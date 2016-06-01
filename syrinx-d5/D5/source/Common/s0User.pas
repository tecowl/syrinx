unit s0User;
{
$History: s0User.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
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
 * User: Akima        Date: 01/10/15   Time: 11:30
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/09   Time: 9:07
 * Updated in $/source/D5Integrated
 * LastUserNameプロパティを追加
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/06   Time: 14:07
 * Created in $/source/p0common
 * 新規作成
}

interface

uses
  SysUtils, Classes;

type
  K0ConfirmItemKind = (
    k0cikUserName,
    k0cikPassword,
    k0cikConfirmPW
  );
  K0ConfirmItemKindSet = set of K0ConfirmItemKind;

type
  K0UserCertifyEvent = procedure(Sender: TObject; const AUserName, APassword:
    string; var APass: Boolean) of object;

type
  K0ChangePWEvent = procedure(Sender: TObject; const AUserName,
    AOldPW, ANewPW: string; var APass: Boolean) of object;

type
  {
    Ts0User
    ユーザを表すクラス。特に何もしないっす。
  }
  Ts0User = class
  private
    FUserName: string;
    FPassword: string;
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
  public
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
  end;

type
  K0UserEvent = procedure(Sender: TObject; AUser: Ts0User) of object;

type
  {
    Ts0CustomGUIUserManager
    GUIアプリケーションへのユーザのログインなどを管理するクラス。
    Ts0Applicationを使用しているアプリで、UserCertificationがTrueに設定されて
    いる場合、起動直後（Application.Runの直前）に自動でユーザ認証が行われる。

    Application.Runの直前ならば、フォームやデータモジュールは生成されているので、
    このコンポーネントが貼り付けられていれば、そのインスタンスも生成されている。
    # 実行時に、Ts0GUIUserManager.Instanceは一つしか生成できない。

    自動で認証したくない場合や、フォームを表示してから、あるいはそれ以外の
    イベントで認証を行いたい場合、Ts0GUIUserManager.Instance.Loginメソッドを
    呼び出します。正しく認証できれば、その戻り値はnil以外になります。

    ユーザ名、パスワードが正しいか否かはOnCanLoginイベントのイベントハンドラ
    の引数AUserName, APasswordを判断し、正しければ引数APassにTrue、間違っていれば
    Falseを代入する。

    ユーザ名、パスワードの入力限度回数はAllowLoginCountで設定できる。
    デフォルトでは3回。

    ログインに成功するとOnLoginイベントが発生する。OnLoginイベントは、
    Loginメソッドだけでなく、CertifyPassword、ChangePasswordメソッドで、
    処理に成功した場合発生する。

    ログインに失敗するとOnLoginFailureイベントが発生する。
    OnLoginFailureイベントは、LoginメソッドとCertifyPasswordメソッドで
    処理に失敗した場合発生する。
    # 失敗した場合というのは、入力ダイアログでキャンセルするか、入力限度回数を
    # オーバーした場合のこと。
  }
  Ts0CustomGUIUserManager = class(TComponent)
  private
    FOnCanLogin: K0UserCertifyEvent;
    FLoginUser: Ts0User;
    FAllowLoginCount: Integer;
    FOnLogin: K0UserEvent;
    FUserCertification: Boolean;
    FOnLoginFailure: TNotifyEvent;
    FOnCanChangePassword: K0ChangePWEvent;
    FLastUserName: string;
    FBeforeLogin: TNotifyEvent;
    procedure SetLastUserName(const Value: string);
  protected
    procedure DoBeforeLogin;
    function DoCanChangePW(const AUserName, AOldPW, ANewPW: string): Boolean;
    function DoCanLogin(const AUserName, APassword: string): Boolean;
    procedure DoLoginFailure;
    procedure DoLogin(AUser: Ts0User);
    function ShowCertifyDlg(AMode: K0ConfirmItemKindSet; AUser: Ts0User): Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CertifyPassword;
    procedure ChangePassword;
    function Login: Ts0User;
    procedure Logout;
    function NewUser(const AUserName, APassword: string): Ts0User; virtual;
    property LoginUser: Ts0User read FLoginUser write FLoginUser;
    class function Instance: Ts0CustomGUIUserManager;
  published
    property AllowLoginCount: Integer read FAllowLoginCount write FAllowLoginCount default 3;
    property LastUserName: string read FLastUserName write SetLastUserName;
    property UserCertification: Boolean read FUserCertification write FUserCertification default False;
    property BeforeLogin: TNotifyEvent read FBeforeLogin write FBeforeLogin;
    property OnCanChangePassword: K0ChangePWEvent read FOnCanChangePassword write FOnCanChangePassword;
    property OnCanLogin: K0UserCertifyEvent read FOnCanLogin write FOnCanLogin;
    property OnLogin: K0UserEvent read FOnLogin write FOnLogin;
    property OnLoginFailure: TNotifyEvent read FOnLoginFailure write FOnLoginFailure;
  end;


implementation

uses
  s0SingletonKeeper,
  s0Application;

{ Ts0User }

procedure Ts0User.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure Ts0User.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

{ Ts0CustomGUIUserManager }

procedure Ts0CustomGUIUserManager.DoBeforeLogin;
begin
  if Assigned(FBeforeLogin) then
    FBeforeLogin(Self);
end;

var
  g9UserMan: Ts0CustomGUIUserManager = nil;

procedure Ts0CustomGUIUserManager.CertifyPassword;
var
  i: Integer;
  tmpUser: Ts0User;
begin
  if FLoginUser = nil then
    Exit;
  tmpUser := NewUser(FLoginUser.UserName, '');
  try
    for i := 0 to Self.AllowLoginCount -1 do
    begin
      if not ShowCertifyDlg([k0cikPassword], tmpUser) then
      begin
        DoLoginFailure;
        Exit;
      end;
      if not DoCanLogin(tmpUser.UserName, tmpUser.Password) then Continue;
      FLoginUser.Password := tmpUser.Password;
      DoLogin(FLoginUser);
      Exit;
    end;
    DoLoginFailure;
  finally
    FreeAndNil(tmpUser);
  end;
end;

procedure Ts0CustomGUIUserManager.ChangePassword;
var
  tmpUser: Ts0User;
begin
  if FLoginUser = nil then
    Exit;
  tmpUser := NewUser(FLoginUser.UserName, '');
  try
    if not ShowCertifyDlg([k0cikPassword, k0cikConfirmPW], tmpUser) then Exit;
    if not DoCanChangePW(tmpUser.UserName, FLoginUser.Password, tmpUser.Password) then Exit;
    FLoginUser.Password := tmpUser.Password;
    DoLogin(FLoginUser);
  finally
    FreeAndNil(tmpUser);
  end;
end;

constructor Ts0CustomGUIUserManager.Create(AOwner: TComponent);
begin
  FUserCertification := False;
  FAllowLoginCount := 3;
  FLoginUser := nil;
  inherited Create(AOwner);
  if g9UserMan = nil then
    g9UserMan := Self;
  if not(csDesigning in Self.ComponentState) then
    Ts0SingletonKeeper.Instance.RegisterSingletion(Self);
end;

function Ts0CustomGUIUserManager.NewUser(const AUserName,
  APassword: string): Ts0User;
begin
  Result := Ts0User.Create;
  Result.UserName := AUserName;
  Result.Password := APassword;
end;

destructor Ts0CustomGUIUserManager.Destroy;
begin
  FreeAndNil(FLoginUser);
  if not(csDesigning in Self.ComponentState) then
    Ts0SingletonKeeper.Instance.UnRegisterSingletion(Self);
  if g9UserMan = Self then
    g9UserMan := nil;
  inherited;
end;

function Ts0CustomGUIUserManager.DoCanLogin(const AUserName,
  APassword: string): Boolean;
begin
  Result := True;
  if Assigned(FOnCanLogin) then
    FOnCanLogin(Self, AUserName, APassword, Result);
end;

class function Ts0CustomGUIUserManager.Instance: Ts0CustomGUIUserManager;
begin
  Result := g9UserMan;
end;

function Ts0CustomGUIUserManager.Login: Ts0User;
var
  i: Integer;
  tmpUser: Ts0User;
begin
  DoBeforeLogin;
  Result := FLoginUser;
  if not UserCertification then Exit;
  FreeAndNil(FLoginUser);
  tmpUser := NewUser(LastUserName, '');
  try
    for i := 0 to Self.AllowLoginCount -1 do
    begin
      if not ShowCertifyDlg([k0cikUserName, k0cikPassword], tmpUser) then
      begin
        DoLoginFailure;
        Exit;
      end;
      if not DoCanLogin(tmpUser.UserName, tmpUser.Password) then Continue;
      FLoginUser := NewUser(tmpUser.UserName, tmpUser.Password);
      FLastUserName := tmpUser.UserName;
      DoLogin(FLoginUser);
      Result := FLoginUser;
      Exit;
    end;
    DoLoginFailure;
  finally
    FreeAndNil(tmpUser);
  end;
end;

procedure Ts0CustomGUIUserManager.Logout;
begin
  FreeAndNil(FLoginUser);
end;

function Ts0CustomGUIUserManager.ShowCertifyDlg(AMode: K0ConfirmItemKindSet;
  AUser: Ts0User): Boolean;
begin
  Result := False;
end;

procedure Ts0CustomGUIUserManager.DoLogin(AUser: Ts0User);
begin
  if Assigned(FOnLogin) then
    FOnLogin(FLoginUser, AUser);
end;

procedure Ts0CustomGUIUserManager.DoLoginFailure;
begin
  if Assigned(FOnLoginFailure) then
    FOnLoginFailure(Self);
end;

function Ts0CustomGUIUserManager.DoCanChangePW(const AUserName, AOldPW,
  ANewPW: string): Boolean;
begin
  Result := True;
  if Assigned(FOnCanChangePassword) then
    FOnCanChangePassword(Self, AUserName, AOldPW, ANewPW, Result);
end;

procedure Ts0CustomGUIUserManager.SetLastUserName(const Value: string);
begin
  FLastUserName := Value;
end;

type
  T9UserStartupAdaptor = class(Ts0AppStarter)
  public
    function CanStart: Boolean; override;
    function CanTerminate: Boolean; override;
  end;

{ T9UserStartupAdaptor }

function T9UserStartupAdaptor.CanStart: Boolean;
begin
  Result := True;
  if g9UserMan = nil then Exit;
  Result := (g9UserMan.Login <> nil);
end;

function T9UserStartupAdaptor.CanTerminate: Boolean;
begin
  Result := True;
end;


initialization
  Ts0AppStarters.RegisterStarter(T9UserStartupAdaptor);

finalization
  Ts0AppStarters.UnRegisterStarter(T9UserStartupAdaptor);


end.

