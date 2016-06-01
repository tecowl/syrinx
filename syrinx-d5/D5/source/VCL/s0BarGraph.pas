unit s0BarGraph;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, ExtCtrls,
  s0VCLClasses;

type
  K0bgDirection = (k0bgdToTop, k0bgdToBottom, k0bgdToRight, k0bgdToLeft);
  K0bgValueUnit = (k0bgvuPercentage, k0bgvuPixel);

type
  Ts0BarGraphItem = class(Ts0VCLCollectionItem)
  private
    FBarLength: Integer;
    FBarWidth: Integer;
    FColor: TColor;
    FFont: TFont;
    FRenderText: Boolean;
    FTextOffsetY: Integer;
    FTextOffsetX: Integer;
    FSelected: Boolean;
    FHint: String;
    FShowHint: Boolean;
    procedure SetBarLength(const Value: Integer);
    procedure SetBarWidth(const Value: Integer);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetRenderText(const Value: Boolean);
    procedure SetTextOffsetX(const Value: Integer);
    procedure SetTextOffsetY(const Value: Integer);
    procedure SetHint(const Value: String);
    procedure SetShowHint(const Value: Boolean);
  protected
    procedure Click;
    procedure DblClick;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Selected: Boolean read FSelected;
  published
    property BarWidth: Integer read FBarWidth write SetBarWidth default 90;
    property BarLength: Integer read FBarLength write SetBarLength default 20;
    property Color: TColor read FColor write SetColor default $00FDF7E3;
    property Font: TFont read FFont write SetFont;
    property RenderText: Boolean read FRenderText write SetRenderText default
      false;
    property TextOffsetX: Integer read FTextOffsetX write SetTextOffsetX default
      0;
    property TextOffsetY: Integer read FTextOffsetY write SetTextOffsetY default
      0;
    property Hint: String read FHint write SetHint;
    property ShowHint: Boolean read FShowHint write SetShowHint default True;
  end;

type
  Ts0BarGraphItems = class(Ts0VCLCollection)
  private
    function GetItems(const Index: Integer): Ts0BarGraphItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0BarGraphItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    property Items[const Index: Integer]: Ts0BarGraphItem read GetItems write
    SetItems; default;
  published
  end;


type
  K0BarGraphNotifyEvent = procedure(Sender: TObject; item: Ts0BarGraphItem) of
    object;

type
  Ts0BarGraph = class(TCustomPanel)
  private
    FDirection: K0bgDirection;
    FOnClick: K0BarGraphNotifyEvent;
    FOnDblClick: K0BarGraphNotifyEvent;
    FValueUnit: K0bgValueUnit;
    FItems: Ts0BarGraphItems;
    FDenominator4Length: Integer;
    FDenominator4Width: Integer;
    procedure SetDirection(const Value: K0bgDirection);
    procedure SetValueUnit(const Value: K0bgValueUnit);
    procedure SetItems(const Value: Ts0BarGraphItems);
    procedure SetDenominator4Length(const Value: Integer);
    procedure SetDenominator4Width(const Value: Integer);
  protected
    function GetBarBelt(item: Ts0BarGraphItem): TRect;
    function GetBarRect(item: Ts0BarGraphItem): TRect;
    function GetClientRect: TRect; override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure PaintBar(item: Ts0BarGraphItem);
    procedure PaintBarText(item: Ts0BarGraphItem; barRect: TRect);
  protected
    procedure Click; override;
    procedure DblClick; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetItem(APoint: TPoint): Ts0BarGraphItem;
  published
    property Items: Ts0BarGraphItems read FItems write SetItems;
    property Direction: K0bgDirection read FDirection write SetDirection default
      k0bgdToTop;
    property ValueUnit: K0bgValueUnit read FValueUnit write SetValueUnit default
      k0bgvuPercentage;
    property OnClick: K0BarGraphNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: K0BarGraphNotifyEvent read FOnDblClick write
      FOnDblClick;
    property Denominator4Length: Integer read FDenominator4Length write
      SetDenominator4Length default 100;
    property Denominator4Width: Integer read FDenominator4Width write
      SetDenominator4Width default 100;
  published
    property Align;
    property Anchors;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property Color;
    property Constraints;
    property FullRepaint;
    property Font; //Ç±ÇÍÇÕégópÇ≥ÇÍÇ»Ç¢ÅB
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont; 
    property ParentShowHint;
    property PopupMenu;
    //property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
  end;

implementation

uses
  Forms,
  s0Exception,
  s0GraphHelper;

{ Ts0BarGraphItem }

procedure Ts0BarGraphItem.Assign(Source: TPersistent);
begin
  inherited;

end;


constructor Ts0BarGraphItem.Create(ACollection: TCollection);
begin
  inherited;
  FFont := TFont.Create;
  FBarWidth := 90;
  FBarLength := 20;
  FColor := $00FDF7E3;
  FRenderText := True;
  FTextOffsetX := 0;
  FTextOffsetY := 0;
  FShowHint := True;
end;

destructor Ts0BarGraphItem.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure Ts0BarGraphItem.SetBarWidth(const Value: Integer);
begin
  FBarWidth := Value;
  Changed(False);
end;

procedure Ts0BarGraphItem.SetColor(const Value: TColor);
begin
  FColor := Value;
  Changed(False);
end;

procedure Ts0BarGraphItem.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Changed(False);
end;

procedure Ts0BarGraphItem.SetBarLength(const Value: Integer);
begin
  FBarLength := Value;
  Changed(False);
end;

procedure Ts0BarGraphItem.SetRenderText(const Value: Boolean);
begin
  FRenderText := Value;
  Changed(False);
end;

procedure Ts0BarGraphItem.SetTextOffsetX(const Value: Integer);
begin
  FTextOffsetX := Value;
  Changed(false);
end;

procedure Ts0BarGraphItem.SetTextOffsetY(const Value: Integer);
begin
  FTextOffsetY := Value;
  Changed(false);
end;

procedure Ts0BarGraphItem.Click;
begin
  FSelected := True;
  Changed(false);
end;

procedure Ts0BarGraphItem.DblClick;
begin

end;

procedure Ts0BarGraphItem.SetHint(const Value: String);
begin
  FHint := Value;
  Changed(false);
end;

procedure Ts0BarGraphItem.SetShowHint(const Value: Boolean);
begin
  FShowHint := Value;
  Changed(False);
end;

{ Ts0BarGraphItems }

function Ts0BarGraphItems.GetItems(const Index: Integer): Ts0BarGraphItem;
begin
  Result := Ts0BarGraphItem(inherited Items[Index]);
end;

procedure Ts0BarGraphItems.SetItems(const Index: Integer;
  const Value: Ts0BarGraphItem);
begin
  inherited Items[Index] := Value;
end;

procedure Ts0BarGraphItems.Update(Item: TCollectionItem);
var
  graphItem: Ts0BarGraphItem;
  current: Ts0BarGraphItem;
  i: Integer;
begin
  inherited;
  if Item <> nil then
  begin
    graphItem := Ts0BarGraphItem(Item);
    if graphItem.Selected then
    begin
      for i := 0 to Self.Count - 1 do
      begin
        current := Items[i];
        if (current <> graphItem) and (current.Selected) then
          current.FSelected := False;
      end;
    end;
  end;
  if OwnerComponent is Ts0BarGraph then
    Ts0BarGraph(OwnerComponent).Refresh;
end;

{ Ts0BarGraph }

procedure Ts0BarGraph.Click;
var
  p: TPoint;
  item: Ts0BarGraphItem;
begin
  p := ScreenToClient(Mouse.CursorPos);
  item := GetItem(p);
  if item <> nil then
    item.Click
  else
    inherited;
end;

constructor Ts0BarGraph.Create(AOwner: TComponent);
begin
  inherited;
  FItems := Ts0BarGraphItems.Create(Self, Ts0BarGraphItem);
  FDenominator4Length := 100;
  FDenominator4Width := 100;
  Caption := '';
end;

procedure Ts0BarGraph.DblClick;
var
  p: TPoint;
  item: Ts0BarGraphItem;
begin
  p := ScreenToClient(Mouse.CursorPos);
  item := GetItem(p);
  if item <> nil then
    item.DblClick
  else
    inherited;
end;

destructor Ts0BarGraph.Destroy;
begin
  inherited;

end;

function Ts0BarGraph.GetBarBelt(item: Ts0BarGraphItem): TRect;
var
  clientRect: TRect;
  W, itemW: Integer;
begin
  clientRect := GetClientRect;
  if item = nil then
    Result := clientRect;
  if FDirection in [k0bgdToTop, k0bgdToBottom] then
  begin
    Result.Top := clientRect.Top;
    Result.Bottom := clientRect.Bottom;
    W := clientRect.Right - clientRect.Left;
    itemW := W div Items.Count;
    Result.Left := item.Index * itemW;
    Result.Right := (item.Index + 1) * itemW - 1;
  end
  else if FDirection in [k0bgdToRight, k0bgdToLeft] then
  begin
    Result.Left := clientRect.Left;
    Result.Right := clientRect.Right;
    W := clientRect.Bottom - clientRect.Top;
    itemW := W div Items.Count;
    Result.Top := item.Index * itemW;
    Result.Bottom := (item.Index + 1) * itemW - 1;
  end
  else
  begin
    Exit;
  end;
end;

function Ts0BarGraph.GetBarRect(item: Ts0BarGraphItem): TRect;
  function GetPixelOfBarLength(d: Integer): Integer;
  begin
    if ValueUnit = k0bgvuPercentage then
      Result := d * item.BarLength div FDenominator4Length
    else
      Result := item.BarLength;
  end;
  function GetHalfPixelOfBatWidth(d: Integer): Integer;
  begin
    if ValueUnit = k0bgvuPercentage then
      Result := d * item.BarWidth div FDenominator4Width div 2
    else
      Result := item.BarWidth div 2;
  end;
var
  dx, dy: Integer;
  barRect: TRect;
  midPos: Integer;
  barW: Integer;
  Rect: TRect;
begin
  Rect := GetBarBelt(item);
  dx := Rect.Right - Rect.Left;
  dy := Rect.Bottom - Rect.Top;
  case direction of
    k0bgdToTop:
      begin
        barRect.Bottom := Rect.Bottom;
        barRect.Top := Rect.Bottom - GetPixelOfBarLength(dy);
        midPos := (Rect.Left + Rect.Right) div 2;
        barW := GetHalfPixelOfBatWidth(dx);
        barRect.Left := midPos - barW;
        barRect.Right := midPos + barW;
      end;
    k0bgdToBottom:
      begin
        barRect.Top := Rect.Top;
        barRect.Bottom := Rect.Top + GetPixelOfBarLength(dy);
        midPos := (Rect.Left + Rect.Right) div 2;
        barW := GetHalfPixelOfBatWidth(dx);
        barRect.Left := midPos - barW;
        barRect.Right := midPos + barW;
      end;
    k0bgdToLeft:
      begin
        barRect.Right := Rect.Right;
        barRect.Left := Rect.Right - GetPixelOfBarLength(dx);
        midPos := (Rect.Top + Rect.Bottom) div 2;
        barW := GetHalfPixelOfBatWidth(dy);
        barRect.Top := midPos - barW;
        barRect.Bottom := midPos + barW;
      end;
    k0bgdToRight:
      begin
        barRect.Left := Rect.Left;
        barRect.Right := Rect.Left + GetPixelOfBarLength(dx);
        midPos := (Rect.Top + Rect.Bottom) div 2;
        barW := GetHalfPixelOfBatWidth(dy);
        barRect.Top := midPos - barW;
        barRect.Bottom := midPos + barW;
      end;
  end;
  Result := barRect;
end;

function Ts0BarGraph.GetClientRect: TRect;
begin
  Result := inherited GetClientRect;
end;

function Ts0BarGraph.GetItem(APoint: TPoint): Ts0BarGraphItem;
var
  i: Integer;
  item: Ts0BarGraphItem;
  belt: TRect;
begin
  for i := 0 to Items.Count - 1 do
  begin
    item := Items[i];
    belt := GetBarBelt(item);
    if IsInRect(APoint, belt) then
    begin
      Result := item;
      Exit;
    end;
  end;
  Result := nil;
end;

procedure Ts0BarGraph.loaded;
begin
  inherited;
  Caption := '';
end;

procedure Ts0BarGraph.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
  item: Ts0BarGraphItem;
begin
  p.x := X;
  p.y := Y; 
  item := GetItem(p);
  if item <> nil then
  begin
    Self.Hint := item.Hint;
    Self.ShowHint := item.ShowHint;
  end;
  inherited;
end;

procedure Ts0BarGraph.Paint;
var
  i: Integer;
  itemRect: TRect;
begin
  if Caption <> '' then
    Caption := '';
  inherited Paint;
  if Items.Count < 1 then
    Exit;
  for i := 0 to Items.Count - 1 do
  begin
    itemRect := GetBarBelt(Items[i]);
    Self.PaintBar(Items[i]);
  end;
end;

procedure Ts0BarGraph.PaintBar(item: Ts0BarGraphItem);
  function GetPixelOfBarLength(d: Integer): Integer;
  begin
    if ValueUnit = k0bgvuPercentage then
      Result := d * item.BarLength div FDenominator4Length
    else
      Result := item.BarLength;
  end;
  function GetHalfPixelOfBatWidth(d: Integer): Integer;
  begin
    if ValueUnit = k0bgvuPercentage then
      Result := d * item.BarWidth div FDenominator4Width div 2
    else
      Result := item.BarWidth div 2;
  end;
var
  barRect: TRect;
begin
  barRect := GetBarRect(item);
  Canvas.Brush.Color := clBlack;
  Canvas.FrameRect(barRect);
  ReduceTranslateRect(barRect, 1);
  Canvas.Brush.Color := item.Color;
  Canvas.FillRect(barRect);
  if item.Selected then
    Canvas.DrawFocusRect(barRect);
  if item.RenderText then
    PaintBarText(item, barRect);
  if item.Selected then
  begin
  	Self.Hint := item.Hint;
  	Self.ShowHint := item.ShowHint;
  end;
end;

procedure Ts0BarGraph.PaintBarText(item: Ts0BarGraphItem;
  barRect: TRect);
var
  textPos: TPoint;
  textRectSize: TSize;
  t: string;
begin
  t := IntToStr(item.BarLength);
  textRectSize := Canvas.TextExtent(t);
  case direction of
    k0bgdToTop:
      begin
        textPos.y := barRect.Top - textRectSize.cy - 1;
        textPos.x := (barRect.Left + BarRect.Right - textRectSize.cx) div 2;
      end;
    k0bgdToBottom:
      begin
        textPos.y := barRect.Bottom + 1;
        textPos.x := (barRect.Left + BarRect.Right - textRectSize.cx) div 2;
      end;
    k0bgdToLeft:
      begin
        textPos.x := barRect.Left - textRectSize.cx - 1;
        textPos.y := (barRect.Top + BarRect.Bottom - textRectSize.cy) div 2;
      end;
    k0bgdToRight:
      begin
        textPos.x := barRect.Right + 1;
        textPos.y := (barRect.Top + BarRect.Bottom - textRectSize.cy) div 2;
      end;
  end;
  textPos.x := textPos.x + item.TextOffsetX;
  textPos.y := textPos.y + item.TextOffsetY;
  //
  Canvas.Brush.Color := Self.Color;
  Canvas.Font.Assign(item.Font);
  if Canvas.TextFlags and ETO_OPAQUE <> 0 then
    Canvas.TextFlags := Canvas.TextFlags - ETO_OPAQUE;
  Canvas.TextOut(textPos.x, textPos.y, t);
end;

procedure Ts0BarGraph.SetDenominator4Length(const Value: Integer);
begin
  FDenominator4Length := Value;
  Refresh;
end;

procedure Ts0BarGraph.SetDenominator4Width(const Value: Integer);
begin
  FDenominator4Width := Value;
  Refresh;
end;

procedure Ts0BarGraph.SetDirection(const Value: K0bgDirection);
begin
  FDirection := Value;
  Refresh;
end;

procedure Ts0BarGraph.SetItems(const Value: Ts0BarGraphItems);
begin
  FItems.Assign(Value);
  Refresh;
end;

procedure Ts0BarGraph.SetValueUnit(const Value: K0bgValueUnit);
begin
  FValueUnit := Value;
  Refresh;
end;

end.

