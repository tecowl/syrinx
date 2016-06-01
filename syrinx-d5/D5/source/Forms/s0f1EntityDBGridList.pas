unit s0f1EntityDBGridList;
{
$History: s0f1EntityDBGridList.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/14   Time: 4:33
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/13   Time: 3:12
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/10   Time: 16:53
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/11   Time: 17:26
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/11   Time: 1:20
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/05   Time: 18:10
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/02   Time: 3:19
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/21   Time: 18:32
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/03   Time: 5:07
 * Updated in $/source/D5Integrated/Forms
 * ユニット名変更完了
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0f0EntityDisplay, s0FormEventPublisher, s0FormRelation, s0EntityListImpl,
  Grids, DBGrids, ActnList, Db, ComCtrls, s0VCLClasses,
  s0ComponentEventWrapper, s0EntityDispImpl;

type
  Ts0frmEntityDBGridList = class(Ts0frmEntityDisplay)
    impList: Ts0EntityListImpl;
    DataSource1: TDataSource;
    ActionList1: TActionList;
    actRefresh: TAction;
    grdEntities: TDBGrid;
    actNewEntity: TAction;
    actRemoveEntity: TAction;
    actClose: TAction;
    StatusBar1: TStatusBar;
    actEditEntity: TAction;
    actShowDetail: TAction;
    procedure grdEntitiesDblClick(Sender: TObject);
    procedure grdEntitiesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure actRefreshExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure impListBeforeRefreshList(Sender: TObject);
    procedure actNewEntityExecute(Sender: TObject);
    procedure actRemoveEntityExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actEditEntityExecute(Sender: TObject);
    procedure actShowDetailExecute(Sender: TObject);
  private
  protected
  public
    class function GetEnableMode: K0DisplayType; override;
  end;

var
  s0frmEntityDBGridList: Ts0frmEntityDBGridList;

implementation

{$R *.DFM}

uses
  s0User, s0UserImpl,
  s0Entity,
  s0DBEntity;

{ Ts0frmEntityDisplay1 }

class function Ts0frmEntityDBGridList.GetEnableMode: K0DisplayType;
begin
  Result := k0dtList;
end;

procedure Ts0frmEntityDBGridList.grdEntitiesDblClick(Sender: TObject);
begin
  inherited;
  impList.Decide;
end;

procedure Ts0frmEntityDBGridList.grdEntitiesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    impList.Decide;
end;

procedure Ts0frmEntityDBGridList.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  impList.MoveSelected;
end;

procedure Ts0frmEntityDBGridList.actRefreshExecute(Sender: TObject);
begin
  inherited;
  impList.RefreshList;
end;

procedure Ts0frmEntityDBGridList.FormShow(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
  if impList.DispEntityClass = nil then Exit;
  Self.Caption := '[一覧] ' + impList.DispEntityClass.GetClassCaption;
  if Ts0GUIUserManager.Instance = nil then Exit;
  if Ts0GUIUserManager.Instance.LoginUser = nil then Exit;
  StatusBar1.Panels[0].Text := Ts0GUIUserManager.Instance.LoginUser.UserName;
end;

procedure Ts0frmEntityDBGridList.impListBeforeRefreshList(Sender: TObject);
begin
  inherited;
  if not(impList.Manager is Ts0DBEntityManager) then Exit;
  if DataSource1.DataSet = Ts0DBEntityManager(impList.Manager).DSList then Exit;
  DataSource1.DataSet := Ts0DBEntityManager(impList.Manager).DSList;
end;

procedure Ts0frmEntityDBGridList.actNewEntityExecute(Sender: TObject);
begin
  inherited;
  impList.ShowSelectedDetail(k0ddmNewEntity, True);
end;

procedure Ts0frmEntityDBGridList.actRemoveEntityExecute(Sender: TObject);
begin
  inherited;
  if impList.Selected = nil then Exit;
  impList.Selected.Remove;
  actRefresh.Execute;
end;

procedure Ts0frmEntityDBGridList.actCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Ts0frmEntityDBGridList.actEditEntityExecute(Sender: TObject);
begin
  inherited;
  impList.ShowSelectedDetail(k0ddmEdit, True);
end;

procedure Ts0frmEntityDBGridList.actShowDetailExecute(Sender: TObject);
begin
  inherited;
  impList.Decide;
end;

end.


















