unit s0CtrlDistiller;
{
$History: s0CtrlDistiller.pas $
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/12/07   Time: 14:36
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/11/28   Time: 22:00
 * Updated in $/source/D5Integrated
 * 各Ｄｉｓｔｉｌｌｅｒが登録／登録解除されたときのイベントを追加。
 * NotificationRegister/RemoveNotificationRegisterでイベントの登録と解除を
 * 行う。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/11/07   Time: 21:00
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/23   Time: 1:11
 * Updated in $/source/D5Integrated
 * Ts0CtrlDistillBroker.FindDistillerにnilが渡されたときに例外を発生するよ
 * うに変更。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/20   Time: 0:00
 * Updated in $/source/D5Integrated
 * GetTitle、SetTitleメソッドで使用するFocusControlLabelメソッドを追加
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/06   Time: 21:22
 * Updated in $/source/D5Integrated
 * DistillerにKeyDown、MouseDownメソッドを追加した
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/20   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * グローバルなリストをFreeしてなかったのでfinalizationでFreeするように修
 * 正
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0comctrl
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/16   Time: 18:06
 * Updated in $/source/D5/p0comctrl
 * GetAccessorメソッドで、対象のAccessorがnilの時、NullAccessorを返すよう
 * に変更
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/08   Time: 23:11
 * Updated in $/source/p0control
 * K0CtrlEventTypeやR0KeyEventsでOnChangeイベントを扱えるように変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/07   Time: 21:34
 * Updated in $/source/p0control
 * GetAccessorメソッドを追加
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/30   Time: 10:07
 * Created in $/source/p0control
 * 新規作成
}
{
  u1ControlDistillBroker の 0レベル移行版
}

interface

uses
	SysUtils, Classes, Controls, Graphics, StdCtrls,
  s0Observer,
  s0InputStyle,
  s0DataAccessor;

type
	K0CtrlEventType = (k0cetOnExit, k0cetOnClick, k0cetOnPressEnter, k0cetOnKeyUp, k0cetOnChange);
  K0CtrlEventTypeSet = set of K0CtrlEventType;

type
  R0FocusEvents = packed record
  	FOnEnter   : TNotifyEvent;
  	FOnExit    : TNotifyEvent;
  end;

type
  R0MouseEvents = packed record
    FOnClick    : TNotifyEvent;
    FOnDblClick : TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp  : TMouseEvent;
  end;

type
  R0KeyEvents = packed record
    FOnKeyDown : TKeyEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp   : TKeyEvent;
    FOnChange  : TNotifyEvent;
  end;

type
  R0SizeEvents = packed record
    FOnCanResize: TCanResizeEvent;
    FOnResize: TNotifyEvent;
  end;

{
  このユニットのメソッドの大半の引数には
  AControl: TObject
  というものが含まれる。
  引数AControlがTControlやTWinControlではないのは、それら以外のクラスを
  コントロールとして見ないしたい場合を想定してのこと。
  また、IsTargetメソッドで型がチェックされているはずなので、
  引数AControlはほとんどの場合、ダウンキャストしてアクセスされる。
  よって、TControlやTWinControlである必要は（それほど）ない。
}

type
	Ts0CtrlDistillerClass = class of Ts0CtrlDistiller;
  Ts0CtrlDistiller = class
  public
    {
      GetUpdateEvents
      指定されたコントロールを、T1ProxyFieldのControl、ControlColに設定する
      場合に使用されるメソッド。T1ProxyFieldのModifyEventsプロパティのデフォルト値は、
      コントロールによって異なる。
      よって、T1ProxyFieldのControl、ControlColプロパティの設定時には、
      このメソッドによってコントロールごとに推奨？されるK1ControlEventTypeSetを
      取得する。
    }
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; virtual;
    {
      GetFocusEvents
      GetMouseEvents
      GetKeyEvents
      GetSizeEvents
      指定されたコントロールのイベントを構造体を用いて取得する
    }
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; virtual;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; virtual;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; virtual;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; virtual;
    {
      SetFocusEvents
      SetMouseEvents
      SetKeyEvents
      SetSizeEvents
      指定されたコントロールのイベントを構造体を用いて設定する。
    }
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); virtual;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); virtual;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); virtual;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); virtual;
    {
       GetValue
       SetValue
       指定されたコントロールに引数で渡された種類の型によって、
       値を設定/取得する。
    }
    class function GetValue(AControl: TObject): string; virtual;
    class procedure SetValue(Value: string; AControl: TObject); virtual;
    {
      SetTitle
      GetTitle
      指定されたコントロールのTitleプロパティを設定する。
    }
    class function GetTitle(AControl: TObject): string; virtual;
    class procedure SetTitle(Value: string; AControl: TObject); virtual;
    {
      GetAccessor
      コントロールのデータに同じインタフェースでアクセスするための
      "Accessor"を取得する。
    }
    class function GetAccessor(AControl: TObject): Ts0DataAccessor; virtual;
    {
      GetInputControl
      入力コントロールの諸属性を操作するT0InputControlを取得する
    }
    class function GetInputControl(AControl: TObject): Ts0InputStyle; virtual;
    {
      Click
      KeyDown
      MouseDown
      外部から擬似的にキーやマウスの操作を行うためのインタフェース。
      っていうか、TWinControlクラス辺りで公開されていればこんなこと
      しなくて済むんだけど。
    }
    class procedure Click(AControl: TObject); virtual;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); virtual;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    {
      GetCanvas
      Canvasを取得する。
    }
    class function GetCanvas(AControl: TObject): TCanvas; virtual;
    {
      IsTarget
      T0ControlDistillBrokerが引数で渡されたコントロールのDistillerを検索する
      場合に、呼び出されるメソッド。
      コントロールがDistillerの対象となるものならば、Trueを返す。

    }
    class function IsTarget(AControl: TObject): Boolean; virtual;
    class function FocusControlLabel(AControl: TObject): TCustomLabel;
    {
    	GetColor/SetColor
      色の取得と設定
    }
    class function GetColor(AControl: TObject): TColor; virtual;
    class procedure SetColor(AControl: TObject; AColor: TColor); virtual;
  end;

type
  K0DistillerRegisterOperationKind = (k0drokRegister, k0drokUnRegister);



type
  Ts0CtrlDistillerBrokerClass = class of Ts0CtrlDistillBroker;

  Ts0DistillerRegisterEvent = class(Ts0Subject)
  private
    FOperation: K0DistillerRegisterOperationKind;
    FSender: Ts0CtrlDistillerBrokerClass;
    FDistillerClass: Ts0CtrlDistillerClass;
  public
    property Sender: Ts0CtrlDistillerBrokerClass read FSender;
    property DistillerClass: Ts0CtrlDistillerClass read FDistillerClass;
    property Operation: K0DistillerRegisterOperationKind read FOperation;
  end;

	Ts0CtrlDistillBroker = class(Ts0CtrlDistiller)
  private
    {*************************************************************************
      これらのメソッドは内部ですべて、FindEventsClassによってDistillerを
      検索し、見つかった場合にはDistillerの同名のメソッドを呼び出すだけの
      メソッドです。
    *************************************************************************}
    {
      GetDistiller
      FindDistiller
      指定されたコントロールに対応するDistillerを検索するメソッド。
      見つからなかった場合に、GetEventsClassはnilを返却するが、
      FindEventsClassは例外を生成する。
    }
    class function GetDistiller(AControl: TObject): Ts0CtrlDistillerClass;
    class function FindDistiller(AControl: TObject): Ts0CtrlDistillerClass;
  public
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetAccessor(AControl: TObject): Ts0DataAccessor; override;
    class function GetInputControl(AControl: TObject): Ts0InputStyle; override;
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    class function GetCanvas(AControl: TObject): TCanvas; override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  public
    {
      RegisterDistiller
      UnRegisterDistiller
      DistillerをBrokerに登録/解除するメソッド。
    }
    class procedure RegisterDistiller(ADistillerClass: Ts0CtrlDistillerClass);
    class procedure UnRegisterDistiller(ADistillerClass: Ts0CtrlDistillerClass);
    class procedure NotificationRegister(AEventListener: Ts0Observer);
    class procedure RemoveNotificationRegister(AEventListener: Ts0Observer);
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetBroker: Ts0CtrlDistillerBrokerClass;
    class procedure RegisterBroker(AClass: Ts0CtrlDistillerBrokerClass);
  public
    class function GetReturnNullAccessor: Boolean;
    class procedure SetReturnNullAccessor(const Value: Boolean);
  end;

implementation

uses
  Contnrs,
  s0TypInfoWrapper,
	s0Exception;

{ Ts0CtrlDistiller }

class procedure Ts0CtrlDistiller.Click(AControl: TObject);
begin
end;

class function Ts0CtrlDistiller.FocusControlLabel(
  AControl: TObject): TCustomLabel;
var
  i: Integer;
  ctrl: TWinControl;
  acsr: Ts0RTTIPublishedAccessor;
begin
  Result := nil;
  if not(AControl is TWinControl) then Exit;
  ctrl := TWinControl(AControl);
  if ctrl.Owner = nil then Exit;
  for i := 0 to ctrl.Owner.ComponentCount -1 do
  begin
    if not(ctrl.Owner.Components[i] is TCustomLabel) then Continue;
    Result := TCustomLabel(ctrl.Owner.Components[i]);
    acsr := Ts0RTTIPublishedAccessor.Create(Result);
    try
      if acsr.ObjectProp['FocusControl'] = ctrl then Exit;
    finally
      FreeAndNil(acsr);
    end;
  end;
  Result := nil;
end;

class function Ts0CtrlDistiller.GetAccessor(AControl: TObject): Ts0DataAccessor;
begin
  Result := nil;
end;

class function Ts0CtrlDistiller.GetCanvas(AControl: TObject): TCanvas;
begin
  Result := nil;
end;

class function Ts0CtrlDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := 0;
end;

class function Ts0CtrlDistiller.GetFocusEvents(AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := nil;
  Result.FOnExit  := nil;
end;

class function Ts0CtrlDistiller.GetInputControl(
  AControl: TObject): Ts0InputStyle;
begin
  Result := nil;
end;

class function Ts0CtrlDistiller.GetKeyEvents(AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := nil;
  Result.FOnKeyPress := nil;
  Result.FOnKeyUp    := nil;
  Result.FOnChange   := nil;
end;

class function Ts0CtrlDistiller.GetMouseEvents(AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := nil;
  Result.FOnDblClick  := nil;
  Result.FOnMouseDown := nil;
  Result.FOnMouseMove := nil;
  Result.FOnMouseUp   := nil;
end;

class function Ts0CtrlDistiller.GetSizeEvents(AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := nil;
  Result.FOnResize    := nil;
end;

class function Ts0CtrlDistiller.GetTitle(AControl: TObject): string;
var
  lbl: TCustomLabel;
  acsr: Ts0RTTIPublishedAccessor;
begin
  Result := '';
  lbl := FocusControlLabel(AControl);
  if lbl = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(lbl);
  try
    if not acsr.PropertyExists('Caption') then Exit;
    Result := acsr.StrProp['Caption'];
  finally
    FreeAndNil(lbl);
  end;
end;

class function Ts0CtrlDistiller.GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnExit, k0cetOnClick];
end;

class function Ts0CtrlDistiller.GetValue(AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0CtrlDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := False;
end;

class procedure Ts0CtrlDistiller.KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState);
begin
end;

class procedure Ts0CtrlDistiller.MouseDown(AControl: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

class procedure Ts0CtrlDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin

end;

class procedure Ts0CtrlDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
end;

class procedure Ts0CtrlDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
end;

class procedure Ts0CtrlDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
end;

class procedure Ts0CtrlDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0CtrlDistiller.SetTitle(Value: string; AControl: TObject);
var
  lbl: TCustomLabel;
  acsr: Ts0RTTIPublishedAccessor;
begin
  lbl := FocusControlLabel(AControl);
  if lbl = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(lbl);
  try
    if not acsr.PropertyExists('Caption') then Exit;
    acsr.StrProp['Caption'] := Value;
  finally
    FreeAndNil(acsr);
  end;
end;

class procedure Ts0CtrlDistiller.SetValue(Value: string;
  AControl: TObject);
begin
end;




{ Ts0CtrlDistillBroker }

class function Ts0CtrlDistillBroker.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
  function GetPublishedAccessor: Ts0DataAccessor;
  var
    acsr: Ts0RTTIPublishedAccessor;
    obj: TObject;
  begin
  	Result := nil;
    acsr := Ts0RTTIPublishedAccessor.Create(AControl);
    try
      if acsr.PropertyExists('Accessor') then
      begin
      	obj := acsr.ObjectProp['Accessor'];
        if obj is Ts0DataAccessor then
        	Result := Ts0DataAccessor(obj);
      end;
    finally
      FreeAndNil(acsr);
    end;
  end;
var
	distillerClass: Ts0CtrlDistillerClass;
begin
	distillerClass := FindDistiller(AControl);
  Result := distillerClass.GetAccessor(AControl);
  if Result = nil then
  	Result := GetPublishedAccessor;
  if (Result = nil) and (GetReturnNullAccessor) then
    Result := Ts0NullDataAccessor.Instance;
end;

class function Ts0CtrlDistillBroker.GetCanvas(AControl: TObject): TCanvas;
begin
  Result := nil;
end;

class function Ts0CtrlDistillBroker.GetFocusEvents(AControl: TObject): R0FocusEvents;
begin
  Result := FindDistiller(AControl).GetFocusEvents(AControl);
end;

class function Ts0CtrlDistillBroker.GetInputControl(
  AControl: TObject): Ts0InputStyle;
begin
  Result := FindDistiller(AControl).GetInputControl(AControl);
end;

class function Ts0CtrlDistillBroker.GetKeyEvents(AControl: TObject): R0KeyEvents;
begin
  Result := FindDistiller(AControl).GetKeyEvents(AControl);
end;

class function Ts0CtrlDistillBroker.GetMouseEvents(AControl: TObject): R0MouseEvents;
begin
  Result := FindDistiller(AControl).GetMouseEvents(AControl);
end;

var
  g9ReturnNullAccessor: Boolean = True;

class function Ts0CtrlDistillBroker.GetReturnNullAccessor: Boolean;
begin
  Result := g9ReturnNullAccessor;
end;

class function Ts0CtrlDistillBroker.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := FindDistiller(AControl).GetSizeEvents(AControl);
end;

class function Ts0CtrlDistillBroker.GetTitle(AControl: TObject): string;
begin
  Result := FindDistiller(AControl).GetTitle(AControl);
end;

class function Ts0CtrlDistillBroker.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := FindDistiller(AControl).GetUpdateEvents(AControl);
end;

class function Ts0CtrlDistillBroker.GetValue(AControl: TObject): string;
var
  acsr: Ts0DataAccessor;
begin
  acsr := GetAccessor(AControl);
  if acsr <> nil then
    Result := acsr.AsString
  else
    Result := FindDistiller(AControl).GetValue(AControl);
end;

class function Ts0CtrlDistillBroker.IsTarget(AControl: TObject): Boolean;
begin
  Result := (GetDistiller(AControl) <> nil);
end;

class procedure Ts0CtrlDistillBroker.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  FindDistiller(AControl).SetFocusEvents(Value, AControl);
end;

class procedure Ts0CtrlDistillBroker.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  FindDistiller(AControl).SetKeyEvents(Value, AControl);
end;

class procedure Ts0CtrlDistillBroker.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  FindDistiller(AControl).SetMouseEvents(Value, AControl);
end;

class procedure Ts0CtrlDistillBroker.SetReturnNullAccessor(const Value: Boolean);
begin
  g9ReturnNullAccessor := Value;
end;

class procedure Ts0CtrlDistillBroker.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  FindDistiller(AControl).SetSizeEvents(Value, AControl);
end;

class procedure Ts0CtrlDistillBroker.SetTitle(Value: string;
  AControl: TObject);
begin
  FindDistiller(AControl).SetTitle(Value, AControl);
end;

class procedure Ts0CtrlDistillBroker.SetValue(Value: string;
  AControl: TObject);
var
  acsr: Ts0DataAccessor;
begin
  acsr := GetAccessor(AControl);
  if acsr <> nil then
    acsr.AsString := Value
  else
    FindDistiller(AControl).SetValue(Value, AControl);
end;

class procedure Ts0CtrlDistillBroker.Click(AControl: TObject);
begin
  FindDistiller(AControl).Click(AControl);
end;

class procedure Ts0CtrlDistillBroker.KeyDown(AControl: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FindDistiller(AControl).KeyDown(AControl, Key, Shift);
end;

class procedure Ts0CtrlDistillBroker.MouseDown(AControl: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FindDistiller(AControl).MouseDown(AControl, Button, Shift, X, Y);
end;

class function Ts0CtrlDistillBroker.GetColor(AControl: TObject): TColor;
begin
	Result := FindDistiller(AControl).GetColor(AControl);
end;

class procedure Ts0CtrlDistillBroker.SetColor(AControl: TObject;
  AColor: TColor);
begin
  FindDistiller(AControl).SetColor(AControl, AColor);
end;



resourcestring
	c9ErrMsg_UnRegisteredControlEvent = 'Unregistered Ts0CtrlDistiller Class for %s';
  c9ErrMsg_NilObjectError = 'Nil object can not distill';

class function Ts0CtrlDistillBroker.FindDistiller(AControl: TObject): Ts0CtrlDistillerClass;
begin
  if AControl = nil then
    raise Es0RegisterException.Create(c9ErrMsg_NilObjectError);
  Result := GetDistiller(AControl);
  if Result = nil then
    raise Es0RegisterException.CreateFmt(c9ErrMsg_UnRegisteredControlEvent, [AControl.ClassName]);
end;



var
  g9DistillerList: TClassList = nil;

class function Ts0CtrlDistillBroker.GetDistiller(AControl: TObject): Ts0CtrlDistillerClass;
var
  i: Integer;
  distillerClass: Ts0CtrlDistillerClass;
begin
  Result := nil;
  if g9DistillerList = nil then Exit;
  for i := 0 to g9DistillerList.Count -1 do
  begin
  	distillerClass := Ts0CtrlDistillerClass(g9DistillerList.Items[i]);
    if distillerClass.IsTarget(AControl) then
    begin
      Result := Ts0CtrlDistillerClass(g9DistillerList.Items[i]);
      Exit;
    end;
  end;
end;

var
  g9BrokerEvent: Ts0DistillerRegisterEvent = nil;


class procedure Ts0CtrlDistillBroker.RegisterDistiller(ADistillerClass: Ts0CtrlDistillerClass);
var
	idx: Integer;
begin
  if g9DistillerList = nil then
    g9DistillerList := TClassList.Create;
	idx := g9DistillerList.IndexOf(ADistillerClass);
  if idx > -1 then Exit;
  g9DistillerList.Add( ADistillerClass );
  //
  if g9BrokerEvent = nil then Exit;
  g9BrokerEvent.FDistillerClass := ADistillerClass;
  g9BrokerEvent.FOperation := k0drokRegister;
  g9BrokerEvent.NotifyAll;
end;

class procedure Ts0CtrlDistillBroker.UnRegisterDistiller(ADistillerClass: Ts0CtrlDistillerClass);
begin
  if g9DistillerList = nil then Exit;
  if g9BrokerEvent <> nil then
  begin
    g9BrokerEvent.FDistillerClass := ADistillerClass;
    g9BrokerEvent.FOperation := k0drokUnRegister;
    g9BrokerEvent.NotifyAll;
  end;
  while g9DistillerList.Remove( ADistillerClass ) > -1 do ;
end;

class procedure Ts0CtrlDistillBroker.NotificationRegister(
  AEventListener: Ts0Observer);
begin
  if g9BrokerEvent = nil then
  begin
    g9BrokerEvent := Ts0DistillerRegisterEvent.Create;
    g9BrokerEvent.FSender := Self;
  end;
  g9BrokerEvent.Attach(AEventListener);
end;

class procedure Ts0CtrlDistillBroker.RemoveNotificationRegister(
  AEventListener: Ts0Observer);
begin
  if g9BrokerEvent = nil then Exit;
  g9BrokerEvent.Detach(AEventListener);
end;

var
  g9BrokerClass: Ts0CtrlDistillerBrokerClass = Ts0CtrlDistillBroker;

class function Ts0CtrlDistillBroker.GetBroker: Ts0CtrlDistillerBrokerClass;
begin
  Result := g9BrokerClass;
end;

class procedure Ts0CtrlDistillBroker.RegisterBroker(AClass: Ts0CtrlDistillerBrokerClass);
begin
  g9BrokerClass := AClass;
end;

initialization

finalization
  FreeAndNil(g9DistillerList);


end.




