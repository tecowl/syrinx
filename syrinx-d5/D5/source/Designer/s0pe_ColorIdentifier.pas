unit s0pe_ColorIdentifier;
{
$History: s0pe_ColorIdentifier.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0ctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf;
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts;
{$ENDIF}

type
  Ts0pe_ColorIdentifier = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

uses
//  c0LogManager,
  s0ColorSet;

{ Ts0pe_ColorIdentifier }

function Ts0pe_ColorIdentifier.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

procedure Ts0pe_ColorIdentifier.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  colMan: Ts0ColorManager;
begin
  colMan := Ts0ColorManager.Instance;
  //Ts0Logger.Instance.LoggingLevel := k0llFrameworkDebug;
  if colMan = nil then
  begin
    //Trace(Self, 'GetValues', 'colManがnil-----！');
    Exit;
  end;
  for i := 0 to colMan.Items.Count - 1 do
  begin
    Proc(colMan.Items.Items[i].Identifier);
  end;
end;

end.
