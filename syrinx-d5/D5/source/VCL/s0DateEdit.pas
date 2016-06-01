unit s0DateEdit;
{
$History: s0DateEdit.pas $
 *
 * *****************  Version 40  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/VCL
 *
 * *****************  Version 39  *****************
 * User: Akima        Date: 02/03/13   Time: 10:58
 * Updated in $/D5/source/VCL
 * 年に相当するエディットで、桁に関係なく年号を表す記号を受け付けるように
 * 修正。
 * デフォルトの高さをTEditにあわせた。
 *
 * *****************  Version 38  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 *
 * *****************  Version 37  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 *
 * *****************  Version 36  *****************
 * User: Akima        Date: 02/02/15   Time: 14:21
 * Updated in $/source/D5Integrated
 * Tc9DateEditItemのIgnoreZeroOfHeadをFalseにした
 *
 * *****************  Version 35  *****************
 * User: Akima        Date: 02/02/14   Time: 23:44
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 34  *****************
 * User: Akima        Date: 02/02/13   Time: 13:59
 * Updated in $/source/D5Integrated
 * FEditsのAutoWidthをFalseに
 *
 * *****************  Version 33  *****************
 * User: Akima        Date: 02/02/08   Time: 2:33
 * Updated in $/source/D6VCLIntegrated
 * InputStyle関係を見直し。ちゃんと後でカスタマイズできるように考慮してみ
* ました。
*
* * * * * * * * * * * * * * * * * * Version 32 * * * * * * * * * * * * * * * * *
* User: Akima Date: 02 / 02 / 07 Time: 23: 36
* Updated in $ / source / D6VCLIntegrated
* Ts0DateiEditItemEditにParentFontを追加。
* AutoSizeプロパティは、VER140の機能がぶつかっているので、使用しないよう
* にして、代わりにAutoAdjustSizeプロパティを追加。
* ReCalcEditsHeightsメソッドで、各エディットのフォントを考慮に入れるよう
* に変更。
*
* * * * * * * * * * * * * * * * * * Version 31 * * * * * * * * * * * * * * * * *
* User: Akima Date: 02 / 02 / 07 Time: 22: 29
* Updated in $ / source / D6VCLIntegrated
*
* * * * * * * * * * * * * * * * * * Version 30 * * * * * * * * * * * * * * * * *
* User: Akima Date: 02 / 02 / 06 Time: 17: 58
* Updated in $ / source / D5Integrated
* AutoTabプロパティを追加。AutoTabがTrueの場合に、次のコントロールへフォ
  * ーカスを移す処理をKeyPressではなく、KeyDownで行うようにした。
  *
  * * * * * * * * * * * * * * * * * * Version 29 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 02 / 01 / 30 Time: 17: 31
* Updated in $ / source / D5Integrated
  * Fontのプロパティなどを変更したときに、AutoSize = Trueならば、ちゃんとそれ
  * にあわせるように修正。
  *
  * * * * * * * * * * * * * * * * * * Version 28 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 02 / 01 / 15 Time: 18: 36
* Updated in $ / source / D6VCLIntegrated
  *
  * * * * * * * * * * * * * * * * * * Version 26 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 18 Time: 16: 11
* Updated in $ / source / D5Integrated
  * OnChangeイベントを派生元で宣言しているものを使用するように変更。
  * その他のイベントも追加。
  *
  * * * * * * * * * * * * * * * * * * Version 25 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 18 Time: 11: 50
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 24 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 15 Time: 2: 04
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 23 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 13 Time: 16: 40
* Updated in $ / source / D5Integrated
  * Visibleがうまく保存されてなかったのでnodefaultにした。
  * ちょっとリファクタリング
  *
  * * * * * * * * * * * * * * * * * * Version 22 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 13 Time: 12: 23
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 21 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 12 Time: 20: 55
* Updated in $ / source / D5Integrated
  * InputController - > InputStyle
  *
  * * * * * * * * * * * * * * * * * * Version 20 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 11 Time: 17: 31
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 19 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 10 Time: 16: 13
* Updated in $ / source / D5Integrated
  * インスタンス生成時にRefreshItemEditsをやると問題が生じたので修正
  *
  * * * * * * * * * * * * * * * * * * Version 18 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 07 Time: 14: 50
* Updated in $ / source / D5Integrated
  * DistillerにClickメソッドを追加
  *
  * * * * * * * * * * * * * * * * * * Version 17 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 05 Time: 18: 49
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 16 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 11 / 28 Time: 18: 18
* Updated in $ / source / D5Integrated
  * Distillerのメソッドをprotectedからpublicに変更
  *
  * * * * * * * * * * * * * * * * * * Version 15 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 11 / 26 Time: 18: 45
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 12 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 11 / 22 Time: 18: 47
* Updated in $ / source / D5Integrated
  * T0ComboBoxControllerにSetTextメソッドを追加
  *
  * * * * * * * * * * * * * * * * * * Version 11 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 10 / 12 Time: 0: 54
* Updated in $ / source / D5Integrated
  * 時刻も表せるように大変更
  *
  * * * * * * * * * * * * * * * * * * Version 10 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 09 / 30 Time: 1: 49
* Updated in $ / source / D5Integrated
  * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
  * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
  * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
  *
  * * * * * * * * * * * * * * * * * * Version 9 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 09 / 20 Time: 0: 09
* Updated in $ / source / D5Integrated
  * OｎChange、Modifiedを追加。
  * デフォルトのサイズを設定しておくように修正。
  * Distiller、InputControl、Accessorの不備を修正
  *
  * * * * * * * * * * * * * * * * * * Version 8 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 09 / 19 Time: 20: 49
* Updated in $ / source / D5Integrated
  * Accessor、Distiller、InputControlを追加
  *
  * * * * * * * * * * * * * * * * * * Version 7 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 30 Time: 17: 40
* Updated in $ / source / D5 / p0comctrl
  * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
  * VSSの履歴マクロの書かれていないファイルにマクロを追加、
  * 要らないファイルの削除を行った。
  *
  * * * * * * * * * * * * * * * * * * Version 6 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 08 Time: 15: 33
* Updated in $ / source / p0control
  * FEditsをTs0CustomDigitEditの配列に変更
  *
  * * * * * * * * * * * * * * * * * * Version 5 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 07 Time: 21: 35
* Updated in $ / source / p0control
  * c0StdCtrlsユニットを廃止したのでそれに対応
  *
  * * * * * * * * * * * * * * * * * * Version 4 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 01 Time: 13: 22
* Updated in $ / source / p0control
  * コメントを追加
  *
  * * * * * * * * * * * * * * * * * * Version 1 * * * * * * * * * * * * * * * *
  *
  * User: Takima Date: 01 / 06 / 28 Time: 18: 27
* Created in $ / Projects / SDRFrameWork / src / lib0
  * 新規追加
  * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
  * VSSでは共有してません。
  }

{
  Ts0CustomDateEdit
  日付を入力、表示するためのコンポーネントです。
  和暦、西暦の変換が可能です。

  public property AsDateTime: TDateTime
  入力されている日付をTDateTime型で取得できます。
  また、TDateTime型で表示する日付を指定することもできます。

  published  property EraType: K0EraKind
  西暦or和暦

  property JapaneseEra: K0JapaneseEra
  表示している日付の、和暦に換算した場合の年号

  property Year: Word index 1 read GetPart write SetPart;
  property Month: Word index 2 read GetPart write SetPart;
  property Day: Word index 3 read GetPart write SetPart;
  表示している日付の年月日。
  同じ日付でもEraTypeによってYearの値は変わります。


  property DispKinds: K0DateDisplayTypeSet
  年月日のうち表示する項目を選べる。
  年のみ、年と月のみ表示というような場合に指定する。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics,
  Forms,
  StdCtrls,
  s0Edit,
  s0CustomComplexCtrl,
  s0DigitEdit,
  s0DateHelper,
  s0CtrlDistiller,
  s0DataAccessor,
  s0InputStyle
  ;

type
  K0EraKind = (k0ekChristian, k0ekJapanese);

type
  K0DateEditItemType = (k0ddtYear, k0ddtMonth, k0ddtDay, k0tdtHour, k0tdtMinute,
    k0tdtSecond, k0tdtMiliSec);
  K0DateEditItemTypeSet = set of K0DateEditItemType;

type
  K0DateEditStyle = (k0desFlatAndBorder, k0desFlat, k0desBorder);

type
  Ts0DateiEditItemEdit = class(Ts0CCCItem)
  protected
    procedure SetAlign(const Value: TAlign); override;
  published
  	//使わなくなったので削除したいが、互換性のためとっておく。
    property Align stored False; 
  published
    property Anchors;
    property Color;
    property Enabled;
    property Font;
    property Left;
    property ParentFont;
    property ReadOnly;
    property TabOrder;
    property TabStop;
    property Visible nodefault;
    property Width;
  end;

type
  Ts0CustomDateEdit = class;

  Ts0DateEditAccessor = class(Ts0DataAccessor)
  private
    function GetOwnerEdit: Ts0CustomDateEdit;
    function GetPart(const Index: Integer): Word;
    procedure SetPart(const Index: Integer; const Value: Word);
  protected
    function GetAsDateTime: TDateTime; override;
    function GetAsFloat: Double; override;
    function GetAsInteger: Integer; override;
    function GetAsString: string; override;
    procedure SetAsDateTime(const Value: TDateTime); override;
    procedure SetAsFloat(const Value: Double); override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: string); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Year: Word index 1 read GetPart write SetPart;
    property Month: Word index 2 read GetPart write SetPart;
    property Day: Word index 3 read GetPart write SetPart;
    property Hour: Word index 4 read GetPart write SetPart;
    property Minute: Word index 5 read GetPart write SetPart;
    property Second: Word index 6 read GetPart write SetPart;
    property MiliSec: Word index 7 read GetPart write SetPart;
  end;

  Ts0CustomDateEditInputStyle = class(Ts0InputStyle)
  protected
    function GetOwnerEdit: Ts0CustomDateEdit;
    function GetAlignment: TAlignment; override;
    function GetCharCase: TEditCharCase; override;
    function GetFont: TFont; override;
    function GetImeMode: TImeMode; override;
    function GetImeName: TImeName; override;
    function GetMaxLength: Integer; override;
    function GetModified: Boolean; override;
    function GetReadOnly: Boolean; override;
    procedure SetModified(const Value: Boolean); override;
    procedure SetAlignment(const Value: TAlignment); override;
    procedure SetCharCase(const Value: TEditCharCase); override;
    procedure SetFont(const Value: TFont); override;
    procedure SetImeMode(const Value: TImeMode); override;
    procedure SetImeName(const Value: TImeName); override;
    procedure SetMaxLength(const Value: Integer); override;
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
  end;

  Ts0CustomDateEdit = class(Ts0CustomComplexCtrl)
  private
    FEraType: K0EraKind;
    FUpdating: Boolean;
    FEdits: array[K0DateEditItemType] of Ts0CustomDigitEdit;
    FEditParts: array[K0DateEditItemType] of Ts0DateiEditItemEdit;
    FAccessor: Ts0DateEditAccessor;
    FInputStyle: Ts0CustomDateEditInputStyle;
    FActivePartKind: K0DateEditItemType;
    FAutoTab: Boolean;
    FAutoAdjustSize: Boolean;
    FMarginTop: Integer;
    FMarginBottom: Integer;
    FAlignment: TAlignment;
    function GetJapaneseEra: K0JapaneseEra;
    function GetModified: Boolean;
    procedure SetAccessor(const Value: Ts0DateEditAccessor);
    procedure SetEraType(const Value: K0EraKind);
    procedure SetJapaneseEra(const Value: K0JapaneseEra);
    procedure SetModified(const Value: Boolean);
    function GetEditParts(const Index: Integer): Ts0DateiEditItemEdit;
    procedure SetEditParts(const Index: Integer; const Value:
      Ts0DateiEditItemEdit);
    procedure SetAutoTab(const Value: Boolean);
    procedure SetAutoAdjustSize(const Value: Boolean);
    procedure SetInputStyle(const Value: Ts0CustomDateEditInputStyle);
    procedure SetMarginBottom(const Value: Integer);
    procedure SetMarginTop(const Value: Integer);
    procedure SetAlignment(const Value: TAlignment);
  private
    function GetAsDateTime: TDateTime;
    function GetPart(const Index: Integer): Word;
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetPart(const Index: Integer; const Value: Word);
  protected
    procedure AdjustSize; override;
    procedure AdjustItemPositions; virtual;
    procedure RefreshItemEdits; 
    function CanDoCtrlEvent(AEventKind: K0CCCPartEventKind; Sender: TObject):
      Boolean; override;
    procedure ChangedOfFont; override;
    procedure CreateHandle; override;
    procedure CreateCtrls; override;
    function GetLastVisibleEdit: Ts0DateiEditItemEdit;
    function GetEditType(AEdit: Ts0CustomDigitEdit): K0DateEditItemType;
    function GetNextEdit(AEdit: Ts0CustomDigitEdit): Ts0CustomDigitEdit;
    function GetPrevEdit(AEdit: Ts0CustomDigitEdit): Ts0CustomDigitEdit;
    procedure Loaded; override;
    function NewInputStyle: Ts0CustomDateEditInputStyle; virtual;
    procedure RestoreActivePartKind(Sender: TObject);
    procedure ValidateMaxDay;
    procedure ItemChanged(Sender: TObject);
    function GetEdits(AType: K0DateEditItemType): Ts0CustomDigitEdit; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    function ReCalcEditsHeights: Integer;
    function ReCalcEditsWidthes: Integer;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    class function GetEraChar(JEra: K0JapaneseEra): Char;
    class function GetJEraByChar(AChar: Char): K0JapaneseEra;
    property ActivePartKind: K0DateEditItemType read FActivePartKind;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property Modified: Boolean read GetModified write SetModified;
  protected
    property Year: Word index 1 read GetPart write SetPart stored False;
    property Month: Word index 2 read GetPart write SetPart stored False;
    property Day: Word index 3 read GetPart write SetPart stored False;
    property Hour: Word index 4 read GetPart write SetPart stored False;
    property Minute: Word index 5 read GetPart write SetPart stored False;
    property Second: Word index 6 read GetPart write SetPart stored False;
    property MiliSec: Word index 7 read GetPart write SetPart stored False;
  protected
  	property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Accessor: Ts0DateEditAccessor read FAccessor write SetAccessor;
    property AutoAdjustSize: Boolean read FAutoAdjustSize write SetAutoAdjustSize
      default True;
    property AutoTab: Boolean read FAutoTab write SetAutoTab default True;
    property EraType: K0EraKind read FEraType write SetEraType default
      k0ekChristian;
    property InputStyle: Ts0CustomDateEditInputStyle read FInputStyle write
      SetInputStyle;
    property JapaneseEra: K0JapaneseEra read GetJapaneseEra write
      SetJapaneseEra;
    property MarginTop: Integer read FMarginTop write SetMarginTop;
    property MarginBottom: Integer read FMarginBottom write SetMarginBottom;
  protected
    property EditYear: Ts0DateiEditItemEdit index 1 read GetEditParts write
      SetEditParts;
    property EditMonth: Ts0DateiEditItemEdit index 2 read GetEditParts write
      SetEditParts;
    property EditDay: Ts0DateiEditItemEdit index 3 read GetEditParts write
      SetEditParts;
    property EditHour: Ts0DateiEditItemEdit index 4 read GetEditParts write
      SetEditParts;
    property EditMinute: Ts0DateiEditItemEdit index 5 read GetEditParts write
      SetEditParts;
    property EditSecond: Ts0DateiEditItemEdit index 6 read GetEditParts write
      SetEditParts;
    property EditMiliSec: Ts0DateiEditItemEdit index 7 read GetEditParts write
      SetEditParts;
  end;

type
  Ts0DateEditInputStyle = class(Ts0CustomDateEditInputStyle)
  published
    { Control's Property }
    property Alignment;
    property CharCase;
    property Font;
    property ImeMode;
    property ImeName;
    property Modified;
    property ReadOnly;
  published
    { Original Property }
    property AutoTab;
    property AutoWidth;
    property Title;
    property TitleDisplay;
  end;

type
  Ts0DateEdit = class(Ts0CustomDateEdit)
  private
    function GetInputStyle: Ts0DateEditInputStyle;
    procedure SetInputStyle(const Value: Ts0DateEditInputStyle);
  protected
    function NewInputStyle: Ts0CustomDateEditInputStyle; override;
  protected
    //次回削除予定
    property Year;
    property Month;
    property Day;
    property Hour;
    property Minute;
    property Second;
    property MiliSec;
  published
  	property Alignment;
    property Accessor;
    property AutoAdjustSize;
    property AutoTab;
    property EraType;
    property InputStyle: Ts0DateEditInputStyle read GetInputStyle write
      SetInputStyle;
    property JapaneseEra;
    property MarginTop;
    property MarginBottom;
  published
    property BorderStyle;
    property BorderStyleOfParts;
    property Color;
    property Ctl3D;
    property Enabled;
    property Font;
    property ReadOnly;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnChange;
    property OnPartEnter;
    property OnPartExit;
  published
    property EditYear;
    property EditMonth;
    property EditDay;
    property EditHour;
    property EditMinute;
    property EditSecond;
    property EditMiliSec;
  end;

type
  Es0DateEditException = class(Exception);

type
  Ts0DateEditDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet;
      override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject);
      override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject);
      override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject);
      override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject);
      override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetAccessor(AControl: TObject): Ts0DataAccessor; override;
    class function GetInputControl(AControl: TObject): Ts0InputStyle; override;
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift:
      TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

type
  Es0DateEdit = class(Exception);

implementation

uses
  s0StringHelper,
  s0ComponentHelper,
  s0TabOrderController,
  Math;

resourcestring
  c9ErrMsg_IndexConversionError = '不正なインデックスです';

function IndexToItemType(AIndex: Integer): K0DateEditItemType;
begin
  case AIndex of
    1: Result := k0ddtYear;
    2: Result := k0ddtMonth;
    3: Result := k0ddtDay;
    4: Result := k0tdtHour;
    5: Result := k0tdtMinute;
    6: Result := k0tdtSecond;
    7: Result := k0tdtMiliSec;
  else
    raise Es0DateEditException.Create(c9ErrMsg_IndexConversionError);
  end;
end;


{ Ts0DateEditAccessor }

constructor Ts0DateEditAccessor.Create(AOwner: TComponent);
begin
  inherited;
end;

function Ts0DateEditAccessor.GetAsDateTime: TDateTime;
begin
  Result := GetOwnerEdit.AsDateTime;
end;

function Ts0DateEditAccessor.GetAsFloat: Double;
begin
  Result := GetOwnerEdit.AsDateTime;
end;

function Ts0DateEditAccessor.GetAsInteger: Integer;
begin
  Result := Trunc(GetOwnerEdit.AsDateTime);
end;

function Ts0DateEditAccessor.GetAsString: string;
begin
  Result := DateTimeToStr(GetOwnerEdit.AsDateTime);
end;

function Ts0DateEditAccessor.GetOwnerEdit: Ts0CustomDateEdit;
begin
  Result := Ts0CustomDateEdit(Owner);
end;

function Ts0DateEditAccessor.GetPart(const Index: Integer): Word;
begin
  Result := GetOwnerEdit.GetPart(Index);
end;

procedure Ts0DateEditAccessor.SetAsDateTime(const Value: TDateTime);
begin
  GetOwnerEdit.AsDateTime := Value;
end;

procedure Ts0DateEditAccessor.SetAsFloat(const Value: Double);
begin
  GetOwnerEdit.AsDateTime := Value;
end;

procedure Ts0DateEditAccessor.SetAsInteger(const Value: Integer);
begin
  GetOwnerEdit.AsDateTime := Value;
end;

procedure Ts0DateEditAccessor.SetAsString(const Value: string);
begin
  GetOwnerEdit.AsDateTime := StrToDateTime(Value);
end;

procedure Ts0DateEditAccessor.SetPart(const Index: Integer;
  const Value: Word);
begin
  GetOwnerEdit.SetPart(Index, Value);
end;


type
  Tc9DateEditItemClass = class of Tc9DateEditItem;
  Tc9DateEditItem = class(Ts0DigitEdit)
  protected
    FOwnerDate: Ts0CustomDateEdit;
    FEditType: K0DateEditItemType;
    FMustGoNext: Boolean;
    function GoNext: Ts0CustomDigitEdit; virtual;
    function GoPrior: Ts0CustomDigitEdit; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MoveToNext;
    procedure Change; override;
  public
    constructor CreateEdit(AEdit: Ts0CustomDateEdit; AType: K0DateEditItemType);
      virtual;
    procedure IncSelValue(Plus: Boolean = True); override;
    property BorderStyle;
  end;

type
  // 年 入力用エディット
  Tc9YearEdit = class(Tc9DateEditItem)
  private
    function GetHead: Char;
    procedure SetHead(const Value: Char);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function NeedFillUpText: Boolean; override;
    procedure FillUpText; override;
    //
    function GetCurrentExponent: Integer; override;
    function GetAsFloat: Double; override;
    procedure SetAsFloat(const Value: Double); override;
  public
    constructor CreateEdit(AEdit: Ts0CustomDateEdit; AType: K0DateEditItemType);
      override;
    property Head: Char read GetHead write SetHead;
  end;

{ Tc9DateEditItem }

procedure Tc9DateEditItem.Change;
begin
  if (FOwnerDate <> nil) and FOwnerDate.FUpdating then Exit;
  inherited Change;
end;

constructor Tc9DateEditItem.CreateEdit(AEdit: Ts0CustomDateEdit; AType:
  K0DateEditItemType);
begin
  inherited Create(AEdit);
  FEditType := AType;
  FOwnerDate := AEdit;
  FillZero := True;
  MinValue := 0;
  CheckMin := True;
  CheckMax := True;
  AutoSelect := False;
  AutoWidth := False;
  ModifyUpDown := True;
  AutoTab := False;
  IgnoreZeroOfHead := False;
  SelectPolicy.Enabled := True;
  SelectPolicy.FixedSelLength := 1;
  SelectPolicy.Options := [k0spoIgnoreDeleteText, k0spoAllowMoveOfUpDown,
    k0spoKeepFixedLength];
end;

function Tc9DateEditItem.GoNext: Ts0CustomDigitEdit;
begin
  Result := FOwnerDate.GetNextEdit(Self);
  if Result = nil then
    Exit;
  Result.SetFocus;
  Result.SelStart := 0;
end;

function Tc9DateEditItem.GoPrior: Ts0CustomDigitEdit;
begin
  Result := FOwnerDate.GetPrevEdit(Self);
  if Result = nil then
    Exit;
  Result.SetFocus;
  Result.SelStart := Result.TextLength - 1;
end;

procedure Tc9DateEditItem.IncSelValue(Plus: Boolean);
var
  lDiff: Integer;
  newDate: TDateTime;
  selS: Integer;
begin
  if Plus then
    lDiff := 1
  else
    lDiff := -1;
  lDiff := lDiff * Trunc(Power(10, GetCurrentExponent));
  newDate := FOwnerDate.AsDateTime;
  case Self.FEditType of
    k0ddtYear: newDate := Ts0DateHelper.IncYear(newDate, lDiff);
    k0ddtMonth: newDate := Ts0DateHelper.IncMonth(newDate, lDiff);
    k0ddtDay: newDate := Ts0DateHelper.IncDay(newDate, lDiff);
    k0tdtHour: newDate := newDate + lDiff / 24;
    k0tdtMinute: newDate := newDate + lDiff / 24 / 60;
    k0tdtSecond: newDate := newDate + lDiff / 24 / 60 / 60;
    k0tdtMiliSec: newDate := newDate + lDiff / 24 / 60 / 60 / 1000;
  end;
  //
  selS := Self.SelStart;
  try
    FOwnerDate.AsDateTime := newDate;
  finally
    Self.SelStart := selS;
  end;
end;

procedure Tc9DateEditItem.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT:
      if SelStart < 1 then
      begin
        GoPrior;
        Key := 0;
      end;
    VK_RIGHT:
      if SelStart + 1 > Self.TextLength - 1 then
      begin
        GoNext;
        Key := 0;
      end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure Tc9DateEditItem.KeyPress(var Key: Char);
  function IsMustGoNext(Key: Char): Boolean;
  begin
    Result := False;
    if not (Ts0CharHelper.IsDigit(Key) or Ts0CharHelper.IsAlpha(Key)) then Exit;
    if SelStart < Self.TextLength - 1 then Exit;
    Result := True;
  end;
begin
  FMustGoNext := IsMustGoNext(Key);
  inherited KeyPress(Key);
end;

procedure Tc9DateEditItem.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  MoveToNext;
end;

procedure Tc9DateEditItem.MoveToNext;
var
  lastEdit: Ts0DateiEditItemEdit;
begin
  if not FMustGoNext then Exit;
  FMustGoNext := False;
  lastEdit := FOwnerDate.GetLastVisibleEdit;
  if lastEdit = nil then Exit;
  if lastEdit.Control = Self then
  begin
    if FOwnerDate.AutoTab then
      Ts0TabOrderController.Instance.MoveFocus(Self)
  end
  else
    GoNext;
end;

{ Tc9YearEdit }

procedure Tc9YearEdit.FillUpText;
var
  i: Integer;
  s: string;
begin
  if FOwnerDate.EraType <> k0ekJapanese then
  begin
    inherited FillUpText;
    Exit;
  end;
  //和暦の場合
  s := Copy(Text, 2, Length(Text) - 1);
  for i := Length(s) + 1 to MaxLength - 1 do
    s := '0' + s;
  Text := Head + s;
end;

function Tc9YearEdit.NeedFillUpText: Boolean;
begin
  Result := inherited NeedFillUpText;
end;

procedure Tc9YearEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_BACK,
      VK_TAB,
      VK_CLEAR,
      VK_DELETE,
      VK_SPACE: Key := 0;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure Tc9YearEdit.KeyPress(var Key: Char);
begin
  if FOwnerDate.EraType = k0ekChristian then
  begin
    inherited KeyPress(Key);
    Exit;
  end;
  //
  if Self.SelStart = 0 then
  begin
    if Key in ['H', 'M', 'S', 'T', 'h', 'm', 's', 't'] then
    begin
      SetHead(UpCase(Key));
      Key := #0;
    end;
    Key := #0;
    inherited KeyPress(Key);
  end
  else
  begin
    if not (Key in ['0'..'9']) then
      Key := #0;
    inherited KeyPress(Key);
  end;
end;

function Tc9YearEdit.GetHead: Char;
begin
  Result := Text[1];
end;

procedure Tc9YearEdit.SetHead(const Value: Char);
begin
  Text := Value + Copy(Text, 2, Length(Text) - 1);
end;

function Tc9YearEdit.GetAsFloat: Double;
var
  s: string;
begin
  Result := 0;
  s := Text;
  if s = '' then Exit;
  while (s <> '') and (not Ts0CharHelper.IsDigit(s[1])) do
    Delete(s, 1, 1);
  try
    Result := StrToFloat(s);
  except
    on E: Exception do
      if E is EConvertError then
        Result := 0;
  end;
  if Result < MinValue then
    Result := MinValue;
end;

function Tc9YearEdit.GetCurrentExponent: Integer;
begin
  Result := inherited GetCurrentExponent; // -1;
end;

procedure Tc9YearEdit.SetAsFloat(const Value: Double);
var
  s: string;
  i: Integer;
begin
  if FOwnerDate.EraType <> k0ekJapanese then
  begin
    inherited SetAsFloat(Value);
    Exit;
  end;
  //和暦の場合
  s := IntToStr(Trunc(Value));
  for i := Length(s) + 1 to MaxLength - 1 do
    s := '0' + s;
  Text := Head + s;
end;

constructor Tc9YearEdit.CreateEdit(AEdit: Ts0CustomDateEdit;
  AType: K0DateEditItemType);
begin
  inherited CreateEdit(AEdit, AType);
  InputStyle.ExclusiveAcceptChar := 'HMSThmst';
end;

{ Ts0CustomDateEdit }

procedure Ts0CustomDateEdit.AdjustItemPositions;
  procedure AdjustItemTops;
  const
  	fixedTopMargin = 2;
  var
    i: K0DateEditItemType;
    h: Integer;
    dh: Integer;
    edit: Ts0CustomDigitEdit;
  begin
    h := Self.Height - MarginTop - MarginBottom;
    for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
    begin
      edit := FEdits[i];
      if edit.Height > h then
      begin
        edit.Top := MarginTop;
      end
      else
      begin
        dh := h - edit.Height;
        edit.Top := MarginTop + (dh div 2) + fixedTopMargin;
      end;
    end;
  end;
  procedure AdjustItemLefts;
  var
    i: K0DateEditItemType;
    currentLeft: Integer;
    totalWidth: Integer;
  begin
  	totalWidth := 0;
    for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
       if FEdits[i].Visible then
    		totalWidth := totalWidth + FEdits[i].Width;
    //
    case Alignment of
      taCenter: currentLeft := (Self.Width - totalWidth) div 2;
      taRightJustify: currentLeft := Self.Width - totalWidth;
    else
    	currentLeft := 0;
    end;
    for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
    begin
      if FEdits[i].Visible then
      begin
        FEdits[i].Left := currentLeft;
        currentLeft := currentLeft + FEdits[i].Width;
      end
      else
      begin
        //Visible=FalseのEditは表示圏外へ
        FEdits[i].Left := -100;
      end;
    end;
  end;
begin
  AdjustItemTops;
  AdjustItemLefts;
end;

procedure Ts0CustomDateEdit.AdjustSize;
begin
  if (csLoading in ComponentState) or (not HandleAllocated) or (not
    AutoAdjustSize) then
  begin
	  AdjustItemPositions;
    inherited AdjustSize;
  end
  else
  begin
    RefreshItemEdits;
  end;
end;

constructor Ts0CustomDateEdit.Create(AOwner: TComponent);
begin
  FAutoTab := True;
  FAccessor := Ts0DateEditAccessor.Create(Self);
  Width := 70;
  Height := 24;
  FAlignment := taLeftJustify;
  //
  FEraType := k0ekChristian;
  inherited Create(AOwner);
  OwnerIgnorance := [ {k0c3pkColor,} k0c3pkFont, k0c3pkTabStop];

  FInputStyle := NewInputStyle;
  FAutoAdjustSize := True;
  ControlStyle := [{csAcceptsControls,}csCaptureMouse, csClickEvents, csFramed,
    csSetCaption, csDoubleClicks, {csFixedWidth, csFixedHeight,}
    csReplicatable];
  //
  AsDateTime := Now;
end;

procedure Ts0CustomDateEdit.CreateCtrls;
  function NewEdit(AType: K0DateEditItemType; AName: string;
    AClass: Tc9DateEditItemClass): Tc9DateEditItem;
  begin
    Result := AClass.CreateEdit(Self, AType);
    Result.Parent := Self;
    Result.Name := Ts0ComponentHelper.GetNewComponentNameOf(Result, AName);
    Result.Align := alNone;
    Result.ParentFont := False;
    Result.NumericOnly := True;
    Result.MaxLength := 2;
    Result.MaxValue := 99;
    Result.Width := 18;
    Result.OnChange := ItemChanged;
    FEditParts[AType] := Ts0DateiEditItemEdit.Create(Self, CCCItems, Result);
  end;
var
  posEdit: Integer;
begin
  FUpdating := True;
  try
    posEdit := 0;
    FEdits[k0ddtYear] := NewEdit(k0ddtYear, 'inpYear', Tc9YearEdit);
    FEdits[k0ddtYear].Left := 0;
    FEdits[k0ddtYear].MaxLength := 4;
    FEdits[k0ddtYear].Width := 30;
    FEdits[k0ddtYear].Visible := True;
    Tc9YearEdit(FEdits[k0ddtYear]).MaxValue := 9999;
    Inc(posEdit, FEdits[k0ddtYear].Width + 2);
    //
    FEdits[k0ddtMonth] := NewEdit(k0ddtMonth, 'inpMonth', Tc9DateEditItem);
    FEdits[k0ddtMonth].Left := posEdit;
    FEdits[k0ddtMonth].Visible := True;
    Tc9DateEditItem(FEdits[k0ddtMonth]).MinValue := 1;
    Tc9DateEditItem(FEdits[k0ddtMonth]).MaxValue := 12;
    Inc(posEdit, FEdits[k0ddtMonth].Width + 2);
    //
    FEdits[k0ddtDay] := NewEdit(k0ddtDay, 'inpDay', Tc9DateEditItem);
    FEdits[k0ddtDay].Left := posEdit;
    FEdits[k0ddtDay].Visible := True;
    Tc9DateEditItem(FEdits[k0ddtDay]).MinValue := 1;
    Tc9DateEditItem(FEdits[k0ddtDay]).MaxValue := 31;
    Inc(posEdit, FEdits[k0ddtDay].Width + 2);

    FEdits[k0tdtHour] := NewEdit(k0tdtHour, 'inpHour', Tc9DateEditItem);
    FEdits[k0tdtHour].Left := posEdit;
    FEdits[k0tdtHour].Visible := False;
    Tc9DateEditItem(FEdits[k0tdtHour]).MinValue := 0;
    Tc9DateEditItem(FEdits[k0tdtHour]).MaxValue := 23;
    Inc(posEdit, FEdits[k0tdtHour].Width + 2);

    FEdits[k0tdtMinute] := NewEdit(k0tdtMinute, 'inpMinute', Tc9DateEditItem);
    FEdits[k0tdtMinute].Left := posEdit;
    FEdits[k0tdtMinute].Visible := False;
    Tc9DateEditItem(FEdits[k0tdtMinute]).MinValue := 0;
    Tc9DateEditItem(FEdits[k0tdtMinute]).MaxValue := 59;
    Inc(posEdit, FEdits[k0tdtMinute].Width + 2);

    FEdits[k0tdtSecond] := NewEdit(k0tdtSecond, 'inpSecond', Tc9DateEditItem);
    FEdits[k0tdtSecond].Left := posEdit;
    FEdits[k0tdtSecond].Visible := False;
    Tc9DateEditItem(FEdits[k0tdtSecond]).MinValue := 0;
    Tc9DateEditItem(FEdits[k0tdtSecond]).MaxValue := 59;
    Inc(posEdit, FEdits[k0tdtSecond].Width + 2);

    FEdits[k0tdtMiliSec] := NewEdit(k0tdtMiliSec, 'inpMiliSec',
      Tc9DateEditItem);
    FEdits[k0tdtMiliSec].Left := posEdit;
    FEdits[k0tdtMiliSec].Visible := False;
    Tc9DateEditItem(FEdits[k0tdtMiliSec]).MinValue := 0;
    Tc9DateEditItem(FEdits[k0tdtMiliSec]).MaxValue := 999;
    Tc9DateEditItem(FEdits[k0tdtMiliSec]).MaxLength := 3;
    Tc9DateEditItem(FEdits[k0tdtMiliSec]).Width := 27;
  finally
    FUpdating := False;
  end;
end;

procedure Ts0CustomDateEdit.CreateHandle;
begin
  inherited;
  RefreshItemEdits;
end;

destructor Ts0CustomDateEdit.Destroy;
begin
  Self.Canvas.Font.FontAdapter := nil;
  FreeAndNil(FInputStyle);
  FreeAndNil(FAccessor);
  inherited;
end;

function Ts0CustomDateEdit.GetAsDateTime: TDateTime;
var
  ys: string;
  t: TDateTime;
begin
  Result := 0;
  t := EncodeTime(
    FEdits[k0tdtHour].AsInteger,
    FEdits[k0tdtMinute].AsInteger,
    FEdits[k0tdtSecond].AsInteger,
    FEdits[k0tdtMiliSec].AsInteger
    );
  case EraType of
    k0ekChristian:
      begin
        Result :=
          EncodeDate(
          FEdits[k0ddtYear].AsInteger,
          FEdits[k0ddtMonth].AsInteger,
          FEdits[k0ddtDay].AsInteger
          ) + t;
      end;

    k0ekJapanese:
      begin
        ys := FEdits[k0ddtYear].Text;
        Result :=
          Ts0DateHelper.ToChristianEra(
          GetJEraByChar(ys[1]),
          FEdits[k0ddtYear].AsInteger,
          FEdits[k0ddtMonth].AsInteger,
          FEdits[k0ddtDay].AsInteger
          ) + t;
      end;
  end;
end;

resourcestring
  c9ErrMsg_EditNotFound = '指定されたインスタンスは見つかりませんでした。';

function Ts0CustomDateEdit.GetEditType(
  AEdit: Ts0CustomDigitEdit): K0DateEditItemType;
var
  i: K0DateEditItemType;
begin
  for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
    if AEdit = FEdits[i] then
    begin
      Result := i;
      Exit;
    end;
  raise Es0DateEditException.Create(c9ErrMsg_EditNotFound);
end;

class function Ts0CustomDateEdit.GetEraChar(JEra: K0JapaneseEra): Char;
const
  c9EraChar: array[K0JapaneseEra] of Char = (
    'M', 'T', 'S', 'H'
    );
begin
  Result := c9EraChar[JEra];
end;

function Ts0CustomDateEdit.GetJapaneseEra: K0JapaneseEra;
begin
  Result := GetJEraByChar(Tc9YearEdit(FEdits[k0ddtYear]).Head);
end;

class function Ts0CustomDateEdit.GetJEraByChar(AChar: Char): K0JapaneseEra;
begin
  Result := k0jeHeisei;
  case AChar of
    'H': Result := k0jeHeisei;
    'M': Result := k0jeMeiji;
    'S': Result := k0jeShowa;
    'T': Result := k0jeTaisho;
  end;
end;

function Ts0CustomDateEdit.GetModified: Boolean;
var
  i: K0DateEditItemType;
begin
  Result := True;
  for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
    if FEdits[i].Modified then
      Exit;
  Result := False;
end;

function Ts0CustomDateEdit.GetNextEdit(
  AEdit: Ts0CustomDigitEdit): Ts0CustomDigitEdit;
var
  i, et: K0DateEditItemType;
begin
  Result := nil;
  et := GetEditType(AEdit);
  if et >= High(K0DateEditItemType) then Exit;
  Inc(et);
  for i := et to High(K0DateEditItemType) do
    if FEdits[i].Enabled and FEdits[i].Visible then
    begin
      Result := FEdits[i];
      Exit;
    end;
end;

function Ts0CustomDateEdit.GetPart(const Index: Integer): Word;
begin
  Result := FEdits[IndexToItemType(Index)].AsInteger;
end;

function Ts0CustomDateEdit.GetPrevEdit(
  AEdit: Ts0CustomDigitEdit): Ts0CustomDigitEdit;
var
  i, et: K0DateEditItemType;
begin
  Result := nil;
  et := GetEditType(AEdit);
  if et <= Low(K0DateEditItemType) then Exit;
  Dec(et);
  for i := et downto Low(K0DateEditItemType) do
    if FEdits[i].Enabled and FEdits[i].Visible then
    begin
      Result := FEdits[i];
      Exit;
    end;
end;

procedure Ts0CustomDateEdit.Invalidate;
var
  i: K0DateEditItemType;
begin
  inherited;
  for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
    FEdits[i].Invalidate;
end;

procedure Ts0CustomDateEdit.ItemChanged(Sender: TObject);
begin
  if Sender = FEdits[k0ddtYear] then
    ValidateMaxDay
  else
    if Sender = FEdits[k0ddtMonth] then
      ValidateMaxDay;
end;

procedure Ts0CustomDateEdit.Loaded;
begin
  inherited;
  RefreshItemEdits;
end;

const
  c9EditsMargin = 6;

function Ts0CustomDateEdit.ReCalcEditsHeights: Integer;
const
  c9DefHeightStr = '8';
  c9HeightMargin = 2;
var
  h, maxHeight: Integer;
  i: K0DateEditItemType;
begin
  Result := Height;
  if not HandleAllocated then Exit;
  Canvas.Font.Assign(Self.Font);
  maxHeight := Canvas.TextHeight(c9DefHeightStr);
  for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
  begin
    if not FEditParts[i].Visible then Continue;
    Canvas.Font.Assign(FEditParts[i].Font);
    h := Canvas.TextHeight(c9DefHeightStr);
    if h < maxHeight then Continue;
    maxHeight := h;
  end;
  Result := maxHeight + c9HeightMargin;
end;

function Ts0CustomDateEdit.ReCalcEditsWidthes: Integer;
  procedure SetWidth(AEdit: Ts0CustomDigitEdit; AStr: string);
  begin
    Self.Canvas.Font.Assign(AEdit.Font);
    AEdit.Width := Self.Canvas.TextWidth(AStr) + c9EditsMargin;
  end;
const
  c9DefWidthStr = '88';
  c9DefWidthStrMiliSec = '888';
  c9DefWidthStrs: array[K0EraKind] of string = ('8888', 'W88');
var
  lastEdit: Ts0DateiEditItemEdit;
begin
  Result := Width;
  if not HandleAllocated then Exit;
  SetWidth(FEdits[k0ddtYear], c9DefWidthStrs[FEraType]);
  SetWidth(FEdits[k0ddtMonth], c9DefWidthStr);
  SetWidth(FEdits[k0ddtDay], c9DefWidthStr);
  SetWidth(FEdits[k0tdtHour], c9DefWidthStr);
  SetWidth(FEdits[k0tdtMinute], c9DefWidthStr);
  SetWidth(FEdits[k0tdtSecond], c9DefWidthStr);
  SetWidth(FEdits[k0tdtMiliSec], c9DefWidthStrMiliSec);
  //
  lastEdit := GetLastVisibleEdit;
  if lastEdit = nil then Exit;
  Result := lastEdit.Left + lastEdit.Width + 1;
end;


procedure Ts0CustomDateEdit.RefreshItemEdits;
begin
  if not HandleAllocated then Exit;
  if AutoAdjustSize and ([csLoading, csReading] * Self.ComponentState = []) then
    inherited SetBounds(Left, Top, ReCalcEditsWidthes, ReCalcEditsHeights);
  AdjustItemPositions;
  Invalidate;
end;

resourcestring
  c9ErrMsg_IllegalSender = '不正なSenderオブジェクトです。';

procedure Ts0CustomDateEdit.RestoreActivePartKind(Sender: TObject);
var
  i: K0DateEditItemType;
begin
  if not (Sender is Ts0CustomDigitEdit) then Exit;
  for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
  begin
    if FEdits[i] = Sender then
    begin
      FActivePartKind := i;
      Exit;
    end;
  end;
  raise Es0DateEditException.Create(c9ErrMsg_IllegalSender);
end;


procedure Ts0CustomDateEdit.SetAccessor(const Value: Ts0DateEditAccessor);
begin
  FAccessor.Assign(Value);
end;

procedure Ts0CustomDateEdit.SetAsDateTime(const Value: TDateTime);
var
  jn: K0JapaneseEra;
  yy, mm, dd: Word;
  hh, nn, ss, ms: Word;
begin
  DecodeTime(Value, hh, nn, ss, ms);
  FEdits[k0tdtHour].AsInteger := hh;
  FEdits[k0tdtMinute].AsInteger := nn;
  FEdits[k0tdtSecond].AsInteger := ss;
  FEdits[k0tdtMiliSec].AsInteger := ms;
  case EraType of
    k0ekChristian:
      begin
        DecodeDate(Value, yy, mm, dd);
        FEdits[k0ddtYear].AsInteger := yy;
        FEdits[k0ddtMonth].AsInteger := mm;
        FEdits[k0ddtDay].AsInteger := dd;
      end;
    k0ekJapanese:
      begin
        Ts0DateHelper.ToJapaneseEra(Value, jn, yy, mm, dd);
        Tc9YearEdit(FEdits[k0ddtYear]).Head := GetEraChar(jn);
        FEdits[k0ddtYear].AsInteger := yy;
        FEdits[k0ddtMonth].AsInteger := mm;
        FEdits[k0ddtDay].AsInteger := dd;
      end;
  end;
end;

procedure Ts0CustomDateEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if AutoAdjustSize and ([csLoading, csReading] * Self.ComponentState = []) then
    inherited SetBounds(ALeft, ATop, ReCalcEditsWidthes, ReCalcEditsHeights)
  else
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure Ts0CustomDateEdit.SetEraType(const Value: K0EraKind);
var
  d: TDateTime;
begin
  //if FEraType = Value then Exit;
  FUpdating := True;
  try
    d := AsDateTime;
    FEraType := Value;
    RefreshItemEdits;
    if FEraType = k0ekChristian then
    begin
      Tc9DateEditItem(FEdits[k0ddtYear]).NumericOnly := True;
      Tc9DateEditItem(FEdits[k0ddtYear]).MaxLength := 4;
      Tc9DateEditItem(FEdits[k0ddtYear]).MaxValue := 9999;
    end
    else
    begin
      Tc9DateEditItem(FEdits[k0ddtYear]).NumericOnly := False;
      Tc9DateEditItem(FEdits[k0ddtYear]).MaxLength := 3;
      Tc9DateEditItem(FEdits[k0ddtYear]).MaxValue := 99;
    end;
  finally
    FUpdating := False;
  end;
  AsDateTime := d;
  RefreshItemEdits;
end;

procedure Ts0CustomDateEdit.SetJapaneseEra(const Value: K0JapaneseEra);
begin
  if FEraType <> k0ekJapanese then
    Exit;
  Tc9YearEdit(FEdits[k0ddtYear]).Head := GetEraChar(Value);
end;

procedure Ts0CustomDateEdit.SetModified(const Value: Boolean);
var
  i: K0DateEditItemType;
begin
  for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
    FEdits[i].Modified := Value;
end;

procedure Ts0CustomDateEdit.SetPart(const Index: Integer; const Value: Word);
begin
  FEdits[IndexToItemType(Index)].AsInteger := Value;
end;

procedure Ts0CustomDateEdit.ValidateMaxDay;
begin
  Tc9DateEditItem(FEdits[k0ddtDay]).MaxValue :=
    Ts0DateHelper.DayCountOfMonth(Year, Month);
end;

function Ts0CustomDateEdit.GetEditParts(const Index: Integer):
  Ts0DateiEditItemEdit;
begin
  Result := FEditParts[IndexToItemType(Index)];
end;

procedure Ts0CustomDateEdit.SetEditParts(const Index: Integer;
  const Value: Ts0DateiEditItemEdit);
begin
  FEditParts[IndexToItemType(Index)].Assign(Value);
end;

function Ts0CustomDateEdit.CanDoCtrlEvent(AEventKind: K0CCCPartEventKind;
  Sender: TObject): Boolean;
begin
  Result := inherited CanDoCtrlEvent(AEventKind, Sender);
  RestoreActivePartKind(Sender);
end;

function Ts0CustomDateEdit.GetLastVisibleEdit: Ts0DateiEditItemEdit;
var
  i: K0DateEditItemType;
begin
  for i := High(K0DateEditItemType) downto Low(K0DateEditItemType) do
  begin
    Result := FEditParts[i];
    if FEditParts[i].Visible then Exit;
  end;
  Result := nil;
end;

procedure Ts0CustomDateEdit.ChangedOfFont;
begin
  inherited ChangedOfFont;
  AdjustSize;
end;

procedure Ts0CustomDateEdit.SetAutoTab(const Value: Boolean);
begin
  FAutoTab := Value;
end;

procedure Ts0CustomDateEdit.SetAutoAdjustSize(const Value: Boolean);
begin
  if FAutoAdjustSize = Value then Exit;
  FAutoAdjustSize := Value;
  if Value then AdjustSize;
end;

procedure Ts0CustomDateEdit.SetInputStyle(const Value:
  Ts0CustomDateEditInputStyle);
begin
  FInputStyle.Assign(Value);
end;

function Ts0CustomDateEdit.NewInputStyle: Ts0CustomDateEditInputStyle;
begin
  Result := Ts0CustomDateEditInputStyle.Create(Self);
end;

function Ts0CustomDateEdit.GetEdits(
  AType: K0DateEditItemType): Ts0CustomDigitEdit;
begin
  Result := FEdits[AType];
end;

procedure Ts0CustomDateEdit.SetMarginBottom(const Value: Integer);
begin
  FMarginBottom := Value;
  AdjustSize;
end;

procedure Ts0CustomDateEdit.SetMarginTop(const Value: Integer);
begin
  FMarginTop := Value;
  AdjustSize;
end;

procedure Ts0CustomDateEdit.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
  AdjustSize;
end;

{ Ts0DateEditDistiller }

class procedure Ts0DateEditDistiller.Click(AControl: TObject);
begin
  Ts0CustomDateEdit(AControl).Click;
end;

class function Ts0DateEditDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomDateEdit(AControl).Accessor;
end;

class function Ts0DateEditDistiller.GetColor(AControl: TObject): TColor;
begin
  Result := Ts0CustomDateEdit(AControl).Color;
end;

class function Ts0DateEditDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0CustomDateEdit(AControl).OnEnter;
  Result.FOnExit := Ts0CustomDateEdit(AControl).OnExit;
end;

class function Ts0DateEditDistiller.GetInputControl(
  AControl: TObject): Ts0InputStyle;
begin
  Result := Ts0CustomDateEdit(AControl).InputStyle;
end;

class function Ts0DateEditDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown := Ts0CustomDateEdit(AControl).OnKeyDown;
  Result.FOnKeyPress := Ts0CustomDateEdit(AControl).OnKeyPress;
  Result.FOnKeyUp := Ts0CustomDateEdit(AControl).OnKeyUp;
  Result.FOnChange := Ts0CustomDateEdit(AControl).OnChange;
end;

class function Ts0DateEditDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick := Ts0CustomDateEdit(AControl).OnClick;
  Result.FOnDblClick := Ts0CustomDateEdit(AControl).OnDblClick;
  Result.FOnMouseDown := Ts0CustomDateEdit(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomDateEdit(AControl).OnMouseMove;
  Result.FOnMouseUp := Ts0CustomDateEdit(AControl).OnMouseUp;
end;

class function Ts0DateEditDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CustomDateEdit(AControl).OnCanResize;
  Result.FOnResize := Ts0CustomDateEdit(AControl).OnResize;
end;

class function Ts0DateEditDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnChange];
end;

class function Ts0DateEditDistiller.GetValue(AControl: TObject): string;
begin
  Result := GetAccessor(AControl).AsString;
end;

class function Ts0DateEditDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CustomDateEdit;
end;

class procedure Ts0DateEditDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0CustomDateEdit(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0DateEditDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomDateEdit(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0DateEditDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomDateEdit(AControl).Color := AColor;
end;

class procedure Ts0DateEditDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomDateEdit(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomDateEdit(AControl).OnExit := Value.FOnExit;
end;

class procedure Ts0DateEditDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomDateEdit(AControl).OnKeyDown := Value.FOnKeyDown;
  Ts0CustomDateEdit(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomDateEdit(AControl).OnKeyUp := Value.FOnKeyUp;
  Ts0CustomDateEdit(AControl).OnChange := Value.FOnChange;
end;

class procedure Ts0DateEditDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomDateEdit(AControl).OnClick := Value.FOnClick;
  Ts0CustomDateEdit(AControl).OnDblClick := Value.FOnDblClick;
  Ts0CustomDateEdit(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomDateEdit(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomDateEdit(AControl).OnMouseUp := Value.FOnMouseUp;
end;

class procedure Ts0DateEditDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomDateEdit(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomDateEdit(AControl).OnResize := Value.FOnResize;
end;

class procedure Ts0DateEditDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  GetAccessor(AControl).AsString := Value;
end;

{ Ts0CustomDateEditInputStyle }

function Ts0CustomDateEditInputStyle.GetAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function Ts0CustomDateEditInputStyle.GetCharCase: TEditCharCase;
begin
  Result := ecUpperCase;
end;

function Ts0CustomDateEditInputStyle.GetFont: TFont;
begin
  Result := GetOwnerEdit.Font;
end;

function Ts0CustomDateEditInputStyle.GetImeMode: TImeMode;
begin
  Result := imClose;
end;

function Ts0CustomDateEditInputStyle.GetImeName: TImeName;
begin
  Result := GetOwnerEdit.ImeName;
end;

function Ts0CustomDateEditInputStyle.GetMaxLength: Integer;
begin
  Result := 0;
end;

function Ts0CustomDateEditInputStyle.GetModified: Boolean;
begin
  Result := GetOwnerEdit.Modified;
end;

function Ts0CustomDateEditInputStyle.GetOwnerEdit: Ts0CustomDateEdit;
begin
  Result := Ts0CustomDateEdit(Control);
end;

function Ts0CustomDateEditInputStyle.GetReadOnly: Boolean;
begin
  Result := GetOwnerEdit.ReadOnly;
end;

function Ts0CustomDateEditInputStyle.GetText: string;
begin
  Result := GetOwnerEdit.Accessor.AsString;
end;

procedure Ts0CustomDateEditInputStyle.SetAlignment(const Value: TAlignment);
begin
end;

procedure Ts0CustomDateEditInputStyle.SetCharCase(const Value: TEditCharCase);
begin
end;

procedure Ts0CustomDateEditInputStyle.SetFont(const Value: TFont);
begin
  GetOwnerEdit.Font := Value;
end;

procedure Ts0CustomDateEditInputStyle.SetImeMode(const Value: TImeMode);
begin
end;

procedure Ts0CustomDateEditInputStyle.SetImeName(const Value: TImeName);
begin
end;

procedure Ts0CustomDateEditInputStyle.SetMaxLength(const Value: Integer);
begin
end;

procedure Ts0CustomDateEditInputStyle.SetModified(const Value: Boolean);
begin
  GetOwnerEdit.Modified := Value;
end;

procedure Ts0CustomDateEditInputStyle.SetText(const Value: string);
begin
  GetOwnerEdit.Accessor.AsString := Value;
end;

{ Ts0DateEdit }

function Ts0DateEdit.GetInputStyle: Ts0DateEditInputStyle;
begin
  Result := Ts0DateEditInputStyle(inherited InputStyle);
end;

function Ts0DateEdit.NewInputStyle: Ts0CustomDateEditInputStyle;
begin
  Result := Ts0CustomDateEditInputStyle.Create(Self);
end;

procedure Ts0DateEdit.SetInputStyle(const Value: Ts0DateEditInputStyle);
begin
  inherited InputStyle := Value;
end;

{ Ts0DateiEditItemEdit }

procedure Ts0DateiEditItemEdit.SetAlign(const Value: TAlign);
begin
	//ignore value
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0DateEditDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0DateEditDistiller);

end.

