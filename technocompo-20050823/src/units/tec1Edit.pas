unit tec1Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0Edit;

type
  Ttec1Edit = class(Ts0Edit)
  private
    function GetFrame: Boolean;
    procedure SetFrame(const Value: Boolean);
  protected
  	procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  	property AutoWidth stored False default False;
  	property Ctl3D stored False default False;
    property Frame: Boolean read GetFrame write SetFrame stored False;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1Edit]);
end;

{ Ttec1Edit }

constructor Ttec1Edit.Create(AOwner: TComponent);
begin
  inherited;
  AutoWidth := False;
end;

function Ttec1Edit.GetFrame: Boolean;
begin
	Result := False;
end;

procedure Ttec1Edit.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
  Self.AutoWidth := False;
end;

procedure Ttec1Edit.SetFrame(const Value: Boolean);
begin
end;

end.
