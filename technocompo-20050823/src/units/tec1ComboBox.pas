unit tec1ComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0ComboBox;

type
  Ttec1ComboBox = class(Ts0ComboBox)
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
  RegisterComponents('Techno', [Ttec1ComboBox]);
end;

{ Ttec1ComboBox }

constructor Ttec1ComboBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1ComboBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
