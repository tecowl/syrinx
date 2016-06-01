unit s0MenuHelper;
{
$History: s0MenuHelper.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 *
 * *****************  Version 2  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマ ンド追加
}

interface

uses
  SysUtils, Classes, Menus;

type
  Ts0MenuHelper = class
  private
  public
    class procedure FreeMenuItem(AItem: TMenuItem);
    class procedure FreeMenus(AMenu: TMenu);
  end;

implementation

{ Ts0MenuHelper }

class procedure Ts0MenuHelper.FreeMenus(AMenu: TMenu);
var
  i: Integer;
  m: TMenuItem;
begin
  for i := AMenu.Items.Count - 1 downto 0 do
  begin
    m := AMenu.Items[i];
    AMenu.Items.Remove(m);
    FreeMenuItem(m);
  end;
  FreeAndNil(AMenu);
end;

class procedure Ts0MenuHelper.FreeMenuItem(AItem: TMenuItem);
var
  i: Integer;
  m: TMenuItem;
begin
  for i := AItem.Count - 1 downto 0 do
  begin
    m := AItem.Items[i];
    AItem.Remove(m);
    FreeMenuItem(m);
  end;
  AItem.Free;
end;

end.
