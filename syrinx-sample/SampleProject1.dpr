program SampleProject1;

uses
  Forms,
  sample_form1 in 'sample_form1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
