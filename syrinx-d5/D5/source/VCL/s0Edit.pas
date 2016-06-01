unit s0Edit;
{
$History: s0Edit.pas $
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 02/03/20   Time: 23:31
 * Updated in $/D5/source/VCL
 * フォーカスを得たときにKeepFixedSelLengthを行うようにした。
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/03/13   Time: 10:56
 * Updated in $/D5/source/VCL
 * HandleAllocatedで分岐して実行されない個所があったので、修正
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCaseを使用して文字列の比較を行っていた部分をSameTextを使用するよう
 * に修正
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/08   Time: 2:33
 * Updated in $/source/D6VCLIntegrated
 * InputStyle関係を見直し。ちゃんと後でカスタマイズできるように考慮してみ
 * ました。
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/02/05   Time: 4:34
 * Updated in $/source/D5Integrated
 * TabOrderControllerの処理をKeyUp時にも呼び出すようにした。
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/12/19   Time: 18:29
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/12/15   Time: 2:04
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/12/13   Time: 12:23
 * Updated in $/source/D5Integrated
 * ChangeメソッドでTextを編集しても再帰しないようにした。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/11/26   Time: 18:45
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/11/23   Time: 1:55
 * Updated in $/source/D5Integrated
 * Changeイベントで行っていた処理をCheckOnChangeに分けた。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/11/23   Time: 0:18
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/11/22   Time: 18:47
 * Updated in $/source/D5Integrated
 * T0EditControllerにSetTextメソッドを追加
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
 * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
 * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/20   Time: 0:09
 * Updated in $/source/D5Integrated
 * Ts0EditAccessorがBoolean、DateTime、Floatに対応していなかったので対応し
 * た。
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
 * User: Akima        Date: 01/08/16   Time: 18:04
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
 * User: Akima        Date: 01/08/08   Time: 15:34
 * Updated in $/source/p0control
 * プロパティの可視性を変更。
 * Accessorの実装を行った。
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
  s0VCLClasses,
  s0InputStyle,
  s0DataAccessor,
  s0CtrlDistiller,
  s0StringValidater;

type
  K0SelPolicyOption = (k0spoIgnoreDeleteText, k0spoAllowMoveOfUpDown,
    k0spoKeepFixedLength, k0spoCustomMoveCursur);
  K0SelPolicyOptionSet = set of K0SelPolicyOption;

type
  Ts0EditSelectionPolicy = class(Ts0VCLPersistent)
  private
    FFixedSelLength: Integer;
    FOptions: K0SelPolicyOptionSet;
    FOwnerEdit: TCustomEdit;
    FEnabled: Boolean;
    procedure SetOptions(const Value: K0SelPolicyOptionSet);
    procedure SetEnabled(const Value: Boolean);
  protected
    function CanSelect(var ANewPos: Integer): Boolean; virtual;
    procedure KeepFixedSelLength;
    function MoveCursorByKey(var Key: Word; Shift: TShiftState): Boolean; virtual;
  protected
    { OwnerEdit calls these "Owner･･･" methods. }
    function OwnerCheckOnChange: Boolean; virtual;
    function OwnerDoEnter: Boolean; virtual;
    function OwnerKeyDown(var Key: Word; Shift: TShiftState): Boolean; virtual;
    function OwnerKeyPress(var Key: Char): Boolean; virtual;
    function OwnerMouseUp(Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer): Boolean; virtual;
    function OwnerSetSelLength(Value: Integer): Boolean; virtual;
    function OwnerSetSelStart(Value: Integer): Boolean; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    property OwnerEdit: TCustomEdit read FOwnerEdit;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property FixedSelLength: Integer read FFixedSelLength write FFixedSelLength default 1;
    property Options: K0SelPolicyOptionSet read FOptions write SetOptions default [k0spoIgnoreDeleteText, k0spoAllowMoveOfUpDown, k0spoKeepFixedLength];
  end;

type
  Ts0CustomEdit = class;

  Ts0EditAccessor = class(Ts0DataAccessor)
  private
    function GetOwnerEdit: Ts0CustomEdit;
  protected
    function GetAsBoolean: Boolean; override;
    function GetAsDateTime: TDateTime; override;
    function GetAsFloat: Double; override;
    function GetAsInteger: Integer; override;
    function GetAsString: String; override;
    procedure SetAsBoolean(const Value: Boolean); override;
    procedure SetAsDateTime(const Value: TDateTime); override;
    procedure SetAsFloat(const Value: Double); override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: String); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  Ts0CustomEditInputStyle = class(Ts0InputStyle)
  protected
    function GetOwnerEdit: Ts0CustomEdit;
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

  Ts0CustomEdit = class(TEdit)
  private
    FNumericOnly: Boolean;
    FAlignment: TAlignment;
    FFillZero: Boolean;
    FCheckMin: Boolean;
    FCheckMax: Boolean;
    FMinValue: Integer;
    FMaxValue: Integer;
    FInputStyle: Ts0CustomEditInputStyle;
    FAccessor: Ts0EditAccessor;
    FChanging: Boolean;
    FSelectPolicy: Ts0EditSelectionPolicy;
    procedure SetTitleDisplay(const Value: TCustomLabel);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure SetAutoWidth(const Value: Boolean);
    procedure CMLimitText(var Message: TMessage); message CB_LIMITTEXT;
    procedure EMSetMaxLength(var msg: TMessage); message EM_LIMITTEXT;
    function GetAcceptCharType: k1InpCharSet;
    function GetAutoTab: Boolean;
    function GetAutoWidth: Boolean;
    function GetExclusiveAcceptChar: string;
    function GetTitleDisplay: TCustomLabel;
    procedure SetAutoTab(const Value: Boolean);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetNumericOnly(const Value: Boolean);
    procedure SetCheckMax(const Value: Boolean);
    procedure SetCheckMin(const Value: Boolean);
    procedure SetFillZero(const Value: Boolean);
    procedure SetMaxValue(const Value: Integer);
    procedure SetMinValue(const Value: Integer);
    procedure SetAccessor(const Value: Ts0EditAccessor);
    procedure SetInputStyle(const Value: Ts0CustomEditInputStyle);
    procedure SetSelectPolicy(const Value: Ts0EditSelectionPolicy);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
  protected
    procedure CreateParams(var params: TCreateParams); override;
    procedure Change; override;
    procedure DoEnter; override;
    procedure DoSetMaxLength(Value: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure SetAcceptCharType(const Value: k1InpCharSet); virtual;
    procedure SetExclusiveAcceptChar(const Value: string); virtual;
    procedure CheckOnChange; virtual;
    procedure ModifyValueOnChange(Value: Integer); virtual;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer); override;
    procedure SetSelLength(Value: Integer); override;
    procedure SetSelStart(Value: Integer); override;
  protected
    function GetAsInteger: Integer; virtual;
    function NeedFillUpText: Boolean; virtual;
    function NewAccessor: Ts0EditAccessor; virtual;
    function NewInputStyle: Ts0CustomEditInputStyle; virtual;
    function NewSelectPolicy: Ts0EditSelectionPolicy; virtual;
    procedure FillUpText; virtual;
    procedure SetAsInteger(const Value: Integer); virtual;
    function ValidateMax(Value: Integer): Boolean;
    function ValidateMin(Value: Integer): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NormalDelete;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
  public
    property Font;
    property MaxLength;
    property OnChange;
  published
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  protected
    property Accessor: Ts0EditAccessor read FAccessor write SetAccessor;
    property InputStyle: Ts0CustomEditInputStyle read FInputStyle write SetInputStyle;
    property SelectPolicy: Ts0EditSelectionPolicy read FSelectPolicy write SetSelectPolicy;
  protected
    property AcceptCharType: k1InpCharSet read GetAcceptCharType write
      SetAcceptCharType default [k1ctalpha..k1ctkana];
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property AutoTab: Boolean read GetAutoTab write SetAutoTab default True;
    property AutoWidth: Boolean read GetAutoWidth write SetAutoWidth default
      True;
    property ExclusiveAcceptChar: string read GetExclusiveAcceptChar write
      SetExclusiveAcceptChar;
    property NumericOnly: Boolean read FNumericOnly write SetNumericOnly;
    property Title: string read GetTitle write SetTitle;
    property TitleDisplay: TCustomLabel read GetTitleDisplay write SetTitleDisplay;
    property CheckMin: Boolean read FCheckMin write SetCheckMin default False;
    property CheckMax: Boolean read FCheckMax write SetCheckMax default False;
    property FillZero: Boolean read FFillZero write SetFillZero default False;
    property MaxValue: Integer read FMaxValue write SetMaxValue default 0;
    property MinValue: Integer read FMinValue write SetMinValue default 0;
  end;

type
  Ts0EditInputStyle = class(Ts0CustomEditInputStyle)
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
  Ts0Edit = class(Ts0CustomEdit)
  private
    function GetInputStyle: Ts0EditInputStyle;
    procedure SetInputStyle(const Value: Ts0EditInputStyle);
  protected
    function NewInputStyle: Ts0CustomEditInputStyle; override;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
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
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ShowHint;
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
    property Alignment;
    property AutoTab;
    property AutoWidth;
    property ExclusiveAcceptChar;
    property NumericOnly;
    property ReadOnly;
    property Title;
    property TitleDisplay;
    property CheckMin;
    property CheckMax;
    property FillZero;
    property MaxValue;
    property MinValue;
  published
    property Accessor;
    property InputStyle: Ts0EditInputStyle read GetInputStyle write SetInputStyle;
    property SelectPolicy;
  end;

type
  Ts0EditDistiller = class(Ts0CtrlDistiller)
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
  s0TypeConvertor,
  s0TabOrderController,
  s0StringHelper;

{ Ts0EditAccessor }

constructor Ts0EditAccessor.Create(AOwner: TComponent);
begin
  inherited;
end;

function Ts0EditAccessor.GetAsBoolean: Boolean;
begin
  Result := SameText(Trim(AsString), 'TRUE');
end;

function Ts0EditAccessor.GetAsDateTime: TDateTime;
begin
  Result := StrToDateTime(AsString);
end;

function Ts0EditAccessor.GetAsFloat: Double;
begin
  Result := StrToFloat(AsString);
end;

function Ts0EditAccessor.GetAsInteger: Integer;
begin
  Result := GetOwnerEdit.AsInteger;
end;

function Ts0EditAccessor.GetAsString: String;
begin
  Result := GetOwnerEdit.Text;
end;

function Ts0EditAccessor.GetOwnerEdit: Ts0CustomEdit;
begin
  Result := Ts0CustomEdit(Owner);
end;

procedure Ts0EditAccessor.SetAsBoolean(const Value: Boolean);
begin
  if Value then
    AsString := 'True'
  else
    AsString := 'False'
end;

procedure Ts0EditAccessor.SetAsDateTime(const Value: TDateTime);
begin
  AsString := DateTimeToStr(Value);
end;

procedure Ts0EditAccessor.SetAsFloat(const Value: Double);
begin
  AsString := FloatToStr(Value);
end;

procedure Ts0EditAccessor.SetAsInteger(const Value: Integer);
begin
  GetOwnerEdit.AsInteger := Value;
end;

procedure Ts0EditAccessor.SetAsString(const Value: String);
begin
  GetOwnerEdit.Text := Value;
end;

{ Ts0CustomEditInputStyle }

function Ts0CustomEditInputStyle.GetAlignment: TAlignment;
begin
  Result := GetOwnerEdit.Alignment;
end;

function Ts0CustomEditInputStyle.GetCharCase: TEditCharCase;
begin
  Result := GetOwnerEdit.CharCase;
end;

function Ts0CustomEditInputStyle.GetFont: TFont;
begin
  Result := GetOwnerEdit.Font;
end;

function Ts0CustomEditInputStyle.GetImeMode: TImeMode;
begin
  Result := GetOwnerEdit.ImeMode;
end;

function Ts0CustomEditInputStyle.GetImeName: TImeName;
begin
  Result := GetOwnerEdit.ImeName;
end;

function Ts0CustomEditInputStyle.GetMaxLength: Integer;
begin
  Result := GetOwnerEdit.MaxLength;
end;

function Ts0CustomEditInputStyle.GetModified: Boolean;
begin
  Result := GetOwnerEdit.Modified;
end;

function Ts0CustomEditInputStyle.GetOwnerEdit: Ts0CustomEdit;
begin
  Result := Ts0CustomEdit(Control);
end;

function Ts0CustomEditInputStyle.GetReadOnly: Boolean;
begin
  Result := GetOwnerEdit.ReadOnly;
end;

function Ts0CustomEditInputStyle.GetText: string;
begin
  Result := GetOwnerEdit.Text;
end;

procedure Ts0CustomEditInputStyle.SetAlignment(const Value: TAlignment);
begin
  GetOwnerEdit.Alignment := Value;
end;

procedure Ts0CustomEditInputStyle.SetCharCase(const Value: TEditCharCase);
begin
  GetOwnerEdit.CharCase := Value;
end;

procedure Ts0CustomEditInputStyle.SetFont(const Value: TFont);
begin
  GetOwnerEdit.Font := Value;
end;

procedure Ts0CustomEditInputStyle.SetImeMode(const Value: TImeMode);
begin
  GetOwnerEdit.ImeMode := Value;
end;

procedure Ts0CustomEditInputStyle.SetImeName(const Value: TImeName);
begin
  GetOwnerEdit.ImeName := Value;
end;

procedure Ts0CustomEditInputStyle.SetMaxLength(const Value: Integer);
begin
  GetOwnerEdit.MaxLength := Value;
end;

procedure Ts0CustomEditInputStyle.SetModified(const Value: Boolean);
begin
  GetOwnerEdit.Modified := Value;
end;

procedure Ts0CustomEditInputStyle.SetText(const Value: string);
begin
  GetOwnerEdit.Text := Value;
end;

{ Ts0EditSelectionPolicy }

function Ts0EditSelectionPolicy.CanSelect(var ANewPos: Integer): Boolean;
begin
  Result := False;
  if ANewPos < 0 then Exit;
  if ANewPos > Length(FOwnerEdit.Text) - FFixedSelLength then Exit;
  Result := True;
end;

constructor Ts0EditSelectionPolicy.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  if AOwner is Ts0CustomEdit then
    FOwnerEdit := Ts0CustomEdit(AOwner);
  FEnabled :=False;
  FFixedSelLength := 1;
  FOptions := [k0spoIgnoreDeleteText, k0spoAllowMoveOfUpDown, k0spoKeepFixedLength];
end;

procedure Ts0EditSelectionPolicy.KeepFixedSelLength;
var
  lenText: Integer;
  newPos: Integer;
begin
  if not(k0spoKeepFixedLength in FOptions) then Exit;
  if not FOwnerEdit.HandleAllocated then Exit;
  newPos := FOwnerEdit.SelStart;
  if CanSelect(newPos) then
    FOwnerEdit.SelStart := newPos
  else
    FOwnerEdit.SelStart := newPos -1;
  //
  lenText := Length(FOwnerEdit.Text);
  if FOwnerEdit.SelStart > lenText - FFixedSelLength then
    if lenText < FFixedSelLength then
      FOwnerEdit.SelStart := 0
    else
      FOwnerEdit.SelStart := lenText - FFixedSelLength;
  if FOwnerEdit.SelLength <> FFixedSelLength then
    FOwnerEdit.SelLength := FFixedSelLength;
end;

function Ts0EditSelectionPolicy.MoveCursorByKey(var Key: Word;
  Shift: TShiftState): Boolean;
  procedure MoveTo(newPos: Integer);
  begin
    if CanSelect(newPos) then
      FOwnerEdit.SelStart := newPos;
    Key := 0;
    KeepFixedSelLength;
  end;
var
  selS: Integer;
begin
  Result := False;
  if k0spoCustomMoveCursur in Options then Exit;
  Result := True;
  selS := FOwnerEdit.SelStart;
  case Key of
    VK_END  : ;
    VK_HOME : ;
    VK_LEFT : MoveTo(selS -1);
    VK_UP   : if k0spoAllowMoveOfUpDown in Options then MoveTo(selS -1);
    VK_RIGHT: MoveTo(selS +1);
    VK_DOWN : if k0spoAllowMoveOfUpDown in Options then MoveTo(selS +1);
  else
    Result := False;
  end;
end;

function Ts0EditSelectionPolicy.OwnerCheckOnChange: Boolean;
begin
  Result := not Enabled;
  if Result then Exit;
  KeepFixedSelLength;
  Result := True;
end;

function Ts0EditSelectionPolicy.OwnerDoEnter: Boolean;
begin
  Result := not FEnabled;
  if Result then Exit;
  KeepFixedSelLength;
  Result := True;
end;

function Ts0EditSelectionPolicy.OwnerKeyDown(var Key: Word;
  Shift: TShiftState): Boolean;
  function IgnoreKey: Boolean;
  begin
    Result := False;
    if not(k0spoIgnoreDeleteText in Options) then Exit;
    case Key of
      VK_BACK,
      VK_TAB,
      VK_CLEAR,
      VK_DELETE: Result := True;
    end;
  end;
begin
  Result := not FEnabled;
  if Result then Exit;
  Result := False;
  if IgnoreKey then
  begin
    Key := 0;
    Exit;
  end
  else
  if MoveCursorByKey(Key, Shift) then
  begin
    Key := 0;
    Exit;
  end;
  Result := True;
end;

function Ts0EditSelectionPolicy.OwnerKeyPress(var Key: Char): Boolean;
begin
  Result := not FEnabled;
  if Result then Exit;
  Result := False;
  if (k0spoIgnoreDeleteText in Options) and (Key = Char(VK_BACK)) then
  begin
    Key := #0;
    Exit;
  end;
  Result := True;
end;

function Ts0EditSelectionPolicy.OwnerMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := not FEnabled;
  if Result then Exit;
  KeepFixedSelLength;
  Result := True;
end;

function Ts0EditSelectionPolicy.OwnerSetSelLength(Value: Integer): Boolean;
begin
  Result := not FEnabled;
  if Result then Exit;
  Result := not (k0spoKeepFixedLength in FOptions);
  if Result then Exit;
  //Valueを無視
  SendMessage(FOwnerEdit.Handle, EM_SETSEL, FOwnerEdit.SelStart, FOwnerEdit.SelStart + FFixedSelLength);
  SendMessage(FOwnerEdit.Handle, EM_SCROLLCARET, 0,0);
end;

function Ts0EditSelectionPolicy.OwnerSetSelStart(Value: Integer): Boolean;
begin
  Result := not FEnabled;
  if Result then Exit;
  Result := not (k0spoKeepFixedLength in FOptions);
  if Result then Exit;
  //必ず長さをFConstSelLengthに。
  if Value > Length(FOwnerEdit.Text) -1 then Exit;
  if not CanSelect(Value) then Exit;
  SendMessage(FOwnerEdit.Handle, EM_SETSEL, Value, Value + FFixedSelLength);
end;

procedure Ts0EditSelectionPolicy.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  if FEnabled then
    OwnerCheckOnChange;
end;

procedure Ts0EditSelectionPolicy.SetOptions(const Value: K0SelPolicyOptionSet);
begin
  FOptions := Value;
end;

{ Ts0CustomEdit }

procedure Ts0CustomEdit.Change;
begin
  if FChanging then
    Exit;
  FChanging := True;
  try
    inherited Change;
    CheckOnChange;
    if FillZero and NeedFillUpText then
      FillUpText;
    if HandleAllocated then
      FInputStyle.ChangeText;
  finally
    FChanging := False;
  end;
end;

procedure Ts0CustomEdit.ModifyValueOnChange(Value: Integer);
var
  p: Integer;
begin
  {
    設計時にVisibleをFalseに設定されたままだとHandleAllocatedは
    Trueにならない。でも値は変更しなきゃなんないので、HandleAllocatedによって
    SelStartを元に戻すかどうかを判断する。
  }
  if HandleAllocated then
  begin
    p := SelStart;
    try
      AsInteger := Value;
    finally
      SelStart := p;
    end;
  end
  else
    AsInteger := Value;
end;

procedure Ts0CustomEdit.CheckOnChange;
begin
  //if HandleAllocated then
  if CheckMax and (not ValidateMax(AsInteger)) then
  	ModifyValueOnChange(FMaxValue);
  if CheckMin and (not ValidateMin(AsInteger)) then
  	ModifyValueOnChange(FMinValue);
  if FNumericOnly then
  begin
    if Text = '' then
      Self.AsInteger := 0;
    if not Ts0StringHelper.IsConstructedByAType(inherited Text, k0ctDigit) then
      inherited Text := '0';
  end;
  if not FSelectPolicy.Enabled then Exit;
  FSelectPolicy.OwnerCheckOnChange;
end;

procedure Ts0CustomEdit.CMLimitText(var Message: TMessage);
begin
  inherited;
  SetAutoWidth(AutoWidth);
end;

constructor Ts0CustomEdit.Create(AOwner: TComponent);
begin
  FAccessor := NewAccessor;
  FSelectPolicy := NewSelectPolicy;
  inherited;
  FInputStyle := NewInputStyle;
  FFillZero := False;
  FCheckMin := False;
  FCheckMax := False;
  FMaxValue := 0;
  FMinValue := 0;
  //
  //ReadOnly := False;
end;

procedure Ts0CustomEdit.CreateParams(var params: TCreateParams);
const
  c9Alignments: array[TAlignment] of Word = (ES_LEFT, ES_RIGHT, ES_CENTER);
  c9NumOnly: array[Boolean] of Word = (0, ES_NUMBER);
begin
  inherited;
  Params.Style := Params.Style or c9Alignments[FAlignment] or
    c9NumOnly[FNumericOnly];
end;

destructor Ts0CustomEdit.Destroy;
begin
  FreeAndNil(FSelectPolicy);
  FreeAndNil(FAccessor);
  FreeAndNil(FInputStyle);
  inherited;
end;

procedure Ts0CustomEdit.DoEnter;
begin
  if not FSelectPolicy.OwnerDoEnter then Exit;
  inherited DoEnter;
end;

procedure Ts0CustomEdit.DoSetMaxLength(Value: Integer);
begin
  inherited;
  SetAutoWidth(AutoWidth);
end;

procedure Ts0CustomEdit.EMSetMaxLength(var msg: TMessage);
begin
  inherited;
  CheckOnChange;
end;

procedure Ts0CustomEdit.FillUpText;
var
  i: Integer;
  s: string;
  orgPos: Integer;
begin
  s := Text;
  if Length(Text) < MaxLength then
  begin
    if HandleAllocated then
		  orgPos := Self.SelStart
    else
      orgPos := 0;
    for i := Length(Text) + 1 to MaxLength do
    begin
      s := '0' + Text;
      orgPos := orgPos + 1;
    end;
    Text := s;
    if HandleAllocated then
    begin
      Self.SelStart := orgPos;
      if (FSelectPolicy <> nil) then
        FSelectPolicy.KeepFixedSelLength;
    end;
  end
  else
  begin
    Text := Copy(s, Length(Text) - MaxLength + 1, MaxLength);
  end;
end;

function Ts0CustomEdit.GetAcceptCharType: k1InpCharSet;
begin
  Result := FInputStyle.AcceptCharType;
end;

function Ts0CustomEdit.GetAsInteger: Integer;
begin
  Result := StrToIntDef(inherited Text, 0);
end;

function Ts0CustomEdit.GetAutoTab: Boolean;
begin
  Result := FInputStyle.AutoTab;
end;

function Ts0CustomEdit.GetAutoWidth: Boolean;
begin
  Result := FInputStyle.AutoWidth;
end;

function Ts0CustomEdit.GetExclusiveAcceptChar: string;
begin
  Result := FInputStyle.ExclusiveAcceptChar;
end;

function Ts0CustomEdit.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
end;

function Ts0CustomEdit.GetTitle: string;
begin
  Result := FInputStyle.Title;
end;

function Ts0CustomEdit.GetTitleDisplay: TCustomLabel;
begin
  Result := FInputStyle.TitleDisplay;
end;

procedure Ts0CustomEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not FSelectPolicy.OwnerKeyDown(Key, Shift) then Exit;
  inherited KeyDown(Key, Shift);
  Ts0TabOrderController.Instance.KeyDown(Self, Key, Shift);
end;

procedure Ts0CustomEdit.KeyPress(var Key: Char);
begin
  if not FSelectPolicy.OwnerKeyPress(Key) then Exit;
  if FInputStyle.KeyPress(Key) then
    inherited KeyPress(Key);
end;

procedure Ts0CustomEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Ts0TabOrderController.Instance.KeyUp(Self, Key, Shift);
end;

procedure Ts0CustomEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if not FSelectPolicy.OwnerMouseUp(Button, Shift, X, Y) then Exit;
  inherited MouseUp(Button, Shift, X, Y);
end;

function Ts0CustomEdit.NeedFillUpText: Boolean;
begin
  Result := False;
  if MaxLength < 1 then
    Exit;
  if Length(Text) = MaxLength then
    Exit;
  Result := True;
end;

function Ts0CustomEdit.NewAccessor: Ts0EditAccessor;
begin
  Result := Ts0EditAccessor.Create(Self);
end;

function Ts0CustomEdit.NewInputStyle: Ts0CustomEditInputStyle;
begin
  Result := Ts0CustomEditInputStyle.Create(Self);
end;

function Ts0CustomEdit.NewSelectPolicy: Ts0EditSelectionPolicy;
begin
  Result := Ts0EditSelectionPolicy.Create(Self);
end;

procedure Ts0CustomEdit.NormalDelete;
begin
  SelLength := 1;
  SelText := '';
end;

procedure Ts0CustomEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if InputStyle <> nil then
    InputStyle.Notification(AComponent, Operation);
end;

procedure Ts0CustomEdit.SetAcceptCharType(const Value: k1InpCharSet);
begin
  FInputStyle.AcceptCharType := Value;
end;

procedure Ts0CustomEdit.SetAccessor(const Value: Ts0EditAccessor);
begin
  FAccessor.Assign( Value );
end;

procedure Ts0CustomEdit.SetAlignment(const Value: TAlignment);
begin
  if FAlignment = Value then
    Exit;
  FAlignment := Value;
  RecreateWnd;
end;

procedure Ts0CustomEdit.SetAsInteger(const Value: Integer);
begin
  inherited Text := IntToStr(Value);
end;

procedure Ts0CustomEdit.SetAutoTab(const Value: Boolean);
begin
  FInputStyle.AutoTab := Value;
end;

procedure Ts0CustomEdit.SetAutoWidth(const Value: Boolean);
begin
  FInputStyle.AutoWidth := Value;
end;

procedure Ts0CustomEdit.SetCheckMax(const Value: Boolean);
begin
  FCheckMax := Value;
  CheckOnChange;
end;

procedure Ts0CustomEdit.SetCheckMin(const Value: Boolean);
begin
  FCheckMin := Value;
  CheckOnChange;
end;

procedure Ts0CustomEdit.SetExclusiveAcceptChar(const Value: string);
begin
  FInputStyle.ExclusiveAcceptChar := Value;
end;

procedure Ts0CustomEdit.SetFillZero(const Value: Boolean);
begin
  FFillZero := Value;
  CheckOnChange;
end;

procedure Ts0CustomEdit.SetInputStyle(const Value: Ts0CustomEditInputStyle);
begin
  FInputStyle.Assign(Value);
end;

procedure Ts0CustomEdit.SetMaxValue(const Value: Integer);
begin
  FMaxValue := Value;
  CheckOnChange;
end;

procedure Ts0CustomEdit.SetMinValue(const Value: Integer);
begin
  FMinValue := Value;
  CheckOnChange;
end;

procedure Ts0CustomEdit.SetNumericOnly(const Value: Boolean);
begin
  if FNumericOnly = Value then
    Exit;
  FNumericOnly := Value;
  RecreateWnd;
  CheckOnChange;
end;

procedure Ts0CustomEdit.SetReadOnly(const Value: Boolean);
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

procedure Ts0CustomEdit.SetSelectPolicy(
  const Value: Ts0EditSelectionPolicy);
begin
  FSelectPolicy.Assign(Value);
end;

procedure Ts0CustomEdit.SetSelLength(Value: Integer);
begin
  if not FSelectPolicy.OwnerSetSelLength(Value) then Exit;
  inherited SetSelLength(Value);
end;

procedure Ts0CustomEdit.SetSelStart(Value: Integer);
begin
  if not FSelectPolicy.OwnerSetSelStart(Value) then Exit;
  inherited SetSelStart(Value);
end;

procedure Ts0CustomEdit.SetTitle(const Value: string);
begin
  FInputStyle.Title := Value;
end;

procedure Ts0CustomEdit.SetTitleDisplay(const Value: TCustomLabel);
begin
  FInputStyle.TitleDisplay := Value;
end;

function Ts0CustomEdit.ValidateMax(Value: Integer): Boolean;
begin
  Result := (Value <= FMaxValue);
end;

function Ts0CustomEdit.ValidateMin(Value: Integer): Boolean;
begin
  Result := (Value >= FMinValue);
end;

{ Ts0Edit }

function Ts0Edit.GetInputStyle: Ts0EditInputStyle;
begin
  Result := Ts0EditInputStyle(inherited InputStyle);
end;

function Ts0Edit.NewInputStyle: Ts0CustomEditInputStyle;
begin
  Result := Ts0EditInputStyle.Create(Self);
end;

procedure Ts0Edit.SetInputStyle(const Value: Ts0EditInputStyle);
begin
  inherited InputStyle := Value;
end;

{ Ts0EditDistiller }

class procedure Ts0EditDistiller.Click(AControl: TObject);
begin
  Ts0CustomEdit(AControl).Click;
end;

class function Ts0EditDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomEdit(AControl).Accessor;
end;

class function Ts0EditDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0CustomEdit(AControl).Color;
end;

class function Ts0EditDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result := inherited GetFocusEvents(AControl);
  Result.FOnEnter := Ts0CustomEdit(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomEdit(AControl).OnExit;
end;

class function Ts0EditDistiller.GetInputControl(
  AControl: TObject): Ts0InputStyle;
begin
  Result := Ts0CustomEdit(AControl).FInputStyle;
end;

class function Ts0EditDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result := inherited GetKeyEvents(AControl);
  Result.FOnKeyDown  := Ts0CustomEdit(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomEdit(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomEdit(AControl).OnKeyUp   ;
  Result.FOnChange   := Ts0CustomEdit(AControl).OnChange  ;
end;

class function Ts0EditDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result := inherited GetMouseEvents(AControl);
  Result.FOnClick     := Ts0CustomEdit(AControl).OnClick;
  Result.FOnDblClick  := Ts0CustomEdit(AControl).OnDblClick;
  Result.FOnMouseDown := Ts0CustomEdit(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomEdit(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomEdit(AControl).OnMouseUp;
end;

class function Ts0EditDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result := inherited GetSizeEvents(AControl);
//  Result.FOnCanResize := Ts0CustomEdit(AControl).OnCanChange;
//  Result.FOnResize    := Ts0CustomEdit(AControl).OnChange;
end;

class function Ts0EditDistiller.GetTitle(AControl: TObject): string;
begin
  Result := inherited GetTitle(AControl);
end;

class function Ts0EditDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnChange];
end;

class function Ts0EditDistiller.GetValue(AControl: TObject): string;
begin
  Result := Ts0CustomEdit(AControl).Text;
end;

class function Ts0EditDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is Ts0CustomEdit);
end;

class procedure Ts0EditDistiller.KeyDown(AControl: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Ts0CustomEdit(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0EditDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomEdit(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0EditDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomEdit(AControl).Color := AColor;
end;

class procedure Ts0EditDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomEdit(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomEdit(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0EditDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomEdit(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomEdit(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomEdit(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  Ts0CustomEdit(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0EditDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomEdit(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomEdit(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomEdit(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomEdit(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomEdit(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0EditDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
end;

class procedure Ts0EditDistiller.SetTitle(Value: string; AControl: TObject);
begin
end;

class procedure Ts0EditDistiller.SetValue(Value: string; AControl: TObject);
begin
  Ts0CustomEdit(AControl).Text := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0EditDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0EditDistiller);

end.
