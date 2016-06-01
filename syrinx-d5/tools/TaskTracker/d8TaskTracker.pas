unit d8TaskTracker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Collection,
  Contnrs, s0FormEventPublisher, s0ObjPropStocker, s0IniPropStocker;

type
  T8UserStory = class;

  K8TaskState = (k8tsNotYet, k8tsCompleted, k8tsWorking, k8tsStopped);
  
  T8PGTask = class(Ts0CollectionItem)
  private
    FCompleted: Boolean;
    FRealWorkTime: Double;
    FEstimate: Double;
    FPGName: string;
    FTaskName: string;
    FTaskID: Integer;
    FPriority: Integer;
    FDescription: TStrings;
    FStatus: K8TaskState;
    procedure SetCompleted(const Value: Boolean);
    procedure SetEstimate(const Value: Double);
    procedure SetPGName(const Value: string);
    procedure SetRealWorkTime(const Value: Double);
    procedure SetTaskName(const Value: string);
    procedure SetTaskID(const Value: Integer);
    procedure SetPriority(const Value: Integer);
    function GetSourceStory: T8UserStory;
    procedure SetDescription(const Value: TStrings);
    procedure SetStatus(const Value: K8TaskState);
  protected
    function GetIdentifier: string; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property SourceStory: T8UserStory read GetSourceStory; // write SetSourceStory;
  published
    property TaskID: Integer read FTaskID write SetTaskID;
    property TaskName: string read FTaskName write SetTaskName;
    property Priority: Integer read FPriority write SetPriority;
    property PGName: string read FPGName write SetPGName;
    property Estimate: Double read FEstimate write SetEstimate; //unit: Hour
    property RealWorkTime: Double read FRealWorkTime write SetRealWorkTime; //unit: Hour
    property Completed: Boolean read FCompleted write SetCompleted;
    property Description: TStrings read FDescription write SetDescription;
    property Status: K8TaskState read FStatus write SetStatus;
  end;

  T8PGTasks = class(Ts0Collection)
  private
    function GetTasks(const Index: Integer): T8PGTask;
    procedure SetTasks(const Index: Integer; const Value: T8PGTask);
  public
    function Add(ATaskName: string): T8PGTask;
    function FindByTaskID(ATaskID: Integer): T8PGTask;
    procedure SortByPriority;
    property Tasks[const Index: Integer]: T8PGTask read GetTasks write SetTasks; default;
  end;

  T8UserStory = class(Ts0CollectionItem)
  private
    FUserName: string;
    FStoryName: string;
    FRequireDate: TDateTime;
    FCompleted: Boolean;
    FDescription: TStrings;
    FStoryID: Integer;
    FTasks: T8PGTasks;
    procedure SetRequireDate(const Value: TDateTime);
    procedure SetStoryName(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetCompleted(const Value: Boolean);
    procedure SetDescription(const Value: TStrings);
    procedure SetStoryID(const Value: Integer);
    procedure SetTasks(const Value: T8PGTasks);
  protected
    function GetIdentifier: string; override;
    function GetSubCollection: Ts0Collection; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property StoryID: Integer read FStoryID write SetStoryID;
    property StoryName: string read FStoryName write SetStoryName;
    property UserName: string read FUserName write SetUserName;
    property RequireDate: TDateTime read FRequireDate write SetRequireDate;
    property Completed: Boolean read FCompleted write SetCompleted;
    property Description: TStrings read FDescription write SetDescription;
    property Tasks: T8PGTasks read FTasks write SetTasks;
  end;

type
  T8UserStories = class(Ts0Collection)
  private
    function GetStories(const Index: Integer): T8UserStory;
    procedure SetStories(const Index: Integer; const Value: T8UserStory);
  public
    function Add(AUserName, AStoryName: string; ARequireDate: TDateTime = 0): T8UserStory;
    function FindByStoryID(AStoryID: Integer): T8UserStory;
    property Stories[const Index: Integer]: T8UserStory read GetStories write SetStories; default;
  end;

type
  K8PGScheduleKind = (k8pgskNone, k8pgskProg, k8pgskMeeting, k8pgskOther);

type
  T8PGSchedule = class(Ts0CollectionItem)
  private
    FTaskID: Integer;
    FScheduleID: Integer;
    FBeginDate: TDateTime;
    FEndDate: TDateTime;
    FScheduleName: string;
    FScheduleKind: K8PGScheduleKind;
    procedure SetBeginDate(const Value: TDateTime);
    procedure SetEndDate(const Value: TDateTime);
    procedure SetScheduleID(const Value: Integer);
    procedure SetTaskID(const Value: Integer);
    procedure SetTask(const Value: T8PGTask);
    function GetTask: T8PGTask;
    procedure SetScheduleName(const Value: string);
    procedure SetScheduleKind(const Value: K8PGScheduleKind);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    function InTime(ADateTime: TDateTime): Boolean;
    property Task: T8PGTask read GetTask write SetTask;
    procedure Assign(Source: TPersistent); override;
  published
    property ScheduleID: Integer read FScheduleID write SetScheduleID;
    property ScheduleKind: K8PGScheduleKind read FScheduleKind write SetScheduleKind;
    property ScheduleName: string read FScheduleName write SetScheduleName;
    property TaskID: Integer read FTaskID write SetTaskID;
    property BeginDate: TDateTime read FBeginDate write SetBeginDate;
    property EndDate: TDateTime read FEndDate write SetEndDate;
  end;

type
  T8PGSchedules = class(Ts0Collection)
  private
    function GetSchedules(const Index: Integer): T8PGSchedule;
    procedure SetSchedules(const Index: Integer;
      const Value: T8PGSchedule);
  public
    function Add(ATaskID: Integer): T8PGSchedule;
    procedure SortByDateTime;
    property Schedules[const Index: Integer]: T8PGSchedule read GetSchedules write SetSchedules; default;
  end;

type
  T8DialyBreak = class(Ts0CollectionItem)
  private
    FBeginTime: TTime;
    FEndTime: TTime;
    procedure SetBeginTime(const Value: TTime);
    procedure SetEndTime(const Value: TTime);
  public
    procedure Assign(Source: TPersistent); override;
    function InTime(ATime: TTime): Boolean;
  published
    property BeginTime: TTime read FBeginTime write SetBeginTime;
    property EndTime: TTime read FEndTime write SetEndTime;
  end;

type
  T8DialyBreaks = class(Ts0Collection)
  private
    function GetBreaks(const Index: Integer): T8DialyBreak;
    procedure SetBreaks(const Index: Integer;
      const Value: T8DialyBreak);
  public
    function Add(ABegin, AEnd: TTime): T8DialyBreak;
    procedure SortByTime;
    property Breaks[const Index: Integer]: T8DialyBreak read GetBreaks write SetBreaks; default;
  end;

type
  T8WorkTimeRule = class(TPersistent)
  private
    FDailyFinishTime: TTime;
    FDailyBeginTime: TTime;
    FBreakTimes: T8DialyBreaks;
    FExtraHoliDays: TStrings;
    FExtraWorkDays: TStrings;
    procedure SetDailyBeginTime(const Value: TTime);
    procedure SetDailyFinishTime(const Value: TTime);
    procedure SetBreakTimes(const Value: T8DialyBreaks);
    procedure SetExtraHoliDays(const Value: TStrings);
    procedure SetExtraWorkDays(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function InWorkingTime(ATime: TTime): Boolean;
    function IsWorkDay(ADate: TDate): Boolean;
    function GetNextBreakTime(ANow: TDateTime): TDateTime;
    function GetNextStartTime(ANow: TDateTime): TDateTime;
  published
    property DailyBeginTime: TTime read FDailyBeginTime write SetDailyBeginTime;
    property DailyFinishTime: TTime read FDailyFinishTime write SetDailyFinishTime;
    property ExtraHoliDays: TStrings read FExtraHoliDays write SetExtraHoliDays;
    property ExtraWorkDays: TStrings read FExtraWorkDays write SetExtraWorkDays;
    property BreakTimes: T8DialyBreaks read FBreakTimes write SetBreakTimes;
  end;

type
  Tc8TrackerMemento = class(TComponent)
  private
    FStories: T8UserStories;
    FSchedules: T8PGSchedules;
    procedure SetStories(const Value: T8UserStories);
    procedure SetSchedules(const Value: T8PGSchedules);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Stories: T8UserStories read FStories write SetStories;
    property Schedules: T8PGSchedules read FSchedules write SetSchedules;
  end;

type
  Tc8TrackerOptions = class(TComponent)
  private
    FWorkTimeRule: T8WorkTimeRule;
    FLastFileName: string;
    procedure SetWorkTimeRule(const Value: T8WorkTimeRule);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property LastFileName: string read FLastFileName write FLastFileName;
    property WorkTimeRule: T8WorkTimeRule read FWorkTimeRule write SetWorkTimeRule;
  end;

type
  Tdm8TaskTracker = class(TDataModule)
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    procedure s0IniPropStocker1InitItems(Sender: TObject);
  private
    FMemento: Tc8TrackerMemento;
    FTaskView: TObjectList;
    FOptions: Tc8TrackerOptions;
    procedure SetMemento(const Value: Tc8TrackerMemento);
    function GetSchedules: T8PGSchedules;
    function GetStories: T8UserStories;
    procedure SetOptions(const Value: Tc8TrackerOptions);
  protected
    function GetNextBreakTime(ANow: TDateTime): TDateTime;
    function GetNextStartTime(ANow: TDateTime): TDateTime;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CalcWorkTime(ANow: TDateTime; var ANeed: Double; var AStart, AEnd: TDateTime): Boolean;
    procedure ReClacSchedules;
    property Stories: T8UserStories read GetStories;
    property Schedules: T8PGSchedules read GetSchedules;
    property TaskView: TObjectList read FTaskView;
    procedure SetTaskViewStory(const Value: T8UserStory);
    procedure LoadFromFile;
    procedure SaveToFile;
  published
    property Memento: Tc8TrackerMemento read FMemento write SetMemento;
    property Options: Tc8TrackerOptions read FOptions write SetOptions;
  end;

var
  dm8TaskTracker: Tdm8TaskTracker;

implementation

{$R *.DFM}

{ T8PGTask }

procedure T8PGTask.Assign(Source: TPersistent);
begin
  if not(Source is T8PGTask) then Exit;
  Completed    := T8PGTask(Source).Completed   ;
  RealWorkTime := T8PGTask(Source).RealWorkTime;
  Estimate     := T8PGTask(Source).Estimate    ;
  PGName       := T8PGTask(Source).PGName      ;
  TaskName     := T8PGTask(Source).TaskName    ;
  TaskID       := T8PGTask(Source).TaskID      ;
  Priority     := T8PGTask(Source).Priority    ;
  Description  := T8PGTask(Source).Description ;
end;

constructor T8PGTask.Create(ACollection: TCollection);
begin
  inherited;
  FTaskID := ID;
  FTaskName := 'New Task';
  FDescription := TStringList.Create;
end;

destructor T8PGTask.Destroy;
begin
  FreeAndNil(FDescription);
  inherited;
end;

function T8PGTask.GetIdentifier: string;
begin
  Result := FTaskName;
end;

function T8PGTask.GetSourceStory: T8UserStory;
begin
  Result := nil;
  if OwnerObj is T8UserStory then
    Result := T8UserStory(OwnerObj);
{
  if OwnerComponent is Tdm8TaskTracker then
    Result := Tdm8TaskTracker(OwnerComponent).Stories.FindByStoryID(FSourceStoryID);
}
end;

procedure T8PGTask.SetCompleted(const Value: Boolean);
begin
  FCompleted := Value;
  Changed(False);
end;

procedure T8PGTask.SetDescription(const Value: TStrings);
begin
  FDescription.Assign(Value);
  Changed(False);
end;

procedure T8PGTask.SetEstimate(const Value: Double);
begin
  FEstimate := Value;
  Changed(False);
end;

procedure T8PGTask.SetPGName(const Value: string);
begin
  FPGName := Value;
  Changed(False);
end;

procedure T8PGTask.SetPriority(const Value: Integer);
begin
  FPriority := Value;
  Changed(False);
end;

procedure T8PGTask.SetRealWorkTime(const Value: Double);
begin
  FRealWorkTime := Value;
  Changed(False);
end;

procedure T8PGTask.SetStatus(const Value: K8TaskState);
begin
  FStatus := Value;
end;

procedure T8PGTask.SetTaskID(const Value: Integer);
begin
  FTaskID := Value;
  Changed(False);
end;

procedure T8PGTask.SetTaskName(const Value: string);
begin
  FTaskName := Value;
  Changed(False);
end;

{ T8PGTasks }

function T8PGTasks.Add(ATaskName: string): T8PGTask;
begin
  Result := T8PGTask(inherited Add);
  Result.FTaskName := ATaskName;
end;

function T8PGTasks.FindByTaskID(ATaskID: Integer): T8PGTask;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Tasks[i];
    if Result.TaskID = ATaskID then Exit;
  end;
  Result := nil;
end;

function T8PGTasks.GetTasks(const Index: Integer): T8PGTask;
begin
  Result := T8PGTask(inherited Items[Index]);
end;

procedure T8PGTasks.SetTasks(const Index: Integer; const Value: T8PGTask);
begin
  inherited Items[Index] := Value;
end;

procedure T8PGTasks.SortByPriority;
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create;
  try
    for i := 0 to Self.Count -1 do
      sl.AddObject(Format('%8.8d', [Tasks[i].Priority]), Tasks[i]);
    sl.Sort;
    for i := sl.Count -1 downto 0 do
      T8PGTask(sl.Objects[i]).Index := 0;
  finally
    FreeAndNil(sl);
  end;
end;

{ T8UserStory }

procedure T8UserStory.Assign(Source: TPersistent);
begin
  if not(Source is T8UserStory) then Exit;
  UserName    := T8UserStory(Source).UserName   ;
  StoryName   := T8UserStory(Source).StoryName  ;
  RequireDate := T8UserStory(Source).RequireDate;
  Completed   := T8UserStory(Source).Completed  ;
  Description := T8UserStory(Source).Description;
  StoryID     := T8UserStory(Source).StoryID    ;
  Tasks       := T8UserStory(Source).Tasks      ;
end;

constructor T8UserStory.Create(ACollection: TCollection);
begin
  inherited;
  FDescription := TStringList.Create;
  FRequireDate := Now;
  FStoryID := ID;
  FStoryName := 'New Story';
  FTasks := T8PGTasks.Create(Self, T8PGTask);
end;

destructor T8UserStory.Destroy;
begin
  FreeAndNil(FTasks);
  FreeAndNil(FDescription);
  inherited;
end;

function T8UserStory.GetIdentifier: string;
begin
  Result := FStoryName;
end;

function T8UserStory.GetSubCollection: Ts0Collection;
begin
  Result := FTasks;
end;

procedure T8UserStory.SetCompleted(const Value: Boolean);
begin
  FCompleted := Value;
  Changed(False);
end;

procedure T8UserStory.SetDescription(const Value: TStrings);
begin
  FDescription.Assign(Value);
  Changed(False);
end;

procedure T8UserStory.SetRequireDate(const Value: TDateTime);
begin
  FRequireDate := Value;
  Changed(False);
end;

procedure T8UserStory.SetStoryID(const Value: Integer);
begin
  FStoryID := Value;
  Changed(False);
end;

procedure T8UserStory.SetStoryName(const Value: string);
begin
  FStoryName := Value;
  Changed(False);
end;

procedure T8UserStory.SetTasks(const Value: T8PGTasks);
begin
  FTasks.Assign(Value);
  Changed(False);
end;

procedure T8UserStory.SetUserName(const Value: string);
begin
  FUserName := Value;
  Changed(False);
end;

{ T8UserStories }

function T8UserStories.Add(AUserName, AStoryName: string;
  ARequireDate: TDateTime): T8UserStory;
begin
  Result := T8UserStory(inherited Add);
  Result.FStoryName := AStoryName;
  Result.FUserName := AUserName;
  Result.FRequireDate := ARequireDate;
end;

function T8UserStories.FindByStoryID(AStoryID: Integer): T8UserStory;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Stories[i];
    if Result.StoryID =  AStoryID then Exit;
  end;
  Result := nil;
end;

function T8UserStories.GetStories(const Index: Integer): T8UserStory;
begin
  Result := T8UserStory(inherited Items[Index]);
end;

procedure T8UserStories.SetStories(const Index: Integer;
  const Value: T8UserStory);
begin
  inherited Items[Index] := Value;
end;

{ T8PGSchedule }

procedure T8PGSchedule.Assign(Source: TPersistent);
begin
  if not(Source is T8PGSchedule) then Exit;
  TaskID       := T8PGSchedule(Source).TaskID      ;
  ScheduleID   := T8PGSchedule(Source).ScheduleID  ;
  BeginDate    := T8PGSchedule(Source).BeginDate   ;
  EndDate      := T8PGSchedule(Source).EndDate     ;
  ScheduleName := T8PGSchedule(Source).ScheduleName;
  ScheduleKind := T8PGSchedule(Source).ScheduleKind;
end;

constructor T8PGSchedule.Create(ACollection: TCollection);
begin
  inherited;
  FScheduleID := ID;
end;

destructor T8PGSchedule.Destroy;
begin
  inherited;

end;

function T8PGSchedule.GetTask: T8PGTask;
begin
  Result := nil;
{
  if OwnerComponent is Tdm8TaskTracker then
    Result := Tdm8TaskTracker(OwnerComponent).Tasks.FindByTaskID(FTaskID);
}
end;

function T8PGSchedule.InTime(ADateTime: TDateTime): Boolean;
begin
  Result := False;
  if ADateTime < FBeginDate then Exit;
  if ADateTime > FEndDate then Exit;
  Result := True;
end;

procedure T8PGSchedule.SetBeginDate(const Value: TDateTime);
begin
  FBeginDate := Value;
  Changed(False);
end;

procedure T8PGSchedule.SetEndDate(const Value: TDateTime);
begin
  FEndDate := Value;
  Changed(False);
end;

procedure T8PGSchedule.SetScheduleID(const Value: Integer);
begin
  FScheduleID := Value;
  Changed(False);
end;

procedure T8PGSchedule.SetScheduleKind(const Value: K8PGScheduleKind);
begin
  FScheduleKind := Value;
  Changed(False);
end;

procedure T8PGSchedule.SetScheduleName(const Value: string);
begin
  FScheduleName := Value;
  Changed(False);
end;

procedure T8PGSchedule.SetTask(const Value: T8PGTask);
begin
  if Value = nil then
    FTaskID := -1
  else
    FTaskID := Value.TaskID;
  Changed(False);
end;

procedure T8PGSchedule.SetTaskID(const Value: Integer);
begin
  FTaskID := Value;
  Changed(False);
end;

{ T8PGSchedules }

function T8PGSchedules.Add(ATaskID: Integer): T8PGSchedule;
begin
  Result := T8PGSchedule(inherited Add);
  Result.FTaskID := ATaskID;
end;

function T8PGSchedules.GetSchedules(const Index: Integer): T8PGSchedule;
begin
  Result := T8PGSchedule(inherited Items[Index]);
end;

procedure T8PGSchedules.SetSchedules(const Index: Integer;
  const Value: T8PGSchedule);
begin
  inherited Items[Index] := Value;
end;

procedure T8PGSchedules.SortByDateTime;
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create;
  try
    for i := 0 to Self.Count -1 do
      sl.AddObject(FormatDateTime('yyyymmddhhnnsszzz', Schedules[i].BeginDate), Schedules[i]);
    sl.Sort;
    for i := sl.Count -1 downto 0 do
      T8PGSchedule(sl.Objects[i]).Index := 0;
  finally
    FreeAndNil(sl);
  end;
end;

{ T8DialyBreak }

procedure T8DialyBreak.Assign(Source: TPersistent);
begin
  if not(Source is T8DialyBreak) then Exit;
  BeginTime := T8DialyBreak(Source).BeginTime;
  EndTime := T8DialyBreak(Source).EndTime;
end;

function T8DialyBreak.InTime(ATime: TTime): Boolean;
begin
  ATime := Frac(ATime);
  Result := (ATime >= FBeginTime) and (ATime <= FEndTime);
end;

procedure T8DialyBreak.SetBeginTime(const Value: TTime);
begin
  FBeginTime := Frac(Value);
  Changed(False);
end;

procedure T8DialyBreak.SetEndTime(const Value: TTime);
begin
  FEndTime := Frac(Value);
  Changed(False);
end;

{ T8DialyBreaks }

function T8DialyBreaks.Add(ABegin, AEnd: TTime): T8DialyBreak;
begin
  Result := T8DialyBreak(inherited Add);
  Result.FBeginTime := Frac(ABegin);
  Result.FEndTime := Frac(AEnd);
end;

function T8DialyBreaks.GetBreaks(
  const Index: Integer): T8DialyBreak;
begin
  Result := T8DialyBreak(inherited Items[Index]);
end;

procedure T8DialyBreaks.SetBreaks(const Index: Integer;
  const Value: T8DialyBreak);
begin
  inherited Items[Index] := Value;
end;

procedure T8DialyBreaks.SortByTime;
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create;
  try
    for i := 0 to Self.Count -1 do
      sl.AddObject( FormatDateTime('hhnnsszzz', Breaks[i].BeginTime), Breaks[i]);
    sl.Sort;
    for i := sl.Count -1 downto 0 do
      T8DialyBreak(sl.Objects[i]).Index := 0;
  finally
    FreeAndNil(sl);
  end;
end;

{ T8WorkTimeRule }

procedure T8WorkTimeRule.Assign(Source: TPersistent);
begin
  if not (Source is T8WorkTimeRule) then Exit;
  DailyFinishTime := T8WorkTimeRule(Source).DailyFinishTime;
  DailyBeginTime  := T8WorkTimeRule(Source).DailyBeginTime ;
  BreakTimes      := T8WorkTimeRule(Source).BreakTimes     ;
  ExtraHoliDays   := T8WorkTimeRule(Source).ExtraHoliDays  ;
  ExtraWorkDays   := T8WorkTimeRule(Source).ExtraWorkDays  ;
end;

constructor T8WorkTimeRule.Create;
begin
  FBreakTimes := T8DialyBreaks.Create(Self, T8DialyBreak);
  FExtraHoliDays := TStringList.Create;
  FExtraWorkDays := TStringList.Create;
  FDailyBeginTime  := 9 / 24;
  FDailyFinishTime := 18 / 24;
  FBreakTimes.Add(StrToTime('12:00'), StrToTime('13:00'));
  FBreakTimes.Add(StrToTime('15:30'), StrToTime('16:00'));
end;

destructor T8WorkTimeRule.Destroy;
begin
  FreeAndNil(FExtraWorkDays);
  FreeAndNil(FExtraHoliDays);
  FreeAndNil(FBreakTimes);
  inherited;
end;

function T8WorkTimeRule.GetNextBreakTime(ANow: TDateTime): TDateTime;
var
  i: Integer;
  nowTime: TTime;
begin
  while not IsWorkDay(ANow) do
    ANow := Int(ANow + 1) + FDailyBeginTime;
  if Frac(ANow) < FDailyBeginTime then
    ANow := Int(ANow) + FDailyBeginTime
  else
  if Frac(ANow) >= FDailyFinishTime then
    ANow := Int(ANow + 1) + FDailyBeginTime;
  //
  nowTime := Frac(ANow);
  for i := 0 to FBreakTimes.Count -1 do
  begin
    if nowTime < BreakTimes[i].BeginTime then
    begin
      Result := Int(ANow) + BreakTimes[i].BeginTime;
      Exit;
    end;
  end;
  Result := Int(ANow) + FDailyFinishTime;
end;

function T8WorkTimeRule.GetNextStartTime(ANow: TDateTime): TDateTime;
var
  i: Integer;
  nowTime: TTime;
begin
  if Frac(ANow) >= FDailyFinishTime then
    ANow := Int(ANow + 1) + FDailyBeginTime;
  while not IsWorkDay(ANow) do
    ANow := Int(ANow + 1) + FDailyBeginTime;
  if Frac(ANow) < FDailyBeginTime then
  begin
    Result := Int(ANow) + FDailyBeginTime;
    Exit;
  end;
  if InWorkingTime(ANow) then
  begin
    Result := ANow;
    Exit;
  end;
  //
  nowTime := Frac(ANow);
  for i := 0 to FBreakTimes.Count -1 do
  begin
    if nowTime < BreakTimes[i].EndTime then
    begin
      Result := Int(ANow) + BreakTimes[i].EndTime;
      Exit;
    end;
  end;
  Result := Int(ANow + 1) + FDailyBeginTime;
end;

function T8WorkTimeRule.InWorkingTime(ATime: TTime): Boolean;
var
  i: Integer;
begin
  Result := False;
  ATime := Frac(ATime);
  if ATime < FDailyBeginTime then Exit;
  if ATime > FDailyFinishTime then Exit;
  for i := 0 to BreakTimes.Count -1 do
    if BreakTimes[i].InTime(ATime) then Exit;
  Result := True;
end;

function T8WorkTimeRule.IsWorkDay(ADate: TDate): Boolean;
  function IsExtraWorkDay(ADate: TDate): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    ADate := Trunc(ADate);
    for i := 0 to FExtraWorkDays.Count -1 do
      if StrToDate(FExtraWorkDays.Strings[i]) = ADate then Exit;
    Result := False;
  end;
  function IsExtraHoliDay(ADate: TDate): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    ADate := Trunc(ADate);
    for i := 0 to FExtraHoliDays.Count -1 do
      if StrToDate(FExtraHoliDays.Strings[i]) = ADate then Exit;
    Result := False;
  end;
var
  lDayOfWeek: Integer;
begin
  Result := True;
  lDayOfWeek := DayOfWeek(ADate);
  case lDayOfWeek of
       1: Result := IsExtraWorkDay(ADate);
    2..6: Result := not IsExtraHoliDay(ADate);
       7: Result := IsExtraWorkDay(ADate);
  end;
end;

procedure T8WorkTimeRule.SetBreakTimes(const Value: T8DialyBreaks);
begin
  FBreakTimes.Assign(Value);
end;

procedure T8WorkTimeRule.SetDailyBeginTime(const Value: TTime);
begin
  FDailyBeginTime := Frac(Value);
end;

procedure T8WorkTimeRule.SetDailyFinishTime(const Value: TTime);
begin
  FDailyFinishTime := Frac(Value);
end;

procedure T8WorkTimeRule.SetExtraHoliDays(const Value: TStrings);
begin
  FExtraHoliDays.Assign(Value);
end;

procedure T8WorkTimeRule.SetExtraWorkDays(const Value: TStrings);
begin
  FExtraWorkDays.Assign(Value);
end;

{ Tc8TrackerMemento }

procedure Tc8TrackerMemento.Assign(Source: TPersistent);
begin
  if not(Source is Tc8TrackerMemento) then Exit;
  Stories := Tc8TrackerMemento(Source).Stories;
  Schedules := Tc8TrackerMemento(Source).Schedules;
end;

constructor Tc8TrackerMemento.Create(AOwner: TComponent);
begin
  inherited;
  FStories := T8UserStories.Create(Self, T8UserStory);
  FSchedules := T8PGSchedules.Create(Self, T8PGSchedule);
end;

destructor Tc8TrackerMemento.Destroy;
begin
  FreeAndNil(FSchedules);
  FreeAndNil(FStories);
  inherited;
end;

procedure Tc8TrackerMemento.SetSchedules(const Value: T8PGSchedules);
begin
  FSchedules.Assign(Value);
end;

procedure Tc8TrackerMemento.SetStories(const Value: T8UserStories);
begin
  FStories.Assign(Value);
end;

{ Tc8TrackerOptions }

procedure Tc8TrackerOptions.Assign(Source: TPersistent);
begin
  if not(Source is Tc8TrackerOptions) then Exit;
  FLastFileName := Tc8TrackerOptions(Source).LastFileName;
end;

constructor Tc8TrackerOptions.Create(AOwner: TComponent);
begin
  inherited;
  FWorkTimeRule := T8WorkTimeRule.Create;
end;

destructor Tc8TrackerOptions.Destroy;
begin
  FreeAndNil(FWorkTimeRule);
  inherited;
end;

procedure Tc8TrackerOptions.SetWorkTimeRule(const Value: T8WorkTimeRule);
begin
  FWorkTimeRule.Assign(Value);
end;

{ Tdm8TaskTracker }

function Tdm8TaskTracker.CalcWorkTime(ANow: TDateTime; var ANeed: Double;
  var AStart, AEnd: TDateTime): Boolean;
var
  lst: TDateTime;
begin
  Result := ANeed <= 1 / 24 / 60;
  if Result then Exit;
  ANow := Self.GetNextStartTime(ANow);
  lst := Self.GetNextBreakTime(ANow);
  //
  AStart := ANow;
  if ANeed < (lst - ANow) * 24 then
    AEnd := AStart + ANeed / 24
  else
    AEnd := lst;
  ANeed := ANeed - (AEnd - AStart) * 24;
end;

constructor Tdm8TaskTracker.Create(AOwner: TComponent);
begin
  inherited;
  FMemento := Tc8TrackerMemento.Create(nil);
  FTaskView := TObjectList.Create(False);
  FOptions := Tc8TrackerOptions.Create(nil);
end;

destructor Tdm8TaskTracker.Destroy;
begin
  FreeAndNil(FOptions);
  FreeAndNil(FTaskView);
  FreeAndNil(FMemento);
  inherited;
end;

function Tdm8TaskTracker.GetNextBreakTime(ANow: TDateTime): TDateTime;
var
  i: Integer;
begin
  Result := Options.WorkTimeRule.GetNextBreakTime(ANow);
  for i := 0 to Schedules.Count -1 do
    if Schedules[i].InTime(Result) then
    begin
      Result := Schedules[i].BeginDate;
      Exit;
    end;
end;

function Tdm8TaskTracker.GetNextStartTime(ANow: TDateTime): TDateTime;
var
  i: Integer;
begin
  Result := Options.WorkTimeRule.GetNextStartTime(ANow);
  for i := 0 to Schedules.Count -1 do
    if Schedules[i].InTime(Result) then
    begin
      Result := Schedules[i].EndDate;
      Exit;
    end;
end;

function Tdm8TaskTracker.GetSchedules: T8PGSchedules;
begin
  Result := FMemento.Schedules;
end;

function Tdm8TaskTracker.GetStories: T8UserStories;
begin
  Result := FMemento.Stories;
end;

procedure Tdm8TaskTracker.LoadFromFile;
var
  fs: TFileStream;
  compo: TComponent;
begin
  if not FileExists(Options.LastFileName) then Exit;
  fs := TFileStream.Create(Options.LastFileName, fmOpenRead or fmShareDenyNone);
  try
    compo := fs.ReadComponent(nil);
    try
      if not(compo is Tc8TrackerMemento) then Exit;
      FMemento.Assign(compo);
    finally
      FreeAndNil(compo);
    end;
  finally
    FreeAndNil(fs);
  end;
end;

procedure Tdm8TaskTracker.ReClacSchedules;
  procedure ClearNtoCompletedProgSchedules;
  var
    i: Integer;
  begin
    for i := Schedules.Count -1 downto 0 do
    begin
      if not(Schedules[i].ScheduleKind in [k8pgskNone, k8pgskProg]) then Continue;
      if Schedules[i].Task <> nil then
      begin
        if not Schedules[i].Task.Completed then
          Schedules.Delete(i);
      end
      else
        Schedules.Delete(i);
    end;
  end;
  procedure GetNotCompletedTasks(Dest: TObjectList);
  var
    i, j: Integer;
  begin
    for i := 0 to Stories.Count -1 do
      for j := 0 to Stories[i].Tasks.Count -1 do
        if not Stories[i].Tasks[j].Completed then
          Dest.Add(Stories[i].Tasks[j]);
  end;
var
  i: Integer;
  curTime: TDateTime;
  estTime: Double;
  tsk: T8PGTask;
  sch: T8PGSchedule;
  startTime, endTime: TDateTime;
  tskList: TObjectList;
begin
  Schedules.BeginUpdate;
  try
    ClearNtoCompletedProgSchedules;
    tskList := TObjectList.Create(False);
    try
      GetNotCompletedTasks(tskList);
      curTime := Now;
      for i := 0 to tskList.Count -1 do
      begin
        tsk := T8PGTask(tskList.Items[i]);
        if tsk.Completed then Continue;
        estTime := tsk.Estimate;
        CalcWorkTime(curTime, estTime, startTime, endTime);
        repeat
          sch := Schedules.Add(tsk.TaskID);
          sch.BeginDate := startTime;
          sch.EndDate := endTime;
          sch.ScheduleName := tsk.TaskName;
          sch.ScheduleKind := k8pgskProg;
          curTime := endTime;
        until CalcWorkTime(curTime, estTime, startTime, endTime);
      end;
      Schedules.SortByDateTime;
    finally
      FreeAndNil(tskList);
    end;
  finally
    Schedules.EndUpdate;
  end;
end;

procedure Tdm8TaskTracker.SaveToFile;
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(Options.LastFileName, fmCreate or fmShareDenyNone);
  try
    fs.WriteComponent(FMemento);
  finally
    FreeAndNil(fs);
  end;
end;

procedure Tdm8TaskTracker.SetMemento(const Value: Tc8TrackerMemento);
begin
  FMemento.Assign(Value);
end;

procedure Tdm8TaskTracker.SetOptions(const Value: Tc8TrackerOptions);
begin
  FOptions.Assign(Value);
end;

procedure Tdm8TaskTracker.SetTaskViewStory(const Value: T8UserStory);
var
  i: Integer;
begin
  FTaskView.Clear;
  if Value = nil then Exit;
  for i := 0 to Value.Tasks.Count -1 do
    FTaskView.Add(Value.Tasks[i]);
end;

procedure Tdm8TaskTracker.s0IniPropStocker1InitItems(Sender: TObject);
begin
  s0IniPropStocker1.Items.AddAllProp(FOptions, k0ialInstance);
end;

initialization
  RegisterClass(T8PGTask);
  RegisterClass(T8UserStory);
  RegisterClass(T8PGSchedule);
  RegisterClass(T8DialyBreak);
  RegisterClass(T8WorkTimeRule);
  RegisterClass(Tc8TrackerMemento);
  RegisterClass(Tc8TrackerOptions);

end.
