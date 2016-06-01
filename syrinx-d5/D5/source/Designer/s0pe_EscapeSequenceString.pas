unit s0pe_EscapeSequenceString;
{
$History: s0pe_EscapeSequenceString.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/12   Time: 2:13
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 2  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf;
{$ELSE}
  DesignEditors, VCLEditors, RTLConsts;
{$ENDIF}

type
  // 複数行の入力を\nで受け入れるプロパティエディッタ
  Ts0pe_EscapeSequenceString = class(TCaptionProperty)
  public
    Function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

implementation

uses
  s0StringHelper;

function Ts0pe_EscapeSequenceString.GetValue: string;
begin
  Result := GetStrValue;
  Ts0StringHelper.EncodeEscapeSeq(Result);
end;

procedure Ts0pe_EscapeSequenceString.SetValue(const Value: string);
var
  capt: string;
begin
  capt := Value;
  Ts0StringHelper.DecodeEscapeSeq(capt);
  SetStrValue(capt);
end;


end.
 
