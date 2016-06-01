unit s0RegCtrl;
{
$History: s0RegCtrl.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/12   Time: 2:31
 * Updated in $/D6/source/VCL
 * Ts0ObjTreeMapper,Ts0ObjTreeMapMenuを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/21   Time: 23:27
 * Updated in $/source/D5Integrated
 * Ts0CheckListBoxがRegisterComponentsされてなかったので登録
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/07   Time: 18:27
 * Updated in $/source/D5Integrated
 * デザイナー関係は設計時用のパッケージに全て移動した
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * コンポーネントパレットの登録先を変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0ctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes,
  s0CtrlDragger,
  s0FormEventPublisher,
  s0FormRelation,
  s0ModeController,
  s0ObjCtrlBuilder,
  s0SingleInput,
  s0TreeViewController,
  s0ObjTreeMapper,
  s0ObjTreeMapMenu
  ;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Form', [
    Ts0FormEventPublisher,
    Ts0FormRelation,
    Ts0ObjCtrlBridge,
    Ts0TreeViewController,
    Ts0ObjTreeMapper,
    Ts0ObjTreeMapMenu
  ]);
end;

end.
