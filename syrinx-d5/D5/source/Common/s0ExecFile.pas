unit s0ExecFile;

interface

uses
  Windows, SysUtils, Classes;

type
  Ts0ExecFile = class
  private
    FExecFileName: string;
    FExecResult: TStrings;
    FParams: string;
    procedure SetExecFileName(const Value: string);
    procedure SetExecResult(const Value: TStrings);
    procedure SetParams(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
    class procedure ExecuteFile(AExe, AParam: string; AResult: TStrings);
    property ExecFileName: string read FExecFileName write SetExecFileName;
    property Params: string read FParams write SetParams;
    property ExecResult: TStrings read FExecResult write SetExecResult;
  end;

implementation

uses
  s0FileNameHelper;

{ Ts0ExecFile }

constructor Ts0ExecFile.Create;
begin
  inherited Create;
  FExecResult := TStringList.Create;
end;

destructor Ts0ExecFile.Destroy;
begin
  FreeAndNil(FExecResult);
  inherited;    
end;

procedure Ts0ExecFile.Execute;
begin
  ExecuteFile(FExecFileName, FParams, FExecResult);
end;

class procedure Ts0ExecFile.ExecuteFile(AExe, AParam: string;
  AResult: TStrings);
var
  si :TStartupInfo;
  pi :TProcessinformation;
  tp, tf: string;
  exeStr: string;
begin
  tp := Ts0FileNameHelper.GeTempPathName;
  ForceDirectories( IncludeTrailingPathDelimiter(tp) );
  tf := Ts0FileNameHelper.GetTempFileName(tp);
  try
    FillChar(si, sizeOf(si), 0);
    si.cb := sizeOf(si);
    si.dwFlags:= STARTF_USESHOWWINDOW;     // DOS プロンプトが表示
    si.wShowWindow := SW_HIDE;             // されるのを抑止する
    exeStr := Format('%s > %s',[AExe, tf]);
    if AParam <> '' then
      exeStr := exeStr +' '+ AParam;
    if not CreateProcess(nil, PChar(exeStr), nil, nil, False, 0, nil, nil, si, pi) Then
      raise Exception.Create('Error!');
    while WaitForsingleObject(pi.hProcess, 0) = WAIT_TIMEOUT do ; // プロセス終了まで待機する
    CloseHandle(pi.hProcess);
  finally
    if FileExists(tf) then
    begin
      AResult.LoadFromFile(tf);
      DeleteFile(tf);
    end;
  end;
end;

procedure Ts0ExecFile.SetExecFileName(const Value: string);
begin
  FExecFileName := Value;
end;

procedure Ts0ExecFile.SetExecResult(const Value: TStrings);
begin
  FExecResult.Assign(Value);
end;

procedure Ts0ExecFile.SetParams(const Value: string);
begin
  FParams := Value;
end;

end.
