unit s0GridFocusController;
{
$History: s0GridFocusController.pas $
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
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes;

type
  Ts0GridFocusControllerClass = class of Ts0GridFocusController;
  Ts0GridFocusController = class
  private
    FKeyToMoveNextCell: Word;
    FKeyToMovePrevCell: Word;
  protected
    procedure SetKeyToMoveNextCell(const Value: Word); virtual;
    procedure SetKeyToMovePrevCell(const Value: Word); virtual;
  public
    constructor Create; virtual;
    property KeyToMoveNextCell: Word read FKeyToMoveNextCell write SetKeyToMoveNextCell;
    property KeyToMovePrevCell: Word read FKeyToMovePrevCell write SetKeyToMovePrevCell;
    class function Instance: Ts0GridFocusController;
    class procedure RegisterController(AClass: Ts0GridFocusControllerClass);
  end;

implementation

{ Ts0GridFocusController }

constructor Ts0GridFocusController.Create;
begin
  inherited Create;
  FKeyToMoveNextCell := 0;
  FKeyToMovePrevCell := 0;
end;

procedure Ts0GridFocusController.SetKeyToMoveNextCell(const Value: Word);
begin
  FKeyToMoveNextCell := Value;
end;

procedure Ts0GridFocusController.SetKeyToMovePrevCell(const Value: Word);
begin
  FKeyToMovePrevCell := Value;
end;

var
  g9CtrlClass: Ts0GridFocusControllerClass = Ts0GridFocusController;
  g9Controller: Ts0GridFocusController = nil;

class function Ts0GridFocusController.Instance: Ts0GridFocusController;
begin
  if g9Controller = nil then
    g9Controller := g9CtrlClass.Create;
  Result := g9Controller;
end;

class procedure Ts0GridFocusController.RegisterController(
  AClass: Ts0GridFocusControllerClass);
begin
  g9CtrlClass := AClass;
end;

initialization

finalization
  FreeAndNil(g9Controller);

end.
