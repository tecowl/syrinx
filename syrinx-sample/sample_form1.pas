unit sample_form1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, s0VCLClasses, s0CtrlDragger, s0AppInstance,
  s0ComponentEventWrapper, s0FormEventPublisher, s0ObjPropStocker,
  s0IniPropStocker, s0Panel, s0ControlProxy, s0ControlDrawer;

type
  TForm1 = class(TForm)
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0CtrlDragger1: Ts0CtrlDragger;
    s0AppInstance1: Ts0AppInstance;
    s0Panel1: Ts0Panel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
	s0CtrlDragger1.BeginDragging;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
	s0CtrlDragger1.EndDragging;
end;

end.
