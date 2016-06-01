unit s0RegExtCtrl;

interface

uses
	SysUtils, Classes;

procedure Register;

implementation

uses
	s0BarGraph;

procedure Register;
begin
  RegisterComponents('P Form', [Ts0BarGraph]);
end;


end.
