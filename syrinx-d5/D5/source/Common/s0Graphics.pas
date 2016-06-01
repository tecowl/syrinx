unit s0Graphics;

interface

uses
  SysUtils, Classes, Windows, Graphics;

type
	Ts0CustomFontDelegate = class(TPersistent)
  private
  	FDelegate: TFont;
    FFreeDelegateOnDestroy: Boolean;
  protected
  	property Delegate: TFont read FDelegate;
  	property FreeDelegateOnDestroy: Boolean read FFreeDelegateOnDestroy;
  protected
    function GetCharset: TFontCharset; virtual;
    function GetColor: TColor; virtual;
    function GetFontAdapter: IChangeNotifier; virtual;
    function GetHandle: HFont; virtual;
    function GetHeight: Integer; virtual;
    function GetName: TFontName; virtual;
    function GetOnChange: TNotifyEvent; virtual;
    function GetOwnerLock: PRTLCriticalSection; virtual;
    function GetPitch: TFontPitch; virtual;
    function GetPixelsPerInch: Integer; virtual;
    function GetSize: Integer; virtual;
    function GetStyle: TFontStyles; virtual;
    procedure SetCharset(const Value: TFontCharset); virtual;
    procedure SetColor(const Value: TColor); virtual;
    procedure SetFontAdapter(const Value: IChangeNotifier); virtual;
    procedure SetHandle(const Value: HFont); virtual;
    procedure SetHeight(const Value: Integer); virtual;
    procedure SetName(const Value: TFontName); virtual;
    procedure SetOnChange(const Value: TNotifyEvent); virtual;
    procedure SetOwnerLock(const Value: PRTLCriticalSection); virtual;
    procedure SetPitch(const Value: TFontPitch); virtual;
    procedure SetPixelsPerInch(const Value: Integer); virtual;
    procedure SetSize(const Value: Integer); virtual;
    procedure SetStyle(const Value: TFontStyles); virtual;
  public
    //TGraphicsObject
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
    property OwnerCriticalSection: PRTLCriticalSection read GetOwnerLock write SetOwnerLock;
  public
    constructor Create; overload; virtual;
    constructor Create(AFont: TFont); overload; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  protected
    property FontAdapter: IChangeNotifier read GetFontAdapter write SetFontAdapter;
    property Handle: HFont read GetHandle write SetHandle;
    property PixelsPerInch: Integer read GetPixelsPerInch write SetPixelsPerInch;
  protected
    property Charset: TFontCharset read GetCharset write SetCharset;
    property Color: TColor read GetColor write SetColor;
    property Height: Integer read GetHeight write SetHeight;
    property Name: TFontName read GetName write SetName;
    property Pitch: TFontPitch read GetPitch write SetPitch default fpDefault;
    property Size: Integer read GetSize write SetSize stored False;
    property Style: TFontStyles read GetStyle write SetStyle;
  end;

type
	Ts0FontDelegate = class(Ts0CustomFontDelegate)
  public
    property FontAdapter;
    property Handle;
    property PixelsPerInch;
  published
    property Charset;
    property Color;
    property Height;
    property Name;
    property Pitch;
    property Size;
    property Style;
  end;

type
	Ts0CustomCanvasDelegate = class(TPersistent)
  private
  	FDelegate: TCanvas;
    FFreeDelegateOnDestroy: Boolean;
  protected
  	property Delegate: TCanvas read FDelegate;
  	property FreeDelegateOnDestroy: Boolean read FFreeDelegateOnDestroy;
  protected
    function GetBrush: TBrush; virtual;
    function GetCanvasOrientation: TCanvasOrientation; virtual;
    function GetClipRect: TRect; virtual;
    function GetCopyMode: TCopyMode; virtual;
    function GetFont: TFont; virtual;
    function GetHandle: HDC; virtual;
    function GetLockCount: Integer; virtual;
    function GetOnChange: TNotifyEvent; virtual;
    function GetOnChanging: TNotifyEvent; virtual;
    function GetPen: TPen; virtual;
    function GetPenPos: TPoint; virtual;
    function GetPixel(X, Y: Integer): TColor; virtual;
    function GetTextFlags: Longint; virtual;
    procedure SetBrush(const Value: TBrush); virtual;
    procedure SetCopyMode(const Value: TCopyMode); virtual;
    procedure SetFont(const Value: TFont); virtual;
    procedure SetHandle(const Value: HDC); virtual;
    procedure SetOnChange(const Value: TNotifyEvent); virtual;
    procedure SetOnChanging(const Value: TNotifyEvent); virtual;
    procedure SetPen(const Value: TPen); virtual;
    procedure SetPenPos(const Value: TPoint); virtual;
    procedure SetPixel(X, Y: Integer; const Value: TColor); virtual;
    procedure SetTextFlags(const Value: Integer); virtual;
  public
    constructor Create; overload; virtual;
    constructor Create(ACanvas: TCanvas); overload; virtual;
    destructor Destroy; override;
    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual;
    procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap;
      const Source: TRect; Color: TColor); virtual;
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual;
    procedure CopyRect(const Dest: TRect; Canvas: TCanvas;
      const Source: TRect); virtual;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); virtual;
    procedure DrawFocusRect(const Rect: TRect); virtual;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); reintroduce; overload; virtual;
    procedure Ellipse(const Rect: TRect); reintroduce; overload; virtual;
    procedure FillRect(const Rect: TRect); virtual;
    procedure FloodFill(X, Y: Integer; Color: TColor; FillStyle: TFillStyle); virtual;
    procedure FrameRect(const Rect: TRect); virtual;
    procedure LineTo(X, Y: Integer); virtual;
    procedure Lock; virtual;
    procedure MoveTo(X, Y: Integer); virtual;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual;
    procedure Polygon(const Points: array of TPoint); virtual;
    procedure Polyline(const Points: array of TPoint); virtual;
    procedure PolyBezier(const Points: array of TPoint); virtual;
    procedure PolyBezierTo(const Points: array of TPoint); virtual;
    procedure Rectangle(X1, Y1, X2, Y2: Integer); reintroduce; overload; virtual;
    procedure Rectangle(const Rect: TRect); reintroduce; overload; virtual;
    procedure Refresh; virtual;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); virtual;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); virtual;
    function TextExtent(const Text: string): TSize; virtual;
    function TextHeight(const Text: string): Integer; virtual;
    procedure TextOut(X, Y: Integer; const Text: string); virtual;
    procedure TextRect(Rect: TRect; X, Y: Integer; const Text: string); virtual;
    function TextWidth(const Text: string): Integer; virtual;
    function TryLock: Boolean; virtual;
    procedure Unlock; virtual;
  protected
    property ClipRect: TRect read GetClipRect;
    property Handle: HDC read GetHandle write SetHandle;
    property LockCount: Integer read GetLockCount;
    property CanvasOrientation: TCanvasOrientation read GetCanvasOrientation;
    property PenPos: TPoint read GetPenPos write SetPenPos;
    property Pixels[X, Y: Integer]: TColor read GetPixel write SetPixel;
    property TextFlags: Longint read GetTextFlags write SetTextFlags;
    property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
    property OnChanging: TNotifyEvent read GetOnChanging write SetOnChanging;
  protected
    property Brush: TBrush read GetBrush write SetBrush;
    property CopyMode: TCopyMode read GetCopyMode write SetCopyMode default cmSrcCopy;
    property Font: TFont read GetFont write SetFont;
    property Pen: TPen read GetPen write SetPen;
  end;


type
	Ts0CanvasDelegate = class(Ts0CustomCanvasDelegate)
  public
    property ClipRect;
    property Handle;
    property LockCount;
    property CanvasOrientation;
    property PenPos;
    property Pixels;
    property TextFlags;
    property OnChange;
    property OnChanging;
  published
    property Brush;
    property CopyMode;
    property Font;
    property Pen;
  end;



implementation

{ Ts0CustomFontDelegate }

procedure Ts0CustomFontDelegate.Assign(Source: TPersistent);
begin
	FDelegate.Assign(Source);
end;

constructor Ts0CustomFontDelegate.Create;
begin
	FDelegate := TFont.Create;
  FFreeDelegateOnDestroy := True;
end;

constructor Ts0CustomFontDelegate.Create(AFont: TFont);
begin
	FDelegate := AFont;
  FFreeDelegateOnDestroy := False;
end;

destructor Ts0CustomFontDelegate.Destroy;
begin
	if FFreeDelegateOnDestroy then
		FreeAndNil(FDelegate);
  inherited;
end;

function Ts0CustomFontDelegate.GetCharset: TFontCharset;
begin
  Result := FDelegate.Charset;
end;

function Ts0CustomFontDelegate.GetColor: TColor;
begin
	Result := FDelegate.Color;
end;

function Ts0CustomFontDelegate.GetFontAdapter: IChangeNotifier;
begin
	Result := FDelegate.FontAdapter;
end;

function Ts0CustomFontDelegate.GetHandle: HFont;
begin
	Result := FDelegate.Handle;
end;

function Ts0CustomFontDelegate.GetHeight: Integer;
begin
	Result := FDelegate.Height;
end;

function Ts0CustomFontDelegate.GetName: TFontName;
begin
	Result := FDelegate.Name;
end;

function Ts0CustomFontDelegate.GetOnChange: TNotifyEvent;
begin
	Result := FDelegate.OnChange;
end;

function Ts0CustomFontDelegate.GetOwnerLock: PRTLCriticalSection;
begin
	Result := FDelegate.OwnerCriticalSection;
end;

function Ts0CustomFontDelegate.GetPitch: TFontPitch;
begin
	Result := FDelegate.Pitch;
end;

function Ts0CustomFontDelegate.GetPixelsPerInch: Integer;
begin
	Result := FDelegate.PixelsPerInch;
end;

function Ts0CustomFontDelegate.GetSize: Integer;
begin
	Result := FDelegate.Size;
end;

function Ts0CustomFontDelegate.GetStyle: TFontStyles;
begin
	Result := FDelegate.Style;
end;

procedure Ts0CustomFontDelegate.SetCharset(const Value: TFontCharset);
begin
	FDelegate.Charset := Value;
end;

procedure Ts0CustomFontDelegate.SetColor(const Value: TColor);
begin
	FDelegate.Color := Value;
end;

procedure Ts0CustomFontDelegate.SetFontAdapter(const Value: IChangeNotifier);
begin
	FDelegate.FontAdapter := Value;
end;

procedure Ts0CustomFontDelegate.SetHandle(const Value: HFont);
begin
	FDelegate.Handle := Value;
end;

procedure Ts0CustomFontDelegate.SetHeight(const Value: Integer);
begin
	FDelegate.Height := Value;
end;

procedure Ts0CustomFontDelegate.SetName(const Value: TFontName);
begin
	FDelegate.Name := Value;
end;

procedure Ts0CustomFontDelegate.SetOnChange(const Value: TNotifyEvent);
begin
	FDelegate.OnChange := Value;
end;

procedure Ts0CustomFontDelegate.SetOwnerLock(const Value: PRTLCriticalSection);
begin
	FDelegate.OwnerCriticalSection := Value;
end;

procedure Ts0CustomFontDelegate.SetPitch(const Value: TFontPitch);
begin
	FDelegate.Pitch := Value;
end;

procedure Ts0CustomFontDelegate.SetPixelsPerInch(const Value: Integer);
begin
	FDelegate.PixelsPerInch := Value;
end;

procedure Ts0CustomFontDelegate.SetSize(const Value: Integer);
begin
	FDelegate.Size := Value;
end;

procedure Ts0CustomFontDelegate.SetStyle(const Value: TFontStyles);
begin
	FDelegate.Style := Value;
end;

{ Ts0CustomCanvasDelegate }

procedure Ts0CustomCanvasDelegate.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
	FDelegate.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure Ts0CustomCanvasDelegate.BrushCopy(const Dest: TRect; Bitmap: TBitmap;
  const Source: TRect; Color: TColor);
begin
	FDelegate.BrushCopy(Dest, Bitmap, Source, Color);
end;

procedure Ts0CustomCanvasDelegate.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
	FDelegate.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure Ts0CustomCanvasDelegate.CopyRect(const Dest: TRect; Canvas: TCanvas;
  const Source: TRect);
begin
	FDelegate.CopyRect(Dest, Canvas, Source);
end;

constructor Ts0CustomCanvasDelegate.Create;
begin
	FDelegate := TCanvas.Create;
  FFreeDelegateOnDestroy := True;
end;

constructor Ts0CustomCanvasDelegate.Create(ACanvas: TCanvas);
begin
	FDelegate := ACanvas;
  FFreeDelegateOnDestroy := False;
end;

destructor Ts0CustomCanvasDelegate.Destroy;
begin
	if FFreeDelegateOnDestroy then
		FreeAndNil(FDelegate);
  inherited;
end;

procedure Ts0CustomCanvasDelegate.Draw(X, Y: Integer; Graphic: TGraphic);
begin
	FDelegate.Draw(X, Y, Graphic);
end;

procedure Ts0CustomCanvasDelegate.DrawFocusRect(const Rect: TRect);
begin
	FDelegate.DrawFocusRect(Rect);
end;

procedure Ts0CustomCanvasDelegate.Ellipse(const Rect: TRect);
begin
	FDelegate.Ellipse(Rect);
end;

procedure Ts0CustomCanvasDelegate.Ellipse(X1, Y1, X2, Y2: Integer);
begin
	FDelegate.Ellipse(X1, Y1, X2, Y2);
end;

procedure Ts0CustomCanvasDelegate.FillRect(const Rect: TRect);
begin
  FDelegate.FillRect(Rect);
end;

procedure Ts0CustomCanvasDelegate.FloodFill(X, Y: Integer; Color: TColor;
  FillStyle: TFillStyle);
begin
	FDelegate.FloodFill(X, Y, Color, FillStyle);
end;

procedure Ts0CustomCanvasDelegate.FrameRect(const Rect: TRect);
begin
	FDelegate.FrameRect(Rect);
end;

function Ts0CustomCanvasDelegate.GetBrush: TBrush;
begin
	Result := FDelegate.Brush;
end;

function Ts0CustomCanvasDelegate.GetCanvasOrientation: TCanvasOrientation;
begin
	Result := FDelegate.CanvasOrientation;
end;

function Ts0CustomCanvasDelegate.GetClipRect: TRect;
begin
	Result := FDelegate.ClipRect;
end;

function Ts0CustomCanvasDelegate.GetCopyMode: TCopyMode;
begin
	Result := FDelegate.CopyMode;
end;

function Ts0CustomCanvasDelegate.GetFont: TFont;
begin
	Result := FDelegate.Font;
end;

function Ts0CustomCanvasDelegate.GetHandle: HDC;
begin
	Result := FDelegate.Handle;
end;

function Ts0CustomCanvasDelegate.GetLockCount: Integer;
begin
	Result := FDelegate.LockCount;
end;

function Ts0CustomCanvasDelegate.GetOnChange: TNotifyEvent;
begin
	Result := FDelegate.OnChange;
end;

function Ts0CustomCanvasDelegate.GetOnChanging: TNotifyEvent;
begin
	Result := FDelegate.OnChanging;
end;

function Ts0CustomCanvasDelegate.GetPen: TPen;
begin
	Result := FDelegate.Pen;
end;

function Ts0CustomCanvasDelegate.GetPenPos: TPoint;
begin
	Result := FDelegate.PenPos;
end;

function Ts0CustomCanvasDelegate.GetPixel(X, Y: Integer): TColor;
begin
	Result := FDelegate.Pixels[X, Y];
end;

function Ts0CustomCanvasDelegate.GetTextFlags: Longint;
begin
	Result := FDelegate.TextFlags;
end;

procedure Ts0CustomCanvasDelegate.LineTo(X, Y: Integer);
begin
	FDelegate.LineTo(X, Y);
end;

procedure Ts0CustomCanvasDelegate.Lock;
begin
	FDelegate.Lock;
end;

procedure Ts0CustomCanvasDelegate.MoveTo(X, Y: Integer);
begin
	FDelegate.MoveTo(X, Y);
end;

procedure Ts0CustomCanvasDelegate.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
	FDelegate.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure Ts0CustomCanvasDelegate.PolyBezier(const Points: array of TPoint);
begin
	FDelegate.PolyBezier(Points);
end;

procedure Ts0CustomCanvasDelegate.PolyBezierTo(const Points: array of TPoint);
begin
	FDelegate.PolyBezierTo(Points);
end;

procedure Ts0CustomCanvasDelegate.Polygon(const Points: array of TPoint);
begin
	FDelegate.Polygon(Points);
end;

procedure Ts0CustomCanvasDelegate.Polyline(const Points: array of TPoint);
begin
	FDelegate.Polyline(Points);
end;

procedure Ts0CustomCanvasDelegate.Rectangle(X1, Y1, X2, Y2: Integer);
begin
	FDelegate.Rectangle(X1, Y1, X2, Y2);
end;

procedure Ts0CustomCanvasDelegate.Rectangle(const Rect: TRect);
begin
	FDelegate.Rectangle(Rect);
end;

procedure Ts0CustomCanvasDelegate.Refresh;
begin
	FDelegate.Refresh;
end;

procedure Ts0CustomCanvasDelegate.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
	FDelegate.RoundRect(X1, Y1, X2, Y2, X3, Y3);
end;

procedure Ts0CustomCanvasDelegate.SetBrush(const Value: TBrush);
begin
	FDelegate.Brush := Value;
end;

procedure Ts0CustomCanvasDelegate.SetCopyMode(const Value: TCopyMode);
begin
	FDelegate.CopyMode := Value;
end;

procedure Ts0CustomCanvasDelegate.SetFont(const Value: TFont);
begin
	FDelegate.Font := Value;
end;

procedure Ts0CustomCanvasDelegate.SetHandle(const Value: HDC);
begin
	FDelegate.Handle := Value;
end;

procedure Ts0CustomCanvasDelegate.SetOnChange(const Value: TNotifyEvent);
begin
	FDelegate.OnChange := Value;
end;

procedure Ts0CustomCanvasDelegate.SetOnChanging(const Value: TNotifyEvent);
begin
	FDelegate.OnChanging := Value;
end;

procedure Ts0CustomCanvasDelegate.SetPen(const Value: TPen);
begin
	FDelegate.Pen := Value;
end;

procedure Ts0CustomCanvasDelegate.SetPenPos(const Value: TPoint);
begin
	FDelegate.PenPos := Value;
end;

procedure Ts0CustomCanvasDelegate.SetPixel(X, Y: Integer; const Value: TColor);
begin
	FDelegate.Pixels[X, Y] := Value;
end;

procedure Ts0CustomCanvasDelegate.SetTextFlags(const Value: Longint);
begin
	FDelegate.TextFlags := Value;
end;

procedure Ts0CustomCanvasDelegate.StretchDraw(const Rect: TRect;
  Graphic: TGraphic);
begin
	FDelegate.StretchDraw(Rect, Graphic);
end;

function Ts0CustomCanvasDelegate.TextExtent(const Text: string): TSize;
begin
	Result := FDelegate.TextExtent(Text);
end;

function Ts0CustomCanvasDelegate.TextHeight(const Text: string): Integer;
begin
	Result := FDelegate.TextHeight(Text);
end;

procedure Ts0CustomCanvasDelegate.TextOut(X, Y: Integer; const Text: string);
begin
	FDelegate.TextOut(X, Y, Text);
end;

procedure Ts0CustomCanvasDelegate.TextRect(Rect: TRect; X, Y: Integer;
  const Text: string);
begin
	FDelegate.TextRect(Rect, X, Y, Text);
end;

function Ts0CustomCanvasDelegate.TextWidth(const Text: string): Integer;
begin
	Result := FDelegate.TextWidth(Text);
end;

function Ts0CustomCanvasDelegate.TryLock: Boolean;
begin
	Result := FDelegate.TryLock;
end;

procedure Ts0CustomCanvasDelegate.Unlock;
begin
	FDelegate.Unlock;
end;

end.
