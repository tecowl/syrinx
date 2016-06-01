program dofChange;

uses
  Forms,
  f8dofChange in 'f8dofChange.pas' {Form1},
  s0DofChange in 's0DofChange.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
