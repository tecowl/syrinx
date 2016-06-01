unit u8Options;

interface

uses
  SysUtils, Classes;

type
  T8Options = class(TComponent)
  private
    FExecTime: Integer;
    FLastUserName: string;
    FLastExecDate: TDateTime;
  public
    class function Instance: T8Options;
  published
    //最終起動ユーザ
    property LastUserName: string read FLastUserName write FLastUserName;
    //最終起動日時
    property LastExecDate: TDateTime read FLastExecDate write FLastExecDate;
    //起動回数
    property ExecTime: Integer read FExecTime write FExecTime;
  end;

implementation

{ T8Options }

var
  g9Options: T8Options = nil;

class function T8Options.Instance: T8Options;
begin
  if g9Options = nil then
  begin
    g9Options := T8Options.Create(nil);
    //IniファイルのSection名としてNameプロパティが使われるので必ず設定する。
    g9Options.Name := 'GlobalOptions';
  end;
  Result := g9Options;
end;

initialization

finalization
  FreeAndNil(g9Options);

end.
