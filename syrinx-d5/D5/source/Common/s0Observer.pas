unit s0Observer;
{
$History: s0Observer.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 18:27
 * Updated in $/source/p0common
 * Ts0Subject.Createの大バグを修正。
 * TObjectListはCreateの引数に明示的にFalseを指定しないと、
 * Destroy時にItemsをFreeしてしまうんです。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/06   Time: 14:04
 * Updated in $/source/p0common
 * Ts0Eventのコンストラクタの定義を変更。
 * Ts0QueryEventを追加。
}

interface

uses
  SysUtils, Classes, Contnrs;

type
  {
    Ts0EventとT0Listener

    OBSERVERパターン[GoF95]の実装です。

    Q.なぜ、OBSERVERパターンが必要するのか？
    A.Delphiのメソッドポインタによる通知は、通知される対象が一つに限られてしまう。
      本フレームワークでは、複数の対象に通知を送りたい場合が多い。
      その場合、メソッドポインタ（イベント）での実装は難しいので、
      抽象的なTs0EventとT0Listenerを用意しておき、それらを用途に合わせて派生することにした。

    通常のイベントと対応付けられるように、Ts0EventはプロパティとしてSenderを
    持つが、これはTNotifyEventイベントなどの引数Senderに対応するものである。

    また、TNotifyEventのように「引数Senderだけで何かしらの通知を行う」という
    イベントのハンドラを簡単に呼び出せるように、T0NotifyListenerを予め実装した。
    このクラスは、AttachしたTs0EventがPublishされると、TNotifyEvent型の
    OnNotifyイベントに指定されたメソッドを呼び出す。


    OBSERVERパターンとは別に付加した機能として、T0Listener.DetachAllメソッドがある。
    これはAttachしているTs0Eventすべてに対してDetachを行うもので、
    T0ListenerのFree時などに使用されている。
  }
  Ts0Subject = class;

  Ts0Observer = class
  public
    destructor Destroy; override;
    procedure Update(ASubj: Ts0Subject); virtual;
  end;

  Ts0Subject = class
  private
    FObservers: TObjectList;
  protected
    function GetObserverCount: Integer;
    function GetObservers(const Index: Integer): Ts0Observer;
    procedure Notify(AObs: Ts0Observer);
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure NotifyAll;
    procedure Attach(AObs: Ts0Observer);
    procedure Detach(AObs: Ts0Observer);
    class procedure NotifyObsDestruction(AObs: Ts0Observer);
  end;

type
  Ts0Event = class(Ts0Subject)
  private
    FSender: TObject;
  public
    constructor Create(ASender: TObject); reintroduce; virtual;
    property Sender: TObject read FSender write FSender;
  end;

type
  Ts0EventListener = class(Ts0Observer)
  private
    FOnEvent: TNotifyEvent;
  public
    constructor Create(AHandler: TNotifyEvent); reintroduce; overload; virtual;
    procedure Update(ASubj: Ts0Subject); override;
    property OnEvent: TNotifyEvent read FOnEvent write FOnEvent;
  end;

type
  Ts0QueryEvent = class(Ts0Event)
  private
    FResultFlag: Boolean;
    FDefaultValue: Boolean;
  public
    constructor Create(ASender: TObject); override;
    function Query: Boolean; virtual; abstract;
    property ResultFlag: Boolean read FResultFlag write FResultFlag;
    property DefaultValue: Boolean read FDefaultValue write FDefaultValue default True;
  end;

type
  K0QueryEvent = procedure(Sender: TObject; var ResultFlag: Boolean) of object;

type
  Ts0QueryEventListener = class(Ts0Observer)
  private
    FOnEvent: K0QueryEvent;
  public
    constructor Create(AHandler: K0QueryEvent); reintroduce; overload; virtual;
    procedure Update(ASubj: Ts0Subject); override;
    property OnEvent: K0QueryEvent read FOnEvent write FOnEvent;
  end;

type
  Ts0AllMatchEvent = class(Ts0QueryEvent)
  public
    function Query: Boolean; override;
  end;

type
  Ts0OneMatchEvent = class(Ts0QueryEvent)
  public
    function Query: Boolean; override;
  end;



implementation

{ Ts0Observer }

destructor Ts0Observer.Destroy;
begin
  Ts0Subject.NotifyObsDestruction(Self);
  inherited;
end;

procedure Ts0Observer.Update(ASubj: Ts0Subject);
begin
end;

{ Ts0Subject }

procedure Ts0Subject.Attach(AObs: Ts0Observer);
begin
  if FObservers.IndexOf(AObs) > -1 then
    Exit;
  FObservers.Add(AObs);
end;

procedure Ts0Subject.Detach(AObs: Ts0Observer);
begin
  while FObservers.Remove(AObs) > -1 do ;
end;

procedure Ts0Subject.Notify(AObs: Ts0Observer);
begin
  AObs.Update(Self);
end;

procedure Ts0Subject.NotifyAll;
var
  i: Integer;
begin
  for i := 0 to FObservers.Count - 1 do
    Notify(Ts0Observer(FObservers.Items[i]));
end;

var
  g9SubjectList: TObjectList = nil;

constructor Ts0Subject.Create;
begin
  inherited Create;
  FObservers := TObjectList.Create(False);
  if g9SubjectList = nil then
    g9SubjectList := TObjectList.Create(False);
  g9SubjectList.Add(Self);
end;

destructor Ts0Subject.Destroy;
begin
  if g9SubjectList <> nil then
    g9SubjectList.Remove(Self);
  FreeAndNil(FObservers);
  inherited;
end;

class procedure Ts0Subject.NotifyObsDestruction(AObs: Ts0Observer);
var
  i: Integer;
begin
  if g9SubjectList = nil then Exit;
  for i := 0 to g9SubjectList.Count - 1 do
    Ts0Subject(g9SubjectList.Items[i]).Detach(AObs);
end;

function Ts0Subject.GetObserverCount: Integer;
begin
  Result := FObservers.Count;
end;

function Ts0Subject.GetObservers(const Index: Integer): Ts0Observer;
begin
  Result := Ts0Observer( FObservers.Items[Index] );
end;

{ Ts0Event }

constructor Ts0Event.Create(ASender: TObject);
begin
  inherited Create;
  FSender := ASender;
end;

{ Ts0EventListener }

constructor Ts0EventListener.Create(AHandler: TNotifyEvent);
begin
  inherited Create;
  FOnEvent := AHandler;
end;

procedure Ts0EventListener.Update(ASubj: Ts0Subject);
var
  s: TObject;
begin
  s := nil;
  if ASubj is Ts0Event then
    s := Ts0Event(ASubj).Sender;
  if Assigned(FOnEvent) then
    FOnEvent(s);
end;

{ Ts0QueryEvent }

constructor Ts0QueryEvent.Create(ASender: TObject);
begin
  FDefaultValue := True;
  inherited Create(ASender);
end;

{ Ts0QueryEventListener }

constructor Ts0QueryEventListener.Create(AHandler: K0QueryEvent);
begin
  inherited Create;
  FOnEvent := AHandler;
end;

procedure Ts0QueryEventListener.Update(ASubj: Ts0Subject);
var
  s: TObject;
  f: Boolean;
begin
  if not(ASubj is Ts0QueryEvent) then Exit;
  s := Ts0QueryEvent(ASubj).Sender;
  f := Ts0QueryEvent(ASubj).ResultFlag;
  if Assigned(FOnEvent) then FOnEvent(s, f);
  Ts0QueryEvent(ASubj).ResultFlag := f;
end;

{ Ts0AllMatchEvent }

function Ts0AllMatchEvent.Query: Boolean;
var
  i, c: Integer;
begin
  Result := False;
  ResultFlag := FDefaultValue;
  c := GetObserverCount;
  for i := 0 to c -1 do
  begin
    Notify(GetObservers(i));
    if not Self.ResultFlag then Exit;
  end;
  Result := True;
end;

{ Ts0OneMatchEvent }

function Ts0OneMatchEvent.Query: Boolean;
var
  i, c: Integer;
begin
  Result := True;
  ResultFlag := FDefaultValue;
  c := GetObserverCount;
  for i := 0 to c -1 do
  begin
    Notify(GetObservers(i));
    if Self.ResultFlag then Exit;
  end;
  Result := False;
end;

initialization

finalization
  FreeAndNil(g9SubjectList);

end.

