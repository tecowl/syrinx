unit tec1IniPropStocker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ObjPropStocker, s0IniPropStocker;

type
  Ttec1IniPropStocker = class(Ts0IniPropStocker)
  private
    { Private �錾 }
  protected
    { Protected �錾 }
  public
    { Public �錾 }
  published
    { Published �錾 }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1IniPropStocker]);
end;

end.