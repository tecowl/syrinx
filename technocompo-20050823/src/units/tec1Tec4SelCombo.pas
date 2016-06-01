unit tec1Tec4SelCombo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Tec4SelCombo;

type
  Ttec1Tec4SelCombo = class(TTec4SelCombo)
  private
  protected
  	procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  	property Ctl3D stored False default False;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1Tec4SelCombo]);
end;

{ Ttec1Tec4SelCombo }

constructor Ttec1Tec4SelCombo.Create(AOwner: TComponent);
begin
  inherited;
  Self.Ctl3D := False;
end;

procedure Ttec1Tec4SelCombo.Loaded;
begin
  inherited;
  Self.Ctl3D := False;
end;

end.
