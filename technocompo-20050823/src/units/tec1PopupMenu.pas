unit tec1PopupMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  Ttec1PopupMenu = class(TPopupMenu)
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
  RegisterComponents('Techno', [Ttec1PopupMenu]);
end;

end.
