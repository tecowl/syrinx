unit s0ce_fModeController;
{
$History: s0ce_fModeController.pas $
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
 * User: Akima        Date: 01/12/11   Time: 3:40
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/25   Time: 10:09
 * Updated in $/source/D5Integrated
 * Ts0CtrlDecoratorのAddメソッド変更に伴い変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0ctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0GridCellControl, s0GridCellCheck, s0Grids, s0BindGrid, s0BaseGrid,
  s0DecoGrid, s0CtrlGrid, ExtCtrls, StdCtrls, Buttons,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  s0ModeController, s0Splitter, s0ControlImage, s0CellDecorator;

type
  Ts0ce_frmModeController = class(TForm)
    grdCtrlItems: Ts0CtrlGrid;
    s0GridCellCheck1: Ts0GridCellCheck;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnNewMode: TButton;
    s0ControlImage1: Ts0ControlImage;
    s0Splitter1: Ts0Splitter;
    procedure btnNewModeClick(Sender: TObject);
    procedure grdCtrlItemsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FDesigner: I0Designer;
    FTarget: Ts0ModeController;
    procedure SetDesigner(const Value: I0Designer);
    procedure SetTarget(const Value: Ts0ModeController);
    procedure LoadFromTarget;
    procedure SaveToTarget;
  public
    property Target: Ts0ModeController read FTarget write SetTarget;
    property Designer: I0Designer read FDesigner write SetDesigner;
    function ShowModal: Integer; override;
  end;

var
  frm0ceModeController: Ts0ce_frmModeController;

implementation

uses
  s0CheckBoxHelper;

{$R *.DFM}

{ Ts0ce_frmModeController }

procedure Ts0ce_frmModeController.LoadFromTarget;
  procedure SetTitleCell;
  var
    i: Integer;
    bs: Ts0BindingSeal;
  begin
    grdCtrlItems.BindSeals.Clear;
    bs := Ts0BindingSeal(grdCtrlItems.BindSeals.Add);
    bs.Top := 0;
    bs.Left := 0;
    bs.Right := 0;
    bs.Bottom := 1;
    for i := 0 to Target.Modes.Count -1 do
    begin
      bs := Ts0BindingSeal(grdCtrlItems.BindSeals.Add);
      bs.RegionKind := k0gcrRect;
      bs.Top := 0;
      bs.Left := i * 3 + 1;
      bs.Right := i * 3 + 3;
      bs.Bottom := 0;
    end;
  end;

  procedure SetColRowCount;
  var
    d: Ts0CtrlDecorator;
    i: Integer;
  begin
    if Target.Modes.Count > 0 then
      grdCtrlItems.ColCount := Target.Modes.Count * 3 + grdCtrlItems.FixedCols
    else
      grdCtrlItems.ColCount := grdCtrlItems.FixedCols + 1;
    //
    if Target.Modes.Count > 0 then
    begin
      if Target.Modes[0].CtrlItems.Count > 0 then
        grdCtrlItems.RowCount := Target.Modes[0].CtrlItems.Count + grdCtrlItems.FixedRows
      else
        grdCtrlItems.RowCount := grdCtrlItems.FixedRows + 1;
    end
    else
      grdCtrlItems.RowCount := grdCtrlItems.FixedRows + 1;
    //
    grdCtrlItems.CtrlDecos.Clear;
    d := grdCtrlItems.CtrlDecos.Add(s0GridCellCheck1);
    d.RegionKind := k0gcrCols;
    d.Left := grdCtrlItems.FixedCols;
    d.Right := grdCtrlItems.ColCount -1;
    //
    for i := 0 to FTarget.Modes.Count -1 do
    begin
      grdCtrlItems.Cells[i * 3 + 1, 0] := Target.Modes[i].ModeName;
      grdCtrlItems.Cells[i * 3 + 1, 1] := 'Enabled';
      grdCtrlItems.Cells[i * 3 + 2, 1] := 'ReadOnly';
      grdCtrlItems.Cells[i * 3 + 3, 1] := 'Visible';
    end;
  end;

  procedure SetValue(ACol, ARow: Integer; Value: Boolean);
  begin
    grdCtrlItems.Cells[ACol, ARow] :=
      Ts0CheckBoxHelper.StateToStr( Ts0CheckBoxHelper.BoolToState(Value) );
  end;

  function GetRowIndex(AItem: Ts0ModeCtrlItem): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    if AItem.Target = nil then Exit;
    for i := grdCtrlItems.FixedRows to grdCtrlItems.RowCount -1 do
    begin
      if grdCtrlItems.Cells[0, i] = AItem.Target.Name then
      begin
        Result := i;
        Exit;
      end;
    end;
  end;
var
  i, j: Integer;
  rowIdx: Integer;
begin
  SetColRowCount;
  SetTitleCell;
  //
  if Target.Modes.Count > 0 then
    for i := 0 to Target.Modes[0].CtrlItems.Count -1 do
      if Target.Modes[0].CtrlItems[i].Target <> nil then
        grdCtrlItems.Cells[0, i + grdCtrlItems.FixedRows] :=
          Target.Modes[0].CtrlItems[i].Target.Name;
  for i := 0 to Target.Modes.Count -1 do
    for j := 0 to Target.Modes[i].CtrlItems.Count -1 do
    begin
      rowIdx := GetRowIndex(Target.Modes[i].CtrlItems[j]);
      if rowIdx < 0 then Continue;
      SetValue(i * 3 + 1, rowIdx, Target.Modes[i].CtrlItems[j].Enabled );
      SetValue(i * 3 + 2, rowIdx, Target.Modes[i].CtrlItems[j].ReadOnly);
      SetValue(i * 3 + 3, rowIdx, Target.Modes[i].CtrlItems[j].Visible );
    end;
end;

procedure Ts0ce_frmModeController.SaveToTarget;
  function GetCheckValue(ACol, ARow: Integer): Boolean;
  begin
    Result :=
      Ts0CheckBoxHelper.SateToBool(
        Ts0CheckBoxHelper.StrToState(grdCtrlItems.Cells[ACol, ARow]));
  end;

  function GetCtrlByName(AName: string): TControl;
  var
    i: Integer;
  begin
    Result := nil;
    if Target.Owner = nil then Exit;
    for i := 0 to Target.Owner.ComponentCount -1 do
      if (Target.Owner.Components[i].Name = AName) and
         (Target.Owner.Components[i] is TControl) then
      begin
        Result := TControl(Target.Owner.Components[i]);
        Exit;
      end;
  end;
var
  r, i: Integer;
  ctrl: TControl;
  item: Ts0ModeCtrlItem;
begin
  for r := grdCtrlItems.FixedRows to grdCtrlItems.RowCount -1 do
  begin
    ctrl := GetCtrlByName(grdCtrlItems.Cells[0, r]);
    for i := 0 to Target.Modes.Count - 1 do
    begin
      item := FTarget.Modes[i].CtrlItems.ItemByCtrl(ctrl);
      if item = nil then Continue;
      item.Enabled  := GetCheckValue(i * 3 + 1, r);
      item.ReadOnly := GetCheckValue(i * 3 + 2, r);
      item.Visible  := GetCheckValue(i * 3 + 3, r);
    end;
  end;
end;

procedure Ts0ce_frmModeController.SetDesigner(const Value: I0Designer);
begin
  FDesigner := Value;
end;

procedure Ts0ce_frmModeController.SetTarget(const Value: Ts0ModeController);
begin
  FTarget := Value;
end;

function Ts0ce_frmModeController.ShowModal: Integer;
begin
  Result := mrCancel;
  if FTarget = nil then Exit;
  if FTarget.Owner is TWinControl then
    s0ControlImage1.Target := TWinControl(FTarget.Owner);
  s0ControlImage1.Refresh;
  LoadFromTarget;
  Result := inherited ShowModal;
  if Result = mrOK then
  begin
    SaveToTarget;
    if Assigned(Designer) then
      Designer.Modified;
  end;
end;

resourcestring
  c0InpDlg_Caption = 'モード新規作成';
  c0InpDlg_Prompt  = '新しいモードの名前を入力してください';

procedure Ts0ce_frmModeController.btnNewModeClick(Sender: TObject);
var
  mn: string;
begin
  mn := 'NewMode';
  if not InputQuery(c0InpDlg_Caption, c0InpDlg_Prompt, mn) then Exit;
  SaveToTarget;
  Ts0ModeItem(Target.Modes.Add).ModeName := mn;
  LoadFromTarget;
end;

procedure Ts0ce_frmModeController.grdCtrlItemsSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
  function GetItemCtrl: TControl;
  var
    i: Integer;
    n: string;
  begin
    Result := nil;
    n := grdCtrlItems.Cells[0, ARow];
    if Trim(n) = '' then Exit;
    if Target.Owner = nil then Exit;
    for i := 0 to Target.Owner.ComponentCount -1 do
    begin
      if Target.Owner.Components[i].Name <> n then Continue;
      if not(Target.Owner.Components[i] is TControl) then Continue;
      Result := TControl(Target.Owner.Components[i]);
      Exit;
    end;
  end;
begin
  s0ControlImage1.Selected.Clear;
  s0ControlImage1.Selected.Add(s0ControlImage1.Drawer.FindItem(GetItemCtrl));
  s0ControlImage1.Refresh;
end;

end.
