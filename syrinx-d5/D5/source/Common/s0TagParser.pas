{-----------------------------------------------------------------------------
 Unit Name: s0TagParser
 Author:    akima
 Purpose:
 TestCase: tc_s0TagParser
 $History: s0TagParser.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/21   Time: 23:28
 * Updated in $/source/D5Integrated
 * Ts0TagCharSetをs0TagPolicyユニットに移動。クラス名もTs0TagPolicyに変更し
 * た。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/19   Time: 21:23
 * Updated in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0TagParser;

interface

uses
  SysUtils, Classes,
  s0TagPolicy;

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
  K0ParamReadType = (k0prtReadOnce, k0prtSeparateRead);

type
  K0TokenCheckedEvent = procedure of object; 


type
  Ts0TagParser = class(Ts0TagPolicyComponent)
  private
    FSource: TStream;
    FReadStr: string;
    FCurrentToken: K0TaggedPageToken;
    FParamReadType: K0ParamReadType;
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
    function CheckSourceSize(AEvent: K0TokenCheckedEvent): Boolean;
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
    procedure FoundFooter(AChar: Char); virtual;
    procedure FoundHeader(AChar: Char); virtual;
    procedure FoundName; virtual;
    procedure FoundParam; virtual;
    procedure FoundParamDelim(AChar: Char); virtual;
    procedure FoundParamValue; virtual;
  protected
    procedure ClearReadStr; virtual;
    procedure ReadNext; virtual;
    property ReadStrIsNotNull: Boolean read GetReadStrIsNotNull;
    property CurrentToken: K0TaggedPageToken read FCurrentToken;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; virtual;
    property ReadStr: string read FReadStr;
    property ParamReadType: K0ParamReadType read FParamReadType write FParamReadType default k0prtReadOnce;
    property Source: TStream read FSource write SetSource;
  end;

implementation

uses
  s0CType;

{ Ts0TagParser }

function Ts0TagParser.CheckDelimInTag(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
begin
  Result := False;
  if not Policy.IsDelimInTag(AChar) then Exit;
  if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
  FoundDelimInTag(AChar);
  Result := True;
end;

function Ts0TagParser.CheckParamDelim(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
begin
  Result := False;
  if FParamReadType <> k0prtSeparateRead then Exit;
  if not Policy.IsParamDelim(AChar) then Exit;
  if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
  FoundParamDelim(AChar);
  Result := True;
end;

function Ts0TagParser.CheckSourceSize(AEvent: K0TokenCheckedEvent): Boolean;
begin
  Result := FSource.Position < FSource.Size;
  if Result then Exit;
  if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
end;

function Ts0TagParser.CheckTagBegin(AChar: Char;
  AEvent: K0TokenCheckedEvent): Boolean;
  procedure CheckTagHeader;
  var
    c: Char;
  begin
    if not CheckSourceSize(AEvent) then Exit;
    FSource.Read(c, 1);
    if Policy.IsOneOfHeaders(c) then
      FoundHeader(c)
    else
      FSource.Seek(-1, soFromCurrent);
  end;
begin
  Result := False;
  if not Policy.IsTagBegin(AChar) then Exit;
  if Self.ReadStrIsNotNull then FoundEndOfNoTag;
  Result := True;
  FoundBegin(AChar);
  CheckTagHeader;
end;

function Ts0TagParser.CheckTagEnd(AChar: Char; AEvent: K0TokenCheckedEvent): Boolean;
var
  nextChar: Char;
begin
  Result := False;
  if Policy.IsOneOfFooters(AChar) then
  begin
    FSource.Read(nextChar, 1);
    if Policy.IsTagEnd(nextChar) then
    begin
      if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
      FoundFooter(AChar);
      FoundEnd(nextChar);
      Result := True;
      Exit;
    end
    else
      FSource.Seek(-1, soFromCurrent);
  end
  else
  if Policy.IsTagEnd(AChar) then
  begin
    if ReadStrIsNotNull and Assigned(AEvent) then AEvent;
    FoundEnd(AChar);
    Result := True;
    Exit;
  end;
end;

procedure Ts0TagParser.ClearReadStr;
begin
  FReadStr := '';
end;

constructor Ts0TagParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FParamReadType := k0prtReadOnce;
end;

destructor Ts0TagParser.Destroy;
begin
  inherited;           
end;

procedure Ts0TagParser.Execute;
begin
  Assert(FSource <> nil);
  Assert(Policy <> nil);
  FCurrentToken := k0tptEnd;
  FindNextOfEnd;
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
    if Ts0Ctype.IsCntrl(c) then Continue;
    FReadStr := FReadStr + c;
  end;
  if ReadStrIsNotNull then FoundName;
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
    if Ts0Ctype.IsCntrl(c) then Continue;
    FReadStr := FReadStr + c;
  end;
  if ReadStrIsNotNull then FoundParam;
end;

procedure Ts0TagParser.FindNextOfEnd;
var
  c: Char;
begin
  while FSource.Position < FSource.Size do
  begin
    FSource.Read(c, 1);
    if CheckTagBegin(c, FoundEndOfNoTag) then Exit;
    if Ts0Ctype.IsCntrl(c) then Continue;
    FReadStr := FReadStr + c;
  end;
  if ReadStrIsNotNull then FoundEndOfNoTag;
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
    if Ts0Ctype.IsCntrl(c) then Continue;
    FReadStr := FReadStr + c;
  end;
  if ReadStrIsNotNull then FoundParamValue;
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
begin
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
  FCurrentToken := k0tptNone;
end;

procedure Ts0TagParser.FoundFooter(AChar: Char);
begin
end;

procedure Ts0TagParser.FoundHeader(AChar: Char);
begin
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

