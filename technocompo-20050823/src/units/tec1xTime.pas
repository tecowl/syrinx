unit tec1xTime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CustomComplexCtrl, s0DateEdit, tec1DateEdit;

type
  Ttec1xTime = class(Ttec1DateEdit)
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
  RegisterComponents('Techno', [Ttec1xTime]);
end;

{ Ttec1xTime }

constructor Ttec1xTime.Create(AOwner: TComponent);
begin
  inherited;
  Self.Ctl3D := False;
end;

procedure Ttec1xTime.Loaded;
begin
  inherited;
  Self.Ctl3D := False;
end;

end.

