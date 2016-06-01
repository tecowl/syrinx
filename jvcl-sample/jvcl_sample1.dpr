program jvcl_sample1;

uses
  Forms,
  jvcl_sampleForm1 in 'jvcl_sampleForm1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
