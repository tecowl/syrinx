unit s0Panel;
{
$History: s0Panel.pas $
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
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/25   Time: 1:54
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,
  s0CtrlDistiller;

type
  Ts0CustomPanel = class(TPanel)
  private
  protected
  public
  published
  end;

type
  Ts0Panel = class(Ts0CustomPanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

type
  Ts0PanelDistiller = class(Ts0CtrlDistiller)
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
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

{ Ts0PanelDistiller }

class procedure Ts0PanelDistiller.Click(AControl: TObject);
begin
  Ts0CustomPanel(AControl).Click;
end;

class function Ts0PanelDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0CustomPanel(AControl).Color;
end;

class function Ts0PanelDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0CustomPanel(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomPanel(AControl).OnExit ;
end;

class function Ts0PanelDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0CustomPanel(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomPanel(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomPanel(AControl).OnKeyUp   ;
  Result.FOnChange   := nil;
end;

class function Ts0PanelDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0CustomPanel(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0CustomPanel(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0CustomPanel(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomPanel(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomPanel(AControl).OnMouseUp  ;
end;

class function Ts0PanelDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CustomPanel(AControl).OnCanResize;
  Result.FOnResize    := Ts0CustomPanel(AControl).OnResize   ;
end;

class function Ts0PanelDistiller.GetTitle(AControl: TObject): string;
begin
  Result := Ts0CustomPanel(AControl).Caption;
end;

class function Ts0PanelDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0PanelDistiller.GetValue(AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0PanelDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CustomPanel;
end;

class procedure Ts0PanelDistiller.KeyDown(AControl: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Ts0CustomPanel(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0PanelDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomPanel(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0PanelDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomPanel(AControl).Color := AColor;
end;

class procedure Ts0PanelDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Value.FOnEnter := Ts0CustomPanel(AControl).OnEnter;
  Value.FOnExit  := Ts0CustomPanel(AControl).OnExit ;
end;

class procedure Ts0PanelDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomPanel(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomPanel(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomPanel(AControl).OnKeyUp    := Value.FOnKeyUp   ;
end;

class procedure Ts0PanelDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomPanel(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomPanel(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomPanel(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomPanel(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomPanel(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0PanelDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomPanel(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomPanel(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0PanelDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  Ts0CustomPanel(AControl).Caption := Value;
end;

class procedure Ts0PanelDistiller.SetValue(Value: string;
  AControl: TObject);
begin
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0PanelDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0PanelDistiller);

end.

