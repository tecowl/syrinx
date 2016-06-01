unit s0DofChange;

interface

uses
  SysUtils, Classes,
  s0Persistent,
  s0Collection;

type
  Ts0DofItem = class(Ts0CollectionItem)
  private
    FValue: string;
    FIdentName: string;
    FSectionName: string;
    procedure SetIdentName(const Value: string);
    procedure SetSectionName(const Value: string);
    procedure SetValue(const Value: string);
  protected
    function GetDisplayName: string; override;
  published
    property SectionName: string read FSectionName write SetSectionName;
    property IdentName: string read FIdentName write SetIdentName;
    property Value: string read FValue write SetValue;
  end;

type
  Ts0DofItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0DofItem;
    procedure SetItems(const Index: Integer; const Value: Ts0DofItem);
  public
    function Add: Ts0DofItem;
    function FindItem(ASection, AIdent: string): Ts0DofItem;
    property Items[const Index: Integer]: Ts0DofItem read GetItems write SetItems;
  end;

type
  Ts0DofChangeAction = class(Ts0DofItem)
  private
    FChangeType: string;
    procedure SetChangeType(const Value: string);
  public
    constructor Create(ACollection: TCollection); override;
    procedure ExecuteBy(ADof: TFileName);
  published
    property ChangeType: string read FChangeType write SetChangeType;
  published
    procedure Execute;
  end;

type
  Ts0DofChangeActions = class(Ts0DofItems)
  private
    function GetActions(const Index: Integer): Ts0DofChangeAction;
    procedure SetActions(const Index: Integer; const Value: Ts0DofChangeAction);
  public
    function Add: Ts0DofChangeAction;
    property Actions[const Index: Integer]: Ts0DofChangeAction read GetActions write SetActions; default;
  end;

type
  Ts0CfgChangeAction = class(Ts0CollectionItem)
  private
    FValue: string;
    FHeader: String;
    procedure SetHeader(const Value: String);
    procedure SetValue(const Value: string);
  public
    procedure ExecuteBy(ADof: TFileName);
  published
    property Header: String read FHeader write SetHeader;
    property Value: string read FValue write SetValue;
  published
    procedure Execute;
  end;

type
  Ts0CfgChangeActions = class(Ts0Collection)
  private
    function GetActions(const Index: Integer): Ts0CfgChangeAction;
    procedure SetActions(const Index: Integer;
      const Value: Ts0CfgChangeAction);
  public
    function Add: Ts0CfgChangeAction;
    property Actions[const Index: Integer]: Ts0CfgChangeAction read GetActions write SetActions; default;
  end;

type
  Ts0ChangProj = class(Ts0CollectionItem)
  private
    FDofActions: Ts0DofChangeActions;
    FFileName: string;
    FTargets: TStrings;
    FCfgActions: Ts0CfgChangeActions;
    procedure SetDofActions(const Value: Ts0DofChangeActions);
    procedure SetFileName(const Value: string);
    procedure SetTargets(const Value: TStrings);
    procedure SetCfgActions(const Value: Ts0CfgChangeActions);
  protected
    function GetDisplayName: string; override;
    function GetSubCollection: Ts0Collection; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property FileName: string read FFileName write SetFileName;
    property Targets: TStrings read FTargets write SetTargets;
    property DofActions: Ts0DofChangeActions read FDofActions write SetDofActions;
    property CfgActions: Ts0CfgChangeActions read FCfgActions write SetCfgActions;
  published
    procedure ExecuteActions;
    procedure LoadFromFile;
    procedure SaveToFile;
  end;

type
  Ts0ChangProjects = class(Ts0Collection)
  private
    function GetProjects(const Index: Integer): Ts0ChangProj;
    procedure SetProjects(const Index: Integer;
      const Value: Ts0ChangProj);
  public
    function Add(AFileName: string; ALoadFromFile: Boolean = True): Ts0ChangProj;
    property Projects[const Index: Integer]: Ts0ChangProj read GetProjects write SetProjects; default;
  end;

type
  Ts0DofChangerMain = class(TComponent)
  private
    FProjects: Ts0ChangProjects;
    procedure SetProjects(const Value: Ts0ChangProjects);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function Instance: Ts0DofChangerMain;
  published
    property Projects: Ts0ChangProjects read FProjects write SetProjects;
  published
    procedure SaveProjects;
  end;       

type
  Ts0CustomItemChangerClass = class of Ts0CustomItemChanger;
  Ts0CustomItemChanger = class
  private
  protected
    function GetChangeType: string; virtual;
    procedure Execute(ADof: TFileName; Action: Ts0DofChangeAction); virtual;
  public
    property ChangeType: string read GetChangeType;
    class function FindChanger(AType: string): Ts0CustomItemChanger;
    class procedure GetChangerTypes(Dest: TStrings);
    class procedure RegisterChanger(AChanger: Ts0CustomItemChangerClass; IsDefault: Boolean = False);
    class procedure UnRegisterChanger(AChanger: Ts0CustomItemChangerClass);
  end;

type
  Ts0ValueOverwrite = class(Ts0CustomItemChanger)
  protected
    function GetChangeType: string; override;
    procedure Execute(ADof: TFileName; Action: Ts0DofChangeAction); override;
  end;

implementation

uses       
  IniFiles,
  s0Iterator,
  s0ObjCSVReader,
  s0ObjCSVWriter,
  Contnrs;

{ Ts0DofItem }

function Ts0DofItem.GetDisplayName: string;
begin
  Result := FSectionName +'.'+ FIdentName +'='+ FValue;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

procedure Ts0DofItem.SetIdentName(const Value: string);
begin
  FIdentName := Value;
end;

procedure Ts0DofItem.SetSectionName(const Value: string);
begin
  FSectionName := Value;
end;

procedure Ts0DofItem.SetValue(const Value: string);
begin
  FValue := Value;
end;

{ Ts0DofItems }

function Ts0DofItems.Add: Ts0DofItem;
begin
  Result := Ts0DofItem(inherited Add);
end;

function Ts0DofItems.FindItem(ASection, AIdent: string): Ts0DofItem;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Self.Items[i];
    if SameText(Result.SectionName, ASection) and
      SameText(Result.IdentName, AIdent) then Exit;
  end;
  Result := nil;
end;

function Ts0DofItems.GetItems(const Index: Integer): Ts0DofItem;
begin
  Result := Ts0DofItem(inherited Items[Index]);
end;

procedure Ts0DofItems.SetItems(const Index: Integer;
  const Value: Ts0DofItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0DofChangeAction }

var
  g9DefaultChangeType: string;

constructor Ts0DofChangeAction.Create(ACollection: TCollection);
begin
  inherited;
  FChangeType := g9DefaultChangeType;
end;

procedure Ts0DofChangeAction.Execute;
var
  proj: Ts0ChangProj;
  i: Integer;
begin
  Assert(OwnerObj is Ts0ChangProj);
  proj := Ts0ChangProj(OwnerObj);
  for i := 0 to proj.Targets.Count -1 do
    ExecuteBy(proj.Targets.Strings[i]);
end;

procedure Ts0DofChangeAction.ExecuteBy(ADof: TFileName);
var
  changer: Ts0CustomItemChanger;
begin
  changer := Ts0CustomItemChanger.FindChanger(FChangeType);
  if changer = nil then Exit;
  changer.Execute(ADof, Self);
end;

procedure Ts0DofChangeAction.SetChangeType(const Value: string);
begin
  FChangeType := Value;
end;

{ Ts0DofChangeActions }

function Ts0DofChangeActions.Add: Ts0DofChangeAction;
begin
  Result := Ts0DofChangeAction(inherited Add);
end;

function Ts0DofChangeActions.GetActions(const Index: Integer): Ts0DofChangeAction;
begin
  Result := Ts0DofChangeAction(inherited Items[Index]);
end;

procedure Ts0DofChangeActions.SetActions(const Index: Integer;
  const Value: Ts0DofChangeAction);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CfgChangeAction }

procedure Ts0CfgChangeAction.Execute;
var
  proj: Ts0ChangProj;
  i: Integer;
begin
  Assert(OwnerObj is Ts0ChangProj);
  proj := Ts0ChangProj(OwnerObj);
  for i := 0 to proj.Targets.Count -1 do
    ExecuteBy(proj.Targets.Strings[i]);
end;

procedure Ts0CfgChangeAction.ExecuteBy(ADof: TFileName);
  function IndexOfHeader(AList: TStrings): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to AList.Count -1 do
      if Pos('-'+ Header, AList.Strings[i]) = 1 then
      begin
        Result := i;
        Exit;
      end;
  end;
var
  sl: TStringList;
  idx: Integer;
  fn: string;
begin
  sl := TStringList.Create;
  try
    fn := ChangeFileExt(ADof, '.cfg');
    if FileExists(fn) then 
      sl.LoadFromFile( fn );
    idx := IndexOfHeader(sl);
    if idx < 0 then
      sl.Add('-'+ Header + Value)
    else
      sl.Strings[idx] := '-'+ Header + Value;
    sl.Sort;
    sl.SaveToFile(fn);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0CfgChangeAction.SetHeader(const Value: String);
begin
  FHeader := Value;
end;

procedure Ts0CfgChangeAction.SetValue(const Value: string);
begin
  FValue := Value;
end;

{ Ts0CfgChangeActions }

function Ts0CfgChangeActions.Add: Ts0CfgChangeAction;
begin
  Result := Ts0CfgChangeAction(inherited Add);
end;

function Ts0CfgChangeActions.GetActions(
  const Index: Integer): Ts0CfgChangeAction;
begin
  Result := Ts0CfgChangeAction(inherited Items[Index]);
end;

procedure Ts0CfgChangeActions.SetActions(const Index: Integer;
  const Value: Ts0CfgChangeAction);
begin
  inherited Items[Index] := Value;
end;

{ Ts0ChangProj }

constructor Ts0ChangProj.Create(ACollection: TCollection);
begin
  inherited;
  FTargets := TStringList.Create;
  FDofActions := Ts0DofChangeActions.Create(Self, Ts0DofChangeAction);
  FCfgActions := Ts0CfgChangeActions.Create(Self, Ts0CfgChangeAction);
end;

destructor Ts0ChangProj.Destroy;
begin
  FreeAndNil(FCfgActions);
  FreeAndNil(FDofActions);
  FreeAndNil(FTargets);
  inherited;
end;

procedure Ts0ChangProj.ExecuteActions;
var
  i: Integer;
begin
  for i := 0 to DofActions.Count -1 do
    DofActions[i].Execute;
  for i := 0 to CfgActions.Count -1 do
    CfgActions[i].Execute;
end;

function Ts0ChangProj.GetDisplayName: string;
begin
  Result := ExtractFileName( FFileName );
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function Ts0ChangProj.GetSubCollection: Ts0Collection;
begin
  Result := FDofActions;
end;

procedure Ts0ChangProj.LoadFromFile;
  procedure LoadFrom(Actions: Ts0Collection; AFileName: string);
  var
    reader: Ts0CollectionCSVReader;
    fs: TFileStream;
  begin
    if not FileExists(AFileName) then Exit;
    fs := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
    try
      reader := Ts0CollectionCSVReader.Create;
      try
        reader.TargetCollection := Actions;
        reader.ReadTitles := True;
        reader.Source := fs;
        reader.Execute;
      finally
        FreeAndNil(reader);
      end;
    finally
      FreeAndNil(fs);
    end;
  end;
begin
  FTargets.LoadFromFile(FFileName);
  //
  LoadFrom(FDofActions, ChangeFileExt(FileName, '.dofcsv'));
  LoadFrom(FCfgActions, ChangeFileExt(FileName, '.cfgcsv'));
end;

resourcestring
  c9FileNameIsNull = 'ファイル名が指定されていません';

procedure Ts0ChangProj.SaveToFile;
  procedure SaveTo(Actions: Ts0Collection; AFileName: string);
  var
    writer: Ts0ObjCSVWriter;
    fs: TFileStream;
    ite: Ts0CollectionIterator;
  begin
    fs := TFileStream.Create(AFileName, fmCreate or fmShareDenyNone);
    try
      writer := Ts0ObjCSVWriter.Create;
      try
        ite := Ts0CollectionIterator.Create(Actions);
        try
          writer.Source := ite;
          writer.AddAllPropsOf(Actions.ItemClass);
          writer.Dest := fs;
          writer.IncludeTitles := True;
          writer.Execute;
        finally
          FreeAndNil(ite);
        end;
      finally
        FreeAndNil(writer);
      end;
    finally
      FreeAndNil(fs);
    end;
  end;
begin
  if FFileName = '' then
    Exception.Create(c9FileNameIsNull);
  FTargets.SaveToFile(FFileName);
  //
  SaveTo(FDofActions, ChangeFileExt(FileName, '.dofcsv'));
  SaveTo(FCfgActions, ChangeFileExt(FileName, '.cfgcsv'));
end;

procedure Ts0ChangProj.SetCfgActions(const Value: Ts0CfgChangeActions);
begin
  FCfgActions := Value;
end;

procedure Ts0ChangProj.SetDofActions(const Value: Ts0DofChangeActions);
begin
  FDofActions.Assign(Value);
end;

procedure Ts0ChangProj.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure Ts0ChangProj.SetTargets(const Value: TStrings);
begin
  FTargets := Value;
end;

{ Ts0ChangProjects }

function Ts0ChangProjects.Add(AFileName: string; ALoadFromFile: Boolean): Ts0ChangProj;
begin
  Result := Ts0ChangProj(inherited Add);
  Result.FileName := AFileName;
  if ALoadFromFile then
    Result.LoadFromFile;
end;

function Ts0ChangProjects.GetProjects(
  const Index: Integer): Ts0ChangProj;
begin
  Result := Ts0ChangProj(inherited Items[Index]);
end;

procedure Ts0ChangProjects.SetProjects(const Index: Integer;
  const Value: Ts0ChangProj);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CustomItemChanger }

procedure Ts0CustomItemChanger.Execute(ADof: TFileName;
  Action: Ts0DofChangeAction);
begin
end;

var
  g9ChangerList: TObjectList;

class function Ts0CustomItemChanger.FindChanger(
  AType: string): Ts0CustomItemChanger;
var
  i: Integer;
begin
  Result := nil;
  if g9ChangerList = nil then Exit;
  for i := 0 to g9ChangerList.Count -1 do
  begin
    Result := Ts0CustomItemChanger(g9ChangerList.Items[i]);
    if SameText( Result.ChangeType, AType) then Exit;
  end;
  Result := nil;
end;

class procedure Ts0CustomItemChanger.GetChangerTypes(Dest: TStrings);
var
  i: Integer;
  changer: Ts0CustomItemChanger;
begin
  if g9ChangerList = nil then Exit;
  for i := 0 to g9ChangerList.Count -1 do
  begin
    changer := Ts0CustomItemChanger(g9ChangerList.Items[i]);
    Dest.Add(changer.ChangeType);
  end;
end;

function Ts0CustomItemChanger.GetChangeType: string;
begin
  Result := '';
end;

class procedure Ts0CustomItemChanger.RegisterChanger(
  AChanger: Ts0CustomItemChangerClass; IsDefault: Boolean);
var
  c: Ts0CustomItemChanger;
begin
  if g9ChangerList = nil then
    g9ChangerList := TObjectList.Create(True);
  c := AChanger.Create;
  g9ChangerList.Add( c );
  if IsDefault or (g9ChangerList.Count = 1) then
    g9DefaultChangeType := c.ChangeType;
end;

class procedure Ts0CustomItemChanger.UnRegisterChanger(
  AChanger: Ts0CustomItemChangerClass);
var
  i: Integer;
  obj: TObject;
begin
  for i := g9ChangerList.Count -1 downto 0 do
  begin
    obj := g9ChangerList.Items[i];
    if obj.ClassType = AChanger then
      g9ChangerList.Delete(i);
  end;
end;

{ Ts0ValueOverwrite }

procedure Ts0ValueOverwrite.Execute(ADof: TFileName;
  Action: Ts0DofChangeAction);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(ADof, '.dof'));
  try
    ini.WriteString(Action.SectionName, Action.IdentName, Action.Value);
  finally
    FreeAndNil(ini);
  end;
end;

function Ts0ValueOverwrite.GetChangeType: string;
begin
  Result := '値の上書き';
end;

{ Ts0DofChangerMain }

constructor Ts0DofChangerMain.Create(AOwner: TComponent);
begin
  inherited;
  FProjects := Ts0ChangProjects.Create(Self, Ts0ChangProj);
  Name := 'Root';
end;

destructor Ts0DofChangerMain.Destroy;
begin
  FreeAndNil(FProjects);
  inherited;
end;

var
  g9Main: Ts0DofChangerMain;

class function Ts0DofChangerMain.Instance: Ts0DofChangerMain;
begin
  if g9Main = nil then
    g9Main := Ts0DofChangerMain.Create(nil);
  Result := g9Main;
end;

procedure Ts0DofChangerMain.SaveProjects;
var
  i: Integer;
begin
  for i := 0 to Projects.Count -1 do
    Projects.Projects[i].SaveToFile;
end;

procedure Ts0DofChangerMain.SetProjects(const Value: Ts0ChangProjects);
begin
  FProjects.Assign(Value);
end;

initialization
  Ts0CustomItemChanger.RegisterChanger(Ts0ValueOverwrite, True);

finalization
  FreeAndNil(g9ChangerList);
  FreeAndNil(g9Main);

end.
