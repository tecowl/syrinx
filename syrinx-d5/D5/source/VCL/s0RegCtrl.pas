unit s0RegCtrl;
{
$History: s0RegCtrl.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/12   Time: 2:31
 * Updated in $/D6/source/VCL
 * Ts0ObjTreeMapper,Ts0ObjTreeMapMenu��ǉ�
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/21   Time: 23:27
 * Updated in $/source/D5Integrated
 * Ts0CheckListBox��RegisterComponents����ĂȂ������̂œo�^
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/07   Time: 18:27
 * Updated in $/source/D5Integrated
 * �f�U�C�i�[�֌W�͐݌v���p�̃p�b�P�[�W�ɑS�Ĉړ�����
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * �R���|�[�l���g�p���b�g�̓o�^���ύX
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0ctrl
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
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
