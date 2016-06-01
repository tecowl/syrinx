unit s0VCLExtCtrlsDistiller;

interface

uses
  SysUtils, Classes, Controls, Graphics, ExtCtrls,
  s0CtrlDistiller;

type
  Ts0VCLShapeDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
  end;

type
  Ts0VCLPaintBoxDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class function GetCanvas(AControl: TObject): TCanvas; override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0VCLImageDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class function GetCanvas(AControl: TObject): TCanvas; override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0VCLBevelDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
  end;

type
  Ts0VCLPanelDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0VCLRadioGroupDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0VCLSplitterDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class function GetCanvas(AControl: TObject): TCanvas; override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Ts0VCLControlBarDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetCanvas(AControl: TObject): TCanvas; override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;


implementation

{ Ts0VCLShapeDistiller }

class function Ts0VCLShapeDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick := nil;
  Result.FOnDblClick := nil;
  Result.FOnMouseDown := TShape(AControl).OnMouseDown;
  Result.FOnMouseMove := TShape(AControl).OnMouseMove;
  Result.FOnMouseUp   := TShape(AControl).OnMouseUp  ;
end;

class function Ts0VCLShapeDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0VCLShapeDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is TShape;
end;

class procedure Ts0VCLShapeDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TShape(AControl).OnMouseDown := Value.FOnMouseDown;
  TShape(AControl).OnMouseMove := Value.FOnMouseMove;
  TShape(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

{ Ts0VCLPaintBoxDistiller }

class function Ts0VCLPaintBoxDistiller.GetCanvas(
  AControl: TObject): TCanvas;
begin
  Result := TPaintBox(AControl).Canvas;
end;

class function Ts0VCLPaintBoxDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TPaintBox(AControl).Color;
end;

class function Ts0VCLPaintBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := TPaintBox(AControl).OnClick    ;
  Result.FOnDblClick  := TPaintBox(AControl).OnDblClick ;
  Result.FOnMouseDown := TPaintBox(AControl).OnMouseDown;
  Result.FOnMouseMove := TPaintBox(AControl).OnMouseMove;
  Result.FOnMouseUp   := TPaintBox(AControl).OnMouseUp  ;
end;

class function Ts0VCLPaintBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0VCLPaintBoxDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is TPaintBox;
end;

class procedure Ts0VCLPaintBoxDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TPaintBox(AControl).Color := AColor;
end;

class procedure Ts0VCLPaintBoxDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TPaintBox(AControl).OnClick     := Value.FOnClick    ;
  TPaintBox(AControl).OnDblClick  := Value.FOnDblClick ;
  TPaintBox(AControl).OnMouseDown := Value.FOnMouseDown;
  TPaintBox(AControl).OnMouseMove := Value.FOnMouseMove;
  TPaintBox(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

{ Ts0VCLImageDistiller }

class function Ts0VCLImageDistiller.GetCanvas(AControl: TObject): TCanvas;
begin
  Result := TImage(AControl).Canvas;
end;

class function Ts0VCLImageDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TImage(AControl).Canvas.Brush.Color;
end;

class function Ts0VCLImageDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := TImage(AControl).OnClick    ;
  Result.FOnDblClick  := TImage(AControl).OnDblClick ;
  Result.FOnMouseDown := TImage(AControl).OnMouseDown;
  Result.FOnMouseMove := TImage(AControl).OnMouseMove;
  Result.FOnMouseUp   := TImage(AControl).OnMouseUp  ;
end;

class function Ts0VCLImageDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0VCLImageDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is TImage;
end;

class procedure Ts0VCLImageDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TImage(AControl).Canvas.Brush.Color := AColor;
end;

class procedure Ts0VCLImageDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TImage(AControl).OnClick     := Value.FOnClick    ;
  TImage(AControl).OnDblClick  := Value.FOnDblClick ;
  TImage(AControl).OnMouseDown := Value.FOnMouseDown;
  TImage(AControl).OnMouseMove := Value.FOnMouseMove;
  TImage(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

{ Ts0VCLBevelDistiller }


class function Ts0VCLBevelDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0VCLBevelDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is TBevel;
end;

{ Ts0VCLPanelDistiller }

class function Ts0VCLPanelDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := TPanel(AControl).Color;
end;

class function Ts0VCLPanelDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := TPanel(AControl).OnEnter;
  Result.FOnExit  := TPanel(AControl).OnExit ;
end;

class function Ts0VCLPanelDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := TPanel(AControl).OnClick    ;
  Result.FOnDblClick  := TPanel(AControl).OnDblClick ;
  Result.FOnMouseDown := TPanel(AControl).OnMouseDown;
  Result.FOnMouseMove := TPanel(AControl).OnMouseMove;
  Result.FOnMouseUp   := TPanel(AControl).OnMouseUp  ;
end;

class function Ts0VCLPanelDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := TPanel(AControl).OnCanResize;
  Result.FOnResize    := TPanel(AControl).OnResize   ;
end;

class function Ts0VCLPanelDistiller.GetTitle(AControl: TObject): string;
begin
  Result := TPanel(AControl).Caption;
end;

class function Ts0VCLPanelDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0VCLPanelDistiller.GetValue(AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0VCLPanelDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is TPanel;
end;

class procedure Ts0VCLPanelDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TPanel(AControl).Color := AColor;
end;

class procedure Ts0VCLPanelDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  TPanel(AControl).OnEnter := Value.FOnEnter;
  TPanel(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0VCLPanelDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  TPanel(AControl).OnClick     := Value.FOnClick    ;
  TPanel(AControl).OnDblClick  := Value.FOnDblClick ;
  TPanel(AControl).OnMouseDown := Value.FOnMouseDown;
  TPanel(AControl).OnMouseMove := Value.FOnMouseMove;
  TPanel(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0VCLPanelDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  TPanel(AControl).OnCanResize := Value.FOnCanResize;
  TPanel(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0VCLPanelDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  TPanel(AControl).Caption := Value;

end;

class procedure Ts0VCLPanelDistiller.SetValue(Value: string;
  AControl: TObject);
begin
end;

{ Ts0VCLRadioGroupDistiller }

class function Ts0VCLRadioGroupDistiller.GetColor(
  AControl: TObject): TColor;
begin
  Result := TRadioGroup(AControl).Color;
end;

class function Ts0VCLRadioGroupDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := TRadioGroup(AControl).OnEnter;
  Result.FOnExit  := TRadioGroup(AControl).OnExit ;
end;

class function Ts0VCLRadioGroupDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := TRadioGroup(AControl).OnClick   ;
  Result.FOnDblClick  := nil;
  Result.FOnMouseDown := nil;
  Result.FOnMouseMove := nil;
  Result.FOnMouseUp   := nil;
end;

class function Ts0VCLRadioGroupDistiller.GetTitle(
  AControl: TObject): string;
begin
  Result := TRadioGroup(AControl).Caption;
end;

class function Ts0VCLRadioGroupDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnClick];
end;

class function Ts0VCLRadioGroupDistiller.GetValue(
  AControl: TObject): string;
begin
  Result := TRadioGroup(AControl).Items.Strings[TRadioGroup(AControl).ItemIndex];
end;

class function Ts0VCLRadioGroupDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := AControl is TRadioGroup;
end;

class procedure Ts0VCLRadioGroupDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TRadioGroup(AControl).Color := AColor;
end;

class procedure Ts0VCLRadioGroupDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  TRadioGroup(AControl).OnEnter := Value.FOnEnter;
  TRadioGroup(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0VCLRadioGroupDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  TRadioGroup(AControl).OnClick := Value.FOnClick;
end;

class procedure Ts0VCLRadioGroupDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  TRadioGroup(AControl).Caption := Value;
end;

class procedure Ts0VCLRadioGroupDistiller.SetValue(Value: string;
  AControl: TObject);
var
  idx: Integer;
  rdg: TRadioGroup;
begin
  rdg := TRadioGroup(AControl);
  idx := rdg.Items.IndexOf(Value);
  if idx > -1 then
    rdg.ItemIndex := idx
  else
    rdg.ItemIndex := StrToIntDef(Value, -1);
end;

{ Ts0VCLSplitterDistiller }

class function Ts0VCLSplitterDistiller.GetCanvas(
  AControl: TObject): TCanvas;
begin
  Result := TSplitter(AControl).Canvas;
end;

class function Ts0VCLSplitterDistiller.GetColor(AControl: TObject): TColor;
begin
  Result := TSplitter(AControl).Color;
end;

class function Ts0VCLSplitterDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := nil;
  Result.FOnKeyPress := nil;
  Result.FOnKeyUp    := nil;
  Result.FOnChange := TSplitter(AControl).OnMoved;
end;

class function Ts0VCLSplitterDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnChange];
end;

class function Ts0VCLSplitterDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is TSplitter;
end;

class procedure Ts0VCLSplitterDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TSplitter(AControl).Color := AColor;
end;

class procedure Ts0VCLSplitterDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  TSplitter(AControl).OnMoved := Value.FOnChange;
end;

{ Ts0VCLControlBarDistiller }

class function Ts0VCLControlBarDistiller.GetCanvas(
  AControl: TObject): TCanvas;
begin
  Result := TControlBar(AControl).Canvas;
end;

class function Ts0VCLControlBarDistiller.GetColor(
  AControl: TObject): TColor;
begin
	Result := TControlBar(AControl).Color;
end;

class function Ts0VCLControlBarDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := TControlBar(AControl).OnEnter;
  Result.FOnExit  := TControlBar(AControl).OnExit ;
end;

class function Ts0VCLControlBarDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := TControlBar(AControl).OnClick    ;
  Result.FOnDblClick  := TControlBar(AControl).OnDblClick ;
  Result.FOnMouseDown := TControlBar(AControl).OnMouseDown;
  Result.FOnMouseMove := TControlBar(AControl).OnMouseMove;
  Result.FOnMouseUp   := TControlBar(AControl).OnMouseUp  ;
end;

class function Ts0VCLControlBarDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := TControlBar(AControl).OnCanResize;
  Result.FOnResize    := TControlBar(AControl).OnResize   ;
end;

class function Ts0VCLControlBarDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0VCLControlBarDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := AControl is TControlBar;
end;

class procedure Ts0VCLControlBarDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  TControlBar(AControl).Color := AColor;
end;

class procedure Ts0VCLControlBarDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  TControlBar(AControl).OnEnter := Value.FOnEnter;
  TControlBar(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0VCLControlBarDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  TControlBar(AControl).OnClick     := Value.FOnClick    ;
  TControlBar(AControl).OnDblClick  := Value.FOnDblClick ;
  TControlBar(AControl).OnMouseDown := Value.FOnMouseDown;
  TControlBar(AControl).OnMouseMove := Value.FOnMouseMove;
  TControlBar(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0VCLControlBarDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  TControlBar(AControl).OnCanResize := Value.FOnCanResize;
  TControlBar(AControl).OnResize    := Value.FOnResize   ;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLShapeDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLPaintBoxDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLImageDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLBevelDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLPanelDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLRadioGroupDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLSplitterDistiller);
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0VCLControlBarDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLShapeDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLPaintBoxDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLImageDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLBevelDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLPanelDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLRadioGroupDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLSplitterDistiller);
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0VCLControlBarDistiller);

end.
