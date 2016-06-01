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
    //�ŏI�N�����[�U
    property LastUserName: string read FLastUserName write FLastUserName;
    //�ŏI�N������
    property LastExecDate: TDateTime read FLastExecDate write FLastExecDate;
    //�N����
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
    //Ini�t�@�C����Section���Ƃ���Name�v���p�e�B���g����̂ŕK���ݒ肷��B
    g9Options.Name := 'GlobalOptions';
  end;
  Result := g9Options;
end;

initialization

finalization
  FreeAndNil(g9Options);

end.
