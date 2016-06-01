unit tec1DateEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CustomComplexCtrl, s0DateEdit;

type
  Ttec1DateEdit = class(Ts0DateEdit)
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
  RegisterComponents('Techno', [Ttec1DateEdit]);
end;

{ Ttec1DateEdit }

constructor Ttec1DateEdit.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
  Color := clWindow;
end;

procedure Ttec1DateEdit.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
