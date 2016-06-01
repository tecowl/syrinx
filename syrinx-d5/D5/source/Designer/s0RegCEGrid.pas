unit s0RegCEGrid;
{
$History: s0RegCEGrid.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:28
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/11   Time: 3:34
 * Created in $/source/D5Integrated/Designer
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
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0CellDecorator,
  s0BaseGrid,
  s0ce_Grids,
  s0ce_BaseGrid;


procedure Register;

implementation

procedure Register;
begin
  { Component Editors }
  RegisterComponentEditor(Ts0CustomBaseGrid, Ts0ce_BaseGrid);
  RegisterComponentEditor(Ts0CustomDecoStringGrid, Ts0ce_Grids);

  { Property Editors }
end;

end.
