unit s0FieldImpression;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls;

type
  Ks0ImagePosition = (k9ipTopLeft, k9ipBottomLeft, k9ipTopRight, k9ipBottomRight);

const
	c0DefauleMarginMin = 0;
	c0DefauleMarginMax = 16;

type
  Ts0FieldImpression = class(TGraphicControl)
  private
    FActive: Boolean;
    FControl: TControl;
    FImages: array[Ks0ImagePosition] of TBitmap;
    FTimer: TTimer;
    FStep: Integer;
    FMarginMaxY: Integer;
    FMarginMinX: Integer;
    FMarginMinY: Integer;
    FMarginMaxX: Integer;
    FInterval: Cardinal;
    FColor: TColor;
    procedure SetActive(const Value: Boolean);
    procedure SetControl(const Value: TControl);
    procedure SetMarginMaxX(const Value: Integer);
    procedure SetMarginMaxY(const Value: Integer);
    procedure SetMarginMinX(const Value: Integer);
    procedure SetMarginMinY(const Value: Integer);
    procedure SetStep(const Value: Integer);
    procedure SetInterval(const Value: Cardinal);
    procedure SetColor(const Value: TColor);
  protected
  	FStepIndex: Integer;
  	procedure LoadImages;
  	procedure DestroyImages;
  	procedure TimerOn(Sender: TObject);
    procedure RectChanged;
    procedure RefreshImages;
    procedure ChangeParent(AParent: TWinControl);
  protected
    procedure Loaded; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  	procedure Activate;
  	procedure ActivateOn(AControl: TControl);
  	procedure Deactivate;
  published
  	property Active: Boolean read FActive write SetActive;
    property Color: TColor read FColor write SetColor default clBlack;
    property Control: TControl read FControl write SetControl;
    property Interval: Cardinal read FInterval write SetInterval default 400;
    property Step: Integer read FStep write SetStep default 4;
    property MarginMinX: Integer read FMarginMinX write SetMarginMinX default c0DefauleMarginMin;
    property MarginMinY: Integer read FMarginMinY write SetMarginMinY default c0DefauleMarginMin;
    property MarginMaxX: Integer read FMarginMaxX write SetMarginMaxX default c0DefauleMarginMax;
    property MarginMaxY: Integer read FMarginMaxY write SetMarginMaxY default c0DefauleMarginMax;
  end;

procedure Register;

implementation

{$R s0FieldImpression.res}

const
	c9ImageNames: array[Ks0ImagePosition] of String =
  	('TOPLEFT', 'BOTTOMLEFT', 'TOPRIGHT', 'BOTTOMRIGHT');

procedure Register;
begin
  RegisterComponents('P Form', [Ts0FieldImpression]);
end;

{ Ts0FieldImpression }

procedure Ts0FieldImpression.Activate;
begin
  ActivateOn(Control);
end;

procedure Ts0FieldImpression.ActivateOn(AControl: TControl);
begin
	if FControl = nil then
  	raise Exception.Create('Control is not specified.');
  if AControl.Owner <> Self.Owner then
  	raise Exception.Create('Ownerの異なるコントロールにはFieldImpressionを適用できません。');
  if AControl.Parent <> Self.Parent then
  	ChangeParent(AControl.Parent);
  if FControl <> AControl then
  begin
  	FControl := AControl;
    RectChanged;
  end;
	FTimer.Interval := Self.Interval;
	FTimer.OnTimer := TimerOn;
	FTimer.Enabled := True;
  FActive := True;
end;

procedure Ts0FieldImpression.ChangeParent(AParent: TWinControl);
begin
	//Self.Parent := AParent;
  Self.Parent.RemoveControl(Self);
  AParent.InsertControl(Self);
end;

constructor Ts0FieldImpression.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 100;
  Height := 50;
  FColor := clBlack;
  FStepIndex := 0;
  FStep := 2;
  FMarginMinX := c0DefauleMarginMin;
  FMarginMinY := c0DefauleMarginMin;
  FMarginMaxX := c0DefauleMarginMax;
  FMarginMaxY := c0DefauleMarginMax;
  FInterval := 400;
  FTimer := TTimer.Create(nil);
  LoadImages;
end;

procedure Ts0FieldImpression.Deactivate;
begin
	FTimer.Enabled := False;
  FActive := False;
  Refresh;
end;

destructor Ts0FieldImpression.Destroy;
begin
	FreeAndNil(FTimer);
	DestroyImages;
  inherited;
end;

procedure Ts0FieldImpression.DestroyImages;
var
	i: Ks0ImagePosition;
begin
	for i := Low(Ks0ImagePosition) to High(Ks0ImagePosition) do
  begin
		FreeAndNil(FImages[i]);
  end;
end;

procedure Ts0FieldImpression.Loaded;
begin
  inherited;
  RectChanged;
	if Active and (Control <> nil) then
  	Activate;
end;

procedure Ts0FieldImpression.LoadImages;
var
	i: Ks0ImagePosition;
begin
	for i := Low(Ks0ImagePosition) to High(Ks0ImagePosition) do
  begin
		FImages[i] := TBitmap.Create;
    FImages[i].LoadFromResourceName(HInstance, c9ImageNames[i]);
    FImages[i].Transparent := True;
    FImages[i].TransparentColor := FImages[i].Canvas.Pixels[0,0];
  end;
end;

procedure Ts0FieldImpression.Paint;
const
	imageWidth = 16;
	imageHeight = 16;
var
	dx, dy: Integer;
	mx, my: Integer;
  i: Ks0ImagePosition;
  ps: array[Ks0ImagePosition] of TPoint;
  controlRect: TRect;
begin
  if not FActive then
  	Exit;
  controlRect.Left := FMarginMaxX;
  controlRect.Right := FMarginMaxX + FControl.Width;
  controlRect.Top := FMarginMaxY;
  controlRect.Bottom := FMarginMaxY + FControl.Height;
  dx := FMarginMaxX - FMarginMinX;
  dy := FMarginMaxY - FMarginMinY;
  mx := dx - Round(dx / FStep * FStepIndex);
  my := dy - Round(dy / FStep * FStepIndex);
	for i := Low(Ks0ImagePosition) to High(Ks0ImagePosition) do
  begin
    case i of
      k9ipTopLeft:
      begin
				ps[i].y := controlRect.Top - my;
				ps[i].x := controlRect.Left - mx;
      end;
      k9ipTopRight:
      begin
				ps[i].y := controlRect.Top - my;
				ps[i].x := controlRect.Right + mx - imageWidth;
      end;
      k9ipBottomLeft:
      begin
				ps[i].y := controlRect.Bottom + my - imageHeight;
				ps[i].x := controlRect.Left - mx;
      end;
      k9ipBottomRight:
      begin
				ps[i].y := controlRect.Bottom + my - imageHeight;
				ps[i].x := controlRect.Right + mx - imageWidth;;
      end;
    end;
  end;
	for i := Low(Ks0ImagePosition) to High(Ks0ImagePosition) do
  begin
    Canvas.Draw(ps[i].x, ps[i].y, FImages[i]);
  end;
end;

procedure Ts0FieldImpression.RectChanged;
begin
	if csLoading in Self.ComponentState then
  	Exit;
	if FControl = nil then
  	Exit;
  Self.Left := FControl.Left - FMarginMaxX;
  Self.Top := FControl.Top - FMarginMaxY;
  Self.Width := FControl.Width + FMarginMaxX * 2;
  Self.Height := FControl.Height + FMarginMaxY * 2;
end;

procedure Ts0FieldImpression.RefreshImages;
const
	baseColor = clBlack;
var
	i: Ks0ImagePosition;
  x, y: Integer;
  img: TBitmap;
  cnvs: TCanvas;
begin
	LoadImages;
	for i := Low(Ks0ImagePosition) to High(Ks0ImagePosition) do
  begin
    img := FImages[i];
    cnvs := img.Canvas;
  	for y := 0 to img.Height -1 do
    begin
      for x := 0 to img.Width -1 do
      begin
				if cnvs.Pixels[x, y] = baseColor then
        	cnvs.Pixels[x, y] := Self.Color;
      end;
    end;
  end;
  Refresh;
end;

procedure Ts0FieldImpression.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if csLoading in Self.ComponentState then
  	Exit;
  if FActive then
  	Activate
  else
  	Deactivate;
end;

procedure Ts0FieldImpression.SetColor(const Value: TColor);
begin
  FColor := Value;
  RefreshImages;
end;

procedure Ts0FieldImpression.SetControl(const Value: TControl);
begin
  FControl := Value;
  if FControl = nil then
  begin
    if Active then
    	Deactivate;
  end
  else
  begin
    RectChanged;
  end;
end;

procedure Ts0FieldImpression.SetInterval(const Value: Cardinal);
begin
  FInterval := Value;
end;

procedure Ts0FieldImpression.SetMarginMaxX(const Value: Integer);
begin
  FMarginMaxX := Value;
  RectChanged;
end;

procedure Ts0FieldImpression.SetMarginMaxY(const Value: Integer);
begin
  FMarginMaxY := Value;
  RectChanged;
end;

procedure Ts0FieldImpression.SetMarginMinX(const Value: Integer);
begin
  FMarginMinX := Value;
end;

procedure Ts0FieldImpression.SetMarginMinY(const Value: Integer);
begin
  FMarginMinY := Value;
end;

procedure Ts0FieldImpression.SetStep(const Value: Integer);
begin
  FStep := Value;
end;

procedure Ts0FieldImpression.TimerOn(Sender: TObject);
begin
	FStepIndex := FStepIndex + 1;
  if FStepIndex >= FStep then
  	FStepIndex := 0;
  Refresh;
end;

end.
