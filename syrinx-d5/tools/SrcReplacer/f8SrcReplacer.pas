unit f8SrcReplacer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, ToolWin, ComCtrls, Menus, s0MenuBar, s0FileFinder, StdCtrls,
  CheckLst, ExtCtrls, s0Grids, s0BindGrid, s0BaseGrid, s0DecoGrid,
  s0CtrlGrid, s0ObjectGrid, s0CollectionGrid, s0GridCellControl,
  s0GridCellCheck, s0Button,
  s0Collection, s0Edit, s0Label, s0CheckBox, s0Memo, s0ObjCtrlBuilder,
  s0UnifiedObjCtrl, s0FormEventPublisher, s0ObjPropStocker,
  s0IniPropStocker,
  s0TypInfoWrapper, s0CellDecorator, s0BaseGridCommand, c0SXProgressDlg;

type
  Tfrm8SrcReplacer = class(TForm)
    CoolBar1: TCoolBar;
    ActionList1: TActionList;
    actOpenFiles: TAction;
    actFindFiles: TAction;
    actExecReplace: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    E1: TMenuItem;
    Open1: TMenuItem;
    Replace1: TMenuItem;
    N1: TMenuItem;
    actClose: TAction;
    Close1: TMenuItem;
    Replace2: TMenuItem;
    s0MenuBar1: Ts0MenuBar;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Memo1: TMemo;
    Splitter2: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    actOpenReplaceText: TAction;
    N2: TMenuItem;
    R1: TMenuItem;
    actFindBeforeReplace: TAction;
    N3: TMenuItem;
    P1: TMenuItem;
    actSaveReplaceText: TAction;
    S1: TMenuItem;
    Panel1: TPanel;
    s0Button1: Ts0Button;
    s0Button2: Ts0Button;
    s0Button3: Ts0Button;
    s0Button4: Ts0Button;
    OpenDialog1: TOpenDialog;
    chkSubDir: Ts0CheckBox;
    edtSearchDir: Ts0Edit;
    edtMasks: Ts0Memo;
    s0Label1: Ts0Label;
    s0Label2: Ts0Label;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    s0CollectionGrid1: Ts0CollectionGrid;
    SaveDialog1: TSaveDialog;
    OpenDialog2: TOpenDialog;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    CheckListBox1: TCheckListBox;
    grdReplaceLines: Ts0CollectionGrid;
    c0GridCmd_CopyToClipBoard3: Ts0GridCmd_CopyToClipBoard;
    c0GridCmd_CutToClipBoard3: Ts0GridCmd_CutToClipBoard;
    c0GridCmd_DeleteSelection3: Ts0GridCmd_DeleteSelection;
    c0GridCmd_PasteFromClipBoard3: Ts0GridCmd_PasteFromClipBoard;
    c0GridCmd_SelectAll3: Ts0GridCmd_SelectAll;
    c0GridCmd_AddRow3: Ts0GridCmd_AddRow;
    c0GridCmd_InsertRow3: Ts0GridCmd_InsertRow;
    c0GridCmd_RemoveRow3: Ts0GridCmd_RemoveRow;
    c0GridCmd_CopyToClipBoard4: Ts0GridCmd_CopyToClipBoard;
    c0GridCmd_CutToClipBoard4: Ts0GridCmd_CutToClipBoard;
    c0GridCmd_DeleteSelection4: Ts0GridCmd_DeleteSelection;
    c0GridCmd_PasteFromClipBoard4: Ts0GridCmd_PasteFromClipBoard;
    c0GridCmd_SelectAll4: Ts0GridCmd_SelectAll;
    c0GridCmd_AddRow4: Ts0GridCmd_AddRow;
    c0GridCmd_InsertRow4: Ts0GridCmd_InsertRow;
    c0GridCmd_RemoveRow4: Ts0GridCmd_RemoveRow;
    c0ShowAllColumns1: Ts0ShowAllColumns;
    c0ShowAllColumns2: Ts0ShowAllColumns;
    c0SXProgressDlg1: Tc0SXProgressDlg;
    s0Button5: Ts0Button;
    actReplaceFileNames: TAction;
    procedure actOpenReplaceTextExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFindFilesExecute(Sender: TObject);
    procedure actSaveReplaceTextExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actOpenFilesExecute(Sender: TObject);
    procedure actFindBeforeReplaceExecute(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure actExecReplaceExecute(Sender: TObject);
    procedure actReplaceFileNamesExecute(Sender: TObject);
  private
    procedure RefreshFileNames;
    procedure DMThreadTerminated(Sender: TObject);
    procedure SetEnabledOfActions(Value: Boolean);
  private
    procedure ParentFileLoad(Sender: TObject; Accessor: Ts0RTTIPublishedAccessor; var Value: string);
    procedure ParentFileSave(Sender: TObject; Accessor: Ts0RTTIPublishedAccessor; Value: string);
  public
  end;

var
  frm8SrcReplacer: Tfrm8SrcReplacer;

implementation

uses
  s0TypeConvertor,
  d8SrcReplacer;

{$R *.DFM}

{ Tfrm8SrcReplacer }

procedure Tfrm8SrcReplacer.actOpenReplaceTextExecute(Sender: TObject);
begin
  OpenDialog1.Options := OpenDialog1.Options - [ofAllowMultiSelect];
  if not OpenDialog1.Execute then Exit;
  dm8SrcReplacer.LoadReplaceStrings(OpenDialog1.FileName);
end;

procedure Tfrm8SrcReplacer.FormCreate(Sender: TObject);
  procedure InitLinesEvents;
  var
    col: Ts0ObjectGridColumn;
  begin
    col := grdReplaceLines.Columns.FindColumn('ParentFile');
    if col = nil then Exit;
    col.CustomAccess := True;
    col.OnCustomLoad := ParentFileLoad;
    col.OnCustomSave := ParentFileSave;
  end;
begin
  s0CollectionGrid1.Target := dm8SrcReplacer.ReplaceStrings;
  s0UnifiedObjCtrl1.Target := dm8SrcReplacer.s0FileFinder1;
  s0UnifiedObjCtrl1.LoadFromTarget;
  grdReplaceLines.Target := dm8SrcReplacer.Targets.Lines;
  InitLinesEvents;
end;

procedure Tfrm8SrcReplacer.FormShow(Sender: TObject);
begin
  s0UnifiedObjCtrl1.LoadFromTarget;
end;

procedure Tfrm8SrcReplacer.actFindFilesExecute(Sender: TObject);
begin
  dm8SrcReplacer.FindFiles;
  RefreshFileNames;
end;

procedure Tfrm8SrcReplacer.actSaveReplaceTextExecute(Sender: TObject);
begin
  if not SaveDialog1.Execute then Exit;
  dm8SrcReplacer.SaveReplaceStrings(SaveDialog1.FileName);
end;

procedure Tfrm8SrcReplacer.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure Tfrm8SrcReplacer.actOpenFilesExecute(Sender: TObject);
begin
  if not OpenDialog2.Execute then Exit;
  dm8SrcReplacer.LoadFileNames(OpenDialog2.Files);
  RefreshFileNames;
end;

procedure Tfrm8SrcReplacer.actFindBeforeReplaceExecute(Sender: TObject);
begin
  SetEnabledOfActions(False);
  dm8SrcReplacer.OnThreadTerminated := DMThreadTerminated;
  dm8SrcReplacer.ThreadEvent := c0SXProgressDlg1.DoProceed;
  c0SXProgressDlg1.ShowDlg;
  dm8SrcReplacer.FindBeforeReplace;
end;

procedure Tfrm8SrcReplacer.RefreshFileNames;
var
  i: Integer;
  idx: Integer;
  f: T8FileColFile;
begin
  CheckListBox1.Items.Clear;
  for i := 0 to dm8SrcReplacer.Targets.Files.Count -1 do
  begin
    if not(dm8SrcReplacer.Targets.Files[i] is T8FileColFile) then Exit;
    f := T8FileColFile(dm8SrcReplacer.Targets.Files[i]);
    idx := CheckListBox1.Items.Add(f.Identifier);
    CheckListBox1.Checked[idx] := f.Enabled;
  end;
end;

procedure Tfrm8SrcReplacer.CheckListBox1ClickCheck(Sender: TObject);
begin
  if CheckListBox1.ItemIndex < 0 then Exit;
  dm8SrcReplacer.ChangeEnabled(
    CheckListBox1.Items.Strings[CheckListBox1.ItemIndex]
  );
end;

procedure Tfrm8SrcReplacer.ParentFileLoad(Sender: TObject;
  Accessor: Ts0RTTIPublishedAccessor; var Value: string);
var
  obj: TObject;
begin
  obj := Accessor.ObjectProp['ParentFile'];
  if not(obj is T8FileColFile) then Exit;
  Value := T8FileColFile(obj).FileName;
end;

procedure Tfrm8SrcReplacer.ParentFileSave(Sender: TObject;
  Accessor: Ts0RTTIPublishedAccessor; Value: string);
begin
end;

procedure Tfrm8SrcReplacer.actExecReplaceExecute(Sender: TObject);
begin
  SetEnabledOfActions(False);
  dm8SrcReplacer.OnThreadTerminated := DMThreadTerminated;
  dm8SrcReplacer.ThreadEvent := c0SXProgressDlg1.DoProceed;
  c0SXProgressDlg1.ShowDlg;
  dm8SrcReplacer.ExecReplace;
end;

procedure Tfrm8SrcReplacer.DMThreadTerminated(Sender: TObject);
begin
  c0SXProgressDlg1.DoTerminated(Sender);
  SetEnabledOfActions(True);
end;

procedure Tfrm8SrcReplacer.SetEnabledOfActions(Value: Boolean);
var
  i: Integer;
begin
  for i := 0 to ActionList1.ActionCount -1 do
    if ActionList1.Actions[i] is TCustomAction then
      TCustomAction(ActionList1.Actions[i]).Enabled := Value;
end;

procedure Tfrm8SrcReplacer.actReplaceFileNamesExecute(Sender: TObject);
begin
  SetEnabledOfActions(False);
  dm8SrcReplacer.OnThreadTerminated := DMThreadTerminated;
  dm8SrcReplacer.ThreadEvent := c0SXProgressDlg1.DoProceed;
  c0SXProgressDlg1.ShowDlg;
  dm8SrcReplacer.ReplaceFileNames;
end;

initialization

finalization


end.
