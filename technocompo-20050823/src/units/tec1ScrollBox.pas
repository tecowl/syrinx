unit tec1ScrollBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  Ttec1ScrollBox = class(TScrollBox)
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
  RegisterComponents('Techno', [Ttec1ScrollBox]);
end;

end.
 