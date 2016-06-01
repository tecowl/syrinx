program s0p_Core50Test;

uses
	Forms,
	TestFrameWork,
	GUITestRunner,
  s0StringsHelperTest in 's0StringsHelperTest.pas';

{$R *.RES}

begin
	Application.Initialize;
	GUITestRunner.RunRegisteredTests;
end.
