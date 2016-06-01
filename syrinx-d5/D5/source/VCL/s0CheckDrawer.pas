unit s0CheckDrawer;

interface

uses
  Windows, SysUtils, Classes, Graphics, StdCtrls;

type
  Ts0CheckDrawer = class
  public
    class procedure DrawTo(ACanvas: TCanvas; ARect: TRect;
      AChecked: TCheckBoxState; AAllowGray: Boolean = True;
      AWithBoxFrame: Boolean = True);
  end;

implementation

{ Ts0CheckDrawer }

class procedure Ts0CheckDrawer.DrawTo(ACanvas: TCanvas; ARect: TRect;
  AChecked: TCheckBoxState; AAllowGray: Boolean; AWithBoxFrame: Boolean);
var
  sx, sy: Integer;
  pcBuf: TColor;
begin
  sx := ARect.Left + (ARect.Right - ARect.Left) div 2;
  sy := ARect.Top + (ARect.Bottom - ARect.Top) div 2;
  pcBuf := ACanvas.Pen.Color;
  try
    ACanvas.FillRect(ARect);
    ACanvas.Pen.Color := clBlack;
    if AWithBoxFrame then
    begin
      ACanvas.Polyline([
        Point(sx-6,sy-6), Point(sx-6,sy+4),
        Point(sx+4,sy+4), Point(sx+4,sy-6), Point(sx-6,sy-6)
      ]);
    end;
    if AAllowGray then
    begin
      case AChecked of
        cbUnchecked: Exit;
        cbChecked  : ;
        cbGrayed   : ACanvas.Pen.Color := clGray;
      end;
    end
    else
    begin
      if AChecked in [cbUnchecked {,cbGrayed} ] then Exit;
    end;
    ACanvas.Polygon([
      Point(sx-4, sy-1), Point(sx-2, sy+0), Point(sx+2, sy-4),
      Point(sx+3, sy-3), Point(sx-2, sy+2), Point(sx-4, sy+0)
    ]);
  finally
    ACanvas.Pen.Color := pcBuf;
  end;
end;

end.
