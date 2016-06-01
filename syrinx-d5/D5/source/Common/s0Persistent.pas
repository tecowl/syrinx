unit s0Persistent;

interface

uses
  SysUtils, Classes,
  s0Observer;

type
  Ts0PersistentClass = class of Ts0Persistent;
  Ts0Persistent = class(TPersistent)
  private
    FOwnerObj: TPersistent;
    FOnChange: Ts0Event;
    FNotifyChangeToOwner: Boolean;
    function GetOwnerComponent: TComponent;
    function GetOnChange: Ts0Event;
  protected
    procedure Change; virtual;
    procedure DoChange; virtual;
    procedure NotificationSubObjChange(AObj: TObject); virtual;
  public
    constructor Create(AOwner: TPersistent); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Clone(AOwner: TPersistent = nil): Ts0Persistent; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); virtual;
    property NotifyChangeToOwner: Boolean read FNotifyChangeToOwner write FNotifyChangeToOwner default False;
    property OwnerObj: TPersistent read FOwnerObj;
    property OwnerComponent: TComponent read GetOwnerComponent;
    property OnChange: Ts0Event read GetOnChange;
  end;

type
  Ts0InterfacedPersistent = class(Ts0Persistent, IUnknown)
  private
    FRefCounting: Boolean;
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(AOwner: TPersistent); override;
    constructor CreateAsIntf(AOwner: TPersistent); virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;
    property RefCounting: Boolean read FRefCounting;
  end;

implementation

uses
  s0Classes,
  s0Collection;

{ Ts0Persistent }

procedure Ts0Persistent.Assign(Source: TPersistent);
begin
end;

procedure Ts0Persistent.Change;
begin
  DoChange;
  if not FNotifyChangeToOwner then Exit;
  if FOwnerObj is Ts0Persistent then
    Ts0Persistent(FOwnerObj).NotificationSubObjChange(Self);
end;

function Ts0Persistent.Clone(AOwner: TPersistent): Ts0Persistent;
begin
  Result := Ts0PersistentClass(Self.ClassType).Create(AOwner);
  Result.Assign(Self);
end;

constructor Ts0Persistent.Create(AOwner: TPersistent);
begin
  inherited Create;
  FNotifyChangeToOwner := False;
  FOwnerObj := AOwner;
end;

destructor Ts0Persistent.Destroy;
begin
  FreeAndNil(FOnChange);
  inherited;
end;

procedure Ts0Persistent.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange.NotifyAll;
end;

function Ts0Persistent.GetOnChange: Ts0Event;
begin
  if FOnChange = nil then
    FOnChange := Ts0Event.Create(Self);
  Result := FOnChange;
end;

function Ts0Persistent.GetOwnerComponent: TComponent;
begin
  Result := nil;
  if FOwnerObj is TComponent then
    Result := TComponent(FOwnerObj)
  else
  if FOwnerObj is Ts0Persistent then
    Result := Ts0Persistent(FOwnerObj).OwnerComponent
  else
  if FOwnerObj is Ts0CollectionItem then
    Result := Ts0CollectionItem(FOwnerObj).OwnerComponent
  else
  if FOwnerObj is Ts0Collection then
    Result := Ts0Collection(FOwnerObj).OwnerComponent;
end;

procedure Ts0Persistent.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
end;

procedure Ts0Persistent.NotificationSubObjChange(AObj: TObject);
begin                             
end;

{ Ts0InterfacedPersistent }

function Ts0InterfacedPersistent._AddRef: Integer;
begin
  if FRefCounting then
    Result := InterlockedIncrement(FRefCount)
  else
    Result := -1;
end;

function Ts0InterfacedPersistent._Release: Integer;
begin
  if FRefCounting then
  begin
    Result := InterlockedDecrement(FRefCount);
    if Result = 0 then
      Destroy;
  end
  else
    Result := -1;
end;

procedure Ts0InterfacedPersistent.AfterConstruction;
begin
  if not FRefCounting then Exit;
// Release the constructor's implicit refcount
  InterlockedDecrement(FRefCount);
end;

resourcestring
  c9ErrMsg_InvalidPointer = 'Invalid Pointer';

procedure Ts0InterfacedPersistent.BeforeDestruction;
begin
  if not FRefCounting then Exit;
  if RefCount <> 0 then
    raise Es0InvalidPointer.Create(c9ErrMsg_InvalidPointer);
end;

constructor Ts0InterfacedPersistent.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FRefCounting := False;
end;

constructor Ts0InterfacedPersistent.CreateAsIntf(AOwner: TPersistent);
begin
  Create(AOwner);
  FRefCounting := True;
end;

class function Ts0InterfacedPersistent.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  Ts0InterfacedPersistent(Result).FRefCount := 1;
end;

function Ts0InterfacedPersistent.QueryInterface(const IID: TGUID;
  out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

end.
