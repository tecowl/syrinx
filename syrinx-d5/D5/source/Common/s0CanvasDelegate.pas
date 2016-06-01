unit s0CanvasDelegate;

interface

uses
  SysUtils, Classes, Windows, Graphics;

type
	Ts0CanvasDelegate = class(TPersistent)
  private
  	FDelegate: TCanvas;
    FFreeDelegateOnDestroy: Boolean;
  protected
    function GetBrush: TBrush;
    function GetCanvasOrientation: TCanvasOrientation;
    function GetClipRect: TRect;
    function GetCopyMode: TCopyMode;
    function GetFont: TFont;
    function GetHandle: HDC;
    function GetLockCount: Integer;
    function GetOnChange: TNotifyEvent;
    function GetOnChanging: TNotifyEvent;
    function GetPen: TPen;
    function GetPenPos: TPoint;
    function GetPixel(X, Y: Integer): TColor;
    function GetTextFlags: Longint;
    procedure SetBrush(const Value: TBrush);
    procedure SetCopyMode(const Value: TCopyMode);
    procedure SetFont(const Value: TFont);
    procedure SetHandle(const Value: HDC);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetOnChanging(const Value: TNotifyEvent);
    procedure SetPen(const Value: TPen);
    procedure SetPenPos(const Value: TPoint);
    procedure SetPixel(X, Y: Integer; const Value: TColor);
    procedure SetTextFlags(const Value: Integer);
  public
    constructor Create; overload; virtual;
    constructor Create(ACanvas: TCanvas); overload; virtual;
    destructor Destroy; override;
    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
    procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap;
      const Source: TRect; Color: TColor);
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
    procedure CopyRect(const Dest: TRect; Canvas: TCanvas;
      const Source: TRect);
    procedure Draw(X, Y: Integer; Graphic: TGraphic);
    procedure DrawFocusRect(const Rect: TRect);
    procedure Ellipse(X1, Y1, X2, Y2: Integer); overload;
    procedure Ellipse(const Rect: TRect); overload;
    procedure FillRect(const Rect: TRect);
    procedure FloodFill(X, Y: Integer; Color: TColor; FillStyle: TFillStyle);
    procedure FrameRect(const Rect: TRect);
    procedure LineTo(X, Y: Integer);
    procedure Lock;
    procedure MoveTo(X, Y: Integer);
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
    procedure Polygon(const Points: array of TPoint);
    procedure Polyline(const Points: array of TPoint);
    procedure PolyBezier(const Points: array of TPoint);
    procedure PolyBezierTo(const Points: array of TPoint);
    procedure Rectangle(X1, Y1, X2, Y2: Integer); overload;
    procedure Rectangle(const Rect: TRect); overload;
    procedure Refresh;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic);
    function TextExtent(const Text: string): TSize;
    function TextHeight(const Text: string): Integer;
    procedure TextOut(X, Y: Integer; const Text: string);
    procedure TextRect(Rect: TRect; X, Y: Integer; const Text: string);
    function TextWidth(const Text: string): Integer;
    function TryLock: Boolean;
    procedure Unlock;
    property ClipRect: TRect read GetClipRect;
    property Handle: HDC read GetHandle write SetHandle;
    property LockCount: Integer read GetLockCount;
    property CanvasOrientation: TCanvasOrientation read GetCanvasOrientation;
    property PenPos: TPoint read GetPenPos write SetPenPos;
    property Pixels[X, Y: Integer]: TColor read GetPixel write SetPixel;
    property TextFlags: Longint read GetTextFlags write SetTextFlags;
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
    property OnChanging: TNotifyEvent read GetOnChanging write SetOnChanging;
  published
    property Brush: TBrush read GetBrush write SetBrush;
    property CopyMode: TCopyMode read GetCopyMode write SetCopyMode default cmSrcCopy;
    property Font: TFont read GetFont write SetFont;
    property Pen: TPen read GetPen write SetPen;
  end;


implementation

{ Ts0CanvasDelegate }

procedure Ts0CanvasDelegate.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
	FDelegate.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure Ts0CanvasDelegate.BrushCopy(const Dest: TRect; Bitmap: TBitmap;
  const Source: TRect; Color: TColor);
begin
	FDelegate.BrushCopy(Dest, Bitmap, Source, Color);
end;

procedure Ts0CanvasDelegate.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
	FDelegate.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure Ts0CanvasDelegate.CopyRect(const Dest: TRect; Canvas: TCanvas;
  const Source: TRect);
begin
	FDelegate.CopyRect(Dest, Canvas, Source);
end;

constructor Ts0CanvasDelegate.Create;
begin
	FDelegate := TCanvas.Create;
  FFreeDelegateOnDestroy := True;
end;

constructor Ts0CanvasDelegate.Create(ACanvas: TCanvas);
begin
	FDelegate := ACanvas;
  FFreeDelegateOnDestroy := False;
end;

destructor Ts0CanvasDelegate.Destroy;
begin
	if FFreeDelegateOnDestroy then
		FreeAndNil(FDelegate);
  inherited;
end;

procedure Ts0CanvasDelegate.Draw(X, Y: Integer; Graphic: TGraphic);
begin
	FDelegate.Draw(X, Y, Graphic);
end;

procedure Ts0CanvasDelegate.DrawFocusRect(const Rect: TRect);
begin
	FDelegate.DrawFocusRect(Rect);
end;

procedure Ts0CanvasDelegate.Ellipse(const Rect: TRect);
begin
	FDelegate.Ellipse(Rect);
end;

procedure Ts0CanvasDelegate.Ellipse(X1, Y1, X2, Y2: Integer);
begin
	FDelegate.Ellipse(X1, Y1, X2, Y2);
end;

procedure Ts0CanvasDelegate.FillRect(const Rect: TRect);
begin
  FDelegate.FillRect(Rect);
end;

procedure Ts0CanvasDelegate.FloodFill(X, Y: Integer; Color: TColor;
  FillStyle: TFillStyle);
begin
	FDelegate.FloodFill(X, Y, Color, FillStyle);
end;

procedure Ts0CanvasDelegate.FrameRect(const Rect: TRect);
begin
	FDelegate.FrameRect(Rect);
end;

function Ts0CanvasDelegate.GetBrush: TBrush;
begin
	Result := FDelegate.Brush;
end;

function Ts0CanvasDelegate.GetCanvasOrientation: TCanvasOrientation;
begin
	Result := FDelegate.CanvasOrientation;
end;

function Ts0CanvasDelegate.GetClipRect: TRect;
begin
	Result := FDelegate.ClipRect;
end;

function Ts0CanvasDelegate.GetCopyMode: TCopyMode;
begin
	Result := FDelegate.CopyMode;
end;

function Ts0CanvasDelegate.GetFont: TFont;
begin
	Result := FDelegate.Font;
end;

function Ts0CanvasDelegate.GetHandle: HDC;
begin
	Result := FDelegate.Handle;
end;

function Ts0CanvasDelegate.GetLockCount: Integer;
begin
	Result := FDelegate.LockCount;
end;

function Ts0CanvasDelegate.GetOnChange: TNotifyEvent;
begin
	Result := FDelegate.OnChange;
end;

function Ts0CanvasDelegate.GetOnChanging: TNotifyEvent;
begin
	Result := FDelegate.OnChanging;
end;

function Ts0CanvasDelegate.GetPen: TPen;
begin
	Result := FDelegate.Pen;
end;

function Ts0CanvasDelegate.GetPenPos: TPoint;
begin
	Result := FDelegate.PenPos;
end;

function Ts0CanvasDelegate.GetPixel(X, Y: Integer): TColor;
begin
	Result := FDelegate.Pixels[X, Y];
end;

function Ts0CanvasDelegate.GetTextFlags: Longint;
begin
	Result := FDelegate.TextFlags;
end;

procedure Ts0CanvasDelegate.LineTo(X, Y: Integer);
begin
	FDelegate.LineTo(X, Y);
end;

procedure Ts0CanvasDelegate.Lock;
begin
	FDelegate.Lock;
end;

procedure Ts0CanvasDelegate.MoveTo(X, Y: Integer);
begin
	FDelegate.MoveTo(X, Y);
end;

procedure Ts0CanvasDelegate.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
	FDelegate.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure Ts0CanvasDelegate.PolyBezier(const Points: array of TPoint);
begin
	FDelegate.PolyBezier(Points);
end;

procedure Ts0CanvasDelegate.PolyBezierTo(const Points: array of TPoint);
begin
	FDelegate.PolyBezierTo(Points);
end;

procedure Ts0CanvasDelegate.Polygon(const Points: array of TPoint);
begin
	FDelegate.Polygon(Points);
end;

procedure Ts0CanvasDelegate.Polyline(const Points: array of TPoint);
begin
	FDelegate.Polyline(Points);
end;

procedure Ts0CanvasDelegate.Rectangle(X1, Y1, X2, Y2: Integer);
begin
	FDelegate.Rectangle(X1, Y1, X2, Y2);
end;

procedure Ts0CanvasDelegate.Rectangle(const Rect: TRect);
begin
	FDelegate.Rectangle(Rect);
end;

procedure Ts0CanvasDelegate.Refresh;
begin
	FDelegate.Refresh;
end;

procedure Ts0CanvasDelegate.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
	FDelegate.RoundRect(X1, Y1, X2, Y2, X3, Y3);
end;

procedure Ts0CanvasDelegate.SetBrush(const Value: TBrush);
begin
	FDelegate.Brush := Value;
end;

procedure Ts0CanvasDelegate.SetCopyMode(const Value: TCopyMode);
begin
	FDelegate.CopyMode := Value;
end;

procedure Ts0CanvasDelegate.SetFont(const Value: TFont);
begin
	FDelegate.Font := Value;
end;

procedure Ts0CanvasDelegate.SetHandle(const Value: HDC);
begin
	FDelegate.Handle := Value;
end;

procedure Ts0CanvasDelegate.SetOnChange(const Value: TNotifyEvent);
begin
	FDelegate.OnChange := Value;
end;

procedure Ts0CanvasDelegate.SetOnChanging(const Value: TNotifyEvent);
begin
	FDelegate.OnChanging := Value;
end;

procedure Ts0CanvasDelegate.SetPen(const Value: TPen);
begin
	FDelegate.Pen := Value;
end;

procedure Ts0CanvasDelegate.SetPenPos(const Value: TPoint);
begin
	FDelegate.PenPos := Value;
end;

procedure Ts0CanvasDelegate.SetPixel(X, Y: Integer; const Value: TColor);
begin
	FDelegate.Pixels[X, Y] := Value;
end;

procedure Ts0CanvasDelegate.SetTextFlags(const Value: Longint);
begin
	FDelegate.TextFlags := Value;
end;

procedure Ts0CanvasDelegate.StretchDraw(const Rect: TRect;
  Graphic: TGraphic);
begin
	FDelegate.StretchDraw(Rect, Graphic);
end;

function Ts0CanvasDelegate.TextExtent(const Text: string): TSize;
begin
	Result := FDelegate.TextExtent(Text);
end;

function Ts0CanvasDelegate.TextHeight(const Text: string): Integer;
begin
	Result := FDelegate.TextHeight(Text);
end;

procedure Ts0CanvasDelegate.TextOut(X, Y: Integer; const Text: string);
begin
	FDelegate.TextOut(X, Y, Text);
end;

procedure Ts0CanvasDelegate.TextRect(Rect: TRect; X, Y: Integer;
  const Text: string);
begin
	FDelegate.TextRect(Rect, X, Y, Text);
end;

function Ts0CanvasDelegate.TextWidth(const Text: string): Integer;
begin
	Result := FDelegate.TextWidth(Text);
end;

function Ts0CanvasDelegate.TryLock: Boolean;
begin
	Result := FDelegate.TryLock;
end;

procedure Ts0CanvasDelegate.Unlock;
begin
	FDelegate.Unlock;
end;

end.
