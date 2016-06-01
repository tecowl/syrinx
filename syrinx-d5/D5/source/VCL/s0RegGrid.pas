unit s0RegGrid;
{
$History: s0RegGrid.pas $
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/03/14   Time: 21:37
 * Updated in $/D5/source/VCL
 * Ts0GridCmdMenuItemをコンポーネントパレットに登録
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
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
 * User: Akima        Date: 02/01/30   Time: 17:33
 * Updated in $/source/D5Integrated
 * Ts0GridCmd_AddRowを追加
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/07   Time: 18:27
 * Updated in $/source/D5Integrated
 * デザイナー関係は設計時用のパッケージに全て移動した
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/12   Time: 21:41
 * Updated in $/source/D5Integrated
 * Ts0ObjListGrid、Ts0CollectionGridを追加
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/01   Time: 9:17
 * Updated in $/source/D5Integrated
 * Ts0ChangeCellSize、Ts0ShowAllColumnsを追加
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/28   Time: 15:53
 * Updated in $/source/D5Integrated
 * Ts0ChangeCellSizeを追加
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/20   Time: 18:37
 * Updated in $/source/D5Integrated
 * 登録先のページ名を”P Grid”に変更
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/07   Time: 3:06
 * Updated in $/source/D5Integrated
 * Command関係をRegisterNoIconで登録するように変更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * コンポーネントパレットの登録先を変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes,
  s0GridRadioGroup,
  s0BindGrid,
  s0DecoGrid,
  s0CtrlGrid,
  s0CollectionGrid,
  s0ObjListGrid,
  s0GridCellCheck,
  s0BaseGrid,
  s0BaseGridCommand
  ;


procedure Register;

implementation

uses
  ActnList;

procedure Register;
begin
  RegisterComponents('P Grid', [Ts0BindGrid]);
  RegisterComponents('P Grid', [Ts0CtrlGrid]);
  RegisterComponents('P Grid', [Ts0DecoGrid]);
  RegisterComponents('P Grid', [Ts0BaseGrid]);
  RegisterComponents('P Grid', [Ts0ObjListGrid]);
  RegisterComponents('P Grid', [Ts0CollectionGrid]);
  RegisterComponents('P Grid', [Ts0GridRadioGroup]);
  RegisterComponents('P Grid', [Ts0GridCellCheck]);
  RegisterComponents('P Grid', [Ts0GridCmdMenuItem]);
  RegisterNoIcon([
    Ts0GridNumbering,
    Ts0CustomGridSorter,
    Ts0CustomGridCellFinder,
    Ts0GridCmd_AddRow,
    Ts0GridCmd_CopyToClipBoard,
    Ts0GridCmd_CutToClipBoard,
    Ts0GridCmd_DeleteSelection,
    Ts0GridCmd_InsertCol,
    Ts0GridCmd_InsertRow,
    Ts0GridCmd_PasteFromClipBoard,
    Ts0GridCmd_RemoveCol,
    Ts0GridCmd_RemoveRow,
    Ts0GridCmd_SelectAll,
    Ts0MoveCellKeyDown,
    Ts0ChangeCellSize,
    Ts0ShowAllColumns
  ] );
  RegisterClasses( [
    Ts0GridNumbering,
    Ts0CustomGridSorter,
    Ts0CustomGridCellFinder,
    Ts0GridCmd_AddRow,
    Ts0GridCmd_CopyToClipBoard,
    Ts0GridCmd_CutToClipBoard,
    Ts0GridCmd_DeleteSelection,
    Ts0GridCmd_InsertCol,
    Ts0GridCmd_InsertRow,
    Ts0GridCmd_PasteFromClipBoard,
    Ts0GridCmd_RemoveCol,
    Ts0GridCmd_RemoveRow,
    Ts0GridCmd_SelectAll,
    Ts0MoveCellKeyDown,
    Ts0ChangeCellSize,
    Ts0ShowAllColumns
  ] );

//  RegisterActions('Edit', [Ts0BaseGridAction], nil);
end;

end.
