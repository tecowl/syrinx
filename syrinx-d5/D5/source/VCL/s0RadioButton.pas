unit s0RadioButton;
{
$History: s0RadioButton.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Ts0RadioButton = class(TRadioButton)
  private
    FOnChange: TNotifyEvent;
  protected
    procedure SetChecked(Value: Boolean); override;
    procedure DoChange;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

{ Ts0RadioButton }

procedure Ts0RadioButton.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure Ts0RadioButton.SetChecked(Value: Boolean);
var
  modified: Boolean;
begin
  modified := Checked <> Value;
  inherited;
  if modified then
    DoChange;
end;

end.
