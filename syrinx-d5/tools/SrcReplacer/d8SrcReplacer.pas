unit d8SrcReplacer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ObjPropStocker, s0IniPropStocker, s0FormEventPublisher, s0FileFinder,
  Contnrs,
  u0SXSeqThread,
  s0Collection,
  s0FileCollections;

type
  T8ReplaceString = class(Ts0CollectionItem)
  private
    FEnabled: Boolean;
    FFindStr: string;
    FReplaceStr: string;
    procedure SetEnabled(const Value: Boolean);
    procedure SetFindStr(const Value: string);
    procedure SetReplaceStr(const Value: string);
  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    function MatchText(AText: string): Boolean;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property FindStr: string read FFindStr write SetFindStr;
    property ReplaceStr: string read FReplaceStr write SetReplaceStr;
  end;

type
  T8ReplaceStrings = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): T8ReplaceString;
    procedure SetItems(const Index: Integer; const Value: T8ReplaceString);
  public
    function Add(AFindStr, AReplaceStr: string): T8ReplaceString;
    function ExecReplace(AText: string): string;
    function IsMatched(AText: string): Boolean;
    procedure LoadFromSL(Source: TStrings);
    procedure SaveToSL(Source: TStrings);
    procedure GetItemNameAndValues(Dest: TStrings);
    property Items[const Index: Integer]: T8ReplaceString read GetItems write SetItems; default;
  end;


type
  T8FileColDir = class(Ts0FileColDir)
  private
    FEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
  public
    constructor Create(ACollection: TCollection); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

type
  T8FileColFile = class(Ts0FileColFile)
  private
    FEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
  public
    constructor Create(ACollection: TCollection); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

type
  T8FileColLine = class(Ts0FileColItem)
  private
    FPosition: Integer;
    FParentFile: Ts0FileColFile;
    FEnabled: Boolean;
    FText: string;
    FReplaced: string;
    procedure SetEnabled(const Value: Boolean);
  protected
    function FindSubCollection: Ts0FileColItems; override;
    function GetCaption: String; override;
    function GetIdentifier: string; override;
    function GetParentItem: Ts0FileColItem; override;
  public
    constructor Create(ACollection: TCollection); override;
  published
    property ParentFile: Ts0FileColFile read FParentFile;
    property Position: Integer read FPosition;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Text: string read FText;
    property Replaced: string read FReplaced;
  end;

type
  T8FileColLines = class(Ts0FileColItems)
  private
    function GetLines(const Index: Integer): T8FileColLine;
    procedure SetLines(const Index: Integer; const Value: T8FileColLine);
  protected
    procedure NotifyItemRemove(AItemOwner: Ts0FileColItems; AItem: Ts0FileColItem); override;
  public
    function AddLines(AFile: Ts0FileColFile; APosition: Integer; AText, AReplaced: string): T8FileColLine;
    function FindLines(AFile: Ts0FileColFile; APosition: Integer): T8FileColLine;
    property Lines[const Index: Integer]: T8FileColLine read GetLines write SetLines; default;
  end;

type
  Tc8FileCollections = class(Ts0FileCollections)
  private
    FLines: T8FileColLines;
    procedure SetLines(const Value: T8FileColLines);
  protected
    function NewDirCollection: Ts0FileColDirs; override;
    function NewFileCollection: Ts0FileColFiles; override;
    function NewLines: T8FileColLines;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Lines: T8FileColLines read FLines write SetLines;
  end;

type
  Tdm8SrcReplacer = class(TDataModule)
    s0FileFinder1: Ts0FileFinder;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0IniPropStocker1: Ts0IniPropStocker;
    procedure DataModuleCreate(Sender: TObject);
  private
    FReplaceStrings: T8ReplaceStrings;
    FTargets: Tc8FileCollections;
    FThreadRunning: Boolean;
    FThreadEvent: K0SeqThreadEvent;
    FOnThreadTerminated: TNotifyEvent;
  protected
    procedure ThreadTerminated(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeEnabled(AFileName: string);
    procedure ExecReplace;
    procedure FindBeforeReplace;
    procedure FindFiles;
    procedure LoadFileNames(AFileNames: TStrings);
    procedure LoadReplaceStrings(AFileName: string);
    procedure SaveReplaceStrings(AFileName: string);
    procedure ReplaceFileNames;
    property ReplaceStrings: T8ReplaceStrings read FReplaceStrings;
    property Targets: Tc8FileCollections read FTargets;
    property ThreadRunning: Boolean read FThreadRunning;
    property ThreadEvent: K0SeqThreadEvent read FThreadEvent write FThreadEvent;
    property OnThreadTerminated: TNotifyEvent read FOnThreadTerminated write FOnThreadTerminated;
  end;

var
  dm8SrcReplacer: Tdm8SrcReplacer;

implementation

uses
  s0FileHelper;

{$R *.DFM}

{ T8ReplaceString }

procedure T8ReplaceString.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T8ReplaceString) then Exit;
  Enabled    := T8ReplaceString(Source).FEnabled;
  FindStr    := T8ReplaceString(Source).FFindStr;
  ReplaceStr := T8ReplaceString(Source).FReplaceStr;
end;

constructor T8ReplaceString.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
end;

function T8ReplaceString.MatchText(AText: string): Boolean;
begin
  Result := AnsiPos(FFindStr, AText) > 0;
end;

procedure T8ReplaceString.SetEnabled(const Value: Boolean);
begin
  if FEnabled = Value then Exit;
  FEnabled := Value;
  Changed(False);
end;

procedure T8ReplaceString.SetFindStr(const Value: string);
begin
  if FFindStr = Value then Exit;
  FFindStr := Value;
  Changed(False);
end;

procedure T8ReplaceString.SetReplaceStr(const Value: string);
begin
  if FReplaceStr = Value then Exit;
  FReplaceStr := Value;
  Changed(False);
end;

{ T8ReplaceStrings }

function T8ReplaceStrings.Add(AFindStr, AReplaceStr: string): T8ReplaceString;
begin
  Result := T8ReplaceString(inherited Add);
  Result.FindStr := AFindStr;
  Result.ReplaceStr := AReplaceStr;
end;

function T8ReplaceStrings.ExecReplace(AText: string): string;
var
  i: Integer;
begin
  Result := AText;
  for i := 0 to Self.Count -1 do
    Result := StringReplace(Result, Items[i].FindStr, Items[i].ReplaceStr, [rfReplaceAll, rfIgnoreCase]);
end;

procedure T8ReplaceStrings.GetItemNameAndValues(Dest: TStrings);
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    if Items[i].FindStr = '' then Exit;
    Dest.Values[ Items[i].FindStr ] := Items[i].ReplaceStr;
  end;
end;

function T8ReplaceStrings.GetItems(const Index: Integer): T8ReplaceString;
begin
  Result := T8ReplaceString(inherited Items[Index]);
end;

function T8ReplaceStrings.IsMatched(AText: string): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Self.Count -1 do
    if Items[i].MatchText(AText) then
      Exit;
  Result := False;
end;

procedure T8ReplaceStrings.LoadFromSL(Source: TStrings);
var
  i: Integer;
begin
  BeginUpdate;
  try
    Self.Clear;
    for i := 0 to Source.Count -1 do
      Self.Add(Source.Names[i], Source.Values[Source.Names[i]]);
  finally
    EndUpdate;
  end;
end;

procedure T8ReplaceStrings.SaveToSL(Source: TStrings);
begin

end;

procedure T8ReplaceStrings.SetItems(const Index: Integer;
  const Value: T8ReplaceString);
begin
  inherited Items[Index] := Value;
end;


{ T8FileColDir }

constructor T8FileColDir.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
end;

procedure T8FileColDir.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

{ T8FileColFile }

constructor T8FileColFile.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
end;

procedure T8FileColFile.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

{ T8FileColLine }

constructor T8FileColLine.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
end;

function T8FileColLine.FindSubCollection: Ts0FileColItems;
begin
  Result := nil;
end;

function T8FileColLine.GetCaption: String;
begin
  Result := IntToStr(FPosition);
end;

function T8FileColLine.GetIdentifier: string;
begin
  if FParentFile <> nil then
    Result := Caption +': '+  FParentFile.Identifier
  else
    Result := Caption;
end;

function T8FileColLine.GetParentItem: Ts0FileColItem;
begin
  Result := FParentFile;
end;

procedure T8FileColLine.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

{ T8FileColLines }

function T8FileColLines.AddLines(AFile: Ts0FileColFile; APosition: Integer;
  AText, AReplaced: string): T8FileColLine;
begin
  Result := FindLines(AFile, APosition);
  if Result <> nil then
  begin
    Result.FText := AText;
    Exit;
  end;
  Result := T8FileColLine(inherited Add);
  Result.FPosition := APosition;
  Result.FParentFile := AFile;
  Result.FText := AText;
  Result.FReplaced := AReplaced;
end;

function T8FileColLines.FindLines(AFile: Ts0FileColFile;
  APosition: Integer): T8FileColLine;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Lines[i];
    if (Result.ParentFile = AFile) and (Result.Position = APosition) then Exit;
  end;
  Result := nil;
end;

function T8FileColLines.GetLines(const Index: Integer): T8FileColLine;
begin
  Result := T8FileColLine(inherited Items[Index]);
end;

procedure T8FileColLines.NotifyItemRemove(AItemOwner: Ts0FileColItems;
  AItem: Ts0FileColItem);
var
  i: Integer;
begin
  if not(AItem is Ts0FileColFile) then Exit;
  for i := Self.Count -1 downto 0 do
  begin
    if Lines[i].ParentFile = AItem then
      Delete(i);
  end;
end;

procedure T8FileColLines.SetLines(const Index: Integer;
  const Value: T8FileColLine);
begin
  inherited Items[Index] := Value;
end;

{ Tc8FileCollections }

constructor Tc8FileCollections.Create(AOwner: TComponent);
begin
  inherited;
  FLines := NewLines;
end;

destructor Tc8FileCollections.Destroy;
begin
  FreeAndNil(FLines);
  inherited;         
end;

function Tc8FileCollections.NewDirCollection: Ts0FileColDirs;
begin
  Result := Ts0FileColDirs.Create(Self, T8FileColDir);
end;

function Tc8FileCollections.NewFileCollection: Ts0FileColFiles;
begin
  Result := Ts0FileColFiles.Create(Self, T8FileColFile);
end;

function Tc8FileCollections.NewLines: T8FileColLines;
begin
  Result := T8FileColLines.Create(Self, T8FileColLine);
end;

procedure Tc8FileCollections.SetLines(const Value: T8FileColLines);
begin
  FLines.Assign(Value);
end;

{ Tdm8SrcReplacer }

constructor Tdm8SrcReplacer.Create(AOwner: TComponent);
begin
  inherited;
  FReplaceStrings := T8ReplaceStrings.Create(Self, T8ReplaceString);
  s0IniPropStocker1.Items.AddAllProp(s0FileFinder1, k0ialInstance);
  s0IniPropStocker1.Items.Remove( s0IniPropStocker1.Items.FindItem(s0FileFinder1, 'Tag') );
  s0IniPropStocker1.Items.Remove( s0IniPropStocker1.Items.FindItem(s0FileFinder1, 'Active') );
  s0IniPropStocker1.Items.Remove( s0IniPropStocker1.Items.FindItem(s0FileFinder1, 'AttrMask') );
  FTargets := Tc8FileCollections.Create(nil);
end;

destructor Tdm8SrcReplacer.Destroy;
begin
  FreeAndNil(FTargets);
  FreeAndNil(FReplaceStrings);
  inherited;
end;

procedure Tdm8SrcReplacer.FindFiles;
begin
  s0FileFinder1.ResultList.Clear;
  s0FileFinder1.Search;
  LoadFileNames(s0FileFinder1.ResultList);
end;

procedure Tdm8SrcReplacer.LoadFileNames(AFileNames: TStrings);
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Assign(AFileNames);
    sl.Sort;
    FTargets.Files.Clear;
    for i := 0 to sl.Count -1 do
      FTargets.Files.AddFile(sl.Strings[i]);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Tdm8SrcReplacer.LoadReplaceStrings(AFileName: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(AFileName);
    sl.Sort;
    ReplaceStrings.LoadFromSL(sl);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Tdm8SrcReplacer.SaveReplaceStrings(AFileName: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    ReplaceStrings.GetItemNameAndValues(sl);
    sl.SaveToFile(AFileName);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Tdm8SrcReplacer.DataModuleCreate(Sender: TObject);
begin
  s0FileFinder1.AttrMask := [k0faReadOnly, k0faHidden, k0faSysFile, k0faVolumeID, k0faArchive];
  s0FileFinder1.Masks.CommaText := '"*.pas","*.dfm","*.dpr"';
end;

procedure Tdm8SrcReplacer.ChangeEnabled(AFileName: string);
var
  f: Ts0FileColFile;
begin
  f := FTargets.Files.FindFile(AFileName);
  if not(f is T8FileColFile) then Exit;
  T8FileColFile(f).Enabled := not T8FileColFile(f).Enabled;
end;

type
  T9FindBeforeReplace = class(T0SXSeqThread)
  private
    FReplaceStrings: T8ReplaceStrings;
    FTargets: Tc8FileCollections;
  protected
    procedure ExecuteSequence; override;
    procedure Execute; override;
  end;

procedure Tdm8SrcReplacer.FindBeforeReplace;
var
  thrd: T9FindBeforeReplace;
begin
  FThreadRunning := True;
  Targets.FLines.BeginUpdate;
  Targets.FLines.Clear;
  thrd := T9FindBeforeReplace.Create;
  thrd.FreeOnTerminate := True;
  thrd.OnTerminate := ThreadTerminated;
  thrd.OnStep := FThreadEvent;
  thrd.FReplaceStrings := Self.ReplaceStrings;
  thrd.FTargets := Self.Targets;
  thrd.Resume;
end;

type
  T9ExecReplace = class(T0SXSeqThread)
  private
    FReplaceStrings: T8ReplaceStrings;
    FTargets: Tc8FileCollections;
    FText: TStringList;
    FFile: Ts0FileColFile;
  protected
    procedure ExecuteSequence; override;
    procedure Execute; override;
  end;

procedure Tdm8SrcReplacer.ExecReplace;
var
  thrd: T9ExecReplace;
begin
  FThreadRunning := True;
  Targets.Lines.BeginUpdate;
  thrd := T9ExecReplace.Create;
  thrd.FreeOnTerminate := True;
  thrd.OnTerminate := ThreadTerminated;
  thrd.OnStep := FThreadEvent;
  thrd.FReplaceStrings := Self.ReplaceStrings;
  thrd.FTargets := Self.Targets;
  thrd.Resume;
end;

procedure Tdm8SrcReplacer.ThreadTerminated(Sender: TObject);
begin
  if Targets.FLines.UpdateCount > 0 then
    Targets.FLines.EndUpdate;
  FThreadRunning := False;
  if Assigned(FOnThreadTerminated) then
    FOnThreadTerminated(Self);
end;

type
  T9ReplaceFileNames = class(T0SXSeqThread)
  private
    FReplaceStrings: T8ReplaceStrings;
    FTargets: Tc8FileCollections;
  protected
    procedure ExecuteSequence; override;
    procedure Execute; override;
  end;

procedure Tdm8SrcReplacer.ReplaceFileNames;
var
  thrd: T9ReplaceFileNames;
begin
  FThreadRunning := True;
  thrd := T9ReplaceFileNames.Create;
  thrd.FreeOnTerminate := True;
  thrd.OnTerminate := ThreadTerminated;
  thrd.OnStep := FThreadEvent;
  thrd.FReplaceStrings := Self.ReplaceStrings;
  thrd.FTargets := Self.Targets;
  thrd.Resume;
end;

{ T9FindBeforeReplace }

procedure T9FindBeforeReplace.Execute;
begin
  FSeqCount := FTargets.Files.Count;
  FSeqIndex := 0;
  inherited;
end;

procedure T9FindBeforeReplace.ExecuteSequence;
var
  i, j: Integer;
  sl: TStringList;
  s: string;
begin
  i := FSeqIndex;
  Inc(FSeqIndex);
  //
  if not T8FileColFile(FTargets.Files[i]).Enabled then Exit;
  sl := TStringList.Create;
  try
    sl.LoadFromFile(FTargets.Files[i].Identifier);
    for j := 0 to sl.Count -1 do
    begin
      s := sl.Strings[j];
      if not FReplaceStrings.IsMatched(s) then Continue;
      FTargets.Lines.AddLines(
        FTargets.Files[i], j, s,
        FReplaceStrings.ExecReplace(s)
        );
    end;
  finally
    FreeAndNil(sl);
  end;
end;

{ T9ExecReplace }

procedure T9ExecReplace.Execute;
begin
  FSeqCount := FTargets.Lines.Count;
  FSeqIndex := 0;
  FFile := nil;
  FText := TStringList.Create;
  try
    inherited;
    if FFile <> nil then
      FText.SaveToFile(FFile.Identifier);
  finally
    FreeAndNil(FText);
  end;
end;

procedure T9ExecReplace.ExecuteSequence;
var
  i: Integer;
  line: T8FileColLine;
begin
  i := FSeqIndex;
  Inc(FSeqIndex);
  //
  line := FTargets.Lines[i];
  if FFile <> line.ParentFile then
  begin
    if FFile <> nil then
    begin
      FText.SaveToFile(FFile.Identifier);
      FFile := nil;
    end;
    FFile := line.ParentFile;
    FText.LoadFromFile(FFile.Identifier);
  end;
  FText.Strings[line.Position] := line.Replaced;
end;

{ T9ReplaceFileNames }

procedure T9ReplaceFileNames.Execute;
begin
  FSeqCount := FTargets.Files.Count;
  FSeqIndex := 0;
  inherited;     
end;

procedure T9ReplaceFileNames.ExecuteSequence;
var
  i: Integer;
  oldFN, newFN: string;
begin
  i := FSeqIndex;
  Inc(FSeqIndex);
  oldFN := FTargets.Files[i].Identifier;
  newFN := FReplaceStrings.ExecReplace(oldFN);
  if AnsiSameText(newFN, oldFN) then Exit;
  if FileExists(newFN) then
    DeleteFile(newFN);
  RenameFile(oldFN, newFN);
end;

end.
