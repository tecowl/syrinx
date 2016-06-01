unit s0fBalloonDlg;
{
$History: s0fBalloonDlg.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0control
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 *
 * *****************  Version 5  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマ ンド追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, c0SXFormRgn, Buttons, Menus, //c0SXFormSeeThrough,
  s0CommonTypes,
  s0ButtonPanel;

type
  K0BalloonRegionKind = (k1brkRound, k1brkBox);

type
  K0BalloonDirection = K0GUIPosition;

type
  Ts0frmBalloonDlg = class(TForm)
    lblMessage: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgnFromMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rgnFromMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FDowned: TPoint;
    FRegionKind: K0BalloonRegionKind;
    FBalloonColor: TColor;
    FDirection: K0BalloonDirection;
    procedure SetRegionKind(const Value: K0BalloonRegionKind);
    procedure SetMessage(const Value: string);
    function GetMessage: string;
    procedure SetBalloonColor(const Value: TColor);
    procedure SetDirection(const Value: K0BalloonDirection);
  protected
    procedure ChangeFormRegion;
  public
    property BalloonColor: TColor read FBalloonColor write SetBalloonColor
      default clBtnFace;
    property Direction: K0BalloonDirection read FDirection write SetDirection;
    property Message: string read GetMessage write SetMessage;
    property RegionKind: K0BalloonRegionKind read FRegionKind write SetRegionKind
      default k1brkBox;
  end;

var
  frm0BalloonDlg: Ts0frmBalloonDlg;

implementation

{$R *.DFM}

{ TForm2 }

procedure Ts0frmBalloonDlg.SetRegionKind(const Value: K0BalloonRegionKind);
begin
  FRegionKind := Value;
  rgnFrom.Visible := False;
end;

procedure Ts0frmBalloonDlg.FormCreate(Sender: TObject);
begin
  RegionKind := k1brkBox; //k1brkRound;
  SetBalloonColor(clBtnFace);
end;

procedure Ts0frmBalloonDlg.SetMessage(const Value: string);
begin
  lblMessage.Caption := Value;
end;

function Ts0frmBalloonDlg.GetMessage: string;
begin
  Result := lblMessage.Caption;
end;

procedure Ts0frmBalloonDlg.FormShow(Sender: TObject);
begin
  SetRegionKind(FRegionKind);
  //FillColor(rgnFrom.Picture.Bitmap, FBalloonColor);
  ChangeFormRegion;
  rgnFrom.CreateRgn;
  rgnFrom.UpdateRgn;
end;

procedure Ts0frmBalloonDlg.rgnFromMouseDown(Sender: TObject; Button:
  TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDowned := Point(X, Y);

end;

procedure Ts0frmBalloonDlg.rgnFromMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Self.SetBounds(
    Self.Left + X - FDowned.x,
    Self.Top + Y - FDowned.y,
    Width,
    Height
    );
end;

procedure Ts0frmBalloonDlg.SetBalloonColor(const Value: TColor);
begin
  FBalloonColor := Value;
  Self.Color := Value;
end;

procedure Ts0frmBalloonDlg.SetDirection(const Value: K0BalloonDirection);
begin
  FDirection := Value;
  case FRegionKind of
    k1brkRound:
      if FDirection = k0posTop then
        FDirection := k0posLeft
      else if FDirection = k0posBottom then
        FDirection := k0posRight;

    k1brkBox:
      if FDirection = k0posLeft then
        FDirection := k0posTop
      else if FDirection = k0posRight then
        FDirection := k0posBottom;
  end;
end;

procedure Ts0frmBalloonDlg.ChangeFormRegion;
const
  c9DirectionWidth = 20;
  c9RoundRadius = 5;
var
  bmp: TBitmap;
  xm2, xm1, xzr, xp1, xp2: Integer;
  ym2, ym1, yzr, yp1, yp2: Integer;
  dw, dh: Integer;
  p0, p1, p2: TPoint;
begin
  bmp := TBitmap.Create;
  try
    bmp.Width := Self.ClientWidth - 10;
    bmp.Height := Self.ClientHeight - 10;

    bmp.Canvas.Pen.Color := clBlack;
    bmp.Canvas.Brush.Color := clBtnFace;

    xm2 := 0;
    xm1 := c9DirectionWidth;
    xzr := bmp.Width div 2;
    xp1 := bmp.Width - c9DirectionWidth;
    xp2 := bmp.Width;

    ym2 := 0;
    ym1 := c9DirectionWidth;
    yzr := bmp.Height div 2;
    yp1 := bmp.Height - c9DirectionWidth;
    yp2 := bmp.Height;

    dw := xzr - c9DirectionWidth;
    dh := yzr - c9DirectionWidth;

    case FDirection of
      k0posTop:
        begin
          p0 := Point(xzr - dw, yzr);
          p1 := Point(xp1 - dw, yzr);
          p2 := Point(xzr - dw, yp2);
        end;
      k0posBottom:
        begin
          p0 := Point(xzr + dw, yzr);
          p1 := Point(xm1 + dw, yzr);
          p2 := Point(xzr + dw, ym2);
        end;
      k0posLeft:
        begin
          p0 := Point(xzr, yzr + dh);
          p1 := Point(xzr, ym1 + dh);
          p2 := Point(xp2, yzr + dh);
        end;
      k0posRight:
        begin
          p0 := Point(xzr, yzr - dh);
          p1 := Point(xzr, yp1 - dh);
          p2 := Point(xm2, yzr - dh);
        end;
    end;

    bmp.Canvas.Polygon([p0, p1, p2]);
    case FRegionKind of
      k1brkRound: bmp.Canvas.Ellipse(xm1, ym1, xp1, yp1);
      k1brkBox: bmp.Canvas.RoundRect(xm1, ym1, xp1, yp1, c9RoundRadius,
        c9RoundRadius);
    end;
    rgnFrom.Picture.Bitmap.Assign(bmp);
  finally
    FreeAndNil(bmp);
  end;
end;

end.
