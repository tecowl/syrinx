unit tec1DateTimePicker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  Ttec1DateTimePicker = class(TDateTimePicker)
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
  RegisterComponents('Techno', [Ttec1DateTimePicker]);
end;

{ Ttec1DateTimePicker }

constructor Ttec1DateTimePicker.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DateTimePicker.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
