unit s0Logger;
{
$History: s0Logger.pas $
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/06   Time: 21:56
 * Updated in $/source/D5Integrated
 * uses節にs0FileNameHelperユニットを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/08   Time: 14:35
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/13   Time: 23:30
 * Updated in $/source/D5Integrated
 * 余計なものを削除した
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 14:05
 * Updated in $/source/p0common
 * アクセプタなどの実装を行った。まだ未完。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/02   Time: 1:05
 * Updated in $/source/p0common
 * Bridgeパターンを適用している最中
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/01   Time: 13:21
 * Updated in $/source/p0common
 * リファクタリングしようと思ってAcceptorを定義したところ
 *
 * *****************  Version 15  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:32
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}
{
  変更履歴

  2001/06/15
    Save、Traceメソッドの引数ALevelが使用されていなかったので、
    各メソッドにて、AcceptLogメソッドにてレベルがLoggingLevelを
    下回っていれば、ログとして扱うように変更。
}

interface

uses
  SysUtils, Classes,
  s0Observer,
  s0FileBuffer,
  s0Exception;

const
  c0DefaultLogFileExt = '.log';

type
  K0FileSaveType = (
    k0fatBySave,   //ログ出力の要求の度に書き出す。
    k0fatKeep,     //ファイル出力しない。
    k0fatOnDemand, //要求があった場合に出力する。ClearBufferが出力のトリガ。
    k0fatOnTimer   //指定時間毎に書き出す。
  );

  K0LogLevel = (
    k0llNormalRunning, //通常の実行時にも出力する。(致命的なエラーに使用することを想定)
    k0llAppDebug,      //アプリケーションデバッグ時に出力する。
    k0llFWCustomDebug, //フレームワークのカスタマイズのデバッグ。
    k0llFrameworkDebug //フレームワークのデバッグ時以外には出力しない。
  );

const
  c0LogLevelPriority: array[K0LogLevel] of Integer = (
    0, //k0llNormalRunning   ログ出力レベルがもっとも低い。
    1, //k0llAppDebug
    2, //k0llFWCustomDebug
    3  //k0llFrameworkDebug  ログ出力レベルがもっとも高い。
  );


type
  Ts0LoggerBaseClass = class of Ts0LoggerBase;
  Ts0LoggerBase = class
  private
    FFileName: string;
    FTimerInterval: Integer;
    FSaveType: K0FileSaveType;
    FDblQuoted: Boolean;
    FBuffer: TStrings;
    FTarget: TStream;
    FLoggingLevel: K0LogLevel;
    procedure SetFileName(const Value: string);
    procedure SetSaveType(const Value: K0FileSaveType);
    procedure SetTimerInterval(const Value: Integer);
    function GetFileName: string;
  protected
    procedure ClearTarget;
    function GetTarget: TStream;
    procedure TimerSwitchOn(Sender: TObject);
    procedure StartLogging;
    procedure TerminateLogging;
  public
    //SINGLETON
    class procedure RegisterClass(AClass: Ts0LoggerBaseClass);
  protected
    function AcceptLog(ALebel: K0LogLevel): Boolean;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    class function Instance: Ts0LoggerBase;
    procedure ClearBuffer;
    procedure SaveMsg(AMsg: string; ALevel: K0LogLevel = k0llFrameworkDebug); virtual;
    procedure SaveObjMsg(AObj: TObject; AMethod: string; AMsg: string = ''; ALevel: K0LogLevel = k0llFrameworkDebug);  
    procedure Snap(AObj: TObject; AMsg: string = ''; ALevel: K0LogLevel = k0llFrameworkDebug);
    class function GetLoggingLevel(Value: Integer): K0LogLevel;
  published
    property FileName: string read GetFileName write SetFileName;
    property SaveType: K0FileSaveType read FSaveType write SetSaveType default k0fatBySave;
    property TimerInterval: Integer read FTimerInterval write SetTimerInterval default 300; //unit: second
    {
      出力されるレベルを設定できる。
      Traceなどで指定されたレベルがこのLoggingLevelよりも低ければログに記録する。
    }
    property LoggingLevel: K0LogLevel read FLoggingLevel write FLoggingLevel default k0llNormalRunning;
  end;


type
  K0LoggerType = (k0ltFile, k0ltStrings);
  K0AcceptorType = (k0atSnapShot, k0atMsg, k0atPerfomance);

type
  Ts0LogAcceptor = class;

  Ts0LoggerClass = class of Ts0Logger;
  Ts0Logger = class
  private
    FOnSave: Ts0Event;
    FAcceptors: array[K0AcceptorType] of Ts0LogAcceptor;
    function GetOnSave: Ts0Event;
  protected
    function NewAcceptor(AType: K0AcceptorType): Ts0LogAcceptor; virtual;
    procedure Save(AData: TStream); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function GetAcceptor(AType: K0AcceptorType): Ts0LogAcceptor;
    property OnSave: Ts0Event read GetOnSave;
  end;

  Ts0LogAcceptorClass = class of Ts0LogAcceptor;
  Ts0LogAcceptor = class
  private
    FLogger: Ts0Logger;
    FDblQuoted: Boolean;
  protected
    function GetCategoryName: string; virtual;
    function GetPerfomance: string; virtual;
    function GetSnapShot(ATarget: TObject): string; virtual;
  public
    constructor Create(ALogger: Ts0Logger); virtual;
    procedure LogOut(AObj: TObject; AMethod: string; AMsg: string = ''; ATarget: TObject = nil); virtual;
    property DblQuoted: Boolean read FDblQuoted write FDblQuoted;
    property Logger: Ts0Logger read FLogger;
  end;


type
  Ts0FileLogger = class(Ts0Logger)
  private
    FBuffer: Ts0FileBuffer;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
  protected
    function NewBuffer: Ts0FileBuffer; virtual;
    procedure Save(AData: TStream); override;
    function GetDefaultFileName: string;
    class function GetDefaultExt: string;
  protected
    property Buffer: Ts0FileBuffer read FBuffer;
  public
    constructor Create; override;
    destructor Destroy; override;
    property FileName: string read GetFileName write SetFileName;
  end;

type
  Ts0StringsLogger = class(Ts0Logger)
  private
    FLog: TStrings;
    procedure SetLog(const Value: TStrings);
  protected
    procedure Save(AData: TStream); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Log: TStrings read FLog write SetLog;
  end;



type
  Ts0SnapShotAcceptor = class(Ts0LogAcceptor)
  protected
    function GetCategoryName: string; override;
    function GetSnapShot(ATarget: TObject): string; override;
  public
  end;

type
  Ts0MsgAcceptor = class(Ts0LogAcceptor)
  protected
    function GetCategoryName: string; override;
  public
  end;

type
  Ts0PerfomanceTracer = class(Ts0LogAcceptor)
  private
    FLastStart: TDateTime;
  protected
    function GetCategoryName: string; override;
    function GetPerfomance: string; override;
  protected
    procedure BeginCount;
    function EndCount: Double;
  public
    constructor Create(ALogger: Ts0Logger); override;
    procedure LogOut(AObj: TObject; AMethod: string; AMsg: string = ''; ATarget: TObject = nil); override;
  end;


procedure SetLogPath(APath: string);
procedure SetLogFileName(AFileName: string);
function GetLoggingLevel(Value: Integer): K0LogLevel;
procedure SetLoggingLevel(ALevel: Integer);
procedure SetSaveMode(AType: K0FileSaveType);
procedure Snap(AObj: TObject; AMsg: string = ''; ALevel: K0LogLevel = k0llFrameworkDebug);
procedure Trace(AMsg: string; AIndentDiff: Integer = 0; ALevel: K0LogLevel = k0llFrameworkDebug); overload;
procedure Trace(AObj: TObject; AMethod: string; AMsg: string = ''; AIndentDiff: Integer = 0; ALevel: K0LogLevel = k0llFrameworkDebug); overload;


implementation

uses
  s0Application,
  s0Matrix,
  s0ObjectHelper,
  s0DateHelper,
  s0StreamHelper,
  s0FileNameHelper;

procedure SetLogPath(APath: string);
var
  f: string;
begin
  if Ts0LoggerBase.Instance = nil then Exit;
  {
    FileCtrlユニットをusesしたくないのでコメントアウト。
    設定する人は必ず正しいパスを設定してね。
    FileCtrlはVclExだかなんだかっていうパッケージを参照するので、
    ファイルが大きくなりそうな気がする。
  }
  //if not DirectoryExists(APath) then Exit;
  f := IncludeTrailingPathDelimiter(APath) +
       ExtractFileName( Ts0LoggerBase.Instance.FileName);
  Ts0LoggerBase.Instance.FileName := f;
end;

procedure SetLogFileName(AFileName: string);
begin
  if Ts0LoggerBase.Instance = nil then Exit;
  Ts0LoggerBase.Instance.FileName := AFileName;
end;

function GetLoggingLevel(Value: Integer): K0LogLevel;
begin
  Result := k0llNormalRunning;
  if Ts0LoggerBase.Instance = nil then Exit;
  Result := Ts0LoggerBase.GetLoggingLevel(Value);
end;

procedure SetLoggingLevel(ALevel: Integer);
begin
  if Ts0LoggerBase.Instance = nil then Exit;
  Ts0LoggerBase.Instance.LoggingLevel := GetLoggingLevel( ALevel );
end;

procedure SetSaveMode(AType: K0FileSaveType);
begin
  if Ts0LoggerBase.Instance = nil then Exit;
  Ts0LoggerBase.Instance.SetSaveType(AType);
end;

procedure Snap(AObj: TObject; AMsg: string = '';
  ALevel: K0LogLevel = k0llFrameworkDebug);
begin
  if Ts0LoggerBase.Instance = nil then Exit;
  Ts0LoggerBase.Instance.Snap(AObj, AMsg, ALevel);
end;

procedure Trace(AMsg: string; AIndentDiff: Integer = 0;
  ALevel: K0LogLevel = k0llFrameworkDebug);
begin
  if Ts0LoggerBase.Instance = nil then Exit;
  Ts0LoggerBase.Instance.SaveMsg(AMsg, ALevel);
end;

procedure Trace(AObj: TObject; AMethod: string; AMsg: string = '';
  AIndentDiff: Integer = 0; ALevel: K0LogLevel = k0llFrameworkDebug);
begin
  if Ts0LoggerBase.Instance = nil then Exit;
  Ts0LoggerBase.Instance.SaveObjMsg(AObj, AMethod, AMsg, ALevel);
end;




{ Ts0LoggerBase }

constructor Ts0LoggerBase.Create;
begin
  inherited Create;
  FDblQuoted := True;
  FSaveType := k0fatBySave;
  FTimerInterval := 300;
//  FFileName := GetDefaultFileName;
  FBuffer := TStringList.Create;
//  MonitorPerfomance := True;
  FLoggingLevel := k0llNormalRunning;
{$IFDEF APPDEBUG}
  FLoggingLevel := k0llAppDebug;
{$ENDIF}
{$IFDEF FRAMEWORKDEBUG}
  FLoggingLevel := k0llFrameworkDebug;
{$ENDIF}
end;

destructor Ts0LoggerBase.Destroy;
begin
  FreeAndNil(FTarget);
  FreeAndNil(FBuffer);
  inherited;
end;

procedure Ts0LoggerBase.SaveMsg(AMsg: string; ALevel: K0LogLevel);
begin
  if not AcceptLog(ALevel) then Exit;

  FBuffer.Add( AMsg );
  if FSaveType in [k0fatBySave, k0fatKeep] then
    ClearBuffer;
end;

procedure Ts0LoggerBase.SaveObjMsg(AObj: TObject; AMethod, AMsg: string; ALevel: K0LogLevel);
var
  objName, clsName: string;
  msg: string;
  dt: string;
  passed: string;
begin
  if not AcceptLog(ALevel) then Exit;

//  passed := Format('%0.000f', [ EndCount ]);

  objName := Ts0ObjectHelper.GetObjectCaption(AObj);
  clsName := '';
  dt := DateToStr(Date) +' ' + Ts0DateTimeHelper.TimeToStrWithMiliSec(Time);
  if AObj <> nil then
    clsName := AObj.ClassName;
  if FDblQuoted then
  begin
    passed  := AnsiQuotedStr(passed , '"');
    objName := AnsiQuotedStr(objName, '"');
    clsName := AnsiQuotedStr(clsName, '"');
    AMethod := AnsiQuotedStr(AMethod, '"');
    AMsg    := AnsiQuotedStr(AMsg   , '"');
    dt      := AnsiQuotedStr(dt     , '"');
  end;
  msg := Format('%s,%s,%s,%s,%s,%s', [objName, clsName, AMethod, AMsg, dt, passed]);
  SaveMsg(msg);
//  BeginCount;
end;

procedure Ts0LoggerBase.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure Ts0LoggerBase.SetSaveType(const Value: K0FileSaveType);
begin
  if FSaveType = Value then Exit;
  FSaveType := Value;
end;

procedure Ts0LoggerBase.SetTimerInterval(const Value: Integer);
begin
  if FTimerInterval = Value then Exit;
  FTimerInterval := Value;
end;

procedure Ts0LoggerBase.TimerSwitchOn(Sender: TObject);
begin
  ClearBuffer;
end;

procedure Ts0LoggerBase.ClearBuffer;
var
  f: TStream;
begin
  f := GetTarget;
  FBuffer.SaveToStream(f);
  FBuffer.Clear;
  if SaveType <> k0fatKeep then
    ClearTarget;
end;

function Ts0LoggerBase.GetTarget: TStream;
var
  lMode: Word;
begin
  if FTarget = nil then
  begin
    if FileExists(FileName) then lMode := fmOpenReadWrite
                            else lMode := fmCreate;
    FTarget := TFileStream.Create(FileName, lMode or fmShareDenyWrite);
  end;
  FTarget.Seek(0, soFromEnd);
  Result := FTarget;
end;

procedure Ts0LoggerBase.ClearTarget;
begin
  FreeAndNil(FTarget);
end;


procedure Ts0LoggerBase.Snap(AObj: TObject; AMsg: string; ALevel: K0LogLevel);
var
  ss: TStringStream;
begin
  if not AcceptLog(ALevel) then Exit;

  ss := TStringStream.Create('');
  try
    if AObj is TComponent then
    begin
      Ts0ObjectHelper.GetComponentData(TComponent(AObj), ss);
    end
    else
    if AObj is TStrings then
    begin
      TStrings(AObj).SaveToStream(ss);
    end
    else
    if AObj is Ts0Matrix then
    begin
      Ts0Matrix(AObj).Text;
      Ts0Matrix(AObj).CommaText;
      Ts0Matrix(AObj).SaveToStream(ss);
    end
    else
      Exit;

    SaveObjMsg(AObj, '<SnapShot>', AMsg + #13#10+ ss.DataString);
  finally
    FreeAndNil(ss);
  end;
end;

procedure Ts0LoggerBase.StartLogging;
begin
  SaveObjMsg(Self, '----------Start logging----------');
end;

procedure Ts0LoggerBase.TerminateLogging;
begin
  SaveObjMsg(Self, '----------Terminate logging----------');
end;

class function Ts0LoggerBase.GetLoggingLevel(Value: Integer): K0LogLevel;
var
  i: K0LogLevel;
begin
  Result := k0llFrameworkDebug;
  for i := Low(K0LogLevel) to High(K0LogLevel) do
    if c0LogLevelPriority[i] = Value then
    begin
      Result := i;
      Exit;
    end;      
end;

function Ts0LoggerBase.AcceptLog(ALebel: K0LogLevel): Boolean;
begin
  Result := (c0LogLevelPriority[ALebel] <= c0LogLevelPriority[FLoggingLevel]);
end;



var
  g9LogManClass: Ts0LoggerBaseClass = Ts0LoggerBase;
  g9LogMan: Ts0LoggerBase = nil;
  g9Terminating: Boolean = False;

class function Ts0LoggerBase.Instance: Ts0LoggerBase;
begin
  if g9LogMan = nil then
  begin
    if not g9Terminating then
    begin
      g9LogMan := g9LogManClass.Create;
      //四天王の一。広目天。筆と巻物を持っているらしいので、ログ向きかなと。
      //g9LogMan.Name := 'Virupaska';
      //g9LogMan.DblQuoted := True;
      g9LogMan.SaveType := k0fatBySave;
      g9LogMan.StartLogging;
    end;
  end;
  Result := g9LogMan;
end;

class procedure Ts0LoggerBase.RegisterClass(AClass: Ts0LoggerBaseClass);
begin
  g9LogManClass := AClass;
end;

function Ts0LoggerBase.GetFileName: string;
begin
  if FFileName = '' then
    FFileName := ChangeFileExt( Ts0Application.Instance.ExeName, c0DefaultLogFileExt);
  Result := FFileName;
end;

{ Ts0Logger }

constructor Ts0Logger.Create;
begin
  inherited Create;
end;

destructor Ts0Logger.Destroy;
var
  i: K0AcceptorType;
begin
  FreeAndNil(FOnSave);
  for i := Low(K0AcceptorType) to High(K0AcceptorType) do
    FreeAndNil( FAcceptors[i] );
  inherited;
end;

function Ts0Logger.GetAcceptor(
  AType: K0AcceptorType): Ts0LogAcceptor;
begin
  if FAcceptors[AType] = nil then
    FAcceptors[AType] := NewAcceptor(AType);
  Result := FAcceptors[AType];
end;

function Ts0Logger.GetOnSave: Ts0Event;
begin
  if FOnSave = nil then
    FOnSave := Ts0Event.Create(Self);
  Result := FOnSave;
end;

function Ts0Logger.NewAcceptor(
  AType: K0AcceptorType): Ts0LogAcceptor;
const
  c9AcceptorClasses: array[K0AcceptorType] of Ts0LogAcceptorClass =
    ( Ts0SnapShotAcceptor, Ts0MsgAcceptor, Ts0PerfomanceTracer );
begin
  Result := c9AcceptorClasses[AType].Create(Self);
end;

procedure Ts0Logger.Save(AData: TStream);
begin
  if Assigned(FOnSave) then
    FOnSave.NotifyAll;
end;

{ Ts0LogAcceptor }

constructor Ts0LogAcceptor.Create(ALogger: Ts0Logger);
begin
  inherited Create;
  FLogger := ALogger;
end;

function Ts0LogAcceptor.GetCategoryName: string;
begin
  Result := '';
end;

function Ts0LogAcceptor.GetPerfomance: string;
begin
  Result := '';
end;

function Ts0LogAcceptor.GetSnapShot(ATarget: TObject): string;
begin
  Result := '';
end;

procedure Ts0LogAcceptor.LogOut(AObj: TObject; AMethod, AMsg: string;
  ATarget: TObject);
  function GetLogString: string;
  const
    c9NoramlFormat = '<%s>, %s, %s, %s';
    c9QuotedFormat = '"<%s>", "%s", "%s", "%s"';
  var
    fmt: string;
    objCaption: string;
  begin
    Result := '';
    objCaption := Ts0ObjectHelper.GetObjectCaptionWithClass(AObj);
    if FDblQuoted then fmt := c9QuotedFormat else fmt := c9NoramlFormat;
    Result := Format(fmt, [GetCategoryName, objCaption, AMsg, GetPerfomance, GetSnapShot(ATarget) ]);
  end;
var
  ss: TStringStream;
begin
  ss := TStringStream.Create( GetLogString );
  try
    FLogger.Save(ss);
  finally
    FreeAndNil(ss);
  end;
end;

{ Ts0FileLogger }

constructor Ts0FileLogger.Create;
begin
  inherited;
  FBuffer := NewBuffer;
end;

destructor Ts0FileLogger.Destroy;
begin
  FreeAndNil(FBuffer);
  inherited;
end;

class function Ts0FileLogger.GetDefaultExt: string;
begin
  Result := c0DefaultLogFileExt;
end;

function Ts0FileLogger.GetDefaultFileName: string;
var
  lExeName: string;
begin
  lExeName := Ts0Application.Instance.ExeName;
  Result := ExtractFilePath(lExeName) +
            '_' + ChangeFileExt( ExtractFileName(lExeName), GetDefaultExt);
end;

function Ts0FileLogger.GetFileName: string;
begin
  Result := FBuffer.FileName;
end;

function Ts0FileLogger.NewBuffer: Ts0FileBuffer;
begin
  Result := Ts0FileBuffer.Create;
end;

procedure Ts0FileLogger.Save(AData: TStream);
begin
  FBuffer.CopyFrom(AData, 0);
  inherited Save(AData);
end;

procedure Ts0FileLogger.SetFileName(const Value: string);
begin
  FBuffer.FileName := Value;
end;

{ Ts0StringsLogger }

constructor Ts0StringsLogger.Create;
begin
  inherited Create;
  FLog := TStringList.Create;
end;

destructor Ts0StringsLogger.Destroy;
begin
  FreeAndNil(FLog);
  inherited;
end;

procedure Ts0StringsLogger.Save(AData: TStream);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromStream(AData);
    FLog.AddStrings(sl);
  finally
    FreeAndNil(sl);
  end;
  inherited Save(AData);
end;

procedure Ts0StringsLogger.SetLog(const Value: TStrings);
begin
  FLog.Assign(Value);
end;

{ Ts0SnapShotAcceptor }

function Ts0SnapShotAcceptor.GetCategoryName: string;
begin
  Result := 'SnapShot';
end;

function Ts0SnapShotAcceptor.GetSnapShot(ATarget: TObject): string;
var
  ss: TStringStream;
begin
  Result := '';
  ss := TStringStream.Create('');
  try
    if ATarget is TComponent then
    begin
      Ts0ObjectHelper.GetComponentData(TComponent(ATarget), ss);
      ss.Seek(0, soFromBeginning);
      Result := ss.DataString;
    end
    else
    if ATarget is TStrings then
    begin
      TStrings(ATarget).SaveToStream(ss);
      ss.Seek(0, soFromBeginning);
      Result := ss.DataString;
    end;
  finally
    FreeAndNil(ss);
  end;
end;

{ Ts0MsgAcceptor }

function Ts0MsgAcceptor.GetCategoryName: string;
begin
  Result := 'Message';
end;

{ Ts0PerfomanceTracer }

procedure Ts0PerfomanceTracer.BeginCount;
begin
  FLastStart := Now;
end;

constructor Ts0PerfomanceTracer.Create(ALogger: Ts0Logger);
begin
  inherited;
end;

function Ts0PerfomanceTracer.EndCount: Double;
var
  lStop: TDateTime;
begin
  lStop := Now;
  Result := (lStop - FLastStart) * 1000 * 60 * 60 * 24;
end;

function Ts0PerfomanceTracer.GetCategoryName: string;
begin
  Result := 'Perfomance';
end;

function Ts0PerfomanceTracer.GetPerfomance: string;
begin
  Result := Format('%0.000f', [ EndCount ]);
end;

procedure Ts0PerfomanceTracer.LogOut(AObj: TObject; AMethod, AMsg: string;
  ATarget: TObject);
begin
  inherited LogOut(AObj, AMethod, AMsg, ATarget);
  BeginCount;
end;

initialization

finalization
  g9Terminating := True;
  if g9LogMan <> nil then
  begin
    g9LogMan.ClearBuffer;
    g9LogMan.TerminateLogging;
  end;
  FreeAndNil(g9LogMan);

end.
