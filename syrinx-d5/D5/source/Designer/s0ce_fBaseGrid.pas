unit s0ce_fBaseGrid;
{
$History: s0ce_fBaseGrid.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/12/11   Time: 3:40
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/03   Time: 23:46
 * Updated in $/source/D5Integrated
 * dfmにTs0BaseGridなどのインスタンスが書き込まれないように動的に生成する
 * ように変更。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/02   Time: 9:54
 * Updated in $/source/D5/p0grid
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/02   Time: 3:15
 * Updated in $/source/D5Integrated
 * フレームを使用しないで、動的にグリッドを生成するようにした。
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Grids, s0BaseGrid, StdCtrls,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf,DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  Menus, Buttons,
  Contnrs,
  ExtCtrls, ComCtrls, s0BindGrid, CheckLst, s0ObjCtrlBuilder;

type
  Ts0ce_frmBaseGrid = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    pgCells: TTabSheet;
    pgDecorators: TTabSheet;
    Panel2: TPanel;
    dspDecos: TListBox;
    Splitter1: TSplitter;
    pnlProps: TScrollBox;
    Splitter2: TSplitter;
    c0ObjCtrlBridge1: Ts0ObjCtrlBridge;
    Panel3: TPanel;
    chkAlwaysShowEditor: TCheckBox;
    Panel4: TPanel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure s0BaseGrid1ChangeCurrent(Sender: TObject; AOld,
      ANew: TGridCoord);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure dspDecosClick(Sender: TObject);
    procedure chkAlwaysShowEditorClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FDesigner: I0Designer;
    FTarget: Ts0CustomBaseGrid;
    FCellEditor: Ts0CustomBaseGrid;
    FDecoEditor: Ts0CustomBaseGrid;
    procedure SetDesigner(const Value: I0Designer);
    procedure SetTarget(const Value: Ts0CustomBaseGrid);
    procedure CopyDecos(Source, Dest: Ts0CustomBaseGrid);
  protected
    procedure CreateGrids;
  public
    property Target: Ts0CustomBaseGrid read FTarget write SetTarget;
    property Designer: I0Designer read FDesigner write SetDesigner;
  end;

var
  frm0ceBaseGrid: Ts0ce_frmBaseGrid;

implementation

{$R *.DFM}

uses
  //s0fObjEditor,
  s0ComponentHelper,
  s0TypInfoWrapper,
  s0CellDecorator,
  s0Collection,
  s0BaseGridCommand;

type
  Tc9MenuItem = class(TMenuItem)
  private
    FForm: Ts0ce_frmBaseGrid;
    FDecos: Ts0CellDecorators;
  public
    procedure Click; override;
  end;

{ Tc9MenuItem }

procedure Tc9MenuItem.Click;
var
  ci: Ts0CollectionItem;
begin
  inherited;
  if FDecos = nil then Exit;
  ci := FDecos.Add;
  if ci is Ts0CellDecorator then
  if FForm.FDecoEditor.Selected.Count < 1 then Exit;
  Ts0CellDecorator(ci).DecoRect := FForm.FDecoEditor.Selected.Items[0].AsRect;
  FForm.FDecoEditor.Col := FForm.FDecoEditor.Selected.Items[0].Left;
  FForm.FDecoEditor.Row := FForm.FDecoEditor.Selected.Items[0].Top;
end;

{ Ts0ce_frmBaseGrid }

procedure Ts0ce_frmBaseGrid.FormCreate(Sender: TObject);
begin
//
end;

procedure Ts0ce_frmBaseGrid.FormDestroy(Sender: TObject);
begin
//
end;

procedure Ts0ce_frmBaseGrid.FormShow(Sender: TObject);
begin
  CreateGrids;
end;

procedure Ts0ce_frmBaseGrid.CreateGrids;
  function NewGrid(APrent: TWinControl): Ts0CustomBaseGrid;
  begin
    Result := Ts0CustomBaseGridClass(Target.ClassType).Create(Self);
    Result.Parent := APrent;
    Result.Align := alClient;
    Result.Name := Ts0ComponentHelper.GetNewComponentName(Result);
  end;
  procedure CreateCellEditor;
  begin
    FCellEditor := NewGrid(pgCells);
    FCellEditor.FixedCols := 0;
    FCellEditor.FixedRows := 0;
    FCellEditor.Options := [
      goFixedVertLine, goFixedHorzLine, goVertLine,
      goHorzLine, goRangeSelect, goDrawFocusSelected,
      goEditing, goAlwaysShowEditor];
    FCellEditor.Commands.AddItem( Ts0GridCmd_CopyToClipBoard );
    FCellEditor.Commands.AddItem( Ts0GridCmd_CutToClipBoard );
    FCellEditor.Commands.AddItem( Ts0GridCmd_DeleteSelection );
    FCellEditor.Commands.AddItem( Ts0GridCmd_PasteFromClipBoard );
    FCellEditor.Commands.AddItem( Ts0GridCmd_SelectAll );
    FCellEditor.Commands.AddItem( Ts0GridCmd_InsertCol );
    FCellEditor.Commands.AddItem( Ts0GridCmd_InsertRow );
    FCellEditor.Commands.AddItem( Ts0GridCmd_RemoveCol );
    FCellEditor.Commands.AddItem( Ts0GridCmd_RemoveRow );
    FCellEditor.CreateCmdMenu;
    chkAlwaysShowEditor.Checked := goAlwaysShowEditor in FCellEditor.Options;
  end;
  procedure CreateDecoEditor;
  var
    pm: TPopupMenu;
    mi: Tc9MenuItem;
    i: Integer;
    w: Ts0RTTIPublishedAccessor;
    dl: TObjectList;
  begin
    FDecoEditor := NewGrid(pgDecorators);
    FDecoEditor.FixedCols := Target.FixedCols;
    FDecoEditor.FixedRows := Target.FixedRows;
    FDecoEditor.OnChangeCurrent := s0BaseGrid1ChangeCurrent;
    FDecoEditor.Options := FDecoEditor.Options  - [goEditing];
    w := Ts0RTTIPublishedAccessor.Create(FDecoEditor);
    try
      if w.RTTINavigator.Props.PropByName('PopupMenu') = nil then Exit;
      if w.ObjectPropClass[ 'PopupMenu' ] <> TPopupMenu then Exit;
      pm := TPopupMenu.Create(Self);
      w.ObjectProp[ 'PopupMenu' ] := pm;
      //
      dl := TObjectList.Create(False);
      try
        FDecoEditor.GetDecoList(dl);
        for i := 0 to dl.Count -1 do
        begin
          if not(dl.Items[i] is Ts0CellDecorators) then Continue;
          mi := Tc9MenuItem.Create(Self);
          mi.FForm := Self;
          mi.FDecos := Ts0CellDecorators( dl.Items[i] );
          mi.Caption := 'Add to ' + dl.Items[i].ClassName;
          pm.Items.Add(mi);
        end;
      finally
        FreeAndNil(dl);
      end;
    finally
      FreeAndNil(w);
    end;
  end;
  procedure LoadCells(Dest: Ts0CustomBaseGrid);
  var
    x, y: Integer;
  begin
    Dest.ColCount := Target.ColCount;
    Dest.RowCount := Target.RowCount;
    for y := 0 to Target.RowCount -1 do
      for x := 0 to Target.ColCount -1 do
        Dest.Cells[x, y] := Target.Cells[x, y];
  end;
begin
  if not(Target is Ts0CustomBaseGrid) then Exit;
  if FCellEditor = nil then CreateCellEditor;
  if FDecoEditor = nil then CreateDecoEditor;
  LoadCells(FCellEditor);
  LoadCells(FDecoEditor);
  CopyDecos(Target, FDecoEditor);
end;

procedure Ts0ce_frmBaseGrid.SetDesigner(const Value: I0Designer);
begin
  FDesigner := Value;
end;

procedure Ts0ce_frmBaseGrid.SetTarget(const Value: Ts0CustomBaseGrid);
begin
  FTarget := Value;
end;

procedure Ts0ce_frmBaseGrid.s0BaseGrid1ChangeCurrent(Sender: TObject; AOld,
  ANew: TGridCoord);
var
  i, j: Integer;
  ds: Ts0CellDecorators;
  c, r: Integer;
  dl: TObjectList;
begin
  dl := TObjectList.Create(False);
  try
    FDecoEditor.GetDecoList(dl);
    dspDecos.Items.Clear;
    c := ANew.X;
    r := ANew.Y;
    for i := 0 to dl.Count -1 do
    begin
      if not(dl.Items[i] is Ts0CellDecorators) then Continue;
      ds := Ts0CellDecorators(dl.Items[i]);
      for j := 0 to ds.Count -1 do
        if ds.Decorators[j].CanDecorate(c, r) then
          dspDecos.Items.AddObject( ds.Decorators[j].GetNamePath, ds.Decorators[j]);
    end;
    dspDecosClick(nil);
  finally
    FreeAndNil(dl);
  end;
end;

procedure Ts0ce_frmBaseGrid.CopyDecos(Source, Dest: Ts0CustomBaseGrid);
var
  dl: TObjectList;
  i: Integer;
  srcDecos, destDecos: Ts0CellDecorators;
begin
  dl := TObjectList.Create(False);
  try
    Source.GetDecoList(dl);          
    for i := 0 to dl.Count -1 do
    begin
      if not (dl.Items[i] is Ts0CellDecorators) then Continue;
      srcDecos := Ts0CellDecorators(dl.Items[i]);
      destDecos := Dest.GetDecorators( Ts0CellDecoratorsClass(dl.Items[i].ClassType) );
      if srcDecos = nil then Continue;
      destDecos.Assign(srcDecos);
    end;
  finally
    FreeAndNil(dl);
  end;
end;

procedure Ts0ce_frmBaseGrid.BitBtn2Click(Sender: TObject);
  procedure CopyCells;
  var
    x, y: Integer;
  begin
    Target.ColCount := FCellEditor.ColCount;
    Target.RowCount := FCellEditor.RowCount;
    for y := 0 to FCellEditor.RowCount -1 do
      for x := 0 to FCellEditor.ColCount -1 do
        Target.Cells[x, y] := FCellEditor.Cells[x, y];
  end;
begin
  CopyCells;
  CopyDecos(FDecoEditor, Target);
  if Designer <> nil then
    Designer.Modified;
end;

procedure Ts0ce_frmBaseGrid.dspDecosClick(Sender: TObject);
var
  idx: Integer;
begin
  idx := dspDecos.ItemIndex;
  if idx > -1 then
  begin
    if c0ObjCtrlBridge1.Target = dspDecos.Items.Objects[idx] then Exit;
    pnlProps.Enabled := True;
    c0ObjCtrlBridge1.ClearCtrls;
    c0ObjCtrlBridge1.ProtoTypes.Clear;
    c0ObjCtrlBridge1.Builder.CtrlParent := pnlProps;
    c0ObjCtrlBridge1.Target := dspDecos.Items.Objects[idx];
    c0ObjCtrlBridge1.BuildCtrls;
    c0ObjCtrlBridge1.LoadFromTarget;
  end
  else
  begin
    if dspDecos.Items.Count > 0 then
    begin
      dspDecos.ItemIndex := 0;
      dspDecosClick(nil);
      Exit;
    end;
    pnlProps.Enabled := False;
    c0ObjCtrlBridge1.ClearCtrls;
    c0ObjCtrlBridge1.ProtoTypes.Clear;
    c0ObjCtrlBridge1.Target := nil;
  end;
end;

procedure Ts0ce_frmBaseGrid.chkAlwaysShowEditorClick(Sender: TObject);
begin
  if chkAlwaysShowEditor.Checked then
    FCellEditor.Options := FCellEditor.Options + [goAlwaysShowEditor]
  else
    FCellEditor.Options := FCellEditor.Options - [goAlwaysShowEditor];
end;

procedure Ts0ce_frmBaseGrid.Button1Click(Sender: TObject);
begin
  c0ObjCtrlBridge1.SaveToTarget;
end;

end.
