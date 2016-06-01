{-----------------------------------------------------------------------------
 Unit Name: s0TagReader
 Author:    akima
 Purpose:
 TestCase: tc_c0TagReadAndWrite
 $History: s0TagReader.pas $
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
 * User: Akima        Date: 02/02/24   Time: 12:05
 * Updated in $/source/D5Integrated
 * MustBeStackedのバグ修正
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/21   Time: 23:29
 * Updated in $/source/D5Integrated
 * NullElementTagNames、InitNullElementTagNamesはTs0TagPolicyに移動。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/19   Time: 21:23
 * Updated in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0TagReader;

interface

uses
  SysUtils, Classes,
  s0TaggedPage,
  s0TagParser,
  Contnrs;

type
  Ts0TagReaderParser = class(Ts0TagParser)
  private
    FPage: Ts0TaggedPage;
    FCurrent: Ts0Tag;
    FIgnoreSpaceDesc: Boolean;
    function GetCurrentParent: Ts0Tag;
    function GetCurrentParentContents: Ts0Tags;
  protected
    FTagStack: TObjectList; // </XXX> を待っているタグ
  protected
    { event methods }
    procedure FoundEndOfNoTag; override;
    procedure FoundBegin(AChar: Char); override;
    procedure FoundEnd(AChar: Char); override;
    procedure FoundFooter(AChar: Char); override;
    procedure FoundHeader(AChar: Char); override;
    procedure FoundName; override;
    procedure FoundParam; override;
  protected
    function NewTag: Ts0Tag;
    property Current: Ts0Tag read FCurrent;
    property CurrentParent: Ts0Tag read GetCurrentParent;
    property CurrentParentContents: Ts0Tags read GetCurrentParentContents;
    function MustBeStacked(ATag: Ts0Tag): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Execute; override;
    property IgnoreSpaceDesc: Boolean read FIgnoreSpaceDesc write FIgnoreSpaceDesc default True;
  end;

type
  Ts0TagReader = class(Ts0TaggedPageFileCommand)
  protected
    function NewParser: Ts0TagParser; virtual;
  public
    procedure Execute; override;
  end;


implementation

uses
  s0CType;

{ Ts0TagReaderParser }

constructor Ts0TagReaderParser.Create(AOwner: TComponent);
begin
  inherited;
  FIgnoreSpaceDesc := True;
end;

procedure Ts0TagReaderParser.Execute;
begin
  Assert(FPage <> nil);
  FCurrent := nil;
  FTagStack := TObjectList.Create(False);
  try
    FPage.Contents.BeginUpdate;
    try
      FPage.Contents.Clear;
      inherited Execute;
    finally
      FPage.Contents.EndUpdate;
    end;
  finally
    FreeAndNil(FTagStack);
  end;
end;

procedure Ts0TagReaderParser.FoundBegin(AChar: Char);
begin
  inherited;
  FCurrent := NewTag;
end;

procedure Ts0TagReaderParser.FoundEnd(AChar: Char);
  function IndexOfPar(ATag: Ts0Tag): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to FTagStack.Count -1 do
    begin
      if SameText( Ts0Tag(FTagStack.Items[i]).TagName, ATag.TagName) then
      begin
        Result := i;
        Exit;
      end;
    end;
  end;
  procedure DeleteStacked(AIndex: Integer);
  var
    i: Integer;
  begin
    for i := 0 to AIndex do
      FTagStack.Delete(0);
  end;
var
  idx: Integer;
begin
  inherited;
  if Policy.IsTerminateHeader(FCurrent.Header) then
  begin
    if Policy.IsOneOfNullElementName(FCurrent.TagName) then Exit;
    idx := IndexOfPar(FCurrent);
    if idx < 0 then Exit;
    DeleteStacked(idx);
    FCurrent.Collection := CurrentParentContents;
  end
  else
  if MustBeStacked(FCurrent) then
    FTagStack.Insert(0, FCurrent);
end;

procedure Ts0TagReaderParser.FoundEndOfNoTag;
var
  dmy: Ts0Tag;
begin
  inherited FoundEndOfNoTag;
  if FIgnoreSpaceDesc and (Trim(ReadStr) = '') then Exit;
  dmy := NewTag;
  dmy.TagName := '';
  dmy.Description := ReadStr;
end;

procedure Ts0TagReaderParser.FoundFooter(AChar: Char);
begin
  inherited;
  FCurrent.Footer := AChar;
end;

procedure Ts0TagReaderParser.FoundHeader(AChar: Char);
begin
  inherited;
  FCurrent.Header := AChar;
end;

procedure Ts0TagReaderParser.FoundName;
begin
  inherited;
  Assert(FCurrent <> nil);
  FCurrent.TagName := ReadStr;
end;

procedure Ts0TagReaderParser.FoundParam;
begin
  inherited;
  FCurrent.Params.Add(ReadStr);
end;

function Ts0TagReaderParser.GetCurrentParent: Ts0Tag;
begin
  Result := nil;
  if FTagStack.Count < 1 then Exit;
  Result := Ts0Tag(FTagStack.First);
end;

function Ts0TagReaderParser.GetCurrentParentContents: Ts0Tags;
begin
  if CurrentParent = nil then
    Result := FPage.Contents
  else
    Result := CurrentParent.Contents;
end;

function Ts0TagReaderParser.MustBeStacked(ATag: Ts0Tag): Boolean;
begin
  Result := False;
  if Policy.IsOneOfNullElementName(ATag.TagName) then Exit;
  if Policy.IsNullElementFooter(ATag.Footer) then Exit;
  if ATag.Header <> #0 then Exit;
  if Pos(':', ATag.TagName) > 0 then Exit;
  Result := True;
end;

function Ts0TagReaderParser.NewTag: Ts0Tag;
begin
  Result := CurrentParentContents.Add
end;

{ Ts0TagReader }

procedure Ts0TagReader.Execute;
var
  parser: Ts0TagParser;
begin
  parser := NewParser;
  try
    PrepareStream(fmOpenRead or fmShareDenyNone);
    try
      parser.Source := Self.Stream;
      parser.PolicyName := Self.PolicyName;
      parser.Policy.Assign(Self.Policy);
      parser.Execute;
    finally
      UnPrepareStream;
    end;
  finally
    FreeAndNil(parser);
  end;
end;

function Ts0TagReader.NewParser: Ts0TagParser;
begin
  Result := Ts0TagReaderParser.Create(nil);
  Ts0TagReaderParser(Result).FPage := Self.Page;
end;

end.
