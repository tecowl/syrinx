program SrcReplacer;

{%File 'readme.txt'}

uses
  Forms,
  f8SrcReplacer in 'f8SrcReplacer.pas' {frm8SrcReplacer},
  d8SrcReplacer in 'd8SrcReplacer.pas' {dm8SrcReplacer: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tdm8SrcReplacer, dm8SrcReplacer);
  Application.CreateForm(Tfrm8SrcReplacer, frm8SrcReplacer);
  Application.Run;
end.
