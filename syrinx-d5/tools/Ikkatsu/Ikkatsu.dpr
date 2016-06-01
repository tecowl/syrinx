program Ikkatsu;

uses
  Forms,
  s8fIkkatsu in 's8fIkkatsu.pas' {Form1},
  s0Ikkatsu in 's0Ikkatsu.pas',
  s0ColpilerDCC32 in 's0ColpilerDCC32.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
