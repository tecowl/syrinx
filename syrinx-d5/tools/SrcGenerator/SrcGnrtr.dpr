program SrcGnrtr;

uses
  Forms,
  f8SrcGnrtrMain in 'f8SrcGnrtrMain.pas' {frm8SrcGnrtr};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm8SrcGnrtr, frm8SrcGnrtr);
  Application.Run;
end.
