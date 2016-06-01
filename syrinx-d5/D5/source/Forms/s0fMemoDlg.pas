unit s0fMemoDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Ts0frmMemoDlg = class(TForm)
    dspText: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
    procedure ShowMemo(AText: string);
    class procedure ShowText(AText: string);
  end;

var
  frm0MemoDlg: Ts0frmMemoDlg;

implementation

{$R *.DFM}

{ Ts0frmMemoDlg }

procedure Ts0frmMemoDlg.ShowMemo(AText: string);
begin
  dspText.Lines.Text := AText;
  Self.ShowModal;
end;

class procedure Ts0frmMemoDlg.ShowText(AText: string);
var
  frm: Ts0frmMemoDlg;
begin
  frm := Ts0frmMemoDlg.Create(nil);
  try
    frm.ShowMemo(AText);
  finally
    FreeAndNil(frm);
  end;
end;

procedure Ts0frmMemoDlg.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
