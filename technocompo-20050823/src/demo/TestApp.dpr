program TestApp;

uses
  Forms,
  f8TestForm in 'f8TestForm.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
