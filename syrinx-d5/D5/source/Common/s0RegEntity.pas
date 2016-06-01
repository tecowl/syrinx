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
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/21   Time: 22:44
 * Updated in $/source/D6VCLIntegrated
 * Ts0EntityFormManager�ATc0EntityAltFormManager���폜
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/12/07   Time: 18:27
 * Updated in $/source/D5Integrated
 * �f�U�C�i�[�֌W�͐݌v���p�̃p�b�P�[�W�ɑS�Ĉړ�����
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
  s0EntityPool;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Entity', [Ts0EntityPool]);
end;

end.
