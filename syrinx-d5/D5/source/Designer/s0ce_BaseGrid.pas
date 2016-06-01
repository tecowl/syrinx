unit s0ce_BaseGrid;
{
$History: s0ce_BaseGrid.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/14   Time: 23:46
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/12   Time: 23:43
 * Updated in $/source/D6VCLIntegrated/Designer
 * �R���|�[�l���g�G�f�B�^���p��������@���m��
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130�AVER140���p�ɂ���
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
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
  s0ce_Control,
  s0ce_Grids,
  s0WrappedCE,
  s0BaseGrid;

type
  Ts0ce_BaseGrid = class(Ts0ce_Grids)
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
  Forms,
  s0ce_fGridCommandList, s0ce_Component;

{ Ts0ce_BaseGrid }

procedure Ts0ce_BaseGrid.ImplExecuteVerb(Index: Integer);
  procedure ShowCommandList;
  var
    frm: Ts0ce_frmGridCommandList;
  begin
    frm := Ts0ce_frmGridCommandList.Create(nil);
    frm.Designer := Self.Designer;
    frm.Target := Ts0CustomBaseGrid(Component);
    frm.Show;
  end;
begin
  case Index of
    0: ShowCommandList;
  end;
end;

function Ts0ce_BaseGrid.ImplGetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '�R�}���h�̐ݒ�';
  end;
end;

function Ts0ce_BaseGrid.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

function Ts0ce_BaseGrid.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_BaseGrid.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_BaseGrid.GetVerb(Index: Integer): string;
begin
  Result := '';
  if Index < ImplGetVerbCount then
  begin
    Result := ImplGetVerb(Index);
  end
  else
    Result := inherited GetVerb(Index - ImplGetVerbCount)
end;

procedure Ts0ce_BaseGrid.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

end.
