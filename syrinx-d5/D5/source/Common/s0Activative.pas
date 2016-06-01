unit s0Activative;
{
  Ts0Activative
  有効か無効かがクラスとして大きな意味を持ちうるクラスの基底クラス。
  普通のTNotifyEvent型のイベントと、Ts0Event型のイベント両方を持つ。
  っていうかそれだけ。

  Ts0ChainedAcivative
  Chain of Responsibilityパターン（の亜種）の実装。
  と言うよりも、TDataBaseやTDataSetのように、Connected、Activeプロパティが
  お互いに関係しているクラスに用いる。

  Serverプロパティで指定されるインスタンスを上位のインスタンスだとすると、
  上位のインスタンスのActiveプロパティがFalseになると、下位のインスタンスの
  ActiveプロパティをFalseにする。
  また、下位のインスタンスのActiveプロパティがTrueになると、上位のインスタンスの
  ActiveプロパティをTrueにする。

  もしActiveを操作できない場合があるなら、派生先のクラスのActivate、
  Deactivateメソッドで例外を生成するようにしてください。

$History: s0Activative.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
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
 * User: Akima        Date: 01/08/06   Time: 13:58
 * Updated in $/source/p0common
 * Ts0Eventのコンストラクタの変更を反映した。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/18   Time: 19:09
 * Updated in $/source/p0common
 * コメントを追加
 *
 * *****************  Version 4  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:32
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes, 
  s0Observer;

type
  Ts0Activative = class(TComponent)
  private
    FActivateEvent: Ts0Event;
    FDeactivateEvent: Ts0Event;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    procedure SetActive(const Value: Boolean);
  protected
    function GetActive: Boolean; virtual;
    procedure Activate; virtual;
    procedure Deactivate; virtual;
    procedure DoActivate;
    procedure DoDeactivate;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Active: Boolean read GetActive write SetActive;
    property ActivateEvent: Ts0Event read FActivateEvent;
    property DeactivateEvent: Ts0Event read FDeactivateEvent;
  published
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
  end;


type
  Ts0ChainedAcivative = class(Ts0Activative)
  private
    FServer: Ts0Activative;
    FServerActivateListener: Ts0EventListener;
    FServerDeactivateListener: Ts0EventListener;
    procedure SetServer(const Value: Ts0Activative);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ServerActivated(Sender: TObject); virtual;
    procedure ServerDeactivated(Sender: TObject); virtual;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    property Server: Ts0Activative read FServer write SetServer;
  end;



implementation

{ Ts0Activative }

procedure Ts0Activative.Assign(Source: TPersistent);
begin
  inherited;

end;

constructor Ts0Activative.Create(AOnwer: TComponent);
begin
  inherited;
  FActivateEvent := Ts0Event.Create(Self);
  FDeactivateEvent := Ts0Event.Create(Self);
end;

destructor Ts0Activative.Destroy;
begin
  Deactivate;
  FreeAndNil(FDeactivateEvent);
  FreeAndNil(FActivateEvent);
  inherited;
end;

procedure Ts0Activative.Activate;
begin
  DoActivate;
end;

procedure Ts0Activative.Deactivate;
begin
  DoDeactivate;
end;

function Ts0Activative.GetActive: Boolean;
begin
  Result := False;
end;

procedure Ts0Activative.SetActive(const Value: Boolean);
begin
  if Value then Activate else Deactivate;
end;

procedure Ts0Activative.DoActivate;
begin
  FActivateEvent.NotifyAll;
  if Assigned(FOnActivate) then
    FOnActivate(Self);
end;

procedure Ts0Activative.DoDeactivate;
begin
  FDeactivateEvent.NotifyAll;
  if Assigned(FOnDeactivate) then
    FOnDeactivate(Self);
end;

{ Ts0ChainedAcivative }

constructor Ts0ChainedAcivative.Create(AOnwer: TComponent);
begin
  inherited;
  FServerActivateListener   := Ts0EventListener.Create(ServerActivated);
  FServerDeactivateListener := Ts0EventListener.Create(ServerDeactivated);
end;

destructor Ts0ChainedAcivative.Destroy;
begin
  if Server <> nil then
  begin
    Server.DeactivateEvent.Detach( FServerDeactivateListener );
    Server.ActivateEvent.Detach( FServerActivateListener );
  end;
  FreeAndNil(FServerDeactivateListener);
  FreeAndNil(FServerActivateListener);
  inherited;     
end;

procedure Ts0ChainedAcivative.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FServer = AComponent then
  begin
    RemoveFreeNotification(Server);
    Server := nil;
  end;
end;

procedure Ts0ChainedAcivative.ServerActivated(Sender: TObject);
begin
end;

procedure Ts0ChainedAcivative.ServerDeactivated(Sender: TObject);
begin
  Deactivate;
end;

procedure Ts0ChainedAcivative.SetServer(const Value: Ts0Activative);
begin
  if FServer = Value then Exit;
  if FServer <> nil then
  begin
    if FServer.ActivateEvent <> nil then FServer.ActivateEvent.Detach(FServerActivateListener);
    if FServer.DeactivateEvent <> nil then FServer.DeactivateEvent.Detach(FServerDeactivateListener);
  end;
  //
  FServer := Value;
  if FServer <> nil then
  begin
    FServer.FreeNotification(Self);
    FServer.ActivateEvent.Attach(FServerActivateListener);
    FServer.DeactivateEvent.Attach(FServerDeactivateListener);
  end;
end;

end.
 
