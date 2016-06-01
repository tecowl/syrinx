unit s0TaggedPage;

interface

uses
  SysUtils, Classes,
  s0Persistent,
  s0Collection;

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
    procedure SetContents(const Value: Ts0Tags);
    procedure SetTagName(const Value: string);
    function GetContents: Ts0Tags;
    function GetTagIsEmpty: Boolean;
    function GetHasDelimTag: Boolean;
    procedure SetParams(const Value: TStrings);
    procedure SetHeader(const Value: Char);
    procedure SetFooter(const Value: Char);
    procedure SetDescription(const Value: string);
  protected
    function GetDisplayName: string; override;
    function GetSubCollection: Ts0Collection; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    property TagIsEmpty: Boolean read GetTagIsEmpty;
    property HasDelimTag: Boolean read GetHasDelimTag;
  published
    property Contents: Ts0Tags read GetContents write SetContents;
    property Header: Char read FHeader write SetHeader;
    property Footer: Char read FFooter write SetFooter;
    property Params: TStrings read FParams write SetParams;
    property TagName: string read FTagName write SetTagName;
    property Description: string read FDescription write SetDescription;
  end;

  Ts0Tags = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0Tag;
    procedure SetItems(const Index: Integer; const Value: Ts0Tag);
  public
    function Add: Ts0Tag;
    property Items[const Index: Integer]: Ts0Tag read GetItems write SetItems;
  end;

type
  Ts0TaggedPage = class(Ts0Persistent)
  private
    FContents: Ts0Tags;
    FFileName: string;
    procedure SetContents(const Value: Ts0Tags);
    procedure SetFileName(const Value: string);
  protected
  public
    constructor Create(AOnwer: TPersistent); override;
    destructor Destroy; override;
    procedure SaveToFile;
    procedure SaveToStream(Dest: TStream);
  published
    property Contents: Ts0Tags read FContents write SetContents;
    property FileName: string read FFileName write SetFileName;
  end;

type
  T0PageSaver = class(Ts0CollectionVisitor)
  private
    FDest: TStream;
    FPage: Ts0TaggedPage;
    FDoIndent: Boolean;
    FIndentCount: Integer;
    FReturnAfterTag: Boolean;
    FIgnoreNullStr: Boolean;
    procedure SetDoIndent(const Value: Boolean);
    procedure SetIndentCount(const Value: Integer);
    function GetLevel(AItem: Ts0Tag): Integer;
    procedure SetReturnAfterTag(const Value: Boolean);
    procedure SetIgnoreNullStr(const Value: Boolean);
  protected
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  public
    constructor Create;
    procedure Execute(APage: Ts0TaggedPage; Dest: TStream);
    property DoIndent: Boolean read FDoIndent write SetDoIndent default True;
    property IndentCount: Integer read FIndentCount write SetIndentCount default 2;
    property IgnoreNullStr: Boolean read FIgnoreNullStr write SetIgnoreNullStr default True;
    property ReturnAfterTag: Boolean read FReturnAfterTag write SetReturnAfterTag default True;
  end;

implementation

uses
  u0Ctype;

{ Ts0Tag }

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

function Ts0Tag.GetContents: Ts0Tags;
begin
  if FContents = nil then
    FContents := Ts0Tags.Create(Self, Ts0Tag);
  Result := FContents;
end;

function Ts0Tag.GetDisplayName: string;
begin
  if FTagName = '' then
    Result := FDescription
  else
  begin
    Result := FTagName;
    if FHeader <> #0 then Result := FHeader + Result;
    if FFooter <> #0 then Result := Result + FFooter;
  end;
end;

function Ts0Tag.GetHasDelimTag: Boolean;
begin
  Result := True;
end;

function Ts0Tag.GetSubCollection: Ts0Collection;
begin
  Result := Contents;
end;

function Ts0Tag.GetTagIsEmpty: Boolean;
begin
  Result := FTagName = '';
end;

procedure Ts0Tag.SetContents(const Value: Ts0Tags);
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

procedure Ts0Tag.SetParams(const Value: TStrings);
begin
  FParams.Assign(Value);
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

function Ts0Tags.GetItems(const Index: Integer): Ts0Tag;
begin
  Result := Ts0Tag(inherited Items[Index]);
end;

procedure Ts0Tags.SetItems(const Index: Integer; const Value: Ts0Tag);
begin
  inherited Items[Index] := Value;
end;

{ Ts0TaggedPage }

constructor Ts0TaggedPage.Create(AOnwer: TPersistent);
begin
  inherited;
  FContents := Ts0Tags.Create(Self, Ts0Tag);
end;

destructor Ts0TaggedPage.Destroy;
begin
  FreeAndNil(FContents);
  inherited;            
end;

procedure Ts0TaggedPage.SaveToFile;
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
  try
    SaveToStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

procedure Ts0TaggedPage.SaveToStream(Dest: TStream);
var
  saver: T0PageSaver;
begin
  saver := T0PageSaver.Create;
  try
    saver.Execute(Self, Dest);
  finally
    FreeAndNil(saver);
  end;
end;

procedure Ts0TaggedPage.SetContents(const Value: Ts0Tags);
begin
  FContents.Assign(Value);
end;

procedure Ts0TaggedPage.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

{ T0PageSaver }

constructor T0PageSaver.Create;
begin
  inherited Create;
  FDoIndent := True;
  FIndentCount := 2;
  FIgnoreNullStr := True;
  FReturnAfterTag := True;
end;

procedure T0PageSaver.Execute(APage: Ts0TaggedPage; Dest: TStream);
begin
  FDest := Dest;
  FPage := APage;
  Assert(FDest <> nil);
  Assert(APage <> nil);
  APage.Contents.Accept(Self);  
end;

function T0PageSaver.GetLevel(AItem: Ts0Tag): Integer;
begin
  Result := 0;
  while (AItem.CollectionAs0Level.OwnerObj <> FPage) and
        (AItem.CollectionAs0Level.OwnerObj is Ts0Tag) do
  begin
    Inc(Result);
    AItem := Ts0Tag(AItem.CollectionAs0Level.OwnerObj);
  end;         
end;

procedure T0PageSaver.SetDoIndent(const Value: Boolean);
begin
  FDoIndent := Value;
end;

procedure T0PageSaver.SetIgnoreNullStr(const Value: Boolean);
begin
  FIgnoreNullStr := Value;
end;

procedure T0PageSaver.SetIndentCount(const Value: Integer);
begin
  FIndentCount := Value;
end;

procedure T0PageSaver.SetReturnAfterTag(const Value: Boolean);
begin
  FReturnAfterTag := Value;
end;

procedure T0PageSaver.VisitItem(AItem: Ts0CollectionItem);
  function GetParamStr(AParam: TStrings): string;
  begin
    Result := AParam.Text;
    Result := StringReplace(Result, #13, ' ', [rfReplaceAll]);
    Result := StringReplace(Result, #10, '', [rfReplaceAll]);
  end;
var
  t: Ts0Tag;
  s: string;
  ss: TStringStream;
begin
  Assert(AItem is Ts0Tag);
  t := Ts0Tag(AItem);
  if Trim(t.TagName) = '' then
    s := t.Params.Text
  else
  begin
    s := s + t.TagName;
    s := s + ' ';
    s := s + GetParamStr(t.Params);
    s := Trim(s);
    if t.Header <> #0 then s := t.Header + s;
    if t.Footer <> #0 then s := s + t.Footer;
    s := Format('<%s>', [s]);
    if ReturnAfterTag then
      s := s + #13#10;
  end;
  //
  if DoIndent then
    s := StringOfChar(' ', GetLevel(t) * IndentCount) + s;
  if IgnoreNullStr and (Trim(s) = '') then
  begin

  end
  else
  begin
    ss := TStringStream.Create(s);
    try
      FDest.CopyFrom(ss, 0);
    finally
      FreeAndNil(ss);
    end;
  end;
  inherited VisitItem(AItem);
end;

end.
