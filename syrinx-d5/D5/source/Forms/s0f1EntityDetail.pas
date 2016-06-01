unit s0f1EntityDetail;
{
$History: s0f1EntityDetail.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/14   Time: 4:45
 * Updated in $/D5/source/Forms
 * ShowNaviListを削除。s0fEntityNaviListに非依存になった
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/13   Time: 3:12
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/01/10   Time: 16:53
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/10/23   Time: 15:51
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/10/17   Time: 23:40
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/17   Time: 12:26
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/17   Time: 10:23
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/11   Time: 17:26
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/11   Time: 1:20
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/05   Time: 16:48
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/02   Time: 3:19
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/21   Time: 18:32
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/03   Time: 5:07
 * Updated in $/source/D5Integrated/Forms
 * ユニット名変更完了
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/30   Time: 12:52
 * Updated in $/source/D5/p0entity
 * Entity関係の作成を一時中断。
 * パッケージの再構築時にエラーが出ることが多いので、そっちを先に対応予定
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/29   Time: 18:42
 * Updated in $/source/D5/p0entity
 * 汎用フォームが実現できそう。一時チェックイン。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0entity
 * p0entityひとまずOK。
 * しかし、汎用的なフォームのためにリファクタリングを思案中・・・
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/27   Time: 20:03
 * Created in $/source/D5/p0entity
 * 新規作成
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Observer,
  s0Entity,
  s0f0EntityDisplay, s0EntityDetailImpl, s0FormEventPublisher, s0FormRelation,
  ActnList, ComCtrls, s0VCLClasses,
  s0ComponentEventWrapper, s0EntityDispImpl;
  
type
  Ts0frmEntityDetailClass = class of Ts0frmEntityDetail;
  Ts0frmEntityDetail = class(Ts0frmEntityDisplay)
    impDetail: Ts0EntityDetailImpl;
    ActionList1: TActionList;
    actRefresh: TAction;
    actNewEntity: TAction;
    actSaveEntity: TAction;
    actRemoveEntity: TAction;
    actClose: TAction;
    actReadOnly: TAction;
    StatusBar1: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actReadOnlyExecute(Sender: TObject);
    procedure actNewEntityExecute(Sender: TObject);
    procedure actSaveEntityExecute(Sender: TObject);
    procedure actRemoveEntityExecute(Sender: TObject);
    procedure actReadOnlyUpdate(Sender: TObject);
    procedure actNewEntityUpdate(Sender: TObject);
    procedure actSaveEntityUpdate(Sender: TObject);
    procedure actRemoveEntityUpdate(Sender: TObject);
    procedure impDetailChangeTargetID(Sender: TObject);
    procedure impDetailChangeEditingMode(Sender: TObject);
  private
    FCloseDetailOrigin: Boolean;
    function GetDetailTarget: Ts0Entity;
    procedure SetDetailTarget(const Value: Ts0Entity);
    function GetIsReadOnly: Boolean;
  protected
    procedure PrepareModalEditForm(AForm: Ts0frmEntityDetail); virtual;
    procedure ShowModalEditForm(AMode: K0DetailDisplayMode);
    procedure ResetFormCaption;
    procedure ShowNaviList;
    property IsReadOnly: Boolean read GetIsReadOnly;
  public
    property DetailTarget: Ts0Entity read GetDetailTarget write SetDetailTarget;
    class function GetEnableMode: K0DisplayType; override;
  end;

var
  s0frmEntityDetail: Ts0frmEntityDetail;

implementation

{$R *.DFM}

uses
  s0User, s0UserImpl;

{ Ts0frmEntityDisplay1 }

function Ts0frmEntityDetail.GetDetailTarget: Ts0Entity;
begin
  Result := impDetail.DispTarget;
end;

class function Ts0frmEntityDetail.GetEnableMode: K0DisplayType;
begin
  Result := k0dtDetail;
end;

procedure Ts0frmEntityDetail.SetDetailTarget(const Value: Ts0Entity);
begin
  impDetail.DispTarget := Value;
end;

procedure Ts0frmEntityDetail.FormShow(Sender: TObject);
begin
  inherited;
  impDetail.LoadFromTarget;
  ResetFormCaption;
  if Ts0GUIUserManager.Instance = nil then Exit;
  if Ts0GUIUserManager.Instance.LoginUser = nil then Exit;
  StatusBar1.Panels[0].Text := Ts0GUIUserManager.Instance.LoginUser.UserName;
  Application.ProcessMessages;
end;

procedure Ts0frmEntityDetail.ShowNaviList;
begin
end;

procedure Ts0frmEntityDetail.actRefreshExecute(Sender: TObject);
begin
  inherited;
  if DetailTarget <> nil then
    DetailTarget.Load;
  impDetail.LoadFromTarget;
  ResetFormCaption;
end;

procedure Ts0frmEntityDetail.ResetFormCaption;
begin
  if impDetail.DispTarget = nil then Exit;
  Self.Caption :=
    Format('[%s] %s ', [
      impDetail.DispTarget.GetClassCaption,
      impDetail.DispTarget.Caption
    ]);
end;

procedure Ts0frmEntityDetail.actCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Ts0frmEntityDetail.actReadOnlyExecute(Sender: TObject);
begin
  inherited;
  case Self.impDetail.EditingMode of
    k0ddmReadOnly : ShowModalEditForm(k0ddmEdit);
    k0ddmEdit,
    k0ddmNewEntity:
    begin
      if s0FormRelation1.Origin = nil then Exit;
      if s0FormRelation1.Origin.ClassType <> Self.ClassType then Exit;
      if not(s0FormRelation1.Origin is Ts0frmEntityDetail) then Exit;
      if Ts0frmEntityDetail(s0FormRelation1.Origin).impDetail.EditingMode <> k0ddmReadOnly then Exit;
      Self.FCloseDetailOrigin := False;
      Close;
    end;
  end;
end;

procedure Ts0frmEntityDetail.actNewEntityExecute(Sender: TObject);
begin
  inherited;
  ShowModalEditForm(k0ddmNewEntity);
end;

procedure Ts0frmEntityDetail.actSaveEntityExecute(Sender: TObject);
begin
  if impDetail.DispTarget = nil then Exit;
  impDetail.SaveToTarget;
end;

procedure Ts0frmEntityDetail.actRemoveEntityExecute(Sender: TObject);
begin
  impDetail.RemoveTarget;
end;

procedure Ts0frmEntityDetail.ShowModalEditForm(AMode: K0DetailDisplayMode);
var
  frm: Ts0frmEntityDetail;
begin
  if AMode = k0ddmReadOnly then Exit;
  frm := Ts0frmEntityDetailClass(Self.ClassType).Create(nil);
  try
    frm.impDetail.EditingMode := AMode;
    PrepareModalEditForm(frm);
    if AMode = k0ddmNewEntity then
    begin
      frm.impDetail.DispTarget.Clear;
      frm.impDetail.DispTarget.ID := -1;
    end;
    frm.ShowModal;
    if frm.FCloseDetailOrigin then
      Close;
  finally
    FreeAndNil(frm);
  end;
end;

procedure Ts0frmEntityDetail.actReadOnlyUpdate(Sender: TObject);
begin
  inherited;
  actReadOnly.Checked := Self.IsReadOnly;
end;

procedure Ts0frmEntityDetail.PrepareModalEditForm(AForm: Ts0frmEntityDetail);
begin
  AForm.FCloseDetailOrigin := True;
  AForm.s0FormRelation1.Origin := Self;
  AForm.impDetail.DispTarget := Self.impDetail.DispTarget;
  AForm.SetBounds(Self.Left, Self.Top, Self.Width, Self.Height);
end;

procedure Ts0frmEntityDetail.actNewEntityUpdate(Sender: TObject);
begin
  inherited;
  actNewEntity.Enabled := Self.IsReadOnly;
end;

procedure Ts0frmEntityDetail.actSaveEntityUpdate(Sender: TObject);
begin
  inherited;
  actSaveEntity.Enabled := not Self.IsReadOnly;
end;

procedure Ts0frmEntityDetail.actRemoveEntityUpdate(Sender: TObject);
begin
  inherited;
  actRemoveEntity.Enabled := not Self.IsReadOnly;
end;

function Ts0frmEntityDetail.GetIsReadOnly: Boolean;
begin
  Result := (impDetail.EditingMode = k0ddmReadOnly);
end;

procedure Ts0frmEntityDetail.impDetailChangeTargetID(Sender: TObject);
begin
  if not Self.Visible then Exit;
  DetailTarget.Load;
  impDetail.LoadFromTarget;
  ResetFormCaption;
end;

procedure Ts0frmEntityDetail.impDetailChangeEditingMode(Sender: TObject);
begin
  inherited;
  StatusBar1.Panels[1].Text := Ts0EntityDisplay.DispModeToStr( impDetail.EditingMode );
end;

end.
