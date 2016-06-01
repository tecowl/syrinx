unit s0Buttons;
{
$History: s0Buttons.pas $
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
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0ctrl
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
 *
 * *****************  Version 2  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * �R�����g�\���R�} ���h�ǉ�
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons;

type
  Ts0BitBtn = class(TBitBtn)
  private
  protected
    FInClicking: Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  public
    procedure Click; override;
  published
    property Align;
  end;

implementation

uses
  s0TabOrderController;

{ Ts0BitBtn }

procedure Ts0BitBtn.Click;
begin
  inherited Click;
  FInClicking := True;
end;

procedure Ts0BitBtn.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FInClicking := False;
  inherited;
  Ts0TabOrderController.Instance.BtnKeyDown(Self, Key, Shift);
end;

procedure Ts0BitBtn.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if FInClicking then
    Ts0TabOrderController.Instance.BtnKeyUp(Self, Key, Shift);
  FInClicking := False;
end;

end.
