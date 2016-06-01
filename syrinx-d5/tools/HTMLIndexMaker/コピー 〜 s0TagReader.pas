unit s0TagReader;

interface

uses
  SysUtils, Classes,
  s0TaggedPage,
  s0TagParser,
  Contnrs;

type
  Ts0TagReader = class(Ts0TagParser)
  private
    FPage: Ts0TaggedPage;
    FCurrent: Ts0Tag;
    FNullElementTagNames: TStrings;
    procedure SetPage(const Value: Ts0TaggedPage);
    function GetCurrentParent: Ts0Tag;
    procedure SetNullElementTagNames(const Value: TStrings);
    function GetCurrentParentContents: Ts0Tags;
  protected
    FTagStack: TObjectList; // </XXX> ‚ð‘Ò‚Á‚Ä‚¢‚éƒ^ƒO
  protected
    { event methods }
    procedure FoundEndOfNoTag; override;
    procedure FoundBegin(AChar: Char); override;
    procedure FoundEnd(AChar: Char); override;
    procedure FoundName; override;
    procedure FoundParam; override;
  protected
    function NewTag: Ts0Tag;
    property Current: Ts0Tag read FCurrent;
    property CurrentParent: Ts0Tag read GetCurrentParent;
    property CurrentParentContents: Ts0Tags read GetCurrentParentContents;
    function MustBeStacked(ATag: Ts0Tag): Boolean;
    procedure InitNullElementTagNames;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; override;
  published
    property Page: Ts0TaggedPage read FPage write SetPage;
    property NullElementTagNames: TStrings read FNullElementTagNames write SetNullElementTagNames;
  end;

implementation

uses
  s0CType;

{ Ts0TagReader }

constructor Ts0TagReader.Create(AOwner: TComponent);
begin
  inherited;
  FNullElementTagNames := TStringList.Create;
  FPage := Ts0TaggedPage.Create(Self);
  InitNullElementTagNames;
end;

destructor Ts0TagReader.Destroy;
begin
  FreeAndNil(FTagStack);
  FreeAndNil(FPage);
  FreeAndNil(FNullElementTagNames);
  inherited;        
end;

procedure Ts0TagReader.Execute;
begin
  FCurrent := nil;
  FreeAndNil(FTagStack);
  FTagStack := TObjectList.Create(False);
  Page.Contents.BeginUpdate;
  try
    Page.Contents.Clear;
    if (Source = nil) and FileExists(Page.FileName) then
    begin
      Source := TFileStream.Create(Page.FileName, fmOpenRead or fmShareDenyNone);
      try
       inherited Execute;
      finally
        Source.Free;
        Source := nil;
      end;
    end
    else
      inherited Execute;
  finally
    Page.Contents.EndUpdate;
  end;
end;

procedure Ts0TagReader.FoundBegin(AChar: Char);
begin
  inherited;
  FCurrent := NewTag;
  FCurrent.Header := TagNameHead;
end;

procedure Ts0TagReader.FoundEnd(AChar: Char);
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
  FCurrent.Footer := Self.TagEndTail;
  if FCurrent.Header = CharSet.TerminaterTagHead then
  begin
    if NullElementTagNames.IndexOf( LowerCase(FCurrent.TagName) ) > -1 then Exit;
    idx := IndexOfPar(FCurrent);
    if idx < 0 then Exit;
    DeleteStacked(idx);
    FCurrent.Collection := CurrentParentContents;
  end
  else
  if MustBeStacked(FCurrent) then
    FTagStack.Insert(0, FCurrent);
end;

procedure Ts0TagReader.FoundEndOfNoTag;
var
  dmy: Ts0Tag;
begin
  inherited;
  dmy := NewTag;
  dmy.TagName := '';
  dmy.Params.Text := ReadStr;
end;

procedure Ts0TagReader.FoundName;
begin
  inherited;
  Assert(FCurrent <> nil);
  FCurrent.TagName := ReadStr;
  FCurrent.Header := TagNameHead;
end;

procedure Ts0TagReader.FoundParam;
begin
  inherited;
  FCurrent.Params.Add(ReadStr);
end;

function Ts0TagReader.GetCurrentParent: Ts0Tag;
begin
  Result := nil;
  if FTagStack.Count < 1 then Exit;
  Result := Ts0Tag(FTagStack.First);
end;

function Ts0TagReader.GetCurrentParentContents: Ts0Tags;
begin
  if CurrentParent = nil then
    Result := Page.Contents
  else
    Result := CurrentParent.Contents;
end;

procedure Ts0TagReader.InitNullElementTagNames;
begin
  FNullElementTagNames.Add('meta');
  FNullElementTagNames.Add('img');
  FNullElementTagNames.Add('br');
  FNullElementTagNames.Add('link');
//  FNullElementTagNames.Add('p');
  FNullElementTagNames.Add('li');
  FNullElementTagNames.Add('hr');
  FNullElementTagNames.Add('font');
  FNullElementTagNames.Add('basefont');
  FNullElementTagNames.Add('input');
  FNullElementTagNames.Add('o:lock');
{
  FNullElementTagNames.Add('v:f');
  FNullElementTagNames.Add('v:path');
  FNullElementTagNames.Add('v:stroke');
  FNullElementTagNames.Add('v:imagedata');
}
end;

function Ts0TagReader.MustBeStacked(ATag: Ts0Tag): Boolean;
begin
  Result := False;
  if ATag.Footer = CharSet.TerminaterTagHead then Exit;
  if Ts0Ctype.IsSign(ATag.Header) then Exit;
  if Pos(':', ATag.TagName) > 0 then Exit;
  if FNullElementTagNames.IndexOf(LowerCase(ATag.TagName)) > -1 then Exit;
  Result := True;
end;

function Ts0TagReader.NewTag: Ts0Tag;
begin
  Result := CurrentParentContents.Add
end;

procedure Ts0TagReader.SetNullElementTagNames(const Value: TStrings);
begin
  FNullElementTagNames.Assign(Value);
end;

procedure Ts0TagReader.SetPage(const Value: Ts0TaggedPage);
begin
  FPage := Value;
end;

end.
