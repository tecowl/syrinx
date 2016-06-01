unit tec1DBListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls;

type
  Ttec1DBListBox = class(TDBListBox)
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
  RegisterComponents('Techno', [Ttec1DBListBox]);
end;

{ Ttec1DBListBox }

constructor Ttec1DBListBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBListBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
