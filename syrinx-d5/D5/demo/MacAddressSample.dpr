program MacAddressSample;

uses
  Forms,
  f8MacAddress in 'f8MacAddress.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
