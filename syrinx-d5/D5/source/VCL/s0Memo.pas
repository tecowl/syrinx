unit s0Memo;
{
$History: s0Memo.pas $
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/02/08   Time: 2:33
 * Updated in $/source/D6VCLIntegrated
 * InputStyle関係を見直し。ちゃんと後でカスタマイズできるように考慮してみ
 * ました。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/02/05   Time: 4:34
 * Updated in $/source/D5Integrated
 * TabOrderControllerの処理をKeyUp時にも呼び出すようにした。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/11/26   Time: 2:40
 * Updated in $/source/D5Integrated
 * Ts0MemoDistillerのバグ修正。OnChangeとOnResizeが入れ替わっていた。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/11/23   Time: 0:19
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/11/22   Time: 18:47
 * Updated in $/source/D5Integrated
 * T0MemoControllerにSetTextメソッドを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
 * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
 * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0comctrl
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/16   Time: 18:05
 * Updated in $/source/D5/p0comctrl
 * AsIntegerKindのデフォルト値を設定
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/16   Time: 17:32
 * Updated in $/source/D5/p0comctrl
 * プロパティの可視性を変更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/08   Time: 18:36
 * Updated in $/source/p0control
 * R0KeyEvents.FOnChange追加対応
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/08   Time: 15:36
 * Updated in $/source/p0control
 * Accessorを実装した。
 * Distillerのバグを修正した。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/07   Time: 21:56
 * Created in $/source/p0control
 * 新規作成
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
  Ts0CustomMemo = class;

  Ts0MemoAccessor = class(Ts0DataAccessor)
  private
    function GetOwnerMemo: Ts0CustomMemo;
  protected
    function GetAsInteger: Integer; override;
    function GetAsString: String; override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: String); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  Ts0CustomMemoInputStyle = class(Ts0InputStyle)
  protected
    function GetOwnerMemo: Ts0CustomMemo;
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

  Ts0CustomMemo = class(TMemo)
  private
    FInputStyle: Ts0CustomMemoInputStyle;
    FAccessor: Ts0MemoAccessor;
    procedure SetTitleDisplay(const Value: TCustomLabel);
    procedure SetAcceptCharType(const Value: k1InpCharSet);
    procedure SetExclusiveAcceptChar(const Value: string);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure CMSetReadOnly(var Message: TMessage); message EM_SETREADONLY;
    function GetAcceptCharType: k1InpCharSet;
    function GetAutoTab: Boolean;
    function GetAutoWidth: Boolean;
    function GetExclusiveAcceptChar: string;
    function GetTitleDisplay: TCustomLabel;
    procedure SetAutoTab(const Value: Boolean);
    procedure SetAutoWidth(const Value: Boolean);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    procedure SetAccessor(const Value: Ts0MemoAccessor);
    procedure SetInputStyle(const Value: Ts0CustomMemoInputStyle);
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function NewInputStyle: Ts0CustomMemoInputStyle; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  protected
    property Accessor: Ts0MemoAccessor read FAccessor write SetAccessor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property MaxLength;
    procedure NormalDelete;
    property Title: string read GetTitle write SetTitle;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  protected
    property AcceptCharType: k1InpCharSet read GetAcceptCharType write
      SetAcceptCharType default [k1ctalpha..k1ctkana];
    property AutoTab: Boolean read GetAutoTab write SetAutoTab default True;
    property AutoWidth: Boolean read GetAutoWidth write SetAutoWidth default
      True;
    property ExclusiveAcceptChar: string read GetExclusiveAcceptChar write
      SetExclusiveAcceptChar;
    property InputStyle: Ts0CustomMemoInputStyle read FInputStyle write SetInputStyle;
    property TitleDisplay: TCustomLabel read GetTitleDisplay write SetTitleDisplay;
  end;

type
  Ts0MemoInputStyle = class(Ts0CustomMemoInputStyle)
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
  Ts0Memo = class(Ts0CustomMemo)
  private
    function GetInputStyle: Ts0MemoInputStyle;
    procedure SetInputStyle(const Value: Ts0MemoInputStyle);
  protected
    function NewInputStyle: Ts0CustomMemoInputStyle; override;
  published
    property Align;
    property Alignment;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property Lines;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  published
    property AcceptCharType;
    property AutoTab;
    property AutoWidth;
    property ExclusiveAcceptChar;
    property Accessor;
    property InputStyle: Ts0MemoInputStyle read GetInputStyle write SetInputStyle;
    property TitleDisplay;
  end;

type
  Ts0MemoDistiller = class(Ts0CtrlDistiller)
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
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

uses
  s0TabOrderController,
  s0StringHelper;

{ Ts0MemoAccessor }

constructor Ts0MemoAccessor.Create(AOwner: TComponent);
begin
  inherited;
end;

function Ts0MemoAccessor.GetAsInteger: Integer;
begin
  Result := -1;
end;

function Ts0MemoAccessor.GetAsString: String;
begin
  Result := GetOwnerMemo.Text;
end;

function Ts0MemoAccessor.GetOwnerMemo: Ts0CustomMemo;
begin
  Result := Ts0CustomMemo(Owner);
end;

procedure Ts0MemoAccessor.SetAsInteger(const Value: Integer);
begin
end;

procedure Ts0MemoAccessor.SetAsString(const Value: String);
begin
  GetOwnerMemo.Text := Value;
end;

{ Ts0CustomMemoInputStyle }

function Ts0CustomMemoInputStyle.GetAlignment: TAlignment;
begin
  Result := GetOwnerMemo.Alignment;
end;

function Ts0CustomMemoInputStyle.GetCharCase: TEditCharCase;
begin
  Result := GetOwnerMemo.CharCase;
end;

function Ts0CustomMemoInputStyle.GetFont: TFont;
begin
  Result := GetOwnerMemo.Font;
end;

function Ts0CustomMemoInputStyle.GetImeMode: TImeMode;
begin
  Result := GetOwnerMemo.ImeMode;
end;

function Ts0CustomMemoInputStyle.GetImeName: TImeName;
begin
  Result := GetOwnerMemo.ImeName;
end;

function Ts0CustomMemoInputStyle.GetMaxLength: Integer;
begin
  Result := GetOwnerMemo.MaxLength;
end;

function Ts0CustomMemoInputStyle.GetModified: Boolean;
begin
  Result := GetOwnerMemo.Modified;
end;

function Ts0CustomMemoInputStyle.GetOwnerMemo: Ts0CustomMemo;
begin
  Result := Ts0CustomMemo(Control);
end;

function Ts0CustomMemoInputStyle.GetReadOnly: Boolean;
begin
  Result := GetOwnerMemo.ReadOnly;
end;

function Ts0CustomMemoInputStyle.GetText: string;
begin
  Result := GetOwnerMemo.Lines.Text;
end;

procedure Ts0CustomMemoInputStyle.SetAlignment(const Value: TAlignment);
begin
  GetOwnerMemo.Alignment := Value;
end;

procedure Ts0CustomMemoInputStyle.SetCharCase(const Value: TEditCharCase);
begin
  GetOwnerMemo.CharCase := Value;
end;

procedure Ts0CustomMemoInputStyle.SetFont(const Value: TFont);
begin
  GetOwnerMemo.Font := Value;
end;

procedure Ts0CustomMemoInputStyle.SetImeMode(const Value: TImeMode);
begin
  GetOwnerMemo.ImeMode := Value;
end;

procedure Ts0CustomMemoInputStyle.SetImeName(const Value: TImeName);
begin
  GetOwnerMemo.ImeName := Value;
end;

procedure Ts0CustomMemoInputStyle.SetMaxLength(const Value: Integer);
begin
  GetOwnerMemo.MaxLength := Value;
end;

procedure Ts0CustomMemoInputStyle.SetModified(const Value: Boolean);
begin
  GetOwnerMemo.Modified := Value;
end;

procedure Ts0CustomMemoInputStyle.SetText(const Value: string);
begin
  GetOwnerMemo.Lines.Text := Value;
end;

{ Ts0CustomMemo }

procedure Ts0CustomMemo.Change;
begin
  inherited;
end;

procedure Ts0CustomMemo.CMSetReadOnly(var Message: TMessage);
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

constructor Ts0CustomMemo.Create(AOwner: TComponent);
begin
  FAccessor := Ts0MemoAccessor.Create(Self);
  inherited;
  FInputStyle := Ts0CustomMemoInputStyle.Create(Self);
  ReadOnly := False;
end;

destructor Ts0CustomMemo.Destroy;
begin
  FreeAndNil(FAccessor);
  FreeAndNil(FInputStyle);
  inherited;
end;

function Ts0CustomMemo.GetAcceptCharType: k1InpCharSet;
begin
  Result := FInputStyle.AcceptCharType;
end;

function Ts0CustomMemo.GetAutoTab: Boolean;
begin
  Result := FInputStyle.AutoTab;
end;

function Ts0CustomMemo.GetAutoWidth: Boolean;
begin
  Result := FInputStyle.AutoWidth;
end;

function Ts0CustomMemo.GetExclusiveAcceptChar: string;
begin
  Result := FInputStyle.ExclusiveAcceptChar;
end;

function Ts0CustomMemo.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
end;

function Ts0CustomMemo.GetTitle: string;
begin
  Result := FInputStyle.Title;
end;

function Ts0CustomMemo.GetTitleDisplay: TCustomLabel;
begin
  Result := FInputStyle.TitleDisplay;
end;

procedure Ts0CustomMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Ts0TabOrderController.Instance.KeyDown(Self, Key, Shift);
end;

procedure Ts0CustomMemo.KeyPress(var Key: Char);
begin
  if FInputStyle.KeyPress(Key) then
    inherited KeyPress(Key);
end;

procedure Ts0CustomMemo.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Ts0TabOrderController.Instance.KeyUp(Self, Key, Shift);
end;

function Ts0CustomMemo.NewInputStyle: Ts0CustomMemoInputStyle;
begin
  Result := Ts0CustomMemoInputStyle.Create(Self);
end;

procedure Ts0CustomMemo.NormalDelete;
begin
  SelLength := 1;
  SelText := '';
end;

procedure Ts0CustomMemo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if FInputStyle <> nil then
    FInputStyle.Notification(AComponent, Operation);
end;

procedure Ts0CustomMemo.SetAcceptCharType(const Value: k1InpCharSet);
begin
  FInputStyle.AcceptCharType := Value;
end;

procedure Ts0CustomMemo.SetAccessor(const Value: Ts0MemoAccessor);
begin
  FAccessor.Assign(Value);
end;

procedure Ts0CustomMemo.SetAutoTab(const Value: Boolean);
begin
  FInputStyle.AutoTab := Value;
end;

procedure Ts0CustomMemo.SetAutoWidth(const Value: Boolean);
begin
  FInputStyle.AutoWidth := Value;
end;

procedure Ts0CustomMemo.SetExclusiveAcceptChar(const Value: string);
begin
  FInputStyle.ExclusiveAcceptChar := Value;
end;

procedure Ts0CustomMemo.SetInputStyle(const Value: Ts0CustomMemoInputStyle);
begin
  FInputStyle.Assign(Value);
end;

procedure Ts0CustomMemo.SetReadOnly(const Value: Boolean);
var
  c, fc: TColor;
begin
  inherited ReadOnly := Value;
  c := Color;
  fc := Font.Color;
  FInputStyle.CMSetReadOnly(c, fc);
  Color := c;
  Font.Color := fc;
  TabStop := not ReadOnly;
end;

procedure Ts0CustomMemo.SetTitle(const Value: string);
begin
  FInputStyle.Title := Value;
end;

procedure Ts0CustomMemo.SetTitleDisplay(const Value: TCustomLabel);
begin
  FInputStyle.TitleDisplay := Value;
end;

{ Ts0MemoDistiller }

class function Ts0MemoDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomMemo(AControl).Accessor;
end;

class function Ts0MemoDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0CustomMemo(AControl).Color;
end;

class function Ts0MemoDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := Ts0CustomMemo(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomMemo(AControl).OnExit;
end;

class function Ts0MemoDistiller.GetInputControl(
  AControl: TObject): Ts0InputStyle;
begin
  Result := Ts0CustomMemo(AControl).FInputStyle;
end;

class function Ts0MemoDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := Ts0CustomMemo(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomMemo(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomMemo(AControl).OnKeyUp   ;
  Result.FOnChange   := Ts0CustomMemo(AControl).OnChange  ;
end;

class function Ts0MemoDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := Ts0CustomMemo(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0CustomMemo(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0CustomMemo(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomMemo(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomMemo(AControl).OnMouseUp  ;
end;

class function Ts0MemoDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
  Result.FOnCanResize := Ts0CustomMemo(AControl).OnCanResize;
  Result.FOnResize    := Ts0CustomMemo(AControl).OnResize   ;
end;

class function Ts0MemoDistiller.GetTitle(AControl: TObject): string;
begin
  Result := Ts0CustomMemo(AControl).Title;
end;

class function Ts0MemoDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnChange];
end;

class function Ts0MemoDistiller.GetValue(AControl: TObject): string;
begin
  Result := Ts0CustomMemo(AControl).Text;
end;

class function Ts0MemoDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is Ts0CustomMemo);
end;

class procedure Ts0MemoDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomMemo(AControl).Color := AColor;
end;

class procedure Ts0MemoDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomMemo(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomMemo(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0MemoDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomMemo(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomMemo(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomMemo(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  Ts0CustomMemo(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0MemoDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomMemo(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomMemo(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomMemo(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomMemo(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomMemo(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0MemoDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomMemo(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomMemo(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0MemoDistiller.SetTitle(Value: string; AControl: TObject);
begin
  Ts0CustomMemo(AControl).Title := Value;
end;

class procedure Ts0MemoDistiller.SetValue(Value: string; AControl: TObject);
begin
  Ts0CustomMemo(AControl).Text := Value;
end;

{ Ts0Memo }

function Ts0Memo.GetInputStyle: Ts0MemoInputStyle;
begin
  Result := Ts0MemoInputStyle(inherited InputStyle);
end;

function Ts0Memo.NewInputStyle: Ts0CustomMemoInputStyle;
begin
  Result := Ts0MemoInputStyle.Create(Self);
end;

procedure Ts0Memo.SetInputStyle(const Value: Ts0MemoInputStyle);
begin
  inherited InputStyle := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0MemoDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0MemoDistiller);

end.
