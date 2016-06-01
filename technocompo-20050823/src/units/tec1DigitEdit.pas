unit tec1DigitEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0Edit, s0DigitEdit;

type
  Ttec1DigitEdit = class(Ts0DigitEdit)
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
  RegisterComponents('Techno', [Ttec1DigitEdit]);
end;

{ Ttec1DigitEdit }

constructor Ttec1DigitEdit.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DigitEdit.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
