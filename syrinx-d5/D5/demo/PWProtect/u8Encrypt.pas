unit u8Encrypt;

interface

uses
	SysUtils, Classes;

type
	T8PWGen = class
  public
  	class function Encrypt(S: String): String;
  end;

implementation

uses
	u8PWConst,
	DCPrc4,
	DCPsha1;


{ T8PWGen }

class function T8PWGen.Encrypt(S: String): String;
var
  Cipher: TDCP_rc4;
begin
  Cipher:= TDCP_rc4.Create(nil);
  try
    // initialize the cipher with a hash of the passphrase
    Cipher.InitStr(c8_Encrypt_PASS_PHRASE,TDCP_sha1);
    // encrypt the contents
    Result := Cipher.EncryptString(S);
    Cipher.Burn;
  finally
    FreeAndNil(Cipher);
  end;
end;

end.
