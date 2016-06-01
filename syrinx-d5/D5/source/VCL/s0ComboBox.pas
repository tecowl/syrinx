unit s0ComboBox;
{
$History: s0ComboBox.pas $
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 29  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/02/25   Time: 12:38
 * Updated in $/source/D5Integrated
 * Items.Objectsの保存方法を変更
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 02/02/21   Time: 23:19
 * Updated in $/source/D5Integrated
 * Items.Objectsのストリームへの書き込みを変更
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/02/08   Time: 2:33
 * Updated in $/source/D6VCLIntegrated
 * InputStyle関係を見直し。ちゃんと後でカスタマイズできるように考慮してみ
 * ました。
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/02/06   Time: 19:32
 * Updated in $/source/D6VCLIntegrated
 * ClearSelection、SelectAllメソッドがVER140からTCustomComboBoxに
 * 追加されたので、再宣言しないようにした。
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/05   Time: 4:34
 * Updated in $/source/D5Integrated
 * TabOrderControllerの処理をKeyUp時にも呼び出すようにした。
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/12/11   Time: 17:32
 * Updated in $/source/D5Integrated
 * Loadedで、Accessor.LoadEnumを呼び出すようにした。
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/12/10   Time: 16:15
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessorを作成。
 * Ts0StringsAccessorはTs0EnumCollectionを使用する。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/11/22   Time: 18:46
 * Updated in $/source/D5Integrated
 * T0ComboBoxControllerにSetTextメソッドを追加
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
 * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
 * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/09/28   Time: 15:54
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/25   Time: 10:06
 * Updated in $/source/D5Integrated
 * SetAsIntegerの実装を変更。
 * GetUpdateEventsをOnChangeに変更
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/05   Time: 14:27
 * Updated in $/source/D5Integrated
 * GetAsIntegerメソッドで、ItemIndexを考慮するように変更
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0comctrl
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/16   Time: 17:32
 * Updated in $/source/D5/p0comctrl
 * プロパティの可視性を変更
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/08   Time: 23:06
 * Updated in $/source/p0control
 * ItemsのObjectsを数値としてストリームに保存できるように
 * SaveObjectsAsIntプロパティを追加。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/08   Time: 18:35
 * Updated in $/source/p0control
 * R0KeyEvents.FOnChange追加対応
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/08   Time: 15:32
 * Updated in $/source/p0control
 * プロパティの可視性を少し変更。
 * ちょっとAccessorのメソッドを変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/08   Time: 2:41
 * Updated in $/source/p0control
}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics,
  s0CommonTypes,
  s0InputStyle,
  s0DataAccessor,
  s0CtrlDistiller,
  s0StringValidater;

type
  Ts0CustomComboBox = class;

  Ts0ComboBoxAccessor = class(Ts0StringsAccessor)
  protected
    function GetItemIndex: Integer; override;
    function GetSource: TStrings; override;
    procedure SetItemIndex(const Value: Integer); override;
  end;

  Ts0CustomComboBoxInputStyle = class(Ts0InputStyle)
  protected
    function GetOwnerCombo: Ts0CustomComboBox;
    function GetAlignment: TAlignment; override;
    function GetCharCase: TEditCharCase; override;
    function GetFont: TFont; override;
    function GetImeMode: TImeMode; override;
    function GetImeName: TImeName; override;
    function GetMaxLength: Integer; override;
    function GetModified: Boolean; override;
    function GetReadOnly: Boolean; override;
    procedure SetAlignment(const Value: TAlignment); override;
    procedure SetCharCase(const Value: TEditCharCase); override;
    procedure SetFont(const Value: TFont); override;
    procedure SetImeMode(const Value: TImeMode); override;
    procedure SetImeName(const Value: TImeName); override;
    procedure SetMaxLength(const Value: Integer); override;
    procedure SetModified(const Value: Boolean); override;
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
  end;

  Ts0CustomComboBox = class(TComboBox)
  private
    FModified: Boolean;
    FReadOnly: Boolean;
    FInputStyle: Ts0CustomComboBoxInputStyle;
    FAlignment: TAlignment;
    FAccessor: Ts0ComboBoxAccessor;
    procedure SetAcceptCharType(const Value: k1InpCharSet);
    procedure SetExclusiveAcceptChar(const Value: string);
    procedure SetTitleDisplay(const Value: TCustomLabel);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure SetAutoWidth(const Value: Boolean);
    procedure CMLimitText(var Message: TMessage); message CB_LIMITTEXT;
    procedure EMSetReadOnly(var Message: TMessage); message EM_SETREADONLY;
    function GetCanUndo: Boolean;
    function GetAutoTab: Boolean;
    function GetAutoWidth: Boolean;
    function GetTitleDisplay: TCustomLabel;
    procedure SetAutoTab(const Value: Boolean);
    function GetAcceptCharType: k1InpCharSet;
    function GetExclusiveAcceptChar: string;
    procedure SetModified(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetAccessor(const Value: Ts0ComboBoxAccessor);
    procedure SetInputStyle(const Value: Ts0CustomComboBoxInputStyle);
  private
    FOnNeedItems: TNotifyEvent;
  protected
    procedure Change; override;
    procedure DoEnter; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    function NewInputStyle: Ts0CustomComboBoxInputStyle; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure DoNeedItems;
    procedure DropDown; override;
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text;
    property Style;
    property Title: string read GetTitle write SetTitle;
  public
    procedure NormalDelete;
    property CanUndo: Boolean read GetCanUndo;
{$IFDEF VER130}
    procedure ClearSelection;
{$ENDIF}
    procedure ClearUndo;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
{$IFDEF VER130}
    procedure SelectAll;
{$ENDIF}
    procedure Undo;
    property Modified: Boolean read FModified write SetModified;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
  protected
    property AcceptCharType: k1InpCharSet read GetAcceptCharType write
      SetAcceptCharType default [k1ctalpha..k1ctkana];
    property Accessor: Ts0ComboBoxAccessor read FAccessor write SetAccessor;
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property AutoTab: Boolean read GetAutoTab write SetAutoTab default True;
    property AutoWidth: Boolean read GetAutoWidth write SetAutoWidth default
      True;
    property ExclusiveAcceptChar: string read GetExclusiveAcceptChar write
      SetExclusiveAcceptChar;
    property InputStyle: Ts0CustomComboBoxInputStyle read FInputStyle write SetInputStyle;
    property TitleDisplay: TCustomLabel read GetTitleDisplay write SetTitleDisplay;
    property OnNeedItems: TNotifyEvent read FOnNeedItems write FOnNeedItems;
  end;

type
  Ts0ComboBoxInputStyle = class(Ts0CustomComboBoxInputStyle)
  published
    { Control's Property }
    property Alignment;
    property CharCase;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property Modified;
    property ReadOnly;
  published
    { Original Property }
    property AcceptCharType;     
    property AutoTab;            
    property AutoWidth;          
    property ExclusiveAcceptChar;
    property Title;              
    property TitleDisplay;       
  end;

type
  Ts0ComboBox = class(Ts0CustomComboBox)
  private
    function GetInputStyle: Ts0ComboBoxInputStyle;
    procedure SetInputStyle(const Value: Ts0ComboBoxInputStyle);
  protected
    function NewInputStyle: Ts0CustomComboBoxInputStyle; override;
  published
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;
    property Items; { Must be published after OnMeasureItem }
  published
    property AcceptCharType;
    property Accessor;
    property Alignment;
    property AutoTab;
    property AutoWidth;
    property ExclusiveAcceptChar;
    property InputStyle: Ts0ComboBoxInputStyle read GetInputStyle write SetInputStyle;
    property ItemIndex;
    property ReadOnly;
    property TitleDisplay;
    property OnNeedItems;     
  end;

type
  Ts0ComboBoxDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
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
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

uses
  s0StringsObjFiler,
  s0ExStringList,
  s0TypeConvertor,
  s0TabOrderController,
  s0StringHelper;

{ Ts0ComboBoxAccessor }

function Ts0ComboBoxAccessor.GetItemIndex: Integer;
begin
  Result := Ts0CustomComboBox(Owner).ItemIndex;
  if Result < 0 then
    Result := Ts0CustomComboBox(Owner).Items.IndexOf(Ts0CustomComboBox(Owner).Text);
end;

function Ts0ComboBoxAccessor.GetSource: TStrings;
begin
  Result := Ts0CustomComboBox(Owner).Items;
end;

procedure Ts0ComboBoxAccessor.SetItemIndex(const Value: Integer);
begin
  Ts0CustomComboBox(Owner).ItemIndex := Value;
end;

{ Ts0CustomComboBox }

constructor Ts0CustomComboBox.Create(AOwner: TComponent);
const
  c9DownBtnWidth = 15;
begin
//  FInputStyle := GetStrategyClass.Create(Self);
  FAccessor := Ts0ComboBoxAccessor.Create(Self);
  inherited;
  FInputStyle := NewInputStyle;
  Ts0CustomComboBoxInputStyle(FInputStyle).AutoWidthMargin := c9DownBtnWidth;
  Style := csDropDown; //Read Only is False
end;

destructor Ts0CustomComboBox.Destroy;
begin
  FreeAndNil(FAccessor);
  FreeAndNil(FInputStyle);
  inherited;
end;

procedure Ts0CustomComboBox.DoNeedItems;
begin
  if Assigned(FOnNeedItems) then
    FOnNeedItems(Self);
end;

procedure Ts0CustomComboBox.DropDown;
begin
  DoNeedItems;
  inherited;
end;

procedure Ts0CustomComboBox.Change;
begin
  inherited;
  Modified := True;
  FInputStyle.ChangeText;
end;

function Ts0CustomComboBox.GetTitle: string;
begin
  Result := FInputStyle.Title
end;

procedure Ts0CustomComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  //上下キーで選択しているときには、AutoTabを無効にする。
  FInputStyle.CancelAutoTab := (Key in [VK_UP, VK_DOWN]);
  //
  if Key = VK_DOWN then
    if not DroppedDown then
      DoNeedItems;
  inherited;
  //
  if not DroppedDown then
    Ts0TabOrderController.Instance.KeyDown(Self, Key, Shift);
end;

procedure Ts0CustomComboBox.KeyPress(var Key: Char);
begin
  if FInputStyle.KeyPress(Key) then
  begin
    inherited KeyPress(Key);
  end;
end;

procedure Ts0CustomComboBox.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited;
  if FInputStyle <> nil then
    FInputStyle.Notification(AComponent, Operation);
end;

procedure Ts0CustomComboBox.SetAcceptCharType(const Value: k1InpCharSet);
begin
  FInputStyle.AcceptCharType := Value;
end;

procedure Ts0CustomComboBox.SetExclusiveAcceptChar(const Value: string);
begin
  FInputStyle.ExclusiveAcceptChar := Value;
end;

procedure Ts0CustomComboBox.SetTitle(const Value: string);
begin
  FInputStyle.Title := Value;
end;

procedure Ts0CustomComboBox.SetTitleDisplay(const Value: TCustomLabel);
begin
  FInputStyle.TitleDisplay := Value;
end;

procedure Ts0CustomComboBox.SetAutoWidth(const Value: Boolean);
begin
  FInputStyle.AutoWidth := Value;
end;

procedure Ts0CustomComboBox.CMLimitText(var Message: TMessage);
begin
  inherited;
  SetAutoWidth(AutoWidth);
end;

procedure Ts0CustomComboBox.EMSetReadOnly(var Message: TMessage);
var
  c, fc: TColor;
begin
  inherited;
  c := Color;
  fc := Font.Color;
  FInputStyle.CMSetReadOnly(c, fc);
  Color := c;
  Font.Color := fc;
end;

function Ts0CustomComboBox.GetCanUndo: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANUNDO, 0, 0) <> 0;
end;

{$IFDEF VER130}
procedure Ts0CustomComboBox.ClearSelection;
begin
  SendMessage(Handle, WM_CLEAR, 0, 0);
end;
{$ENDIF}

procedure Ts0CustomComboBox.CopyToClipboard;
begin
  SendMessage(Handle, WM_COPY, 0, 0);
end;

procedure Ts0CustomComboBox.CutToClipboard;
begin
  SendMessage(Handle, WM_CUT, 0, 0);
end;

procedure Ts0CustomComboBox.PasteFromClipboard;
begin
  SendMessage(Handle, WM_PASTE, 0, 0);
end;

procedure Ts0CustomComboBox.Undo;
begin
  SendMessage(Handle, WM_UNDO, 0, 0);
end;

procedure Ts0CustomComboBox.ClearUndo;
begin
  SendMessage(Handle, EM_EMPTYUNDOBUFFER, 0, 0);
end;

{$IFDEF VER130}
procedure Ts0CustomComboBox.SelectAll;
begin
  SendMessage(Handle, EM_SETSEL, 0, -1);
end;
{$ENDIF}

function Ts0CustomComboBox.GetAutoTab: Boolean;
begin
  Result := FInputStyle.AutoTab;
end;

function Ts0CustomComboBox.GetAutoWidth: Boolean;
begin
  Result := FInputStyle.AutoWidth;
end;

function Ts0CustomComboBox.GetTitleDisplay: TCustomLabel;
begin
  Result := FInputStyle.TitleDisplay;
end;

procedure Ts0CustomComboBox.SetAutoTab(const Value: Boolean);
begin
  FInputStyle.AutoTab := Value;
end;

function Ts0CustomComboBox.GetAcceptCharType: k1InpCharSet;
begin
  Result := FInputStyle.AcceptCharType;
end;

function Ts0CustomComboBox.GetExclusiveAcceptChar: string;
begin
  Result := FInputStyle.ExclusiveAcceptChar;
end;

procedure Ts0CustomComboBox.SetModified(const Value: Boolean);
begin
  FModified := Value;
end;

procedure Ts0CustomComboBox.NormalDelete;
begin
  SelLength := 1;
  SelText := '';
end;

procedure Ts0CustomComboBox.DoEnter;
begin
  FInputStyle.CancelAutoTab := False;
  inherited DoEnter;
end;

procedure Ts0CustomComboBox.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    if HandleAllocated then
      SendMessage(Handle, EM_SETREADONLY, Ord(Value), 0);
  end;
end;

procedure Ts0CustomComboBox.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
end;

procedure Ts0CustomComboBox.SetAccessor(const Value: Ts0ComboBoxAccessor);
begin
  FAccessor.Assign( Value );
end;

procedure Ts0CustomComboBox.DefineProperties(Filer: TFiler);
var
  sof: Ts0StringsObjFiler;
begin
  inherited DefineProperties(Filer);
  sof := Ts0StringsObjFiler.Create(Items);
  try
    sof.DefineProperties(Filer);
  finally
    FreeAndNil(sof);
  end;
end;

procedure Ts0CustomComboBox.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then Exit;
  Accessor.LoadEnum;
end;

procedure Ts0CustomComboBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not DroppedDown then
    Ts0TabOrderController.Instance.KeyDown(Self, Key, Shift);
end;

function Ts0CustomComboBox.NewInputStyle: Ts0CustomComboBoxInputStyle;
begin
  Result := Ts0CustomComboBoxInputStyle.Create(Self);
end;

procedure Ts0CustomComboBox.SetInputStyle(
  const Value: Ts0CustomComboBoxInputStyle);
begin
  FInputStyle.Assign(Value);
end;

{ Ts0ComboBoxDistiller }

class procedure Ts0ComboBoxDistiller.Click(AControl: TObject);
begin
  Ts0CustomComboBox(AControl).Click;
end;

class function Ts0ComboBoxDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomComboBox(AControl).Accessor;
end;

class function Ts0ComboBoxDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0CustomComboBox(AControl).Color;
end;

class function Ts0ComboBoxDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := Ts0CustomComboBox(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomComboBox(AControl).OnExit;
end;

class function Ts0ComboBoxDistiller.GetInputControl(
  AControl: TObject): Ts0InputStyle;
begin
  Result := Ts0CustomComboBox(AControl).FInputStyle;
end;

class function Ts0ComboBoxDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := Ts0CustomComboBox(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomComboBox(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomComboBox(AControl).OnKeyUp   ;
  Result.FOnChange   := Ts0CustomComboBox(AControl).OnChange  ;
end;

class function Ts0ComboBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := Ts0CustomComboBox(AControl).OnClick;
  Result.FOnDblClick  := Ts0CustomComboBox(AControl).OnDblClick;
{
  Result.FOnMouseDown := Ts0CustomComboBox(AControl).nil;
  Result.FOnMouseMove := Ts0CustomComboBox(AControl).nil;
  Result.FOnMouseUp   := Ts0CustomComboBox(AControl).nil;
}
end;

class function Ts0ComboBoxDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := nil;
//  Result.FOnResize    := nil;
end;

class function Ts0ComboBoxDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0ComboBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnChange];
end;

class function Ts0ComboBoxDistiller.GetValue(AControl: TObject): string;
begin
  Result := Ts0CustomComboBox(AControl).Text;
end;

class function Ts0ComboBoxDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is Ts0CustomComboBox);
end;

class procedure Ts0ComboBoxDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0CustomComboBox(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0ComboBoxDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomComboBox(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0ComboBoxDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomComboBox(AControl).Color := AColor;
end;

class procedure Ts0ComboBoxDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomComboBox(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomComboBox(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0ComboBoxDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomComboBox(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomComboBox(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomComboBox(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  Ts0CustomComboBox(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0ComboBoxDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomComboBox(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomComboBox(AControl).OnDblClick  := Value.FOnDblClick ;
{
  Ts0CustomComboBox(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomComboBox(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomComboBox(AControl).OnMouseUp   := Value.FOnMouseUp  ;
}
end;

class procedure Ts0ComboBoxDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0ComboBoxDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0ComboBoxDistiller.SetValue(Value: string; AControl: TObject);
begin
  Ts0CustomComboBox(AControl).Text := Value;
end;

{ Ts0CustomComboBoxInputStyle }

function Ts0CustomComboBoxInputStyle.GetAlignment: TAlignment;
begin
  Result := GetOwnerCombo.Alignment;
end;

function Ts0CustomComboBoxInputStyle.GetCharCase: TEditCharCase;
begin
  Result := GetOwnerCombo.CharCase;
end;

function Ts0CustomComboBoxInputStyle.GetFont: TFont;
begin
  Result := GetOwnerCombo.Font;
end;

function Ts0CustomComboBoxInputStyle.GetImeMode: TImeMode;
begin
  Result := GetOwnerCombo.ImeMode;
end;

function Ts0CustomComboBoxInputStyle.GetImeName: TImeName;
begin
  Result := GetOwnerCombo.ImeName;
end;

function Ts0CustomComboBoxInputStyle.GetMaxLength: Integer;
begin
  Result := GetOwnerCombo.MaxLength;
end;

function Ts0CustomComboBoxInputStyle.GetModified: Boolean;
begin
  Result := GetOwnerCombo.Modified;
end;

function Ts0CustomComboBoxInputStyle.GetOwnerCombo: Ts0CustomComboBox;
begin
  Result := Ts0CustomComboBox(Control);
end;

function Ts0CustomComboBoxInputStyle.GetReadOnly: Boolean;
begin
  Result := GetOwnerCombo.ReadOnly;
end;

function Ts0CustomComboBoxInputStyle.GetText: string;
begin
  Result := GetOwnerCombo.Text;
end;

procedure Ts0CustomComboBoxInputStyle.SetAlignment(const Value: TAlignment);
begin
 GetOwnerCombo.Alignment := Value;
end;

procedure Ts0CustomComboBoxInputStyle.SetCharCase(const Value: TEditCharCase);
begin
 GetOwnerCombo.CharCase := Value;
end;

procedure Ts0CustomComboBoxInputStyle.SetFont(const Value: TFont);
begin
  GetOwnerCombo.Font := Value;
end;

procedure Ts0CustomComboBoxInputStyle.SetImeMode(const Value: TImeMode);
begin
 GetOwnerCombo.ImeMode := Value;
end;

procedure Ts0CustomComboBoxInputStyle.SetImeName(const Value: TImeName);
begin
 GetOwnerCombo.ImeName := Value;
end;

procedure Ts0CustomComboBoxInputStyle.SetMaxLength(const Value: Integer);
begin
 GetOwnerCombo.MaxLength := Value;
end;

procedure Ts0CustomComboBoxInputStyle.SetModified(const Value: Boolean);
begin
 GetOwnerCombo.Modified := Value;
end;

procedure Ts0CustomComboBoxInputStyle.SetText(const Value: string);
begin
  GetOwnerCombo.Text := Value;
end;

{ Ts0ComboBox }

function Ts0ComboBox.GetInputStyle: Ts0ComboBoxInputStyle;
begin
  Result := Ts0ComboBoxInputStyle(inherited InputStyle);
end;

function Ts0ComboBox.NewInputStyle: Ts0CustomComboBoxInputStyle;
begin
  Result := Ts0ComboBoxInputStyle.Create(Self);
end;

procedure Ts0ComboBox.SetInputStyle(const Value: Ts0ComboBoxInputStyle);
begin
  inherited InputStyle := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0ComboBoxDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0ComboBoxDistiller);

end.
