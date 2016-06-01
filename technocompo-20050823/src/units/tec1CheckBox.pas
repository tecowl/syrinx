unit tec1CheckBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0CheckBox;

type
  Ttec1CheckBox = class(Ts0CheckBox)
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
  RegisterComponents('Techno', [Ttec1CheckBox]);
end;

{ Ttec1CheckBox }

constructor Ttec1CheckBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1CheckBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
