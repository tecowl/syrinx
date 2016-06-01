program TaskTracker;

uses
  Forms,
  f8TaskTracker in 'f8TaskTracker.pas' {frm8Main},
  d8TaskTracker in 'd8TaskTracker.pas' {dm8TaskTracker: TDataModule},
  s0fObjPropEditor in '..\..\Forms\s0fObjPropEditor.pas' {frm0ObjPropEditor},
  s0fObjEditor in '..\..\Forms\s0fObjEditor.pas' {frm0ObjEditor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tdm8TaskTracker, dm8TaskTracker);
  Application.CreateForm(Tfrm8Main, frm8Main);
  Application.Run;
end.
