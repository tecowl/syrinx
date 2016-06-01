program PasswordSample;

uses
  Forms,
  Dialogs,
  f8Password in 'f8Password.pas' {Form4},
  u8MacAddress in 'u8MacAddress.pas',
  c8PWController in 'c8PWController.pas',
  u8PWConst in 'u8PWConst.pas',
  DCPsha1 in 'DCPsha1.pas',
  DCPbase64 in 'DCPbase64.pas',
  DCPconst in 'DCPconst.pas',
  DCPcrypt2 in 'DCPcrypt2.pas',
  DCPrc4 in 'DCPrc4.pas',
  u8Encrypt in 'u8Encrypt.pas';

{$R *.RES}

begin
  Application.Initialize;
	if not T8PWControllerFactory.GetSingletonOfForm(True).CanStart then
  begin
  	ShowMessage('Application cannot be started');
    Exit;
  end;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
