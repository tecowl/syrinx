unit s0RegCEEntity;
{
$History: s0RegCEEntity.pas $
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
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/12   Time: 21:41
 * Updated in $/source/D5Integrated
 * Ts0EntityPool��ǉ�
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/04   Time: 12:22
 * Updated in $/source/D5Integrated
 * Ts0DBEntityManager�̃R���|�[�l���g�G�f�B�^Ts0ce_DBEntityMan��o�^
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/21   Time: 16:59
 * Updated in $/source/D5Integrated
 * Tc0EntityCtrlBridge���폜
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/19   Time: 20:46
 * Updated in $/source/D5Integrated
 * Tc0EntityCtrlBridge��ǉ�
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * �R���|�[�l���g�p���b�g�̓o�^���ύX
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
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
  DesignIntf,DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DBEntity,
  s0ce_DBEntityManager
  ;

procedure Register;

implementation

procedure Register;
begin
  { Component Editors }
  RegisterComponentEditor(Ts0DBEntityManager, Ts0ce_DBEntityMan);

  { Property Editors }
end;

end.
