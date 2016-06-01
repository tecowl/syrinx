program TagTree;

uses
  Forms,
  f8TagTree in 'f8TagTree.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
