unit s0StringValidater;
{
$History: s0StringValidater.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 4  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  Classes,
  s0CommonTypes,
  s0CType;

type
  K1InpCharFunc =	function(c: Char): ByteBool of object;
  K1CharactorSet =  set of Char;

type
	Ts0StringValidater = class
  public
		class function isSpecialKey(const key: word): Boolean;
		class function validateChartype(ACharType: K1InpCharSet; AChars: array of Char;
      AResetDBCS: Boolean = False): Boolean;
		class function validateExclusiveChar(exclusivechar: K1CharactorSet;
      AChars: array of char): Boolean; overload;
		class function validateExclusiveChar(ExclusiveAcceptString: string;
      AChars: array of char): Boolean; overload;
		class procedure uppercaseChartype(ACharType: K1InpCharSet; var value: String);
    class function StringToCharSet(Source: string): K1CharactorSet;
  end;

implementation

uses
	windows, sysutils
  ;

{--------------------------------------------------------------------
説明：PC上の特殊キー(文字入力とみなしたくないキー)を判定する
引数：key : 入力されたキーコードをセット
結果：PCの特殊キーの場合はTrueを返す
備考：
---------------------------------------------------------------------}
class function Ts0StringValidater.isSpecialKey (const key: word):Boolean;
begin
  result := Ts0Ctype.IsSpecialKey(key);
end;


{--------------------------------------------------------------------
説明：特殊なキーコードだけを判定したい場合に使用するメソッド
引数：exclusiveChars[] : チェックOKとする基準の文字の配列
      AChars[] : 判定する文字の配列
結果：全てが入力可能な文字だった場合はTrueを返す
備考：
---------------------------------------------------------------------}
class function Ts0StringValidater.validateExclusiveChar(exclusivechar: K1CharactorSet; AChars: array of char):Boolean;
var
	i:integer;
begin
	Result := True;
  for i := low(AChars) to high(AChars) do
  begin
    Result := ( AChars[i] in exclusivechar ) or ( UpCase(AChars[i]) in exclusivechar );
    if not Result then Break;
	end;
end;


class function Ts0StringValidater.validateExclusiveChar(
  ExclusiveAcceptString: string; AChars: array of char): Boolean;
begin
  Result := validateExclusiveChar(StringToCharSet(ExclusiveAcceptString), AChars);
end;



var
	//文字列比較の為の関数配列
	g9CharTypeAry:	array[K1InpCharType] of K1InpCharFunc;

var
	DBCSFirst: Boolean = False;

{--------------------------------------------------------------------
説明：キーコードが所定のタイプに合致するかを判定するメソッド
引数：charType : 各種入力コンポーネントでセットされた入力文字タイプ (u1ConstCompo)
      AChars[] : 判定する文字の配列
結果：入力可能な文字だった場合はTrueを返す
備考：
---------------------------------------------------------------------}
class function Ts0StringValidater.validateChartype(ACharType: K1InpCharSet; AChars: array of Char;
  AResetDBCS: Boolean = False): Boolean;
var
	i: integer;
  j: K1InpCharType;
begin
  {選ばれた列挙型ﾌﾟﾛﾊﾟﾃｨに対応した関数で入力文字の有効性をﾁｪｯｸ}
	if AResetDBCS then DBCSFirst := False; //DBCS判定をリセットする
  Result := False;
  for i := low(AChars) to high(AChars) do
    for j := Low(K1InpCharType) to High(K1InpCharType) do
      if j in ACharType then
        if j = k1ctKanji then
        begin
          //DBCSの1バイト目だった場合はチェックをしない
          if DBCSFirst then begin
            DBCSFirst := False;
            Result := Result or Ts0Ctype.iskanji2(AChars[i]);
          end
          else
          begin
            //DBCSの2バイト目だった場合は特別なチェックを行う
            DBCSFirst := Ts0Ctype.iskanji(AChars[i]);
            if DBCSFirst then Result := true;
          end;
        end
        else
          Result := Result or g9CharTypeAry[j](AChars[i]);
end;


{--------------------------------------------------------------------
説明：CharTypeを考慮してUpperCase操作を行う
引数：exclusiveChars[] : チェックOKとする基準の文字の配列
      AChars[] : 判定する文字の配列
結果：全てが入力可能な文字だった場合はTrueを返す
備考：
---------------------------------------------------------------------}
class procedure Ts0StringValidater.uppercaseChartype(ACharType: K1InpCharSet; var value:String);
var
	DBCSFirst: Boolean;
var
	i: integer;
begin
  DBCSFirst := False;
  {選ばれた列挙型ﾌﾟﾛﾊﾟﾃｨ中で英字だけをUpperCase操作する}
  for i := 1 to Length(value) do
  begin
		if DBCSFirst then
       DBCSFirst := False
		else
    begin
    	DBCSFirst := Ts0Ctype.iskanji(value[i]);
			if not DBCSFirst then
      begin
        {英字か?}
        if ( k1ctAlpha in ACharType ) then
        begin
          if g9CharTypeAry[k1ctAlpha](value[i]) then
            value[i] := AnsiUpperCase(copy(value[i], 1, 1))[1];
        end;
			end;
		end;
	end;
end;

class function Ts0StringValidater.StringToCharSet(Source: string): K1CharactorSet;
var
  i: Integer;
begin
  Result := [];
  for i := 1 to Length(Source) do
    Include(Result, Source[i]);
end;

initialization
begin
	//文字列バリデーション用の関数を配列にセット (別な関数に差し替えが可能)
  g9CharTypeAry[k1ctAlpha] := Ts0Ctype.isalpha;
  g9CharTypeAry[k1ctDigit] := Ts0Ctype.isdigit;
  g9CharTypeAry[k1ctSign ] := Ts0Ctype.issign;
  {DBCS}
{$IFNDEF NOIMEPROP}
  g9CharTypeAry[k1ctKana ] := Ts0Ctype.iskana;
  g9CharTypeAry[k1ctKanji] := Ts0Ctype.iskanji;
{$ENDIF}
end;

end.

