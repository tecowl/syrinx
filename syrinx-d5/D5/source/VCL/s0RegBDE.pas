unit s0RegBDE;

interface

uses
  SysUtils, Classes,
  s0StoredProc,
  s0Table,
  s0Query;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P DM', [Ts0StoredProc]);
  RegisterComponents('P DM', [Ts0Table]);
  RegisterComponents('P DM', [Ts0Query]);
end;

end.
