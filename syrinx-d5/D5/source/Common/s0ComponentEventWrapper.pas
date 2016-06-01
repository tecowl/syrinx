unit s0ComponentEventWrapper;

interface

uses
  SysUtils, Classes,
  s0Observer;

type
	K0FormEventType = (k0femCreate, k0femShow, k0femCloseQuery, k0femClose, k0femDestroy);
  K0FormEventTypeSet = set of K0FormEventType;

type
  Ts0ComponentEventWrapper = class(TComponent)
  private
    FOnCreate: Ts0Event;
    FOnDestroy: Ts0Event;
    FBufOnCreate: TNotifyEvent;
    FBufOnDestroy: TNotifyEvent;
  protected
    procedure Loaded; override;
    procedure OwnerCreate(Sender: TObject); virtual;
    procedure OwnerDestroy(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearEventBuffer; virtual;
    procedure SnatchEvents; virtual;
    procedure PutBackEvents; virtual;
    procedure AddListener(AListener: Ts0EventListener; AEventTypes: K0FormEventTypeSet); virtual;
    class function FindEventWrapper(AOwner: TComponent): Ts0ComponentEventWrapper;
  public
    property OnCreate : Ts0Event read FOnCreate;
    property OnDestroy: Ts0Event read FOnDestroy;
  end;

implementation

uses
  s0TypInfoWrapper;

{ Ts0ComponentEventWrapper }

procedure Ts0ComponentEventWrapper.AddListener(AListener: Ts0EventListener;
  AEventTypes: K0FormEventTypeSet);
begin
	if k0femCreate in AEventTypes then
  	Self.OnCreate.Attach(AListener);	
	if k0femDestroy in AEventTypes then
  	Self.OnDestroy.Attach(AListener);
end;

procedure Ts0ComponentEventWrapper.ClearEventBuffer;
begin
  FBufOnCreate := nil;
  FBufOnDestroy := nil;
end;

constructor Ts0ComponentEventWrapper.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOnCreate := Ts0Event.Create(Self);
  FOnDestroy := Ts0Event.Create(Self);
end;

destructor Ts0ComponentEventWrapper.Destroy;
begin
  FreeAndNil(FOnCreate);
  FreeAndNil(FOnDestroy);
  inherited;
end;

class function Ts0ComponentEventWrapper.FindEventWrapper(
  AOwner: TComponent): Ts0ComponentEventWrapper;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AOwner.ComponentCount -1 do
  begin
    if AOwner.Components[i] is Ts0ComponentEventWrapper then
    begin
      Result := Ts0ComponentEventWrapper(AOwner.Components[i]);
      Exit;
    end;
  end;
end;

procedure Ts0ComponentEventWrapper.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then Exit;
  SnatchEvents;
end;

procedure Ts0ComponentEventWrapper.OwnerCreate(Sender: TObject);
begin
  if csDesigning in Self.ComponentState then Exit;
  if Assigned(FBufOnCreate) then FBufOnCreate(Sender);
  if Assigned(FOnCreate) then FOnCreate.NotifyAll;
end;

procedure Ts0ComponentEventWrapper.OwnerDestroy(Sender: TObject);
begin
  if csDesigning in Self.ComponentState then Exit;
  if Assigned(FOnDestroy) then FOnDestroy.NotifyAll;
  if Assigned(FBufOnDestroy) then FBufOnDestroy(Sender);
end;

function GetEventByRTTI(Accessor: Ts0RTTIPublishedAccessor; AEvent: string): TNotifyEvent;
const
  c9EventType = 'TNotifyEvent';
var
  mthd: TMethod;
begin
  Result := nil;
  if not Accessor.PropertyExists(AEvent) then Exit;
  if Accessor.PropTypeName(AEvent) <> c9EventType then Exit;
  mthd := Accessor.MethodProp[ AEvent ];
  Result := TNotifyEvent(mthd);
end;

procedure SetEventByRTTI(Accessor: Ts0RTTIPublishedAccessor; AEvent: string;
  AMethod: TNotifyEvent);
const
  c9EventType = 'TNotifyEvent';
begin
  if not Accessor.PropertyExists(AEvent) then Exit;
  if Accessor.PropTypeName(AEvent) <> c9EventType then Exit;
  Accessor.MethodProp[ AEvent ] := TMethod(AMethod);
end;

const
  c9OnCreate = 'OnCreate';
  c9OnDestroy = 'OnDestroy';
  
procedure Ts0ComponentEventWrapper.PutBackEvents;
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  if csDesigning in Self.ComponentState then Exit;
  if Owner = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(Owner);
  try
    SetEventByRTTI( acsr, c9OnCreate, FBufOnCreate );
    SetEventByRTTI( acsr, c9OnDestroy, FBufOnDestroy );
  finally
    FreeAndNil(acsr);
  end;
  ClearEventBuffer;
end;

procedure Ts0ComponentEventWrapper.SnatchEvents;
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  if csDesigning in Self.ComponentState then Exit;
  if Owner = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(Owner);
  try
    FBufOnCreate  := GetEventByRTTI(acsr, c9OnCreate);
    FBufOnDestroy := GetEventByRTTI(acsr, c9OnDestroy);
    SetEventByRTTI( acsr, c9OnCreate , OwnerCreate );
    SetEventByRTTI( acsr, c9OnDestroy, OwnerDestroy);
  finally
    FreeAndNil(acsr);
  end;
  ClearEventBuffer;
end;

end.
