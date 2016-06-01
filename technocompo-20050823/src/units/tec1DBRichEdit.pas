unit tec1DBRichEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, DBCtrls;

type
  Ttec1DBRichEdit = class(TDBRichEdit)
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
  RegisterComponents('Techno', [Ttec1DBRichEdit]);
end;

{ Ttec1DBRichEdit }

constructor Ttec1DBRichEdit.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBRichEdit.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
