program TechnoCompoDemo;

uses
  Forms,
  f8DemoForm in 'f8DemoForm.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
