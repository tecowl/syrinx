unit tec1HotKey;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  Ttec1HotKey = class(THotKey)
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
  RegisterComponents('Techno', [Ttec1HotKey]);
end;

end.
