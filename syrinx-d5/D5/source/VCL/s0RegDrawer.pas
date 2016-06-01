unit s0RegDrawer;

interface

uses
  SysUtils, Classes,
  s0ControlDrawer,
  s0ControlImage;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Form', [Ts0ControlDrawer, Ts0ControlImage]);
end;

end.
