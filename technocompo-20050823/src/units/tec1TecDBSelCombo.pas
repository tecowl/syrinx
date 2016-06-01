unit tec1TecDBSelCombo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComboBox;

type
  Ttec1TecDBSelCombo = class(TTecDBSelCombo)
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
  RegisterComponents('Techno', [Ttec1TecDBSelCombo]);
end;

{ Ttec1TecDBSelCombo }

constructor Ttec1TecDBSelCombo.Create(AOwner: TComponent);
begin
  inherited;
  Self.Ctl3D := False;
end;

procedure Ttec1TecDBSelCombo.Loaded;
begin
  inherited;
  Self.Ctl3D := False;
end;

end.
