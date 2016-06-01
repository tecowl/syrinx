unit tec1GroupBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0GroupBox;

type
  Ttec1GroupBox = class(Ts0GroupBox)
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
  RegisterComponents('Techno', [Ttec1GroupBox]);
end;

{ Ttec1GroupBox }

constructor Ttec1GroupBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1GroupBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
