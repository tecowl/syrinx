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
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Satoh        Date: 00/07/25   Time: 16:51
 * Updated in $/COPS5/LIB0
 * isSpecialKeyメソッドでは半角/全角キーのトグル入力も判断できるようにした
 * 
 * *****************  Version 3  *****************
 * User: Satoh        Date: 00/07/25   Time: 15:47
 * Updated in $/COPS5/LIB0
 * Windowsの特殊キーを判断する関数を追加した
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
    class function IsAlNum(c: Char): ByteBool;	{ 英数字 }
    class function IsAlpha(c: Char): ByteBool;	{ 英字 }
    class function IsAscii(c: Char): ByteBool;	{ ASCII 文字 }
    class function IsCntrl(c: Char): ByteBool;	{ 制御文字 }
    class function IsDigit(c: Char): ByteBool;	{ 数字 }
    class function IsSign(c: Char) : ByteBool;	{ 記号 }
    {function isgraph(c: Char): ByteBool;	{ 表示文字 }
    {function islower(c: Char): ByteBool;	{ 英小文字 }
    {function isprint(c: Char): ByteBool;	{ 印刷可能文字 }
    {function ispunct(c: Char): ByteBool;	{ 区切り文字 }
    {function isspace(c: Char): ByteBool;	{ 空白文字 }
    {function isupper(c: Char): ByteBool;	{ 英大文字 }
    {function isxdigit(c: Char): ByteBool;	{ 16進文字 }
    class function IsKana(c: Char): ByteBool;	 { 半角カナ文字 }
    class function IsKanji(c: Char): ByteBool;	 { 漢字の1バイト目 }
    class function IsKanji2(c: Char): ByteBool; { 漢字の2バイト目 }
    class function IsAllChar(c: Char):ByteBool; {上記関数のOR条件}
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

  { Borland C++ 4.0 と同等の判別用テーブル }
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

class function Ts0Ctype.IsKana(c: Char): ByteBool;	 { 半角カナ文字 }
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
説明：PC上の特殊キー(文字入力とみなしたくないキー)を判定する
引数：key : 入力されたキーコードをセット
結果：PCの特殊キーの場合はTrueを返す
備考：
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
    240,{カタカナ/ひらかな} 243, 244{半角/全角}
    : result := true;
  end;
end;

end.

