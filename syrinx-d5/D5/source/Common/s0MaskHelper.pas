unit s0MaskHelper;
{
$History: s0MaskHelper.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/21   Time: 13:21
 * Created in $/source/D5Integrated
 * 新規作成
}

interface

uses
  SysUtils, Classes, Masks;

type
  Ts0MaskHelper = class
  public
    class procedure ExtractStrings(Source, Dest: TStrings; AMask: string);
    class function IndexOfMask(Source: TStrings; AMask: string): Integer;
  end;             

implementation

{ Ts0MaskHelper }

class procedure Ts0MaskHelper.ExtractStrings(Source, Dest: TStrings;
  AMask: string);
var
  m: TMask;
  i: Integer;
begin
  m := TMask.Create(AMask);
  try
    for i := 0 to Source.Count -1 do
      if m.Matches(Source.Strings[i]) then
        Dest.Add(Source.Strings[i]);
  finally
    FreeAndNil(m);
  end;
end;

class function Ts0MaskHelper.IndexOfMask(Source: TStrings;
  AMask: string): Integer;
var
  m: TMask;
  i: Integer;
begin
  Result := -1;
  m := TMask.Create(AMask);
  try
    for i := 0 to Source.Count -1 do
      if m.Matches(Source.Strings[i]) then
      begin
        Result := i;
        Exit;
      end;
  finally
    FreeAndNil(m);
  end;
end;

end.
