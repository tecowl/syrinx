unit tec1FormEventPublisher;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ComponentEventWrapper, s0FormEventPublisher;

type
  Ttec1FormEventPublisher = class(Ts0FormEventPublisher)
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
  RegisterComponents('Techno', [Ttec1FormEventPublisher]);
end;

end.
