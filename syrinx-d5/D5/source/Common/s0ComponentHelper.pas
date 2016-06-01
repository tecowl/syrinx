unit s0ComponentHelper;
{
$History: s0ComponentHelper.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/12   Time: 23:51
 * Updated in $/source/D6VCLIntegrated
 * GetRootOwnerメソッドを追加
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/11/08   Time: 3:08
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/04   Time: 21:08
 * Updated in $/source/D5Integrated
 * GetNewComponentNameOfメソッドを追加
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0core
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes;

type
  Ts0ComponentHelper = class
  private
  public
    class function GetNewComponentName(ACompo: TComponent): string;
    class function GetNewComponentNameOf(ACompo: TComponent; ABaseName: string): string;
    class function GetRootOwner(ACompo: TComponent): TComponent;
  end;

implementation

{ Ts0ComponentHelper }

class function Ts0ComponentHelper.GetNewComponentName(ACompo: TComponent): string;
var
  s: string;
begin
  s := ACompo.ClassName;
  Delete(s, 1, 1);
  Result := GetNewComponentNameOf(ACompo, s);
end;

class function Ts0ComponentHelper.GetNewComponentNameOf(ACompo: TComponent;
  ABaseName: string): string;
var
  i: integer;
begin
  Result := ABaseName;
  if ACompo.Owner = nil then Exit;
  i := 0;
  repeat
    inc(i);
    Result := ABaseName + IntToStr(i);
  until ACompo.Owner.FindComponent(Result) = nil;
end;

class function Ts0ComponentHelper.GetRootOwner(ACompo: TComponent): TComponent;
begin
  Result := ACompo;
  if ACompo.ComponentCount > 0 then Exit;
  if ACompo.Owner = nil then Exit;
  Result := GetRootOwner(ACompo.Owner);
end;

end.
