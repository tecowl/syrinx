unit s0ControlImage;
{
$History: s0ControlImage.pas $
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
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0ctrl
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/01   Time: 13:22
 * Updated in $/source/p0control
 * コメントを追加
}

{
  Ts0ControlImage

  作成動機
  ・指定したコントロールの配置などを、コントロール自身以外で表示されたい
  ・コントロールのレイアウトを表示して選択させたい
                              
  public property Selected: Ts0ControlProxyList
  選択されている項目のリスト

  public property Focused: Ts0ControlProxy
  フォーカスされている項目

  published  property Color: TColor;
  背景色

  published  property ColorSelected: TColor;
  選択されている項目の色

  published  property MarkerName: string;
  どのように表示するかを指定できる

  published  property Target;
  表示したいコントロールを指定する。
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,
  s0CanvasDrawer,
  s0ControlProxy,
  s0ControlDrawer;

type
  Ts0CustomControlImage = class;

  Ts0ControlImageDrawer = class(Ts0CustomControlDrawer)
  protected
    FView: Ts0CustomControlImage;
    function NewMarker(AClass: Ts0ControlMarkerClass): Ts0ControlMarker; override;
  end;

  Ts0CustomControlImage = class(TGraphicControl)
  private
    FDrawer: Ts0ControlImageDrawer;
    procedure SetDrawer(const Value: Ts0ControlImageDrawer);
    procedure SetTarget(const Value: TWinControl);
    function GetTarget: TWinControl;
    function GetMarkerName: K0CanvasDrawerName;
    procedure SetMarkerName(const Value: K0CanvasDrawerName);
  protected
    procedure Paint; override;
    function NewDrawer: Ts0ControlImageDrawer; virtual;
  protected
    property Target: TWinControl read GetTarget write SetTarget;
    property MarkerName: K0CanvasDrawerName read GetMarkerName write SetMarkerName;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Drawer: Ts0ControlImageDrawer read FDrawer write SetDrawer;
    procedure Refresh;
  published
  end;


type
  Ts0CustomControlImageView = class;

  Ts0CIVMarker = class(Ts0ControlMarker)
  private
    FView: Ts0CustomControlImageView;
  protected
    function IsSelected(AItem: Ts0ControlProxy): Boolean;
    function IsFocused(AItem: Ts0ControlProxy): Boolean;
    procedure DrawControl(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy); override;
    procedure DrawTabControl(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy); override;
    property View: Ts0CustomControlImageView read FView;
    function GetBrushColor(AItem: Ts0ControlProxy): TColor;
  public
    procedure Draw(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy); override;
  end;


  Ts0CustomControlImageView = class(Ts0CustomControlImage)
  private
    FSelected: Ts0ControlProxyList;
    FFocused: Ts0ControlProxy;
    FMultiSelectShift: TShiftState;
    FColor: TColor;
    FColorSelected: TColor;
    function GetSelected: Ts0ControlProxyList;
    function GetFocused: Ts0ControlProxy;
    procedure SetColor(const Value: TColor);
    procedure SetColorSelected(const Value: TColor);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  protected
    property Selected: Ts0ControlProxyList read GetSelected;
    property Focused: Ts0ControlProxy read GetFocused;
    property Color: TColor read FColor write SetColor default clWindow;
    property ColorSelected: TColor read FColorSelected write SetColorSelected default clTeal;
  protected
    property MultiSelectShift: TShiftState read FMultiSelectShift write FMultiSelectShift default [ssShift];
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
  end;



type
  Ts0ControlImage = class(Ts0CustomControlImageView)
  public
    property Selected;
    property Focused;
  published
    property ShowHint;
  published
    property Align;
    property Color;
    property ColorSelected;
    property MarkerName;
    property Target;
  end;

implementation

uses
  s0ControlHelper,
  s0GraphHelper;

{ Ts0ControlImageDrawer }

function Ts0ControlImageDrawer.NewMarker(
  AClass: Ts0ControlMarkerClass): Ts0ControlMarker;
begin
  Result := inherited NewMarker(AClass);
  if not(Result is Ts0CIVMarker) then Exit;
  if FView is Ts0CustomControlImageView then
    Ts0CIVMarker(Result).FView := Ts0CustomControlImageView(Self.FView);
end;

{ Ts0CustomControlImage }

constructor Ts0CustomControlImage.Create(AOnwer: TComponent);
begin
  inherited Create(AOnwer);
  ControlStyle := ControlStyle + [csReplicatable];
  Height := 105;
  Width := 105;
  FDrawer := NewDrawer;
end;

destructor Ts0CustomControlImage.Destroy;
begin
  FreeAndNil(FDrawer);
  inherited;
end;

function Ts0CustomControlImage.GetMarkerName: K0CanvasDrawerName;
begin
  Result := FDrawer.MarkerName;
end;

function Ts0CustomControlImage.GetTarget: TWinControl;
begin
  Result := FDrawer.Target;
end;

function Ts0CustomControlImage.NewDrawer: Ts0ControlImageDrawer;
begin
  Result := Ts0ControlImageDrawer.Create(nil);
  Result.FView := Self;
end;

procedure Ts0CustomControlImage.Paint;
begin
  if FDrawer.Target <> nil then
  begin
    if FDrawer.Canvas <> Self.Canvas then
      FDrawer.Canvas := Self.Canvas;
    FDrawer.Refresh;
  end
  else
  begin
    
  end;
  inherited;
end;

procedure Ts0CustomControlImage.Refresh;
begin
  FDrawer.BuildItems;
  FDrawer.ResetItemRect;
  FDrawer.Refresh;
end;

procedure Ts0CustomControlImage.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if FDrawer = nil then Exit;
  FDrawer.ResetItemRect;
  FDrawer.Refresh;
end;

procedure Ts0CustomControlImage.SetDrawer(const Value: Ts0ControlImageDrawer);
begin
  FDrawer := Value;
end;

procedure Ts0CustomControlImage.SetMarkerName(
  const Value: K0CanvasDrawerName);
begin
  FDrawer.MarkerName := Value;
end;

procedure Ts0CustomControlImage.SetTarget(const Value: TWinControl);
begin
  FDrawer.Target := Value;
end;



{ Ts0CIVMarker }

procedure Ts0CIVMarker.Draw(ACanvas: TCanvas; ARect: TRect;
  AItem: Ts0ControlProxy);
begin
  inherited;
  if IsFocused(AItem) then
  begin
    s0GraphHelper.ReduceTranslateRect(ARect, 3);
    ACanvas.DrawFocusRect(ARect);
  end;
end;

procedure Ts0CIVMarker.DrawControl(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy);
var
  r: TRect;
  p: TPoint;
begin
  ACanvas.Brush.Color := GetBrushColor(AItem);
  ACanvas.Rectangle(ARect);
  r := ARect;
  s0GraphHelper.ReduceTranslateRect(r, 2);
  p := Ts0ControlHelper.GetTextPosition(
         ACanvas,
         AItem.Caption,
         AItem.BoundsRect
       );
  ACanvas.TextRect( r, p.x, p.y, AItem.Caption);
end;

procedure Ts0CIVMarker.DrawTabControl(ACanvas: TCanvas; ARect: TRect;
  AItem: Ts0ControlProxy);
  procedure DrawActiveTab(r: TRect);
  begin
    ACanvas.FillRect(r);
    ACanvas.Polyline( [
      Point( r.Left , r.Bottom -1),
      Point( r.Left , r.Top      ),
      Point( r.Right, r.Top      ),
      Point( r.Right, r.Bottom -1)
      ]);
  end;
  procedure DrawCaption(r: TRect; ACaption: string);
  var
    p: TPoint;
  begin
    s0GraphHelper.ReduceTranslateRect( r, 2 );
    p := Ts0ControlHelper.GetTextPosition(ACanvas, ACaption, r);
    ACanvas.TextRect(r, p.x, p.y, ACaption);
  end;
  procedure DrawTabs(ATabs: Ts0TabCtrlProxyImpl);
  var
    i: Integer;
    fs: TFontStyles;
  begin
    ACanvas.Brush.Color := FView.Color;
    for i := 0 to ATabs.Count -1 do
    begin
      if ATabs.ActiveTabIndex = i then
      begin
        DrawActiveTab( ATabs.Items[i].Rect );
        fs := ACanvas.Font.Style;
        try
          ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
          DrawCaption(ATabs.Items[i].Rect, ATabs.Items[i].Caption);
        finally
          ACanvas.Font.Style := fs;
        end;
      end
      else
      begin
        ACanvas.Rectangle( ATabs.Items[i].Rect );
        DrawCaption(ATabs.Items[i].Rect, ATabs.Items[i].Caption);
      end;
    end;
  end;
begin
  if AItem = nil then Exit;
  ACanvas.Brush.Color := GetBrushColor(AItem);
  ACanvas.Rectangle( AItem.BoundsRect );
  if AItem.TabCtrl <> nil then
    DrawTabs( AItem.TabCtrl );
end;

function Ts0CIVMarker.GetBrushColor(AItem: Ts0ControlProxy): TColor;
begin
  if IsSelected(AItem) then
    Result := FView.ColorSelected
  else
    Result := FView.Color;
end;

function Ts0CIVMarker.IsFocused(AItem: Ts0ControlProxy): Boolean;
begin
  Result := False;
  if FView.Focused = nil then Exit;
  Result := (FView.Focused = AItem);
end;

function Ts0CIVMarker.IsSelected(AItem: Ts0ControlProxy): Boolean;
begin
  Result := (FView.Selected.IndexOf(AItem) > -1);
end;

{ Ts0CustomControlImageView }

constructor Ts0CustomControlImageView.Create(AOnwer: TComponent);
begin
  inherited;
  FFocused := nil;
  FColor := clWindow;
  FColorSelected := clTeal;
  FMultiSelectShift := [ssShift];
  FSelected := Ts0ControlProxyList.Create(False);
  SetMarkerName( Ts0CIVMarker.GetDrawerName );
end;

destructor Ts0CustomControlImageView.Destroy;
begin
  FreeAndNil(FSelected);
  inherited;
end;

function Ts0CustomControlImageView.GetFocused: Ts0ControlProxy;
begin
  Result := FFocused;
end;

function Ts0CustomControlImageView.GetSelected: Ts0ControlProxyList;
begin
  Result := FSelected;
end;

procedure Ts0CustomControlImageView.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  function MouseDownOnTab(ATab: Ts0TabCtrlProxyImpl; AX, AY: Integer): Boolean;
  var
    idx: Integer;
  begin
    Result := False;
    idx := ATab.IndexOfPos(AX, AY);
    if idx < 0 then Exit;
    if idx = ATab.ActiveTabIndex then Exit;
    ATab.ActiveTabIndex := idx;
    Result := True;
  end;
var
  prxy: Ts0ControlProxy;
begin
  inherited MouseDown(Button, Shift, X, Y);
  prxy := FDrawer.ItemByCanvasPos( Point(X, Y) );
  FFocused := prxy;
  if (prxy <> nil) and (FMultiSelectShift * Shift = FMultiSelectShift) then
  begin
    if FSelected.IndexOf(prxy) < 0 then
      FSelected.Add(prxy)
    else
      FSelected.Remove(prxy);
  end
  else
  begin
    FSelected.Clear;
    if prxy <> nil then
    begin
      if prxy.TabCtrl is Ts0TabCtrlProxyImpl then
      begin
        if not MouseDownOnTab( Ts0TabCtrlProxyImpl(prxy.TabCtrl), X, Y) then
          FSelected.Add(prxy);
      end
      else
        FSelected.Add(prxy);
    end;
  end;
  Canvas.Brush.Color := Color;
  FDrawer.Refresh;
end;

procedure Ts0CustomControlImageView.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);

end;

procedure Ts0CustomControlImageView.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  prxy: Ts0ControlProxy;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if not ShowHint then Exit;
  prxy := FDrawer.ItemByCanvasPos( Point(X, Y) );
  if prxy = nil then
    Self.Hint := ''
  else
    Self.Hint := prxy.Caption;
end;

procedure Ts0CustomControlImageView.Paint;
begin
  Canvas.Brush.Color := Color;
  inherited Paint;
end;

procedure Ts0CustomControlImageView.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure Ts0CustomControlImageView.SetColorSelected(const Value: TColor);
begin
  FColorSelected := Value;
end;

initialization
  Ts0CanvasDrawer.RegisterDrawer(Ts0CIVMarker);

finalization
  Ts0CanvasDrawer.UnRegisterDrawer(Ts0CIVMarker);

end.
