unit tec1TreeView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  Ttec1TreeView = class(TTreeView)
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
  RegisterComponents('Techno', [Ttec1TreeView]);
end;

{ Ttec1TreeView }

constructor Ttec1TreeView.Create(AOwner: TComponent);
begin
  inherited;
  Self.Ctl3D := False;
end;

procedure Ttec1TreeView.Loaded;
begin
  inherited;
  Self.Ctl3D := False;
end;

end.
