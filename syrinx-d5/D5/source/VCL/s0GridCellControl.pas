unit s0GridCellControl;
{
$History: s0GridCellControl.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/01/10   Time: 3:13
 * Updated in $/source/D5Integrated
 * BorderStyle�v���p�e�B��ǉ�
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/06   Time: 0:20
 * Updated in $/source/D5Integrated
 * DrawToCanvas�̈�����AState��ǉ�
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Grids;

type
  Ts0GridCellControl = class(TCustomControl)
  private
    FDrawFixedCells: Boolean;
    FBorderStyle: TBorderStyle;
    procedure SetDrawFixedCells(const Value: Boolean);
    procedure SetBorderStyle(const Value: TBorderStyle);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    function GetCtrlValue: string; virtual;
    procedure SetCtrlValue(const Value: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRect; AState: TGridDrawState; CellValue: string); virtual;
    property CtrlValue: string read GetCtrlValue write SetCtrlValue;
  published
    property DrawFixedCells: Boolean read FDrawFixedCells write SetDrawFixedCells default False;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
  end;

implementation

uses
  Extctrls;

{ Ts0GridCellControl }

constructor Ts0GridCellControl.Create(AOwner: TComponent);
begin
  inherited;
  FDrawFixedCells := False;
  FBorderStyle := bsSingle;
end;

procedure Ts0GridCellControl.CreateParams(var Params: TCreateParams);
const
  c9BorderStyle: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BS_OWNERDRAW or WS_TABSTOP;
    if FBorderStyle = bsNone then Exit;
    if NewStyleControls and Ctl3D then
    begin
      Style := Style and not c9BorderStyle[BorderStyle];
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end
    else
      Style := Style or c9BorderStyle[BorderStyle];
  end;
end;

procedure Ts0GridCellControl.DrawToCanvas(ACanvas: TCanvas; ARect: TRect;
  AState: TGridDrawState; CellValue: string);
begin
end;

function Ts0GridCellControl.GetCtrlValue: string;
begin
  Result := '';
end;

procedure Ts0GridCellControl.Paint;
var
  bc: TColor;
begin
  bc := Canvas.Brush.Color;
  try
    Canvas.Brush.Color := Color;
    Canvas.FillRect(Self.ClientRect);
//    DrawFrame(Self.Canvas, Self.ClientRect);
    DrawToCanvas(Self.Canvas, Self.ClientRect, [], CtrlValue);
    if Screen.ActiveControl = Self then
      Canvas.DrawFocusRect(Self.ClientRect);
  finally
    Brush.Color := bc;
  end;
end;

procedure Ts0GridCellControl.SetBorderStyle(const Value: TBorderStyle);
begin
  FBorderStyle := Value;
  RecreateWnd;
  Invalidate;
end;

procedure Ts0GridCellControl.SetCtrlValue(const Value: string);
begin
end;

procedure Ts0GridCellControl.SetDrawFixedCells(const Value: Boolean);
begin
  FDrawFixedCells := Value;
end;

end.
 
