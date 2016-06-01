unit s0GUIRobot;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Menus,
  s0VCLClasses,
  s0CommonTypes;

type
  K0GUIRobotOption = (k0groClickBeforeDblClick);
  K0GUIRobotOptions = set of K0GUIRobotOption; 

type
  Ts0GUIRobot = class(Ts0VCLComponent)
  private
    FMouseSpeed: Longword;
    FClickInterval: Longword;
    FOptions: K0GUIRobotOptions;
    function GetUnserCursor: TControl;
    function GetFocused: TWinControl;
    procedure SetFocused(Value: TWinControl);
    function GetActiveForm: TCustomForm;
    procedure SetActiveForm(const Value: TCustomForm);
    procedure SetUnserCursor(const Value: TControl);
    procedure SetMouseSpeed(const Value: Longword);
    function GetCursorPos: TPoint;
    procedure SetCursorPos(const Value: TPoint);
    procedure SetClickInterval(const Value: Longword);
    procedure SetOptions(const Value: K0GUIRobotOptions);
  protected
    procedure SendKeyMsg(ACtrl: TControl; AMsg: Cardinal; Key:
      Word; Shift: TShiftState);
    procedure SendMouseMsg(ACtrl: TControl; AMsg: Cardinal; Button:
      TMouseButton; Shift: TShiftState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure Click;
    procedure DblClick;
    procedure RightClick;
  public
    procedure ClickCtrl(ACtrl: TControl);
    procedure DblClickCtrl(ACtrl: TControl);
    procedure RightClickCtrl(ACtrl: TControl);
  public
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState);
    procedure MoveTo(AScrnPos: TPoint);
    procedure MoveNow(AScrnPos: TPoint);
    procedure MoveSlowly(AScrnPos: TPoint);
  public
    procedure MoveToCtrl(AControl: TControl; AHorz: K0HorizontalAlignment =
      k0haCenter; AVert: K0VerticalAlignment = k0vaCenter);
    procedure MoveToCtrlOf(AControl: TControl; ACtrlPos: TPoint);
  public
    procedure InputChar(AChar: Char);
    procedure InputChars(AChar: Char; ACount: Integer);
    procedure InputText(AText: string);
    procedure KeyDown(Key: Word; Shift: TShiftState);
    procedure KeyPress(Key: Char);
    procedure KeyUp(Key: Word; Shift: TShiftState);
  public
    procedure WaitFor(AMiliSec: LongWord);
  public
    property CursorPos: TPoint read GetCursorPos write SetCursorPos;
  public
    property ActiveForm: TCustomForm read GetActiveForm write SetActiveForm;
    property Focused: TWinControl read GetFocused write SetFocused;
    property UnserCursor: TControl read GetUnserCursor write SetUnserCursor;
  published
    property ClickInterval: Longword read FClickInterval write SetClickInterval default 100; {miliseconds}
    property MouseSpeed: Longword read FMouseSpeed write SetMouseSpeed default 2500; {pixel / sec}
    property Options: K0GUIRobotOptions read FOptions write SetOptions
      default [k0groClickBeforeDblClick];
  end;

function GetCtrlByScreenPos(APos: TPoint): TControl;

procedure Register;

implementation

uses
  s0StringHelper,
  s0ControlHelper,
  s0GraphHelper;

procedure Register;
begin
  RegisterComponents('P Form', [Ts0GUIRobot]);
end;

function GetCtrlByScreenPos(APos: TPoint): TControl;
  function GetFormByPos(p: TPoint): TCustomForm;
  var
    i: Integer;
  begin
    for i := Screen.CustomFormCount -1 downto 0 do
    begin
      Result := Screen.CustomForms[i];
      if s0GraphHelper.IsInRect(p, Result.BoundsRect) then Exit;
    end;
    Result := nil;
  end;
  function GetCtrlByPos(AParent: TWinControl; p: TPoint): TControl;
  var
    i: Integer;
  begin
    p := AParent.ScreenToClient(p);
    for i := AParent.ControlCount -1 downto 0 do
    begin
      Result := AParent.Controls[i];
      if s0GraphHelper.IsInRect(p, Result.BoundsRect) then Exit;
    end;
    Result := nil;
  end;    
var
  prnt: TWinControl;
begin
  Result := nil;
  prnt := GetFormByPos(APos);
  if prnt = nil then Exit;
  repeat
    Result := GetCtrlByPos(prnt, APos);
    if Result is TWinControl then
      prnt := TWinControl(Result)
    else
      Break;
  until Result = nil;
  if Result = nil then
    Result := prnt;
end;

{ Ts0GUIRobot }

procedure Ts0GUIRobot.Click;
  procedure DownAndUp;
  begin
    MouseDown(mbLeft, [ssLeft]);
    WaitFor(FClickInterval);
    MouseUp(mbLeft, []);
  end;
begin
  if UnserCursor = nil then Exit;
  DownAndUp;
end;

procedure Ts0GUIRobot.ClickCtrl(ACtrl: TControl);
begin
  if ACtrl = nil then Exit;
  if UnserCursor <> ACtrl then
    MoveToCtrl(ACtrl);
  Click;
end;

constructor Ts0GUIRobot.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ClickInterval := 100;
  FMouseSpeed := 2500;
  FOptions := [k0groClickBeforeDblClick];
end;

procedure Ts0GUIRobot.DblClick;
  procedure ClickBeforeDoubleClick;
  begin
    if not(k0groClickBeforeDblClick in FOptions) then Exit;
    Click;
  end;
begin
  if UnserCursor = nil then Exit;
  ClickBeforeDoubleClick;
  SendMouseMsg(UnserCursor, WM_LBUTTONDBLCLK, mbLeft, [ssLeft, ssDouble]);
  { ‰½‚ÅDblClick‚ÌŒã‚ÉMouseUp‚¾‚¯‚µ‚È‚¯‚ê‚Î‚È‚ç‚È‚¢‚Ì‚©•s–¾ }
  MouseUp(mbLeft, []);
end;

procedure Ts0GUIRobot.DblClickCtrl(ACtrl: TControl);
begin
  if ACtrl = nil then Exit;
  if UnserCursor <> ACtrl then
    MoveToCtrl(ACtrl);
  DblClick;
end;

destructor Ts0GUIRobot.Destroy;
begin

  inherited;
end;

function Ts0GUIRobot.GetActiveForm: TCustomForm;
begin
  Result := Screen.ActiveCustomForm;
end;

function Ts0GUIRobot.GetCursorPos: TPoint;
begin
  Result := Mouse.CursorPos;
end;

function Ts0GUIRobot.GetFocused: TWinControl;
begin
  Result := Screen.ActiveControl;
end;

function Ts0GUIRobot.GetUnserCursor: TControl;
begin
  Result := GetCtrlByScreenPos(CursorPos);
end;

procedure Ts0GUIRobot.InputChar(AChar: Char);
begin
  if Focused = nil then Exit;
  if Ts0CharHelper.IsKana(AChar) then Exit;
  KeyDown(Word(AChar), []);
  KeyPress( AChar );
  KeyUp(Word(AChar), []);
end;

procedure Ts0GUIRobot.InputChars(AChar: Char; ACount: Integer);
var
  t: string;
begin
  t := StringOfChar(AChar, ACount);
  InputText(t);
end;

procedure Ts0GUIRobot.InputText(AText: string);
var
  i: Integer;
begin
  if Focused = nil then Exit;
  for i := 1 to Length(AText) do
    if ByteToCharIndex(AText, i) = i then
      InputChar(AText[i]);
end;

procedure Ts0GUIRobot.KeyDown(Key: Word; Shift: TShiftState);
begin
  if Focused = nil then Exit;
  SendKeyMsg(Focused, WM_KEYDOWN, Key, Shift);
end;

procedure Ts0GUIRobot.KeyPress(Key: Char);
begin
  if Focused = nil then Exit;
  SendKeyMsg(Focused, WM_CHAR, Word(Key), []);
end;

procedure Ts0GUIRobot.KeyUp(Key: Word; Shift: TShiftState);
begin
  if Focused = nil then Exit;
  SendKeyMsg(Focused, WM_KEYUP, Key, Shift);
end;

procedure Ts0GUIRobot.MouseDown(Button: TMouseButton;
  Shift: TShiftState);
begin
  if UnserCursor = nil then Exit;
  SendMouseMsg(UnserCursor, WM_LBUTTONDOWN, Button, Shift);
end;

procedure Ts0GUIRobot.MouseUp(Button: TMouseButton;
  Shift: TShiftState);
begin
  if UnserCursor = nil then Exit;
  SendMouseMsg(UnserCursor, WM_LBUTTONUP, Button, Shift);
end;

procedure Ts0GUIRobot.MoveNow(AScrnPos: TPoint);
begin
  Mouse.CursorPos := AScrnPos;
end;

procedure Ts0GUIRobot.MoveSlowly(AScrnPos: TPoint);
var
  n, beginMove, endMove: DWORD;
  basePos: TPoint;
  xIsConst: Boolean;
  a, b: Double;

  procedure CalcSimpleEquationAB;
  begin
    xIsConst := AScrnPos.X = basePos.X;
    if not xIsConst then
    begin
      a := (basePos.Y - AScrnPos.Y) / (basePos.X - AScrnPos.X);
      b := (basePos.X * AScrnPos.Y - AScrnPos.X * basePos.Y) / (basePos.X - AScrnPos.X);
    end;
  end;
  function GetNextPos: TPoint;
  var
    p: Double;
  begin
    Result := basePos;
    p := (n - beginMove) / (endMove - beginMove);
    if xIsConst then
    begin
      Result.Y := Trunc( (AScrnPos.Y - basePos.Y) * p + basePos.Y );
    end
    else
    begin
      Result.X := Trunc( (AScrnPos.X - basePos.X) * p + basePos.X );
      Result.Y := Trunc( a * Result.X + b);
    end;
  end;
var
  l: Double;
  t: DWORD;
begin
  basePos := CursorPos;
  CalcSimpleEquationAB;
  l := sqrt( sqr(AScrnPos.X - basePos.X) + sqr(AScrnPos.Y - basePos.Y) );
  t := Trunc( (l / (FMouseSpeed)) * 1000);
  n := GetTickCount;
  beginMove := n;
  endMove := beginMove + t;
  while n < endMove do
  begin
    CursorPos := GetNextPos;
    Application.ProcessMessages;
    n := GetTickCount;
  end;
  if (CursorPos.X <> AScrnPos.X) or (CursorPos.Y <> AScrnPos.Y) then
    CursorPos := AScrnPos;
end;

procedure Ts0GUIRobot.MoveTo(AScrnPos: TPoint);
begin
  if FMouseSpeed < 1 then
    MoveNow(AScrnPos)
  else
    MoveSlowly(AScrnPos);
end;

procedure Ts0GUIRobot.MoveToCtrl(AControl: TControl;
  AHorz: K0HorizontalAlignment; AVert: K0VerticalAlignment);
  function GetPosAligned: TPoint;
  begin
    Result.X := 0;
    Result.Y := 0;
    case AHorz of
      k0haLeft  : Result.X := (AControl.Width div 4);
      k0haCenter: Result.X := (AControl.Width div 2);
      k0haRight : Result.X := (AControl.Width div 4) * 3;
    end;
    case AVert of
      k0vaTop   : Result.Y := (AControl.Height div 4);
      k0vaCenter: Result.Y := (AControl.Height div 2);
      k0vaBottom: Result.Y := (AControl.Height div 4) * 3;
    end;
  end;
begin
  if AControl = nil then Exit;
  MoveToCtrlOf(AControl, GetPosAligned);
end;

procedure Ts0GUIRobot.MoveToCtrlOf(AControl: TControl;
  ACtrlPos: TPoint);
begin
  if AControl = nil then Exit;
  MoveTo( AControl.ClientToScreen(ACtrlPos) );
end;

procedure Ts0GUIRobot.RightClick;
begin

end;

procedure Ts0GUIRobot.RightClickCtrl(ACtrl: TControl);
begin
  if ACtrl = nil then Exit;
  if UnserCursor <> ACtrl then
    MoveToCtrl(ACtrl);
  RightClick;
end;

procedure Ts0GUIRobot.SendKeyMsg(ACtrl: TControl; AMsg: Cardinal;
  Key: Word; Shift: TShiftState);
var
  msg: TWMKey;
begin
  if ACtrl = nil then Exit;
  msg.Msg := AMsg;
  msg.CharCode := Key;
  msg.KeyData := Ts0ControlHelper.ShiftStateToKeyData(Shift, True);
  ACtrl.Perform(AMsg, TMessage(msg).WParam, TMessage(msg).LParam);
end;

procedure Ts0GUIRobot.SendMouseMsg(ACtrl: TControl; AMsg: Cardinal;
  Button: TMouseButton; Shift: TShiftState);
var
  p: TPoint;
  msg: TWMMouse;
begin
  if ACtrl = nil then Exit;
  case Button of
    mbLeft  : msg.Msg := WM_LBUTTONUP;
    mbRight : msg.Msg := WM_RBUTTONUP;
    mbMiddle: msg.Msg := WM_MBUTTONUP;
  end;
  msg.Keys := Ts0ControlHelper.ShiftStateToKey(Shift);
  p := ACtrl.ScreenToClient(CursorPos);
  msg.XPos := p.X;
  msg.YPos := p.Y;
  ACtrl.Perform(AMsg, TMessage(msg).WParam, TMessage(msg).LParam);
end;

procedure Ts0GUIRobot.SetActiveForm(const Value: TCustomForm);
begin
  Assert(Value <> nil);
  Value.SetFocus;
end;

procedure Ts0GUIRobot.SetClickInterval(const Value: Longword);
begin
  FClickInterval := Value;
end;

procedure Ts0GUIRobot.SetCursorPos(const Value: TPoint);
begin
  Mouse.CursorPos := Value;
end;

procedure Ts0GUIRobot.SetFocused(Value: TWinControl);
var
  frm: TCustomForm;
begin
  Assert(Value <> nil);
  frm := GetParentForm(Value);
  if frm = nil then Exit;
  frm.SetFocusedControl(Value);
end;

procedure Ts0GUIRobot.SetMouseSpeed(const Value: Longword);
begin
  FMouseSpeed := Value;
end;

procedure Ts0GUIRobot.SetOptions(const Value: K0GUIRobotOptions);
begin
  FOptions := Value;
end;

procedure Ts0GUIRobot.SetUnserCursor(const Value: TControl);
begin
  MoveToCtrl(Value);
end;

procedure Ts0GUIRobot.WaitFor(AMiliSec: LongWord);
var
  t: DWORD;
begin
  t := GetTickCount;
  while GetTickCount < t + AMiliSec do
    Application.ProcessMessages;
end;

end.
