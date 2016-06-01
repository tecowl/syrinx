unit s0pe_CanvasDrawerName;
{
$History: s0pe_CanvasDrawerName.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
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
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0ControlDrawer;

type
  Ts0CanvasDrawerNameProperty = class(TStringProperty)
  protected
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

uses
  s0CanvasDrawer;

{ Ts0CanvasDrawerNameProperty }

function Ts0CanvasDrawerNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect, paRevertable];
end;

procedure Ts0CanvasDrawerNameProperty.GetValues(Proc: TGetStrProc);
begin
  Ts0CanvasDrawer.GetRegisteredNames(Proc, Ts0ControlMarker);
end;

end.
 
