program Registration;

uses
  Forms,
  f8Registration in 'f8Registration.pas' {Form1},
  u8PWConst in 'u8PWConst.pas',
  c8PWController in 'c8PWController.pas',
  DCPbase64 in 'DCPbase64.pas',
  DCPconst in 'DCPconst.pas',
  DCPcrypt2 in 'DCPcrypt2.pas',
  DCPrc4 in 'DCPrc4.pas',
  DCPsha1 in 'DCPsha1.pas',
  u8Encrypt in 'u8Encrypt.pas',
  u8MacAddress in 'u8MacAddress.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
