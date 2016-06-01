unit f8TaskTracker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, ComCtrls, s0MenuBar, Menus, ToolWin, s0Grids, s0CellDecorator,
  s0BindGrid, s0CtrlGrid, s0DecoGrid, s0BaseGrid, s0ObjectGrid,
  s0ObjListGrid, s0CollectionGrid, s0TreeViewController, ExtCtrls,
  s0ObjCtrlBuilder, s0UnifiedObjCtrl, StdCtrls, s0Memo, s0Edit,
  s0DateEdit;

type
  Tfrm8Main = class(TForm)
    CoolBar1: TCoolBar;
    MainMenu1: TMainMenu;
    s0MenuBar1: Ts0MenuBar;
    ActionList1: TActionList;
    actNewStory: TAction;
    actNewTask: TAction;
    actNewSchedule: TAction;
    actClose: TAction;
    actRefreshSchedule: TAction;
    actRecalcSchedule: TAction;
    File1: TMenuItem;
    NewSchedule1: TMenuItem;
    NewTask1: TMenuItem;
    NewSchedule2: TMenuItem;
    N1: TMenuItem;
    CloseX1: TMenuItem;
    View1: TMenuItem;
    RefreshSchedule1: TMenuItem;
    RefreshSchedule2: TMenuItem;
    s0TreeViewController1: Ts0TreeViewController;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    actSave: TAction;
    actLoad: TAction;
    actSaveAs: TAction;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Edit1: TMenuItem;
    actLoad1: TMenuItem;
    actSaveAs1: TMenuItem;
    actSave1: TMenuItem;
    ScrollBox1: TScrollBox;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    Panel1: TPanel;
    grdSchedules: Ts0CollectionGrid;
    Splitter2: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actNewStoryExecute(Sender: TObject);
    procedure actRecalcScheduleExecute(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure actSaveExecute(Sender: TObject);
    procedure actSaveAsExecute(Sender: TObject);
    procedure actLoadExecute(Sender: TObject);
    procedure actRefreshScheduleExecute(Sender: TObject);
    procedure s0UnifiedObjCtrl1StandInCtrls(Sender: TObject);
    procedure s0UnifiedObjCtrl1InitCtrl(Sender: TObject;
      AProp: Ts0ProtoTypeCtrl; AControl: TControl);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  frm8Main: Tfrm8Main;

implementation

uses
  s0fObjEditor,
  d8TaskTracker;

{$R *.DFM}

{ Tfrm8Main }

procedure Tfrm8Main.FormCreate(Sender: TObject);
begin
  grdSchedules.Target := dm8TaskTracker.Schedules;
  s0TreeViewController1.Model := dm8TaskTracker.Stories;
end;

procedure Tfrm8Main.FormDestroy(Sender: TObject);
begin
//
end;

procedure Tfrm8Main.FormShow(Sender: TObject);
begin
//
end;

procedure Tfrm8Main.actNewStoryExecute(Sender: TObject);
var
  sch: T8PGSchedule;
begin
  sch := dm8TaskTracker.Schedules.Add(-1);
  Ts0frmObjEditor.ShowEditorModal(sch);
end;

procedure Tfrm8Main.actRecalcScheduleExecute(Sender: TObject);
begin
  dm8TaskTracker.ReClacSchedules;
end;

procedure Tfrm8Main.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  s0UnifiedObjCtrl1.ClearCtrls;
  s0UnifiedObjCtrl1.ProtoTypes.Clear;
  s0UnifiedObjCtrl1.Target := s0TreeViewController1.SelectedItem;
  s0UnifiedObjCtrl1.BuildCtrls;
  s0UnifiedObjCtrl1.LoadFromTarget;
end;

procedure Tfrm8Main.actSaveExecute(Sender: TObject);
begin
  dm8TaskTracker.SaveToFile;
end;

procedure Tfrm8Main.actSaveAsExecute(Sender: TObject);
begin
  if not SaveDialog1.Execute then Exit;
  dm8TaskTracker.Options.LastFileName := SaveDialog1.FileName;
  dm8TaskTracker.SaveToFile;
end;

procedure Tfrm8Main.actLoadExecute(Sender: TObject);
begin
  if not OpenDialog1.Execute then Exit;
  dm8TaskTracker.Options.LastFileName := OpenDialog1.FileName;
  dm8TaskTracker.LoadFromFile;
end;

procedure Tfrm8Main.actRefreshScheduleExecute(Sender: TObject);
begin
  grdSchedules.LoadFromTarget;
  s0TreeViewController1.RefreshView;
end;

procedure Tfrm8Main.s0UnifiedObjCtrl1StandInCtrls(Sender: TObject);
const
  c9CtrlMargin = 20;
var
  i: Integer;
  ctrl: TControl;
begin
  for i := 0 to s0UnifiedObjCtrl1.ProtoTypes.Count -1 do
  begin
    ctrl := s0UnifiedObjCtrl1.ProtoTypes.PropCtrls[i].Ctrl;
    if ctrl = nil then Continue;
    if ctrl is Ts0Edit then
    begin
      Ts0Edit(ctrl).Width := ScrollBox1.Width - Ts0Edit(ctrl).Left - c9CtrlMargin;
      Ts0Edit(ctrl).Anchors := [akLeft, akTop, akRight];
    end
    else
    if ctrl is Ts0Memo then
    begin
      Ts0Memo(ctrl).Width := ScrollBox1.Width - Ts0Memo(ctrl).Left - c9CtrlMargin;
      Ts0Memo(ctrl).Anchors := [akLeft, akTop, akRight];
    end;
  end;
end;

procedure Tfrm8Main.s0UnifiedObjCtrl1InitCtrl(Sender: TObject;
  AProp: Ts0ProtoTypeCtrl; AControl: TControl);
var
  dtEdit: Ts0DateEdit;
begin
  if AControl is Ts0DateEdit then
  begin
    dtEdit := Ts0DateEdit(AControl);
    dtEdit.EditYear.Visible   := True;
    dtEdit.EditMonth.Visible  := True;
    dtEdit.EditDay.Visible    := True;
    dtEdit.EditHour.Visible   := True;
    dtEdit.EditMinute.Visible := True;
    dtEdit.AutoSize := True;
  end;
end;

end.
