unit s0ValidationMsg;

interface

uses
  SysUtils, Classes, Contnrs,
  s0Persistent;

type
  K0ValidationResult = (k0vrFatalError, k0vrWarning, k0vrHint, k0vrInfomation);
  K0ValidationResults = set of K0ValidationResult;

resourcestring
  c0ValidResult_FatalError = '’v–½“I‚ÈƒGƒ‰[';
  c0ValidResult_Warning    = 'Œx';
  c0ValidResult_Hint       = 'ƒqƒ“ƒg';
  c0ValidResult_Infomation = 'î•ñ';

const
  c0ValidationKindStr: array[K0ValidationResult] of string = (
    c0ValidResult_FatalError,
    c0ValidResult_Warning   ,
    c0ValidResult_Hint      ,
    c0ValidResult_Infomation
  );

type
  Ts0ValidationMsg = class(Ts0Persistent)
  private
    FKind: K0ValidationResult;
    FMessage: string;
  public
    constructor Create(AOwner: TPersistent; AMsg: string;
      AKind: K0ValidationResult = k0vrInfomation); reintroduce; virtual;
    property Message: string read FMessage;
    property Kind: K0ValidationResult read FKind;
  end;             

type
  K0ValidationMsgEvent = procedure(Sender: TObject; AMsg: Ts0ValidationMsg) of object;

type
  Ts0ValidationMessager = class(TComponent)
  private
    FMsgList: TObjectList;
    FOnAddMsg: K0ValidationMsgEvent;
    FOnRemoveMsg: K0ValidationMsgEvent;
    FOnClear: TNotifyEvent;
    FOnChange: TNotifyEvent;
    function GetItemCount: Integer;
    function GetItems(const Index: Integer): Ts0ValidationMsg;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddMsg(AMsg: Ts0ValidationMsg): Integer; virtual;
    procedure Change; virtual;
    procedure ClearMsg; virtual;
    procedure CopyMessages(Dest: TStrings);
    procedure DeleteMsg(AIndex: Integer); virtual;
    function NewMsg(AMsg: string; AKind: K0ValidationResult = k0vrInfomation): Ts0ValidationMsg;
    function RemoveMsg(AMsg: Ts0ValidationMsg): Integer;
    property MsgList: TObjectList read FMsgList;
    property Items[const Index: Integer]: Ts0ValidationMsg read GetItems;
    property ItemCount: Integer read GetItemCount;
  published
    property OnAddMsg: K0ValidationMsgEvent read FOnAddMsg write FOnAddMsg;
    property OnClear : TNotifyEvent read FOnClear  write FOnClear ;
    property OnRemoveMsg: K0ValidationMsgEvent read FOnRemoveMsg write FOnRemoveMsg;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

type
  Ts0ValidationNotifier = class(TComponent)
  published
  end;

type
  Ts0GlobalValidationManager = class(Ts0ValidationMessager)
  public
    class function Instance: Ts0GlobalValidationManager;
  end;


implementation

{ Ts0ValidationMsg }

constructor Ts0ValidationMsg.Create(AOwner: TPersistent; AMsg: string;
  AKind: K0ValidationResult);
begin
  inherited Create(AOwner);
  FMessage := AMsg;
  FKind := AKind;
end;

{ Ts0ValidationMessager }

function Ts0ValidationMessager.AddMsg(AMsg: Ts0ValidationMsg): Integer;
begin
  Result := -1;
  if FMsgList.IndexOf(AMsg) > -1 then Exit;
  Result := FMsgList.Add(AMsg);
  if Assigned(FOnAddMsg) then
    FOnAddMsg(Self, AMsg);
  Change;
end;

procedure Ts0ValidationMessager.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure Ts0ValidationMessager.ClearMsg;
begin
  if csDestroying in Self.ComponentState then Exit;
  if Assigned(FOnClear) then
    FOnClear(Self);
  FMsgList.Clear;
  Change;
end;

procedure Ts0ValidationMessager.CopyMessages(Dest: TStrings);
var
  i: Integer;
begin
  Dest.Clear;
  for i := 0 to FMsgList.Count -1 do
    Dest.Add('[' + c0ValidationKindStr[Items[i].Kind] +'] '+ Items[i].Message);
end;

constructor Ts0ValidationMessager.Create(AOwner: TComponent);
begin
  inherited;
  FMsgList := TObjectList.Create(True);
end;

procedure Ts0ValidationMessager.DeleteMsg(AIndex: Integer);
begin
  RemoveMsg( Ts0ValidationMsg(FMsgList.Items[AIndex]) );
end;

destructor Ts0ValidationMessager.Destroy;
begin
  ClearMsg;
  FreeAndNil(FMsgList);
  inherited;
end;

function Ts0ValidationMessager.GetItemCount: Integer;
begin
  Result := FMsgList.Count;
end;

function Ts0ValidationMessager.GetItems(
  const Index: Integer): Ts0ValidationMsg;
begin
  Result := Ts0ValidationMsg(FMsgList.Items[Index]);
end;

function Ts0ValidationMessager.NewMsg(AMsg: string;
  AKind: K0ValidationResult): Ts0ValidationMsg;
begin
  Result := Ts0ValidationMsg.Create(Self, AMsg, AKind);
  AddMsg(Result);
end;

function Ts0ValidationMessager.RemoveMsg(AMsg: Ts0ValidationMsg): Integer;
begin
  if Assigned(FOnRemoveMsg) then
    FOnRemoveMsg(Self, AMsg);
  Result := FMsgList.Remove(AMsg);
  Change;
end;

{ Ts0GlobalValidationManager }

var
  g9ValidMan: Ts0GlobalValidationManager = nil;

class function Ts0GlobalValidationManager.Instance: Ts0GlobalValidationManager;
begin
  if g9ValidMan = nil then
    g9ValidMan := Ts0GlobalValidationManager.Create(nil);
  Result := g9ValidMan;
end;

initialization

finalization
  FreeAndNil(g9ValidMan);

end.




