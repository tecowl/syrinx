unit s0AppInstance;
{
$History: s0AppInstance.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
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
 * User: Akima        Date: 01/09/01   Time: 0:09
 * Updated in $/source/D5/p0additional
 * 設計時にはコンストラクタで他のインスタンスが存在しているかどうかをチェ
 * ックしないように修正
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/07   Time: 10:34
 * Updated in $/source/p0common
 * コメントを追加
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/12   Time: 18:59
 * Updated in $/source/p0common
 * 登録するコンポーネントパレットがTechnoのままだった。
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:27
 * Created in $/Projects/SDRFrameWork/src/lib0
 * 新規追加
 * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
 * VSSでは共有してません。
}

interface

uses
  Windows, SysUtils, Classes;

type
  K0AppInstNeedNameEvent = procedure(Sender: TObject; var AName: string) of
    object;

type
  {
    Ts0AppInstance
    アプリケーションの二重起動を防ぐためのコンポーネント。
    このコンポーネントは置くだけで勝手に動きます。

    大雑把な動きを書くと、コンポーネントが実行時にロードされたとき、
    Loadedメソッドが呼び出され、そこでアプリケーション固有の名前を使って
    ミューテックスを検索して、存在してたら（他のアプリが起動してたら）
    protectedのFailToStartAppメソッドが実行される。

    FailToStartAppメソッドでは、AutoTerminateプロパティがTrueなら
    Application.Terminateを実行してアプリを終了させ、AutoTerminateプロパティが
    FalseならEs0AppInstException例外を発生させる。

    アプリケーション固有の名前は、AppInstNameプロパティで指定しておくことが
    できるが、OnMakeAppInstNameイベントをハンドリングしてそのハンドラの
    引数ANameに代入することで動的に指定することも可能。

    またEnabledプロパティがFalseならば、このコンポーネントは全く機能しない。
  }
  Ts0AppInstance = class(TComponent)
  private
    FAppInstName: string;
    FOnMakeAppInstName: K0AppInstNeedNameEvent;
    FAutoTerminate: Boolean;
    FEnabled: Boolean;
    procedure SetAppInstName(const Value: string);
    procedure SetEnabled(const Value: Boolean);
  protected
    procedure InitializeApp;
    procedure Loaded; override;
    function DoOnMakeAppInstName: string;
    function CanStartApp: Boolean;
    procedure FailToStartApp;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {
      GetInstance
      起動できた場合、このコンポーネントのインスタンスはアプリケーションに
      一つしかないので、それにアクセスするためのメソッド。
    }
    class function GetInstance: Ts0AppInstance;
  published
    {
      AutoTerminate
      2重起動している場合に、自動的に終了するか否か。
    }
    property AutoTerminate: Boolean read FAutoTerminate write FAutoTerminate
      default True;
    {
      AppInstName
      OnMakeAppInstName
      アプリケーションとしての固有の名前。
      OnMakeAppInstNameイベントで使用される前に変更することもできる。
    }
    property AppInstName: string read FAppInstName write SetAppInstName;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property OnMakeAppInstName: K0AppInstNeedNameEvent read FOnMakeAppInstName
      write FOnMakeAppInstName;
  end;

type
  Es0AppInstException = class(Exception);

implementation

uses
  s0Application;

{ Ts0AppInstance }

var
  g9ApInstance: Ts0AppInstance = nil;
  g9AppMutex: THandle = 0;

function Ts0AppInstance.CanStartApp: Boolean;
var
  existance: THandle;
begin
  Result := False;
  existance := OpenMutex(MUTEX_ALL_ACCESS, False, PChar(FAppInstName));
  if existance <> 0 then
  begin
    CloseHandle(existance);
    Exit;
  end;
  Result := True;
end;

resourcestring
  c9ExcptMsg_DuplicateComponent =
    'Ts0AppInstanceは2つ以上同時に使用できません';

constructor Ts0AppInstance.Create(AOwner: TComponent);
begin
  inherited;
  if not(csDesigning in Self.ComponentState) then 
    if g9ApInstance <> nil then
      raise Es0AppInstException.Create(c9ExcptMsg_DuplicateComponent);
  g9ApInstance := Self;
  FAutoTerminate := True;
  FEnabled := True;
  FAppInstName := 'AppIdentifier';
end;

destructor Ts0AppInstance.Destroy;
begin
  inherited;
  g9ApInstance := nil;
end;

function Ts0AppInstance.DoOnMakeAppInstName: string;
begin
  Result := FAppInstName;
  if Assigned(FOnMakeAppInstName) then
    FOnMakeAppInstName(Self, Result);
end;

resourcestring
  c9ExcptMsg_FailToStart = 'アプリケーションの起動に失敗しました';

procedure Ts0AppInstance.FailToStartApp;
begin
  if FAutoTerminate then
  begin
    Ts0Application.Instance.Terminate
  end
  else
    raise Es0AppInstException.Create(c9ExcptMsg_FailToStart);
end;

class function Ts0AppInstance.GetInstance: Ts0AppInstance;
begin
  Result := g9ApInstance;
end;

procedure Ts0AppInstance.InitializeApp;
begin
  if not Enabled then
    Exit;
  FAppInstName := DoOnMakeAppInstName;
  //
  if CanStartApp then
    g9AppMutex := CreateMutex(nil, False, PChar(FAppInstName))
  else
    FailToStartApp;
end;

procedure Ts0AppInstance.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then
    Exit;
  InitializeApp;
end;

procedure Ts0AppInstance.SetAppInstName(const Value: string);
begin
  FAppInstName := Value;
end;

procedure Ts0AppInstance.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

initialization

finalization
  ReleaseMutex(g9AppMutex);

end.
