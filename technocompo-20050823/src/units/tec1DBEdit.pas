unit tec1DBEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls;

type
  Ttec1DBEdit = class(TDBEdit)
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
  RegisterComponents('Techno', [Ttec1DBEdit]);
end;

{ Ttec1DBEdit }

constructor Ttec1DBEdit.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBEdit.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
