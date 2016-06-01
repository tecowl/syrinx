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
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 21  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:39
 * Updated in $/GUI/Source/Doc
 * コメント表示コマンド追加
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
    本フレームワーク、Document側における実行単位となるコンポーネントの基底クラス。
    実行単位とは、問合せ、更新（TSへのメッセージ送信）、チェック（Validation）を
    指す。将来、これらにあたる処理を実装する必要がある場合には、このクラスから派生させる。

    Executeメソッドが中心的なメソッドである。
    他のメンバは、Executeを実行するための設定であったり、実行結果であったり、
    実行にまつわるイベントであったりする。

    ユニークな特徴として、AltExecutionプロパティ、OnAltExecuteイベントを
    実装していることがある。
    AltExecutionプロパティがTrueの場合、Executeメソッドが実行されても本来、実行
    されるべき派生クラスでOverrideされているCoreExecuteメソッドは実行されず、
    OnAltExecuteイベントが実行される。

    これは、問合せや更新などの機能が、派生クラスのCoreExecuteメソッドでの実装を
    使わずに実行できる場合に、そちらを使えるようにするためのもの。
    ぶっちゃけた話、EntityのRestoreやSendUpdateRequestメソッドを用いて、
    フィールドの値を問合せ、更新を行いたい場合に備えて、AltExecutionプロパティ、
    OnAltExecuteイベントは用意されていると言ってもいい。
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
      処理を実行する。実行される内容は、派生クラスのCoreExecuteメソッドによって異なる。
    }
    function Execute: K0ExecutionState; virtual;
    {
      ReadyExecution
      実行前に呼び出されるメソッドで、実行するための準備を行うメソッド。
    }
    procedure ReadyExecution; virtual;
    {
      State
      状態を表すプロパティ。状態の種類は以下のとおり。
      k0esReady   実行準備OK
      k0esSuccess 実行が成功した
      k0esFault   実行が失敗した

      このプロパティは実行時にコードで変更してもよい。
    }
    property State: K0ExecutionState read GetState write SetState;
  published
    {
      AltExecution
      OnAltExecute
      Executeメソッド実行時に、AltExecutionプロパティがTrueならば、CoreExecuteを行わずに、
      OnAltExecuteイベントを実行する。
    }
    property AltExecution: Boolean read FAltExecution write FAltExecution default False; //代替実行
    {
      DisableExecution
      Executeメソッド実行時に、機能の実行ができない（EnabledがFalse）場合の
      Executeメソッドの戻り値を示す。通常、このプロパティを変更する必要はないと思われる。
    }
    property DisableExecution: K0ExecutionState read FDisableExecution write FDisableExecution default k0esSuccess;
    {
      Enabled
      実行できるかどうかを表す。
    }
  	property Enabled: Boolean read FEnabled write FEnabled default True;
    {
      ErrorCode
      ErrorMsg
      実行に失敗した場合に、処理のエラーを示すコードとメッセージ。
      Tc1ModelDocのErrorCode、ErrorMsgに設定される。
    }
  	property ErrorCode: Integer read FErrorCode write SetErrorCode;
  	property ErrorMsg: string read FErrorMsg write SetErrorMsg;
    {
      AfterExecute
      BeforeExecute
      Executeメソッドが呼び出され、CoreExecuteを実行する前にBeforeExecuteイベントが
      発生し、CoreExecuteの実行直後にAfterExecuteイベントが発生する。

    }
    property AfterExecute : K0ExecNotifyEvent read FAfterExecute  write FAfterExecute ;
    property BeforeExecute: K0ExecNotifyEvent read FBeforeExecute write FBeforeExecute;
    property OnAltExecute : K0AltExecEvent    read FOnAltExecute  write FOnAltExecute ;
    {
      OnExecException
      実行に際して、例外が発生した場合に、発生するイベント。
      引数ARaiseにTrueを代入すると例外が再生成され、Falseを代入すると例外は無視される。
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
    Ts0Executiveの実行順序を管理するコンポーネント。
    Executeメソッドが呼び出されたときには、Sequenceプロパティ（のItems）で
    指定されるTs0ExecutiveのExecuteメソッドを順次呼び出していく。

    Sequenceで指定されるTs0ExecutiveのExecuteのメソッドの戻り値がk0esFault
    であった場合に、その後のTs0Executiveは実行されない。

    順番を指定するには、Ts0ExecSequence（コレクション）であるSequenceプロパティに
    Itemを追加して、Item（Ts0ExecSequenceItem）のExecutiveプロパティに
    Ts0Executiveを設定する。

    このコンポーネント自身もTs0Executiveから派生しているため、
    Item（Ts0ExecSequenceItem）のExecutiveプロパティにTs0SeqExecutiveを
    設定することもできる。
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
  	//property AbsoluteComparison: Boolean read FAbsoluteComparison write FAbsoluteComparison; //完全な論理評価
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
