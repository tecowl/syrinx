unit tec1CoolBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls;

type
  Ttec1CoolBar = class(TCoolBar)
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
  RegisterComponents('Techno', [Ttec1CoolBar]);
end;

end.
