unit s0StringHelper;
{
$History: s0StringHelper.pas $
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/05   Time: 18:49
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/29   Time: 1:28
 * Updated in $/source/D5Integrated
 * AreLike���\�b�h�̃|�C���g�v�Z��ZeroDivide���N���Ă���
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/27   Time: 2:44
 * Updated in $/source/D5Integrated
 * �����񂪎��Ă��邩�ǂ����𔻒f���郁�\�b�hAreLike���\�b�h��ǉ��B
 * ����ALikeBorder�͎��Ă���ƌ��Ȃ��p�[�Z���e�[�W�B
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/11/08   Time: 14:35
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/11   Time: 1:21
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/12   Time: 2:13
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:28
 * Created in $/Projects/SDRFrameWork/src/lib0
 * �V�K�ǉ�
 * \Usr\takima\Lecture\StaffDailyReport\Source����ړ����܂����B
 * VSS�ł͋��L���Ă܂���B
}

interface

uses
  SysUtils, Classes;

type
  K0CharType = (
    k0ctAlphabet, //�A���t�@�x�b�g
    k0ctAscii, //�A�X�L�[����
    k0ctControl, //���䕶��
    k0ctDigit, //�����H
    k0ctKana, //���p�J�i
    k0ctKanji, //�S�p
    k0ctSign //�L��
    );
  K0CharTypeSet = set of K0CharType;

type
  K0ValidateCharMethod = function(c: Char): Bytebool of object;

type
  Ts0CharHelper = class
  private
  public
    class function IsAllChar(c: Char): Bytebool;
    class function IsAlpha(c: Char): ByteBool;
    class function IsAscii(c: Char): ByteBool;
    class function IsCntrl(c: Char): ByteBool;
    class function IsDigit(c: Char): ByteBool;
    class function IsKana(c: Char): ByteBool;
    class function IsKanji(c: Char): ByteBool;
    class function IsKanji2(c: Char): ByteBool;
    class function IsSign(c: Char): Bytebool;
    class function GetCharType(c: Char): K0CharTypeSet;
  end;

const
  c0StrHelp_ConnectNameAndVal = '=';

//�A�v���P�[�V����������u�p�X���v�u�x�[�X���v�u�g���q�v�ɕ���
type
  R0FileNameRec = Record
    Path:String;
    Base:String;
    Extension:String;
  End;

type
  Ts0StringHelper = class
  private
    class procedure ReplaceStr(var Source: string; Search,
      Replace: string);
  public
    class function ConcatNameAndValue(AName, Value: string;
      ADelim: Char = c0StrHelp_ConnectNameAndVal): string;
    class function SliceNameAndValue(S: string;var AName, Value: string;
      ADelim: Char = c0StrHelp_ConnectNameAndVal): Boolean;
    class function GetNameSliced(S: string; ADelim: Char = c0StrHelp_ConnectNameAndVal): string;
    class function GetValueSliced(S: string; ADelim: Char = c0StrHelp_ConnectNameAndVal): string;
    class procedure AddStrWithDelim(var Dest: string; AStr: string; ADelim: string = ',');
    class procedure SliceString(Source: string; Dest: TStrings; Delim: string = ';');
    class function QuotedStr(AStr: string; AQuote: Char = '"'): string;
    class function ExtractQuotedStr(AStr: string; AQuote: Char = '"'): string;
    class function GetFileNameBody(AFileName: string): string;
    class function DivideFileName(AFileName: string;
      var AFileNameRec: R0FileNameRec; AUpperCase: Boolean): Integer;
    class function GetTokenBy(Delim: Char; var Stream: string): string;
    class function GetExeNameFromVer(const Ver: integer;
      var FileName: string): string;
    //
    {
      IncludeChar            �w�肵�������킪��ł��܂܂�Ă���ꍇTrue
      IsConstructedByAType   �w�肵�������킾���ŕ����񂪍\������Ă���ꍇTrue
      IsConstructedByTypeSet �w�肵��������Z�b�g�ŕ����񂪍\������Ă���ꍇTrue
    }
    class function IncludeChar(AStr: string; AType: K0CharType): Boolean;
    class function IsConstructedByAType(AStr: string; AType: K0CharType):
      Boolean;
    class function IsConstructedByTypeSet(AStr: string; ATypeSet:
      K0CharTypeSet): Boolean;
    {
      DeleteChar
      �w�肵�������񂩂�w�肵��������S�č폜�����������Ԃ�
    }
    class function DeleteChar(AStr: string; AChar: Char): string;
    {
      SliceStrByChar
      ��������w�肵�������Ő؂蕪����
    }
    class procedure SliceStrByChar(Dest: TStrings; const AStr: string;
      const Delimiter: Char);
    class procedure SlicePCharByChar(Dest: TStrings; AStr: PChar;
      const Delimiter: Char = #0);
    {
    }
    class function ConcatStrings(Source: TStrings; const Delimiter: Char = ';'): string;
    class function RepeatString(repeated: String; repeatTime: Integer): String;
    {
      \a	7  �x��(�����R�[�h�V)
      \b	8  �o�b�N�X�y�[�X(�����R�[�h�W)
      \t	9  �����^�u�R�[�h(�����R�[�h�X)
      \n	10 �j���[���C��(�����R�[�h10)
      \v	11 �����^�u�R�[�h(�����R�[�h11)
      \f	12 �t�H�[���t�B�[�h(�����R�[�h12)
      \r	13 �L�����b�W���^�[��(�����R�[�h13)
      \z	26 �G���h�I�u�t�@�C��(EOF�F�����R�[�h26)
      \e	27 �G�X�P�[�v�R�[�h(�����R�[�h27)

      DecodeEscapeSeq �����񒆂�\n�Ȃǂ����s�Ȃǂɒu��������
      EncodeEscapeSeq �����񒆂̉��s�Ȃǂ�\n�Ȃǂɒu��������
    }
    class procedure DecodeEscapeSeq(var Str: string);
    class procedure EncodeEscapeSeq(var Str: string);
    class function GetEscDecoded(const Str: string): string;
    class function GetEscEncoded(const Str: string): string;
    //
    class function IndexOfArray(AStr: string; StrArray: array of string): Integer;
    class function IndexOfArrayCaseSensitive(AStr: string; StrArray: array of string): Integer;
    {
      �����񂪎��Ă��邩�ǂ����𔻒f����B
    }
    class function AreLike(AStr1, AStr2: string; ALikeBorder: Integer = 30): Boolean;
    //
    class function GetQuotedPos(S: string; var ABegin, AEnd: Integer; ADelimiter: Char = '"'): Boolean;
    class function GetQuotedStr(S: string; ADelimiter: Char; var AResult: string): Boolean;
    class procedure RemoveQuated(var S: string; ADelimiter: Char = '"');
    //
    class function ReverseStr(S: string): string;
    class function ReversePos(ASubstr: string; S: string): Integer;
    class function ReverseAnsiPos(ASubstr: string; S: string): Integer;
  end;

implementation

const
  _IS_SPACE = $01;
  _IS_DIGIT = $02;
  _IS_UPPER = $04;
  _IS_LOWER = $08;
  _IS_HEX = $10;
  _IS_CNTRL = $20;
  _IS_PUNCT = $40;

  { Borland C++ 4.0 �Ɠ����̔��ʗp�e�[�u�� }
  _Ctype: array[Char] of Byte = (
    $20, $20, $20, $20, $20, $20, $20, $20, $20, $21, $21, $21, $21, $21, $20,
      $20,
    $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20,
      $20,
    $01, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40,
      $40,
    $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $40, $40, $40, $40, $40,
      $40,
    $40, $14, $14, $14, $14, $14, $14, $04, $04, $04, $04, $04, $04, $04, $04,
      $04,
    $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $40, $40, $40, $40,
      $40,
    $40, $18, $18, $18, $18, $18, $18, $08, $08, $08, $08, $08, $08, $08, $08,
      $08,
    $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $40, $40, $40, $40,
      $20,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
      $00
    );

var
  g9Validation: array[K0CharType] of K0ValidateCharMethod = (
    nil, nil, nil, nil, nil, nil, nil
    );

class function Ts0CharHelper.IsAlpha(c: Char): ByteBool;
begin
  Result := ByteBool(_Ctype[c] and (_IS_UPPER or _IS_LOWER));
end;

class function Ts0CharHelper.IsAscii(c: Char): ByteBool;
begin
  Result := ByteBool(Ord(c) < 128) or
    ByteBool(($20 <= Ord(c)) and (Ord(c) <= $7E));
end;

class function Ts0CharHelper.IsCntrl(c: Char): ByteBool;
begin
  Result := ByteBool(_Ctype[c] and _IS_CNTRL);
end;

class function Ts0CharHelper.IsDigit(c: Char): ByteBool;
begin
  Result := ByteBool(_Ctype[c] and _IS_DIGIT);
end;

class function Ts0CharHelper.IsKana(c: Char): ByteBool; { ���p�J�i���� }
begin
  Result := ByteBool(($A1 <= Ord(c)) and (Ord(c) <= $DF));
end;

class function Ts0CharHelper.IsKanji(c: Char): ByteBool;
begin
  {Result := IsDBCSLeadByte(Byte(ord(c)));}
  Result := ByteBool(($81 <= Ord(c)) and (Ord(c) <= $9F)) or
    ByteBool(($E0 <= Ord(c)) and (Ord(c) <= $FC));
end;

class function Ts0CharHelper.IsKanji2(c: Char): ByteBool;
begin
  Result := (($40 <= Ord(c)) and (Ord(c) <= $7F))
    or (($80 <= Ord(c)) and (Ord(c) <= $FC));
end;

class function Ts0CharHelper.IsAllChar(c: Char): Bytebool;
begin
  Result := (ByteBool(($80 <= Ord(c)) and (Ord(c) <= $FC))) or
    (ByteBool(($20 <= Ord(c)) and (Ord(c) <= $7E)));
end;

class function Ts0CharHelper.IsSign(c: Char): Bytebool;
begin
  Result := (ByteBool(($20 <= Ord(c)) and (Ord(c) <= $2F))) or
    (ByteBool(($3A <= Ord(c)) and (Ord(c) <= $40))) or
    (ByteBool(($5B <= Ord(c)) and (Ord(c) <= $60))) or
    (ByteBool(($7B <= Ord(c)) and (Ord(c) <= $7F)));
end;

class function Ts0CharHelper.GetCharType(c: Char): K0CharTypeSet;
var
  i: K0CharType;
begin
  Result := [];
  for i := Low(K0CharType) to High(K0CharType) do
    if g9Validation[i](c) then
      Include(Result, i);
end;

{ Ts0StringHelper }

class procedure Ts0StringHelper.AddStrWithDelim(var Dest: string; AStr, ADelim: string);
begin
  if Dest = '' then Dest := AStr
  else
    Dest := Dest + ADelim + AStr;
end;

class function Ts0StringHelper.ConcatNameAndValue(AName, Value: string; ADelim: Char): string;
begin
  Result := AName + ADelim + Value;
end;

class function Ts0StringHelper.ExtractQuotedStr(AStr: string; AQuote: Char): string;
var
  s: PChar;
begin
  s := PChar(AStr);
  Result := AnsiExtractQuotedStr( s, AQuote);
  if Result = '' then
    Result := AStr;
end;

class function Ts0StringHelper.GetNameSliced(S: string; ADelim: Char): string;
var
  dmy: string;
begin
  Result := '';
  dmy := '';
  if not SliceNameAndValue(S, Result, dmy, ADelim) then
    Result := '';
end;

class function Ts0StringHelper.GetValueSliced(S: string; ADelim: Char): string;
var
  dmy: string;
begin
  Result := '';
  if not SliceNameAndValue(S, dmy, Result, ADelim) then
    Result := '';
end;

class function Ts0StringHelper.QuotedStr(AStr: string; AQuote: Char): string;
begin
  Result := AnsiQuotedStr(AStr, AQuote);
end;

class function Ts0StringHelper.SliceNameAndValue(S: string; var AName, Value: string; ADelim: Char): Boolean;
var
  idx: Integer;
begin
  Result := False;
  if s = '' then Exit;
  AName := '';
  Value := '';
  idx := System.Pos(ADelim, S);
  if idx > 0 then
  begin
    AName := System.Copy(s, 1, idx -1);
    Value := System.Copy(s, idx + 1, Length(s) - idx);
  end;
  Result := idx > 0;
end;

class procedure Ts0StringHelper.SliceString(Source: string; Dest: TStrings; Delim: string);
var
  buf, s: string;
  dLen: Integer;
  idx: Integer;
begin
  buf := Source;
  dLen := System.Length(Delim);
  while buf <> '' do
  begin
    idx := System.Pos(Delim, buf);
    if idx > 0 then
    begin
      s := Copy(buf, 1, idx -1);
      Delete(buf, 1, idx + dLen -1);
    end
    else
    begin
      s := buf;
      buf := '';
    end;
    Dest.Add( s );
  end;
end;

//�v���O���������u�p�X���v�A�u�x�[�X���v�u�g���q�v�ɕ�������
{------------------------------------------------------------
�����F�v���O���������u�p�X���v�A�u�x�[�X���v�u�g���q�v�ɕ�������
�����FaAppName�ɂ̓v���O���������AaAppRec�ɂ͂��̃��j�b�g�ɒ�`���Ă���
�@�@�@�\���̕ϐ����Q�Ƃœn��
���ʁFaAppRec�\���̂ɂ͕������ꂽ�A�v���P�[�V���������Z�b�g�����
���l�F���ʂŖ߂��������͎��ۂɕ������ꂽ�v�f���ł���
------------------------------------------------------------}
class function Ts0StringHelper.DivideFileName(AFileName: string;
  var AFileNameRec: R0FileNameRec; AUpperCase: Boolean ): Integer;
var
  Str2:String;
begin
  Result := 0;
  //AFileName := AFileName;
  AFileNameRec.Path := ExtractFileDir(AFileName);
  if AFileNameRec.Path <> '' then inc(Result);

  Str2 := ExtractFileName(AFileName);
  AFileNameRec.Base := ChangeFileExt(Str2, '');
  if AFileNameRec.Base <> '' then inc(Result);

  AFileNameRec.Extension := ExtractFileExt(Str2);
  if AFileNameRec.Extension <> '' then inc(Result);

  if AUpperCase then begin
    AFileNameRec.Path := AnsiUpperCase(AFileNameRec.Path);
    AFileNameRec.Base := AnsiUpperCase(AFileNameRec.Base);
    AFileNameRec.Extension := AnsiUpperCase(AFileNameRec.Extension);
  end;
end;

{------------------------------------------------------------
�����F�C�ӂ̋�؂蕶���ŋ�؂������ʂ��擾
�����FDelim�ɂ͋�؂蕶���AStream�ɂ͐؂�o����������킽��
���ʁFDelim�Ŏw�肵����؂蕶�����o������܂ł̕������Ԃ�
���l�F�擾��������������ƈ�̋�؂蕶����Stream����폜�����
------------------------------------------------------------}
class function  Ts0StringHelper.GetTokenBy(Delim: Char; var Stream: string): string;
var
  Index: Integer;
  NewStrm, OldStream: string;
begin
	Result	:= '';
  for Index := 1 to Length(Stream) do
  begin
  	if Char(Stream[Index]) = Delim then
    begin
			OldStream := Copy(Stream, 1, Index - 1);
      Result  := OldStream;
			OldStream := '';
    	NewStrm	:= Copy(Stream, Index + 1, Length(Stream));
      Stream  := '';
			Stream  := Copy(NewStrm, 1, Length(NewStrm));
			NewStrm := '';
      Exit;
    end
  end;
  Result 	:= Stream;
  Stream	:= '';
end;

{------------------------------------------------------------
�����FVersionNo��t������Exe���̂�Ԃ�
�����FVer�ɂ͗L���ȃo�[�W�����AFilename�ɂ�EXE����n��
���ʁF���s�ɐ��������牺�ꌅ���o�[�W����NO�ɂ����ς����Exe����Ԃ�
���l�F
------------------------------------------------------------}
class function Ts0StringHelper.GetExeNameFromVer(const Ver: integer; var FileName: string): string;
var
  TempFileName: string;
  ExeStr: string;
begin
  TempfileName := '';
  ExeStr  		 := '';
  TempFileName := FileName;

	If Pos('.',FileName) > 0 then
	 	ExeStr := Self.GetTokenBy('.', TempFileName)
	Else
 		ExeStr := TempFileName;

	ExeStr   := Copy(ExeStr, 1, Length(ExeStr)-1) + IntToStr(Ver) + '.EXE';
	Result := ExeStr; {EXE����߂�}
end;


class function Ts0StringHelper.GetFileNameBody(AFileName: string): string;
begin
  Result := ChangeFileExt( ExtractFileName(AFileName), '');
end;


class function Ts0StringHelper.DeleteChar(AStr: string; AChar: Char): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(AStr) do
    if AStr[i] <> AChar then
      Result := Result + AStr[i];
end;

class function Ts0StringHelper.IncludeChar(AStr: string;
  AType: K0CharType): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(AStr) do
    if g9Validation[AType](AStr[i]) then
      Exit;
  Result := False;
end;

class function Ts0StringHelper.IsConstructedByAType(AStr: string;
  AType: K0CharType): Boolean;
var
  i: Integer;
  m: K0ValidateCharMethod;
begin
  Result := False;
  m := g9Validation[AType];
  for i := 1 to Length(AStr) do
    if not m(AStr[i]) then
      Exit;
  Result := True;
end;

class function Ts0StringHelper.IsConstructedByTypeSet(AStr: string;
  ATypeSet: K0CharTypeSet): Boolean;
var
  i: Integer;
  j: K0CharType;
begin
  Result := False;
  for i := 1 to Length(AStr) do
    for j := Low(K0CharType) to High(K0CharType) do
      if j in ATypeSet then
        if not g9Validation[j](AStr[i]) then
          Exit;
  Result := True;
end;

class procedure Ts0StringHelper.SlicePCharByChar(Dest: TStrings;
  AStr: PChar; const Delimiter: Char);
var
  s: string;
begin
  s := '';
  while AStr^ <> #0 do
  begin
    s := s + AStr^;
    Inc(AStr);
    if AStr^ = #0 then
    begin
      Dest.Add(s);
      s := '';
      Inc(AStr);
    end;
  end;
end;

class procedure Ts0StringHelper.SliceStrByChar(Dest: TStrings; const AStr: string;
  const Delimiter: Char);
var
  i: Integer;
  s: string;
begin
  Dest.Clear;
  s := '';
  for i := 1 to Length(AStr) do
    if AStr[i] = Delimiter then
    begin
      Dest.Add(s);
      s := '';
    end
    else
      s := s + AStr[i];
  if s <> '' then
    Dest.Add(s);
end;

class procedure Ts0StringHelper.DecodeEscapeSeq(var Str: string);
begin
  ReplaceStr(Str, '\a', #7 );
  ReplaceStr(Str, '\b', #8 );
  ReplaceStr(Str, '\t', #9 );
  ReplaceStr(Str, '\n', #10);
  ReplaceStr(Str, '\v', #11);
  ReplaceStr(Str, '\f', #12);
  ReplaceStr(Str, '\r', #13);
  ReplaceStr(Str, '\z', #26);
  ReplaceStr(Str, '\e', #27);
end;

class procedure Ts0StringHelper.EncodeEscapeSeq(var Str: string);
begin
  ReplaceStr(Str, #7 , '\a');
  ReplaceStr(Str, #8 , '\b');
  ReplaceStr(Str, #9 , '\t');
  ReplaceStr(Str, #10, '\n');
  ReplaceStr(Str, #11, '\v');
  ReplaceStr(Str, #12, '\f');
  ReplaceStr(Str, #13, '\r');
  ReplaceStr(Str, #26, '\z');
  ReplaceStr(Str, #27, '\e');
end;

class procedure Ts0StringHelper.ReplaceStr(var Source : string; Search, Replace : string);
begin
  Source := StringReplace(Source, Search, Replace, [rfReplaceAll, rfIgnoreCase]);
end;

class function Ts0StringHelper.GetEscDecoded(const Str: string): string;
begin
  Result := Str;
  DecodeEscapeSeq(Result);
end;

class function Ts0StringHelper.GetEscEncoded(const Str: string): string;
begin
  Result := Str;
  EncodeEscapeSeq(Result);
end;

class function Ts0StringHelper.IndexOfArray(AStr: string;
  StrArray: array of string): Integer;
var
  i: Integer;
begin
  Result := Low(StrArray) -1;
  for i := Low(StrArray) to High(StrArray) do
    if AnsiCompareText(AStr, StrArray[i]) = 0 then
    begin
      Result := i;
      Exit;
    end;   
end;

class function Ts0StringHelper.IndexOfArrayCaseSensitive(AStr: string;
  StrArray: array of string): Integer;
var
  i: Integer;
begin
  Result := Low(StrArray) -1;
  for i := Low(StrArray) to High(StrArray) do
    if AnsiCompareStr(AStr, StrArray[i]) = 0 then
    begin
      Result := i;
      Exit;
    end;   
end;

class function Ts0StringHelper.AreLike(AStr1, AStr2: string;
  ALikeBorder: Integer): Boolean;
var
  p: Integer;
  len1, len2: Integer;
  i: Integer;
begin
  AStr1 := Trim(AStr1);
  AStr2 := Trim(AStr2);
  len1 := Length(AStr1);
  len2 := Length(AStr2);
  p := 0;
  for i := 1 to len1 do
  begin
    if i > len2 then Break;
    if AStr1[i] = AStr2[i] then Inc(p);
  end;
  for i := 1 to len2 do
  begin
    if i > len1 then Break;
    if AStr1[i] = AStr2[i] then Inc(p);
  end;
  for i := 0 to len1 -1 do
  begin
    if Len2 - i < 1 then Break;
    if AStr1[len1 - i] = AStr2[len2 - i] then Inc(p);
  end;
  for i := 0 to len2 -1 do
  begin
    if Len1 - i < 1 then Break;
    if AStr1[len1 - i] = AStr2[len2 - i] then Inc(p);
  end;
  if p = 0 then
    Result := (len1 + len2 = 0)
  else
    Result := (p / (len1 + len2) / 2 * 100) >= ALikeBorder;
end;

class function Ts0StringHelper.ReverseAnsiPos(ASubstr, S: string): Integer;
var
  rv: string;
begin
  rv := ReverseStr(S);
  Result := AnsiPos(ASubstr, rv);
end;

class function Ts0StringHelper.ReversePos(ASubstr, S: string): Integer;
var
  rv: string;
begin
  rv := ReverseStr(S);
  Result := Pos(ASubstr, rv);
end;

class function Ts0StringHelper.ReverseStr(S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := Length(S) downto 1 do
    Result := Result + S[i];
end;

class procedure Ts0StringHelper.RemoveQuated(var S: string;
  ADelimiter: Char);
begin

end;

class function Ts0StringHelper.GetQuotedPos(S: string; var ABegin,
  AEnd: Integer; ADelimiter: Char): Boolean;
var
  ps: PChar;
  i: Integer;
begin
  Result := False;
  ps := PChar(S);
  ABegin := 0;
  AEnd := 0;
  i := 1;
  while ps <> #0 do
  begin
    if ps^ = ADelimiter then
    begin
      if ABegin < 1 then
        ABegin := i
      else
      if ((ps + 1)^ = ADelimiter) then
      begin
        Inc(ps);
        Inc(i);
      end
      else
      begin
        AEnd := i;
        Result := True;
        Exit;
      end;
    end;
    Inc(ps);
    Inc(i);
  end;
end;

class function Ts0StringHelper.GetQuotedStr(S: string;
  ADelimiter: Char; var AResult: string): Boolean;
var
  posBegin, posEnd: Integer;
begin
  Result := GetQuotedPos(S, posBegin, posEnd, ADelimiter);
  if Result then
    AResult := Copy(S, posBegin, posEnd - posBegin + 1);
end;

class function Ts0StringHelper.ConcatStrings(Source: TStrings;
  const Delimiter: Char): string;
var
  i: Integer;
begin
  Result := '';
  if Source.Count < 1 then Exit;
    Result := Source.Strings[0];
  for i := 1 to Source.Count -1 do
    Result := Result + Delimiter + Source.Strings[i];
end;

class function Ts0StringHelper.RepeatString(repeated: String;
  repeatTime: Integer): String;
var
	i: Integer;
begin
	Result := '';
	for i := 0 to repeatTime -1 do
  	Result := Result + repeated;
end;

initialization
  g9Validation[k0ctAlphabet] := Ts0CharHelper.IsAlpha;
  g9Validation[k0ctAscii] := Ts0CharHelper.IsAscii;
  g9Validation[k0ctControl] := Ts0CharHelper.IsCntrl;
  g9Validation[k0ctDigit] := Ts0CharHelper.IsDigit;
  g9Validation[k0ctKana] := Ts0CharHelper.IsKana;
  g9Validation[k0ctKanji] := Ts0CharHelper.IsKanji;
  g9Validation[k0ctSign] := Ts0CharHelper.IsSign;

finalization
  g9Validation[k0ctAlphabet] := nil;
  g9Validation[k0ctAscii]    := nil;
  g9Validation[k0ctControl]  := nil;
  g9Validation[k0ctDigit]    := nil;
  g9Validation[k0ctKana]     := nil;
  g9Validation[k0ctKanji]    := nil;
  g9Validation[k0ctSign]     := nil;

end.

