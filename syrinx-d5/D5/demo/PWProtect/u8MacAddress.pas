unit u8MacAddress;

interface

uses
	SysUtils, Classes;

type
	T8MacAddress = class
  public
    class procedure RetrieveMacAddresses(Dest: TStrings);
    class function GetPrimaryMacAddress(): String;
  end;

implementation

uses nb30;

{ T8MacAddress }

class function T8MacAddress.GetPrimaryMacAddress: String;
var
	sl: TStringList;
begin
	Result := '';
	sl := TStringList.Create;
  try
  	RetrieveMacAddresses(sl);
    if sl.Count < 1 then
    	Exit;
    Result := sl[0];
  finally
		FreeAndNil(sl);
  end;
end;

//以下のサイトを参考にしました
//http://homepage1.nifty.com/MADIA/delphi/delphi_bbs/200111_01110008.html
class procedure T8MacAddress.RetrieveMacAddresses(Dest: TStrings);
type
  PAstat = ^TAstat;
  TAstat = packed record
	  adapt: TAdapterStatus;
  	NameBuff: array [0 .. 29] of TNameBuffer;
  end;
var
  ncb: TNCB;
  lenum: TLanaEnum;
  i: integer;
  Adapter: TAstat;
  s: String;
begin
  FillChar(ncb, SizeOf(ncb), 0);
  ncb.ncb_command := Char(NCBENUM);
  ncb.ncb_buffer := @lenum;
  ncb.ncb_length := SizeOf(lenum);
  if Integer(Netbios( @ncb )) <> 0 then
  	raise Exception.Create('failed to check network adaptors');
  //
  for i := 0 to integer(lenum.length) - 1 do
  begin
    FillChar(ncb, SizeOf(NCB), 0);
    ncb.ncb_command := Char(NCBRESET);
    ncb.ncb_lana_num := lenum.lana[i];
	  if Integer(Netbios( @ncb )) <> 0 then
  		raise Exception.Create('failed to check network adaptor[' + IntToStr(i) + ']');
		//
    FillChar(ncb, SizeOf(NCB), 0);
    ncb.ncb_command := Char(NCBASTAT);
    ncb.ncb_lana_num := lenum.lana[i];
    ncb.ncb_callname := '* ';
    ncb.ncb_buffer := @Adapter;
    ncb.ncb_length := SizeOf(Adapter);
	  if Integer(Netbios( @ncb )) <> 0 then
  		raise Exception.Create('failed to check network adaptor[' + IntToStr(i) + ']');
    s := IntToHex(integer(Adapter.adapt.adapter_address[0]), 2)
         + '-' + IntToHex(integer(Adapter.adapt.adapter_address[1]), 2)
         + '-' + IntToHex(integer(Adapter.adapt.adapter_address[2]), 2)
         + '-' + IntToHex(integer(Adapter.adapt.adapter_address[3]), 2)
         + '-' + IntToHex(integer(Adapter.adapt.adapter_address[4]), 2)
         + '-' + IntToHex(integer(Adapter.adapt.adapter_address[5]), 2);
    Dest.Add(s);
  end;
end;

end.
