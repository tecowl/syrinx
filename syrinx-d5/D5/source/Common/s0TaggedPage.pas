{-----------------------------------------------------------------------------
 Unit Name: s0TaggedPage
 Author:    akima
 Purpose:
 TestCase: tc_s0TaggedPage
 $History: s0TaggedPage.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/05/14   Time: 3:29
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/25   Time: 12:39
 * Updated in $/source/D5Integrated
 * Contentsの生成をvirtualなメソッドで行うように変更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/21   Time: 23:29
 * Updated in $/source/D5Integrated
 * 変更多数！
-----------------------------------------------------------------------------}

unit s0TaggedPage;

interface

uses
  SysUtils, Classes, Contnrs,
  s0Persistent,
  s0Collection,
  s0TagPolicy;

type
  K0TagState = (k0tsCreating, k0tsEditing, k0tsComplete);

type
  Ts0Tags = class;

  Ts0Tag = class(Ts0CollectionItem)
  private
    FTagName: string;
    FContents: Ts0Tags;
    FParams: TStrings;
    FHeader: Char;
    FFooter: Char;
    FDescription: string;
    procedure SetContents(Value: Ts0Tags);
    procedure SetTagName(const Value: string);
    function GetContents: Ts0Tags;
    procedure SetParams(Value: TStrings);
    procedure SetHeader(const Value: Char);
    procedure SetFooter(const Value: Char);
    procedure SetDescription(const Value: string);
    function GetParentTag: Ts0Tag;
    procedure SetParentTag(Value: Ts0Tag);
    function GetPairTag: Ts0Tag;
    function GetParamValues(AName: string): string;
    procedure SetParamValues(AName: string; Value: string);
  protected
    function GetPolicy: Ts0TagPolicy;
  protected
    function GetDisplayName: string; override;
    function GetIdentifier: string; override;
    function GetSubCollection: Ts0Collection; override;
    function GetAllDescriptions: string;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AddParams(AParams: array of string);
    function Equals(AItem: Ts0CollectionItem): Boolean; override;
    property ParentTag: Ts0Tag read GetParentTag write SetParentTag;
    property PairTag: Ts0Tag read GetPairTag;
    property Policy: Ts0TagPolicy read GetPolicy;
    property ParamValues[AName: string]: string read GetParamValues write SetParamValues;
    property AllDescriptions: string read GetAllDescriptions;
    procedure MoveWithPair(ANewParent: Ts0Tag);
  published
    property Contents: Ts0Tags read GetContents write SetContents;
    property Header: Char read FHeader write SetHeader;
    property Footer: Char read FFooter write SetFooter;
    property Params: TStrings read FParams write SetParams;
    property TagName: string read FTagName write SetTagName;
    property Description: string read FDescription write SetDescription;
  end;

  K0TagFindOption = (
    k0tfoUseMask,    //マスクを使って検索
    k0tfoIgnoreCase, //大文字小文字を区別しない
    k0tfoNestSearch  //サブ項目も検索
  );
  K0TagFindOptions = set of K0TagFindOption;

  Ts0Tags = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0Tag;
    procedure SetItems(const Index: Integer; Value: Ts0Tag);
  protected
    function GetPolicy: Ts0TagPolicy;
  public
    function Add: Ts0Tag;
    function AddDescription(ADesc: String): Ts0Tag;
    function AddTag(ATagName: string; AWithTerminater: Boolean = True): Ts0Tag;
    function AddTagWithParam(ATagName: string; AParams: array of string;
      AWithTerminater: Boolean = True): Ts0Tag;
    function InsertTag(Index: Integer; ATagName: string;
      AWithTerminater: Boolean = True): Ts0Tag;
    function InsertTagWithParam(Index: Integer; ATagName: string;
      AParams: array of string; AWithTerminater: Boolean = True): Ts0Tag;
    procedure FindByTagName(Dest: Ts0CollectionItemList; ATagName: string;
      AOptions: K0TagFindOptions = [k0tfoIgnoreCase, k0tfoNestSearch];
      AHeader: Char = #0; AFooter: Char = #0);
    function FindTag(ATagName: string; AOptions:
      K0TagFindOptions = [k0tfoIgnoreCase, k0tfoNestSearch];
      AHeader: Char = #0; AFooter: Char = #0): Ts0Tag;
    procedure RemoveTag(AItem: Ts0Tag);
    property Items[const Index: Integer]: Ts0Tag read GetItems write SetItems; default;
    property Policy: Ts0TagPolicy read GetPolicy;
  end;

type
  Ts0TaggedPageCommand = class;   

  Ts0TaggedPage = class(Ts0TagPolicyComponent)
  private
    FContents: Ts0Tags;
    procedure SetContents(Value: Ts0Tags);
  protected
    function NewTags: Ts0Tags; virtual;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Contents: Ts0Tags read FContents write SetContents;
  public
    procedure LoadFromFile(AFileName: TFileName);
    procedure LoadFromStream(Source: TStream);
    procedure SaveToFile(AFileName: TFileName);
    procedure SaveToStream(Dest: TStream);
  public
    function ReadObject: TObject;
    procedure WriteObject(Instance: TObject);
  end;

  Ts0TaggedPageCommandClass = class of Ts0TaggedPageCommand;
  Ts0TaggedPageCommand = class(Ts0TagPolicyComponent)
  private
    FPage: Ts0TaggedPage;
    procedure SetPage(const Value: Ts0TaggedPage);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure Execute; virtual; abstract;
    property Page: Ts0TaggedPage read FPage write SetPage;
  published
    property PolicyName;
  end;

type
  Ts0TaggedPageFileCommandClass = class of Ts0TaggedPageFileCommand;
  Ts0TaggedPageFileCommand = class(Ts0TaggedPageCommand)
  private
    FStream: TStream;
    FFileName: TFileName;
    FStreamIsPrepared: Boolean;
    procedure SetStream(Value: TStream);
    procedure SetFileName(const Value: TFileName);
  protected
    procedure PrepareStream(AMode: Word);
    procedure UnPrepareStream;
  public
    constructor Create(AOwner: TComponent); override;
    property FileName: TFileName read FFileName write SetFileName;
    property Stream: TStream read FStream write SetStream;
  end;

type
  Ts0TaggedPageObjectCommandClass = class of Ts0TaggedPageObjectCommand;
  Ts0TaggedPageObjectCommand = class(Ts0TaggedPageCommand)
  private
    FObjects: TObjectList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Objects: TObjectList read FObjects;
  end;

var
  g0PageLoadCommandClass: Ts0TaggedPageFileCommandClass;
  g0PageSaveCommandClass: Ts0TaggedPageFileCommandClass;
  g0PageReadObjCommandClass: Ts0TaggedPageObjectCommandClass;
  g0PageWriteObjCommandClass: Ts0TaggedPageObjectCommandClass;

implementation

uses
  s0TagReader,
  s0TagWriter,
  s0ObjXMLReader,
  s0ObjXMLWriter,
  Masks,
  s0Ctype;

type
  Ts0TagFinder = class(Ts0CollectionItemFinder)
  private
    FHeader: Char;
    FFooter: Char;
    FTagName: string;
    FMask: TMask;
    FOptions: K0TagFindOptions;
  protected
    function Match(AItem: Ts0CollectionItem): Boolean; override;
  public
    constructor Create; override;
    procedure Execute; override;
    property TagName: string read FTagName write FTagName;
    property Options: K0TagFindOptions read FOptions write FOptions;
  end;

{ Ts0TagFinder }

constructor Ts0TagFinder.Create;
begin
  inherited Create;
end;

procedure Ts0TagFinder.Execute;
begin
  if k0tfoNestSearch in Options then
    Self.TimingOfSubFind := k0fsikAfterMatch
  else
    Self.TimingOfSubFind := k0fsikNone;
  //
  if k0tfoUseMask in Options then
  begin
    FMask := TMask.Create(FTagName);
    try
      inherited Execute;
    finally
      FreeAndNil(FMask);
    end;
  end
  else
    inherited Execute;  
end;

function Ts0TagFinder.Match(AItem: Ts0CollectionItem): Boolean;
var
  t: Ts0Tag;
begin
  Result := False;
  Assert(AItem is Ts0Tag);
  t := Ts0Tag(AItem);
  if t.Header <> FHeader then Exit;
  if t.Footer <> FFooter then Exit;
  if FMask = nil then
  begin
    if k0tfoIgnoreCase in Options then
      Result := SameText(t.TagName, FTagName)
    else
      Result := (CompareStr(t.TagName, FTagName) = 0);
  end
  else
    Result := FMask.Matches(t.TagName);
end;

{ Ts0Tag }

procedure Ts0Tag.AddParams(AParams: array of string);
var
  i: Integer;
begin
  for i := Low(AParams) to High(AParams) do
    Params.Add(AParams[i]);
end;

procedure Ts0Tag.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0Tag) then Exit;
  Self.Header      := Ts0Tag(Source).Header;
  Self.Footer      := Ts0Tag(Source).Footer;
  Self.Params      := Ts0Tag(Source).Params;
  Self.TagName     := Ts0Tag(Source).TagName;
  Self.Description := Ts0Tag(Source).Description;
  Self.Contents    := Ts0Tag(Source).Contents;
end;

constructor Ts0Tag.Create(ACollection: TCollection);
begin
  inherited;
  FParams := TStringList.Create;
end;

destructor Ts0Tag.Destroy;
begin
  FreeAndNil(FContents);
  FreeAndNil(FParams);
  inherited;
end;

function Ts0Tag.Equals(AItem: Ts0CollectionItem): Boolean;
begin
  Result := False;
  if not(AItem is Ts0Tag) then Exit;
  if Self.TagName     <> Ts0Tag(AItem).TagName then Exit;
  if Self.Description <> Ts0Tag(AItem).Description then Exit;
  if Self.Header      <> Ts0Tag(AItem).Header then Exit;
  if Self.Footer      <> Ts0Tag(AItem).Footer then Exit;
  if Self.Params.Text <> Ts0Tag(AItem).Params.Text then Exit;
  if not Self.Contents.Equals(Ts0Tag(AItem).Contents) then Exit;;
  Result := True;
end;

function Ts0Tag.GetAllDescriptions: string;
var
  lst: Ts0CollectionItemList;
  i: Integer;
begin
  Result := '';
  lst := Ts0CollectionItemList.Create(False);
  try
    Contents.FindByTagName(lst, '');
    for i := 0 to lst.Count -1 do
    begin
      Assert(lst.Items[i] is Ts0Tag);
      Result := Result + Ts0Tag(lst.Items[i]).Description;
    end;
  finally
    FreeAndNil(lst);
  end;
end;

function Ts0Tag.GetContents: Ts0Tags;
begin
  if FContents = nil then
    FContents := Ts0Tags.Create(Self, Self.GetClassType);
  Result := FContents;
end;

function Ts0Tag.GetDisplayName: string;
begin
  Result := GetIdentifier;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function Ts0Tag.GetIdentifier: string;
begin
  if FTagName = '' then
    Result := FDescription
  else
  begin
    Result := FTagName;
    if FHeader <> #0 then Result := FHeader + Result;
    if FFooter <> #0 then Result := Result + FFooter;
  end;
  if Result = '' then
    Result := inherited GetIdentifier;
end;

function Ts0Tag.GetPairTag: Ts0Tag;
var
  idx, i: Integer;
begin
  idx := Self.Index;
  if Policy.IsTerminateHeader(FHeader) then
  begin
    for i := idx downto 0 do
    begin
      Assert(Collection.Items[i] is Ts0Tag);
      Result := Ts0Tag(Collection.Items[i]);
      if Policy.IsTerminateHeader(Result.Header) then Continue;
      if Result.TagName = Self.TagName then
        Exit;
    end;
  end
  else
  begin
    for i := idx to Collection.Count -1 do
    begin
      Assert(Collection.Items[i] is Ts0Tag);
      Result := Ts0Tag(Collection.Items[i]);
      if not Policy.IsTerminateHeader(Result.Header) then Continue;
      if Result.TagName = Self.TagName then
        Exit;
    end;
  end;
  Result := nil;
end;

function Ts0Tag.GetParamValues(AName: string): string;
begin
  Result := Params.Values[AName];
  Policy.DecodeParamValue(Result);
end;

function Ts0Tag.GetParentTag: Ts0Tag;
begin
  Result := nil;
  if OwnerObj is Ts0Tag then
    Result := Ts0Tag(OwnerObj);
end;

function Ts0Tag.GetPolicy: Ts0TagPolicy;
begin
  Result := nil;
  if OwnerComponent is Ts0TaggedPage then
    Result := Ts0TaggedPage(OwnerComponent).Policy;
end;

function Ts0Tag.GetSubCollection: Ts0Collection;
begin
  Result := Contents;
end;

procedure Ts0Tag.MoveWithPair(ANewParent: Ts0Tag);
var
  pair: Ts0Tag;
begin
  pair := PairTag;
  ParentTag := ANewParent;
  if pair <> nil then
    pair.ParentTag := ANewParent;
end;

procedure Ts0Tag.SetContents(Value: Ts0Tags);
begin
  FContents.Assign(Value);
end;

procedure Ts0Tag.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure Ts0Tag.SetFooter(const Value: Char);
begin
  FFooter := Value;
end;

procedure Ts0Tag.SetHeader(const Value: Char);
begin
  FHeader := Value;
end;

procedure Ts0Tag.SetParams(Value: TStrings);
begin
  FParams.Assign(Value);
end;

procedure Ts0Tag.SetParamValues(AName: string; Value: string);
begin
  Policy.EncodeParamValue(Value);
  Params.Values[AName] := Value;
end;

procedure Ts0Tag.SetParentTag(Value: Ts0Tag);
begin
  if GetParentTag = Value then Exit;
  if Value <> nil then
    Self.Collection := Value.Contents
  else
  begin
    if OwnerComponent is Ts0TaggedPage then
      Self.Collection := Ts0TaggedPage(OwnerComponent).Contents;
  end;
end;

procedure Ts0Tag.SetTagName(const Value: string);
begin
  FTagName := Value;
end;

{ Ts0Tags }

function Ts0Tags.Add: Ts0Tag;
begin
  Result := Ts0Tag(inherited Add);
end;

function Ts0Tags.AddDescription(ADesc: String): Ts0Tag;
begin
  Result := Self.Add;
  Result.Description := ADesc;
end;

function Ts0Tags.AddTag(ATagName: string; AWithTerminater: Boolean): Ts0Tag;
  function NewTag: Ts0Tag;
  begin
    Result := Self.Add;
    Result.TagName := ATagName;
  end;
begin
  Result := NewTag;
  if not AWithTerminater then Exit;
  if Policy.IsOneOfNullElementName(ATagName) then Exit;
  NewTag.Header := Policy.TerminateHeader;
end;

function Ts0Tags.AddTagWithParam(ATagName: string; AParams: array of string;
  AWithTerminater: Boolean): Ts0Tag;
begin
  Result := AddTag(ATagName, AWithTerminater);
  Result.AddParams(AParams);
end;

procedure Ts0Tags.FindByTagName(Dest: Ts0CollectionItemList; ATagName: string;
  AOptions: K0TagFindOptions; AHeader: Char; AFooter: Char);
var
  finder: Ts0TagFinder;
  i: Integer;
begin
  Assert(Dest <> nil);
  finder := Ts0TagFinder.Create;
  try
    finder.TagName := ATagName;
    finder.Options := AOptions;
    finder.Target := Self;
    finder.AnswerOnlyOne := False;
    finder.Execute;
    //
    if Dest = nil then Exit;
    Dest.OwnsObjects := False;
    Dest.Clear;
    for i := 0 to finder.ResultList.Count -1 do
      Dest.Add( finder.ResultList.Items[i] );
  finally
    FreeAndNil(finder);
  end;
end;

function Ts0Tags.FindTag(ATagName: string; AOptions: K0TagFindOptions;
  AHeader, AFooter: Char): Ts0Tag;
var
  finder: Ts0TagFinder;
begin
  Result := nil;
  finder := Ts0TagFinder.Create;
  try
    finder.TagName := ATagName;
    finder.Options := AOptions;
    finder.Target := Self;
    finder.AnswerOnlyOne := True;
    finder.Execute;
    //
    if finder.ResultList.Count > 0 then
      Result := Ts0Tag(finder.ResultList.First);
  finally
    FreeAndNil(finder);
  end;
end;

function Ts0Tags.GetItems(const Index: Integer): Ts0Tag;
begin
  Result := Ts0Tag(inherited Items[Index]);
end;

function Ts0Tags.GetPolicy: Ts0TagPolicy;
begin
  Result := nil;
  if OwnerComponent is Ts0TaggedPage then
    Result := Ts0TaggedPage(OwnerComponent).Policy;
end;

function Ts0Tags.InsertTag(Index: Integer; ATagName: string;
  AWithTerminater: Boolean): Ts0Tag;
begin
  Result := AddTag(ATagName, AWithTerminater);
  Result.Index := Index;
  if Result.PairTag = nil then Exit;
  Result.PairTag.Index := Index + 1;  
end;

function Ts0Tags.InsertTagWithParam(Index: Integer; ATagName: string;
  AParams: array of string; AWithTerminater: Boolean): Ts0Tag;
begin
  Result := InsertTag(Index, ATagName, AWithTerminater);
  Result.AddParams(AParams);
end;

procedure Ts0Tags.RemoveTag(AItem: Ts0Tag);
var
  i, idx: Integer;
  t: Ts0Tag;
  itemPair: Ts0Tag;
  prnt: Ts0Tags;
begin
  idx := IndexOf(AItem);
  if idx < 0 then Exit;
  Self.BeginUpdate;
  try
    itemPair := AItem.PairTag;
    //
    prnt := AItem.Contents;
    for i := prnt.Count -1 downto 0 do
    begin
      t := prnt.Items[i];
      t.Collection := Self;
      t.Index := idx;
    end;
    Assert(prnt.Count = 0);
    inherited Remove(AItem);
    if itemPair <> nil then
      inherited Remove(itemPair);
  finally
    Self.EndUpdate;
  end;
end;

procedure Ts0Tags.SetItems(const Index: Integer; Value: Ts0Tag);
begin
  inherited Items[Index] := Value;
end;

{ Ts0TaggedPage }

procedure Ts0TaggedPage.Assign(Source: TPersistent);
var
  src: Ts0TaggedPage;
begin
  inherited Assign(Source);
  if not(Source is Ts0TaggedPage) then Exit;
  src := Ts0TaggedPage(Source);
  Contents := src.Contents;
end;

constructor Ts0TaggedPage.Create(AOnwer: TComponent);
begin
  inherited;
  FContents := NewTags;
end;

destructor Ts0TaggedPage.Destroy;
begin
  FreeAndNil(FContents);
  inherited;
end;

procedure Ts0TaggedPage.LoadFromFile(AFileName: TFileName);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

procedure Ts0TaggedPage.LoadFromStream(Source: TStream);
var
  reader: Ts0TaggedPageFileCommand;
begin
  reader := g0PageLoadCommandClass.Create(nil);
  try
    reader.Page := Self;
    reader.Stream := Source;
    reader.Execute;
  finally
    FreeAndNil(reader);
  end;
end;

function Ts0TaggedPage.NewTags: Ts0Tags;
begin
  Result := Ts0Tags.Create(Self, Ts0Tag);
end;

function Ts0TaggedPage.ReadObject: TObject;
var
  reader: Ts0TaggedPageObjectCommand;
begin
  Result := nil;
  Assert(g0PageReadObjCommandClass <> nil);
  reader := g0PageReadObjCommandClass.Create(nil);
  try
    reader.Page := Self;
    reader.Objects.OwnsObjects := False;
    reader.Execute;
    if reader.Objects.Count < 1 then Exit;
    Result := reader.Objects.Items[0];
  finally
    FreeAndNil(reader);
  end;
end;

procedure Ts0TaggedPage.SaveToFile(AFileName: TFileName);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(AFileName, fmCreate or fmShareDenyNone);
  try
    SaveToStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

procedure Ts0TaggedPage.SaveToStream(Dest: TStream);
var
  writer: Ts0TaggedPageFileCommand;
begin
  writer := g0PageSaveCommandClass.Create(nil);
  try
    writer.Page := Self;
    writer.Stream := Dest;
    writer.Execute;
  finally
    FreeAndNil(writer);
  end;
end;

procedure Ts0TaggedPage.SetContents(Value: Ts0Tags);
begin
  FContents.Assign(Value);
end;

procedure Ts0TaggedPage.WriteObject(Instance: TObject);
var
  writer: Ts0TaggedPageObjectCommand;
begin
  Assert(g0PageWriteObjCommandClass <> nil);
  writer := g0PageWriteObjCommandClass.Create(nil);
  try
    writer.Page := Self;
    writer.Objects.Add(Instance);
    writer.Execute;
  finally
    FreeAndNil(writer);
  end;
end;

{ Ts0TaggedPageCommand }

procedure Ts0TaggedPageCommand.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FPage = AComponent then
    FPage := nil;
end;

procedure Ts0TaggedPageCommand.SetPage(const Value: Ts0TaggedPage);
begin
  FPage := Value;
  if FPage = nil then Exit;
  Self.PolicyName := FPage.PolicyName;
end;

{ Ts0TaggedPageFileCommand }

constructor Ts0TaggedPageFileCommand.Create(AOwner: TComponent);
begin
  inherited;
  FStreamIsPrepared := False;
end;

procedure Ts0TaggedPageFileCommand.PrepareStream(AMode: Word);
begin
  if FStream = nil then
  begin
    FStream := TFileStream.Create(FileName, AMode);
    FStreamIsPrepared := True;
  end
  else
    FStreamIsPrepared := False;
end;

procedure Ts0TaggedPageFileCommand.SetFileName(const Value: TFileName);
begin
  FFileName := Value;
end;

procedure Ts0TaggedPageFileCommand.SetStream(Value: TStream);
begin
  FStream := Value;
end;

procedure Ts0TaggedPageFileCommand.UnPrepareStream;
begin
  if FStreamIsPrepared then
    FreeAndNil(FStream);
  FStreamIsPrepared := False;
end;

{ Ts0TaggedPageObjectCommand }

constructor Ts0TaggedPageObjectCommand.Create(AOwner: TComponent);
begin
  inherited;
  FObjects := TObjectList.Create(False);
end;

destructor Ts0TaggedPageObjectCommand.Destroy;
begin
  FreeAndNil(FObjects);
  inherited;           
end;

initialization
  g0PageLoadCommandClass := Ts0TagReader;
  g0PageSaveCommandClass := Ts0TagWriter;
  g0PageReadObjCommandClass := Ts0ObjXMLReader;
  g0PageWriteObjCommandClass := Ts0ObjXMLWriter;

end.
