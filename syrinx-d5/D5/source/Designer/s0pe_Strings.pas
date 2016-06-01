unit s0pe_Strings;
{
$History: s0pe_Strings.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/21   Time: 23:34
 * Updated in $/source/D5Integrated/Designer
 * �s��C��
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/08   Time: 23:04
 * Created in $/source/p0common
 * �V�K�쐬
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
  Ts0pe_String = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

uses
  Controls,
  s0pe_fStrings;

{ Ts0pe_String }

procedure Ts0pe_String.Edit;
var
  frm: Ts0pe_frmStrings;
  s: TStrings;
begin
  frm := Ts0pe_frmStrings.Create(nil);
  try
    s := TStrings(GetOrdValue);
    frm.Strings := s;
    if frm.ShowModal <> mrOK then Exit;
    if Designer <> nil then
      Designer.Modified;
  finally
    FreeAndNil(frm);
  end;
end;

function Ts0pe_String.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paReadOnly];
end;

end.
