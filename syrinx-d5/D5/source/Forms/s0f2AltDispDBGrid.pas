unit s0f2AltDispDBGrid;
{
$History: s0f2AltDispDBGrid.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/14   Time: 4:33
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/21   Time: 22:46
 * Updated in $/source/D6VCLIntegrated/Forms
 * 各Entity用のDMには、Ts0EntityFormManagerを置かないように変更。
 * Ts0EntityFormManagerはコンポーネントとして廃止したことに対応。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/17   Time: 23:40
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/11   Time: 17:26
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
 * User: Akima        Date: 01/10/01   Time: 17:38
 * Updated in $/source/D5Integrated/Forms
 * TreeViewでＦｉｌｔｅｒを記述できるようにしている最中だけどチェックイン
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
  s0f1EntityDBGridList, ActnList, Db, s0f0EntityDisplay, s0EntityListImpl,
  s0FormEventPublisher, s0FormRelation, Grids, DBGrids,
  s0Entity, ExtCtrls, ComCtrls, StdCtrls, s0TreeViewController,
  s0TreeFilterMaker, s0DSFilterMaker, Menus, s0VCLClasses,
  s0ComponentEventWrapper, s0EntityDispImpl;

type
  Ts0frmAltDispDBGrid = class(Ts0frmEntityDBGridList)
    pnlFilters: TPanel;
    Splitter1: TSplitter;
    dspFilters: TMemo;
    TreeView1: TTreeView;
    Splitter2: TSplitter;
    s0TreeViewController1: Ts0TreeViewController;
    c0DSFilter1: Ts0DSFilter;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Show1: TMenuItem;
    New1: TMenuItem;
    Delete1: TMenuItem;
    Refresh1: TMenuItem;
    N1: TMenuItem;
    Close1: TMenuItem;
    procedure impListBeforeRefreshList(Sender: TObject);
    procedure s0TreeViewController1RefreshView(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
  private
    FTargetClass: Ts0EntityClass;
    FDispOptions: K0DetailDisplayModeSet;
    FAllowRemove: Boolean;
    procedure SetDispOptions(const Value: K0DetailDisplayModeSet);
    procedure SetAllowRemove(const Value: Boolean);
  protected
    function GetTargetClass: Ts0EntityClass; override;
    procedure SetTargetClass(Value: Ts0EntityClass); override;
  public
    class function GetTargetClassBeforeCreate: Ts0EntityClass; override;
    class function IsAlternative: Boolean; override;
    class procedure SetTestMode(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property AllowRemove: Boolean read FAllowRemove write SetAllowRemove default True;
    property DetailDispOptions: K0DetailDisplayModeSet read FDispOptions write
      SetDispOptions default [k0ddmReadOnly, k0ddmEdit, k0ddmNewEntity];
  end;

var
  frm0AltDispDBGrid: Ts0frmAltDispDBGrid;

implementation

{$R *.DFM}

uses
  s0EntityFormManager,
  s0DBEntity;

{ Ts0frmEntityDBGridList1 }

function Ts0frmAltDispDBGrid.GetTargetClass: Ts0EntityClass;
begin
  Result := FTargetClass;
end;

class function Ts0frmAltDispDBGrid.GetTargetClassBeforeCreate: Ts0EntityClass;
begin
  Result := nil;
end;

class function Ts0frmAltDispDBGrid.IsAlternative: Boolean;
begin
  Result := True;
end;

procedure Ts0frmAltDispDBGrid.SetTargetClass(Value: Ts0EntityClass);
begin
  FTargetClass := Value;
end;

procedure Ts0frmAltDispDBGrid.impListBeforeRefreshList(Sender: TObject);
begin
  inherited;
  c0DSFilter1.Target := DataSource1.DataSet;
  s0TreeViewController1.Model := c0DSFilter1.Items;
end;

procedure Ts0frmAltDispDBGrid.s0TreeViewController1RefreshView(
  Sender: TObject);
begin
  inherited;
  c0DSFilter1.UpdateDSFilter;
end;

var
  g9TestMode: Boolean = False;

class procedure Ts0frmAltDispDBGrid.SetTestMode(Value: Boolean);
begin
  g9TestMode := Value;
end;

procedure Ts0frmAltDispDBGrid.FormShow(Sender: TObject);
begin
  inherited;
  pnlFilters.Visible :=  g9TestMode;
  actNewEntity.Enabled :=  k0ddmNewEntity in FDispOptions;
  actRemoveEntity.Enabled :=  FAllowRemove;
  actEditEntity.Enabled :=  k0ddmEdit in FDispOptions;
  actShowDetail.Enabled :=  k0ddmReadOnly in FDispOptions;
end;

procedure Ts0frmAltDispDBGrid.actCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Ts0frmAltDispDBGrid.SetDispOptions(
  const Value: K0DetailDisplayModeSet);
begin
  FDispOptions := Value;
end;

procedure Ts0frmAltDispDBGrid.SetAllowRemove(const Value: Boolean);
begin
  FAllowRemove := Value;
end;

constructor Ts0frmAltDispDBGrid.Create(AOwner: TComponent);
begin
  inherited;
  FAllowRemove := True;
  FDispOptions := [k0ddmReadOnly, k0ddmEdit, k0ddmNewEntity]; 
end;

initialization
  RegisterDispClass(Ts0frmAltDispDBGrid);

finalization
  UnRegisterDispClass(Ts0frmAltDispDBGrid);

end.
