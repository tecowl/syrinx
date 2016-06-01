unit s0ce_ModeController;
{
$History: s0ce_ModeController.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/12   Time: 23:44
 * Updated in $/source/D6VCLIntegrated/Designer
 * �R���|�[�l���g�G�f�B�^���p��������@���m��
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
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
  DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  s0ce_Component;

type
  Ts0ce_ModeController = class(Ts0ce_Component)
  private
    procedure ImplExecuteVerb(Index: Integer);
    function ImplGetVerb(Index: Integer): string;
    function ImplGetVerbCount: Integer;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: T0DesignMenu); override;
  end;

implementation

uses
  s0ce_fModeController,
  s0ModeController;

{ Ts0ce_ModeController }

procedure Ts0ce_ModeController.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_ModeController.GetVerb(Index: Integer): string;
begin
  Result := '';
  if Index < ImplGetVerbCount then
  begin
    Result := ImplGetVerb(Index);
  end
  else
    if ClassType <> Ts0ce_Component then
      Result := inherited GetVerb(Index - ImplGetVerbCount)
end;

function Ts0ce_ModeController.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_ModeController.ImplExecuteVerb(Index: Integer);
  procedure ShowEditItem;
  var
    frm: Ts0ce_frmModeController;
  begin
    frm := Ts0ce_frmModeController.Create(nil);
    try
      frm.Target := Ts0ModeController(Component);
      frm.Designer := Self.Designer;
      frm.ShowModal;
    finally
      FreeAndNil(frm);
    end;
  end;
begin
  case Index of
    0: ShowEditItem;
  end;
end;

resourcestring
  c9VerbItem_EditItem = '���ڂ̕ҏW(&E)';

function Ts0ce_ModeController.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := c9VerbItem_EditItem;
  end;
end;

function Ts0ce_ModeController.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Ts0ce_ModeController.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

end.
