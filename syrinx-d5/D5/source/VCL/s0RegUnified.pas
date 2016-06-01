unit s0RegUnified;

interface

uses
  SysUtils, Classes,
  s0UnifiedObjCtrl;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Form', [Ts0UnifiedObjCtrl]);
end;

end.
