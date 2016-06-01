unit s0pe_EscapeSequenceString;
{
$History: s0pe_EscapeSequenceString.pas $
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
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/12   Time: 2:13
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
 * 
 * *****************  Version 2  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * �R�����g�\���R�}���h�ǉ�
}

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf;
{$ELSE}
  DesignEditors, VCLEditors, RTLConsts;
{$ENDIF}

type
  // �����s�̓��͂�\n�Ŏ󂯓����v���p�e�B�G�f�B�b�^
  Ts0pe_EscapeSequenceString = class(TCaptionProperty)
  public
    Function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

implementation

uses
  s0StringHelper;

function Ts0pe_EscapeSequenceString.GetValue: string;
begin
  Result := GetStrValue;
  Ts0StringHelper.EncodeEscapeSeq(Result);
end;

procedure Ts0pe_EscapeSequenceString.SetValue(const Value: string);
var
  capt: string;
begin
  capt := Value;
  Ts0StringHelper.DecodeEscapeSeq(capt);
  SetStrValue(capt);
end;


end.
 
