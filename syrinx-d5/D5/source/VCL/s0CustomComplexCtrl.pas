{-----------------------------------------------------------------------------
 Unit Name: s0CustomComplexCtrl
 Author:    akima
 Purpose:
 TestCase: tc_s0CustomComplexCtrl
 $History: s0CustomComplexCtrl.pas $
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/02/14   Time: 21:11
 * Updated in $/source/D5Integrated
 * 子コントロールのTabStopをFalseにしたとき、そのコントロールを
 * マウスで選択しようとしてもフォーカスが正しく移らないバグを修正。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/02/07   Time: 23:39
 * Updated in $/source/D6VCLIntegrated
 * Ts0CCCItemにParentFontプロパティを追加。
 * Ts0CustomComplexCtrlのFontプロパティは、Canvas.Fontを参照していたが、
 * 上位クラスのFontを公開するように変更。
 * ChangedOfFontで、ItemsのFontを変更していたけど、それらはTControlなどの
 * ParentFont関係の実装に任せて、ここでは何もしないことにした。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/01/30   Time: 17:33
 * Updated in $/source/D5Integrated
 * ChangedOfFontメソッドをvirtualに。
 * また、CanvasのFontにFontの変更を反映するようにした。
 * 必要に応じてAdjustSizeを呼び出すようにした。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/01/30   Time: 15:05
 * Updated in $/source/D5Integrated
 * 改めてDelphi5用でもAutoSizeプロパティを使えるように変更
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/01/10   Time: 17:32
 * Updated in $/source/D5Integrated
 * SetFocusのバグ修正。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/01/10   Time: 16:54
 * Updated in $/source/D5Integrated
 * フォーカスされた時に子コントロールにフォーカスを移すようにした
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/12/20   Time: 10:05
 * Updated in $/source/D5Integrated
 * FEnabled,FTabStop,FReadOnlyのデフォルト値が設定されておらず、プロパティ
 * の値を正しくシリアライズできていなかった。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/12/19   Time: 21:17
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/12/19   Time: 19:13
 * Updated in $/source/D5Integrated
 * SetFocusメソッドをoverride。TabStopを無視し、かつFTabStopがFalseなら
 * 子コントロールにフォーカスをあわせる。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/12/13   Time: 12:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/12/12   Time: 14:11
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/12/12   Time: 3:50
 * Updated in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0CustomComplexCtrl;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Contnrs,
  s0VCLClasses,
  s0CtrlEventSnatcher,
  s0TypInfoWrapper;

type
  K0CCCPropKind = (
    { Native TControl Properties }
    k0c3pkAlign, k0c3pkAnchors, k0c3pkEnabled, k0c3pkHeight,
    k0c3pkLeft, k0c3pkTop, k0c3pkVisible, k0c3pkWidth,
    { Native TWinControl Properties }
    k0c3pkTabOrder, k0c3pkTabStop,
    { RTTI Properties }
    k0c3pkBorderStyle, k0c3pkCaption, k0c3pkColor, k0c3pkFont, k0c3pkParentColor,
    k0c3pkParentFont, k0c3pkReadOnly, k0c3pkText
  );
  K0CCCPropKindSet = set of K0CCCPropKind;

type
  K0CCCRTTIPropKind = k0c3pkBorderStyle..k0c3pkText;
  K0CCCRTTIPropKindSet = set of K0CCCRTTIPropKind;

type
  K0CCCPartEventKind = (
    k0c3peOnCanResize,
    k0c3peOnChange   ,
    k0c3peOnClick    ,
    k0c3peOnDblClick ,
    k0c3peOnEnter  ,
    k0c3peOnExit   ,
    k0c3peOnKeyDown  ,
    k0c3peOnKeyPress ,
    k0c3peOnKeyUp    ,
    k0c3peOnMouseDown,
    k0c3peOnMouseMove,
    k0c3peOnMouseUp  ,
    k0c3peOnResize
  );
  K0CCCPartEventKindSet = set of K0CCCPartEventKind;

type
  Ts0CCCItems = class;
  Ts0CustomComplexCtrl = class;

  Ts0CCCItemClass = class of Ts0CCCItem;
  Ts0CCCItem = class(Ts0VCLPersistent)
  private
    FOwnerList: Ts0CCCItems;
    FControl: TControl;
    FAccessor: Ts0RTTIPublishedAccessor;
    FIgnorance: K0CCCPropKindSet;
    FEventListener: Ts0CtrlEventListener;
    procedure SetIgnorance(const Value: K0CCCPropKindSet);
  protected
    { TControl Properties }
    function GetAlign: TAlign; virtual;
    function GetAnchors: TAnchors; virtual;
    function GetEnabled: Boolean; virtual;
    function GetHeight: Integer; virtual;
    function GetLeft: Integer; virtual;
    function GetTop: Integer; virtual;
    function GetVisible: Boolean; virtual;
    function GetWidth: Integer; virtual;
    procedure SetAlign(const Value: TAlign); virtual;
    procedure SetAnchors(const Value: TAnchors); virtual;
    procedure SetEnabled(const Value: Boolean); virtual;
    procedure SetHeight(const Value: Integer); virtual;
    procedure SetLeft(const Value: Integer); virtual;
    procedure SetTop(const Value: Integer); virtual;
    procedure SetVisible(const Value: Boolean); virtual;
    procedure SetWidth(const Value: Integer); virtual;
  protected
    { TWinControl Properties }
    function GetTabOrder: Integer; virtual;
    function GetTabStop: Boolean; virtual;
    procedure SetTabOrder(const Value: Integer); virtual;
    procedure SetTabStop(const Value: Boolean); virtual;
  protected
    { RTTI Properties }
    function GetBorderStyle: TBorderStyle; virtual;
    function GetCaption: string; virtual;
    function GetColor: TColor; virtual;
    function GetFont: TFont; virtual;
    function GetParentColor: Boolean; virtual;
    function GetParentFont: Boolean; virtual;
    function GetReadOnly: Boolean; virtual;
    function GetText: string; virtual;
    procedure SetBorderStyle(const Value: TBorderStyle); virtual;
    procedure SetCaption(const Value: string); virtual;
    procedure SetColor(const Value: TColor); virtual;
    procedure SetFont(const Value: TFont); virtual;
    procedure SetParentColor(const Value: Boolean); virtual;
    procedure SetParentFont(const Value: Boolean); virtual;
    procedure SetReadOnly(const Value: Boolean); virtual;
    procedure SetText(const Value: string); virtual;
  protected
    function GetOwnerCtrl: Ts0CustomComplexCtrl;
    procedure RestoreIgnorance;
    property Accessor: Ts0RTTIPublishedAccessor read FAccessor;
  public
    constructor Create(AOwner: TPersistent; AOwnerList: Ts0CCCItems; ACtrl: TControl); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SnatchEvents;
    procedure PutBackEvents;
    property Control: TControl read FControl;
    property Ignorance: K0CCCPropKindSet read FIgnorance write SetIgnorance;
  protected
    property Align: TAlign read GetAlign write SetAlign default alNone;
    property Anchors: TAnchors read GetAnchors write SetAnchors default [akLeft, akTop];
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property Visible: Boolean read GetVisible write SetVisible default True;
    property Left  : Integer read GetLeft   write SetLeft  ;
    property Top   : Integer read GetTop    write SetTop   ;
    property Width : Integer read GetWidth  write SetWidth ;
    property Height: Integer read GetHeight write SetHeight;
  protected
    property TabOrder: Integer read GetTabOrder write SetTabOrder;
    property TabStop: Boolean read GetTabStop write SetTabStop default True;
  protected
    property BorderStyle: TBorderStyle read GetBorderStyle write SetBorderStyle default bsSingle;
    property Caption: string read GetCaption write SetCaption;
    property Color: TColor read GetColor write SetColor default clWindow;
    property Font: TFont read GetFont write SetFont;
    property ParentColor: Boolean read GetParentColor write SetParentColor;
    property ParentFont: Boolean read GetParentFont write SetParentFont default False;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Text: string read GetText write SetText;
  end;

  Ts0CCCItems = class(TObjectList)
  private
    FOwner: Ts0CustomComplexCtrl;
    function GetItems(const Index: Integer): Ts0CCCItem;
    procedure SetItems(const Index: Integer; const Value: Ts0CCCItem);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      virtual;
  public
    property Items[const Index: Integer]: Ts0CCCItem read GetItems write SetItems; default;
  end;

  Ts0CustomComplexCtrl = class(TCustomControl)
  private
    FEnabled: Boolean;
    FReadOnly: Boolean;
    FTabStop: Boolean;
    FBorderStyle: TBorderStyle;
    FBorderStyleOfParts: TBorderStyle;
    FOnPartExit: TNotifyEvent;
    FOnPartEnter: TNotifyEvent;
    FPartsEventOptions: K0CCCPartEventKindSet;
    FOnChange: TNotifyEvent;
{$IFDEF VER130} {for Delphi5}
    FAutoSize: Boolean;
{$ENDIF}
    function GetColor: TColor;
    function GetReadOnly: Boolean;
    function GetTabStop: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetTabStop(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetBorderStyleOfParts(const Value: TBorderStyle);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
  private
    FCCCItems: Ts0CCCItems;
    FOwnerIgnorance: K0CCCPropKindSet;
    procedure SetOwnerIgnorance(const Value: K0CCCPropKindSet);
  protected
    function CanDoCtrlEvent(AEventKind: K0CCCPartEventKind; Sender: TObject): Boolean; virtual;
    procedure CtrlOnCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean); virtual;
    procedure CtrlOnChange(Sender: TObject); virtual;
    procedure CtrlOnClick(Sender: TObject); virtual;
    procedure CtrlOnDblClick(Sender: TObject); virtual;
    procedure CtrlOnEnter(Sender: TObject); virtual;
    procedure CtrlOnExit(Sender: TObject); virtual;
    procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure CtrlOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure CtrlOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); virtual;
    procedure CtrlOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure CtrlOnResize(Sender: TObject); virtual;
    function GetPositionOnMySelf(Sender: TObject; AOriginal: TPoint): TPoint;
{$IFDEF VER130} {for Delphi5}
    procedure SetAutoSize(Value: Boolean); virtual;
{$ENDIF}
  protected
    function GetEnabled: Boolean; override;
    procedure SetEnabled(Value: Boolean); override;
  protected
    procedure ChangedOfFont; virtual;
    procedure ChangedOfCanvasBrush(Sender: TObject);
    procedure CreateCtrls; virtual; abstract;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  protected
    property CCCItems: Ts0CCCItems read FCCCItems;
    property OwnerIgnorance: K0CCCPropKindSet read FOwnerIgnorance write SetOwnerIgnorance;
  protected
    property Color: TColor read GetColor write SetColor;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property Font;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property TabStop: Boolean read GetTabStop write SetTabStop default True;
  protected
{$IFDEF VER130} {for Delphi5}
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
{$ENDIF}
  protected
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
    property BorderStyleOfParts: TBorderStyle read FBorderStyleOfParts write SetBorderStyleOfParts default bsSingle;
    property PartsEventOptions: K0CCCPartEventKindSet read FPartsEventOptions
      write FPartsEventOptions default [k0c3peOnChange..k0c3peOnMouseUp];
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnPartEnter: TNotifyEvent read FOnPartEnter write FOnPartEnter;
    property OnPartExit : TNotifyEvent read FOnPartExit  write FOnPartExit ;
  end;

procedure Register;

implementation

uses
  TypInfo;

procedure Register;
begin
//  RegisterComponents('P Form', [Ts0CustomComplexCtrl]);
end;

type
  T9CtrlEventListener = class(Ts0CtrlEventListener)
  private
    FOwner: Ts0CustomComplexCtrl;
  public
    constructor Create(AOwner: Ts0CustomComplexCtrl);
    procedure CtrlOnCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean); override;
    procedure CtrlOnChange(Sender: TObject); override;
    procedure CtrlOnClick(Sender: TObject); override;
    procedure CtrlOnDblClick(Sender: TObject); override;
    procedure CtrlOnEnter(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
    procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); override;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure CtrlOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CtrlOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure CtrlOnResize(Sender: TObject); override;
  end;

type
  T9FontChageNotifier = class(TInterfacedObject, IChangeNotifier)
  private
    FOwner: Ts0CustomComplexCtrl;
  public
    constructor Create(AOwner: Ts0CustomComplexCtrl); reintroduce;
    procedure Changed;
  end;

{ T9CtrlEventListener }

constructor T9CtrlEventListener.Create(AOwner: Ts0CustomComplexCtrl);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure T9CtrlEventListener.CtrlOnCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  FOwner.CtrlOnCanResize(Sender, NewWidth, NewHeight, Resize);
end;

procedure T9CtrlEventListener.CtrlOnChange(Sender: TObject);
begin
  FOwner.CtrlOnChange(Sender);
end;

procedure T9CtrlEventListener.CtrlOnClick(Sender: TObject);
begin
  FOwner.CtrlOnClick(Sender);
end;

procedure T9CtrlEventListener.CtrlOnDblClick(Sender: TObject);
begin
  FOwner.CtrlOnDblClick(Sender);
end;

procedure T9CtrlEventListener.CtrlOnEnter(Sender: TObject);
begin
  FOwner.CtrlOnEnter(Sender);
end;

procedure T9CtrlEventListener.CtrlOnExit(Sender: TObject);
begin
  FOwner.CtrlOnExit(Sender);
end;

procedure T9CtrlEventListener.CtrlOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FOwner.CtrlOnKeyDown(Sender, Key, Shift);
end;

procedure T9CtrlEventListener.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
  FOwner.CtrlOnKeyPress(Sender, Key);
end;

procedure T9CtrlEventListener.CtrlOnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FOwner.CtrlOnKeyUp(Sender, Key, Shift);
end;

procedure T9CtrlEventListener.CtrlOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FOwner.CtrlOnMouseDown(Sender, Button, Shift, X, Y);
end;

procedure T9CtrlEventListener.CtrlOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FOwner.CtrlOnMouseMove(Sender, Shift, X, Y);
end;

procedure T9CtrlEventListener.CtrlOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FOwner.CtrlOnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure T9CtrlEventListener.CtrlOnResize(Sender: TObject);
begin
  FOwner.CtrlOnResize(Sender);
end;

{ T9FontChageNotifier }

procedure T9FontChageNotifier.Changed;
begin
  FOwner.ChangedOfFont;
end;

constructor T9FontChageNotifier.Create(AOwner: Ts0CustomComplexCtrl);
begin
  inherited Create;
  FOwner := AOwner;
end;

{ Ts0CCCItem }

const
  c9CCCItemRTTIPropNames: array[K0CCCRTTIPropKind] of string = (
    'BorderStyle', 'Caption', 'Color', 'Font', 'ParentColor', 'ParentFont', 'ReadOnly', 'Text'
  );

procedure Ts0CCCItem.Assign(Source: TPersistent);
begin
  if not (Source is Ts0CCCItem) then Exit;
  Ignorance := Ts0CCCItem(Source).Ignorance;
  Color   := Ts0CCCItem(Source).Color  ;
  Enabled := Ts0CCCItem(Source).Enabled;
  Font    := Ts0CCCItem(Source).Font   ;
  TabStop := Ts0CCCItem(Source).TabStop;
end;

constructor Ts0CCCItem.Create(AOwner: TPersistent; AOwnerList: Ts0CCCItems; ACtrl: TControl);
begin
  inherited Create(AOwner);
  FOwnerList := AOwnerList;
  FOwnerList.Add(Self);
  FControl := ACtrl;
  FAccessor := Ts0RTTIPublishedAccessor.Create(FControl);
  RestoreIgnorance;
end;

destructor Ts0CCCItem.Destroy;
begin
  PutBackEvents;
  FreeAndNil(FAccessor);
  inherited;
end;

function Ts0CCCItem.GetAlign: TAlign;
begin
  Result := FControl.Align;
end;

function Ts0CCCItem.GetAnchors: TAnchors;
begin
  Result := FControl.Anchors;
end;

function Ts0CCCItem.GetBorderStyle: TBorderStyle;
var
  s: string;
begin
  Result := bsNone;
  s := c9CCCItemRTTIPropNames[k0c3pkBorderStyle];
  if not FAccessor.PropertyExists(s) then Exit;
  Result := TBorderStyle( FAccessor.OrdProp[s] );
end;

function Ts0CCCItem.GetCaption: string;
var
  s: string;
begin
  Result := '';
  s := c9CCCItemRTTIPropNames[k0c3pkCaption];
  if not FAccessor.PropertyExists(s) then Exit;
  if FAccessor.EnabledAsString(s) then
    Result := FAccessor.PropAsString[s];
end;

function Ts0CCCItem.GetColor: TColor;
begin
  Result := FAccessor.OrdProp[ c9CCCItemRTTIPropNames[k0c3pkColor] ];
end;

function Ts0CCCItem.GetEnabled: Boolean;
begin
  Result := FControl.Enabled;
end;

function Ts0CCCItem.GetFont: TFont;
var
  obj: TObject;
begin
  Result := nil;  
  obj := FAccessor.ObjectProp[ c9CCCItemRTTIPropNames[k0c3pkFont] ];
  if obj is TFont then
    Result := TFont(obj);
end;

function Ts0CCCItem.GetHeight: Integer;
begin
  Result := FControl.Height;
end;

function Ts0CCCItem.GetLeft: Integer;
begin
  Result := FControl.Left;
end;

function Ts0CCCItem.GetOwnerCtrl: Ts0CustomComplexCtrl;
begin
  Result := nil;
  if FOwnerList is Ts0CCCItems then
    Result := Ts0CCCItems(FOwnerList).FOwner;
end;

function Ts0CCCItem.GetParentColor: Boolean;
begin
  Result := Boolean(FAccessor.OrdProp[c9CCCItemRTTIPropNames[k0c3pkParentColor]]);
end;

function Ts0CCCItem.GetParentFont: Boolean;
begin
  Result := Boolean(FAccessor.OrdProp[c9CCCItemRTTIPropNames[k0c3pkParentFont]]);
end;

function Ts0CCCItem.GetReadOnly: Boolean;
begin
  Result := Boolean(FAccessor.OrdProp[c9CCCItemRTTIPropNames[k0c3pkReadOnly]]);
end;

function Ts0CCCItem.GetTabOrder: Integer;
begin
  Result := 0;
  if not(FControl is TWinControl) then Exit;
  Result := TWinControl(FControl).TabOrder;
end;

function Ts0CCCItem.GetTabStop: Boolean;
begin
  Result := False;
  if not(FControl is TWinControl) then Exit;
  Result := TWinControl(FControl).TabStop;
end;

function Ts0CCCItem.GetText: string;
var
  s: string;
begin
  Result := '';
  s := c9CCCItemRTTIPropNames[k0c3pkText];
  if not FAccessor.PropertyExists(s) then Exit;
  if FAccessor.EnabledAsString(s) then
    Result := FAccessor.PropAsString[s];
end;

function Ts0CCCItem.GetTop: Integer;
begin
  Result := FControl.Top;
end;

function Ts0CCCItem.GetVisible: Boolean;
begin
  Result := FControl.Visible;
end;

function Ts0CCCItem.GetWidth: Integer;
begin
  Result := FControl.Width;
end;

procedure Ts0CCCItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FControl = AComponent then
  begin
    FControl := nil;
    FreeAndNil(FAccessor);
  end;
end;

procedure Ts0CCCItem.PutBackEvents;
begin
  if FEventListener = nil then Exit;
  Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FEventListener);
  FreeAndNil(FEventListener);
end;

procedure Ts0CCCItem.RestoreIgnorance;
var
  i: K0CCCPropKind;
begin
  FIgnorance := [];
  for i := Low(K0CCCRTTIPropKind) to High(K0CCCRTTIPropKind) do
    if not FAccessor.PropertyExists(c9CCCItemRTTIPropNames[i]) then
      Include(FIgnorance, i);
end;

procedure Ts0CCCItem.SetAlign(const Value: TAlign);
begin
  if k0c3pkAlign in Ignorance then Exit;
  FControl.Align := Value;
end;

procedure Ts0CCCItem.SetAnchors(const Value: TAnchors);
begin
  if k0c3pkAnchors in Ignorance then Exit;
  FControl.Anchors := Value;
end;

procedure Ts0CCCItem.SetBorderStyle(const Value: TBorderStyle);
var
  s: string;
begin
  if k0c3pkBorderStyle in Ignorance then Exit;
  s := c9CCCItemRTTIPropNames[k0c3pkBorderStyle];
  if not FAccessor.PropertyExists(s) then Exit;
  FAccessor.OrdProp[s] := Integer(Value);
end;

procedure Ts0CCCItem.SetCaption(const Value: string);
var
  s: string;
begin
  if k0c3pkCaption in Ignorance then Exit;
  s := c9CCCItemRTTIPropNames[k0c3pkCaption];
  if not FAccessor.PropertyExists(s) then Exit;
  if FAccessor.EnabledAsString(s) then
    FAccessor.PropAsString[s] := Value;
end;

procedure Ts0CCCItem.SetColor(const Value: TColor);
begin
  if k0c3pkColor in Ignorance then Exit;
  FAccessor.OrdProp[ c9CCCItemRTTIPropNames[k0c3pkColor] ] := Value;
end;

procedure Ts0CCCItem.SetEnabled(const Value: Boolean);
begin
  if k0c3pkEnabled in Ignorance then Exit;
  FControl.Enabled := Value;
end;

procedure Ts0CCCItem.SetFont(const Value: TFont);
begin
  if k0c3pkFont in Ignorance then Exit;
  FAccessor.ObjectProp[ c9CCCItemRTTIPropNames[k0c3pkFont] ] := Value;
end;

procedure Ts0CCCItem.SetHeight(const Value: Integer);
begin
  if k0c3pkHeight in Ignorance then Exit;
  FControl.Height := Value;
end;

procedure Ts0CCCItem.SetIgnorance(const Value: K0CCCPropKindSet);
begin
  FIgnorance := Value;
end;

procedure Ts0CCCItem.SetLeft(const Value: Integer);
begin
  if k0c3pkLeft in Ignorance then Exit;
  FControl.Left := Value;
end;

procedure Ts0CCCItem.SetParentColor(const Value: Boolean);
begin
  if k0c3pkParentColor in Ignorance then Exit;
  FAccessor.OrdProp[c9CCCItemRTTIPropNames[k0c3pkParentColor]] := Integer(Value);
end;

procedure Ts0CCCItem.SetParentFont(const Value: Boolean);
begin
  if k0c3pkParentFont in Ignorance then Exit;
  FAccessor.OrdProp[c9CCCItemRTTIPropNames[k0c3pkParentFont]] := Integer(Value);
end;

procedure Ts0CCCItem.SetReadOnly(const Value: Boolean);
begin
  if k0c3pkReadOnly in Ignorance then Exit;
  FAccessor.OrdProp[c9CCCItemRTTIPropNames[k0c3pkReadOnly]] := Integer(Value);
end;

procedure Ts0CCCItem.SetTabOrder(const Value: Integer);
begin
  if k0c3pkTabOrder in Ignorance then Exit;
  if FControl is TWinControl then
    TWinControl(FControl).TabOrder := Value;
end;

procedure Ts0CCCItem.SetTabStop(const Value: Boolean);
begin
  if k0c3pkTabStop in Ignorance then Exit;
  if FControl is TWinControl then
    TWinControl(FControl).TabStop := Value;
end;

procedure Ts0CCCItem.SetText(const Value: string);
var
  s: string;
begin
  if k0c3pkText in Ignorance then Exit;
  s := c9CCCItemRTTIPropNames[k0c3pkText];
  if not FAccessor.PropertyExists(s) then Exit;
  if FAccessor.EnabledAsString(s) then
    FAccessor.PropAsString[s] := Value;
end;

procedure Ts0CCCItem.SetTop(const Value: Integer);
begin
  if k0c3pkTop in Ignorance then Exit;
  FControl.Top := Value;
end;

procedure Ts0CCCItem.SetVisible(const Value: Boolean);
begin
  if k0c3pkVisible in Ignorance then Exit;
  FControl.Visible := Value;
end;

procedure Ts0CCCItem.SetWidth(const Value: Integer);
begin
  if k0c3pkWidth in Ignorance then Exit;
  FControl.Width := Value;
end;

procedure Ts0CCCItem.SnatchEvents;
begin
  if FControl = nil then Exit;
  if FEventListener <> nil then Exit;
  if not(FOwnerList is Ts0CCCItems) then Exit;
  FEventListener := T9CtrlEventListener.Create(Ts0CCCItems(FOwnerList).FOwner);
  Ts0CtrlEventSnatcher.Instance.RegisterListener(FControl, FEventListener);
end;

{ Ts0CCCItems }

function Ts0CCCItems.GetItems(const Index: Integer): Ts0CCCItem;
begin
  Result := Ts0CCCItem(inherited Items[Index]);
end;

procedure Ts0CCCItems.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].Notification(AComponent, Operation);
end;

procedure Ts0CCCItems.SetItems(const Index: Integer;
  const Value: Ts0CCCItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CustomComplexCtrl }

function Ts0CustomComplexCtrl.CanDoCtrlEvent(
  AEventKind: K0CCCPartEventKind; Sender: TObject): Boolean;
begin
  Result := AEventKind in FPartsEventOptions;
end;

procedure Ts0CustomComplexCtrl.ChangedOfCanvasBrush(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to FCCCItems.Count -1 do
    FCCCItems.Items[i].Color := Canvas.Brush.Color;
end;

procedure Ts0CustomComplexCtrl.ChangedOfFont;
begin
end;

procedure Ts0CustomComplexCtrl.CMEnter(var Message: TCMEnter);
begin
  inherited;
  if inherited TabStop then Exit;
//  SelectNext(nil, True, True);
end;

constructor Ts0CustomComplexCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  FCCCItems := Ts0CCCItems.Create(True);
  FCCCItems.FOwner := Self;
  Self.Font.FontAdapter := T9FontChageNotifier.Create(Self);
  Canvas.Brush.OnChange := Self.ChangedOfCanvasBrush;
  FOwnerIgnorance := [k0c3pkColor, k0c3pkFont, k0c3pkTabStop];
  FPartsEventOptions := [k0c3peOnChange..k0c3peOnMouseUp];
  FBorderStyle := bsNone;
  FBorderStyleOfParts := bsSingle;
  FEnabled := True;
  FTabStop := True;
  FReadOnly := False;
  inherited TabStop := False;
  CreateCtrls;
end;

procedure Ts0CustomComplexCtrl.CreateParams(var Params: TCreateParams);
const
  c9BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or c9BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure Ts0CustomComplexCtrl.CtrlOnCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  if not(k0c3peOnResize in FPartsEventOptions) then Exit;
  Resize := inherited CanResize(NewWidth, NewHeight);
end;

procedure Ts0CustomComplexCtrl.CtrlOnChange(Sender: TObject);
begin
  if not CanDoCtrlEvent(k0c3peOnChange, Sender) then Exit;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure Ts0CustomComplexCtrl.CtrlOnClick(Sender: TObject);
begin
  if not CanDoCtrlEvent(k0c3peOnClick, Sender) then Exit;
  inherited Click;
end;

procedure Ts0CustomComplexCtrl.CtrlOnDblClick(Sender: TObject);
begin
  if not CanDoCtrlEvent(k0c3peOnDblClick, Sender) then Exit;
  inherited DblClick;
end;

procedure Ts0CustomComplexCtrl.CtrlOnEnter(Sender: TObject);
begin
  if not CanDoCtrlEvent(k0c3peOnEnter, Sender) then Exit;
  if Assigned(FOnPartEnter) then
    FOnPartEnter(Self);
end;

procedure Ts0CustomComplexCtrl.CtrlOnExit(Sender: TObject);
begin
  if not CanDoCtrlEvent(k0c3peOnExit, Sender) then Exit;
  if Assigned(FOnPartExit) then
    FOnPartExit(Self);
end;

procedure Ts0CustomComplexCtrl.CtrlOnKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not CanDoCtrlEvent(k0c3peOnKeyDown, Sender) then Exit;
  inherited KeyDown(Key, Shift);
end;

procedure Ts0CustomComplexCtrl.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CanDoCtrlEvent(k0c3peOnKeyPress, Sender) then Exit;
  inherited KeyPress(Key);
end;

procedure Ts0CustomComplexCtrl.CtrlOnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not CanDoCtrlEvent(k0c3peOnKeyUp, Sender) then Exit;
  inherited KeyUp(Key, Shift);
end;

procedure Ts0CustomComplexCtrl.CtrlOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  if not CanDoCtrlEvent(k0c3peOnMouseDown, Sender) then Exit;
  p := GetPositionOnMySelf(Sender, Point(X, Y));
  inherited MouseDown(Button, Shift, p.x, p.y);
end;

procedure Ts0CustomComplexCtrl.CtrlOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  if not CanDoCtrlEvent(k0c3peOnMouseMove, Sender) then Exit;
  p := GetPositionOnMySelf(Sender, Point(X, Y));
  inherited MouseMove(Shift, p.x, p.y);
end;

procedure Ts0CustomComplexCtrl.CtrlOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  if not CanDoCtrlEvent(k0c3peOnMouseUp, Sender) then Exit;
  p := GetPositionOnMySelf(Sender, Point(X, Y));
  inherited MouseUp(Button, Shift, p.x, p.y);
end;

procedure Ts0CustomComplexCtrl.CtrlOnResize(Sender: TObject);
begin
  if not CanDoCtrlEvent(k0c3peOnMouseUp, Sender) then Exit;
  inherited Resize;
end;

destructor Ts0CustomComplexCtrl.Destroy;
begin
  FreeAndNil(FCCCItems);
  inherited;
end;

function Ts0CustomComplexCtrl.GetColor: TColor;
begin
  Result := Canvas.Brush.Color;
end;

function Ts0CustomComplexCtrl.GetEnabled: Boolean;
begin
  if k0c3pkEnabled in OwnerIgnorance then
    Result := FEnabled
  else
    Result := inherited GetEnabled;
end;

function Ts0CustomComplexCtrl.GetPositionOnMySelf(Sender: TObject;
  AOriginal: TPoint): TPoint;
begin
  if Sender is TControl then
    Result := Self.ScreenToClient(TControl(Sender).ClientToScreen(AOriginal))
  else
    Result := AOriginal;
end;

function Ts0CustomComplexCtrl.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

function Ts0CustomComplexCtrl.GetTabStop: Boolean;
begin
  if k0c3pkTabStop in OwnerIgnorance then
    Result := FTabStop
  else
    Result := inherited TabStop;
end;

procedure Ts0CustomComplexCtrl.Loaded;
var
  i: Integer;
begin
  inherited;
  if csDesigning in Self.ComponentState then Exit;
  for i := 0 to FCCCItems.Count -1 do
    FCCCItems.Items[i].SnatchEvents;
end;

procedure Ts0CustomComplexCtrl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FCCCItems <> nil then
    FCCCItems.Notification(AComponent, Operation);
end;

{$IFDEF VER130} {for Delphi5}
procedure Ts0CustomComplexCtrl.SetAutoSize(Value: Boolean);
begin
  if FAutoSize = Value then Exit;
  FAutoSize := Value;
  if Value then AdjustSize;
end;
{$ENDIF}

procedure Ts0CustomComplexCtrl.SetBorderStyle(const Value: TBorderStyle);
begin
  FBorderStyle := Value;
  RecreateWnd;
  AdjustSize;
end;

procedure Ts0CustomComplexCtrl.SetBorderStyleOfParts(
  const Value: TBorderStyle);
var
  i: Integer;
begin
  FBorderStyleOfParts := Value;
  for i := 0 to FCCCItems.Count -1 do
    FCCCItems.Items[i].BorderStyle := Value;
  AdjustSize;
end;

procedure Ts0CustomComplexCtrl.SetColor(const Value: TColor);
begin
  Canvas.Brush.Color := Value;
  if k0c3pkColor in Self.OwnerIgnorance then Exit;
  inherited Color := Value;
end;

procedure Ts0CustomComplexCtrl.SetEnabled(Value: Boolean);
var
  i: Integer;
begin
  FEnabled := Value;
  for i := 0 to FCCCItems.Count -1 do
    FCCCItems.Items[i].Enabled := Value;
  if k0c3pkEnabled in OwnerIgnorance then Exit;
  inherited SetEnabled(Value);
end;

procedure Ts0CustomComplexCtrl.SetFocus;
var
  ctrl: TWinControl;
begin
  if (k0c3pkTabStop in FOwnerIgnorance) and (not inherited TabStop) then
  begin
    ctrl := FindNextControl(nil, True, True, True);
    if ctrl <> nil then
      ctrl.SetFocus;
  end
  else
    inherited SetFocus;
end;

procedure Ts0CustomComplexCtrl.SetOwnerIgnorance(
  const Value: K0CCCPropKindSet);
begin
  FOwnerIgnorance := Value;
  Invalidate;
end;

procedure Ts0CustomComplexCtrl.SetReadOnly(const Value: Boolean);
var
  i: Integer;
begin
  FReadOnly := Value;
  for i := 0 to FCCCItems.Count -1 do
    FCCCItems.Items[i].ReadOnly := Value;
end;

procedure Ts0CustomComplexCtrl.SetTabStop(const Value: Boolean);
var
  i: Integer;
begin
  FTabStop := Value;
  for i := 0 to FCCCItems.Count -1 do
    FCCCItems.Items[i].TabStop := Value;
  if k0c3pkTabStop in OwnerIgnorance then Exit;
  inherited TabStop := Value;
end;

end.
