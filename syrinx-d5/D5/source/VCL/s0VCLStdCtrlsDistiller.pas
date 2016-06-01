unit s0VCLStdCtrlsDistiller;
{
$History: s0VCLStdCtrlsDistiller.pas $
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
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes, StdCtrls, Graphics, 
  s0CtrlDistiller;


type
  Ts0EditDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0MemoDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0ComboBoxDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0ButtonDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
  end;

type
  Ts0CheckBoxDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0LabelDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0ListBoxDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0StaticTextDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

uses
  s0CheckBoxHelper,
  s0TypeConvertor;

{ Ts0EditDistiller }

class function Ts0EditDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TEdit(AControl).Color;
end;

class function Ts0EditDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := TEdit(AControl).OnEnter;
  Result.FOnExit  := TEdit(AControl).OnExit;
end;

class function Ts0EditDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := TEdit(AControl).OnKeyDown;
  Result.FOnKeyPress := TEdit(AControl).OnKeyPress;
  Result.FOnKeyUp    := TEdit(AControl).OnKeyUp;
  Result.FOnChange   := TEdit(AControl).OnChange;
end;

class function Ts0EditDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TEdit(AControl).OnClick;
  Result.FOnDblClick  := TEdit(AControl).OnDblClick;
  Result.FOnMouseDown := TEdit(AControl).OnMouseDown;
  Result.FOnMouseMove := TEdit(AControl).OnMouseMove;
  Result.FOnMouseUp   := TEdit(AControl).OnMouseUp;
end;

class function Ts0EditDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := TEdit(AControl).OnCanChange;
//  Result.FOnResize    := TEdit(AControl).OnChange;
end;

class function Ts0EditDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0EditDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0EditDistiller.GetValue(AControl: TObject): string;
begin
  Result := TEdit(AControl).Text;
end;

class function Ts0EditDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TEdit);
end;

class procedure Ts0EditDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TEdit(AControl).Color := AColor;
end;

class procedure Ts0EditDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  TEdit(AControl).OnEnter := Value.FOnEnter;
  TEdit(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0EditDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TEdit(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TEdit(AControl).OnKeyPress := Value.FOnKeyPress;
  TEdit(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  TEdit(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0EditDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TEdit(AControl).OnClick     := Value.FOnClick    ;
  TEdit(AControl).OnDblClick  := Value.FOnDblClick ;
  TEdit(AControl).OnMouseDown := Value.FOnMouseDown;
  TEdit(AControl).OnMouseMove := Value.FOnMouseMove;
  TEdit(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0EditDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0EditDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0EditDistiller.SetValue(Value: string; AControl: TObject);
begin
  TEdit(AControl).Text := Value;
end;


{ Ts0MemoDistiller }

class function Ts0MemoDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TMemo(AControl).Color;
end;

class function Ts0MemoDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := TMemo(AControl).OnEnter;
  Result.FOnExit  := TMemo(AControl).OnExit;
end;

class function Ts0MemoDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := TMemo(AControl).OnKeyDown;
  Result.FOnKeyPress := TMemo(AControl).OnKeyPress;
  Result.FOnKeyUp    := TMemo(AControl).OnKeyUp;
  Result.FOnChange   := TMemo(AControl).OnChange;
end;

class function Ts0MemoDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TMemo(AControl).OnClick;
  Result.FOnDblClick  := TMemo(AControl).OnDblClick;
  Result.FOnMouseDown := TMemo(AControl).OnMouseDown;
  Result.FOnMouseMove := TMemo(AControl).OnMouseMove;
  Result.FOnMouseUp   := TMemo(AControl).OnMouseUp;
end;

class function Ts0MemoDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := TEdit(AControl).OnCanChange;
//  Result.FOnResize    := TEdit(AControl).OnChange;
end;

class function Ts0MemoDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0MemoDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0MemoDistiller.GetValue(AControl: TObject): string;
begin
  Result := TMemo(AControl).Text;
end;

class function Ts0MemoDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TMemo);
end;

class procedure Ts0MemoDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TMemo(AControl).Color := AColor;
end;

class procedure Ts0MemoDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  TMemo(AControl).OnEnter := Value.FOnEnter;
  TMemo(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0MemoDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TMemo(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TMemo(AControl).OnKeyPress := Value.FOnKeyPress;
  TMemo(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  TMemo(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0MemoDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TMemo(AControl).OnClick     := Value.FOnClick    ;
  TMemo(AControl).OnDblClick  := Value.FOnDblClick ;
  TMemo(AControl).OnMouseDown := Value.FOnMouseDown;
  TMemo(AControl).OnMouseMove := Value.FOnMouseMove;
  TMemo(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0MemoDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0MemoDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0MemoDistiller.SetValue(Value: string; AControl: TObject);
begin
  TMemo(AControl).Text := Value;
end;

{ Ts0ComboBoxDistiller }

class function Ts0ComboBoxDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TComboBox(AControl).Color;
end;

class function Ts0ComboBoxDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := TComboBox(AControl).OnEnter;
  Result.FOnExit  := TComboBox(AControl).OnExit;
end;

class function Ts0ComboBoxDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := TComboBox(AControl).OnKeyDown;
  Result.FOnKeyPress := TComboBox(AControl).OnKeyPress;
  Result.FOnKeyUp    := TComboBox(AControl).OnKeyUp;
  Result.FOnChange   := TComboBox(AControl).OnChange;
end;

class function Ts0ComboBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TComboBox(AControl).OnClick;
  Result.FOnDblClick  := TComboBox(AControl).OnDblClick;
{
  Result.FOnMouseDown := TComboBox(AControl).nil;
  Result.FOnMouseMove := TComboBox(AControl).nil;
  Result.FOnMouseUp   := TComboBox(AControl).nil;
}
end;

class function Ts0ComboBoxDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := nil;
//  Result.FOnResize    := nil;
end;

class function Ts0ComboBoxDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0ComboBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0ComboBoxDistiller.GetValue(AControl: TObject): string;
begin
  Result := TComboBox(AControl).Text;
end;

class function Ts0ComboBoxDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TComboBox);
end;

class procedure Ts0ComboBoxDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TComboBox(AControl).Color := AColor;
end;

class procedure Ts0ComboBoxDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  TComboBox(AControl).OnEnter := Value.FOnEnter;
  TComboBox(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0ComboBoxDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TComboBox(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TComboBox(AControl).OnKeyPress := Value.FOnKeyPress;
  TComboBox(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  TComboBox(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0ComboBoxDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TComboBox(AControl).OnClick     := Value.FOnClick    ;
  TComboBox(AControl).OnDblClick  := Value.FOnDblClick ;
{
  TComboBox(AControl).OnMouseDown := Value.FOnMouseDown;
  TComboBox(AControl).OnMouseMove := Value.FOnMouseMove;
  TComboBox(AControl).OnMouseUp   := Value.FOnMouseUp  ;
}
end;

class procedure Ts0ComboBoxDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0ComboBoxDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0ComboBoxDistiller.SetValue(Value: string; AControl: TObject);
begin
  TComboBox(AControl).Text := Value;
end;

{ Ts0ButtonDistiller }

class function Ts0ButtonDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := TButton(AControl).OnEnter;
  Result.FOnExit  := TButton(AControl).OnExit;
end;

class function Ts0ButtonDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := TButton(AControl).OnKeyDown;
  Result.FOnKeyPress := TButton(AControl).OnKeyPress;
  Result.FOnChange   := nil; //TButton(AControl).OnChange;
end;

class function Ts0ButtonDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TButton(AControl).OnClick;
  //Result.FOnDblClick  := nil;
  Result.FOnMouseDown := TButton(AControl).OnMouseDown;
  Result.FOnMouseMove := TButton(AControl).OnMouseMove;
  Result.FOnMouseUp   := TButton(AControl).OnMouseUp;
end;

class function Ts0ButtonDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := nil;
//  Result.FOnResize    := nil;
end;

class function Ts0ButtonDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0ButtonDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0ButtonDistiller.GetValue(AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0ButtonDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TButton);
end;

class procedure Ts0ButtonDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  TButton(AControl).OnEnter := Value.FOnEnter;
  TButton(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0ButtonDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TButton(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TButton(AControl).OnKeyPress := Value.FOnKeyPress;
  TButton(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  //TButton(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0ButtonDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TButton(AControl).OnClick     := Value.FOnClick    ;
  //TButton(AControl).OnDblClick  := Value.FOnDblClick ;
  TButton(AControl).OnMouseDown := Value.FOnMouseDown;
  TButton(AControl).OnMouseMove := Value.FOnMouseMove;
  TButton(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0ButtonDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0ButtonDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0ButtonDistiller.SetValue(Value: string; AControl: TObject);
begin
  //TButton(AControl).Caption := Value;
end;

{ Ts0CheckBoxDistiller }

class function Ts0CheckBoxDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TCheckBox(AControl).Color;
end;

class function Ts0CheckBoxDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := TCheckBox(AControl).OnEnter;
  Result.FOnExit  := TCheckBox(AControl).OnExit;
end;

class function Ts0CheckBoxDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := TCheckBox(AControl).OnKeyDown;
  Result.FOnKeyPress := TCheckBox(AControl).OnKeyPress;
  Result.FOnKeyUp    := TCheckBox(AControl).OnKeyUp;
  Result.FOnChange   := nil; //TCheckBox(AControl).Onchange;
end;

class function Ts0CheckBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TCheckBox(AControl).OnClick;
  //Result.FOnDblClick  := TCheckBox(AControl).OnDblClick;
  Result.FOnMouseDown := TCheckBox(AControl).OnMouseDown;
  Result.FOnMouseMove := TCheckBox(AControl).OnMouseMove;
  Result.FOnMouseUp   := TCheckBox(AControl).OnMouseUp;
end;

class function Ts0CheckBoxDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := nil;
//  Result.FOnResize    := nil;
end;

class function Ts0CheckBoxDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0CheckBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0CheckBoxDistiller.GetValue(AControl: TObject): string;
begin
  Result := Ts0CheckBoxHelper.StateToStr(TCheckBox(AControl).State);
end;

class function Ts0CheckBoxDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TCheckBox);
end;

class procedure Ts0CheckBoxDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TCheckBox(AControl).Color := AColor;
end;

class procedure Ts0CheckBoxDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  TCheckBox(AControl).OnEnter := Value.FOnEnter;
  TCheckBox(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0CheckBoxDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TCheckBox(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TCheckBox(AControl).OnKeyPress := Value.FOnKeyPress;
  TCheckBox(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  //TCheckBox(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0CheckBoxDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TCheckBox(AControl).OnClick     := Value.FOnClick    ;
  //TCheckBox(AControl).OnDblClick  := Value.FOnDblClick ;
  TCheckBox(AControl).OnMouseDown := Value.FOnMouseDown;
  TCheckBox(AControl).OnMouseMove := Value.FOnMouseMove;
  TCheckBox(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0CheckBoxDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0CheckBoxDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0CheckBoxDistiller.SetValue(Value: string; AControl: TObject);
begin
  TCheckBox(AControl).State := Ts0CheckBoxHelper.StrToState(Value);
end;

{ Ts0LabelDistiller }

class function Ts0LabelDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TLabel(AControl).Color;
end;

class function Ts0LabelDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
{
  Result.FOnEnter := TLabel(AControl).OnEnter;
  Result.FOnExit  := TLabel(AControl).OnExit;
}
end;

class function Ts0LabelDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
{
  Result.FOnKeyDown  := TLabel(AControl).OnKeyDown;
  Result.FOnKeyPress := TLabel(AControl).OnKeyPress;
  Result.FOnKeyUp    := TLabel(AControl).OnKeyUp;
  Result.FOnChange   := TLabel(AControl).OnChange;
}
end;

class function Ts0LabelDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TLabel(AControl).OnClick;
  Result.FOnDblClick  := TLabel(AControl).OnDblClick;
  Result.FOnMouseDown := TLabel(AControl).OnMouseDown;
  Result.FOnMouseMove := TLabel(AControl).OnMouseMove;
  Result.FOnMouseUp   := TLabel(AControl).OnMouseUp;
end;

class function Ts0LabelDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := nil;
//  Result.FOnResize    := nil;
end;

class function Ts0LabelDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0LabelDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0LabelDistiller.GetValue(AControl: TObject): string;
begin
  Result := TLabel(AControl).Caption;
end;

class function Ts0LabelDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TLabel);
end;

class procedure Ts0LabelDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TLabel(AControl).Color := AColor;
end;

class procedure Ts0LabelDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
{
  TLabel(AControl).OnEnter := Value.FOnEnter;
  TLabel(AControl).OnExit  := Value.FOnExit ;
}
end;

class procedure Ts0LabelDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
{
  TLabel(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TLabel(AControl).OnKeyPress := Value.FOnKeyPress;
  TLabel(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  TLabel(AControl).OnChange   := Value.FOnChange  ;
}
end;

class procedure Ts0LabelDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TLabel(AControl).OnClick     := Value.FOnClick    ;
  TLabel(AControl).OnDblClick  := Value.FOnDblClick ;
  TLabel(AControl).OnMouseDown := Value.FOnMouseDown;
  TLabel(AControl).OnMouseMove := Value.FOnMouseMove;
  TLabel(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0LabelDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0LabelDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0LabelDistiller.SetValue(Value: string; AControl: TObject);
begin
  TLabel(AControl).Caption := Value;
end;

{ Ts0ListBoxDistiller }

class function Ts0ListBoxDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TListBox(AControl).Color;
end;

class function Ts0ListBoxDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := TListBox(AControl).OnEnter;
  Result.FOnExit  := TListBox(AControl).OnExit;
end;

class function Ts0ListBoxDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := TListBox(AControl).OnKeyDown;
  Result.FOnKeyPress := TListBox(AControl).OnKeyPress;
  Result.FOnKeyUp    := TListBox(AControl).OnKeyUp;
//  Result.FOnChange    := TListBox(AControl).OnChange;
end;

class function Ts0ListBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TListBox(AControl).OnClick;
  Result.FOnDblClick  := TListBox(AControl).OnDblClick;
  Result.FOnMouseDown := TListBox(AControl).OnMouseDown;
  Result.FOnMouseMove := TListBox(AControl).OnMouseMove;
  Result.FOnMouseUp   := TListBox(AControl).OnMouseUp;
end;

class function Ts0ListBoxDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := nil;
//  Result.FOnResize    := nil;
end;

class function Ts0ListBoxDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0ListBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0ListBoxDistiller.GetValue(AControl: TObject): string;
begin
  Result := TListBox(AControl).Items.Text;
end;

class function Ts0ListBoxDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TListBox);
end;

class procedure Ts0ListBoxDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TListBox(AControl).Color := AColor;
end;

class procedure Ts0ListBoxDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  TListBox(AControl).OnEnter := Value.FOnEnter;
  TListBox(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0ListBoxDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TListBox(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TListBox(AControl).OnKeyPress := Value.FOnKeyPress;
  TListBox(AControl).OnKeyUp    := Value.FOnKeyUp   ;
//  TListBox(AControl).OnChange    := Value.FOnChange   ;
end;

class procedure Ts0ListBoxDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TListBox(AControl).OnClick     := Value.FOnClick    ;
  TListBox(AControl).OnDblClick  := Value.FOnDblClick ;
  TListBox(AControl).OnMouseDown := Value.FOnMouseDown;
  TListBox(AControl).OnMouseMove := Value.FOnMouseMove;
  TListBox(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0ListBoxDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0ListBoxDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0ListBoxDistiller.SetValue(Value: string; AControl: TObject);
begin
  TListBox(AControl).Items.Text := Value;
end;

{ Ts0StaticTextDistiller }

class function Ts0StaticTextDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TStaticText(AControl).Color;
end;

class function Ts0StaticTextDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
{
  Result.FOnEnter := TStaticText(AControl).OnEnter;
  Result.FOnExit  := TStaticText(AControl).OnExit;
}
end;

class function Ts0StaticTextDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
{
  Result.FOnKeyDown  := TStaticText(AControl).OnKeyDown;
  Result.FOnKeyPress := TStaticText(AControl).OnKeyPress;
  Result.FOnKeyUp    := TStaticText(AControl).OnKeyUp;
  Result.FOnChange    := TStaticText(AControl).OnChange;
}
end;

class function Ts0StaticTextDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := TStaticText(AControl).OnClick;
  Result.FOnDblClick  := TStaticText(AControl).OnDblClick;
  Result.FOnMouseDown := TStaticText(AControl).OnMouseDown;
  Result.FOnMouseMove := TStaticText(AControl).OnMouseMove;
  Result.FOnMouseUp   := TStaticText(AControl).OnMouseUp;
end;

class function Ts0StaticTextDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := nil;
//  Result.FOnResize    := nil;
end;

class function Ts0StaticTextDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0StaticTextDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := inherited GetUpdateEvents(AControl);
end;

class function Ts0StaticTextDistiller.GetValue(AControl: TObject): string;
begin
  Result := TStaticText(AControl).Caption;
end;

class function Ts0StaticTextDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is TStaticText);
end;

class procedure Ts0StaticTextDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TStaticText(AControl).Color := AColor;
end;

class procedure Ts0StaticTextDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
{
  TStaticText(AControl).OnEnter := Value.FOnEnter;
  TStaticText(AControl).OnExit  := Value.FOnExit ;
}
end;

class procedure Ts0StaticTextDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
{
  TStaticText(AControl).OnKeyDown  := Value.FOnKeyDown ;
  TStaticText(AControl).OnKeyPress := Value.FOnKeyPress;
  TStaticText(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  TStaticText(AControl).OnChange    := Value.FOnChange   ;
}
end;

class procedure Ts0StaticTextDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TStaticText(AControl).OnClick     := Value.FOnClick    ;
  TStaticText(AControl).OnDblClick  := Value.FOnDblClick ;
  TStaticText(AControl).OnMouseDown := Value.FOnMouseDown;
  TStaticText(AControl).OnMouseMove := Value.FOnMouseMove;
  TStaticText(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0StaticTextDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0StaticTextDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0StaticTextDistiller.SetValue(Value: string; AControl: TObject);
begin
  TStaticText(AControl).Caption := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0EditDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0MemoDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0ComboBoxDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0ButtonDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0CheckBoxDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0LabelDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0ListBoxDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0StaticTextDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0EditDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0MemoDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0ComboBoxDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0ButtonDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0CheckBoxDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0LabelDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0ListBoxDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0StaticTextDistiller);

end.
