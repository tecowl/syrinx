unit tec1ListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0ListBox;

type
  Ttec1ListBox = class(Ts0ListBox)
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
  RegisterComponents('Techno', [Ttec1ListBox]);
end;

{ Ttec1ListBox }

constructor Ttec1ListBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1ListBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
