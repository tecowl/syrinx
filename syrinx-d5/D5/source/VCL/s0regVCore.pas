unit s0regVCore;

interface

uses
  SysUtils, Classes,
  s0UserImpl;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P DM', [Ts0GUIUserManager]);
end;

end.
