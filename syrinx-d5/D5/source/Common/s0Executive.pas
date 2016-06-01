unit s0Executive;
{
$History: s0Executive.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 21  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:39
 * Updated in $/GUI/Source/Doc
 * �R�����g�\���R�}���h�ǉ�
}

interface

uses
  SysUtils, Classes,
//  s0Exception,
  s0Collection;


type
  K0ExecutionState = (k0esReady, k0esSuccess, k0esFault);

type
  Ts0Executive = class;

  K0AltExecEvent = procedure(Sender: Ts0Executive;
  	var AResult: K0ExecutionState) of object;
  K0ExecNotifyEvent = procedure(Sender: Ts0Executive) of object;
  K0ExecExceptionEvent = procedure(Sender: Ts0Executive; E: Exception;
  	var ARaise: Boolean) of object;

  {
    Ts0Executive
    �{�t���[�����[�N�ADocument���ɂ�������s�P�ʂƂȂ�R���|�[�l���g�̊��N���X�B
    ���s�P�ʂƂ́A�⍇���A�X�V�iTS�ւ̃��b�Z�[�W���M�j�A�`�F�b�N�iValidation�j��
    �w���B�����A�����ɂ����鏈������������K�v������ꍇ�ɂ́A���̃N���X����h��������B

    Execute���\�b�h�����S�I�ȃ��\�b�h�ł���B
    ���̃����o�́AExecute�����s���邽�߂̐ݒ�ł�������A���s���ʂł�������A
    ���s�ɂ܂��C�x���g�ł������肷��B

    ���j�[�N�ȓ����Ƃ��āAAltExecution�v���p�e�B�AOnAltExecute�C�x���g��
    �������Ă��邱�Ƃ�����B
    AltExecution�v���p�e�B��True�̏ꍇ�AExecute���\�b�h�����s����Ă��{���A���s
    �����ׂ��h���N���X��Override����Ă���CoreExecute���\�b�h�͎��s���ꂸ�A
    OnAltExecute�C�x���g�����s�����B

    ����́A�⍇����X�V�Ȃǂ̋@�\���A�h���N���X��CoreExecute���\�b�h�ł̎�����
    �g�킸�Ɏ��s�ł���ꍇ�ɁA��������g����悤�ɂ��邽�߂̂��́B
    �Ԃ����Ⴏ���b�AEntity��Restore��SendUpdateRequest���\�b�h��p���āA
    �t�B�[���h�̒l��⍇���A�X�V���s�������ꍇ�ɔ����āAAltExecution�v���p�e�B�A
    OnAltExecute�C�x���g�͗p�ӂ���Ă���ƌ����Ă������B
  }
  Ts0Executive = class(TComponent)
  private
    FAltExecution: Boolean;
    FEnabled: Boolean;
    FOnExecException: K0ExecExceptionEvent;
    FAfterExecute: K0ExecNotifyEvent;
    FBeforeExecute: K0ExecNotifyEvent;
    FOnAltExecute: K0AltExecEvent;
    FDisableExecution: K0ExecutionState;
    FErrorCode: Integer;
    FErrorMsg: string;
    FState: K0ExecutionState;
    procedure SetErrorCode(const Value: Integer);
    procedure SetErrorMsg(const Value: string);
    procedure SetState(const Value: K0ExecutionState);
  protected
    function GetState: K0ExecutionState;
    function CoreExecute: K0ExecutionState; virtual; abstract;
  	procedure DoBeforeExecution; virtual;
  	procedure DoAfterExecution; virtual;
    function DoAltExecution: K0ExecutionState; virtual;
    function DoExecError(E: Exception): Boolean; virtual;
    function CanExecute(var AResult: K0ExecutionState): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    {
      Execute
      ���������s����B���s�������e�́A�h���N���X��CoreExecute���\�b�h�ɂ���ĈقȂ�B
    }
    function Execute: K0ExecutionState; virtual;
    {
      ReadyExecution
      ���s�O�ɌĂяo����郁�\�b�h�ŁA���s���邽�߂̏������s�����\�b�h�B
    }
    procedure ReadyExecution; virtual;
    {
      State
      ��Ԃ�\���v���p�e�B�B��Ԃ̎�ނ͈ȉ��̂Ƃ���B
      k0esReady   ���s����OK
      k0esSuccess ���s����������
      k0esFault   ���s�����s����

      ���̃v���p�e�B�͎��s���ɃR�[�h�ŕύX���Ă��悢�B
    }
    property State: K0ExecutionState read GetState write SetState;
  published
    {
      AltExecution
      OnAltExecute
      Execute���\�b�h���s���ɁAAltExecution�v���p�e�B��True�Ȃ�΁ACoreExecute���s�킸�ɁA
      OnAltExecute�C�x���g�����s����B
    }
    property AltExecution: Boolean read FAltExecution write FAltExecution default False; //��֎��s
    {
      DisableExecution
      Execute���\�b�h���s���ɁA�@�\�̎��s���ł��Ȃ��iEnabled��False�j�ꍇ��
      Execute���\�b�h�̖߂�l�������B�ʏ�A���̃v���p�e�B��ύX����K�v�͂Ȃ��Ǝv����B
    }
    property DisableExecution: K0ExecutionState read FDisableExecution write FDisableExecution default k0esSuccess;
    {
      Enabled
      ���s�ł��邩�ǂ�����\���B
    }
  	property Enabled: Boolean read FEnabled write FEnabled default True;
    {
      ErrorCode
      ErrorMsg
      ���s�Ɏ��s�����ꍇ�ɁA�����̃G���[�������R�[�h�ƃ��b�Z�[�W�B
      Tc1ModelDoc��ErrorCode�AErrorMsg�ɐݒ肳���B
    }
  	property ErrorCode: Integer read FErrorCode write SetErrorCode;
  	property ErrorMsg: string read FErrorMsg write SetErrorMsg;
    {
      AfterExecute
      BeforeExecute
      Execute���\�b�h���Ăяo����ACoreExecute�����s����O��BeforeExecute�C�x���g��
      �������ACoreExecute�̎��s�����AfterExecute�C�x���g����������B

    }
    property AfterExecute : K0ExecNotifyEvent read FAfterExecute  write FAfterExecute ;
    property BeforeExecute: K0ExecNotifyEvent read FBeforeExecute write FBeforeExecute;
    property OnAltExecute : K0AltExecEvent    read FOnAltExecute  write FOnAltExecute ;
    {
      OnExecException
      ���s�ɍۂ��āA��O�����������ꍇ�ɁA��������C�x���g�B
      ����ARaise��True��������Ɨ�O���Đ�������AFalse��������Ɨ�O�͖��������B
    }
    property OnExecException  : K0ExecExceptionEvent  read FOnExecException   write FOnExecException  ;
  end;

//type
//  K0SeekItemMode = (k0simHorizontal, k0simVertical);

type
  Ts0ExecSequenceItem = class(Ts0CollectionItem)
  private
    FExecutive: Ts0Executive;
  protected
    procedure SetExecutive(Const Value: Ts0Executive); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
		function Execute: K0ExecutionState;
    procedure ReadyExecution;
  published
    property Executive: Ts0Executive read FExecutive write SetExecutive;
  end;

type
  Ts0ExecSequenceClass = class of Ts0ExecSequence;
  Ts0ExecSequence = class(Ts0Collection)
  private
    function GetSeqItems(const Index: Integer): Ts0ExecSequenceItem;
    procedure SetSeqItems(const Index: Integer; const Value: Ts0ExecSequenceItem);
  protected
    FErrorCode: Integer;
    FErrorMsg: string;
  public
    function Execute: K0ExecutionState;
    procedure ReadyExecution;
  	property SeqItems[const Index: Integer]: Ts0ExecSequenceItem read GetSeqItems write SetSeqItems; default;
  end;

type
  {
    Ts0SeqExecutive
    Ts0Executive�̎��s�������Ǘ�����R���|�[�l���g�B
    Execute���\�b�h���Ăяo���ꂽ�Ƃ��ɂ́ASequence�v���p�e�B�i��Items�j��
    �w�肳���Ts0Executive��Execute���\�b�h�������Ăяo���Ă����B

    Sequence�Ŏw�肳���Ts0Executive��Execute�̃��\�b�h�̖߂�l��k0esFault
    �ł������ꍇ�ɁA���̌��Ts0Executive�͎��s����Ȃ��B

    ���Ԃ��w�肷��ɂ́ATs0ExecSequence�i�R���N�V�����j�ł���Sequence�v���p�e�B��
    Item��ǉ����āAItem�iTs0ExecSequenceItem�j��Executive�v���p�e�B��
    Ts0Executive��ݒ肷��B

    ���̃R���|�[�l���g���g��Ts0Executive����h�����Ă��邽�߁A
    Item�iTs0ExecSequenceItem�j��Executive�v���p�e�B��Ts0SeqExecutive��
    �ݒ肷�邱�Ƃ��ł���B
  }
  Ts0SeqExecutive = class(Ts0Executive)
  private
    FSequence: Ts0ExecSequence;
    procedure SetSequence(const Value: Ts0ExecSequence);
    //FAbsoluteComparison: Boolean;
    //FSeekMode: K0SeekItemMode;
  protected
    function CreateExecSequence: Ts0ExecSequence; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Execute: K0ExecutionState; override;
    procedure ReadyExecution; override;
  published
  	//property AbsoluteComparison: Boolean read FAbsoluteComparison write FAbsoluteComparison; //���S�Ș_���]��
    //property SeekMode: K0SeekItemMode read FSeekMode write FSeekMode;
  	property Sequence: Ts0ExecSequence read FSequence write SetSequence;
  end;



implementation


{ Ts0Executive }

procedure Ts0Executive.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0Executive) then Exit;
  Self.AltExecution  := Ts0Executive(Source).AltExecution ;
  Self.Enabled       := Ts0Executive(Source).Enabled      ;
  Self.AfterExecute  := Ts0Executive(Source).AfterExecute ;
  Self.BeforeExecute := Ts0Executive(Source).BeforeExecute;
  Self.OnAltExecute  := Ts0Executive(Source).OnAltExecute ;
  Self.OnExecException   := Ts0Executive(Source).OnExecException  ;
end;

function Ts0Executive.CanExecute(var AResult: K0ExecutionState): Boolean;
begin
  Result := Enabled;
  AResult := FDisableExecution;
end;

constructor Ts0Executive.Create(AOwner: TComponent);
begin
  inherited;
  FDisableExecution := k0esSuccess;
  FAltExecution := False;
  FEnabled := True;
end;

destructor Ts0Executive.Destroy;
begin
  inherited;
end;

procedure Ts0Executive.DoAfterExecution;
begin
  if assigned(FAfterExecute) then
    FAfterExecute(Self);
end;

function Ts0Executive.DoAltExecution: K0ExecutionState;
begin
  Result := FState;
  if assigned(FOnAltExecute) then
  	FOnAltExecute(Self, Result);
end;

procedure Ts0Executive.DoBeforeExecution;
begin
  if assigned(FBeforeExecute) then
    FBeforeExecute(Self);
end;

function Ts0Executive.DoExecError(E: Exception): Boolean;
begin
  Result := False;
  if assigned(FOnExecException) then
    FOnExecException(Self, E, Result);
end;

function Ts0Executive.Execute: K0ExecutionState;
begin
  Result := k0esSuccess;
  FState := k0esSuccess;
  try
    if not CanExecute(FState) then Exit;
    try
      DoBeforeExecution;
      if FState = k0esFault then Exit;

      if AltExecution then FState := DoAltExecution
                      else FState := CoreExecute;
      if FState = k0esFault then Exit;

      DoAfterExecution;
      if FState = k0esFault then Exit;
    except
      on E: Exception do
      begin
        FState := k0esFault;
        if DoExecError(E) then
          raise
        else
        begin
          ErrorCode := -1;
          ErrorMsg  := E.Message;
        end;
      end;
    end;
  finally
    Result := FState;
  end;
end;

function Ts0Executive.GetState: K0ExecutionState;
begin
  Result := FState;
end;

procedure Ts0Executive.ReadyExecution;
begin
  FState := k0esReady;
end;

procedure Ts0Executive.SetErrorCode(const Value: Integer);
begin
  FErrorCode := Value;
end;

procedure Ts0Executive.SetErrorMsg(const Value: string);
begin
  FErrorMsg := Value;
end;

procedure Ts0Executive.SetState(const Value: K0ExecutionState);
begin
  FState := Value;
end;

{ Ts0ExecSequenceItem }

function Ts0ExecSequenceItem.Execute: K0ExecutionState;
begin
  Result := k0esReady;
  if FExecutive = nil then Exit;
  Result := FExecutive.Execute;
end;

procedure Ts0ExecSequenceItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FExecutive = AComponent then FExecutive := nil;
end;

procedure Ts0ExecSequenceItem.ReadyExecution;
begin
  if FExecutive = nil then Exit;
  FExecutive.ReadyExecution;
end;

procedure Ts0ExecSequenceItem.SetExecutive(Const Value: Ts0Executive);
begin
  FExecutive := Value;
  if FExecutive = Self.GetOwnerComponent then
    FExecutive := nil;
end;

{ Ts0ExecSequence }

function Ts0ExecSequence.Execute: K0ExecutionState;
var
	i: Integer;
begin
  Result := k0esFault;
  FErrorCode := 0;
	for i := 0 to Self.Count -1 do
    if SeqItems[i].Execute = k0esFault then
    begin
      FErrorCode := SeqItems[i].Executive.ErrorCode;
      FErrorMsg  := SeqItems[i].Executive.ErrorMsg;
      Exit;
    end;
  Result := k0esSuccess;
end;

function Ts0ExecSequence.GetSeqItems(
  const Index: Integer): Ts0ExecSequenceItem;
begin
  Result := Ts0ExecSequenceItem(Items[Index]);
end;

procedure Ts0ExecSequence.ReadyExecution;
var
	i: Integer;
begin
	for i := 0 to Self.Count -1 do
    SeqItems[i].ReadyExecution;
end;

procedure Ts0ExecSequence.SetSeqItems(const Index: Integer;
  const Value: Ts0ExecSequenceItem);
begin
  Items[Index] := Value;
end;

{ Ts0SeqExecutive }

procedure Ts0SeqExecutive.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0SeqExecutive) then Exit;
  Self.Sequence.Assign(Ts0SeqExecutive(Source).Sequence);
end;

constructor Ts0SeqExecutive.Create(AOwner: TComponent);
begin
  FSequence := CreateExecSequence;
  inherited;
end;

destructor Ts0SeqExecutive.Destroy;
begin
	FreeAndNil(FSequence);
  inherited;
end;

function Ts0SeqExecutive.Execute: K0ExecutionState;
begin
  if not CanExecute(Result) then Exit;
  Result := k0esFault;

  if (inherited Execute = k0esFault) then Exit;

  if Sequence.Execute = k0esFault then
  begin
    Self.ErrorCode := Sequence.FErrorCode;
    Self.ErrorMsg  := Sequence.FErrorMsg;
    Exit;
  end;
  Result := k0esSuccess;
end;


function Ts0SeqExecutive.CreateExecSequence: Ts0ExecSequence;
begin
  Result := Ts0ExecSequence.Create(Self, Ts0ExecSequenceItem);
end;

procedure Ts0SeqExecutive.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if FSequence <> nil then
    FSequence.Notification(AComponent, Operation);
end;

procedure Ts0SeqExecutive.ReadyExecution;
begin
  inherited;
  Sequence.ReadyExecution;
end;

procedure Ts0SeqExecutive.SetSequence(const Value: Ts0ExecSequence);
begin
  FSequence.Assign(Value);
end;

end.
