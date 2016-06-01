unit s0GraphHelper;
{
$History: s0GraphHelper.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/12/05   Time: 18:49
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0control
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/30   Time: 10:10
 * Updated in $/source/p0control
 * 以下のメソッドを追加
 * ParallelTranslatePoint、
 * ParallelTranslateRect、
 * MagnifyPoint、
 * MagnifyRect、
 * ReduceTranslateRect
 * 
 * 以下のクラスを追加
 * Ts0Rect
 *
 * *****************  Version 5  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマ ンド追加
}

interface

uses
  Windows,
  Classes;

function IsIntersect(ARect1, ARect2: TRect): Boolean;
function IsBetween(AValue, AMin, AMax: Integer; MinusIsInfinity: Boolean =
  False): Boolean;
function IsInRect(APos: TPoint; ARect: TRect; MinusIsInfinity: Boolean = False):
  Boolean;
{
function IsOnRectEdge(APos: TPoint; ARect: TRect; AEdge: K0GUIPosition;
  MinusIsInfinity: Boolean = False): Boolean;
function EdgeOfRect(APos: TPoint; ARect: TRect): K0GUIPositionSet;

procedure GetLineFromRect(const ARect: TRect; const APosition: K0GUIPosition; var
  p1, p2: TPoint);
}

procedure ParallelTranslatePoint(var APoint: TPoint; AX, AY: Integer);
procedure ParallelTranslateRect(var ARect: TRect; AX, AY: Integer);
procedure MagnifyPoint(var APoint: TPoint; XRaito, YRaito: Extended);
procedure MagnifyRect(var ARect: TRect; XRaito, YRaito: Extended);
procedure ReduceTranslateRect(var ARect: TRect; Margin: Integer);


type
  Ts0Rect = class
  private
    FRect: TRect;
  protected
    procedure SetPosition(const Index, Value: Integer);
    procedure SetAsRect(const Value: TRect);
  public
    constructor Create(ARect: TRect);
    property Top   : Integer index 0 read FRect.Top    write SetPosition;
    property Left  : Integer index 1 read FRect.Left   write SetPosition;
    property Right : Integer index 2 read FRect.Right  write SetPosition;
    property Bottom: Integer index 3 read FRect.Bottom write SetPosition;
    property AsRect: TRect read FRect write SetAsRect;
  end;


implementation

function IsIntersect(ARect1, ARect2: TRect): Boolean;
var
  lDummy: TRect;
begin
  Result := Windows.IntersectRect(lDummy, ARect1, ARect2);
end;

function IsBetween(AValue, AMin, AMax: Integer; MinusIsInfinity: Boolean =
  False): Boolean;
begin
  if MinusIsInfinity then
    Result := ((AMin < 0) or (AMin <= AValue)) and ((AMax < 0) or (AMax >=
      AValue))
  else
    Result := (AMin <= AValue) and (AMax >= AValue);
end;

function IsInRect(APos: TPoint; ARect: TRect; MinusIsInfinity: Boolean):
  Boolean;
var
  rl, rt, rr, rb: Boolean;
begin
  if MinusIsInfinity then
  begin
    rl := (ARect.Left < 0) or (APos.x >= ARect.Left);
    rt := (ARect.Right < 0) or (APos.x <= ARect.Right);
    rr := (ARect.Top < 0) or (APos.y >= ARect.Top);
    rb := (ARect.Bottom < 0) or (APos.y <= ARect.Bottom);
  end
  else
  begin
    rl := (APos.x >= ARect.Left);
    rt := (APos.x <= ARect.Right);
    rr := (APos.y >= ARect.Top);
    rb := (APos.y <= ARect.Bottom);
  end;
  Result := rl and rt and rr and rb;
end;

{
procedure GetLineFromRect(const ARect: TRect; const APosition: K0GUIPosition; var
  p1, p2: TPoint);
begin
  case APosition of
    k0posTop: p1 := Point(ARect.Left, ARect.Top);
    k0posBottom: p1 := Point(ARect.Left, ARect.Bottom);
    k0posLeft: p1 := Point(ARect.Left, ARect.Top);
    k0posRight: p1 := Point(ARect.Right, ARect.Top);
  end;
  case APosition of
    k0posTop: p2 := Point(ARect.Right, ARect.Top);
    k0posBottom: p2 := Point(ARect.Right, ARect.Bottom);
    k0posLeft: p2 := Point(ARect.Left, ARect.Bottom);
    k0posRight: p2 := Point(ARect.Right, ARect.Bottom);
  end;
end;

function IsOnRectEdge(APos: TPoint; ARect: TRect; AEdge: K0GUIPosition;
  MinusIsInfinity: Boolean = False): Boolean;
begin
  Result := False;
  if MinusIsInfinity then
  begin
    case AEdge of
      k0posTop: Result := (APos.y = ARect.Top) or (APos.y = 0);
      k0posBottom: Result := (APos.y = ARect.Bottom);
      k0posLeft: Result := (APos.x = ARect.Left) or (APos.x = 0);
      k0posRight: Result := (APos.x = ARect.Right);
    end;
  end
  else
  begin
    case AEdge of
      k0posTop: Result := (APos.y = ARect.Top);
      k0posBottom: Result := (APos.y = ARect.Bottom);
      k0posLeft: Result := (APos.x = ARect.Left);
      k0posRight: Result := (APos.x = ARect.Right);
    end;
  end;
end;

function EdgeOfRect(APos: TPoint; ARect: TRect): K0GUIPositionSet;
var
  i: K0GUIPosition;
begin
  Result := [];
  for i := Low(K0GUIPosition) to High(K0GUIPosition) do
  begin
    if IsOnRectEdge(APos, ARect, i) then
      Include(Result, i);
  end;
end;
}

procedure ParallelTranslatePoint(var APoint: TPoint; AX, AY: Integer);
begin
  APoint.x := APoint.x + AX;
  APoint.y := APoint.y + AY;
end;

procedure ParallelTranslateRect(var ARect: TRect; AX, AY: Integer);
begin
  ParallelTranslatePoint(ARect.TopLeft, AX, AY);
  ParallelTranslatePoint(ARect.BottomRight, AX, AY);
end;

procedure MagnifyPoint(var APoint: TPoint; XRaito, YRaito: Extended);
begin
  APoint.x := Trunc(APoint.x * XRaito);
  APoint.y := Trunc(APoint.y * YRaito);
end;

procedure MagnifyRect(var ARect: TRect; XRaito, YRaito: Extended);
begin
  MagnifyPoint(ARect.TopLeft, XRaito, YRaito);
  MagnifyPoint(ARect.BottomRight, XRaito, YRaito);
end;

procedure ReduceTranslateRect(var ARect: TRect; Margin: Integer);
begin
  ARect.Top := ARect.Top + Margin;
  ARect.Left := ARect.Left + Margin;
  ARect.Right := ARect.Right - Margin;
  ARect.Bottom := ARect.Bottom - Margin;
end;

{ Ts0Rect }

constructor Ts0Rect.Create(ARect: TRect);
begin
  FRect := ARect;
end;

procedure Ts0Rect.SetAsRect(const Value: TRect);
begin
  FRect := Value;
end;

procedure Ts0Rect.SetPosition(const Index, Value: Integer);
begin
  case Index of
    0: FRect.Top    := Value;
    1: FRect.Left   := Value;
    2: FRect.Right  := Value;
    3: FRect.Bottom := Value;
  end;
end;

end.

