unit tec1RichEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  Ttec1RichEdit = class(TRichEdit)
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
  RegisterComponents('Techno', [Ttec1RichEdit]);
end;

{ Ttec1RichEdit }

constructor Ttec1RichEdit.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1RichEdit.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
