unit tec1DBComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls;

type
  Ttec1DBComboBox = class(TDBComboBox)
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
  RegisterComponents('Techno', [Ttec1DBComboBox]);
end;

{ Ttec1DBComboBox }

constructor Ttec1DBComboBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBComboBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
