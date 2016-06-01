unit s0RegCECore;
{
$History: s0RegCECore.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:28
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/08   Time: 5:04
 * Updated in $/source/D6VCLIntegrated/Designer
 * Ts0ce_Control��Ts0ce_WinControl��ǉ�
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/06   Time: 13:32
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/10   Time: 3:21
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/11   Time: 3:34
 * Created in $/source/D5Integrated/Designer
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * �R���|�[�l���g�p���b�g�̓o�^���ύX
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0core
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

uses
  Controls,
  s0ce_Component,
  s0ce_Control;

procedure Register;
begin
  { Component Editors }
  RegisterComponentEditor(TComponent , Ts0ce_Component );
  RegisterComponentEditor(TControl   , Ts0ce_Control   );
  RegisterComponentEditor(TWinControl, Ts0ce_WinControl);

  { Property Editors }
end;

end.
