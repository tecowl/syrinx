unit s0ce_fCompoPropFilter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ObjectsPropFilter, ExtCtrls, ToolWin, ComCtrls, ActnList, StdCtrls,
  s0Button, s0ObjCtrlBuilder, s0UnifiedObjCtrl,  
  s0PropertyProtoType, s0VCLClasses;

type
  Ts0ce_frmCompoPropFilter = class(TForm)
    ScrollBox1: TScrollBox;
    CoolBar1: TCoolBar;
    Panel1: TPanel;
    s0Button1: Ts0Button;
    s0Button2: Ts0Button;
    s0Button3: Ts0Button;
    ActionList1: TActionList;
    actRefresh: TAction;
    actSaveValues: TAction;
    actClose: TAction;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    procedure actRefreshExecute(Sender: TObject);
    procedure actSaveValuesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
  private
    FFilter: Ts0ObjectsPropFilter;
    FTarget: TComponent;
    procedure SetTarget(const Value: TComponent);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Target: TComponent read FTarget write SetTarget;
    property Filter: Ts0ObjectsPropFilter read FFilter;
  end;

var
  frm0ceCompoPropFilter: Ts0ce_frmCompoPropFilter;

implementation

{$R *.DFM}

uses
  Contnrs;

{ Ts0ce_frmCompoPropFilter }

constructor Ts0ce_frmCompoPropFilter.Create(AOwner: TComponent);
begin
  inherited;
  FFilter := Ts0ObjectsPropFilter.Create(nil);
end;

destructor Ts0ce_frmCompoPropFilter.Destroy;
begin
  FreeAndNil(FFilter);
  inherited;
end;

procedure Ts0ce_frmCompoPropFilter.SetTarget(const Value: TComponent);
var
  i: Integer;
  cl: TComponentList;
begin
  FTarget := Value;
  if FTarget = nil then Exit;
  cl := TComponentList.Create(False);
  try
    for i := 0 to FTarget.ComponentCount -1 do
      cl.Add(FTarget.Components[i]);
    FFilter.SourceList := cl;
  finally
    FreeAndNil(cl);
  end;
end;

procedure Ts0ce_frmCompoPropFilter.actRefreshExecute(Sender: TObject);
begin
  FFilter.RefreshItems;
end;

procedure Ts0ce_frmCompoPropFilter.actSaveValuesExecute(Sender: TObject);
begin
  FFilter.SaveItemValues;
end;

procedure Ts0ce_frmCompoPropFilter.FormShow(Sender: TObject);
var
  p: Ts0PropertyProtoType;
begin
  s0UnifiedObjCtrl1.Target := FFilter;
  s0UnifiedObjCtrl1.BuildCtrls;
  s0UnifiedObjCtrl1.LoadFromTarget;
  //
  p := s0UnifiedObjCtrl1.ProtoTypes.FindByName('Items');
  if not(p is Ts0ProtoTypeCtrl) then Exit;
  Ts0ProtoTypeCtrl(p).Ctrl.Anchors := [akLeft, akTop, akRight, akBottom];
end;

procedure Ts0ce_frmCompoPropFilter.actCloseExecute(Sender: TObject);
begin
  Close;
end;

initialization
  RegisterClass(Ts0ObjectsPropFilter);

finalization
  UnRegisterClass(Ts0ObjectsPropFilter);

end.
