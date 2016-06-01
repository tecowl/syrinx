unit tec1IniPropStocker;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ObjPropStocker, s0IniPropStocker;

type
  Ttec1IniPropStocker = class(Ts0IniPropStocker)
  private
    { Private éŒ¾ }
  protected
    { Protected éŒ¾ }
  public
    { Public éŒ¾ }
  published
    { Published éŒ¾ }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1IniPropStocker]);
end;

end.
