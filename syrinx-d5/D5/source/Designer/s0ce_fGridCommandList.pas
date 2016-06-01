unit s0ce_fGridCommandList;
{
$History: s0ce_fGridCommandList.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/06   Time: 21:24
 * Updated in $/source/D5Integrated
 * グリッドを表示に使用して、ショートカットを表示できるようにした
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  s0BaseGrid, s0Observer, Grids, ExtCtrls, Menus;

type
  Ts0ce_frmGridCommandList = class(TForm)
    grdCommands: TStringGrid;
    Panel1: TPanel;
    cmbCommandClasses: TComboBox;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    Delete1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdCommandsClick(Sender: TObject);
    procedure grdCommandsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
  private
    FDesigner: I0Designer;
    FTarget: Ts0CustomBaseGrid;
    FListener: Ts0EventListener;
    procedure SetDesigner(const Value: I0Designer);
    procedure SetTarget(const Value: Ts0CustomBaseGrid);
    procedure RefreshList;
  public
    property Target: Ts0CustomBaseGrid read FTarget write SetTarget;
    property Designer: I0Designer read FDesigner write SetDesigner;
    procedure TargetOnChange(Sender: TObject);
  end;

var
  frm0ceGridCommandList: Ts0ce_frmGridCommandList;

implementation

{$R *.DFM}

{ TForm2 }

procedure Ts0ce_frmGridCommandList.FormCreate(Sender: TObject);
begin
  FListener := Ts0EventListener.Create(TargetOnChange);
  cmbCommandClasses.Items.Clear;
  Ts0GridCommand.GetRegisteredClassNames( cmbCommandClasses.Items );
end;

procedure Ts0ce_frmGridCommandList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FListener);
end;

procedure Ts0ce_frmGridCommandList.TargetOnChange(Sender: TObject);
begin
  RefreshList;
end;

procedure Ts0ce_frmGridCommandList.FormShow(Sender: TObject);
begin
  RefreshList;
end;

procedure Ts0ce_frmGridCommandList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure Ts0ce_frmGridCommandList.SetDesigner(const Value: I0Designer);
begin
  FDesigner := Value;
end;

procedure Ts0ce_frmGridCommandList.SetTarget(const Value: Ts0CustomBaseGrid);
begin
  FTarget := Value;
  if FTarget = nil then Exit;
  FTarget.Commands.OnChange.Attach(FListener);
end;

procedure Ts0ce_frmGridCommandList.RefreshList;
var
  i: Integer;
  r: Integer;
  cmd: Ts0GridCommand;
begin
  if grdCommands.FixedRows > 0 then
  begin
    grdCommands.Cells[0, 0] := 'Command';
    grdCommands.Cells[1, 0] := 'ShortCut';
  end;
  if FTarget.Commands.Count < 1 then
  begin
    grdCommands.RowCount := grdCommands.FixedRows + 1;
    grdCommands.Rows[grdCommands.FixedRows].Clear;
  end
  else
    grdCommands.RowCount := FTarget.Commands.Count + grdCommands.FixedRows;

  for i := 0 to FTarget.Commands.Count -1 do
  begin
    r := i + grdCommands.FixedRows;
    cmd := FTarget.Commands.Items[i];
    grdCommands.Cols[0].Objects[r] := cmd;
    grdCommands.Cells[0, r] := cmd.GetCommandName;
    grdCommands.Cells[1, r] := ShortCutToText(cmd.ShortCut);
  end;
end;

procedure Ts0ce_frmGridCommandList.grdCommandsClick(Sender: TObject);
var
  item: Ts0GridCommand;
begin
  if grdCommands.Row < grdCommands.FixedRows then Exit;
  if grdCommands.Row > grdCommands.RowCount -1 then Exit;
  item := Ts0GridCommand( grdCommands.Cols[0].Objects[ grdCommands.Row ] );
  if Designer = nil then Exit;
  Designer.SelectComponent( item );
end;

procedure Ts0ce_frmGridCommandList.grdCommandsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    grdCommandsClick(nil);
end;

procedure Ts0ce_frmGridCommandList.Button1Click(Sender: TObject);
var
  cls: Ts0GridCommandClass;
begin
  cls := Ts0GridCommand.GetCommandByName(cmbCommandClasses.Items.Strings[cmbCommandClasses.ItemIndex]);
  if cls = nil then Exit;
  Target.Commands.AddItem(cls);
  RefreshList;
end;

procedure Ts0ce_frmGridCommandList.Delete1Click(Sender: TObject);
begin
  if not(grdCommands.Cols[0].Objects[grdCommands.Row] is Ts0GridCommand) then Exit;
  Target.Commands.Remove(Ts0GridCommand(grdCommands.Cols[0].Objects[grdCommands.Row]));
  RefreshList;
end;

end.
