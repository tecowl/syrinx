unit tec1DBCheckBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls;

type
  Ttec1DBCheckBox = class(TDBCheckBox)
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
  RegisterComponents('Techno', [Ttec1DBCheckBox]);
end;

{ Ttec1DBCheckBox }

constructor Ttec1DBCheckBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBCheckBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
