unit s0ControlLock;
{
$History: s0ControlLock.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0ctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/01   Time: 13:22
 * Updated in $/source/p0control
 * コメントを追加
 *
 * *****************  Version 4  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマ ンド追加
}

{
  Ts0ControlLock
  コントロールのEnabledなどをまとめて制御するコンポーネント。
  public  property Locked: Boolean
  ロックがかけられているかどうかを表す。

  public   procedure LockControls;
  ロックする。EnabledをFalseにする。

  public   procedure UnLockControls;
  ロックを外す。EnabledをTrueにする。

  published  property ControlArea: TWinControl
  ロック対象となるコントロール。

  published  property LockAllControl: Boolean
  全てのコントロールをロックするかどうか。



  Ts0VisibleController
  コントロールのVisibleをまとめて制御するコンポーネント。
    property Mode: K0InitialControlMode read FMode write SetMode default
      k1icmDisabled;

  public  procedure SetVisibleOfTargets(Value: Boolean);

  published  property Mode: K0InitialControlMode read FMode write SetMode default
  published    k1icmDisabled;
  published  property Targets: Ts0CtrlPtrCollection read FTargets write SetTargets;
  published  property ControlArea: TWinControl read FControlArea write SetControlArea;
}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics,
  s0VCLClasses,
  s0Exception,
  s0CtrlPtrCollection;

type
  Ts0ControlLock = class(Ts0VCLComponent)
  private
    FLockedControls: TList;
    FLocked: Boolean;
    FControlArea: TWinControl;
    FLockAllControl: Boolean;
    procedure SetControlsEnable(AEnabled: Boolean);
    procedure SetControlArea(const Value: TWinControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Locked: Boolean read FLocked;
    procedure LockControls;
    procedure UnLockControls;
  published
    property ControlArea: TWinControl read FControlArea write SetControlArea;
    property LockAllControl: Boolean read FLockAllControl write FLockAllControl
      default True;
  end;

type
  K0InitialControlMode = (k1icmNone, k1icmHidden, k1icmDisabled);

type
  Ts0VisibleController = class(Ts0VCLComponent)
  private
    FTargets: Ts0CtrlPtrCollection;
    FMode: K0InitialControlMode;
    FHiddenCtrls: TList;
    FControlArea: TWinControl;
    procedure SetTargets(const Value: Ts0CtrlPtrCollection);
    procedure SetMode(const Value: K0InitialControlMode);
    procedure SetControlArea(const Value: TWinControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure GetInitialHiddenCtrls(Dest: TList);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetVisibleOfTargets(Value: Boolean);
  published
    property Mode: K0InitialControlMode read FMode write SetMode default
      k1icmDisabled;
    property Targets: Ts0CtrlPtrCollection read FTargets write SetTargets;
    property ControlArea: TWinControl read FControlArea write SetControlArea;
  end;

implementation

uses
  ActnList,
  s0GraphHelper;

{ Ts0ControlLock }

procedure Ts0ControlLock.LockControls;
begin
  SetControlsEnable(False);
end;

constructor Ts0ControlLock.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLockedControls := TList.Create;
  FLockAllControl := True;
end;

destructor Ts0ControlLock.Destroy;
begin
  FreeAndNil(FLockedControls);
  inherited;
end;

procedure Ts0ControlLock.UnLockControls;
begin
  SetControlsEnable(True);
end;

procedure Ts0ControlLock.SetControlsEnable(AEnabled: Boolean);
  procedure LockAndAddControl(AList: TList; AControl: TControl);
  begin
    if not AControl.Enabled then
      Exit;
    AControl.Enabled := False;
    FLockedControls.Add(AControl);
  end;
var
  i: Integer;
begin
  if AEnabled then
  begin
    for i := 0 to FLockedControls.Count - 1 do
      TControl(FLockedControls.Items[i]).Enabled := True;
    FLockedControls.Clear;
    FLocked := False;
  end
  else
  begin
    FLocked := True;
    FLockedControls.Clear;
    if FControlArea = nil then
      Exit;
    if FLockAllControl then
    begin
      for i := 0 to FControlArea.ComponentCount - 1 do
        if FControlArea.Components[i] is TControl then
          LockAndAddControl(FLockedControls,
            TControl(FControlArea.Components[i]));
    end
    else
    begin
      for i := 0 to FControlArea.ControlCount - 1 do
        LockAndAddControl(FLockedControls, FControlArea.Controls[i]);
    end;
  end;
end;

procedure Ts0ControlLock.SetControlArea(const Value: TWinControl);
begin
  FControlArea := Value;
end;

procedure Ts0ControlLock.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then
    Exit;
  if FControlArea = AComponent then
    FControlArea := nil;
end;

{ Ts0VisibleController }

constructor Ts0VisibleController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMode := k1icmDisabled;
  FTargets := Ts0CtrlPtrCollection.Create(Self, Ts0CtrlPtrCollectionItem);
end;

destructor Ts0VisibleController.Destroy;
begin
  FreeAndNil(FHiddenCtrls);
  FreeAndNil(FTargets);
  inherited;
end;

procedure Ts0VisibleController.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  FTargets.Notification(AComponent, Operation);
  if FControlArea = AComponent then
    FControlArea := nil;
end;

procedure Ts0VisibleController.SetTargets(const Value: Ts0CtrlPtrCollection);
begin
  FTargets.Assign(Value);
end;

procedure Ts0VisibleController.SetVisibleOfTargets(Value: Boolean);
var
  i: Integer;
  ctrl: TControl;
begin
  if FMode = k1icmNone then
    Exit;
  if Value then
  begin
    if (FHiddenCtrls = nil) then
      Exit;
  end
  else
  begin
    if (FHiddenCtrls <> nil) then
      Exit;
    FHiddenCtrls := TList.Create;
    GetInitialHiddenCtrls(FHiddenCtrls);
  end;
  for i := 0 to FHiddenCtrls.Count - 1 do
  begin
    ctrl := TControl(FHiddenCtrls.Items[i]);
    case FMode of
      k1icmHidden: ctrl.Visible := Value;
      k1icmDisabled: ctrl.Enabled := Value;
    end;
  end;
  if Value then
  begin
    FreeAndNil(FHiddenCtrls);
  end;
end;

procedure Ts0VisibleController.SetMode(const Value: K0InitialControlMode);
begin
  FMode := Value;
end;

procedure Ts0VisibleController.GetInitialHiddenCtrls(Dest: TList);
var
  i: Integer;
begin
  if FControlArea = nil then
    Exit;
  for i := 0 to FControlArea.ControlCount - 1 do
  begin
    if FTargets.IndexOfCtrl(FControlArea.Controls[i]) > -1 then
      Continue;
    Dest.Add(FControlArea.Controls[i]);
  end;
end;

procedure Ts0VisibleController.SetControlArea(const Value: TWinControl);
begin
  FControlArea := Value;
end;

end.
