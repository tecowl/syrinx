unit s0f2EntityHybrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0f1EntityDBGridList, ActnList, Db, s0f0EntityDisplay, s0EntityListImpl,
  s0FormEventPublisher, s0FormRelation, ComCtrls, Grids, DBGrids, ExtCtrls,
  s0EntityDetailImpl,
  s0VCLClasses, s0ComponentEventWrapper,
  s0EntityDispImpl;

type
  Ts0frmEntityHybrid = class(Ts0frmEntityDBGridList)
    impDetail: Ts0EntityDetailImpl;
    Splitter1: TSplitter;
    pnlDetail: TPanel;
    actSaveEntity: TAction;
    actReadOnly: TAction;
    procedure impListDecide(Sender: TObject);
    procedure impListMoveSelected(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSaveEntityExecute(Sender: TObject);
    procedure actShowNaviListExecute(Sender: TObject);
    procedure actNewEntityExecute(Sender: TObject);
  private
  public
    procedure ShowNaviList;
  end;

var
  s0frmEntityHybrid: Ts0frmEntityHybrid;

implementation

{$R *.DFM}

{ Ts0frmEntityHybrid }

procedure Ts0frmEntityHybrid.impListDecide(Sender: TObject);
begin
  inherited;
  impDetail.LoadFromTarget;
end;

procedure Ts0frmEntityHybrid.impListMoveSelected(Sender: TObject);
begin
  inherited;
  impDetail.LoadFromTarget;
end;

procedure Ts0frmEntityHybrid.FormCreate(Sender: TObject);
begin
  inherited;
  //OnCreateÇæÇ∆å„Ç≈èëÇ´ä∑Ç¶ÇÁÇÍÇƒÇµÇ‹Ç§ÅB
  //impDetail.DispTarget := impList.Selected;
end;

procedure Ts0frmEntityHybrid.FormShow(Sender: TObject);
begin
  inherited;
  impDetail.DispTarget := impList.Selected;
  impDetail.LoadFromTarget;
end;

procedure Ts0frmEntityHybrid.actSaveEntityExecute(Sender: TObject);
begin
  inherited;
  impDetail.SaveToTarget;
  actRefresh.Execute;
end;

procedure Ts0frmEntityHybrid.actShowNaviListExecute(Sender: TObject);
begin
  inherited;
  ShowNaviList;
end;

procedure Ts0frmEntityHybrid.ShowNaviList;
begin
end;

procedure Ts0frmEntityHybrid.actNewEntityExecute(Sender: TObject);
begin
  //inherited actNewEntityExecute(Sender);
  if impList.Selected = nil then Exit;
  impList.Selected.ID := 0;
  impDetail.ClearCtrls;
end;

end.
