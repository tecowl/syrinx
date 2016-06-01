unit f8PWGenrator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JvComponent, JvCipher, JvSerialMaker, ComCtrls;

type
  TForm5 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    JvXORCipher1: TJvXORCipher;
    procedure Button1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form5: TForm5;

implementation

{$R *.DFM}

uses
	u8Encrypt;

procedure TForm5.Button1Click(Sender: TObject);
begin
	Edit2.Text := T8PWGen.Encrypt(Edit1.Text );
end;

end.
