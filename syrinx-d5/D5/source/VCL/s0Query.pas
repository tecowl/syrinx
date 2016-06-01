unit s0Query;
{
$History: s0Query.pas $
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/12/07   Time: 18:28
 * Updated in $/source/D5Integrated
 * 実行時パッケージに含まれうるユニットからDsgnIntfを削除。
 * それに関係するクラスなどは設計時用のパッケージにまとめた。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/11/09   Time: 1:18
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/08   Time: 21:52
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/08   Time: 14:35
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/08   Time: 3:08
 * Updated in $/source/D5Integrated
 * Log機能を一応追加。
 * でもまだ色々やんなきゃ。
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/12   Time: 0:55
 * Updated in $/source/D5Integrated
 * ShowSQLでパラメータのDataType（TFieldType）も表示するようにした
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/11   Time: 17:23
 * Updated in $/source/D5Integrated
 * ShowSQLメソッドをもっと詳細が表示されるように変更
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/09   Time: 9:09
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0db
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes, 
  DBTables;

type
  Ts0CustomQuery = class(TQuery)
  private
    FShowSQLOnError: Boolean;
    FSQLFileEnabled: Boolean;
    FSQLFileName: TFileName;
    procedure SetSQLFileEnabled(const Value: Boolean);
    procedure SetSQLFileName(const Value: TFileName);
  protected
    procedure Loaded; override;
    procedure OpenCursor(InfoQuery: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromSQLFile;
    procedure SaveToSQLFile;
  public
    property SQLFileEnabled: Boolean read FSQLFileEnabled write SetSQLFileEnabled default False;
    property SQLFileName: TFileName read FSQLFileName write SetSQLFileName;
  end;

type
  Ts0Query = class(Ts0CustomQuery)
  private
  protected
  public
  published
    property SQLFileEnabled;
    property SQLFileName;
  end;

type
  Es0Query = class(Exception);

implementation

uses
  s0DateHelper,
  s0ComponentHelper,
  s0DBHelper,
  s0FieldHelper;

{ Tce0CustomQuery }

constructor Ts0CustomQuery.Create(AOwner: TComponent);
begin
  inherited;
  FShowSQLOnError := False;
end;

destructor Ts0CustomQuery.Destroy;
begin
  inherited;
end;

procedure Ts0CustomQuery.Loaded;
begin
  inherited;
  if SQLFileEnabled then
    LoadFromSQLFile;
end;

procedure Ts0CustomQuery.LoadFromSQLFile;
begin
  if Trim(FSQLFileName) = '' then Exit;
  if not FileExists(FSQLFileName) then Exit;
  Self.SQL.LoadFromFile(FSQLFileName);
end;

procedure Ts0CustomQuery.OpenCursor(InfoQuery: Boolean);
begin
  inherited OpenCursor(InfoQuery);
end;

procedure Ts0CustomQuery.SaveToSQLFile;
begin
  if Trim(FSQLFileName) = '' then Exit;
  Self.SQL.SaveToFile(FSQLFileName);
end;

procedure Ts0CustomQuery.SetSQLFileEnabled(const Value: Boolean);
begin
  FSQLFileEnabled := Value;
end;

procedure Ts0CustomQuery.SetSQLFileName(const Value: TFileName);
begin
  FSQLFileName := Value;
end;

end.
