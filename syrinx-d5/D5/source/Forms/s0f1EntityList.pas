unit s0f1EntityList;
{
$History: s0f1EntityList.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/03   Time: 5:07
 * Updated in $/source/D5Integrated/Forms
 * ���j�b�g���ύX����
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0entity
 * p0entity�ЂƂ܂�OK�B
 * �������A�ėp�I�ȃt�H�[���̂��߂Ƀ��t�@�N�^�����O���v�Ē��E�E�E
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/28   Time: 8:22
 * Updated in $/source/D5/p0entity
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/27   Time: 20:03
 * Created in $/source/D5/p0entity
 * �V�K�쐬
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Entity, s0EntityDispImpl,
  s0f0EntityDisplay, s0FormEventPublisher, s0FormRelation, s0EntityListImpl,
  s0VCLClasses, s0ComponentEventWrapper;

type
  Ts0frmEntityList = class(Ts0frmEntityDisplay)
    impList: Ts0EntityListImpl;
  protected
  public
    class function GetEnableMode: K0DisplayType; override;
  end;

var
  frm0EntityList: Ts0frmEntityList;

implementation

{$R *.DFM}

{ Ts0frmEntityList }

class function Ts0frmEntityList.GetEnableMode: K0DisplayType;
begin
  Result := k0dtList;
end;

end.
