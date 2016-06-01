unit s0SingleInput;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, ExtCtrls,
  s0VCLClasses,
  s0CtrlEventSnatcher,
  Contnrs;    

type
  K0SingleInputOption = (k0sioReadOnlyLock, k0sioDisableLock, k0sioAutoClear);
  K0SingleInputOptionSet = set of K0SingleInputOption;

type
  Ts0SingleInput = class(Ts0VCLComponent)
  private
    FInputCtrl: TWinControl;
    FActive: Boolean;
    FControlArea: TWinControl;
    FBuf_TabStops: TComponentList;
    FInputCtrlListener: Ts0CtrlEventListener;
    FActivateCtrl: TCustomCheckBox;
    FActivateCtrlListener: Ts0CtrlEventListener;
    FOnKeyDown: TKeyEvent;
    FOnKeyUp: TKeyEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnMouseUp: TMouseEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnEnter: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FTimer: TTimer;
    FIntervalOfLastCtrlEvent: Integer;
    FOnInput: TNotifyEvent;
    FOptions: K0SingleInputOptionSet;
    FTerminators: String;
    procedure SetInputCtrl(const Value: TWinControl);
    procedure SetActive(const Value: Boolean);
    procedure SetControlArea(const Value: TWinControl);
    procedure SetActivateCtrl(const Value: TCustomCheckBox);
    procedure SetIntervalOfLastCtrlEvent(const Value: Integer);
  protected
    procedure CtrlOnChange(Sender: TObject);
    procedure CtrlOnClick(Sender: TObject);
    procedure CtrlOnDblClick(Sender: TObject);
    procedure CtrlOnEnter(Sender: TObject);
    procedure CtrlOnExit(Sender: TObject);
    procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char);
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CtrlOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CtrlOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure CtrlOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  protected
    procedure ActiveCtrlClick(Sender: TObject);
    procedure DoInput;
    function IsTerminator(Value: Char): Boolean;
    procedure LockTabStops;
    procedure UnLockTabStops;
    procedure SetTabStopOfCtrls(Value: Boolean);
    procedure CtrlOnEvent(AStopTimer: Boolean = False);
    procedure TimerOnTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Activate;
    procedure Deactivate;
  published
    property ActivateCtrl: TCustomCheckBox read FActivateCtrl write SetActivateCtrl;
    property Active: Boolean read FActive write SetActive default True;
    property ControlArea: TWinControl read FControlArea write SetControlArea;
    property InputCtrl: TWinControl read FInputCtrl write SetInputCtrl;
    property IntervalOfLastCtrlEvent: Integer read FIntervalOfLastCtrlEvent write SetIntervalOfLastCtrlEvent default -1;
    property Terminators: String read FTerminators write FTerminators;
    property Options: K0SingleInputOptionSet read FOptions write FOptions default [k0sioAutoClear];
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnInput: TNotifyEvent read FOnInput write FOnInput;
  end;

procedure Register;

implementation

uses
  s0InputStyle,
  s0TypeConvertor,
  s0CtrlDistiller,
  s0VCLStdCtrlsDistiller;

procedure Register;
begin
  RegisterComponents('P Form', [Ts0SingleInput]);
end;

type
  T9ActivateCtrlListener = class(Ts0CtrlEventListener)
  private
    FOwner: Ts0SingleInput;
  public
    constructor Create(AOwner: Ts0SingleInput);
    procedure CtrlOnClick(Sender: TObject); override;
  end;

type
  T9InputCtrlListener = class(Ts0CtrlEventListener)
  private
    FOwner: Ts0SingleInput;
  public
    constructor Create(AOwner: Ts0SingleInput);
    procedure CtrlOnChange(Sender: TObject); override;
    procedure CtrlOnClick(Sender: TObject); override;
    procedure CtrlOnDblClick(Sender: TObject); override;
    procedure CtrlOnEnter(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
    procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); override;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure CtrlOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CtrlOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
  end;

{ T9ActivateCtrlListener }

constructor T9ActivateCtrlListener.Create(AOwner: Ts0SingleInput);
begin
  FOwner := AOwner;
end;

procedure T9ActivateCtrlListener.CtrlOnClick(Sender: TObject);
begin
  FOwner.ActiveCtrlClick(Sender);
end;

{ T9InputCtrlListener }

constructor T9InputCtrlListener.Create(AOwner: Ts0SingleInput);
begin
  FOwner := AOwner;
end;

procedure T9InputCtrlListener.CtrlOnChange(Sender: TObject);
begin
  FOwner.CtrlOnChange(Sender);
end;

procedure T9InputCtrlListener.CtrlOnClick(Sender: TObject);
begin
  FOwner.CtrlOnClick(Sender);
end;

procedure T9InputCtrlListener.CtrlOnDblClick(Sender: TObject);
begin
  FOwner.CtrlOnDblClick(Sender);
end;

procedure T9InputCtrlListener.CtrlOnEnter(Sender: TObject);
begin
  FOwner.CtrlOnEnter(Sender);
end;

procedure T9InputCtrlListener.CtrlOnExit(Sender: TObject);
begin
  FOwner.CtrlOnExit(Sender);
end;

procedure T9InputCtrlListener.CtrlOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FOwner.CtrlOnKeyDown(Sender, Key, Shift);
end;

procedure T9InputCtrlListener.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
  FOwner.CtrlOnKeyPress(Sender, Key);
end;

procedure T9InputCtrlListener.CtrlOnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FOwner.CtrlOnKeyUp(Sender, Key, Shift);
end;

procedure T9InputCtrlListener.CtrlOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FOwner.CtrlOnMouseDown(Sender, Button, Shift, X, Y);
end;

procedure T9InputCtrlListener.CtrlOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FOwner.CtrlOnMouseMove(Sender, Shift, X, Y);
end;

procedure T9InputCtrlListener.CtrlOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FOwner.CtrlOnMouseUp(Sender, Button, Shift, X, Y);
end;


{ Ts0SingleInput }

procedure Ts0SingleInput.Activate;
begin
  if FInputCtrlListener <> nil then Exit;
  if FInputCtrl = nil then Exit;
  FInputCtrlListener := T9InputCtrlListener.Create(Self);
  Ts0CtrlEventSnatcher.Instance.RegisterListener(FInputCtrl, FInputCtrlListener);
  LockTabStops;
  if FInputCtrl.HandleAllocated and FInputCtrl.Enabled then
    FInputCtrl.SetFocus;
end;

constructor Ts0SingleInput.Create(AOwner: TComponent);
begin
  inherited;
  FTerminators := #13;
  FOptions := [k0sioAutoClear];
  FIntervalOfLastCtrlEvent := -1;
  FActivateCtrlListener := T9ActivateCtrlListener.Create(Self);
  FActive := True;
  if AOwner is TCustomForm then
    FControlArea := TCustomForm(AOwner);
  if csDesigning in Self.ComponentState then Exit;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerOnTimer;
end;

procedure Ts0SingleInput.CtrlOnChange(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Sender);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnClick(Sender: TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(Sender);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnDblClick(Sender: TObject);
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(Sender);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnEnter(Sender: TObject);
begin
  if Assigned(FOnEnter) then
    FOnEnter(Sender);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnExit(Sender: TObject);
begin
  if Assigned(FOnExit) then
    FOnExit(Sender);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Assigned(FOnKeyDown) then
    FOnKeyDown(Sender, Key, Shift);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnKeyPress(Sender: TObject; var Key: Char);
begin
  if Assigned(FOnKeyPress) then
    FOnKeyPress(Sender, Key);
  CtrlOnEvent( IsTerminator(Key) );
end;

procedure Ts0SingleInput.CtrlOnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Assigned(FOnKeyUp) then
    FOnKeyUp(Sender, Key, Shift);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Sender, Button, Shift, X, Y);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseMove) then
    FOnMouseMove(Sender, Shift, X, Y);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.CtrlOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Sender, Button, Shift, X, Y);
  CtrlOnEvent;
end;

procedure Ts0SingleInput.Deactivate;
begin
  UnLockTabStops;
  if FInputCtrlListener = nil then Exit;
  Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FInputCtrlListener);
  FreeAndNil( FInputCtrlListener );
end;

destructor Ts0SingleInput.Destroy;
begin
  FreeAndNil(FTimer);
  FreeAndNil(FActivateCtrlListener);
  FreeAndNil(FInputCtrlListener);
  FreeAndNil(FBuf_TabStops);
  inherited;
end;

procedure Ts0SingleInput.ActiveCtrlClick(Sender: TObject);
begin
  if not(Sender is TCustomCheckBox) then Exit;
  Active := Ts0TypeConv.StrToBool( Ts0CtrlDistillBroker.GetValue(Sender) );
end;

procedure Ts0SingleInput.Loaded;
begin
  inherited;
  if csDesigning in Self.ComponentState then Exit;
  if FActive then
    Activate; 
end;

procedure Ts0SingleInput.LockTabStops;
begin
  if FBuf_TabStops <> nil then Exit;
  FBuf_TabStops := TComponentList.Create(False);
  SetTabStopOfCtrls(False);
end;

procedure Ts0SingleInput.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FInputCtrl = AComponent then
    FInputCtrl := nil;
  if FControlArea = AComponent then
    FControlArea := nil;   
  if FActivateCtrl = AComponent then
    FActivateCtrl := nil;
end;

procedure Ts0SingleInput.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if csDesigning in Self.ComponentState then Exit;
  if FActive then
    Activate
  else
    Deactivate;
end;

procedure Ts0SingleInput.SetActivateCtrl(const Value: TCustomCheckBox);
begin
  if FActivateCtrl = Value then Exit;
  if csDesigning in Self.ComponentState then
  begin
    FActivateCtrl := Value;
  end
  else
  begin
    Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FActivateCtrlListener);
    FActivateCtrl := Value;
    if FActivateCtrl <> nil then
      Ts0CtrlEventSnatcher.Instance.RegisterListener(FActivateCtrl, FActivateCtrlListener);
  end;
end;

procedure Ts0SingleInput.SetControlArea(const Value: TWinControl);
  function CanBeControlArea(ACtrl: TWinControl): Boolean;
  begin
    Result := False;
    if ACtrl = nil then Exit;
    Result := csAcceptsControls in ACtrl.ControlStyle;
  end;
begin
  if FControlArea = Value then Exit;
  if Value <> nil then 
    if not CanBeControlArea(Value)then Exit;
  FControlArea := Value;
end;

procedure Ts0SingleInput.SetInputCtrl(const Value: TWinControl);
begin
  FInputCtrl := Value;
end;         

procedure Ts0SingleInput.SetTabStopOfCtrls(Value: Boolean);
  procedure SetLockProps(ACtrl: TWinControl; AVal: Boolean);
  var
    inpCtrl: Ts0InputStyle;
  begin
    ACtrl.TabStop := Value;
    if ACtrl = FActivateCtrl then Exit;
    if k0sioReadOnlyLock in FOptions then
    begin
      inpCtrl := Ts0CtrlDistillBroker.GetInputControl(ACtrl);
      if inpCtrl <> nil then
        inpCtrl.ReadOnly := not AVal;
    end;
    if k0sioDisableLock in FOptions then
      ACtrl.Enabled := AVal;
  end;
var
  i: Integer;
  ctrl: TControl;
begin
  if FControlArea = nil then Exit;
  for i := 0 to FControlArea.ControlCount -1 do
  begin
    ctrl := FControlArea.Controls[i];
    if ctrl = FInputCtrl then Continue;
    if not(ctrl is TWinControl) then Continue;
    if Value then
    begin
      if FBuf_TabStops.IndexOf(ctrl) < 0 then Continue;
      FBuf_TabStops.Remove(ctrl);
    end
    else
    begin
      if not TWinControl(ctrl).TabStop then Continue;
      FBuf_TabStops.Add(ctrl);
    end;
    SetLockProps( TWinControl(ctrl), Value );
  end;
end;

procedure Ts0SingleInput.UnLockTabStops;
begin
  if FBuf_TabStops = nil then Exit;
  SetTabStopOfCtrls(True);
  FreeAndNil(FBuf_TabStops);
end;

procedure Ts0SingleInput.SetIntervalOfLastCtrlEvent(const Value: Integer);
begin
  FIntervalOfLastCtrlEvent := Value;
end;

procedure Ts0SingleInput.CtrlOnEvent(AStopTimer: Boolean);
begin
  FTimer.Enabled := False;
  if AStopTimer then
  begin
    DoInput;
    Exit;
  end;
  if FIntervalOfLastCtrlEvent < 0 then Exit;
  FTimer.Interval := FIntervalOfLastCtrlEvent;
  FTimer.Enabled := True;
end;

procedure Ts0SingleInput.TimerOnTimer(Sender: TObject);
begin
  DoInput;
  FTimer.Enabled := False;
end;

procedure Ts0SingleInput.DoInput;
begin
  if Assigned(FOnInput) then
    FOnInput(Self);
  if k0sioAutoClear in FOptions then
    if FInputCtrl <> nil then 
      Ts0CtrlDistillBroker.SetValue('', FInputCtrl);
end;

function Ts0SingleInput.IsTerminator(Value: Char): Boolean;
begin
  Result := (AnsiPos(Value, FTerminators) > 0);
end;

end.
