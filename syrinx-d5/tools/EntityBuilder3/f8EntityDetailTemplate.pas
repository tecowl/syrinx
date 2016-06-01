unit f8EntityDetailTemplate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Entity, s0f1EntityDetail, ActnList, s0f0EntityDisplay,
  s0EntityDetailImpl, s0FormEventPublisher, s0FormRelation, ComCtrls,
  s0ObjCtrlBuilder, s0UnifiedObjCtrl, Menus;

type
  Tfrm8EntityDetailTemplate = class(Ts0frmEntityDetail)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    Delete1: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    Show1: TMenuItem;
    ShowNavigators1: TMenuItem;
    R1: TMenuItem;
    N1: TMenuItem;
    Delete2: TMenuItem;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    ScrollBox1: TScrollBox;
    procedure impDetailDetailLoad(Sender: TObject);
    procedure impDetailDetailSave(Sender: TObject);
    procedure impDetailSetTarget(Sender: TObject);
  private
  public
    class function GetTargetClassBeforeCreate: Ts0EntityClass; override;
  end;

var
  frm8EntityDetailTemplate: Tfrm8EntityDetailTemplate;

implementation

{$R *.DFM}

{ Tfrm8EntityDetailTemplate }

class function Tfrm8EntityDetailTemplate.GetTargetClassBeforeCreate: Ts0EntityClass;
begin
  Result := nil;
end;

procedure Tfrm8EntityDetailTemplate.impDetailDetailLoad(Sender: TObject);
begin
  inherited;
//
end;

procedure Tfrm8EntityDetailTemplate.impDetailDetailSave(Sender: TObject);
begin
  inherited;
//
end;

procedure Tfrm8EntityDetailTemplate.impDetailSetTarget(Sender: TObject);
begin
  inherited;
//
end;

end.
