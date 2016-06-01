unit f8EntityBuilder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ActnList, Menus, ComCtrls, s0MenuBar, ToolWin, s0VCLClasses,
  s0ObjCtrlBuilder, s0UnifiedObjCtrl, s0ObjTreeMapper, s0CustomComplexCtrl,
  s0ObjTreeView, s0BoundsLayout, StdCtrls, s0Button, StdActns,
  s0ObjTreeMapAction, s0ObjTreeMapMenu, s0ComponentEventWrapper,
  s0FormEventPublisher, s0ObjPropStocker, s0IniPropStocker;

type
  Tfrm8EntityBuilder = class(TForm)
    CoolBar1: TCoolBar;
    s0MenuBar1: Ts0MenuBar;
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    s0ObjTreeView1: Ts0ObjTreeView;
    actClose: TAction;
    s0Button2: Ts0Button;
    s0Button3: Ts0Button;
    s0Button4: Ts0Button;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    ID1: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    N3: TMenuItem;
    Panel2: TPanel;
    s0Button5: Ts0Button;
    s0Button9: Ts0Button;
    s0Button10: Ts0Button;
    Panel4: TPanel;
    s0Button7: Ts0Button;
    s0Button8: Ts0Button;
    Panel3: TPanel;
    s0Button6: Ts0Button;
    N4: TMenuItem;
    SQLQ1: TMenuItem;
    C1: TMenuItem;
    S1: TMenuItem;
    N5: TMenuItem;
    I1: TMenuItem;
    T1: TMenuItem;
    s0Button11: Ts0Button;
    dspValidation: TMemo;
    Splitter1: TSplitter;
    s0Button1: Ts0Button;
    actRefresh: TAction;
    Show1: TMenuItem;
    SQLQ2: TMenuItem;
    s0LayoutSet1: Ts0LayoutSet;
    actSaveToFile: Ts0ObjTreeMapAction;
    actGenerateFiles: Ts0ObjTreeMapAction;
    actGenerateSQL: Ts0ObjTreeMapAction;
    actExportToTable: Ts0ObjTreeMapAction;
    actCreateTable: Ts0ObjTreeMapAction;
    actDeleteTable: Ts0ObjTreeMapAction;
    actSelectFromBDE: Ts0ObjTreeMapAction;
    actSaveIDConstUnit: Ts0ObjTreeMapAction;
    actAddProject: Ts0ObjTreeMapAction;
    actLoadProject: Ts0ObjTreeMapAction;
    actSaveProject: Ts0ObjTreeMapAction;
    actSaveToFiles: Ts0ObjTreeMapAction;
    actGenerateSQLs: Ts0ObjTreeMapAction;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0IniPropStocker1: Ts0IniPropStocker;
    N6: TMenuItem;
    actRemoveProject: Ts0ObjTreeMapAction;
    N7: TMenuItem;
    s0Button12: Ts0Button;
    procedure FormCreate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure s0ObjTreeView1BeforeMenuItemClick(Sender: TObject;
      AItem: TMenuItem; AObj: TObject; AMethodName: String;
      var AKind: K0MapMenuItemKind; var AutoExecute: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionList1Execute(Action: TBasicAction;
      var Handled: Boolean);
  private
    procedure ValidationMsgChange(Sender: TObject);
  public
    procedure BuilderBeforeBuild(Sender: TObject);
    procedure BuilderAfterBuild(Sender: TObject);
    procedure BuilderInitCtrl(Sender: TObject; AProp: Ts0ProtoTypeCtrl; AControl: TControl);
  end;

var
  frm8EntityBuilder: Tfrm8EntityBuilder;

implementation

uses
  s0Memo,
  s0ObjectHelper,
  s0ValidationMsg,
  u8MetaEntities,
  d8EntityBuilder,
  s8EntityFile,
  s8EntitySQL,
  s0DBEntity,
  f0SelectTables;

{$R *.DFM}

type
  Ts8EntityFilesGUI = class(Ts8EntityFiles)
  public
    function ConfirmSaveFile(AFileName: string): Boolean; override;
    class procedure ClearFlags;
  end;

{ Ts8EntityFilesGUI }

var
  g9Flags: Integer;

class procedure Ts8EntityFilesGUI.ClearFlags;
begin
  g9Flags := mrNone;
end;

function Ts8EntityFilesGUI.ConfirmSaveFile(AFileName: string): Boolean;
var
  userAns: Integer;
begin
  Result := False;
  if g9Flags = mrCancel then Exit;
  Result := inherited ConfirmSaveFile(AFileName);
  if Result then Exit;
  case g9Flags of
    mrYesToAll: Result := True;
    mrNoToAll : Result := False;
  end;
  if g9Flags in [mrYesToAll, mrNoToAll] then Exit;
  userAns :=
    MessageDlg(
      Format('ファイル"%s"は既に存在します。上書きしますか？', [AFileName]),
      mtConfirmation, [mbYes, mbNo, mbCancel, mbNoToAll, mbYesToAll], 0
    );                 
  case userAns of
    mrCancel  : Abort;
    mrYes     : Result := True ;
    mrNo      : Result := False;
    mrYesToAll: Result := True ;
    mrNoToAll : Result := False;
  end;
  if userAns in [mrYesToAll, mrNoToAll] then
    g9Flags := userAns;
end;

type
  Tc8MetaEntityManGUI = class(Ts8XMLMetaEntityMan)
  public
    function ConfirmBeforeRemove: Integer;
  published
    procedure RemoveProject; override;
    procedure SelectFromBDE; override;
  end;

{ Tc8MetaEntityManGUI }

function Tc8MetaEntityManGUI.ConfirmBeforeRemove: Integer;
begin
  Result := mrNo;
  if not Modified then Exit;
  Result :=
    MessageDlg(
      Format('"%s"は変更されています。保存しますか？', [FileName]),
      mtConfirmation, [mbYes, mbNo, mbCancel], 0
    );
end;

procedure Tc8MetaEntityManGUI.RemoveProject;
begin
  case ConfirmBeforeRemove of
    mrCancel: Exit;
    mrYes   : SaveProject;
  end;
  inherited;
end;

procedure Tc8MetaEntityManGUI.SelectFromBDE;
var
  frm: Tfrm0SelectTables;
  i: Integer;
begin
  frm := Tfrm0SelectTables.Create(nil);
  try
    frm.Session := Self.BDEConnection.DataBase.Session;
    frm.DataBase := Self.BDEConnection.DataBase;
    frm.BDEAliasName := Self.BDEConnection.AliasName;
    frm.ShowModal;
    Self.BDEConnection.AliasName := frm.BDEAliasName;
    for i := 0 to frm.Dest.Count -1 do
      Self.Entities.AddTable(frm.Dest.Strings[i]);
  finally
    FreeAndNil(frm);
  end;
end;

{ Tfrm8EntityBuilder }

procedure Tfrm8EntityBuilder.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  dm8EntityBuilder.MetaEntityManClass := Tc8MetaEntityManGUI;
  //
  s0ObjTreeView1.ObjCtrlBride.BeforeBuild := BuilderBeforeBuild;
  s0ObjTreeView1.ObjCtrlBride.AfterBuild := BuilderAfterBuild;
  s0ObjTreeView1.ObjCtrlBride.OnInitCtrl := BuilderInitCtrl;
  Ts0GlobalValidationManager.Instance.OnChange := ValidationMsgChange;
  //
  s0ObjTreeView1.Target := dm8EntityBuilder;
  s0ObjTreeView1.Refresh;
  //
  actSaveProject.EnabledCtrlPropName := 'Modified';
  for i := 0 to ActionList1.ActionCount -1 do
    if ActionList1.Actions[i] is Ts0ObjTreeMapAction then
      Ts0ObjTreeMapAction(ActionList1.Actions[i]).Mapper := s0ObjTreeView1.TreeMapper;
end;

procedure Tfrm8EntityBuilder.actRefreshExecute(Sender: TObject);
begin
  s0ObjTreeView1.Refresh;
end;

procedure Tfrm8EntityBuilder.actCloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure Tfrm8EntityBuilder.FormActivate(Sender: TObject);
begin
  s0ObjTreeView1.Selected := dm8EntityBuilder.Projects;
end;

procedure Tfrm8EntityBuilder.ValidationMsgChange(Sender: TObject);
begin
  Ts0GlobalValidationManager.Instance.CopyMessages(dspValidation.Lines);
end;

procedure Tfrm8EntityBuilder.s0ObjTreeView1BeforeMenuItemClick(
  Sender: TObject; AItem: TMenuItem; AObj: TObject; AMethodName: String;
  var AKind: K0MapMenuItemKind; var AutoExecute: Boolean);
begin
  Ts0GlobalValidationManager.Instance.ClearMsg;
  Ts8EntityFilesGUI.ClearFlags;
end;

procedure Tfrm8EntityBuilder.ActionList1Execute(Action: TBasicAction;
  var Handled: Boolean);
begin
  Ts0GlobalValidationManager.Instance.ClearMsg;
  Ts8EntityFilesGUI.ClearFlags;
end;

const
  c9SQLSheetPropNames: array[K0EntityDataSetType] of string = (
    'sh_detail', 'sh_list', 'sh_insert', 'sh_update', 'sh_delete'
  );

  c9SQLPropNames: array[K0EntityDataSetType] of string = (
    'Select', 'SelectList', 'Insert', 'Update', 'Delete'
  );                                                    

procedure Tfrm8EntityBuilder.BuilderBeforeBuild(Sender: TObject);
  procedure SetInvisibleProps(ABridge: Ts0ObjCtrlBridge);
  var
    i: Integer;
  begin
    for i := 0 to ABridge.ProtoTypes.Count -1 do
    begin
      if Ts0ObjectHelper.ClassInherites(TCollection, ABridge.ProtoTypes.Items[i].TypeName) then
        ABridge.ProtoTypes.Items[i].WithoutCtrl := True;
    end;
    ABridge.StandInCtrls;
  end;
var
  b: Ts0ObjCtrlBridge;
  ptc: Ts0ProtoTypeCtrl;
  i: K0EntityDataSetType;
begin
  if not(Sender is Ts0ObjCtrlBridge) then Exit;
  b := Ts0ObjCtrlBridge(Sender);
  SetInvisibleProps(b);
  //
  if b.Target is Ts8EntitySQLs then
  begin
    ptc := Ts0ProtoTypeCtrl(b.ProtoTypes.AddProto('_tabs', '', '', 0));
    ptc.CtrlClassName := TPageControl.ClassName;
    for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    begin
      ptc := Ts0ProtoTypeCtrl(b.ProtoTypes.AddProto(c9SQLSheetPropNames[i], '', '', 0));
      ptc.CtrlClassName := TTabSheet.ClassName;
    end;
  end
  else
  if b.Target is Ts8EntityFile then
  begin
    ptc := Ts0ProtoTypeCtrl(b.ProtoTypes.AddProto('_header', '', '', 0));
    ptc.CtrlClassName := TPanel.ClassName;
    ptc := Ts0ProtoTypeCtrl(b.ProtoTypes.AddProto('_tabs', '', '', 0));
    ptc.CtrlClassName := TPageControl.ClassName;
    ptc := Ts0ProtoTypeCtrl(b.ProtoTypes.AddProto('_pas', '', '', 0));
    ptc.CtrlClassName := TTabSheet.ClassName;
    ptc := Ts0ProtoTypeCtrl(b.ProtoTypes.AddProto('_dfm', '', '', 0));
    ptc.CtrlClassName := TTabSheet.ClassName;
  end;
end;

procedure Tfrm8EntityBuilder.BuilderAfterBuild(Sender: TObject);
var
  b: Ts0ObjCtrlBridge;
  pnl: TPanel;
  pc: TPageControl;
  sht: TTabSheet;
  i: K0EntityDataSetType;
  ptc: Ts0ProtoTypeCtrl;
begin
  if not(Sender is Ts0ObjCtrlBridge) then Exit;
  b := Ts0ObjCtrlBridge(Sender);
  if b.Target is Ts8EntitySQLs then
  begin
    pc := TPageControl( b.ProtoTypes.FindPropCtrls('_tabs').Ctrl );
    pc.Align := alClient;
    for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    begin
      sht := TTabSheet(b.ProtoTypes.FindPropCtrls(c9SQLSheetPropNames[i]).Ctrl);
      sht.PageControl := pc;
      sht.Caption := c9SQLPropNames[i];
      ptc := b.ProtoTypes.FindPropCtrls(c9SQLPropNames[i]);
      if ptc.Ctrl = nil then Continue;
      ptc.Ctrl.Parent := sht;
      ptc.Ctrl.Align := alClient;
    end;
  end
  else
  if b.Target is Ts8EntityFile then
  begin
    pnl := TPanel( b.ProtoTypes.FindPropCtrls('_header').Ctrl );
    pnl.Align := alTop;
    pnl.Height := 50;
    pnl.Caption := '';
    ptc := b.ProtoTypes.FindPropCtrls('UnitName');
    ptc.Ctrl.Parent := pnl;
    ptc.CtrlLabel.Parent := pnl;
    ptc := b.ProtoTypes.FindPropCtrls('UnitClass');
    ptc.Ctrl.Parent := pnl;
    ptc.CtrlLabel.Parent := pnl;
    //
    pc := TPageControl( b.ProtoTypes.FindPropCtrls('_tabs').Ctrl );
    pc.Align := alClient;
    sht := TTabSheet(b.ProtoTypes.FindPropCtrls('_pas').Ctrl);
    sht.PageControl := pc;
    sht.Caption := Ts8EntityFile(b.Target).UnitName + '.pas';
    ptc := b.ProtoTypes.FindPropCtrls('PasLines');
    ptc.Ctrl.Parent := sht;
    ptc.Ctrl.Align := alClient;
    sht := TTabSheet(b.ProtoTypes.FindPropCtrls('_dfm').Ctrl);
    sht.PageControl := pc;
    sht.Caption := Ts8EntityFile(b.Target).UnitName + '.dfm';
    sht.TabVisible := Ts8EntityFile(b.Target).Kind <> k8efkEntityUnit;
    ptc := b.ProtoTypes.FindPropCtrls('DfmLines');
    ptc.Ctrl.Parent := sht;
    ptc.Ctrl.Align := alClient;
  end;
end;

procedure Tfrm8EntityBuilder.BuilderInitCtrl(Sender: TObject;
  AProp: Ts0ProtoTypeCtrl; AControl: TControl);
begin
  if AControl is Ts0Memo then
    Ts0Memo(AControl).ScrollBars := ssBoth;
end;

procedure Tfrm8EntityBuilder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  i: Integer;
  proj: Ts8XMLMetaEntityMan;
begin
  for i := 0 to dm8EntityBuilder.Projects.Count -1 do
  begin
    proj := dm8EntityBuilder.Projects[i];
    case (proj as Tc8MetaEntityManGUI).ConfirmBeforeRemove of
      mrCancel:
        begin
          CanClose := False;
          Exit;
        end;
      mrYes   : proj.SaveProject;
    end;
  end;
end;

initialization
  T8MetaEntity.SetFilesClass(Ts8EntityFilesGUI);
  RegisterClass(TPanel);
  RegisterClass(TPageControl);
  RegisterClass(TTabSheet);
  RegisterClass(Tc8MetaEntityManGUI);

finalization
  UnRegisterClass(TPanel);
  UnRegisterClass(TPageControl);
  UnRegisterClass(TTabSheet);
  UnRegisterClass(Tc8MetaEntityManGUI);

end.
