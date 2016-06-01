unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  c0ObjPropStocker, c0IniPropStocker, StdCtrls, c0FormEventPublisher;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    c0FormEventPublisher1: Tc0FormEventPublisher;
    c0IniPropStocker1: Tc0IniPropStocker;
    Edit2: TEdit;
    procedure c0IniPropStocker1Items5GetValueToSave(
      Sender: T0ObjPropStockerItem; var AValue: String;
      var ACancel: Boolean);
    procedure c0IniPropStocker1Items5SetValueToLoad(
      Sender: T0ObjPropStockerItem; var AValue: String;
      var ACancel: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private éŒ¾ }
  public
    { Public éŒ¾ }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  u8Options;

procedure TForm1.c0IniPropStocker1Items5GetValueToSave(
  Sender: T0ObjPropStockerItem; var AValue: String; var ACancel: Boolean);
begin
  AValue := DateTimeToStr(Now);
end;

procedure TForm1.c0IniPropStocker1Items5SetValueToLoad(
  Sender: T0ObjPropStockerItem; var AValue: String; var ACancel: Boolean);
begin
  Edit2.Text := AValue;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  c0IniPropStocker1.Items.AddAllProp(T8Options.Instance, k0ialInstance);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  T8Options.Instance.ExecTime := T8Options.Instance.ExecTime + 1;
  T8Options.Instance.LastExecDate := Now;
  if T8Options.Instance.ExecTime > 3 then
    ShowMessage('‹N“®‰ñ”‚ª3‰ñ‚ğ’´‚¦‚Ü‚µ‚½');
end;

end.
