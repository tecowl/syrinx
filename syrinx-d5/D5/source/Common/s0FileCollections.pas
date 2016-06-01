{-----------------------------------------------------------------------------
 Unit Name: s0FileCollections
 Author:    akima
 Purpose:
 TestCase: tc_s0FileCollections
 $History: s0FileCollections.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/06   Time: 19:26
 * Updated in $/source/D6VCLIntegrated
 * IncludeTrailingBackslash、ExcludeTrailingBackslashを使用していた部分を
 * 、
 * s0FileNameHelperのIncludeTrailingPathDelimiter、ExcludeTrailingPathDeli
 * miter
 * 関数を使用するように変更。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/12/04   Time: 1:46
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/12/03   Time: 14:02
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/01   Time: 0:16
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0FileCollections;

interface

uses
  SysUtils, Classes,
  Contnrs,
  s0Collection;

type
  Ts0FileColItems = class;

  Ts0FileColItem = class(Ts0CollectionItem)
  private
  protected
    procedure FindChildren(Source: Ts0FileColItems; Dest: TObjectList);
    function FindSubCollection: Ts0FileColItems; virtual;
    function GetCaption: String; virtual;
    function GetParentItem: Ts0FileColItem; virtual;
  public
    property Caption: String read GetCaption;
    property ParentItem: Ts0FileColItem read GetParentItem;
  end;

  Ts0FileColItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0FileColItem;
    procedure SetItems(const Index: Integer; const Value: Ts0FileColItem);
  protected
    procedure NotifyItemDestroy(AItem: Ts0CollectionItem); override;
    procedure NotifyItemRemove(AItemOwner: Ts0FileColItems; AItem: Ts0FileColItem); virtual;
  public
    procedure SaveToSL(Dest: TStrings);
    property Items[const Index: Integer]: Ts0FileColItem read GetItems write SetItems;
  end;

type
  Ts0FileColDir = class(Ts0FileColItem)
  private
    FDirName: string;
    function GetParentDirName: string;
  protected
    function FindSubCollection: Ts0FileColItems; override;
    function GetCaption: String; override;
    function GetIdentifier: string; override;
    function GetParentItem: Ts0FileColItem; override;
  public
    procedure GetFiles(Dest: TObjectList);
    procedure GetSubDirs(Dest: TObjectList);
    property DirName: string read FDirName;
    property ParentDirName: string read GetParentDirName;
  end;

type
  Ts0FileColDirs = class(Ts0FileColItems)
  private
    function GetDirectories(const Index: Integer): Ts0FileColDir;
    procedure SetDirectories(const Index: Integer;
      const Value: Ts0FileColDir);
  protected
    procedure AddAncestors(ATopDir, AChildDir: string);
    function FindAncestor(ADirName: string): Ts0FileColDir;
    procedure NotifyItemRemove(AItemOwner: Ts0FileColItems; AItem: Ts0FileColItem); override;
  public
    function AddDir(ADirName: string): Ts0FileColDir;
    function AddDirWithParent(AParent: Ts0FileColDir; ADirName: string): Ts0FileColDir;
    function FindDir(ADirName: string): Ts0FileColDir;
    function IndexOfName(ADirName: string): Integer;
    property Directories[const Index: Integer]: Ts0FileColDir read GetDirectories write SetDirectories; default;
  end;

type
  Ts0FileColFile = class(Ts0FileColItem)
  private
    FFileName: TFileName;
    FParentDir: Ts0FileColDir;
  protected
    function GetCaption: String; override;
    function GetIdentifier: string; override;
    function GetParentItem: Ts0FileColItem; override;
  published
    property ParentDir: Ts0FileColDir read FParentDir;
    property FileName: TFileName read FFileName;
  end;

type
  Ts0FileColFiles = class(Ts0FileColItems)
  private
    function GetFiles(const Index: Integer): Ts0FileColFile;
    procedure SetFiles(const Index: Integer; const Value: Ts0FileColFile);
  protected
    procedure NotifyItemRemove(AItemOwner: Ts0FileColItems; AItem: Ts0FileColItem); override;
  public
    function AddFile(AFileName: string): Ts0FileColFile;
    function AddFileWithDir(ADir: Ts0FileColDir; AFileName: string): Ts0FileColFile;
    function FindFile(AFileName: string): Ts0FileColFile;
    function FindFileOfDir(ADir: Ts0FileColDir; AFileName: string): Ts0FileColFile;
    function IndexOfName(AFileName: string): Integer;
    property Files[const Index: Integer]: Ts0FileColFile read GetFiles write SetFiles; default;
  end;

type
  Ts0FileCollections = class(TComponent)
  private
    FDirs: Ts0FileColDirs;
    FFiles: Ts0FileColFiles;
    procedure SetDirs(const Value: Ts0FileColDirs);
    procedure SetFiles(const Value: Ts0FileColFiles);
  protected
    procedure ItemDestroyed(ACollection: Ts0FileColItems; AItem: Ts0FileColItem); virtual;
    function NewDirCollection: Ts0FileColDirs; virtual;
    function NewFileCollection: Ts0FileColFiles; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property Dirs: Ts0FileColDirs read FDirs write SetDirs;
    property Files: Ts0FileColFiles read FFiles write SetFiles;
  published
  end;

implementation

uses
  s0FileNameHelper;

{ Ts0FileColItem }

procedure Ts0FileColItem.FindChildren(Source: Ts0FileColItems; Dest: TObjectList);
var
  i: Integer;
begin
  for i := 0 to Source.Count -1 do
  begin
    if Source.Items[i].ParentItem = Self then
      Dest.Add(Source.Items[i]);
  end;
end;

function Ts0FileColItem.FindSubCollection: Ts0FileColItems;
begin
  Result := nil;
end;

function Ts0FileColItem.GetCaption: String;
begin

end;

function Ts0FileColItem.GetParentItem: Ts0FileColItem;
begin
  Result := nil;
end;

{ Ts0FileColItems }

function Ts0FileColItems.GetItems(const Index: Integer): Ts0FileColItem;
begin
  Result := Ts0FileColItem(inherited Items[Index]);
end;

procedure Ts0FileColItems.NotifyItemDestroy(AItem: Ts0CollectionItem);
begin
  inherited;
  if not(AItem is Ts0FileColItem) then Exit;
  if OwnerComponent is Ts0FileCollections then
    Ts0FileCollections(OwnerComponent).ItemDestroyed(
      Self, Ts0FileColItem(AItem)
    );
end;

procedure Ts0FileColItems.NotifyItemRemove(AItemOwner: Ts0FileColItems;
  AItem: Ts0FileColItem);
begin
end;

procedure Ts0FileColItems.SaveToSL(Dest: TStrings);
begin
end;

procedure Ts0FileColItems.SetItems(const Index: Integer;
  const Value: Ts0FileColItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0FileColDir }

procedure Ts0FileColDir.GetFiles(Dest: TObjectList);
begin
  FindChildren(FindSubCollection, Dest);
end;

function Ts0FileColDir.FindSubCollection: Ts0FileColItems;
begin
  Result := nil;
  if OwnerComponent is Ts0FileCollections then
    Result := Ts0FileCollections(OwnerComponent).Files;
end;

function Ts0FileColDir.GetCaption: String;
begin
  Result := ExtractFileName(FDirName);
end;

function Ts0FileColDir.GetIdentifier: string;
begin
  Result := FDirName; 
end;

procedure Ts0FileColDir.GetSubDirs(Dest: TObjectList);
begin
  if Collection is Ts0FileColDirs then
    FindChildren(Ts0FileColDirs(Collection), Dest);
end;

function Ts0FileColDir.GetParentItem: Ts0FileColItem;
var
  i: Integer;
begin
  Result := nil;
  if not(Collection is Ts0FileColDirs) then Exit;
  for i := 0 to Ts0FileColDirs(Collection).Count -1 do
  begin
    Result := Ts0FileColDirs(Collection).Directories[i];
    if not(Result is Ts0FileColDir) then Continue;
    if Ts0FileColDir(Result).DirName = Self.ParentDirName then Exit;
  end;
  Result := nil;
end;

function Ts0FileColDir.GetParentDirName: string;
begin
  Result := ExtractFileDir(FDirName);
end;

{ Ts0FileColDirs }

procedure Ts0FileColDirs.AddAncestors(ATopDir, AChildDir: string);
var
  d: string;
  drivePath: string;
begin
  ATopDir := ExcludeTrailingPathDelimiter(ATopDir);
  AChildDir := ExcludeTrailingPathDelimiter(AChildDir);
  if CompareText(ATopDir, AChildDir) = 0 then Exit;
  drivePath := ExtractFileDrive(AChildDir);
  AddDir(AChildDir);
  d := ExcludeTrailingPathDelimiter( ExtractFileDir(AChildDir) );
  while (d <> '') and (d <> drivePath) and (d <> ATopDir) do
  begin
    AddDir(d);
    d := ExcludeTrailingPathDelimiter( ExtractFileDir(d) );
  end;
end;

function Ts0FileColDirs.AddDir(ADirName: string): Ts0FileColDir;
var
  ancestor: Ts0FileColDir;
begin
  ADirName := ExcludeTrailingPathDelimiter(ADirName);
  Result := FindDir(ADirName);
  if Result <> nil then Exit;
  Result := Ts0FileColDir(inherited Add);
  Result.FDirName := ADirName;
  ancestor := FindAncestor(ADirName);
  if ancestor <> nil then
    AddAncestors(ancestor.DirName, Result.ParentDirName);
end;

function Ts0FileColDirs.AddDirWithParent(AParent: Ts0FileColDir;
  ADirName: string): Ts0FileColDir;
begin
  Result := nil;
  if AParent <> nil then Exit;
  
end;

function Ts0FileColDirs.FindAncestor(ADirName: string): Ts0FileColDir;
var
  d: string;
  drivePath: string;
begin
  ADirName := ExcludeTrailingPathDelimiter(ADirName);
  drivePath := ExtractFileDrive(ADirName);
  d := ADirName;
  repeat
    d := ExcludeTrailingPathDelimiter( ExtractFileDir(d) );
    Result := FindDir(d);
  until (d = '') or (d = drivePath)or (Result <> nil);
end;

function Ts0FileColDirs.FindDir(ADirName: string): Ts0FileColDir;
var
  idx: Integer;
begin
  Result := nil;
  idx := Self.IndexOfName(ADirName);
  if idx > -1 then
    Result := Directories[idx];
end;

function Ts0FileColDirs.GetDirectories(const Index: Integer): Ts0FileColDir;
begin
  Result := nil;
  if (inherited Items[Index]) is Ts0FileColDir then
    Result := Ts0FileColDir(inherited Items[Index]);
end;

function Ts0FileColDirs.IndexOfName(ADirName: string): Integer;
var
  i: Integer;
begin
  ADirName := ExcludeTrailingPathDelimiter(ADirName);
  for i := 0 to Self.Count -1 do
  begin
    Result := i;
    if CompareText(Directories[i].DirName, ADirName) = 0 then Exit;
  end;
  Result := -1;
end;

procedure Ts0FileColDirs.NotifyItemRemove(AItemOwner: Ts0FileColItems;
  AItem: Ts0FileColItem);
begin
end;

procedure Ts0FileColDirs.SetDirectories(const Index: Integer;
  const Value: Ts0FileColDir);
begin
  inherited Items[Index] := Value;
end;

{ Ts0FileColFile }

function Ts0FileColFile.GetCaption: String;
begin
  Result := Caption;
end;

function Ts0FileColFile.GetIdentifier: string;
begin
  Result := IncludeTrailingPathDelimiter(FParentDir.Identifier) + FileName;
end;

function Ts0FileColFile.GetParentItem: Ts0FileColItem;
begin
  Result := FParentDir;
end;

{ Ts0FileColFiles }                

function Ts0FileColFiles.AddFile(AFileName: string): Ts0FileColFile;
var
  d: Ts0FileColDir;
begin
  Result := nil;
  if not(OwnerComponent is Ts0FileCollections) then Exit;
  d := Ts0FileCollections(OwnerComponent).Dirs.AddDir(ExtractFileDir(AFileName));
  Result := Self.AddFileWithDir(d, AFileName);
end;

function Ts0FileColFiles.AddFileWithDir(ADir: Ts0FileColDir;
  AFileName: string): Ts0FileColFile;
begin
  Result := nil;
  if ADir = nil then Exit;
  Result := Ts0FileColFile(inherited Add);
  Result.FFileName := ExtractFileName(AFileName);
  Result.FParentDir := ADir;
end;

function Ts0FileColFiles.FindFile(AFileName: string): Ts0FileColFile;
var
  d: Ts0FileColDir;
begin
  Result := nil;
  if not(OwnerComponent is Ts0FileCollections) then Exit;
  d := Ts0FileCollections(OwnerComponent).Dirs.FindDir(ExtractFileDir(AFileName));
  if d = nil then Exit;
  Result := FindFileOfDir(d, AFileName);
end;

function Ts0FileColFiles.FindFileOfDir(ADir: Ts0FileColDir;
  AFileName: string): Ts0FileColFile;
var
  i: Integer;
begin
  AFileName := ExtractFileName(AFileName);
  for i := 0 to Self.Count -1 do
  begin
    Result := Files[i];
    if Result.FileName <> AFileName then Continue;
    if Result.ParentDir <> ADir then Continue;
    Exit;
  end;
  Result := nil;
end;

function Ts0FileColFiles.GetFiles(const Index: Integer): Ts0FileColFile;
begin
  Result := Ts0FileColFile(inherited Items[Index]);
end;

function Ts0FileColFiles.IndexOfName(AFileName: string): Integer;
begin
  Result := -1;
end;

procedure Ts0FileColFiles.NotifyItemRemove(AItemOwner: Ts0FileColItems;
  AItem: Ts0FileColItem);
var
  i: Integer;
begin
  if not (AItem is Ts0FileColDir) then Exit;
  for i := Self.Count -1 downto 0 do
    if Files[i].ParentDir = AItem then
      Delete(i);
end;

procedure Ts0FileColFiles.SetFiles(const Index: Integer;
  const Value: Ts0FileColFile);
begin
  inherited Items[Index] := Value;
end;

{ Ts0FileCollections }

constructor Ts0FileCollections.Create(AOwner: TComponent);
begin
  inherited;
  FDirs := NewDirCollection;
  FFiles := NewFileCollection;
end;

destructor Ts0FileCollections.Destroy;
begin
  FreeAndNil(FFiles);
  FreeAndNil(FDirs);
  inherited;
end;

procedure Ts0FileCollections.ItemDestroyed(ACollection: Ts0FileColItems;
  AItem: Ts0FileColItem);
begin
  if csDestroying in Self.ComponentState then Exit;
  if ACollection = FDirs then
    FFiles.NotifyItemRemove(ACollection, AItem)
  else
  if ACollection = FFiles then
    FDirs.NotifyItemRemove(ACollection, AItem);
end;

function Ts0FileCollections.NewDirCollection: Ts0FileColDirs;
begin
  Result := Ts0FileColDirs.Create(Self, Ts0FileColDir);
end;

function Ts0FileCollections.NewFileCollection: Ts0FileColFiles;
begin
  Result := Ts0FileColFiles.Create(Self, Ts0FileColFile);
end;

procedure Ts0FileCollections.SetDirs(const Value: Ts0FileColDirs);
begin
  FDirs.Assign(Value);
end;

procedure Ts0FileCollections.SetFiles(const Value: Ts0FileColFiles);
begin
  FFiles.Assign(Value);
end;

end.
 
