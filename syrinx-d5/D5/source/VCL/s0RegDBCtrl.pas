unit s0RegDBCtrl;
{
$History: s0RegDBCtrl.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
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
 * Updated in $/source/D5/p0dbctrl
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
}

interface

uses
  SysUtils, Classes;

procedure Register;

implementation

uses
  s0DSFilterMaker, s0DBGridAction;


procedure Register;
begin
  { Components }
  RegisterComponents('P Form', [Ts0DSFilter]);
  RegisterComponents('P Form', [Ts0DBGridAction]);
end;

end.
