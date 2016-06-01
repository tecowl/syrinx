unit tec1CheckListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, s0CheckListBox;

type
  Ttec1CheckListBox = class(Ts0CheckListBox)
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
  RegisterComponents('Techno', [Ttec1CheckListBox]);
end;

{ Ttec1CheckListBox }

constructor Ttec1CheckListBox.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1CheckListBox.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
