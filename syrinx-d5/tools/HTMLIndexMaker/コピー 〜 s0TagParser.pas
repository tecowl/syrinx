unit s0TagParser;

interface

uses
  SysUtils, Classes;

type
  K0TaggedPageToken = (
    k0tptBegin,
    k0tptEnd,
    k0tptDelimInTag,
    k0tptParamDelim,
    k0tptNone,
    k0tptName,
    k0tptParam,
    k0tptParamValue
    );

type
  K0TaggedPageCharToken = k0tptBegin..k0tptParamDelim;
  K0TaggedPageCharTokenSet = set of K0TaggedPageCharToken;

type
  Ts0TagCharSet = class(TPersistent)
  private
    FTagBegin: Char;
    FTagEnd: Char;
    FDelimInTag: Char;
    FParamDelim: Char;
    FTerminaterTagHead: Char;
    FNullElementTagTail: Char;
  public
    constructor Create;
    property TagBegin: Char read FTagBegin write FTagBegin default '<';
    property TagEnd: Char read FTagEnd write FTagEnd default '>';
    property DelimInTag: Char read FDelimInTag write FDelimInTag default ' ';
    property ParamDelim: Char read FParamDelim write FParamDelim default '=';
    property TerminaterTagHead: Char read FTerminaterTagHead write FTerminaterTagHead default '/';
    property NullElementTagTail: Char read FNullElementTagTail write FNullElementTagTail default '/';
  end;

type
  K0ParamReadType = (k0prtReadOnce, k0prtSeparateRead);

type
  K0TokenCheckedEvent = procedure of object; 


type
  Ts0TagParser = class(TComponent)
  private
    FSource: TStream;
    FReadStr: string;
    FCurrentToken: K0TaggedPageToken;
    FCharSet: Ts0TagCharSet;
    FParamReadType: K0ParamReadType;
    FCurrentTagIsTerminater: Boolean;
    FTagNameHead: Char;
    FTagEndTail: Char;
    procedure SetSource(const Value: TStream);
    function GetReadStrIsNotNull: Boolean;
  protected
    function FindNextChar(AChar: Char): Boolean; virtual;
    procedure FindNextToken; virtual;
  protected
    function CheckTagBegin(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
    function CheckTagEnd(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
    function CheckDelimInTag(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
    function CheckParamDelim(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
    procedure FindNextOfBegin     ; virtual;
    procedure FindNextOfEnd       ; virtual;
    procedure FindNextOfDelimInTag; virtual;
    procedure FindNextOfParamDelim; virtual;
  protected
    { event methods }
    procedure FoundEndOfNoTag; virtual;
    procedure FoundBegin(AChar: Char); virtual;
    procedure FoundEnd(AChar: Char); virtual;
    procedure FoundDelimInTag(AChar: Char); virtual;
    procedure FoundName; virtual;
    procedure FoundParam; virtual;
    procedure FoundParamDelim(AChar: Char); virtual;
    procedure FoundParamValue; virtual;
  protected
    procedure ClearReadStr; virtual;
    procedure ClearTagProp;
    procedure ReadNext; virtual;
    property ReadStrIsNotNull: Boolean read GetReadStrIsNotNull;
    property CurrentToken: K0TaggedPageToken read FCurrentToken;
    property CurrentTagIsTerminater: Boolean read FCurrentTagIsTerminater;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; virtual;
    property TagNameHead: Char read FTagNameHead;
    property TagEndTail: Char read FTagEndTail;
    property ReadStr: string read FReadStr;
    property ParamReadType: K0ParamReadType read FParamReadType write FParamReadType default k0prtReadOnce;
    property CharSet: Ts0TagCharSet read FCharSet;
    property Source: TStream read FSource write SetSource;    
  end;

implementation

uses
  s0CType;

{ Ts0TagCharSet }

constructor Ts0TagCharSet.Create;
begin
  inherited;
  FTagBegin   := '<';
  FTagEnd     := '>';
  FDelimInTag := ' ';
  FParamDelim := '=';
  FTerminaterTagHead := '/';
  FNullElementTagTail := '/';
end;

{ Ts0TagParser }

function Ts0TagParser.CheckDelimInTag(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
begin
  Result := False;
  if AChar = CharSet.DelimInTag then
  begin
    if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
    FoundDelimInTag(AChar);
    Result := True;
    Exit;
  end;
end;

function Ts0TagParser.CheckParamDelim(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
begin
  Result := False;
  if FParamReadType <> k0prtSeparateRead then Exit;
  if AChar = CharSet.ParamDelim then
  begin
    if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
    FoundParamDelim(AChar);
    Result := True;
    Exit;
  end;
end;

function Ts0TagParser.CheckTagBegin(AChar: Char;
  AEvent: K0TokenCheckedEvent): Boolean;
begin
  Result := False;
  if AChar = CharSet.TagBegin then
  begin
    if Self.ReadStrIsNotNull then FoundEndOfNoTag;
    Result := True;
    FoundBegin(AChar);
    Exit;
  end;
end;

function Ts0TagParser.CheckTagEnd(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
var
  nextChar: Char;
begin
  Result := False;
  if AChar = CharSet.NullElementTagTail then
  begin
    FSource.Read(nextChar, 1);
    if nextChar = CharSet.TagEnd then
    begin
      if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
      Self.FTagEndTail := AChar;
      FoundEnd(nextChar);
      Result := True;
      Exit;
    end
    else
      FSource.Seek(-1, soFromCurrent);
  end
  else
  if AChar = CharSet.TagEnd then
  begin
    if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
    Self.FTagEndTail := #0;
    FoundEnd(AChar);
    Result := True;
    Exit;
  end;
end;

procedure Ts0TagParser.ClearReadStr;
begin
  FReadStr := '';
end;

procedure Ts0TagParser.ClearTagProp;
begin
  FTagNameHead := #0;
  FTagEndTail  := #0;
end;

constructor Ts0TagParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FParamReadType := k0prtReadOnce;
  FCharSet := Ts0TagCharSet.Create;
end;

destructor Ts0TagParser.Destroy;
begin
  FreeAndNil(FCharSet);
  inherited;           
end;

procedure Ts0TagParser.Execute;
begin
  Assert(FSource <> nil);
  if not FindNextChar(CharSet.TagBegin) then Exit;
  FCurrentToken := k0tptBegin;
  FoundBegin(CharSet.TagBegin);
  ReadNext;
end;

function Ts0TagParser.FindNextChar(AChar: Char): Boolean;
var
  c: Char;
begin
  Result := False;
  while FSource.Position < FSource.Size do
  begin
    FSource.Read(c, 1);
    if c = AChar then
    begin
      Result := True;
      Exit;
    end;
    FReadStr := FReadStr + c;
  end;
end;

procedure Ts0TagParser.FindNextOfBegin;
var
  c: Char;
begin
  while FSource.Position < FSource.Size do
  begin
    FSource.Read(c, 1);
    if CheckTagEnd(c, FoundName) then Exit;
    if CheckDelimInTag(c, FoundName) then Exit;
    FReadStr := FReadStr + c;
  end;
end;

procedure Ts0TagParser.FindNextOfDelimInTag;
var
  c: Char;
  singleQuoted: Boolean;
  doubleQuoted: Boolean;
begin
  singleQuoted := False;
  doubleQuoted := False;
  while FSource.Position < FSource.Size do
  begin
    FSource.Read(c, 1);
    if (c = '''') and (not doubleQuoted) then singleQuoted := not singleQuoted;
    if (c = '"')  and (not singleQuoted) then doubleQuoted := not doubleQuoted;
    if singleQuoted or doubleQuoted then
    begin
      FReadStr := FReadStr + c;
      Continue;
    end;
    //
    if CheckTagEnd(c, FoundParam) then Exit;
    if CheckDelimInTag(c, FoundParam) then Exit;
    if CheckParamDelim(c, FoundParam) then Exit;
    FReadStr := FReadStr + c;
  end;
end;

procedure Ts0TagParser.FindNextOfEnd;
var
  c: Char;
begin
  while FSource.Position < FSource.Size do
  begin
    FSource.Read(c, 1);
    if CheckTagBegin(c, FoundEndOfNoTag) then Exit;
    FReadStr := FReadStr + c;
  end;
end;

procedure Ts0TagParser.FindNextOfParamDelim;
var
  c: Char;
  singleQuoted: Boolean;
  doubleQuoted: Boolean;
begin
  singleQuoted := False;
  doubleQuoted := False;
  while FSource.Position < FSource.Size do
  begin
    FSource.Read(c, 1);
    if (c = '''') and (not doubleQuoted) then singleQuoted := not singleQuoted;
    if (c = '"')  and (not singleQuoted) then doubleQuoted := not doubleQuoted;
    if singleQuoted or doubleQuoted then
    begin
      FReadStr := FReadStr + c;
      Continue;
    end;
    //
    if CheckTagEnd(c, FoundParamValue) then Exit;
    if CheckDelimInTag(c, FoundParamValue) then Exit;
    FReadStr := FReadStr + c;
  end;
end;

procedure Ts0TagParser.FindNextToken;
begin
  ClearReadStr;
  case FCurrentToken of
    k0tptBegin     : FindNextOfBegin     ;
    k0tptEnd       : FindNextOfEnd       ;
    k0tptDelimInTag: FindNextOfDelimInTag;
    k0tptParamDelim: FindNextOfParamDelim;
  end;
end;

procedure Ts0TagParser.FoundBegin(AChar: Char);
  procedure ReadIsNullElement;
  var
    bufPos: Integer;
    c: Char;
  begin
    if not(FSource.Position < FSource.Size) then Exit;
    bufPos := FSource.Position;
    FSource.Read(c, 1);
    if Ts0Ctype.IsSign(c) then
      FTagNameHead := c
    else
    begin
      FSource.Position := bufPos;
    end;
  end;
begin
  ClearTagProp;
  ReadIsNullElement;
  FCurrentToken := k0tptBegin;
end;

procedure Ts0TagParser.FoundDelimInTag(AChar: Char);
begin
  FCurrentToken := k0tptDelimInTag;
end;

procedure Ts0TagParser.FoundEnd(AChar: Char);
begin
  FCurrentToken := k0tptEnd;
end;

procedure Ts0TagParser.FoundEndOfNoTag;
begin
  ClearTagProp;
  FCurrentToken := k0tptNone;
end;

procedure Ts0TagParser.FoundName;
begin
  FCurrentToken := k0tptName;
end;

procedure Ts0TagParser.FoundParam;
begin
  FCurrentToken := k0tptParam;
end;

procedure Ts0TagParser.FoundParamDelim(AChar: Char);
begin
  FCurrentToken := k0tptParamDelim;
end;

procedure Ts0TagParser.FoundParamValue;
begin
  FCurrentToken := k0tptParamValue;
end;

function Ts0TagParser.GetReadStrIsNotNull: Boolean;
begin
  Result := (FReadStr <> '');
end;

procedure Ts0TagParser.ReadNext;
begin
  while FSource.Position < FSource.Size do
  begin
    FindNextToken;
  end;
end;

procedure Ts0TagParser.SetSource(const Value: TStream);
begin
  FSource := Value;
end;

end.

