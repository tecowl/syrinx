unit s0FileNameHelper;
{
$History: s0FileNameHelper.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 19:23
 * Updated in $/source/D6VCLIntegrated
 * IncludeTrailingPathDelimiterとExcludeTrailingPathDelimiter関数を追加。
 * これらはVER130とVER140の違いを吸収するもの。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/06   Time: 14:06
 * Updated in $/source/p0common
 * GeTempPathName、GeTempFileNameメソッドを追加
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:28
 * Created in $/Projects/SDRFrameWork/src/lib0
 * 新規追加
 * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
 * VSSでは共有してません。
}

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
{$ENDIF}
  SysUtils, Classes;

type
  K0FileName = type TFileName;

type
  Ts0FileNameHelper = class
  private
  public
    class function GetCurrentDirectory: K0FileName;
//    class function GetCurrentFileName: K0FileName;
    {
      ReplaceFileName

      引数SourceFileNameで指定された文字列中のキーワードを
      引数KeyWordsのNamesプロパティにて検索し、対応するValuesプロパティにて
      置換するメソッド。

      キーワードの検索で用いられる文字列のフォーマ ットは、c0KeyWordFormatにて指定される。
      デフォルトでは、Delphiのライブラリパスなどで使用されている '$(%s)' 。
    }
    class function ReplaceFileName(const SourceFileName: string; KeyWords: TStrings): string;
    //
    class function GeTempPathName: string;
    class function GetTempFileName(ADir: string; APrefix: string = 'ple';
      ANum: Integer = 0): string;
  end;

function IncludeTrailingPathDelimiter(const S: string): string;
function ExcludeTrailingPathDelimiter(const S: string): string;

const
  c0KeyWordFormat: string = '$(%s)';

implementation


function IncludeTrailingPathDelimiter(const S: string): string;
begin
{$IFDEF VER130}
  Result := SysUtils.IncludeTrailingBackslash(S);
{$ELSE}
  Result := SysUtils.IncludeTrailingPathDelimiter(S);
{$ENDIF}
end;

function ExcludeTrailingPathDelimiter(const S: string): string;
begin
{$IFDEF VER130}
  Result := SysUtils.ExcludeTrailingBackslash(S);
{$ELSE}
  Result := SysUtils.ExcludeTrailingPathDelimiter(S);
{$ENDIF}
end;

{ Ts0FileNameHelper }

class function Ts0FileNameHelper.GetCurrentDirectory: K0FileName;
begin
  Result := GetCurrentDir;
end;

{
class function Ts0FileNameHelper.GetCurrentFileName: K0FileName;
begin
  Result := ExpandUNCFileName(Application.ExeName);
end;
}

class function Ts0FileNameHelper.GeTempPathName: string;
var
  buf: array[0..260] of Char;
begin
  windows.GetTempPath(SizeOf(buf), buf);
  Result := buf;
  Result := IncludeTrailingPathDelimiter(Result);
end;

class function Ts0FileNameHelper.GetTempFileName(ADir,
  APrefix: string; ANum: Integer): string;
var
  buf: array[0..260] of Char;
begin
  if ADir = '' then
    ADir := GeTempPathName;
  ADir := IncludeTrailingPathDelimiter(ADir);
  Windows.GetTempFileName(PChar(ADir), PChar(APrefix), ANum, buf);
  Result := buf;
end;

class function Ts0FileNameHelper.ReplaceFileName(
  const SourceFileName: string; KeyWords: TStrings): string;
var
  i: Integer;
begin
  Result := SourceFileName;
  for i := 0 to KeyWords.Count - 1 do
  begin
    Result := StringReplace(
      Result,
      Format(c0KeyWordFormat, [KeyWords.Names[i]]),
      KeyWords.Values[KeyWords.Names[i]],
      [rfReplaceAll, rfIgnoreCase]
      );
  end;
end;

end.

