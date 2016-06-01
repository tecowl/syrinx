unit tec1BitBtn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Ttec1BitBtn = class(TBitBtn)
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
  RegisterComponents('Techno', [Ttec1BitBtn]);
end;

{ Ttec1BitBtn }

constructor Ttec1BitBtn.Create(AOwner: TComponent);
begin
  inherited;
  Self.Ctl3D := False;
end;

procedure Ttec1BitBtn.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
