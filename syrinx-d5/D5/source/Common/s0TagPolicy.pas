{-----------------------------------------------------------------------------
 Unit Name: s0TagPolicy
 Author:    akima
 Purpose:
 TestCase: tc_s0TagPolicy
 $History: s0TagPolicy.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/05/14   Time: 3:29
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/24   Time: 12:06
 * Updated in $/source/D5Integrated
 * 複数の種類の文字によって、タグ中やパラメータが区切られることもありうる
 * ことを考慮
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/02/21   Time: 23:13
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0TagPolicy;

interface

uses
  SysUtils, Classes,
  Contnrs;

type
  K0TagPolicyName = type string;

  Ts0TagPolicyClass = class of Ts0TagPolicy; 
  Ts0TagPolicy = class(TPersistent)
  private
    FNullElementTagNames: TStrings;
    FDelimsInTag: string;
    FParamDelims: string;
    FParamQuote: Char;
    procedure SetNullElementTagNames(const Value: TStrings);
  protected
    FTagBegin: Char;
    FTagEnd: Char;
    FDelimInTag: Char;
    FParamDelim: Char;
    FTerminateHeader: Char;
    FNullElementFooter: Char;
    FTagHeaders: string;
    FTagFooters: string;
    FPolicyName: K0TagPolicyName;
  protected
    procedure DoInitNullElementTagNames;
    procedure InitNullElementTagNames(ATagNames: TStrings); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IsTagBegin(AChar: Char): Boolean; virtual;
    function IsTagEnd(AChar: Char): Boolean; virtual;
    function IsDelimInTag(AChar: Char): Boolean; virtual;
    function IsParamDelim(AChar: Char): Boolean; virtual;
    function IsTerminateHeader(AChar: Char): Boolean; virtual;
    function IsNullElementFooter(AChar: Char): Boolean; virtual;
  public
    function IsOneOfHeaders(AChar: Char): Boolean; virtual;
    function IsOneOfFooters(AChar: Char): Boolean; virtual;
    function IsOneOfNullElementName(ATagName: string): Boolean; virtual;
  //public
  protected
    procedure DecodeString(var AStr: string); virtual;
    procedure EncodeString(var AStr: string); virtual;
  public
    procedure DecodeParamValue(var AStr: string); virtual;
    procedure EncodeParamValue(var AStr: string); virtual;
  published
    property PolicyName: K0TagPolicyName read FPolicyName write FPolicyName;
    property TagBegin: Char read FTagBegin write FTagBegin default '<';
    property TagEnd: Char read FTagEnd write FTagEnd default '>';
    property DelimInTag: Char read FDelimInTag write FDelimInTag default ' ';
    property ParamDelim: Char read FParamDelim write FParamDelim default '=';
    property TagHeaders: string read FTagHeaders write FTagHeaders;
    property TagFooters: string read FTagFooters write FTagFooters;
    property DelimsInTag: string read FDelimsInTag write FDelimsInTag;
    property ParamDelims: string read FParamDelims write FParamDelims;
    property ParamQuote: Char read FParamQuote write FParamQuote default '"';
    property TerminateHeader: Char read FTerminateHeader write FTerminateHeader default '/';
    property NullElementFooter: Char read FNullElementFooter write FNullElementFooter default '/';
    property NullElementTagNames: TStrings read FNullElementTagNames write SetNullElementTagNames;
  end;

type
  Ts0TagPolicyComponent = class(TComponent)
  private
    FPolicyName: K0TagPolicyName;
  protected
    function GetPolicy: Ts0TagPolicy; virtual;
    procedure SetPolicyName(const Value: K0TagPolicyName); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override; 
    property Policy: Ts0TagPolicy read GetPolicy;
  published
    property PolicyName: K0TagPolicyName read FPolicyName write SetPolicyName;
  end;

type
  Es0TagPolicyComponent = class(Exception);

type
  Ts0XMLPolicy = class(Ts0TagPolicy)
  protected
    procedure InitNullElementTagNames(ATagNames: TStrings); override;
  public
    constructor Create; override;
    function IsOneOfNullElementName(ATagName: string): Boolean; override;
    procedure DecodeString(var AStr: string); override;
    procedure EncodeString(var AStr: string); override;
  end;

type
  Ts0HTMLPolicy = class(Ts0TagPolicy)
  protected
    procedure InitNullElementTagNames(ATagNames: TStrings); override;
  public
    constructor Create; override;
    function IsOneOfNullElementName(ATagName: string): Boolean; override;
  end;

type
  Ts0TagPolicyRegister = class
  private
    FPolicies: TObjectList;
    FPolicyClasses: TStringList;
    function FindClass(AName: string): Ts0TagPolicyClass;
    function FindInstance(AName: string): Ts0TagPolicy;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure RegisterTagPolicy(APolicy: Ts0TagPolicy);
    procedure RegisterTagPolicyClass(APolicyName: K0TagPolicyName; APolicyClass: Ts0TagPolicyClass);
    procedure UnRegisterTagPolicy(APolicy: Ts0TagPolicy);
    procedure UnRegisterTagPolicyClass(APolicyName: K0TagPolicyName; APolicyClass: Ts0TagPolicyClass);
    procedure GetRegisteredNames(Dest: TStrings);
    function GetTagPolicy(APolicyName: K0TagPolicyName): Ts0TagPolicy;
    function IsRegistered(APolicyName: K0TagPolicyName): Boolean;
    class function Instance: Ts0TagPolicyRegister;
  end;

implementation

uses
  s0StringHelper;

{ Ts0TagPolicy }

procedure Ts0TagPolicy.Assign(Source: TPersistent);
var
  src: Ts0TagPolicy;
begin
  if not(Source is Ts0TagPolicy) then Exit;
  src := Ts0TagPolicy(Source);
  Self.PolicyName          := src.PolicyName         ;
  Self.TagBegin            := src.TagBegin           ;
  Self.TagEnd              := src.TagEnd             ;
  Self.DelimInTag          := src.DelimInTag         ;
  Self.ParamDelim          := src.ParamDelim         ;
  Self.TagHeaders          := src.TagHeaders         ;
  Self.TagFooters          := src.TagFooters         ;
  Self.DelimsInTag         := src.DelimsInTag        ;
  Self.ParamDelims         := src.ParamDelims        ;
  Self.ParamQuote          := src.ParamQuote         ;
  Self.TerminateHeader     := src.TerminateHeader    ;
  Self.NullElementFooter   := src.NullElementFooter  ;
  Self.NullElementTagNames := src.NullElementTagNames;
end;

constructor Ts0TagPolicy.Create;
begin
  inherited;
  FTagBegin := '<';
  FTagEnd := '>';
  FDelimInTag := ' ';
  FParamDelim := '=';
  FParamQuote := '"';
  FTerminateHeader := '/';
  FNullElementFooter := '/';
  FNullElementTagNames := TStringList.Create;
  DoInitNullElementTagNames;
end;

procedure Ts0TagPolicy.DecodeParamValue(var AStr: string);
begin
  if ParamQuote = #0 then
    // do nothing
  else
  if AStr = StringOfChar(ParamQuote, 2) then
    AStr := ''
  else
    AStr := Ts0StringHelper.ExtractQuotedStr(AStr, ParamQuote);
  DecodeString(AStr);
end;

procedure Ts0TagPolicy.DecodeString(var AStr: string);
begin
end;

destructor Ts0TagPolicy.Destroy;
begin
  FreeAndNil(FNullElementTagNames);
  inherited Destroy;
end;

procedure Ts0TagPolicy.DoInitNullElementTagNames;
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create;
  try
    sl.Assign(NullElementTagNames);
    InitNullElementTagNames(sl);
    NullElementTagNames.Clear;
    for i := 0 to sl.Count -1 do
      NullElementTagNames.Add(LowerCase(sl.Strings[i]));
    TStringList(NullElementTagNames).Sorted := True;
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0TagPolicy.EncodeParamValue(var AStr: string);
begin
  EncodeString(AStr);
  if ParamQuote = #0 then
    // do nothing
  else
    AStr := Ts0StringHelper.QuotedStr(AStr, ParamQuote);
end;

procedure Ts0TagPolicy.EncodeString(var AStr: string);
begin
end;

procedure Ts0TagPolicy.InitNullElementTagNames(ATagNames: TStrings);
begin
end;

function Ts0TagPolicy.IsDelimInTag(AChar: Char): Boolean;
begin
  Result := False;
  if AChar = #0 then Exit;
  Result := True;
  if AChar = FDelimInTag then Exit;
  if Pos(AChar, FDelimsInTag) > 0 then Exit;
  Result := False;
end;

function Ts0TagPolicy.IsNullElementFooter(AChar: Char): Boolean;
begin
  Result := (AChar <> #0) and (AChar = FNullElementFooter)
end;

function Ts0TagPolicy.IsOneOfFooters(AChar: Char): Boolean;
begin
  Result := Pos(AChar, TagFooters) > 0;
end;

function Ts0TagPolicy.IsOneOfHeaders(AChar: Char): Boolean;
begin
  Result := Pos(AChar, TagHeaders) > 0;
end;

function Ts0TagPolicy.IsOneOfNullElementName(ATagName: string): Boolean;
begin
  Result := (NullElementTagNames.IndexOf(LowerCase(ATagName)) > -1);
end;

function Ts0TagPolicy.IsParamDelim(AChar: Char): Boolean;
begin
  Result := False;
  if AChar = #0 then Exit;
  Result := True;
  if AChar = FParamDelim then Exit;
  if Pos(AChar, FParamDelims) > 0 then Exit;
  Result := False;
end;

function Ts0TagPolicy.IsTagBegin(AChar: Char): Boolean;
begin
  Result := (AChar <> #0) and (AChar = FTagBegin);
end;

function Ts0TagPolicy.IsTagEnd(AChar: Char): Boolean;
begin
  Result := (AChar <> #0) and (AChar = FTagEnd);
end;

function Ts0TagPolicy.IsTerminateHeader(AChar: Char): Boolean;
begin
  Result := (AChar <> #0) and (AChar = FTerminateHeader);
end;

procedure Ts0TagPolicy.SetNullElementTagNames(const Value: TStrings);
begin
  FNullElementTagNames.Assign(Value);
end;

{ Ts0TagPolicyComponent }

procedure Ts0TagPolicyComponent.Assign(Source: TPersistent);
var
  src: Ts0TagPolicyComponent;
begin
//  inherited Assign(Source);
  if not (Source is Ts0TagPolicyComponent) then Exit;
  src := Ts0TagPolicyComponent(Source);
  PolicyName := src.PolicyName; 
end;

constructor Ts0TagPolicyComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPolicyName := 'HTML';
end;

resourcestring
  c9ErrMsg_NotRegisteredName = 'PolicyName"%s"は登録された名称ではありません';

function Ts0TagPolicyComponent.GetPolicy: Ts0TagPolicy;
begin
  Result := Ts0TagPolicyRegister.Instance.GetTagPolicy(PolicyName);
  if Result = nil then
    raise Es0TagPolicyComponent.CreateFmt(c9ErrMsg_NotRegisteredName, [PolicyName]);
end;

procedure Ts0TagPolicyComponent.SetPolicyName(
  const Value: K0TagPolicyName);
begin
  if FPolicyName = Value then Exit;
  FPolicyName := Value;
end;

{ Ts0XMLPolicy }

constructor Ts0XMLPolicy.Create;
begin
  inherited Create;
  PolicyName := 'XML';
  FTagBegin   := '<';
  FTagEnd     := '>';
  FDelimInTag := ' ';
  FParamDelim := '=';
  FTagHeaders := '/?!';
  FTagFooters := '/';
  FTerminateHeader := '/';
  FNullElementFooter := '/';
  FDelimsInTag := ' ' + #13;
  FParamDelims := '=';
end;

type
  Ks9SpecialChars = (
    ks9lt, ks9gt, ks9amp, ks9apos, ks9quot
  );

  Rs9CharCodeSet = packed record
    C: Char;
    S: string;
  end;

type
  Ks9CodingArray = array[Ks9SpecialChars] of Rs9CharCodeSet;

{
  ここを参照しました。
  http://www.asahi-net.or.jp/~ps8a-okzk/xml/xml_2/escape.html
}
const
  c9EntityRefCodings: Ks9CodingArray = (
    (C: '<' ; S: '&lt;'),
    (C: '>' ; S: '&gt;'),
    (C: '&' ; S: '&amp;'),
    (C: ''''; S: '&apos;'),
    (C: '"' ; S: '&quot;')
  );

const
  c9CharRefCodings: Ks9CodingArray = (
    (C: '<' ; S: '&#38;#60;'),
    (C: '>' ; S: '&#62;'),
    (C: '&' ; S: '&#38;#38;'),
    (C: ''''; S: '&#39;'),
    (C: '"' ; S: '&#34;')
  );

{
  <!ENTITY lt "&#38;#60;">
  <!ENTITY gt "&#62;">
  <!ENTITY amp "&#38;#38;">
  <!ENTITY apos "&#39;">
  <!ENTITY quot "&#34;">
}

procedure Ts0XMLPolicy.DecodeString(var AStr: string);
var
  i: Ks9SpecialChars;
begin
  for i := Low(Ks9SpecialChars) to High(Ks9SpecialChars) do
    AStr := StringReplace(AStr, c9EntityRefCodings[i].S, c9EntityRefCodings[i].C, [rfReplaceAll]);
end;

procedure Ts0XMLPolicy.EncodeString(var AStr: string);
var
  i: Ks9SpecialChars;
begin
  for i := Low(Ks9SpecialChars) to High(Ks9SpecialChars) do
    AStr := StringReplace(AStr, c9EntityRefCodings[i].C, c9EntityRefCodings[i].S, [rfReplaceAll]);
end;

procedure Ts0XMLPolicy.InitNullElementTagNames(ATagNames: TStrings);
begin
  ATagNames.Clear;
end;

function Ts0XMLPolicy.IsOneOfNullElementName(ATagName: string): Boolean;
begin
  Result := False;
end;

{ Ts0HTMLPolicy }

constructor Ts0HTMLPolicy.Create;
begin
  inherited Create;
  PolicyName := 'HTML';
  FTagBegin   := '<';
  FTagEnd     := '>';
  FDelimInTag := ' ';
  FParamDelim := '=';
  FTagHeaders := '/?!';
  FTagFooters := '/';
  FTerminateHeader := '/';
  FNullElementFooter := #0;
  FDelimsInTag := ' ' + #13;
  FParamDelims := '=';
end;

procedure Ts0HTMLPolicy.InitNullElementTagNames(ATagNames: TStrings);
begin
  ATagNames.Add('meta');
  ATagNames.Add('img');
  ATagNames.Add('br');
  ATagNames.Add('link');
  ATagNames.Add('li');
  ATagNames.Add('hr');
//  ATagNames.Add('font');
  ATagNames.Add('basefont');
  ATagNames.Add('input');
  inherited InitNullElementTagNames(ATagNames);
end;

function Ts0HTMLPolicy.IsOneOfNullElementName(ATagName: string): Boolean;
begin
  Result := inherited IsOneOfNullElementName(ATagName);
  if Result then Exit;
  Result := (Pos(':', ATagName) > 0);
end;

{ Ts0TagPolicyRegister }

constructor Ts0TagPolicyRegister.Create;
begin
  inherited Create;
  FPolicies := TObjectList.Create(True);
  FPolicyClasses := TStringList.Create;
end;

destructor Ts0TagPolicyRegister.Destroy;
begin
  FreeAndNil(FPolicyClasses);
  FreeAndNil(FPolicies);
  inherited;
end;

function Ts0TagPolicyRegister.FindClass(AName: string): Ts0TagPolicyClass;
var
  idx: Integer;
begin
  Result := nil;
  AName := LowerCase(AName);
  idx := FPolicyClasses.IndexOf(AName);
  if idx < 0 then Exit;
  Result := Ts0TagPolicyClass( FPolicyClasses.Objects[idx] );
end;

function Ts0TagPolicyRegister.FindInstance(AName: string): Ts0TagPolicy;
var
  i: Integer;
begin
  for i := 0 to FPolicies.Count -1 do
  begin
    Assert(FPolicies.Items[i] is Ts0TagPolicy);
    Result := Ts0TagPolicy(FPolicies.Items[i]);
    if SameText(Result.PolicyName, AName) then
      Exit;
  end;
  Result := nil;
end;

procedure Ts0TagPolicyRegister.GetRegisteredNames(Dest: TStrings);
  procedure GetNamesFromInstances(d: TStrings);
  var
    i: Integer;
    t: Ts0TagPolicy;
  begin
    for i := 0 to FPolicies.Count -1 do
    begin
      Assert(FPolicies.Items[i] is Ts0TagPolicy);
      t := Ts0TagPolicy(FPolicies.Items[i]);
      if d.IndexOf(t.PolicyName) > -1 then Continue;
      d.Add(t.PolicyName);
    end;
  end;
  procedure GetNamesFromClasses(d: TStrings);
  var
    i: Integer;
  begin
    for i := 0 to FPolicyClasses.Count -1 do
    begin
      if d.IndexOf(FPolicyClasses.Strings[i]) > -1 then Continue;
      d.Add(FPolicyClasses.Strings[i]);
    end
  end;
begin
  Dest.Clear;
  GetNamesFromInstances(Dest);
  GetNamesFromClasses(Dest);
end;

function Ts0TagPolicyRegister.GetTagPolicy(
  APolicyName: K0TagPolicyName): Ts0TagPolicy;
  function CreatePolicy(AClass: Ts0TagPolicyClass): Ts0TagPolicy;
  begin
    Result := nil;
    if AClass = nil then Exit;
    Result := AClass.Create;
    FPolicies.Add(Result);
  end;
begin
  Result := FindInstance(APolicyName);
  if Result <> nil then Exit;
  Result := CreatePolicy( FindClass(APolicyName) );
end;

var
  g9Register: Ts0TagPolicyRegister = nil;

class function Ts0TagPolicyRegister.Instance: Ts0TagPolicyRegister;
begin
  if g9Register = nil then
    g9Register := Ts0TagPolicyRegister.Create;
  Result := g9Register;
end;

function Ts0TagPolicyRegister.IsRegistered(
  APolicyName: K0TagPolicyName): Boolean;
begin
  Result := (FindInstance(APolicyName) <> nil) or (FindClass(APolicyName) <> nil);
end;

procedure Ts0TagPolicyRegister.RegisterTagPolicy(APolicy: Ts0TagPolicy);
begin
  Assert(APolicy <> nil);
  if FPolicies.IndexOf(APolicy) > -1 then Exit;
  FPolicies.Add(APolicy);
end;

procedure Ts0TagPolicyRegister.RegisterTagPolicyClass(
  APolicyName: K0TagPolicyName; APolicyClass: Ts0TagPolicyClass);
begin
  APolicyName := LowerCase(APolicyName);
  if FPolicyClasses.IndexOf(APolicyName) > -1 then Exit;
  FPolicyClasses.AddObject(APolicyName, TObject(APolicyClass));
end;

procedure Ts0TagPolicyRegister.UnRegisterTagPolicy(APolicy: Ts0TagPolicy);
begin
  while FPolicies.Remove(APolicy) > -1 do ;
end;

procedure Ts0TagPolicyRegister.UnRegisterTagPolicyClass(
  APolicyName: K0TagPolicyName; APolicyClass: Ts0TagPolicyClass);
var
  idx: Integer;
begin
  APolicyName := LowerCase(APolicyName);
  repeat
    idx := FPolicyClasses.IndexOf(APolicyName);
    if idx > -1 then
      FPolicyClasses.Delete(idx);
  until idx < 0;
end;

initialization
  Ts0TagPolicyRegister.Instance.RegisterTagPolicyClass('XML', Ts0XMLPolicy);
  Ts0TagPolicyRegister.Instance.RegisterTagPolicyClass('HTML', Ts0HTMLPolicy);

finalization
  FreeAndNil(g9Register);

end.
