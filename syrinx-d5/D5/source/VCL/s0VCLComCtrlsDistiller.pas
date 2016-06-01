unit s0VCLComCtrlsDistiller;

interface

uses
  SysUtils, Classes, Controls, Graphics, ComCtrls,
  s0CtrlDistiller;

type
  Ts0VCLTabControlDistiller = class(Ts0CtrlDistiller)
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
    class function GetCanvas(AControl: TObject): TCanvas; override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

{ Ts0VCLTabControlDistiller }

class function Ts0VCLTabControlDistiller.GetCanvas(
  AControl: TObject): TCanvas;
begin
  Result := TTabControl(AControl).Canvas;
end;

class function Ts0VCLTabControlDistiller.GetColor(
  AControl: TObject): TColor;
begin
	Result := TTabControl(AControl).Canvas.Brush.Color;
end;

class function Ts0VCLTabControlDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := TTabControl(AControl).OnEnter;
  Result.FOnExit  := TTabControl(AControl).OnExit ;
end;

class function Ts0VCLTabControlDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := nil;
  Result.FOnKeyPress := nil;
  Result.FOnKeyUp    := nil;
  Result.FOnChange   := TTabControl(AControl).OnChange;
end;

class function Ts0VCLTabControlDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := nil;
  Result.FOnDblClick  := nil;
  Result.FOnMouseDown  := TTabControl(AControl).OnMouseDown;
  Result.FOnMouseMove  := TTabControl(AControl).OnMouseMove;
  Result.FOnMouseUp    := TTabControl(AControl).OnMouseUp  ;
end;

class function Ts0VCLTabControlDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize  := nil;
  Result.FOnResize     := TTabControl(AControl).OnResize;
end;

class function Ts0VCLTabControlDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnChange];
end;

class function Ts0VCLTabControlDistiller.GetValue(
  AControl: TObject): string;
begin
  Result := IntToStr( TTabControl(AControl).TabIndex );
end;

class function Ts0VCLTabControlDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := AControl is TTabControl;
end;

class procedure Ts0VCLTabControlDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TTabControl(AControl).Canvas.Brush.Color := AColor;
end;

class procedure Ts0VCLTabControlDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  TTabControl(AControl).OnEnter := Value.FOnEnter;
  TTabControl(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0VCLTabControlDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TTabControl(AControl).OnChange := Value.FOnChange;
end;

class procedure Ts0VCLTabControlDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  TTabControl(AControl).OnMouseDown := Value.FOnMouseDown;
  TTabControl(AControl).OnMouseMove := Value.FOnMouseMove;
  TTabControl(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0VCLTabControlDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  TTabControl(AControl).OnResize := Value.FOnResize;
end;

class procedure Ts0VCLTabControlDistiller.SetValue(Value: string;
  AControl: TObject);
var
  idx: Integer;
begin
  idx := StrToIntDef(Value, -1);
  if idx > -1 then
    TTabControl(AControl).TabIndex := idx;
end;

end.
