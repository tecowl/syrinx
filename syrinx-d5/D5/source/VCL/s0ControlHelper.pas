unit s0ControlHelper;
{
$History: s0ControlHelper.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/08   Time: 2:36
 * Updated in $/source/D6VCLIntegrated
 * Key関連のメソッドを追加。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0control
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 15:12
 * Updated in $/source/p0control
 * GetRelativeTopLeftのバグ修正
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/30   Time: 10:09
 * Updated in $/source/p0control
 * GetRelativeTopLeft、GetRelativeBoundsRect、GetTextPositionメソッドを追
 * 加
 * 
 *
 * *****************  Version 3  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマ ンド追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  s0CommonTypes;

type
  Ts0ControlHelper = class
  private
  public
    class procedure SetFocusNextControl(AForm: TCustomForm);
    class function IsAncestor(AContainer: TWinControl; AControl: TControl):
      Boolean;
    class function GetParentForm(AControl: TControl): TCustomForm;
    class function GetRelativeTopLeft(ABase: TWinControl;
      ATarget: TControl): TPoint;
    class function GetRelativeBoundsRect(ABase: TWinControl;
      ATarget: TControl): TRect;
    class function GetTextPosition(ACanvas: TCanvas; AText: string; ARect: TRect;
      AHorz: TAlignment = taCenter; AVert: K0VerticalAlignment = k0vaCenter): TPoint;
    //
    class function ShiftStateToKey(AState: TShiftState; AReflect: Boolean = True): Word;
    class function ShiftStateToKeyData(AState: TShiftState; AReflect: Boolean = True): Longint;
    class function ShiftStateToKeyboardState(AState: TShiftState): TKeyboardState;
    //
    class procedure KeyStateOn(var AKeyState: Byte);
    class procedure KeyStateOff(var AKeyState: Byte);
    class procedure ChangeNextState(var AKeyState: Byte);
  end;

type
  Es0ControlParentException = class(Exception);

implementation

{ Ts0ControlHelper }

class function Ts0ControlHelper.GetParentForm(AControl: TControl): TCustomForm;
begin
  Result := nil;
  if AControl = nil then
    Exit;
  if AControl.Parent = nil then
    Exit;
  if AControl.Parent is TCustomForm then
    Result := TCustomForm(AControl.Parent)
  else
    Result := GetParentForm(AControl.Parent);
end;

resourcestring
  c9ErrMsg_BaseIsNotAncestor = '引数ABaseは、引数ATargetの祖先ではありません';

class function Ts0ControlHelper.GetRelativeTopLeft(ABase: TWinControl;
  ATarget: TControl): TPoint;
  function GetPosition: TPoint;
  var
    current: TWinControl;
  begin
    Result := ATarget.BoundsRect.TopLeft;
    current := ATarget.Parent;
    while current <> ABase do
    begin
      Result.x := Result.x + current.Left;
      Result.y := Result.y + current.Top;
      current := current.Parent;
    end;
  end;
begin
  if ABase = ATarget then
  begin
    Result := Point(0, 0);
    Exit;
  end;
  if not IsAncestor(ABase, ATarget) then
    raise Es0ControlParentException.Create(c9ErrMsg_BaseIsNotAncestor);
  Result := GetPosition; 
end;

class function Ts0ControlHelper.GetRelativeBoundsRect(ABase: TWinControl;
  ATarget: TControl): TRect;
begin
  Result.TopLeft := GetRelativeTopLeft(ABase, ATarget);
  Result.Right := Result.Left + ATarget.Width;
  Result.Bottom := Result.Top + ATarget.Height;
end;

class function Ts0ControlHelper.IsAncestor(AContainer: TWinControl;
  AControl: TControl): Boolean;
begin
  Result := False;
  if AContainer = nil then
    Exit;
  if AControl = nil then
    Exit;
  Result := (AContainer = AControl.Parent);
  if not Result then
    Result := IsAncestor(AContainer, AControl.Parent);
end;

class procedure Ts0ControlHelper.SetFocusNextControl(AForm: TCustomForm);
begin
  if AForm = nil then Exit;
  SendMessage(AForm.Handle, WM_NEXTDLGCTL, 0, 0);
end;


class function Ts0ControlHelper.GetTextPosition(ACanvas: TCanvas; AText: string;
  ARect: TRect; AHorz: TAlignment; AVert: K0VerticalAlignment): TPoint;
var
  h, w: Integer;
  rh, rw: Integer;
begin
  Result := ARect.TopLeft;
  rw := ARect.Right - ARect.Left;
  rh := ARect.Bottom - ARect.Top;
  h := ACanvas.TextHeight(AText);
  w := ACanvas.TextWidth(AText);
  case AHorz of
    taLeftJustify : Result.x := 0;
    taRightJustify: Result.x := rw - w;
    taCenter      : Result.x := (rw - w) div 2;
  end;
  Result.x := Result.x +  + ARect.Left;
  case AVert of
    k0vaTop   : Result.y := 0;
    k0vaCenter: Result.y := (rh - h) div 2;
    k0vaBottom: Result.y := rh - h;
  end;
  Result.y := Result.y +  + ARect.Top;
  if Result.x < ARect.Left then Result.x := ARect.Left;
  if Result.y < ARect.Top  then Result.y := ARect.Top;
end;

class function Ts0ControlHelper.ShiftStateToKey(AState: TShiftState; AReflect: Boolean): Word;
  procedure ReflectState;
  var
    keys: TKeyboardState;
  begin
    if not AReflect then Exit;
    GetKeyboardState(keys);
    if ssAlt in AState then
      KeyStateOn(keys[VK_MENU])
    else
      KeyStateOff(keys[VK_MENU]);
    SetKeyboardState(keys);
  end;
begin
  Result := 0;
  if ssShift  in AState then Result := Result + MK_SHIFT;
  if ssCtrl   in AState then Result := Result + MK_CONTROL;
  if ssLeft   in AState then Result := Result + MK_LBUTTON;
  if ssRight  in AState then Result := Result + MK_RBUTTON;
  if ssMiddle in AState then Result := Result + MK_MBUTTON;
  ReflectState;
end;

class function Ts0ControlHelper.ShiftStateToKeyboardState(
  AState: TShiftState): TKeyboardState;
var
  i: Integer;
begin
  for i := Low(Result) to High(Result) do
    Result[i] := 0;
  if ssShift  in AState then KeyStateOn(Result[VK_SHIFT  ]) else KeyStateOff(Result[VK_SHIFT  ]);
  if ssCtrl   in AState then KeyStateOn(Result[VK_CONTROL]) else KeyStateOff(Result[VK_CONTROL]);
  if ssAlt    in AState then KeyStateOn(Result[VK_MENU   ]) else KeyStateOff(Result[VK_MENU   ]);
  if ssLeft   in AState then KeyStateOn(Result[VK_LBUTTON]) else KeyStateOff(Result[VK_LBUTTON]);
  if ssRight  in AState then KeyStateOn(Result[VK_RBUTTON]) else KeyStateOff(Result[VK_RBUTTON]);
  if ssMiddle in AState then KeyStateOn(Result[VK_MBUTTON]) else KeyStateOff(Result[VK_MBUTTON]);
end;

class function Ts0ControlHelper.ShiftStateToKeyData(
  AState: TShiftState; AReflect: Boolean): Longint;
  procedure ReflectState;
  var
    keys: TKeyboardState;
  begin
    if not AReflect then Exit;
    GetKeyboardState(keys);
    if ssShift in AState then KeyStateOn(keys[VK_SHIFT  ]) else KeyStateOff(keys[VK_SHIFT  ]);
    if ssCtrl  in AState then KeyStateOn(keys[VK_CONTROL]) else KeyStateOff(keys[VK_CONTROL]);
    SetKeyboardState(keys);
  end;
const
  c9AltMask = $20000000;
begin
  Result := 0;
  if ssAlt in AState then Result := c9AltMask;
  ReflectState;
end;

class procedure Ts0ControlHelper.KeyStateOff(var AKeyState: Byte);
begin
  case AKeyState of
    128: AKeyState := 0;
    129: AKeyState := 1;
  end;
end;

class procedure Ts0ControlHelper.KeyStateOn(var AKeyState: Byte);
begin
  case AKeyState of
    0: AKeyState := 129;
    1: AKeyState := 128;
  end;
end;

class procedure Ts0ControlHelper.ChangeNextState(var AKeyState: Byte);
begin
  case AKeyState of
      0: AKeyState := 129;
      1: AKeyState := 128;
    128: AKeyState :=   0;
    129: AKeyState :=   1;
  end;
end;

end.

