{-----------------------------------------------------------------------------
 Unit Name: c0DataSetLogger
 Author:    akima
 Purpose:
$History: s0DSLogger.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/12/07   Time: 18:28
 * Updated in $/source/D5Integrated
 * 実行時パッケージに含まれうるユニットからDsgnIntfを削除。
 * それに関係するクラスなどは設計時用のパッケージにまとめた。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0DSLogger;

interface

uses
  SysUtils, Classes, 
  DB, Contnrs;

type
  K0LoggingEventKind = (
    k0lekCancel, k0lekClose, k0lekDelete, k0lekEdit, k0lekInsert,
    k0lekOpen, k0lekPost, k0lekRefresh, k0lekScroll
  );
  K0LoggingEventKindSet = set of K0LoggingEventKind;

type
  Ts0LogObj = class
  private
    FEventKind: K0LoggingEventKind;
    FTargetDS: TDataSet;
    FStartTime: TDateTime;
    FFinishTime: TDateTime;
    FCanceled: Boolean;
  public
    property Canceled: Boolean read FCanceled write FCanceled;
    property EventKind : K0LoggingEventKind read FEventKind  write FEventKind ;
    property FinishTime: TDateTime read FFinishTime write FFinishTime;
    property StartTime : TDateTime read FStartTime  write FStartTime ;
    property TargetDS  : TDataSet  read FTargetDS   write FTargetDS  ;
    function TimeRequiredAsString: string; //Unit MiliSecond
    function FinishTimeAsString: string;
    function StartTimeAsString: string;
  end;

type
  K0LoggerStreamType = (k0lstFile, k0lstMemory, k0lstCustom);

type
  Ts0DSLogger = class;

  Ts0DSEventListener = class
  private
    FCurrentLog: Ts0LogObj;
    FOwner: Ts0DSLogger;
    FKind: K0LoggingEventKind;
    FBufEventAfter: TDataSetNotifyEvent;
    FBufEventBefore: TDataSetNotifyEvent;
    procedure DoAfterEvent(DataSet: TDataSet);
    procedure DoBeforeEvent(DataSet: TDataSet);
    function GetActive: Boolean;
  public
    constructor Create(AOwner: Ts0DSLogger; AKind: K0LoggingEventKind;
      ABufEventBefore, ABufEventAfter: TDataSetNotifyEvent);
    procedure Cancel;
    procedure EventAfter(DataSet: TDataSet);
    procedure EventBefore(DataSet: TDataSet);
    property Active: Boolean read GetActive;
    property EventKind: K0LoggingEventKind read FKind;
  end;

  Ts0DSLoggerStyleClass = class of Ts0DSLoggerStyle;
  Ts0DSLoggerStyle = class(TComponent)
  private
    FOwnerLogger: Ts0DSLogger;
    procedure SetOwnerLogger(const Value: Ts0DSLogger);
  protected
    procedure SetParentComponent(AParent: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
  public
    procedure WriteALog(Dest: TStream; ALog: Ts0LogObj); virtual;
    class function GetStyleName: string; virtual; abstract;
    class function GetEventKindName(AEventKind: K0LoggingEventKind): string;
  published
    property OwnerLogger: Ts0DSLogger read FOwnerLogger write SetOwnerLogger;
  end;

  Ts0DSLogger = class(TComponent)
  private
    FActive: Boolean;
    FFileName: TFileName;
    FListeners: TObjectList;
    FLoggingEvents: K0LoggingEventKindSet;
    FStyle: Ts0DSLoggerStyle;
    FTargetDS: TDataSet;
    FStreamType: K0LoggerStreamType;
    FStream: TStream;
    procedure SetTargetDS(const Value: TDataSet);
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetFileName(const Value: TFileName);
    function GetStyle: Ts0DSLoggerStyle;
    function GetStyleName: string;
    procedure SetStyle(const Value: Ts0DSLoggerStyle);
    procedure SetStyleName(const Value: string);
    function GetListener(AKind: K0LoggingEventKind): Ts0DSEventListener;
    procedure SetStream(const Value: TStream);
    procedure SetStreamType(const Value: K0LoggerStreamType);
    function GetStream: TStream;
  protected
    procedure Loaded; override;
    function NewStyle(AClass: Ts0DSLoggerStyleClass): Ts0DSLoggerStyle;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WriteALog(ALog: Ts0LogObj);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Cancel;
    procedure SnatchEvents;
    procedure PutEventsBack;
    property Style: Ts0DSLoggerStyle read GetStyle write SetStyle;
    property Stream: TStream read GetStream write SetStream;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property TargetDS: TDataSet read FTargetDS write SetTargetDS;
    property LoggingEvents: K0LoggingEventKindSet read FLoggingEvents write FLoggingEvents default [k0lekOpen];
  published
    property FileName: TFileName read FFileName write SetFileName;
    property StreamType: K0LoggerStreamType read FStreamType write SetStreamType default k0lstFile;
    property StyleName: string read GetStyleName write SetStyleName;
  end;

type
  Ts0DSLoggerStyleRegister = class
  private
    FStyles: TClassList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetStyleNamesToList(Dest: TStrings);
    procedure GetStyleNames(Proc: TGetStrProc);
    function StyleByName(AName: string): Ts0DSLoggerStyleClass;
    procedure RegisterLoggerStyle(ALogger: Ts0DSLoggerStyleClass);
    procedure UnRegisterLoggerStyle(ALogger: Ts0DSLoggerStyleClass);
    class function Instance: Ts0DSLoggerStyleRegister;
  end;

type
  K0LoggerDefaultStyleOption = (k0ldsoHeader, k0ldsoFooter, k0ldsoProperties, k0ldsoRecordCount, k0ldsoTime);
  K0LoggerDefaultStyleOptionSet = set of K0LoggerDefaultStyleOption;

type
  Ts0DSLoggerDefaultStyle = class(Ts0DSLoggerStyle)
  private
    FLoggingProperties: TStrings;
    FOptions: K0LoggerDefaultStyleOptionSet;
    FLogFooter: TStrings;
    FLogHeader: TStrings;
    procedure SetLoggingProperties(const Value: TStrings);
    procedure SetLogFooter(const Value: TStrings);
    procedure SetLogHeader(const Value: TStrings);
  protected
    procedure WriteFooter(Dest: TStrings);
    procedure WriteHeader(Dest: TStrings);
    procedure WriteProperties(Dest: TStrings; ADataSet: TDataSet);
    procedure WriteRecordCount(Dest: TStrings; ACount: Integer);
    procedure WriteTime(Dest: TStrings; ALog: Ts0LogObj);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteALog(Dest: TStream; ALog: Ts0LogObj); override;
    class function GetStyleName: string; override;
  published
    property LogHeader: TStrings read FLogHeader write SetLogHeader;
    property LogFooter: TStrings read FLogFooter write SetLogFooter;
    property LoggingProperties: TStrings read FLoggingProperties write SetLoggingProperties;
    property Options: K0LoggerDefaultStyleOptionSet read FOptions write FOptions default [k0ldsoFooter, k0ldsoProperties, k0ldsoTime];
  end;

type
  Ts0DSLoggerSimpleCSV = class(Ts0DSLoggerStyle)
  public
    procedure WriteALog(Dest: TStream; ALog: Ts0LogObj); override;
    class function GetStyleName: string; override;
  end;



type
  Es0DSLoggerException = class(Exception);

function LogDTToStr(ADateTime: TDateTime): string;
procedure RegisterLoggerStyle(ALogger: Ts0DSLoggerStyleClass);
procedure UnRegisterLoggerStyle(ALogger: Ts0DSLoggerStyleClass);

procedure Register;

implementation

uses
  s0ComponentHelper,
  s0DateHelper,
  s0TypInfoWrapper,
  s0FileStream;

procedure Register;
begin
end;

var
  g9Finalizing: Boolean = False;

procedure RegisterLoggerStyle(ALogger: Ts0DSLoggerStyleClass);
begin
  if g9Finalizing then Exit;
  RegisterClass(ALogger);
  Ts0DSLoggerStyleRegister.Instance.RegisterLoggerStyle(ALogger);
end;

procedure UnRegisterLoggerStyle(ALogger: Ts0DSLoggerStyleClass);
begin
  if g9Finalizing then Exit;
  Ts0DSLoggerStyleRegister.Instance.UnRegisterLoggerStyle(ALogger);
  UnRegisterClass(ALogger);
end;

function LogDTToStr(ADateTime: TDateTime): string;
begin
  Result := FormatDateTime('yyyy/mm/dd hh:nn:ss:zzz', ADateTime);
end;

{ Ts0LogObj }

function Ts0LogObj.FinishTimeAsString: string;
begin
  if FFinishTime = 0 then
    Result := ''
  else
    Result := LogDTToStr(FFinishTime);
end;

function Ts0LogObj.StartTimeAsString: string;
begin
  if FStartTime = 0 then
    Result := ''
  else
    Result := LogDTToStr(FStartTime);
end;

function Ts0LogObj.TimeRequiredAsString: string;
begin
  Result := '';
  if FStartTime = 0 then Exit;
  if FFinishTime = 0 then Exit;
  Result := IntToStr( Trunc( Ts0DateTimeHelper.TimeToFloat(FFinishTime - FStartTime, k0dtukMiliSecond) ) );
end;

{ Ts0DSEventListener }

procedure Ts0DSEventListener.Cancel;
begin
  if FCurrentLog = nil then Exit;
  FOwner.WriteALog(FCurrentLog);
end;

constructor Ts0DSEventListener.Create(AOwner: Ts0DSLogger; AKind: K0LoggingEventKind;
  ABufEventBefore, ABufEventAfter: TDataSetNotifyEvent);
begin
  inherited Create;
  FOwner := AOwner;
  FKind := AKind;
  FBufEventAfter := ABufEventAfter;
  FBufEventBefore := FBufEventBefore;
end;

procedure Ts0DSEventListener.DoAfterEvent(DataSet: TDataSet);
begin
  if Assigned(FBufEventAfter) then
    FBufEventAfter(DataSet);
end;

procedure Ts0DSEventListener.DoBeforeEvent(DataSet: TDataSet);
begin
  if Assigned(FBufEventBefore) then
    FBufEventBefore(DataSet);
end;

procedure Ts0DSEventListener.EventAfter(DataSet: TDataSet);
begin
  if FKind in FOwner.LoggingEvents then
  begin
    if FCurrentLog = nil then
    begin
      FCurrentLog := Ts0LogObj.Create;
      FCurrentLog.TargetDS  := DataSet;
      FCurrentLog.EventKind := FKind;
      FCurrentLog.StartTime := 0;
    end;
    FCurrentLog.Canceled := False;
    FCurrentLog.FinishTime := Now;
    //
    FOwner.WriteALog(FCurrentLog);
    FreeAndNil(FCurrentLog);
  end;
  DoAfterEvent(DataSet);
end;

procedure Ts0DSEventListener.EventBefore(DataSet: TDataSet);
begin
  DoBeforeEvent(DataSet);
  if FKind in FOwner.LoggingEvents then
  begin
    if FCurrentLog <> nil then
      Cancel;
    FreeAndNil(FCurrentLog);
    FCurrentLog := Ts0LogObj.Create;
    FCurrentLog.Canceled := True;
    FCurrentLog.TargetDS  := DataSet;
    FCurrentLog.EventKind := FKind;
    FCurrentLog.FinishTime := 0;
    FCurrentLog.StartTime := Now;
  end;
end;

function Ts0DSEventListener.GetActive: Boolean;
begin
  Result := FCurrentLog <> nil;
end;

{ Ts0DSLoggerStyle }

constructor Ts0DSLoggerStyle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := Ts0ComponentHelper.GetNewComponentName(Self);
end;

destructor Ts0DSLoggerStyle.Destroy;
begin
  if FOwnerLogger <> nil then
  begin
    if FOwnerLogger.FStyle = Self then
      FOwnerLogger.FStyle := nil;
  end;
  inherited;
end;

class function Ts0DSLoggerStyle.GetEventKindName(
  AEventKind: K0LoggingEventKind): string;
const
  c9EventKindNames: array[K0LoggingEventKind] of string = (
    'Cancel',   'Close',    'Delete',
    'Edit',     'Insert',   'Open',
    'Post',     'Refresh',  'Scroll'
  );
begin
  Result := c9EventKindNames[AEventKind]
end;

function Ts0DSLoggerStyle.GetParentComponent: TComponent;
begin
  Result := FOwnerLogger;
end;

function Ts0DSLoggerStyle.HasParent: Boolean;
begin
  Result := True; //FOwnerLogger <> nil;
end;

procedure Ts0DSLoggerStyle.SetOwnerLogger(const Value: Ts0DSLogger);
begin
  if FOwnerLogger <> nil then
    if FOwnerLogger.FStyle = Self then
      FOwnerLogger.Style := nil; 
  FOwnerLogger := Value;
  if FOwnerLogger <> nil then
    if FOwnerLogger.FStyle <> Self then
      FOwnerLogger.Style := Self;
end;

procedure Ts0DSLoggerStyle.SetParentComponent(AParent: TComponent); 
begin
  if csLoading in ComponentState then Exit;
  if AParent is Ts0DSLogger then
    OwnerLogger := Ts0DSLogger(AParent);
end;

procedure Ts0DSLoggerStyle.WriteALog(Dest: TStream; ALog: Ts0LogObj);
begin
end;

{ Ts0DSLogger }

procedure Ts0DSLogger.Cancel;
var
  i: Integer;
  lstnr: Ts0DSEventListener;
begin
  for i := 0 to FListeners.Count -1 do
  begin
    lstnr := Ts0DSEventListener(FListeners.Items[i]);
    if lstnr.Active then
      lstnr.Cancel;
  end;
end;

constructor Ts0DSLogger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStreamType := k0lstFile;
  FActive := False;
end;

destructor Ts0DSLogger.Destroy;
begin
  FreeAndNil(FStyle);
  PutEventsBack;
  inherited Destroy;
end;

function Ts0DSLogger.GetActive: Boolean;
begin
  if [csLoading, csReading, csDesigning] * Self.ComponentState = [] then
    Result := FListeners <> nil
  else
    Result := FActive;
end;

procedure Ts0DSLogger.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited;
  if FStyle <> nil then
    if FStyle.Owner = Root then
      Proc(FStyle);
end;

function Ts0DSLogger.GetListener(AKind: K0LoggingEventKind): Ts0DSEventListener;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FListeners.Count -1 do
  begin
    Result := Ts0DSEventListener(FListeners.Items[i]);
    if Result.FKind = AKind then Exit;
  end;
end;

function Ts0DSLogger.GetStream: TStream;
begin
  if FStream = nil then
    case FStreamType of
      k0lstFile  : FStream := Ts0WriteFileBuffer.Create(FFileName, k0fsmDenyNone, False);
      k0lstMemory: FStream := TMemoryStream.Create;
      k0lstCustom: ;
    end;
  Result := FStream;
end;

function Ts0DSLogger.GetStyle: Ts0DSLoggerStyle;
begin
  if FStyle = nil then
    FStyle := NewStyle(Ts0DSLoggerDefaultStyle);
  Result := FStyle;
end;

function Ts0DSLogger.GetStyleName: string;
begin
  Result := Ts0DSLoggerDefaultStyle.GetStyleName;
  if FStyle = nil then Exit;
  Result := FStyle.GetStyleName;
end;

procedure Ts0DSLogger.Loaded;
begin
  inherited;
  if csDesigning in Self.ComponentState then Exit;
  if FActive then
    SnatchEvents;
end;

function Ts0DSLogger.NewStyle(
  AClass: Ts0DSLoggerStyleClass): Ts0DSLoggerStyle;
begin
  Result := AClass.Create(Self.Owner);
  Result.FOwnerLogger := Self;
end;

procedure Ts0DSLogger.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTargetDS = AComponent then
    FTargetDS := nil;
end;

procedure Ts0DSLogger.PutEventsBack;
var
  ls: Ts0DSEventListener;
begin
  if TargetDS = nil then Exit;
  if FListeners = nil then Exit;
  ls := GetListener(k0lekCancel);
  TargetDS.BeforeCancel  := ls.FBufEventBefore;
  TargetDS.AfterCancel   := ls.FBufEventAfter;
  ls := GetListener(k0lekClose);
  TargetDS.BeforeClose   := ls.FBufEventBefore;
  TargetDS.AfterClose    := ls.FBufEventAfter;
  ls := GetListener(k0lekDelete);
  TargetDS.BeforeDelete  := ls.FBufEventBefore;
  TargetDS.AfterDelete   := ls.FBufEventAfter;
  ls := GetListener(k0lekEdit);
  TargetDS.BeforeEdit    := ls.FBufEventBefore;
  TargetDS.AfterEdit     := ls.FBufEventAfter;
  ls := GetListener(k0lekInsert);
  TargetDS.BeforeInsert  := ls.FBufEventBefore;
  TargetDS.AfterInsert   := ls.FBufEventAfter;
  ls := GetListener(k0lekOpen);
  TargetDS.BeforeOpen    := ls.FBufEventBefore;
  TargetDS.AfterOpen     := ls.FBufEventAfter;
  ls := GetListener(k0lekPost);
  TargetDS.BeforePost    := ls.FBufEventBefore;
  TargetDS.AfterPost     := ls.FBufEventAfter;
  ls := GetListener(k0lekRefresh);
  TargetDS.BeforeRefresh := ls.FBufEventBefore;
  TargetDS.AfterRefresh  := ls.FBufEventAfter;
  ls := GetListener(k0lekScroll);
  TargetDS.BeforeScroll  := ls.FBufEventBefore;
  TargetDS.AfterScroll   := ls.FBufEventAfter;
  FreeAndNil(FListeners);
end;

procedure Ts0DSLogger.SetActive(const Value: Boolean);
begin
  if GetActive = Value then Exit;
  if [csLoading, csReading, csDesigning] * Self.ComponentState = [] then
  begin
    if Value then SnatchEvents else PutEventsBack;
  end
  else
    FActive := Value;
end;

resourcestring
  c9ErrMsg_CannotChangeTargetDSOnActive =
    'ActiveプロパティがTrueの時にはTargetDSプロパティを変更することはできません';

procedure Ts0DSLogger.SetFileName(const Value: TFileName);
begin
  FFileName := Value;
end;

resourcestring
  c9ErrMsg_CannotChangeStream =
    'StreamTypeがk0lstCustom以外が設定されているので、Streamプロパティを設定できません。';

procedure Ts0DSLogger.SetStream(const Value: TStream);
begin
  if FStreamType <> k0lstCustom then
    raise Es0DSLoggerException.Create(c9ErrMsg_CannotChangeStream);
  FStream := Value;
end;

procedure Ts0DSLogger.SetStreamType(const Value: K0LoggerStreamType);
begin
  if FStreamType = Value then Exit;
  FStreamType := Value;
  if FStreamType = k0lstCustom then
    FreeAndNil(FStream);
end;

procedure Ts0DSLogger.SetStyle(const Value: Ts0DSLoggerStyle);
begin
  if FStyle = Value then Exit;
  if FStyle <> nil then
    if FStyle.OwnerLogger = Self then
      FStyle.OwnerLogger := nil;
  FStyle := Value;
  if FStyle <> nil then
    if FStyle.OwnerLogger <> Self then
      FStyle.OwnerLogger := Self;
end;

procedure Ts0DSLogger.SetStyleName(const Value: string);
var
  cls: Ts0DSLoggerStyleClass;
begin
  if [csLoading, csReading] * Self.ComponentState <> [] then Exit;
  FreeAndNil(FStyle);
  cls := Ts0DSLoggerStyleRegister.Instance.StyleByName(Value);
  if cls = nil then
    cls := Ts0DSLoggerDefaultStyle;          
  Style := NewStyle(cls);
end;

procedure Ts0DSLogger.SetTargetDS(const Value: TDataSet);
begin
  if FTargetDS = Value then Exit;
  if [csLoading, csReading, csDesigning] * Self.ComponentState = [] then
    if Active then
      raise Es0DSLoggerException.Create(c9ErrMsg_CannotChangeTargetDSOnActive);
  FTargetDS := Value;
end;

procedure Ts0DSLogger.SnatchEvents;
  function NewListener(AKind: K0LoggingEventKind; AEventBefore, AEventAfter: TDataSetNotifyEvent): Ts0DSEventListener;
  begin
    Result := Ts0DSEventListener.Create(Self, AKind, AEventBefore, AEventAfter);
    FListeners.Add(Result);
  end;
var
  nl: Ts0DSEventListener;
begin
  if TargetDS = nil then Exit;
  if FListeners <> nil then Exit;
  FListeners := TObjectList.Create(True);
  nl := NewListener(k0lekCancel , TargetDS.BeforeCancel , TargetDS.AfterCancel );
  TargetDS.BeforeCancel := nl.EventBefore;
  TargetDS.AfterCancel  := nl.EventAfter;
  nl := NewListener(k0lekClose  , TargetDS.BeforeClose  , TargetDS.AfterClose  );
  TargetDS.BeforeClose := nl.EventBefore;
  TargetDS.AfterClose  := nl.EventAfter;
  nl := NewListener(k0lekDelete , TargetDS.BeforeDelete , TargetDS.AfterDelete );
  TargetDS.BeforeDelete := nl.EventBefore;
  TargetDS.AfterDelete  := nl.EventAfter;
  nl := NewListener(k0lekEdit   , TargetDS.BeforeEdit   , TargetDS.AfterEdit   );
  TargetDS.BeforeEdit := nl.EventBefore;
  TargetDS.AfterEdit  := nl.EventAfter;
  nl := NewListener(k0lekInsert , TargetDS.BeforeInsert , TargetDS.AfterInsert );
  TargetDS.BeforeInsert := nl.EventBefore;
  TargetDS.AfterInsert  := nl.EventAfter;
  nl := NewListener(k0lekOpen   , TargetDS.BeforeOpen   , TargetDS.AfterOpen   );
  TargetDS.BeforeOpen := nl.EventBefore;
  TargetDS.AfterOpen  := nl.EventAfter;
  nl := NewListener(k0lekPost   , TargetDS.BeforePost   , TargetDS.AfterPost   );
  TargetDS.BeforePost := nl.EventBefore;
  TargetDS.AfterPost  := nl.EventAfter;
  nl := NewListener(k0lekRefresh, TargetDS.BeforeRefresh, TargetDS.AfterRefresh);
  TargetDS.BeforeRefresh := nl.EventBefore;
  TargetDS.AfterRefresh  := nl.EventAfter;
  nl := NewListener(k0lekScroll , TargetDS.BeforeScroll , TargetDS.AfterScroll );
  TargetDS.BeforeScroll := nl.EventBefore;
  TargetDS.AfterScroll  := nl.EventAfter;
end;

procedure Ts0DSLogger.WriteALog(ALog: Ts0LogObj);
begin
  if FStyle <> nil then
    FStyle.WriteALog(Stream, ALog);
  if FStream is Ts0WriteFileBuffer then
  begin
    Ts0WriteFileBuffer(FStream).Open;
    Ts0WriteFileBuffer(FStream).WriteToDest;
    Ts0WriteFileBuffer(FStream).Close;
  end;
end;

{ Ts0DSLoggerStyleRegister }

constructor Ts0DSLoggerStyleRegister.Create;
begin
  inherited Create;
  FStyles := TClassList.Create;
end;

destructor Ts0DSLoggerStyleRegister.Destroy;
begin
  g9Finalizing := True;
  FreeAndNil(FStyles);
  inherited;
end;

procedure Ts0DSLoggerStyleRegister.GetStyleNames(Proc: TGetStrProc);
var
  i: Integer;
begin
  for i := 0 to FStyles.Count -1 do
    Proc( Ts0DSLoggerStyleClass(FStyles.Items[i]).GetStyleName );
end;

procedure Ts0DSLoggerStyleRegister.GetStyleNamesToList(Dest: TStrings);
var
  i: Integer;
begin
  for i := 0 to FStyles.Count -1 do
    Dest.Add( Ts0DSLoggerStyleClass(FStyles.Items[i]).GetStyleName );
end;

var
  g9DSLRegister: Ts0DSLoggerStyleRegister = nil;

resourcestring
  c9ErrMsg_CannotCreateInFinalizing = '終了処理中にT0QLPRegister.Instanceにアクセスすることはできません';

class function Ts0DSLoggerStyleRegister.Instance: Ts0DSLoggerStyleRegister;
begin
  if g9Finalizing then
    raise Es0DSLoggerException.Create(c9ErrMsg_CannotCreateInFinalizing);
  if g9DSLRegister = nil then
    g9DSLRegister := Ts0DSLoggerStyleRegister.Create;
  Result := g9DSLRegister;
end;

function Ts0DSLoggerStyleRegister.StyleByName(AName: string): Ts0DSLoggerStyleClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FStyles.Count -1 do
    if AnsiCompareText(Ts0DSLoggerStyleClass(FStyles.Items[i]).GetStyleName, AName) = 0 then
    begin
      Result := Ts0DSLoggerStyleClass(FStyles.Items[i]);
      Exit;
    end;
end;

procedure Ts0DSLoggerStyleRegister.RegisterLoggerStyle(
  ALogger: Ts0DSLoggerStyleClass);
begin
  if FStyles.IndexOf(ALogger) > -1 then Exit;
  FStyles.Add(ALogger);
end;

procedure Ts0DSLoggerStyleRegister.UnRegisterLoggerStyle(
  ALogger: Ts0DSLoggerStyleClass);
begin
  while FStyles.Remove(ALogger) > -1 do ;
end;

{ Ts0DSLoggerDefaultStyle }

constructor Ts0DSLoggerDefaultStyle.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [k0ldsoFooter, k0ldsoProperties, k0ldsoTime];
  FLoggingProperties := TStringList.Create;
  FLoggingProperties.Add('Name');
  FLoggingProperties.Add('Params');
  FLoggingProperties.Add('SQL');
  //
  FLogHeader := TStringList.Create;
  FLogFooter := TStringList.Create;
  FLogFooter.Text := StringOfChar('-', 79);
end;

destructor Ts0DSLoggerDefaultStyle.Destroy;
begin
  FreeAndNil(FLogFooter);
  FreeAndNil(FLogHeader);
  FreeAndNil(FLoggingProperties);
  inherited;
end;

class function Ts0DSLoggerDefaultStyle.GetStyleName: string;
begin
  Result := 'Default';
end;

procedure Ts0DSLoggerDefaultStyle.SetLogFooter(const Value: TStrings);
begin
  FLogFooter.Assign(Value);
end;

procedure Ts0DSLoggerDefaultStyle.SetLoggingProperties(
  const Value: TStrings);
begin
  FLoggingProperties.Assign(Value);
end;

procedure Ts0DSLoggerDefaultStyle.SetLogHeader(const Value: TStrings);
begin
  FLogHeader.Assign(Value);
end;

procedure Ts0DSLoggerDefaultStyle.WriteALog(Dest: TStream; ALog: Ts0LogObj);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    if k0ldsoHeader      in FOptions then WriteHeader(sl);
    sl.Add(Format('EventKind: %s', [GetEventKindName(ALog.EventKind)]) );
    if k0ldsoProperties  in FOptions then WriteProperties(sl, ALog.TargetDS);
    if k0ldsoRecordCount in FOptions then WriteRecordCount(sl, ALog.TargetDS.RecordCount);
    if k0ldsoTime        in FOptions then WriteTime(sl, ALog);
    if k0ldsoFooter      in FOptions then WriteFooter(sl);
    sl.SaveToStream(Dest);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0DSLoggerDefaultStyle.WriteFooter(Dest: TStrings);
begin
  Dest.AddStrings(FLogFooter);
end;

procedure Ts0DSLoggerDefaultStyle.WriteHeader(Dest: TStrings);
begin
  Dest.AddStrings(FLogHeader);
end;

procedure Ts0DSLoggerDefaultStyle.WriteProperties(Dest: TStrings; ADataSet: TDataSet);
var
  i: Integer;
  acsr: Ts0RTTIPublishedAccessor;
  pn: string;
begin
  acsr := Ts0RTTIPublishedAccessor.Create(ADataSet);
  try
    for i := 0 to FLoggingProperties.Count -1 do
    begin
      pn := FLoggingProperties.Strings[i];
      if not acsr.PropertyExists(pn) then Continue;
      Dest.Add( pn +'="'+ acsr.PropAsString[ pn ] +'"' );
    end;
  finally
    FreeAndNil(acsr);
  end;
end;

procedure Ts0DSLoggerDefaultStyle.WriteRecordCount(Dest: TStrings;
  ACount: Integer);
begin
  Dest.Add( 'RecordCount='+ IntToStr(ACount) );
end;

procedure Ts0DSLoggerDefaultStyle.WriteTime(Dest: TStrings; ALog: Ts0LogObj);
begin
  Dest.Add(
    Format(
      'Start: %s' +#$D#$A+ 'Finish: %s' +#$D#$A+ 'TimeRequired(ms): %s',
      [ALog.StartTimeAsString, ALog.FinishTimeAsString, ALog.TimeRequiredAsString]
    )
  );
end;

{ Ts0DSLoggerSimpleCSV }

class function Ts0DSLoggerSimpleCSV.GetStyleName: string;
begin
  Result := 'Simple CSV';
end;

procedure Ts0DSLoggerSimpleCSV.WriteALog(Dest: TStream; ALog: Ts0LogObj);
var
  s: string;
  ss: TStringStream;
begin
  s := Format(
      '"%s","%s","%s","%s","%s"' +#$D#$A,[
      ALog.TargetDS.Name,
      GetEventKindName(ALog.EventKind),
      ALog.StartTimeAsString,
      ALog.FinishTimeAsString,
      ALog.TimeRequiredAsString      
    ]);                      
  ss := TStringStream.Create(s);
  try
    Dest.CopyFrom(ss, 0);
  finally
    FreeAndNil(ss);
  end;
end;

initialization
  RegisterLoggerStyle(Ts0DSLoggerDefaultStyle);
  RegisterLoggerStyle(Ts0DSLoggerSimpleCSV);

finalization
  UnRegisterLoggerStyle(Ts0DSLoggerDefaultStyle);
  UnRegisterLoggerStyle(Ts0DSLoggerSimpleCSV);
  g9Finalizing := True;
  FreeAndNil(g9DSLRegister);

end.
