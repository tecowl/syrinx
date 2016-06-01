unit s0f3AltMemoDisp;
{
$History: s0f3AltMemoDisp.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:07
 * Updated in $/source/D5Integrated/Forms
 * ���j�b�g���ύX����
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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0f2EntityMemoDisp, s0f0EntityDisplay, s0EntityDetailImpl,
  s0FormEventPublisher, s0FormRelation, StdCtrls,
  s0Entity, ActnList, ExtCtrls, a0EntityNaviList;

type
  Ts0frmAltMemoDisp = class(Ts0frmEntityMemoDisp)
  private
    FTargetClass: Ts0EntityClass;
  protected
    function GetTargetClass: Ts0EntityClass; override;
    procedure SetTargetClass(Value: Ts0EntityClass); override;
  public
    class function GetTargetClassBeforeCreate: Ts0EntityClass; override;
    class function IsAlternative: Boolean; override;
  end;

var
  frm0AltMemoDisp: Ts0frmAltMemoDisp;

implementation

{$R *.DFM}

{ Ts0frmAltMemoDisp }

function Ts0frmAltMemoDisp.GetTargetClass: Ts0EntityClass;
begin
  Result := FTargetClass;
end;

class function Ts0frmAltMemoDisp.GetTargetClassBeforeCreate: Ts0EntityClass;
begin
  Result := nil;
end;

class function Ts0frmAltMemoDisp.IsAlternative: Boolean;
begin
  Result := True;
end;

procedure Ts0frmAltMemoDisp.SetTargetClass(Value: Ts0EntityClass);
begin
  FTargetClass := Value;
end;

initialization
  RegisterDispClass(Ts0frmAltMemoDisp);

finalization
  UnRegisterDispClass(Ts0frmAltMemoDisp);

end.
