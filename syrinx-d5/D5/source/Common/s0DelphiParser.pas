{-----------------------------------------------------------------------------
 Unit Name: s0DelphiParser
 Author:    akima
 Purpose:
 TestCase: 
 See: 
 $History: s0DelphiParser.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/18   Time: 13:55
 * Updated in $/D5/source/Common
 * BinToHex,HexToBinをコメントアウト
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
-----------------------------------------------------------------------------}

unit s0DelphiParser;

interface

uses
	SysUtils, Classes;

type
  Ts0CustomDelphiParser = class(TObject)
  private
    FSource: TStream;
    FToken: Char;
{
    procedure CheckToken(T: Char);
    procedure CheckTokenSymbol(const S: string);
}
    procedure Error(const Ident: string);
//    procedure ErrorFmt(const Ident: string; const Args: array of const);
    procedure ErrorStr(const Message: string);
{
    procedure HexToBinary(Stream: TStream);
    function SourcePos: Longint;
    function TokenComponentIdent: String;
}
  protected
  	FBufferSize: Longint;
    FOrigin: Longint;
    FBuffer: PChar;
    FBufPtr: PChar;
    FBufEnd: PChar;
    FSourcePtr: PChar;
    FSourceEnd: PChar;
    FTokenPtr: PChar;
    FStringPtr: PChar;
    FSourceLine: Integer;
    FSaveChar: Char;
    FFloatType: Char;
    FWideStr: WideString;
    procedure ReadBuffer;
    procedure SkipBlanks;
  public
    constructor Create(Stream: TStream); virtual;
    destructor Destroy; override;
    function NextToken: Char; virtual;
    function TokenFloat: Extended;
    function TokenInt: Longint;
    function TokenString: string;
    function TokenWideString: WideString;
    function TokenSymbolIs(const S: string): Boolean;
    property FloatType: Char read FFloatType;
    property SourceLine: Integer read FSourceLine;
    property Source: TStream read FSource;
    property Token: Char read FToken;
  end;

const
  //Token Object
  c0toEOF     = Char(0);
  c0toSymbol  = Char(1);
  c0toString  = Char(2);
  c0toInteger = Char(3);
  c0toFloat   = Char(4);
  c0toWString = Char(5);

type
	Ts0CommentDelphiParser = class(Ts0CustomDelphiParser)
  private
  protected
  	procedure SkipToCR(var APtr: PChar);
    procedure SkipTo(var APtr: PChar; EndChars: array of Char); overload;
    procedure SkipTo(var APtr: PChar; EC1: Char); overload;
    procedure SkipTo(var APtr: PChar; EC1, EC2: Char); overload;
    procedure SkipTo(var APtr: PChar; EC1, EC2, EC3: Char); overload;
    procedure CheckComment; virtual;
  public
    function NextToken: Char; override;
  end;

const
	c0toComment = Char(6);


type
	Ts0ReserveWordDelphiParser = class(Ts0CommentDelphiParser)
  private
    FReservedList: TStrings;
    FOrderList: TStrings;
    FWordType: Integer;
    procedure AddArrayToList(AList: TStrings; AArray: array of string);
  protected
  	procedure InitReserved; virtual;
    procedure InitOrder; virtual;
  public
    constructor Create(Stream: TStream); override;
    destructor Destroy; override;
    function NextToken: Char; override;
    property ReservedList: TStrings read FReservedList;
    property OrderList: TStrings read FOrderList;
    property WordType: Integer read FWordType write FWordType;
    function TypeByWord(AWord: string): Integer;
    function WordByType(AType: Integer): String;
    function TokenIsReserved: Boolean;
    function TokenIsOrder: Boolean;
  end;


const
  c0wtOrder    =  64;
  c0wtReserved = 128;

	//A0OrderWordType (must be sorted)
  c0owtAbsolute    = c0wtOrder +  0;
  c0owtAbstract    = c0wtOrder +  1;
  c0owtAssembler   = c0wtOrder +  2;
  c0owtAutomated   = c0wtOrder +  3;
  c0owtCdecl       = c0wtOrder +  4;
  c0owtContains    = c0wtOrder +  5;
  c0owtDefault     = c0wtOrder +  6;
  c0owtDispid      = c0wtOrder +  7;
  c0owtDynamic     = c0wtOrder +  8;
  c0owtExport      = c0wtOrder +  9;
  c0owtExternal    = c0wtOrder + 10;
  c0owtFar         = c0wtOrder + 11;
  c0owtForward     = c0wtOrder + 12;
  c0owtImplements  = c0wtOrder + 13;
  c0owtIndex       = c0wtOrder + 14;
  c0owtMessage     = c0wtOrder + 15;
  c0owtName        = c0wtOrder + 16;
  c0owtNear        = c0wtOrder + 17;
  c0owtNodefault   = c0wtOrder + 18;
  c0owtOverload    = c0wtOrder + 19;
  c0owtOverride    = c0wtOrder + 20;
  c0owtPackage     = c0wtOrder + 21;
  c0owtPascal      = c0wtOrder + 22;
  c0owtPrivate     = c0wtOrder + 23;
  c0owtProtected   = c0wtOrder + 24;
  c0owtPublic      = c0wtOrder + 25;
  c0owtPublished   = c0wtOrder + 26;
  c0owtRead        = c0wtOrder + 27;
  c0owtReadonly    = c0wtOrder + 28;
  c0owtRegister    = c0wtOrder + 29;
  c0owtReintroduce = c0wtOrder + 30;
  c0owtRequires    = c0wtOrder + 31;
  c0owtResident    = c0wtOrder + 32;
  c0owtSafecall    = c0wtOrder + 33;
  c0owtStdcall     = c0wtOrder + 34;
  c0owtStored      = c0wtOrder + 35;
  c0owtVirtual     = c0wtOrder + 36;
  c0owtWrite       = c0wtOrder + 37;
  c0owtWriteonly   = c0wtOrder + 38;

	//A0ReservedWordType (must be sorted)
  c0rwtAnd            = c0wtReserved +  0;
  c0rwtArray          = c0wtReserved +  1;
  c0rwtAs             = c0wtReserved +  2;
  c0rwtAsm            = c0wtReserved +  3;
  c0rwtBegin          = c0wtReserved +  4;
  c0rwtCase     	    = c0wtReserved +  5;
  c0rwtClass          = c0wtReserved +  6;
  c0rwtConst          = c0wtReserved +  7;
  c0rwtConstructor    = c0wtReserved +  8;
  c0rwtDestructor     = c0wtReserved +  9;
  c0rwtDispinterface  = c0wtReserved + 10;
  c0rwtDiv            = c0wtReserved + 11;
  c0rwtDo             = c0wtReserved + 12;
  c0rwtDownto         = c0wtReserved + 13;
  c0rwtElse           = c0wtReserved + 14;
  c0rwtEnd            = c0wtReserved + 15;
  c0rwtExcept         = c0wtReserved + 16;
  c0rwtExports        = c0wtReserved + 17;
  c0rwtFile           = c0wtReserved + 18;
  c0rwtFinalization   = c0wtReserved + 19;
  c0rwtFinally        = c0wtReserved + 20;
  c0rwtFor            = c0wtReserved + 21;
  c0rwtFunction       = c0wtReserved + 22;
  c0rwtGoto           = c0wtReserved + 23;
  c0rwtIf             = c0wtReserved + 24;
  c0rwtImplementation = c0wtReserved + 25;
  c0rwtIn             = c0wtReserved + 26;
  c0rwtInherited      = c0wtReserved + 27;
  c0rwtInitialization = c0wtReserved + 28;
  c0rwtInline         = c0wtReserved + 29;
  c0rwtInterface      = c0wtReserved + 30;
  c0rwtIs             = c0wtReserved + 31;
  c0rwtLabel          = c0wtReserved + 32;
  c0rwtLibrary        = c0wtReserved + 33;
  c0rwtMod            = c0wtReserved + 34;
  c0rwtNil            = c0wtReserved + 35;
  c0rwtNot            = c0wtReserved + 36;
  c0rwtObject         = c0wtReserved + 37;
  c0rwtOf             = c0wtReserved + 38;
  c0rwtOr             = c0wtReserved + 39;
  c0rwtOut            = c0wtReserved + 40;
  c0rwtPacked         = c0wtReserved + 41;
  c0rwtProcedure      = c0wtReserved + 42;
  c0rwtProgram        = c0wtReserved + 43;
  c0rwtProperty       = c0wtReserved + 44;
  c0rwtRaise          = c0wtReserved + 45;
  c0rwtRecord         = c0wtReserved + 46;
  c0rwtRepeat         = c0wtReserved + 47;
  c0rwtResourcestring = c0wtReserved + 48;
  c0rwtSet            = c0wtReserved + 49;
  c0rwtShl            = c0wtReserved + 50;
  c0rwtShr            = c0wtReserved + 51;
  c0rwtString         = c0wtReserved + 52;
  c0rwtThen           = c0wtReserved + 53;
  c0rwtThreadvar      = c0wtReserved + 54;
  c0rwtTo             = c0wtReserved + 55;
  c0rwtTry            = c0wtReserved + 56;
  c0rwtType           = c0wtReserved + 57;
  c0rwtUnit           = c0wtReserved + 58;
  c0rwtUntil          = c0wtReserved + 59;
  c0rwtUses           = c0wtReserved + 60;
  c0rwtVar            = c0wtReserved + 61;
  c0rwtWhile          = c0wtReserved + 62;
  c0rwtWith           = c0wtReserved + 63;
  c0rwtXor            = c0wtReserved + 64;




implementation

const
//  ParseBufSize = 4096 * 8;
  SParseError = '%1:d 行で%0:s';
  SIdentifierExpected = '識別子が必要です';
  SStringExpected = '文字列が必要です';
  SNumberExpected = '数値が必要です';
  SCharExpected = '''''%s'''' が必要です';
  SSymbolExpected = '%s が必要です';
  SInvalidNumber = '数値が不正です';
  SInvalidString = '文字列定数が不正です';
  SInvalidProperty = '不正なプロパティの値です';
  SInvalidBinary = 'バイナリ値が不正です';
  SLineTooLong = '行が長すぎます';



{
procedure BinToHex(Buffer, Text: PChar; BufSize: Integer); assembler;
asm
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EDX,0
        JMP     @@1
@@0:    DB      '0123456789ABCDEF'
@@1:    LODSB
        MOV     DL,AL
        AND     DL,0FH
        MOV     AH,@@0.Byte[EDX]
        MOV     DL,AL
        SHR     DL,4
        MOV     AL,@@0.Byte[EDX]
        STOSW
        DEC     ECX
        JNE     @@1
        POP     EDI
        POP     ESI
end;

function HexToBin(Text, Buffer: PChar; BufSize: Integer): Integer; assembler;
asm
        PUSH    ESI
        PUSH    EDI
        PUSH    EBX
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EBX,EDX
        MOV     EDX,0
        JMP     @@1
@@0:    DB       0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1
        DB      -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1
        DB      -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        DB      -1,10,11,12,13,14,15
@@1:    LODSW
        CMP     AL,'0'
        JB      @@2
        CMP     AL,'f'
        JA      @@2
        MOV     DL,AL
        MOV     AL,@@0.Byte[EDX-'0']
        CMP     AL,-1
        JE      @@2
        SHL     AL,4
        CMP     AH,'0'
        JB      @@2
        CMP     AH,'f'
        JA      @@2
        MOV     DL,AH
        MOV     AH,@@0.Byte[EDX-'0']
        CMP     AH,-1
        JE      @@2
        OR      AL,AH
        STOSB
        DEC     ECX
        JNE     @@1
@@2:    MOV     EAX,EDI
        SUB     EAX,EBX
        POP     EBX
        POP     EDI
        POP     ESI
end;
}

constructor Ts0CustomDelphiParser.Create(Stream: TStream);
begin
  inherited Create;
  FSource {FStream} := Stream;
  FBufferSize := 4096;
  GetMem(FBuffer, FBufferSize);
  FBuffer[0] := #0;
  FBufPtr := FBuffer;
  FBufEnd := FBuffer + FBufferSize;
  FSourcePtr := FBuffer;
  FSourceEnd := FBuffer;
  FTokenPtr := FBuffer;
  FSourceLine := 1;
//  NextToken;
end;

destructor Ts0CustomDelphiParser.Destroy;
begin
  if FBuffer <> nil then
  begin
    FSource {FStream}.Seek(Longint(FTokenPtr) - Longint(FBufPtr), 1);
    FreeMem(FBuffer, FBufferSize);
  end;
end;

{
procedure Ts0CustomDelphiParser.CheckToken(T: Char);
begin
  if Token <> T then
    case T of
      c0toSymbol : Error(SIdentifierExpected);
      c0toString,
      c0toWString: Error(SStringExpected);
      c0toInteger,
      c0toFloat  : Error(SNumberExpected);
      else ErrorFmt(SCharExpected, [T]);
    end;
end;

procedure Ts0CustomDelphiParser.CheckTokenSymbol(const S: string);
begin
  if not TokenSymbolIs(S) then ErrorFmt(SSymbolExpected, [S]);
end;
}

procedure Ts0CustomDelphiParser.Error(const Ident: string);
begin
  ErrorStr(Ident);
end;

{
procedure Ts0CustomDelphiParser.ErrorFmt(const Ident: string; const Args: array of const);
begin
  ErrorStr(Format(Ident, Args));
end;
}

procedure Ts0CustomDelphiParser.ErrorStr(const Message: string);
begin
  raise EParserError.CreateFmt(SParseError, [Message, FSourceLine]);
end;

(*
procedure Ts0CustomDelphiParser.HexToBinary(Stream: TStream);
var
  Count: Integer;
  Buffer: array[0..255] of Char;
begin
  SkipBlanks;
  while FSourcePtr^ <> '}' do
  begin
    Count := HexToBin(FSourcePtr, Buffer, SizeOf(Buffer));
    if Count = 0 then Error(SInvalidBinary);
    Stream.Write(Buffer, Count);
    Inc(FSourcePtr, Count * 2);
    SkipBlanks;
  end;
  NextToken;
end;
*)

function Ts0CustomDelphiParser.NextToken: Char;
var
  P: PChar;

  function GetValueFromChar(var pc: PChar): Integer;
  begin
    Result := 0;
    while pc^ in ['0'..'9'] do begin
      Result := Result * 10 + (Ord(pc^) - Ord('0'));
      Inc(pc);
    end;
  end;

  function CheckSingleQuote(var pc: PChar): Boolean;
  begin
    Result := True;
    Inc(pc);
    if pc^ <> '''' then Result := False;
  end;

  function IncludeWideStr(pc: PChar): Boolean;
  var
    val: Integer;
    l: Integer;
  begin
    Result := False;
    l := 0;
    while True do
      case pc^ of
        '#':
          begin
            Inc(pc);
            val := GetValueFromChar(pc);
            if (val > 255) then Result := True;
            Inc(l);
          end;
        '''':
          begin
            Inc(pc);
            while True do begin
              case pc^ of
                #0,
                #10,
                #13: Error(SInvalidString);
                '''': if not CheckSingleQuote(pc) then Break;
              end;
              Inc(l);
              Inc(pc);
            end;
          end;
      else
        Break;
      end;
		if Result then SetLength(FWideStr, l);
  end;

  function SkipStringChar: Char;
  var
    I, J: Integer;
    IsWideStr: Boolean;
    S: PChar;
  begin
    S := P;
    IsWideStr := IncludeWideStr(P);
    J := 1;
    while True do
      case P^ of
        '#':
          begin
            Inc(P);
            I := GetValueFromChar(P);
            if IsWideStr then begin
              FWideStr[J] := WideChar(SmallInt(I));
              Inc(J);
            end else begin
              S^ := Chr(I);
              Inc(S);
            end;
          end;
        '''':
          begin
            Inc(P);
            while True do begin
              case P^ of
                #0, #10, #13: Error(SInvalidString);
                '''': if not CheckSingleQuote(P) then Break;
              end;
              if IsWideStr then begin
                FWideStr[J] := WideChar(P^);
                Inc(J);
              end else begin
                S^ := P^;
                Inc(S);
              end;
              Inc(P);
            end;
          end;
      else
        Break;
      end;
    FStringPtr := S;
    if IsWideStr then Result := c0toWString
                 else Result := c0toString;
  end;

  
  function SkipSymbolChar: Char;
  begin
    Inc(P);
    while P^ in ['A'..'Z', 'a'..'z', '0'..'9', '_'] do Inc(P);
    Result := c0toSymbol;
  end;

  function SkipIntegerChar: Char;
  begin
    Inc(P);
    while P^ in ['0'..'9', 'A'..'F', 'a'..'f'] do Inc(P);
    Result := c0toInteger;
  end;

  function SkipNumericChar: Char;
  begin
    Inc(P);
    while P^ in ['0'..'9'] do Inc(P);
    Result := c0toInteger;
    //
    if P^ in ['0'..'9', '.', 'e', 'E', '+', '-'] then Result := c0toFloat;
    while P^ in ['0'..'9', '.', 'e', 'E', '+', '-'] do Inc(P);
    //
    if (P^ in ['c', 'C', 'd', 'D', 's', 'S']) then
    begin
      Result := c0toFloat;
      FFloatType := P^;
      Inc(P);
    end else
      FFloatType := #0;
  end;

begin
  SkipBlanks;
  P := FSourcePtr;
  FTokenPtr := P;
  case P^ of
    'A'..'Z', 'a'..'z', '_': Result := SkipSymbolChar;
    '#', ''''              : Result := SkipStringChar;
    '$'       						 : Result := SkipIntegerChar;
    '-', '0'..'9'  				 : Result := SkipNumericChar;
  else
    Result := P^;
    if Result <> c0toEOF then Inc(P);
  end;
  FSourcePtr := P;
  FToken := Result;
end;

procedure Ts0CustomDelphiParser.ReadBuffer;
var
  Count: Integer;
begin
  Inc(FOrigin, FSourcePtr - FBuffer);
  FSourceEnd[0] := FSaveChar;
  Count := FBufPtr - FSourcePtr;
  if Count <> 0 then Move(FSourcePtr[0], FBuffer[0], Count);
  FBufPtr := FBuffer + Count;
  Inc(FBufPtr, FSource{FStream}.Read(FBufPtr[0], FBufEnd - FBufPtr));
  FSourcePtr := FBuffer;
  FSourceEnd := FBufPtr;
  if FSourceEnd = FBufEnd then
  begin
    FSourceEnd := LineStart(FBuffer, FSourceEnd - 1);
    if FSourceEnd = FBuffer then Error(SLineTooLong);
  end;
  FSaveChar := FSourceEnd[0];
  FSourceEnd[0] := #0;
end;

procedure Ts0CustomDelphiParser.SkipBlanks;
begin
  while True do
  begin
    case FSourcePtr^ of
      #0:
        begin
          ReadBuffer;
          if FSourcePtr^ = #0 then Exit;
          Continue;
        end;
      #10:
        Inc(FSourceLine);
      #33..#255:
        Exit;
    end;
    Inc(FSourcePtr);
  end;
end;

{
function Ts0CustomDelphiParser.SourcePos: Longint;
begin
  Result := FOrigin + (FTokenPtr - FBuffer);
end;
}

function Ts0CustomDelphiParser.TokenFloat: Extended;
begin
  if FFloatType <> #0 then Dec(FSourcePtr);
  Result := StrToFloat(TokenString);
  if FFloatType <> #0 then Inc(FSourcePtr);
end;

function Ts0CustomDelphiParser.TokenInt: Longint;
begin
  Result := StrToInt(TokenString);
end;

function Ts0CustomDelphiParser.TokenString: string;
var
  L: Integer;
begin
  if FToken = c0toString then L := FStringPtr - FTokenPtr
  										 else L := FSourcePtr - FTokenPtr;
  SetString(Result, FTokenPtr, L);
end;

function Ts0CustomDelphiParser.TokenWideString: WideString;
begin
  Result := FWideStr;
end;

function Ts0CustomDelphiParser.TokenSymbolIs(const S: string): Boolean;
begin
  Result := (Token = c0toSymbol) and (CompareText(S, TokenString) = 0);
end;

(*
function Ts0CustomDelphiParser.TokenComponentIdent: String;
var
  P: PChar;
begin
  CheckToken(c0toSymbol);
  P := FSourcePtr;
  while P^ = '.' do
  begin
    Inc(P);
    if not (P^ in ['A'..'Z', 'a'..'z', '_']) then
      Error(SIdentifierExpected);
    repeat
      Inc(P)
    until not (P^ in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
  end;
  FSourcePtr := P;
  Result := TokenString;
end;
*)

{ Ts0CommentDelphiParser }

procedure Ts0CommentDelphiParser.SkipTo(var APtr: PChar; EndChars: array of Char);
var
	match: Boolean;
  i, idx0: Integer;
begin
  while True do begin
	  match := False;
    for i := Low(EndChars) to High(EndChars) do begin
      idx0 := i - Low(EndChars);
      if (StrByteType(APtr, idx0 + 1) = mbSingleByte) and
      	 ( (APtr + idx0)^ = EndChars[i] ) then begin
        match := True;
      end
      else begin
	      Break;
      end;
    end;
    if match then Break
    else Inc(APtr);
  end;
  // ポインタが指す場所は，コメントが閉じた次の文字
  Inc(APtr, High(EndChars) - Low(EndChars) +1 ) ;
end;

procedure Ts0CommentDelphiParser.SkipTo(var APtr: PChar; EC1: Char);
begin
  while True do
    case StrByteType(APtr, 1) of
      mbSingleByte: if APtr^ = EC1 then Break
                    else Inc(APtr);
      mbLeadByte  : Inc(APtr, 2);
      else Inc(APtr);
    end;
  Inc(APtr, 1);
end;

procedure Ts0CommentDelphiParser.SkipTo(var APtr: PChar; EC1, EC2: Char);
begin
  while True do
    if (StrByteType(APtr, 1) = mbSingleByte) and (APtr^ = EC1) and
       (StrByteType(APtr, 2) = mbSingleByte) and ((APtr+1)^ = EC2) 	then Break
    else Inc(APtr);
  Inc(APtr, 2);
end;

procedure Ts0CommentDelphiParser.SkipTo(var APtr: PChar; EC1, EC2, EC3: Char);
begin
  while True do
    if (StrByteType(APtr, 1) = mbSingleByte) and (APtr^ = EC1) and
       (StrByteType(APtr, 2) = mbSingleByte) and ((APtr+1)^ = EC2) and
       (StrByteType(APtr, 3) = mbSingleByte) and ((APtr+2)^ = EC3) then Break
    else Inc(APtr);
  Inc(APtr, 3);
end;

procedure Ts0CommentDelphiParser.SkipToCR(var APtr: PChar);
begin
	SkipTo(APtr, #13);
end;

procedure Ts0CommentDelphiParser.CheckComment;
var
  P: PChar;
  Result: Char;
begin
  Result := Token;

  // 既にトークンの種類が確定している場合は，処理を行わない
  if Result < c0toComment then Exit;

  // TParser の内部フィールドを参照する
  // FTokenPtr は，現在注目している文字列の先頭文字へのポインタ
  P := Self.FTokenPtr;
  case P^ of
    '{' :
      begin
        // コメントの終わりまでポインタをインクリメントする
				SkipTo(P, '}');
        Result := c0toComment;
      end;
    '/' :
      begin
        if ((P+1)^ = '/') then begin
          // スラッシュ２個によるコメント行
          SkipToCR(P);
          Result := c0toComment;
        end;
      end;
    '(' :
      begin
        if ((P+1)^ = '*') then
        begin
					SkipTo(P, '*', ')');
          Result := c0toComment;
        end;
      end;
  end;
  if Result = c0toComment then
  begin
    // TParser の内部フィールドを書き換える
    // FSourcePtr は，現在注目している文字列の最後の文字へのポインタ
    // FToken は，解析したトークンの種類
    Self.FSourcePtr := P;
    Self.FToken := Result;
  end;
end;

function Ts0CommentDelphiParser.NextToken: Char;
begin
  Result := inherited NextToken;
  CheckComment;
end;






{ Ts0ReserveWordDelphiParser }

procedure Ts0ReserveWordDelphiParser.AddArrayToList(AList: TStrings;
  AArray: array of string);
var
	i: Integer;
begin
	for i := Low(AArray) to High(AArray) do
    AList.AddObject( LowerCase(AArray[i]), TObject(i) );
end;

constructor Ts0ReserveWordDelphiParser.Create(Stream: TStream);
begin
  inherited;
  FReservedList := TStringList.Create;
  TStringList(FReservedList).Sorted := True;
  TStringList(FReservedList).Duplicates := dupError;
  //
  FOrderList := TStringList.Create;
  TStringList(FOrderList).Sorted := True;
  TStringList(FOrderList).Duplicates := dupError;
end;

destructor Ts0ReserveWordDelphiParser.Destroy;
begin
	FOrderList.Free;
  FOrderList := nil;
	FReservedList.Free;
  FReservedList := nil;
  inherited;
end;


const
  c9OrderWordArray: array[c0owtAbsolute..c0owtWriteonly] of string = (
    'absolute'   , 'abstract'   , 'assembler'  , 'automated'  , 'cdecl'      ,
    'contains'   , 'default'    , 'dispid'     , 'dynamic'    , 'export'     ,
    'external'   , 'far'        , 'forward'    , 'implements' , 'index'      ,
    'message'    , 'name'       , 'near'       , 'nodefault'  , 'overload'   ,
    'override'   , 'package'    , 'pascal'     , 'private'    , 'protected'  ,
    'public'     , 'published'  , 'read'       , 'readonly'   , 'register'   ,
    'reintroduce', 'requires'   , 'resident'   , 'safecall'   , 'stdcall'    ,
    'stored'     , 'virtual'    , 'write'      ,
    'writeonly'
  );

  c9ReserveWordArray: array[c0rwtAnd..c0rwtXor] of string = (
    'and'           ,    'array'         ,    'as'            ,    'asm'           ,    'begin'         ,
    'case'     	    ,    'class'         ,    'const'         ,    'constructor'   ,    'destructor'    ,    'dispinterface' ,
    'div'           ,    'do'            ,    'downto'        ,    'else'          ,    'end'           ,    'except'        ,
    'exports'       ,    'file'          ,    'finalization'  ,    'finally'       ,    'for'           ,    'function'      ,
    'goto'          ,    'if'            ,    'implementation',    'in'            ,    'inherited'     ,    'initialization',
    'inline'        ,    'interface'     ,    'is'            ,    'label'         ,    'library'       ,    'mod'           ,
    'nil'           ,    'not'           ,    'object'        ,    'of'            ,    'or'            ,    'out'           ,
    'packed'        ,    'procedure'     ,    'program'       ,    'property'      ,    'raise'         ,    'record'        ,
    'repeat'        ,    'resourcestring',    'set'           ,    'shl'           ,    'shr'           ,    'string'        ,
    'then'          ,    'threadvar'     ,    'to'            ,    'try'           ,    'type'          ,    'unit'          ,
    'until'         ,    'uses'          ,    'var'           ,    'while'         ,    'with'          ,    'xor'
  );


procedure Ts0ReserveWordDelphiParser.InitOrder;
begin
  AddArrayToList(FOrderList, c9OrderWordArray);
end;

procedure Ts0ReserveWordDelphiParser.InitReserved;
begin
  AddArrayToList(FReservedList, c9ReserveWordArray);
end;



function Ts0ReserveWordDelphiParser.NextToken: Char;
begin
  Result := inherited NextToken;
  if Result = c0toSymbol then
    FWordType := TypeByWord(TokenString);
end;

function Ts0ReserveWordDelphiParser.TokenIsOrder: Boolean;
begin
  Result := (FWordType and c0wtOrder) = c0wtOrder; 
end;

function Ts0ReserveWordDelphiParser.TokenIsReserved: Boolean;
begin
  Result := (FWordType and c0wtReserved) = c0wtReserved;
end;




function Ts0ReserveWordDelphiParser.TypeByWord(AWord: string): Integer;
var
	idx: Integer;
begin
  Result := 0;
  idx := FReservedList.IndexOf( LowerCase(AWord) );
  if idx > -1 then
  begin
    Result := Integer( FReservedList.Objects[idx] );
    Exit;
  end;
  idx := FOrderList.IndexOf( LowerCase(AWord) );
  if idx > -1 then
  begin
    Result := Integer( FOrderList.Objects[idx] );
    Exit;
  end;
end;

function Ts0ReserveWordDelphiParser.WordByType(AType: Integer): String;
var
	idx: Integer;
begin
  Result := '';
  idx := FReservedList.IndexOfObject( TObject(AType) );
  if idx > -1 then
  begin
    Result := FReservedList.Strings[idx];
    Exit;
  end;
  idx := FOrderList.IndexOfObject( TObject(AType) );
  if idx > -1 then
  begin
    Result := FOrderList.Strings[idx];
    Exit;
  end;
end;

end.
 
