unit tec1Button;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0Button;

type
  Ttec1Button = class(Ts0Button)
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
  RegisterComponents('Techno', [Ttec1Button]);
end;

{ Ttec1Button }

constructor Ttec1Button.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1Button.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
