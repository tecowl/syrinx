unit s0CType;
{
 *******************************************************************
 *
 * Liblary:	 s0CType
 * OutLine:   Cops Char Type Decision Function
 * Hierarchy:
 * Note:
 *
 $History: s0CType.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 4  *****************
 * User: Satoh        Date: 00/07/25   Time: 16:51
 * Updated in $/COPS5/LIB0
 * isSpecialKey���\�b�h�ł͔��p/�S�p�L�[�̃g�O�����͂����f�ł���悤�ɂ���
 * 
 * *****************  Version 3  *****************
 * User: Satoh        Date: 00/07/25   Time: 15:47
 * Updated in $/COPS5/LIB0
 * Windows�̓���L�[�𔻒f����֐���ǉ�����
 * 
 * *****************  Version 2  *****************
 * User: Mikami       Date: 98/02/12   Time: 19:47
 * Updated in $/COPS/LIB0
 *******************************************************************
}
interface

uses classes;

type
	Ts0Ctype = class
  public
    class function IsAlNum(c: Char): ByteBool;	{ �p���� }
    class function IsAlpha(c: Char): ByteBool;	{ �p�� }
    class function IsAscii(c: Char): ByteBool;	{ ASCII ���� }
    class function IsCntrl(c: Char): ByteBool;	{ ���䕶�� }
    class function IsDigit(c: Char): ByteBool;	{ ���� }
    class function IsSign(c: Char) : ByteBool;	{ �L�� }
    {function isgraph(c: Char): ByteBool;	{ �\������ }
    {function islower(c: Char): ByteBool;	{ �p������ }
    {function isprint(c: Char): ByteBool;	{ ����\���� }
    {function ispunct(c: Char): ByteBool;	{ ��؂蕶�� }
    {function isspace(c: Char): ByteBool;	{ �󔒕��� }
    {function isupper(c: Char): ByteBool;	{ �p�啶�� }
    {function isxdigit(c: Char): ByteBool;	{ 16�i���� }
    class function IsKana(c: Char): ByteBool;	 { ���p�J�i���� }
    class function IsKanji(c: Char): ByteBool;	 { ������1�o�C�g�� }
    class function IsKanji2(c: Char): ByteBool; { ������2�o�C�g�� }
    class function IsAllChar(c: Char):ByteBool; {��L�֐���OR����}
		class function IsSpecialKey (const key: word):boolean;
  end;

implementation

uses
{$IFDEF VER80}
	Winprocs
{$ELSE}
	windows
{$ENDIF}
  ;

const
  _IS_SPACE = $01;
  _IS_DIGIT = $02;
  _IS_UPPER = $04;
  _IS_LOWER = $08;
  _IS_HEX   = $10;
  _IS_CNTRL = $20;
  _IS_PUNCT = $40;

  { Borland C++ 4.0 �Ɠ����̔��ʗp�e�[�u�� }
  _Ctype: array[Char] of Byte = (
    $20,$20,$20,$20,$20,$20,$20,$20,$20,$21,$21,$21,$21,$21,$20,$20,
    $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,
    $01,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,
    $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$40,$40,$40,$40,$40,$40,
    $40,$14,$14,$14,$14,$14,$14,$04,$04,$04,$04,$04,$04,$04,$04,$04,
    $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$40,$40,$40,$40,$40,
    $40,$18,$18,$18,$18,$18,$18,$08,$08,$08,$08,$08,$08,$08,$08,$08,
    $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$40,$40,$40,$40,$20,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  );

class function Ts0Ctype.IsAlNum(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and (_IS_DIGIT or _IS_UPPER or _IS_LOWER) );
end;

class function Ts0Ctype.IsAlpha(c: Char): ByteBool;
begin
	Result := ByteBool( _Ctype[c] and (_IS_UPPER or _IS_LOWER) );
end;

class function Ts0Ctype.IsAscii(c: Char): ByteBool;
begin
	Result := ByteBool( Ord(c) < 128 ) or
						ByteBool( ($20 <= Ord(c) ) and (Ord(c) <= $7e) );
end;

class function Ts0Ctype.IsCntrl(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and _IS_CNTRL);
end;

class function Ts0Ctype.IsDigit(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and _IS_DIGIT);
end;

(*
class function Ts0Ctype.isgraph(c: Char): ByteBool;
begin
	Result := ByteBool(($20 <= Ord(c)) and (Ord(c) <= $7e));
end;

class function Ts0Ctype.islower(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and _IS_LOWER);
end;

class function Ts0Ctype.isprint(c: Char): ByteBool;
begin
	Result := ByteBool(($20 <= Ord(c)) and (Ord(c) <= $7e));
end;

class function Ts0Ctype.ispunct(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and _IS_PUNCT);
end;

class function Ts0Ctype.isspace(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and _IS_SPACE);
end;

class function Ts0Ctype.isupper(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and _IS_UPPER);
end;

class function Ts0Ctype.isxdigit(c: Char): ByteBool;
begin
	Result := ByteBool(_Ctype[c] and (_IS_DIGIT or _IS_HEX )) ;
end;
*)

class function Ts0Ctype.IsKana(c: Char): ByteBool;	 { ���p�J�i���� }
begin
	Result := ByteBool(($A1 <= Ord(c)) and (Ord(c) <= $DF));
end;

class function Ts0Ctype.IsKanji(c: Char): ByteBool;
begin
	{Result := IsDBCSLeadByte(Byte(ord(c)));}
	Result := ByteBool(($81 <= Ord(c)) and (Ord(c) <= $9F)) OR
						ByteBool(($E0 <= Ord(c)) and (Ord(c) <= $FC));
end;

class function Ts0Ctype.IsKanji2(c: Char): ByteBool;
begin
	Result := (($40 <= Ord(c)) and (Ord(c) <= $7F))
				 or (($80 <= Ord(c)) and (Ord(c) <= $FC));
End;

class function Ts0Ctype.IsAllChar(c: Char): Bytebool;
begin
	Result := ( ByteBool(($80 <= Ord(c)) and (Ord(c) <= $FC))) or
						( ByteBool(($20 <= Ord(c)) and (Ord(c) <= $7e)));
end;

class function Ts0Ctype.IsSign(c: Char): Bytebool;
begin
	Result := ( ByteBool(($20 <= Ord(c)) and (Ord(c) <= $2f))) or
						( ByteBool(($3A <= Ord(c)) and (Ord(c) <= $40))) or
						( ByteBool(($5B <= Ord(c)) and (Ord(c) <= $60))) or
						( ByteBool(($7B <= Ord(c)) and (Ord(c) <= $7F)));
end;

{--------------------------------------------------------------------
�����FPC��̓���L�[(�������͂Ƃ݂Ȃ������Ȃ��L�[)�𔻒肷��
�����Fkey : ���͂��ꂽ�L�[�R�[�h���Z�b�g
���ʁFPC�̓���L�[�̏ꍇ��True��Ԃ�
���l�F
---------------------------------------------------------------------}
class function Ts0Ctype.IsSpecialKey (const key: word):boolean;
begin
  result := false;
  Case Key Of
    VK_HOME,
    VK_END,
    VK_INSERT,
    VK_DELETE,
    VK_PRIOR,
    VK_NEXT,
    VK_SNAPSHOT,
    VK_SCROLL,
    VK_PAUSE,
    VK_F1..VK_F12,
    VK_KANA,
    VK_SHIFT, VK_LSHIFT, VK_RSHIFT,
    VK_CONTROL, VK_LCONTROL, VK_RCONTROL,
    VK_MENU, VK_LWIN, VK_RWIN,
    VK_RMENU, VK_LMENU, VK_APPS,
    VK_NUMLOCK,
    VK_KANJI..VK_MODECHANGE,
    VK_LEFT..VK_DOWN,
    240,{�J�^�J�i/�Ђ炩��} 243, 244{���p/�S�p}
    : result := true;
  end;
end;

end.

