unit tec1DBRadioGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls;

type
  Ttec1DBRadioGroup = class(TDBRadioGroup)
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
  RegisterComponents('Techno', [Ttec1DBRadioGroup]);
end;

{ Ttec1DBRadioGroup }

constructor Ttec1DBRadioGroup.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBRadioGroup.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
