unit s0f2AltEntityDetail;
{
$History: s0f2AltEntityDetail.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/25   Time: 15:55
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/14   Time: 4:33
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/01/21   Time: 22:46
 * Updated in $/source/D6VCLIntegrated/Forms
 * 各Entity用のDMには、Ts0EntityFormManagerを置かないように変更。
 * Ts0EntityFormManagerはコンポーネントとして廃止したことに対応。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/20   Time: 12:33
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/17   Time: 23:40
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
 * User: Akima        Date: 01/10/05   Time: 13:06
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/02   Time: 3:19
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/01   Time: 17:38
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/21   Time: 17:04
 * Updated in $/source/D5Integrated/Forms
 * Tc0EntityCtrlBridgeではなくTs0ObjCtrlBridgeにクラス名が変更になったこと
 * に対応
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0f1EntityDetail, ActnList, s0f0EntityDisplay, s0EntityDetailImpl,
  s0FormEventPublisher, s0FormRelation, 
  s0Entity, s0ObjCtrlBuilder, s0UnifiedObjCtrl, StdCtrls, ExtCtrls, Menus,
  ComCtrls, s0VCLClasses, s0ComponentEventWrapper, s0EntityDispImpl;

type
  Ts0frmAltEntityDetail = class(Ts0frmEntityDetail)
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    pnlCtrls: TScrollBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    Delete1: TMenuItem;
    Show1: TMenuItem;
    ShowNavigators1: TMenuItem;
    N1: TMenuItem;
    Delete2: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    R1: TMenuItem;
    procedure impDetailDetailLoad(Sender: TObject);
    procedure impDetailDetailSave(Sender: TObject);
    procedure impDetailSetTarget(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FTargetClass: Ts0EntityClass;
    FAllowRemove: Boolean;
    FAllowNewEntity: Boolean;
    procedure SetAllowNewEntity(const Value: Boolean);
    procedure SetAllowRemove(const Value: Boolean);
  protected
    function GetTargetClass: Ts0EntityClass; override;
    procedure SetTargetClass(Value: Ts0EntityClass); override;
    procedure PrepareModalEditForm(AForm: Ts0frmEntityDetail); override;
  public
    class function GetTargetClassBeforeCreate: Ts0EntityClass; override;
    class function IsAlternative: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    property AllowRemove: Boolean read FAllowRemove write SetAllowRemove default True;
    property AllowNewEntity: Boolean read FAllowNewEntity write SetAllowNewEntity default True;
  end;

var
  frm0AltEntityDetail: Ts0frmAltEntityDetail;

implementation

uses
  s0EntityFormManager,
  s0DBEntity;

{$R *.DFM}

function Ts0frmAltEntityDetail.GetTargetClass: Ts0EntityClass;
begin
  Result := FTargetClass;
end;

class function Ts0frmAltEntityDetail.GetTargetClassBeforeCreate: Ts0EntityClass;
begin
  Result := nil;
end;

procedure Ts0frmAltEntityDetail.impDetailDetailLoad(Sender: TObject);
begin
  s0UnifiedObjCtrl1.LoadFromTarget;
end;

procedure Ts0frmAltEntityDetail.impDetailDetailSave(Sender: TObject);
begin
  s0UnifiedObjCtrl1.SaveToTarget;
end;

class function Ts0frmAltEntityDetail.IsAlternative: Boolean;
begin
  Result := True;
end;

procedure Ts0frmAltEntityDetail.SetTargetClass(Value: Ts0EntityClass);
begin
  FTargetClass := Value;
end;

procedure Ts0frmAltEntityDetail.impDetailSetTarget(Sender: TObject);
begin
  if impDetail.DispTarget.Manager is Ts0DBEntityManager then
  begin
    s0UnifiedObjCtrl1.ProtoTypes.Assign(
      Ts0DBEntityManager(impDetail.DispTarget.Manager).ProtoTypes
    );
    s0UnifiedObjCtrl1.ProtoSourceCompo := impDetail.DispTarget.Manager;
    s0UnifiedObjCtrl1.ProtoSourcePropName := 'ProtoTypes';
  end;
  s0UnifiedObjCtrl1.Target := impDetail.DispTarget;
  s0UnifiedObjCtrl1.BuildCtrls;
  s0UnifiedObjCtrl1.LoadFromTarget;
end;

procedure Ts0frmAltEntityDetail.PrepareModalEditForm(
  AForm: Ts0frmEntityDetail);
var
  frm: Ts0frmAltEntityDetail;
begin
  inherited PrepareModalEditForm(AForm);
  if not(AForm is Ts0frmAltEntityDetail) then Exit;
  frm := Ts0frmAltEntityDetail(AForm);
  frm.pnlCtrls.HorzScrollBar.Position := Self.pnlCtrls.HorzScrollBar.Position;
  frm.pnlCtrls.VertScrollBar.Position := Self.pnlCtrls.VertScrollBar.Position;
end;

procedure Ts0frmAltEntityDetail.FormShow(Sender: TObject);
begin
  inherited;
  actNewEntity.Enabled :=  FAllowNewEntity;
  actRemoveEntity.Enabled :=  FAllowRemove;
end;

constructor Ts0frmAltEntityDetail.Create(AOwner: TComponent);
begin
  inherited;
  FAllowRemove := True;
  FAllowNewEntity := True;
end;

procedure Ts0frmAltEntityDetail.SetAllowNewEntity(const Value: Boolean);
begin
  FAllowNewEntity := Value;
end;

procedure Ts0frmAltEntityDetail.SetAllowRemove(const Value: Boolean);
begin
  FAllowRemove := Value;
end;

initialization
  RegisterDispClass(Ts0frmAltEntityDetail);

finalization
  UnRegisterDispClass(Ts0frmAltEntityDetail);

end.
