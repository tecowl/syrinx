unit s0DBHelper;

interface

uses
  SysUtils, Classes, DB;

type
  Ts0DBHelper = class
  public
    class function GetExceptionMsg(E: Exception): string;
  end;

implementation

uses
  DBTables;

{ Ts0DBHelper }

class function Ts0DBHelper.GetExceptionMsg(E: Exception): string;
var
  i: Integer;
  err: TDBError;
begin
  Result := E.Message;
  if E is EDBEngineError then
  begin
    Result := Result + #13#10+ 'ErrorCount: ' + IntToStr(EDBEngineError(E).ErrorCount);
    for i := 0 to EDBEngineError(E).ErrorCount -1 do
    begin
      err := EDBEngineError(E).Errors[i];
      Result :=
        Result + #13#10 +
        Format(
          '%0.4d: Category(%d); ErrorCode(%d); SubCode(%d); NativeError(%d); Message("%s")',
          [i + 1, err.Category, err.ErrorCode, err.SubCode, err.NativeError, err.Message]);
    end;
  end;
end;

end.
