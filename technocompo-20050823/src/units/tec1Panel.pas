unit tec1Panel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, s0Panel;

type
  Ttec1Panel = class(Ts0Panel)
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
  RegisterComponents('Techno', [Ttec1Panel]);
end;

{ Ttec1Panel }

constructor Ttec1Panel.Create(AOwner: TComponent);
begin
  inherited;
  Ctl3D := False;
end;

procedure Ttec1Panel.Loaded;
begin
  inherited;
  Ctl3D := False;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
end;

end.
