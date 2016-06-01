unit tec1MaskEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask;

type
  Ttec1MaskEdit = class(TMaskEdit)
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
  RegisterComponents('Techno', [Ttec1MaskEdit]);
end;

{ Ttec1MaskEdit }

constructor Ttec1MaskEdit.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1MaskEdit.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
