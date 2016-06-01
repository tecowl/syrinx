program SVMMain;

uses
  Forms,
  f8VerManMain in 'f8VerManMain.pas' {frm8VerManMain},
  c0SXVersionCopy in '..\..\c0SXVersionCopy.pas',
  c0SXVersionManager in '..\..\c0SXVersionManager.pas',
  f8VersionHistory in 'f8VersionHistory.pas' {frm8VersionHistory};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Small Version Manager';
  Application.CreateForm(Tfrm8VerManMain, frm8VerManMain);
  Application.CreateForm(Tfrm8VersionHistory, frm8VersionHistory);
  Application.Run;
end.
