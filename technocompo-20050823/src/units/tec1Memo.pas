unit tec1Memo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0Memo;

type
  Ttec1Memo = class(Ts0Memo)
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
  RegisterComponents('Techno', [Ttec1Memo]);
end;

{ Ttec1Memo }

constructor Ttec1Memo.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1Memo.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
