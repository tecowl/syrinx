unit tec1FormEventPublisher;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ComponentEventWrapper, s0FormEventPublisher;

type
  Ttec1FormEventPublisher = class(Ts0FormEventPublisher)
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
  RegisterComponents('Techno', [Ttec1FormEventPublisher]);
end;

end.
