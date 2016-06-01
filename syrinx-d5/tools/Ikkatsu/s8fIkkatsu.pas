unit s8fIkkatsu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  s0StringHelper;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: PChar;
begin
  Memo1.Lines.Clear;
  s := GetEnvironmentStrings;
  Ts0StringHelper.SlicePCharByChar(Memo1.Lines, s);
end;

end.
