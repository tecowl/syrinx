program PWGenrator;

uses
  Forms,
  f8PWGenrator in 'f8PWGenrator.pas' {Form5},
  u8Encrypt in 'u8Encrypt.pas',
  DCPsha1 in 'DCPsha1.pas',
  DCPrc4 in 'DCPrc4.pas',
  DCPcrypt2 in 'DCPcrypt2.pas',
  DCPbase64 in 'DCPbase64.pas',
  DCPconst in 'DCPconst.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
