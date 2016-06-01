unit s0RegEntity;
{
$History: s0RegEntity.pas $
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/21   Time: 22:44
 * Updated in $/source/D6VCLIntegrated
 * Ts0EntityFormManager、Tc0EntityAltFormManagerを削除
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/12/07   Time: 18:27
 * Updated in $/source/D5Integrated
 * デザイナー関係は設計時用のパッケージに全て移動した
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/12   Time: 21:41
 * Updated in $/source/D5Integrated
 * Ts0EntityPoolを追加
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/04   Time: 12:22
 * Updated in $/source/D5Integrated
 * Ts0DBEntityManagerのコンポーネントエディタTs0ce_DBEntityManを登録
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/21   Time: 16:59
 * Updated in $/source/D5Integrated
 * Tc0EntityCtrlBridgeを削除
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/19   Time: 20:46
 * Updated in $/source/D5Integrated
 * Tc0EntityCtrlBridgeを追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * コンポーネントパレットの登録先を変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes, 
  s0EntityPool;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Entity', [Ts0EntityPool]);
end;

end.
