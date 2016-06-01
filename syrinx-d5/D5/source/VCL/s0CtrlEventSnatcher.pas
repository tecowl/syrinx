unit s0CtrlEventSnatcher;
{
$History: s0CtrlEventSnatcher.pas $
 *
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/19   Time: 0:14
 * Updated in $/D5/source/VCL
 *
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 *
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 *
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 *
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/28   Time: 22:01
 * Updated in $/source/D5Integrated
 * DistillerBrokerからDistillerの登録が解除されたときにそのコントロールを
 * 使用しているControllerを削除するようにBrokerRegisterListenメソッドを追
 * 加。
 *
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/07   Time: 13:33
 * Updated in $/source/D5Integrated
 * FreeNotificationを使ってコントロールが破棄されることを通知されるように
 * した。
 * # っていうか今までやってなかったのかよ！ > 俺
 *
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/07   Time: 0:52
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/01   Time: 9:14
 * Updated in $/source/D5Integrated
 * OnCanResize、OｎMouseDown、OnMouseMove、OnMouseUp、OnResizeイベントもSn
 * atchできるようにした。
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/13   Time: 23:27
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/01   Time: 2:46
 * Updated in $/source/D5/p0comctrl
 * UnRegisterしたときに要らないControllerをFreeするようにした
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/08   Time: 23:07
 * Created in $/source/p0control
 * 新規作成
 * ｃ１ControlEventFacadeを変更して作成。
 *
 * *****************  Version 18  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes,
  Controls,
  Contnrs,
  s0VCLClasses,
  s0Observer,
  s0CtrlDistiller,
  s0Collection;

type
  Ts0CtrlEventListener = class
  private
  public
    destructor Destroy; override;
    procedure CtrlOnCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean); virtual;
    procedure CtrlOnChange(Sender: TObject); virtual;
    procedure CtrlOnClick(Sender: TObject); virtual;
    procedure CtrlOnDblClick(Sender: TObject); virtual;
    procedure CtrlOnEnter(Sender: TObject); virtual;
    procedure CtrlOnExit(Sender: TObject); virtual;
    procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      virtual;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      virtual;
    procedure CtrlOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure CtrlOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); virtual;
    procedure CtrlOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure CtrlOnResize(Sender: TObject); virtual;
  end;

type
  Ts0CESnatcherItem = class(Ts0VCLCollectionItem)
  private
    FFocusEventBuffer: R0FocusEvents;
    FMouseEventBuffer: R0MouseEvents;
    FKeyEventBuffer: R0KeyEvents;
    FSizeEventBuffer: R0SizeEvents;
    FControl: TControl;
    FEnabled: Boolean;
    FSnatched: Boolean;
    procedure SetControl(const Value: TControl);
  protected
    FListeners: TObjectList;
    procedure ClearEventBuffer;
    procedure CtrlOnCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure CtrlOnChange(Sender: TObject);
    procedure CtrlOnClick(Sender: TObject);
    procedure CtrlOnDblClick(Sender: TObject);
    procedure CtrlOnEnter(Sender: TObject);
    procedure CtrlOnExit(Sender: TObject);
    procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char);
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CtrlOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CtrlOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure CtrlOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CtrlOnResize(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure SnatchEvent;
    procedure PutEventBack;
    procedure RegisterListener(AListener: Ts0CtrlEventListener);
    procedure UnRegisterListener(AListener: Ts0CtrlEventListener);
    property Snatched: Boolean read FSnatched;
  published
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property Control: TControl read FControl write SetControl;
  end;

type
  Ts0CESnatcherItems = class(Ts0VCLCollection)
  private
    function GetControllers(const Index: Integer): Ts0CESnatcherItem;
  protected
  public
  	function Add(AControl: TControl; AListener: Ts0CtrlEventListener): Ts0CESnatcherItem;
    property Controllers[const Index: Integer]: Ts0CESnatcherItem read
      GetControllers; default;
  end;

type
  Ts0CtrlEventSnatcher = class(Ts0VCLComponent)
  private
    FControllers: Ts0CESnatcherItems;
    FWaitToSnatch: TObjectList;
    FDistillerBrokerListener: Ts0Observer;
    procedure SetControllers(const Value: Ts0CESnatcherItems);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure BrokerRegisterListen(
      Sender: Ts0CtrlDistillerBrokerClass;
      ADistillerClass: Ts0CtrlDistillerClass;
      AOperation: K0DistillerRegisterOperationKind);
    function CreateItems: Ts0CESnatcherItems; virtual;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; ASingleton: Boolean); reintroduce; overload; virtual;
    destructor Destroy; override;
    procedure SnatchEvent;
    procedure PutEventBack;
    procedure RegisterListener(AControl: TControl; AListener:
      Ts0CtrlEventListener; ASnatchSoon: Boolean = True);
    procedure UnRegisterListener(AControl: TControl; AListener:
      Ts0CtrlEventListener);
    class function Instance: Ts0CtrlEventSnatcher;
  published
    property Controllers: Ts0CESnatcherItems read FControllers write
      SetControllers;
  end;


implementation

uses
  s0SingletonKeeper,
  s0Exception;

{ Ts0CtrlEventListener }

procedure Ts0CtrlEventListener.CtrlOnCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnChange(Sender: TObject);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnClick(Sender: TObject);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnDblClick(Sender: TObject);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnEnter(Sender: TObject);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnExit(Sender: TObject);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure Ts0CtrlEventListener.CtrlOnResize(Sender: TObject);
begin
end;

destructor Ts0CtrlEventListener.Destroy;
begin
  Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, Self);
  inherited;
end;


{ Ts0CESnatcherItem }

procedure Ts0CESnatcherItem.ClearEventBuffer;
begin
  FillChar(FFocusEventBuffer, SizeOf(FFocusEventBuffer), 0);
  FillChar(FMouseEventBuffer, SizeOf(FMouseEventBuffer), 0);
  FillChar(FKeyEventBuffer, SizeOf(FKeyEventBuffer), 0);
  FillChar(FSizeEventBuffer, SizeOf(FSizeEventBuffer), 0);
end;

constructor Ts0CESnatcherItem.Create(Collection: TCollection);
begin
  FEnabled := True;
  ClearEventBuffer;
  inherited;
  FSnatched := False;
  FListeners := TObjectList.Create(False);
end;

procedure Ts0CESnatcherItem.CtrlOnCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var
  i: Integer;
begin
  if Assigned(FSizeEventBuffer.FOnCanResize) then
  begin
    FSizeEventBuffer.FOnCanResize(Sender, NewWidth, NewHeight, Resize);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnCanResize(Sender, NewWidth,
      NewHeight, Resize);
end;

procedure Ts0CESnatcherItem.CtrlOnChange(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FKeyEventBuffer.FOnChange) then
  begin
    FKeyEventBuffer.FOnChange(Sender);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnChange(Sender);
end;

procedure Ts0CESnatcherItem.CtrlOnClick(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FMouseEventBuffer.FOnClick) then
  begin
    FMouseEventBuffer.FOnClick(Sender);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnClick(Sender);
end;

procedure Ts0CESnatcherItem.CtrlOnDblClick(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FMouseEventBuffer.FOnDblClick) then
  begin
    FMouseEventBuffer.FOnDblClick(Sender);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnDblClick(Sender);
end;

procedure Ts0CESnatcherItem.CtrlOnEnter(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FFocusEventBuffer.FOnEnter) then
  begin
    FFocusEventBuffer.FOnEnter(Sender);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnEnter(Sender);
end;

procedure Ts0CESnatcherItem.CtrlOnExit(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FFocusEventBuffer.FOnExit) then
  begin
    FFocusEventBuffer.FOnExit(Sender);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnExit(Sender);
end;

procedure Ts0CESnatcherItem.CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
var
  i: Integer;
begin
  if Assigned(FKeyEventBuffer.FOnKeyDown) then
  begin
    FKeyEventBuffer.FOnKeyDown(Sender, Key, Shift);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnKeyDown(Sender, Key, Shift);
end;

procedure Ts0CESnatcherItem.CtrlOnKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
begin
  if Assigned(FKeyEventBuffer.FOnKeyPress) then
  begin
    FKeyEventBuffer.FOnKeyPress(Sender, Key);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnKeyPress(Sender, Key);
end;

procedure Ts0CESnatcherItem.CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift:
  TShiftState);
var
  i: Integer;
begin
  if Assigned(FKeyEventBuffer.FOnKeyUp) then
  begin
    FKeyEventBuffer.FOnKeyUp(Sender, Key, Shift);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnKeyUp(Sender, Key, Shift);
end;

procedure Ts0CESnatcherItem.CtrlOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  if Assigned(FMouseEventBuffer.FOnMouseDown) then
  begin
    FMouseEventBuffer.FOnMouseDown(Sender, Button, Shift, X, Y);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnMouseDown(Sender, Button,
      Shift, X, Y);
end;

procedure Ts0CESnatcherItem.CtrlOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  if Assigned(FMouseEventBuffer.FOnMouseMove) then
  begin
    FMouseEventBuffer.FOnMouseMove(Sender, Shift, X, Y);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnMouseMove(Sender, Shift, X,
      Y);
end;

procedure Ts0CESnatcherItem.CtrlOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  if Assigned(FMouseEventBuffer.FOnMouseUp) then
  begin
    FMouseEventBuffer.FOnMouseUp(Sender, Button, Shift, X, Y);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnMouseUp(Sender, Button,
      Shift, X, Y);
end;

procedure Ts0CESnatcherItem.CtrlOnResize(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FSizeEventBuffer.FOnResize) then
  begin
    FSizeEventBuffer.FOnResize(Sender);
  end;
  if not FEnabled then Exit;
  for i := 0 to FListeners.Count - 1 do
    Ts0CtrlEventListener(FListeners.Items[i]).CtrlOnResize(Sender);
end;

destructor Ts0CESnatcherItem.Destroy;
  procedure ReleaseControl;
  begin
    if FControl <> nil then
      FControl.RemoveFreeNotification(Self.OwnerComponent);
    if FSnatched then
      PutEventBack;
    FControl := nil;
  end;
begin
  ReleaseControl;
  ClearEventBuffer;
  FreeAndNil(FListeners);
  inherited;
end;

procedure Ts0CESnatcherItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FControl = AComponent then
  begin
    FControl := nil;
    if FSnatched then
      FSnatched := False;
  end;
end;


{
resourcestring
  c9ErrMsg_IllegalPutEventBack = 'Illegal Put Event Back';
  c9ErrMsg_IllegalSnatchEvent = 'Illegal Snatch Event';
}

procedure Ts0CESnatcherItem.PutEventBack;
begin
  if not FSnatched then Exit;
  if FControl = nil then Exit;
  Ts0CtrlDistillBroker.SetFocusEvents(FFocusEventBuffer, FControl);
  Ts0CtrlDistillBroker.SetMouseEvents(FMouseEventBuffer, FControl);
  Ts0CtrlDistillBroker.SetKeyEvents(FKeyEventBuffer, FControl);
  Ts0CtrlDistillBroker.SetSizeEvents(FSizeEventBuffer, FControl);
  ClearEventBuffer;
  FSnatched := False;
end;

procedure Ts0CESnatcherItem.RegisterListener(AListener: Ts0CtrlEventListener);
var
  idx: Integer;
begin
  idx := FListeners.IndexOf(AListener);
  if idx > -1 then Exit;
  FListeners.Add(AListener);
end;

procedure Ts0CESnatcherItem.SetControl(const Value: TControl);
var
  buf: Boolean;
begin
  buf := FSnatched;
  if FControl <> nil then
    FControl.RemoveFreeNotification(Self.OwnerComponent);
  if FSnatched then PutEventBack;
  FControl := Value;
  if FControl <> nil then
    FControl.FreeNotification(Self.OwnerComponent);
  if buf then SnatchEvent;
end;

procedure Ts0CESnatcherItem.SnatchEvent;
var
  lFocusE: R0FocusEvents;
  lMouseE: R0MouseEvents;
  lKeyE: R0KeyEvents;
  lSizeE: R0SizeEvents;
begin
  if FSnatched then Exit;
  if FControl = nil then Exit;
  FSnatched := True;
  ClearEventBuffer;

  FFocusEventBuffer := Ts0CtrlDistillBroker.GetFocusEvents(FControl);
  FMouseEventBuffer := Ts0CtrlDistillBroker.GetMouseEvents(FControl);
  FKeyEventBuffer := Ts0CtrlDistillBroker.GetKeyEvents(FControl);
  FSizeEventBuffer := Ts0CtrlDistillBroker.GetSizeEvents(FControl);

  FillChar(lFocusE, SizeOf(lFocusE), 0);
  FillChar(lMouseE, SizeOf(lMouseE), 0);
  FillChar(lKeyE, SizeOf(lKeyE), 0);
  FillChar(lSizeE, SizeOf(lSizeE), 0);

  lFocusE.FOnEnter := Self.CtrlOnEnter;
  lFocusE.FOnExit := Self.CtrlOnExit;
  lMouseE.FOnClick := Self.CtrlOnClick;
  lMouseE.FOnDblClick := Self.CtrlOnDblClick;
  lMouseE.FOnMouseDown := Self.CtrlOnMouseDown;
  lMouseE.FOnMouseMove := Self.CtrlOnMouseMove;
  lMouseE.FOnMouseUp := Self.CtrlOnMouseUp;
  lKeyE.FOnKeyDown := Self.CtrlOnKeyDown;
  lKeyE.FOnKeyPress := Self.CtrlOnKeyPress;
  lKeyE.FOnKeyUp := Self.CtrlOnKeyUp;
  lKeyE.FOnChange := Self.CtrlOnChange;
  lSizeE.FOnCanResize := Self.CtrlOnCanResize;
  lSizeE.FOnResize := Self.CtrlOnResize;

  Ts0CtrlDistillBroker.SetFocusEvents(lFocusE, FControl);
  Ts0CtrlDistillBroker.SetMouseEvents(lMouseE, FControl);
  Ts0CtrlDistillBroker.SetKeyEvents(lKeyE, FControl);
  Ts0CtrlDistillBroker.SetSizeEvents(lSizeE, FControl);
end;

procedure Ts0CESnatcherItem.UnRegisterListener(
  AListener: Ts0CtrlEventListener);
begin
  while FListeners.Remove(AListener) > -1 do ;
end;


{ Ts0CESnatcherItems }

function Ts0CESnatcherItems.Add(AControl: TControl; AListener: Ts0CtrlEventListener): Ts0CESnatcherItem;
begin
	Result := Ts0CESnatcherItem(inherited Add);
  Result.Control := AControl;
  Result.RegisterListener(AListener);
end;

function Ts0CESnatcherItems.GetControllers(
  const Index: Integer): Ts0CESnatcherItem;
begin
  Result := Ts0CESnatcherItem(Self.Items[Index]);
end;


type
  T9DistillBrokerEventListener = class(Ts0Observer)
  private
    FOwner: Ts0CtrlEventSnatcher;
  public
    constructor Create(AOwner: Ts0CtrlEventSnatcher);
    procedure Update(ASubj: Ts0Subject); override;
  end;

{ T9DistillBrokerEventListener }

constructor T9DistillBrokerEventListener.Create(
  AOwner: Ts0CtrlEventSnatcher);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure T9DistillBrokerEventListener.Update(ASubj: Ts0Subject);
var
  evnt: Ts0DistillerRegisterEvent;
begin
  if FOwner = nil then Exit;
  if not (ASubj is Ts0DistillerRegisterEvent) then Exit;
  evnt := Ts0DistillerRegisterEvent(ASubj);
  FOwner.BrokerRegisterListen(evnt.Sender, evnt.DistillerClass, evnt.Operation);
end;



{ Ts0CtrlEventSnatcher }

procedure Ts0CtrlEventSnatcher.BrokerRegisterListen(
  Sender: Ts0CtrlDistillerBrokerClass;
  ADistillerClass: Ts0CtrlDistillerClass;
  AOperation: K0DistillerRegisterOperationKind);
var
  i: Integer;
begin
  if AOperation <> k0drokUnRegister then Exit;
  for i := Controllers.Count - 1 downto 0 do
  begin
    if ADistillerClass.IsTarget(Controllers[i].FControl) then
    begin
      Controllers.Delete(i);
    end;
  end;
end;

constructor Ts0CtrlEventSnatcher.Create(AOwner: TComponent; ASingleton: Boolean);
begin
  inherited Create(AOwner);
  if ASingleton then
  	Ts0SingletonKeeper.Instance.RegisterSingletion(Self);
  FControllers := CreateItems;
  //
  FDistillerBrokerListener := T9DistillBrokerEventListener.Create(Self);
  Ts0CtrlDistillBroker.NotificationRegister(FDistillerBrokerListener);
end;

constructor Ts0CtrlEventSnatcher.Create(AOwner: TComponent);
begin
  Create(AOwner, True);
end;

function Ts0CtrlEventSnatcher.CreateItems: Ts0CESnatcherItems;
begin
  Result := Ts0CESnatcherItems.Create(Self, Ts0CESnatcherItem);
end;

destructor Ts0CtrlEventSnatcher.Destroy;
begin
  FreeAndNil(FDistillerBrokerListener);
  FreeAndNil(FControllers);
  Ts0SingletonKeeper.Instance.UnRegisterSingletion(Self);
  inherited;
end;

var
  g9Snatcher: Ts0CtrlEventSnatcher = nil;

class function Ts0CtrlEventSnatcher.Instance: Ts0CtrlEventSnatcher;
begin
  if g9Snatcher = nil then
    g9Snatcher := Ts0CtrlEventSnatcher.Create(nil);
  Result := g9Snatcher;
end;

procedure Ts0CtrlEventSnatcher.Loaded;
var
  i: Integer;
begin
  inherited;
  if FWaitToSnatch = nil then Exit;
  for i := 0 to FWaitToSnatch.Count - 1 do
    Ts0CESnatcherItem(FWaitToSnatch.Items[i]).SnatchEvent;
  FreeAndNil(FWaitToSnatch);
end;

procedure Ts0CtrlEventSnatcher.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited;
  if FControllers <> nil then
    FControllers.Notification(AComponent, Operation);
end;

procedure Ts0CtrlEventSnatcher.PutEventBack;
var
  i: Integer;
begin
  for i := 0 to FControllers.Count - 1 do
    if FControllers[i].Snatched then
      FControllers[i].PutEventBack;
end;

procedure Ts0CtrlEventSnatcher.RegisterListener(AControl: TControl;
  AListener: Ts0CtrlEventListener; ASnatchSoon: Boolean);
var
  i: Integer;
  newController: Ts0CESnatcherItem;
begin
  for i := 0 to FControllers.Count - 1 do
    if (FControllers[i].Control = AControl) then
    begin
      FControllers[i].RegisterListener(AListener);
      Exit;
    end;
  if csDesigning in AControl.ComponentState then Exit;
  //
  newController := FControllers.Add(AControl, AListener);
  if ASnatchSoon and (not newController.Snatched) then
    if [csLoading, csReading] * Self.ComponentState <> [] then
    begin
      if FWaitToSnatch = nil then
        FWaitToSnatch := TObjectList.Create;
      FWaitToSnatch.Add(newController);
    end
    else
      newController.SnatchEvent;
end;

procedure Ts0CtrlEventSnatcher.SetControllers(
  const Value: Ts0CESnatcherItems);
begin
  FControllers.Assign(Value);
end;

procedure Ts0CtrlEventSnatcher.SnatchEvent;
var
  i: Integer;
begin
  for i := 0 to FControllers.Count - 1 do
    if not FControllers[i].Snatched then
      FControllers[i].SnatchEvent;
end;

procedure Ts0CtrlEventSnatcher.UnRegisterListener(AControl: TControl;
  AListener: Ts0CtrlEventListener);
var
  i: Integer;
begin
  for i := FControllers.Count - 1 downto 0 do
    if (FControllers[i].Control = AControl) or (AControl = nil) then
    begin
      FControllers[i].UnRegisterListener(AListener);
      if FControllers[i].FListeners.Count < 1 then
        Self.FControllers.Delete(i);
    end;
end;

initialization

finalization
  FreeAndNil(g9Snatcher);

end.

