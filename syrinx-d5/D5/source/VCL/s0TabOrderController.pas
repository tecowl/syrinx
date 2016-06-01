unit s0TabOrderController;
{
$History: s0TabOrderController.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/05   Time: 4:34
 * Updated in $/source/D5Integrated
 * フォーカスの移動は、KeyUp時に行うようにした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/07   Time: 14:35
 * Updated in $/source/D5Integrated
}

interface

uses
  Windows, Messages,
  SysUtils, Classes, Controls,
  s0VCLClasses;

type
  K0BtnFocusMoveType = (
    k0bfmtNone,
    k0bfmtIgnoreEnter,
    k0bfmtMoveWithoutAccept,
    k0bfmtMoveAfterAccept
    );

type
  Ts0TabOrderController = class(Ts0VCLPersistent)
  private
    FMoveFocusOnEnterKey: Boolean;
    FMoveFocusTypeOnBtnEnter: K0BtnFocusMoveType;
    procedure SetMoveFocusOnEnterKey(const Value: Boolean);
  protected
    function ValidateKeyDownParam(Sender: TWinControl; var Key: Word; Shift: TShiftState): Boolean;
  public
    constructor Create; reintroduce;
    procedure MoveFocus(AControl: TWinControl);
    procedure KeyDown(Sender: TWinControl; var Key: Word; Shift: TShiftState);
    procedure KeyUp(Sender: TWinControl; var Key: Word; Shift: TShiftState);
    procedure BtnKeyDown(Sender: TWinControl; var Key: Word; Shift: TShiftState);
    procedure BtnKeyUp(Sender: TWinControl; var Key: Word; Shift: TShiftState);
    class function Instance: Ts0TabOrderController;
  published
    property MoveFocusOnEnterKey: Boolean read FMoveFocusOnEnterKey write
      SetMoveFocusOnEnterKey default True;
    property MoveFocusTypeOnBtnEnter: K0BtnFocusMoveType read FMoveFocusTypeOnBtnEnter write FMoveFocusTypeOnBtnEnter;
  end;

implementation

uses
  Forms;
  
{ Ts0TabOrderController }

procedure Ts0TabOrderController.BtnKeyDown(Sender: TWinControl;
  var Key: Word; Shift: TShiftState);
begin
  if not ValidateKeyDownParam(Sender, Key, Shift) then Exit;
  case FMoveFocusTypeOnBtnEnter of
    k0bfmtNone: ;
    k0bfmtIgnoreEnter: Key := 0;
    k0bfmtMoveWithoutAccept:
    begin
      MoveFocus(Sender);
      Key := 0;
    end;
    k0bfmtMoveAfterAccept: ;
  end;
end;

procedure Ts0TabOrderController.BtnKeyUp(Sender: TWinControl; var Key: Word;
  Shift: TShiftState);
begin
  if not ValidateKeyDownParam(Sender, Key, Shift) then Exit;
  case FMoveFocusTypeOnBtnEnter of
    k0bfmtNone: ;
    k0bfmtIgnoreEnter: ;
    k0bfmtMoveWithoutAccept: ;
    k0bfmtMoveAfterAccept:
    begin
      MoveFocus(Sender);
      Key := 0;
    end;
  end;
end;

constructor Ts0TabOrderController.Create;
begin
  inherited Create(nil);
  FMoveFocusOnEnterKey := False;
  FMoveFocusTypeOnBtnEnter := k0bfmtMoveAfterAccept;
end;

var
  g9TabController: Ts0TabOrderController = nil;

class function Ts0TabOrderController.Instance: Ts0TabOrderController;
begin
  if g9TabController = nil then
    g9TabController := Ts0TabOrderController.Create;
  Result := g9TabController;
end;

procedure Ts0TabOrderController.KeyDown(Sender: TWinControl; var Key: Word;
  Shift: TShiftState);
begin
end;

procedure Ts0TabOrderController.KeyUp(Sender: TWinControl; var Key: Word;
  Shift: TShiftState);
begin
  if not ValidateKeyDownParam(Sender, Key, Shift) then Exit;
  if not FMoveFocusOnEnterKey then Exit;
  Key := 0;
  MoveFocus(Sender);
end;

procedure Ts0TabOrderController.MoveFocus(AControl: TWinControl);
var
  f: TCustomForm;
begin
  f := GetParentForm(AControl);
  if f = nil then Exit;
  SendMessage(f.Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure Ts0TabOrderController.SetMoveFocusOnEnterKey(
  const Value: Boolean);
begin
  if FMoveFocusOnEnterKey = Value then Exit;
  FMoveFocusOnEnterKey := Value;
  if FMoveFocusOnEnterKey then
    FMoveFocusTypeOnBtnEnter := k0bfmtMoveAfterAccept
  else
    FMoveFocusTypeOnBtnEnter := k0bfmtNone;
end;

function Ts0TabOrderController.ValidateKeyDownParam(Sender: TWinControl;
  var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := False;
  if Sender = nil then Exit;
  if Key <> VK_RETURN then Exit;
  Result := True;
end;

initialization

finalization
  FreeAndNil(g9TabController);

end.
