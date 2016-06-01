unit s0RegAdditional;
{
$History: s0RegAdditional.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/12/07   Time: 18:27
 * Updated in $/source/D5Integrated
 * デザイナー関係は設計時用のパッケージに全て移動した
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/20   Time: 18:36
 * Updated in $/source/D5Integrated
 * Tc0SXDictionaryを追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:38
 * Updated in $/source/D5Integrated
 * コンポーネントパレットの登録先を変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes,
  s0FileCollections,
  s0AppInstance,
  s0FileFinder,
  s0IniPropStocker,
  s0ObjectsPropFilter,
  s0TextComparer,
  s0TaggedPage,
  s0TagReader,
  s0TagWriter,
  s0TagBookMarker
  ;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P DM', [
    Ts0FileCollections,
    Ts0AppInstance,
    Ts0TextComparer,
    Ts0ObjectsPropFilter,
    Ts0IniPropStocker,
    Ts0FileFinder,
    Ts0TaggedPage,
    Ts0TagReader,
    Ts0TagWriter,
    Ts0TagBookMarker
  ]);
end;

end.
