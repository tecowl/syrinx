unit s0RegCEDBGrid;
{
$History: s0RegCEDBGrid.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:28
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/11   Time: 3:34
 * Created in $/source/D5Integrated/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/12/07   Time: 14:36
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/02   Time: 3:12
 * Updated in $/source/D5Integrated
 * �]�v�ȃ��j�b�g��uses����͂������B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * �R���|�[�l���g�p���b�g�̓o�^���ύX
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0dbgrid
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
}

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf;
{$ELSE}
  DesignIntf,DesignEditors, VCLEditors, RTLConsts;
{$ENDIF}

procedure Register;

implementation

procedure Register;
begin
  { Component Editors }

  { Property Editors }
end;

end.
