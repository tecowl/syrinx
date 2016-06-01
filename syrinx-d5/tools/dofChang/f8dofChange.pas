unit f8dofChange;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0VCLClasses, s0ObjCtrlBuilder, s0Edit, s0UnifiedObjCtrl, 
  s0FileFinder, ExtCtrls, s0Label, CheckLst, s0ObjPropStocker,
  s0IniPropStocker, s0TreeViewController, ActnList,
  s0DofChange,
  Menus, ComCtrls, s0ObjTreeMapper;

type
  TForm1 = class(TForm)
    s0IniPropStocker1: Ts0IniPropStocker;
    ActionList1: TActionList;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    actOpenProj: TAction;
    actSaveProj: TAction;
    actExit: TAction;
    actAddDof: TAction;
    actRemoveDof: TAction;
    actCreateAction: TAction;
    actDeleteAction: TAction;
    actExecute: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    AddDof1: TMenuItem;
    RemoveDof1: TMenuItem;
    N2: TMenuItem;
    CreateAction1: TMenuItem;
    DeleteAction1: TMenuItem;
    Run1: TMenuItem;
    Execute1: TMenuItem;
    actRemoveProj: TAction;
    RemoveProj1: TMenuItem;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    ScrollBox1: TScrollBox;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    actNewProj: TAction;
    NewProject1: TMenuItem;
    s0ObjTreeMapMenu1: Ts0ObjTreeMapMenu;
    s0ObjTreeMapper1: Ts0ObjTreeMapper;
    procedure actNewProjExecute(Sender: TObject);
    procedure actOpenProjExecute(Sender: TObject);
    procedure actSaveProjExecute(Sender: TObject);
    procedure actRemoveProjExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure s0ObjTreeMapMenu1NeedRefresh(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.actNewProjExecute(Sender: TObject);
begin
  if not SaveDialog1.Execute then Exit;
  Ts0DofChangerMain.Instance.Projects.Add(SaveDialog1.FileName, False);
  s0ObjTreeMapper1.Refresh;
end;

procedure TForm1.actOpenProjExecute(Sender: TObject);
begin
  if not OpenDialog1.Execute then Exit;
  Ts0DofChangerMain.Instance.Projects.Add(OpenDialog1.FileName, True);
  s0ObjTreeMapper1.Refresh;
end;

procedure TForm1.actSaveProjExecute(Sender: TObject);
begin
  Ts0DofChangerMain.Instance.SaveProjects;
end;

procedure TForm1.actRemoveProjExecute(Sender: TObject);
begin
//
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  s0ObjTreeMapper1.Target := Ts0DofChangerMain.Instance;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  s0ObjTreeMapper1.Target := nil;
end;

procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  s0UnifiedObjCtrl1.ClearCtrls;
  s0UnifiedObjCtrl1.Target := nil;
  s0UnifiedObjCtrl1.ProtoTypes.Clear;
  if Node = nil then Exit;
  if Node.Data = nil then Exit;
  s0UnifiedObjCtrl1.Target := TObject(Node.Data);
  s0UnifiedObjCtrl1.BuildCtrls;
  s0UnifiedObjCtrl1.LoadFromTarget;
end;

procedure TForm1.s0ObjTreeMapMenu1NeedRefresh(Sender: TObject);
begin
  s0ObjTreeMapper1.Refresh;
end;

end.

