unit tec1StringGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Grids, s0CellDecorator, s0BindGrid, s0CtrlGrid, s0DecoGrid, s0BaseGrid;

type
  Ttec1StringGrid = class(Ts0BaseGrid)
  private
    FAlternateRowFontColor: TColor;
    FAlternateRowColor: TColor;
    procedure SetAlternateRowColor(const Value: TColor);
    procedure SetAlternateRowFontColor(const Value: TColor);
  protected
    FAltRowDecorator: Ts0ColorDecorator;
    function NeedAltRowDecorator: Boolean;
    procedure SetupAltRowDecorator;
    procedure Loaded; override;
  public
    constructor Create(AOnwer: TComponent); override;
  published
    property AlternateRowColor: TColor read FAlternateRowColor write
      SetAlternateRowColor default $00DAFCF1;
    property AlternateRowFontColor: TColor read FAlternateRowFontColor write
      SetAlternateRowFontColor default clWindowText;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1StringGrid]);
end;

{ Ttec1StringGrid }

constructor Ttec1StringGrid.Create(AOnwer: TComponent);
begin
	inherited Create(AOnwer);
  FAlternateRowColor := $00DAFCF1;
  FAlternateRowFontColor := clWindowText;
end;

procedure Ttec1StringGrid.Loaded;
begin
  inherited;
  if NeedAltRowDecorator then
    SetupAltRowDecorator;
end;

function Ttec1StringGrid.NeedAltRowDecorator: Boolean;
begin
  Result := (Color <> AlternateRowColor) or (Font.Color <>
    AlternateRowFontColor);
end;

procedure Ttec1StringGrid.SetAlternateRowColor(const Value: TColor);
begin
  FAlternateRowColor := Value;
  if NeedAltRowDecorator then
    SetupAltRowDecorator;
end;

procedure Ttec1StringGrid.SetAlternateRowFontColor(const Value: TColor);
begin
  FAlternateRowFontColor := Value;
  if NeedAltRowDecorator then
    SetupAltRowDecorator;
end;

procedure Ttec1StringGrid.SetupAltRowDecorator;
begin
  if FAltRowDecorator = nil then
    FAltRowDecorator := Ts0ColorDecorator(Self.ColorDecos.Add);
  FAltRowDecorator.StripeRow := True;
  FAltRowDecorator.RegionKind := k0gcrWhole;
  FAltRowDecorator.Color := Self.AlternateRowColor;
  FAltRowDecorator.FontColor := Self.AlternateRowFontColor;
  FAltRowDecorator.ColorIdentifier := 'stripe row';
end;


end.

