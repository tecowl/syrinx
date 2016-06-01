unit s0RegEntityCtrl;

interface

uses
  SysUtils, Classes,
  s0EntityDetailImpl,
  s0EntityFormManager,
  s0EntityListImpl,
  s0NaviSelector,
  s0NaviSelEdit;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Entity', [
    Ts0EntityDetailImpl,
    Ts0EntityFormManager,
    Ts0EntityListImpl,
    Ts0NaviSelector,
    Ts0NaviEdit
  ]);
end;

end.
