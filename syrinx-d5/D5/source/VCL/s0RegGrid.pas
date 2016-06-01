unit s0RegGrid;
{
$History: s0RegGrid.pas $
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/03/14   Time: 21:37
 * Updated in $/D5/source/VCL
 * Ts0GridCmdMenuItem���R���|�[�l���g�p���b�g�ɓo�^
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/30   Time: 17:33
 * Updated in $/source/D5Integrated
 * Ts0GridCmd_AddRow��ǉ�
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/07   Time: 18:27
 * Updated in $/source/D5Integrated
 * �f�U�C�i�[�֌W�͐݌v���p�̃p�b�P�[�W�ɑS�Ĉړ�����
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/12   Time: 21:41
 * Updated in $/source/D5Integrated
 * Ts0ObjListGrid�ATs0CollectionGrid��ǉ�
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/01   Time: 9:17
 * Updated in $/source/D5Integrated
 * Ts0ChangeCellSize�ATs0ShowAllColumns��ǉ�
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/28   Time: 15:53
 * Updated in $/source/D5Integrated
 * Ts0ChangeCellSize��ǉ�
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/20   Time: 18:37
 * Updated in $/source/D5Integrated
 * �o�^��̃y�[�W�����hP Grid�h�ɕύX
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/07   Time: 3:06
 * Updated in $/source/D5Integrated
 * Command�֌W��RegisterNoIcon�œo�^����悤�ɕύX
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * �R���|�[�l���g�p���b�g�̓o�^���ύX
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
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
