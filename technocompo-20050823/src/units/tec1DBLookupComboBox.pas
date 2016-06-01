unit tec1DBLookupComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls;

type
  Ttec1DBLookupComboBox = class(TDBLookupComboBox)
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
  RegisterComponents('Techno', [Ttec1DBLookupComboBox]);
end;

{ Ttec1DBLookupComboBox }

constructor Ttec1DBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBLookupComboBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
