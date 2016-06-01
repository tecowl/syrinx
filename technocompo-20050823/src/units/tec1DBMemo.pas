unit tec1DBMemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls;

type
  Ttec1DBMemo = class(TDBMemo)
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
  RegisterComponents('Techno', [Ttec1DBMemo]);
end;

{ Ttec1DBMemo }

constructor Ttec1DBMemo.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
end;

procedure Ttec1DBMemo.Loaded;
begin
  inherited;
	Self.Ctl3D := False;
end;

end.
