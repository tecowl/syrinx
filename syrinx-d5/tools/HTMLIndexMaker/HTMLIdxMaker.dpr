program HTMLIdxMaker;

uses
  Forms,
  f8Main in 'f8Main.pas' {frm8Main},
  s0fObjPropEditor in 's0fObjPropEditor.pas' {s0frmObjPropEditor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm8Main, frm8Main);
  Application.Run;
end.
