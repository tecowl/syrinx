{-----------------------------------------------------------------------------
 Unit Name: s0TagWriter
 Author:    akima
 Purpose:
 TestCase: tc_c0TagReadAndWrite
 $History: s0TagWriter.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * ê⁄ì™é´ÇïœçXÅBxxSXÅ`Ç…ÇµÇΩÅB
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/02/21   Time: 23:10
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0TagWriter;

interface

uses
  SysUtils, Classes,
  s0TaggedPage,
  s0TagPolicy,
  Contnrs;

type
  Ts0TagWriter = class(Ts0TaggedPageFileCommand)
  private
    FIgnoreNullStr: Boolean;
    FDoIndent: Boolean;
    FReturnAfterTag: Boolean;
    FIndentCount: Integer;
    procedure SetDoIndent(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; override;
  published
    property DoIndent: Boolean read FDoIndent write SetDoIndent default True;
    property IndentCount: Integer read FIndentCount write FIndentCount default 2;
    property IgnoreNullStr: Boolean read FIgnoreNullStr write FIgnoreNullStr default False;
    property ReturnAfterTag: Boolean read FReturnAfterTag write FReturnAfterTag default True;
  end;

implementation

uses
  s0Collection;

type
  T9PageSaver = class(Ts0CollectionVisitor)
  private
    Stream: TStream;
    FPage: Ts0TaggedPage;
    FDoIndent: Boolean;
    FIndentCount: Integer;
    FReturnAfterTag: Boolean;
    FIgnoreNullStr: Boolean;
    function GetLevel(AItem: Ts0Tag): Integer;
  protected
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  public
    constructor Create;
    procedure Execute(APage: Ts0TaggedPage; Dest: TStream);
  end;

{ Ts0TagWriter }

constructor Ts0TagWriter.Create(AOwner: TComponent);
begin
  inherited;
  FDoIndent := True;
  FIndentCount := 2;
  FIgnoreNullStr := False;
  FReturnAfterTag := True;
end;

destructor Ts0TagWriter.Destroy;
begin
  inherited;
end;

procedure Ts0TagWriter.Execute;
var
  saver: T9PageSaver;
begin
  Assert(Page <> nil);
  saver := T9PageSaver.Create;
  try
    PrepareStream(fmCreate or fmShareDenyNone);
    try
      saver.FDoIndent       := Self.DoIndent;
      saver.FIndentCount    := Self.IndentCount;
      saver.FReturnAfterTag := Self.ReturnAfterTag;
      saver.FIgnoreNullStr  := Self.IgnoreNullStr;
      saver.Execute(Page, Stream);
    finally
      UnPrepareStream;
    end;
  finally
    FreeAndNil(saver);
  end;
end;

procedure Ts0TagWriter.SetDoIndent(const Value: Boolean);
begin
  FDoIndent := Value;
  if [csLoading, csReading] * Self.ComponentState <> [] then Exit;
  FReturnAfterTag := True;
end;

{ T9PageSaver }

constructor T9PageSaver.Create;
begin
  inherited Create;
  FDoIndent := False;
  FIndentCount := 2;
  FIgnoreNullStr := False;
  FReturnAfterTag := False;
end;

procedure T9PageSaver.Execute(APage: Ts0TaggedPage; Dest: TStream);
begin
  Stream := Dest;
  FPage := APage;
  Assert(Stream <> nil);
  Assert(APage <> nil);
  APage.Contents.Accept(Self);  
end;

function T9PageSaver.GetLevel(AItem: Ts0Tag): Integer;
begin
  Result := 0;
  while (AItem.CollectionAs0Level.OwnerObj <> FPage) and
        (AItem.CollectionAs0Level.OwnerObj is Ts0Tag) do
  begin
    Inc(Result);
    AItem := Ts0Tag(AItem.CollectionAs0Level.OwnerObj);
  end;
end;

procedure T9PageSaver.VisitItem(AItem: Ts0CollectionItem);
  function GetParamStr(AParam: TStrings): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := 0 to AParam.Count -1 do
      Result := Result + ' '+ AParam.Strings[i];
  end;
var
  t: Ts0Tag;
  s: string;
  ss: TStringStream;
begin
  Assert(AItem is Ts0Tag);
  t := Ts0Tag(AItem);
  if Trim(t.TagName) = '' then
    s := t.Description
  else
  begin
    s := s + t.TagName;
    s := s + ' ';
    s := s + GetParamStr(t.Params);
    s := Trim(s);
    if t.Header <> #0 then s := t.Header + s;
    if t.Footer <> #0 then s := s + t.Footer;
    s := Format('<%s>', [s]);
  end;
  if FReturnAfterTag then
    s := s + #13#10;
  //
  if FDoIndent then
    s := StringOfChar(' ', GetLevel(t) * FIndentCount) + s;
  if FIgnoreNullStr and (Trim(s) = '') then
  begin

  end
  else
  begin
    ss := TStringStream.Create(s);
    try
      Stream.CopyFrom(ss, 0);
    finally
      FreeAndNil(ss);
    end;
  end;
  inherited VisitItem(AItem);
end;

end.
