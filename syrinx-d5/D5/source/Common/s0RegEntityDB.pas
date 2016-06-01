unit s0RegEntityDB;

interface

uses
  SysUtils, Classes,
  s0DBEntity;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Entity', [Ts0DBEntityManager]);
end;

end.
