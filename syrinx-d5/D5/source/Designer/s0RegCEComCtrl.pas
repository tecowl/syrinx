unit s0RegCEComCtrl;
{
$History: s0RegCEComCtrl.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/13   Time: 21:08
 * Updated in $/source/D5Integrated/Designer
 * Ts0pe_ObjCtrlBuilderCOTNameを追加
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/11   Time: 3:34
 * Created in $/source/D5Integrated/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/03   Time: 23:41
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridgeのコンポーネントエディタとしてTs0ce_ObjCtrlBridgeを追加。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/21   Time: 16:59
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridgeを追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * コンポーネントパレットの登録先を変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf,DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0ObjCtrlBuilder,
  s0ce_ObjCtrlBridge;


procedure Register;

implementation

procedure Register;
begin
  { Component Editors }
  RegisterComponentEditor(Ts0ObjCtrlBridge, Ts0ce_ObjCtrlBridge);

  { Property Editors }
  RegisterPropertyEditor(TypeInfo(String), Ts0ObjCtrlBuilder,
    'CtrlOfTypeClassName', Ts0pe_ObjCtrlBuilderCOTName);
end;

end.
