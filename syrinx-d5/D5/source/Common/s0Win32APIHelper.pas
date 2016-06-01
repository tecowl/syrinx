unit s0Win32APIHelper;
{
$History: s0Win32APIHelper.pas $
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
 * *****************  Version 3  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  Windows, Messages, SysUtils, Classes;

type
  Ts0Win32APIHelper = class
  private
  public
    class function GetLastErrorStr(ErrorCode: Integer): String;
    class function CheckSingleInstanceVer(const aVer: integer; aName: string): THandle;
  end;

implementation

uses
  s0StringHelper;

{--------------------------------------------------------------------
説明：Win32のGetLastErrorの戻り値を文字列に変換する関数
引数：ErrorCodeは
結果：Win32のエラーメッセージが戻る
備考：
---------------------------------------------------------------------}
class function Ts0Win32APIHelper.GetLastErrorStr(ErrorCode: Integer): string;
const
  MAX_MES = 512;
var
  Buf: PChar;
begin
  Buf := AllocMem(MAX_MES);
  try
    FormatMessage(Format_Message_From_System, Nil, ErrorCode,
                  (SubLang_Default shl 10) + Lang_Neutral,
                  Buf, MAX_MES, Nil);
  finally
    Result := Buf;
    FreeMem(Buf);
  end;
end;

{------------------------------------------------------------
説明：指定した名前のMutexをバージョン番号を考慮してあるかどうか調べる
引数：aNameにはプログラムIDなどシステムでユニークな文字列を渡す
      aVerにはセキュリティクラス等から最新のバージョンNOを取得して渡す
結果：結果にはオープンしたMutexが返る。0だった場合、他にインスタンスがいる
備考：結果で戻ったMutexはアプリケーション終了時までに必ずクローズすること
------------------------------------------------------------}
class function Ts0Win32APIHelper.CheckSingleInstanceVer(const aVer: integer;aName: string):THandle;
var
  hMutex: THandle;
begin
  hMutex := OpenMutex(
    MUTEX_ALL_ACCESS,
    False,
    PChar(AnsiUpperCase( Ts0StringHelper.GetExeNameFromVer(aVer, aName) ))
  );
  if hMutex <> 0 then
  begin
    CloseHandle(hMutex);
    Result := 0;
  end
  else
    Result := CreateMutex(
                nil,
                False,
                PChar(AnsiUpperCase( Ts0StringHelper.GetExeNameFromVer(aVer, aName) ))
              );
end;

end.
