unit tec1RadioGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, s0RadioGroup;

type
  Ttec1RadioGroup = class(Ts0RadioGroup)
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
  RegisterComponents('Techno', [Ttec1RadioGroup]);
end;

{ Ttec1RadioGroup }

constructor Ttec1RadioGroup.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1RadioGroup.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
