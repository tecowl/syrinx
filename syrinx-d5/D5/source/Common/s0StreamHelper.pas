unit s0StreamHelper;
{
$History: s0StreamHelper.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes;

type
  Ts0StreamHelper = class
  public
    class procedure CopyString(Dest: TStream; AStr: string); 
  end;

implementation

{ Ts0StreamHelper }

class procedure Ts0StreamHelper.CopyString(Dest: TStream; AStr: string);
var
  ss: TStringStream;
begin
  ss := TStringStream.Create(AStr);
  try
    Dest.CopyFrom(ss, 0);
  finally
    FreeAndNil(ss);
  end;
end;

end.
