unit s0Database;
{
$History: s0Database.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/06   Time: 1:03
 * Updated in $/source/D5Integrated
 * Loginに成功したときのユーザ名とパスワードをFLoginUserNameとFLoginPasswo
 * rdに反映するように変更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/21   Time: 15:27
 * Updated in $/source/D5Integrated
 * DefaultUserNameを取得できなくても例外で止まんないようにした
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/28   Time: 15:55
 * Updated in $/source/D5Integrated
 * 認証ダイアログでキャンセルしたときに処理を抜けるように修正
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/28   Time: 1:59
 * Created in $/source/D5Integrated
 * 新規作成
}

interface

uses
  SysUtils, Classes, 
  DBTables;

type
  Ts0Database = class(TDatabase)
  private
    FStoredLoginParam: Boolean;
    FLoginUserName: string;
    FLoginPassword: string;
    FTimeOfConfirm: Integer;
    procedure SetLoginPassword(const Value: string);
    procedure SetLoginUserName(const Value: string);
    procedure SetStoredLoginParam(const Value: Boolean);
  protected
    procedure DoConnect; override;
    function GetDefaultUserName: string;
  public
    constructor Create(AOwner: TComponent); override;
    function ConfirmLoginInfo(NameReadOnly: Boolean = False): Boolean;
  published
    property LoginUserName: string read FLoginUserName write SetLoginUserName;
    property LoginPassword: string read FLoginPassword write SetLoginPassword;
    property StoredLoginParam: Boolean read FStoredLoginParam write SetStoredLoginParam default False;
    property TimeOfConfirm: Integer read FTimeOfConfirm write FTimeOfConfirm default 3;
  end;

type
  Es0DatabaseException = class(Exception);

procedure Register;

implementation


uses
  DBLogDlg; //削除予定

procedure Register;
begin
  RegisterComponents('P DM', [Ts0Database]);
end;

{ Ts0Database }

function Ts0Database.ConfirmLoginInfo(NameReadOnly: Boolean): Boolean;
begin
//DBLogDlgユニットと共に削除。代わりの仕組みを作る。
  Result := LoginDialogEx(AliasName, FLoginUserName, FLoginPassword, NameReadOnly);
end;

constructor Ts0Database.Create(AOwner: TComponent);
begin
  inherited;
  FTimeOfConfirm := 3;
  FStoredLoginParam := False;
end;

resourcestring
  c9Msg_FailToConnect = '接続に失敗しました(%d)';
  c9Msg_CancelToConnect = '接続をキャンセルしました';

procedure Ts0Database.DoConnect;
var
  i: Integer;
begin
  if StoredLoginParam then
  begin
    LoginPrompt := False;
    Params.Values['USER NAME'] := FLoginUserName;
    Params.Values['PASSWORD'] := FLoginPassword;
    for i := 0 to TimeOfConfirm -1 do
    begin
      if i = 0 then
      begin
        try
          inherited DoConnect;
          FLoginUserName := Params.Values['USER NAME'];
          FLoginPassword := Params.Values['PASSWORD'];
          Exit;
        except
        end;
      end;
      if FLoginUserName = '' then
      begin
        try
          FLoginUserName := GetDefaultUserName;
        except
        end;
      end;
      if not ConfirmLoginInfo(False) then
        raise Es0DatabaseException.Create(c9Msg_CancelToConnect);
      Params.Values['USER NAME'] := FLoginUserName;
      Params.Values['PASSWORD'] := FLoginPassword;
      try
        inherited DoConnect;
        FLoginUserName := Params.Values['USER NAME'];
        FLoginPassword := Params.Values['PASSWORD'];
        Exit;
      except
        if i < FTimeOfConfirm -1 then
        begin
          //MessageDlg( Format(c9Msg_FailToConnect, [i]), mtError, [mbOK], 0)
        end
        else
          raise;
      end;
    end;
  end
  else
  begin
    if Params.Values['USER NAME'] = '' then
      Params.Values['USER NAME'] := FLoginUserName;
    if Params.Values['PASSWORD'] = '' then
      Params.Values['PASSWORD'] := FLoginPassword;
    inherited DoConnect;
  end;
end;

function Ts0Database.GetDefaultUserName: string;
var
  sl: TStringList;
  an: string;
begin
  Result := '';
  if Session = nil then Exit;
  an := DatabaseName;
  if an = '' then
    an := AliasName;
  if an = '' then Exit;
  sl := TStringList.Create;
  try
    Session.GetAliasParams(an, sl);
    Result := sl.Values['USER NAME'];
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0Database.SetLoginPassword(const Value: string);
begin
  FLoginPassword := Value;
end;

procedure Ts0Database.SetLoginUserName(const Value: string);
begin
  FLoginUserName := Value;
end;

procedure Ts0Database.SetStoredLoginParam(const Value: Boolean);
begin
  FStoredLoginParam := Value;
end;

end.
