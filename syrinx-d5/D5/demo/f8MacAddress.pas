unit f8MacAddress;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
	{
  	MACアドレスを取得するサンプル
  	http://homepage1.nifty.com/MADIA/delphi/delphi_bbs/200111_01110008.html
  }
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

uses nb30;



{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
type
  PAstat = ^TAstat;
  TAstat = packed record
	  adapt: TAdapterStatus;
  	NameBuff: array [0 .. 29] of TNameBuffer;
  end;
var
  Ncb: TNCB;
  RetCode: Integer;
  lenum: TLanaEnum;
  i: integer;
  Adapter: TAstat;
begin
  Memo1.Lines.Clear;
//
  FillChar(Ncb, SizeOf(NCB), 0);
  Ncb.ncb_command := Char(NCBENUM);
  Ncb.ncb_buffer := @lenum;
  Ncb.ncb_length := SizeOf(lenum);
  RetCode := Integer(Netbios( @Ncb ));
  Memo1.Lines.Add( 'The NCBENUM return code is: $' + IntToHex(RetCode, 2) );

  for i := 0 to integer(lenum.length) - 1 do
  begin
    FillChar(Ncb, SizeOf(NCB), 0);
    Ncb.ncb_command := Char(NCBRESET);
    Ncb.ncb_lana_num := lenum.lana[i];

    RetCode := Integer(Netbios( @Ncb ));
    Memo1.Lines.Add( 'The NCBRESET on LANA ' + IntToStr(Integer(lenum.lana[i]))
                    +' return code is: $' + IntToHex(RetCode, 2) );

    FillChar(Ncb, SizeOf(NCB), 0);
    Ncb.ncb_command := Char(NCBASTAT);
    Ncb.ncb_lana_num := lenum.lana[i];

    Ncb.ncb_callname := '* ';
    Ncb.ncb_buffer := @Adapter;
    Ncb.ncb_length := SizeOf(Adapter);

    RetCode := Integer(Netbios( @Ncb ));
    Memo1.Lines.Add( 'The NCBASTAT on LANA ' + IntToStr(Integer(lenum.lana[i]))
                    +' return code is: $' + IntToHex(RetCode, 2) );

    if RetCode = 0 then
    begin
      Memo1.Lines.Add('The Ethernet Number on LANA ' + IntToStr(Integer(lenum.lana[i]))
        + ' is:' + IntToHex(integer(Adapter.adapt.adapter_address[0]), 2)
           + '-' + IntToHex(integer(Adapter.adapt.adapter_address[1]), 2)
           + '-' + IntToHex(integer(Adapter.adapt.adapter_address[2]), 2)
           + '-' + IntToHex(integer(Adapter.adapt.adapter_address[3]), 2)
           + '-' + IntToHex(integer(Adapter.adapt.adapter_address[4]), 2)
           + '-' + IntToHex(integer(Adapter.adapt.adapter_address[5]), 2));
    end;
  end;
end;

end.
