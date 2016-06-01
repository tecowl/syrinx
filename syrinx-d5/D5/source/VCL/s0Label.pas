unit s0Label;
{
$History: s0Label.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/11   Time: 20:28
 * Updated in $/D6/source/VCL
 * Distillerを追加
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:28
 * Created in $/Projects/SDRFrameWork/src/lib0
 * 新規追加
 * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
 * VSSでは共有してません。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CtrlDistiller,
  StdCtrls;

type
  Ts0CustomLabel = class(TLabel)
  private
    FOnMouseEnter: TNotifyEvent;
    FOnMouseExit: TNotifyEvent;
    procedure CMMouseEnter(var msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseExit(var msg: TMessage); message CM_MOUSELEAVE;
  private
    FLikeAHyperLink: Boolean;
    FLinkColor: TColor;
    FColorBuf: TColor;
    FStyleBuf: TFontStyles;
    FLinkUnderLine: Boolean;
    FPerformingLink: Boolean;
    FLinkCursor: TCursor;
    FCursorBuf: TCursor;
    FLinkKeyShift: TShiftState;
  protected
    procedure DoMouseEnter;
    procedure DoMouseExit;
    function GetPerformingLink: Boolean;
    function GetLikeAHyperLink: Boolean;
    function GetLinkColor: TColor;
    function GetLinkUnderLine: Boolean;
    function GetLinkCursor: TCursor;
    function GetLinkKeyShift: TShiftState;
    procedure SetLikeAHyperLink(const Value: Boolean);
    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkUnderLine(const Value: Boolean);
    procedure SetLinkCursor(const Value: TCursor);
    procedure SetLinkKeyShift(const Value: TShiftState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PerformingLink: Boolean read GetPerformingLink;
    procedure PerformLinking;
    procedure PerformNormal;
  published
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
  published
    property LikeAHyperLink: Boolean read GetLikeAHyperLink write
      SetLikeAHyperLink default False;
    property LinkColor: TColor read GetLinkColor write SetLinkColor default
      clBlue;
    property LinkUnderLine: Boolean read GetLinkUnderLine write SetLinkUnderLine
      default True;
    property LinkCursor: TCursor read GetLinkCursor write SetLinkCursor default
      crHandPoint;
    property LinkKeyShift: TShiftState read GetLinkKeyShift write SetLinkKeyShift
      default [];
  end;

type
  Ts0Label = class(Ts0CustomLabel)
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
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
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

{ Ts0CustomLabel }

procedure Ts0CustomLabel.CMMouseEnter(var msg: TMessage);
begin
  inherited;
  if FLikeAHyperLink then
    PerformLinking;
  DoMouseEnter;
end;

procedure Ts0CustomLabel.CMMouseExit(var msg: TMessage);
begin
  DoMouseExit;
  if FLikeAHyperLink then
    PerformNormal;
  inherited;
end;

constructor Ts0CustomLabel.Create(AOwner: TComponent);
begin
  inherited;
  FLikeAHyperLink := False;
  FLinkColor := clBlue;
  FLinkUnderLine := True;
  FLinkCursor := crHandPoint;
  FLinkKeyShift := [];
end;

destructor Ts0CustomLabel.Destroy;
begin
  inherited;
end;

procedure Ts0CustomLabel.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure Ts0CustomLabel.DoMouseExit;
begin
  if Assigned(FOnMouseExit) then
    FOnMouseExit(Self);
end;

function Ts0CustomLabel.GetLikeAHyperLink: Boolean;
begin
  Result := FLikeAHyperLink;
end;

function Ts0CustomLabel.GetLinkColor: TColor;
begin
  Result := FLinkColor;
end;

function Ts0CustomLabel.GetLinkCursor: TCursor;
begin
  Result := FLinkCursor;
end;

function Ts0CustomLabel.GetLinkKeyShift: TShiftState;
begin
  Result := FLinkKeyShift;
end;

function Ts0CustomLabel.GetLinkUnderLine: Boolean;
begin
  Result := FLinkUnderLine;
end;

function Ts0CustomLabel.GetPerformingLink: Boolean;
begin
  Result := FPerformingLink;
end;

procedure Ts0CustomLabel.PerformLinking;
begin
  if FPerformingLink then
    Exit;
  FPerformingLink := True;
  //
  FColorBuf := Font.Color;
  Font.Color := FLinkColor;
  FStyleBuf := Font.Style;
  if FLinkUnderLine then
    Font.Style := Font.Style + [fsUnderline];
  FCursorBuf := Cursor;
  Cursor := FLinkCursor;
end;

procedure Ts0CustomLabel.PerformNormal;
begin
  if not FPerformingLink then
    Exit;
  FPerformingLink := False;
  //
  Font.Color := FColorBuf;
  if FLinkUnderLine then
    Font.Style := FStyleBuf;
  Cursor := FCursorBuf;
end;

procedure Ts0CustomLabel.SetLikeAHyperLink(const Value: Boolean);
begin
  FLikeAHyperLink := Value;
end;

procedure Ts0CustomLabel.SetLinkColor(const Value: TColor);
begin
  FLinkColor := Value;
end;

procedure Ts0CustomLabel.SetLinkCursor(const Value: TCursor);
begin
  FLinkCursor := Value;
end;

procedure Ts0CustomLabel.SetLinkKeyShift(const Value: TShiftState);
begin
  FLinkKeyShift := Value;
end;

procedure Ts0CustomLabel.SetLinkUnderLine(const Value: Boolean);
begin
  FLinkUnderLine := Value;
end;

{ Ts0LabelDistiller }

class procedure Ts0LabelDistiller.Click(AControl: TObject);
begin
  Ts0CustomLabel(AControl).Click;
end;

class function Ts0LabelDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0CustomLabel(AControl).Color;
end;

class function Ts0LabelDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
//  Result.FOnEnter := Ts0CustomLabel(AControl).OnEnter;
//  Result.FOnExit  := Ts0CustomLabel(AControl).OnExit ;
end;

class function Ts0LabelDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
//  Result.FOnKeyDown  := Ts0CustomLabel(AControl).OnKeyDown ;
//  Result.FOnKeyPress := Ts0CustomLabel(AControl).OnKeyPress;
//  Result.FOnKeyUp    := Ts0CustomLabel(AControl).OnKeyUp   ;
//  Result.FOnChange   := nil;
end;

class function Ts0LabelDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0CustomLabel(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0CustomLabel(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0CustomLabel(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomLabel(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomLabel(AControl).OnMouseUp  ;
end;

class function Ts0LabelDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CustomLabel(AControl).OnCanResize;
  Result.FOnResize    := Ts0CustomLabel(AControl).OnResize   ;
end;

class function Ts0LabelDistiller.GetTitle(AControl: TObject): string;
begin
  Result := Ts0CustomLabel(AControl).Caption;
end;

class function Ts0LabelDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0LabelDistiller.GetValue(AControl: TObject): string;
begin
  Result := Ts0CustomLabel(AControl).Caption;
end;

class function Ts0LabelDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CustomLabel;
end;

class procedure Ts0LabelDistiller.KeyDown(AControl: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  Ts0CustomLabel(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0LabelDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomLabel(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0LabelDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomLabel(AControl).Color := AColor;
end;

class procedure Ts0LabelDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
//  Value.FOnEnter := Ts0CustomLabel(AControl).OnEnter;
//  Value.FOnExit  := Ts0CustomLabel(AControl).OnExit ;
end;

class procedure Ts0LabelDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
//  Ts0CustomLabel(AControl).OnKeyDown  := Value.FOnKeyDown ;
//  Ts0CustomLabel(AControl).OnKeyPress := Value.FOnKeyPress;
//  Ts0CustomLabel(AControl).OnKeyUp    := Value.FOnKeyUp   ;
end;

class procedure Ts0LabelDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomLabel(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomLabel(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomLabel(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomLabel(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomLabel(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0LabelDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomLabel(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomLabel(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0LabelDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  Ts0CustomLabel(AControl).Caption := Value;
end;

class procedure Ts0LabelDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  Ts0CustomLabel(AControl).Caption := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0LabelDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0LabelDistiller);

end.
