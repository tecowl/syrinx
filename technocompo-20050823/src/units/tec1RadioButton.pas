unit tec1RadioButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0RadioButton;

type
  Ttec1RadioButton = class(Ts0RadioButton)
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
  RegisterComponents('Techno', [Ttec1RadioButton]);
end;

{ Ttec1RadioButton }

constructor Ttec1RadioButton.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1RadioButton.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
