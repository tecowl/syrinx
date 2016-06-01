unit s0pe_ColorIdentifier;
{
$History: s0pe_ColorIdentifier.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 4  *****************
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
  DsgnIntf;
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts;
{$ENDIF}

type
  Ts0pe_ColorIdentifier = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

uses
//  c0LogManager,
  s0ColorSet;

{ Ts0pe_ColorIdentifier }

function Ts0pe_ColorIdentifier.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

procedure Ts0pe_ColorIdentifier.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  colMan: Ts0ColorManager;
begin
  colMan := Ts0ColorManager.Instance;
  //Ts0Logger.Instance.LoggingLevel := k0llFrameworkDebug;
  if colMan = nil then
  begin
    //Trace(Self, 'GetValues', 'colMan��nil-----�I');
    Exit;
  end;
  for i := 0 to colMan.Items.Count - 1 do
  begin
    Proc(colMan.Items.Items[i].Identifier);
  end;
end;

end.
