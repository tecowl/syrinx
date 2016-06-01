unit tec1DBLookupListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls;

type
  Ttec1DBLookupListBox = class(TDBLookupListBox)
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
  RegisterComponents('Techno', [Ttec1DBLookupListBox]);
end;

{ Ttec1DBLookupListBox }

constructor Ttec1DBLookupListBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBLookupListBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
