unit s0ce_ExDBGrid;
{
$History: s0ce_ExDBGrid.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/12   Time: 23:44
 * Updated in $/source/D6VCLIntegrated/Designer
 * コンポーネントエディタを継承する方法を確定
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0dbgrid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/06   Time: 14:12
 * Created in $/source/p0control/p0dbgrid
 * 新規作成
}

interface

uses
  SysUtils, Classes, DsgnIntf,
  c0SXExDBGrid;

type
  Ts0ce_ExDBGrid = class(TComponentEditor)
  public
    procedure ImplExecuteVerb(Index: Integer); override;
    function ImplGetVerb(Index: Integer): string; override;
    function ImplGetVerbCount: Integer; override;
  end;

implementation

uses
  f0ceDBGrid;

{ Ts0ce_ExDBGrid }

procedure Ts0ce_ExDBGrid.ImplExecuteVerb(Index: Integer);
  procedure EditColumns;
  var
    frm: Tfrm0ceDBGrid;
  begin
    if not(Component is Tc0SXCustomExDBGrid) then Exit;
    frm := Tfrm0ceDBGrid.Create(nil);
    try
      frm.Target := Tc0SXCustomExDBGrid(Component);
      frm.Designer := Self.Designer;
      frm.ShowModal;
    finally
      FreeAndNil(frm);
    end;
  end;
begin
  case Index of
    0: EditColumns;
  end;
end;

resourcestring
  c9Verb_EditColumns = '列の編集';

function Ts0ce_ExDBGrid.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := c9Verb_EditColumns;
  end;
end;

function Ts0ce_ExDBGrid.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

end.
