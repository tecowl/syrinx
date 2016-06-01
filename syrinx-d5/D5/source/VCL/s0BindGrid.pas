unit s0BindGrid;
{
$History: s0BindGrid.pas $
 * 
 * *****************  Version 37  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 36  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 35  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 34  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 33  *****************
 * User: Akima        Date: 02/02/14   Time: 21:50
 * Updated in $/source/D5Integrated
 * 列が移動したときに、タイトルも正しく移動するように修正
 * 
 * *****************  Version 32  *****************
 * User: Akima        Date: 02/02/05   Time: 4:30
 * Updated in $/source/D5Integrated
 * overrideしている、SetRowCount、SetCellsメソッドを呼ばすに、直接上位クラ
 * スの
 * SetRowCount、SetCellsを呼び出すメソッド、InhrSetRowCount、InhrSetCells
 * メソッドを追加。
 * 
 * *****************  Version 31  *****************
 * User: Akima        Date: 02/01/06   Time: 0:18
 * Updated in $/source/D5Integrated
 * KeyDown時にInvalidateしないように修正
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 01/12/11   Time: 3:39
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 29  *****************
 * User: Akima        Date: 01/12/10   Time: 17:39
 * Updated in $/source/D5Integrated
 * 大リファクタリング後、グリッドがやーっと安定しました。
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 01/12/10   Time: 16:15
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 01/12/07   Time: 18:56
 * Updated in $/source/D5Integrated
 * InplaceEditorを削除するというビッグリファクタリング成功！！！！
 * s0Gridsに修正多数
 * 
 * Ts0CustomStringGrid 
 *   <|--- Ts0CustomBindGrid
 *     <|--- Ts0CustomBaseGrid
 *       <|--- Ts0CustomDecoGrid
 *         <|--- Ts0CustomCtrlGrid
 *           <|--- Ts0ObjectGrid
 * となっていた継承関係を以下のように変更
 * 
 * Ts0CustomStringGrid 
 *   <|--- Ts0CustomDecoStringGrid (s0CellDecoratorに新規作成)
 *     <|--- Ts0CustomBindGrid
 *       <|--- Ts0CustomCtrlGrid
 *         <|--- Ts0CustomDecoGrid
 *           <|--- Ts0CustomBaseGrid
 *             <|--- Ts0ObjectGrid
 * 
 * 常々InplaceEditorが邪魔だなーと思っていたが、スパイクのつもりで
 * 削除してみたら大成功！もうInplaceEditorとCtrlDecoのコントロールを
 * 区別しません！わーい。処理が速くなったし、全体的にすっきりしたっす。
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 01/12/07   Time: 14:36
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 01/12/06   Time: 20:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/11/23   Time: 6:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/11/23   Time: 1:56
 * Updated in $/source/D5Integrated
 * MouseMoveメソッドでinvalidateしないようにした
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/10/21   Time: 15:25
 * Updated in $/source/D5Integrated
 * 何らかのDecoratorが破棄されたときの通知を受けるためのメソッドとしてDeco
 * Destroyを追加。（Ts0CtrlGridでovrride）
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/10/04   Time: 12:24
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/10/03   Time: 23:50
 * Updated in $/source/D5Integrated
 * Ts0GridColumnがGetDisplayNameメソッドをoverride。
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/10/03   Time: 0:23
 * Updated in $/source/D5Integrated
 * AutoEditingModeプロパティ、GetDecoratorsメソッドを追加
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/10/02   Time: 3:14
 * Updated in $/source/D5Integrated
 * GetDecoListメソッドを追加。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/10/01   Time: 9:09
 * Updated in $/source/D5Integrated
 * AccessorとDistillerを追加
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/09/30   Time: 1:50
 * Updated in $/source/D5Integrated
 * ValidateColIndex、ValidateRowIndexを変更
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/09/27   Time: 9:12
 * Updated in $/source/D5Integrated
 * Ts0GridColumnにDefaultValueを追加
 * ClearCol, ClearRowをTs0BaseGridから移動。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/25   Time: 10:05
 * Updated in $/source/D5Integrated
 * Columnsプロパティを追加
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/18   Time: 11:53
 * Updated in $/source/D5Integrated
 * ColumnMoved、RowMoved、NotificationなどでのDecoratorsを呼び出しを
 * Ts0BindGridだけで行うように修正
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/07   Time: 3:04
 * Updated in $/source/D5Integrated
 * キー操作、マウス操作の不備を修正
 *
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/06   Time: 21:19
 * Updated in $/source/D5Integrated
 * セルの移動などの制御を加えた
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0grid
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0grid
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/07   Time: 10:40
 * Updated in $/source/p0control/p0grid
 * Ts0GridCellDrawerを追加。
 * ・・・・左側で見切れているセルをうまく表示することができなーい！
 * 全部描画しちゃうのでぃす。困ってマース。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/30   Time: 11:11
 * Updated in $/source/p0control/p0grid
 * u0CellDecoratorにTs0CellDecoratorなどを移動した
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/30   Time: 10:15
 * Created in $/source/p0control/p0grid
 * 新規作成
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  contnrs,
  s0Persistent,
  s0VCLClasses,
  s0DataAccessor,
  s0CtrlDistiller,
  s0CellDecorator,
  s0Collection,
  s0Grids;

type
	{
  	セルを結合するデコレータ。
    デコレータの基本プロパティ以外は設定するプロパティはない。
  }
  Ts0BindingSeal = class(Ts0CellDecorator)
  protected
    procedure DrawBindCell;
  public
    function IsBaseCell(ACol, ARow: Integer): Boolean;
    function IsDrawTarget(ACol, ARow: Integer): Boolean;
  end;

type
  Ts0BindingSeals = class(Ts0CellDecorators)
  private
    function GetSeals(const Index: Integer): Ts0BindingSeal;
    procedure SetSeals(const Index: Integer; const Value: Ts0BindingSeal);
  public
    function SealByPos(ACol, ARow: Integer): Ts0BindingSeal;
    property Seals[const Index: Integer]: Ts0BindingSeal read GetSeals write SetSeals; default;
  end;

type
	{
  	セルを書込み禁止にするデコレータ。
    デコレータの基本プロパティ以外は設定するプロパティはない。
  }
  Ts0ReadOnlySeal = class(Ts0CellDecorator)
  public
    procedure Assign(Source: TPersistent); override;
  end;

type
  Ts0ReadOnlySeals = class(Ts0CellDecorators)
  private
    function GetSeals(const Index: Integer): Ts0ReadOnlySeal;
    procedure SetSeals(const Index: Integer; const Value: Ts0ReadOnlySeal);
  public
    property Seals[const Index: Integer]: Ts0ReadOnlySeal read GetSeals write SetSeals; default;
  end;

type
  Ts0CustomBindGrid = class;

  Ts0GridColumn = class(Ts0VCLCollectionItem)
  private
    FVirtualIndex: Integer;
    FTitleRow: Integer;
    FOwnerGrid: Ts0CustomBindGrid;
    FDefaultValue: string;
    FTitle: string;
    procedure SetTitle(const Value: string);
    procedure SetTitleRow(const Value: Integer);
    function GetTitle: string;
    function GetOwnerGrid: Ts0CustomBindGrid;
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);
    procedure SetTitleToGrid;
  protected
    function GetDisplayName: string; override;
    function GetIdentifier: string; override;
    property OwnerGrid: Ts0CustomBindGrid read GetOwnerGrid;
    procedure ResetPropToGrid; virtual;
    procedure SetIndex(Value: Integer); override;
  public
    procedure Assign(Source: TPersistent); override;
    property VirtualIndex: Integer read FVirtualIndex;
  published
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property Title: string read GetTitle write SetTitle;
    property TitleRow: Integer read FTitleRow write SetTitleRow;
    property Width: Integer read GetWidth write SetWidth;
  end;

  Ts0GridColumns = class(Ts0VCLCollection)
  private
    function GetColumns(const Index: Integer): Ts0GridColumn;
    procedure SetColumns(const Index: Integer; const Value: Ts0GridColumn);
    function GetAllColWidth: Integer;
  protected
    procedure PrepareColCout(AColCount: Integer);
    procedure ResetPropsToGrid;
    procedure Update(Item: TCollectionItem); override;
  public
    function ColByVirtualIndex(AVirtualIndex: Integer): Ts0GridColumn;
    function GetRealIndex(AVirtualIndex: Integer): Integer;
    property AllColWidth: Integer read GetAllColWidth;
    property Columns[const Index: Integer]: Ts0GridColumn read GetColumns write SetColumns; default;
  end;                                                                                             

  K0GridCellDrawOption = (k0gcdoRaiseFixedCell, k0gcdoUseReadOnlyColor);
  K0GridCellDrawOptionSet = set of K0GridCellDrawOption;

  K0GridOption = (
    k0goFixedVertLine,
    k0goFixedHorzLine,
    k0goVertLine,
    k0goHorzLine,
    k0goRangeSelect,
    k0goDrawFocusSelected,
    k0goRowSizing,
    k0goColSizing,
    k0goRowMoving,
    k0goColMoving,
    //k0goEditing,
    k0goTabs,
    k0goRowSelect,
    //k0goAlwaysShowEditor,
    k0goThumbTracking
  );
  K0GridOptions = set of K0GridOption;

  Ts0GridCellDrawer = class;

  Ts0BindGridAccessor = class(Ts0DataAccessor)
  protected
    function GetGrid: Ts0CustomBindGrid;
    function GetAsString: String; override;
    procedure SetAsString(const Value: String); override;
  end;

  K0GridChangeCurrentEvent = procedure(Sender: TObject; AOld, ANew: TGridCoord)
    of object;

  K0GridMode = (k0gmMoving, k0gmSelecting, k0gmEditing);
  K0GridModeSet = set of K0GridMode;

  K0GridModeTrigger = (k0gmtKeyDown, k0gmtKeyUp, k0gmtMouseDown, k0gmtMouseUp, k0gmtOther);

  Ts0GridMode = class
  protected
    FGrid: Ts0CustomBindGrid;
    FModeValue: K0GridMode;
    procedure Activate; virtual; abstract;
    procedure Deactivate; virtual; abstract;
  public
    function DidNotMove(AX, AY: Integer): Boolean;
    class function IsModeKey(k: Word): Boolean;
    class function IsMoveKey(k: Word): Boolean;
  public
    constructor Create(AGrid: Ts0CustomBindGrid); virtual;
    function GetNextMode(ATrigger: K0GridModeTrigger; AKey: Word; AShift:
      TShiftState; AButton: TMouseButton; X, Y: Integer): K0GridMode; virtual; abstract;
    property ModeValue: K0GridMode read FModeValue;
    procedure KeyDownOfGrid(AKey: Word; AShift: TShiftState); virtual;
    procedure ClickOfGrid; virtual;
  end;

  Ts0CustomBindGrid = class(Ts0CustomDecoStringGrid)
  private
    FBindSeals: Ts0BindingSeals;
    FMultiLine: Boolean;
    FCellDrawer: Ts0GridCellDrawer;
    FReadOnlySeals: Ts0ReadOnlySeals;
    FColumns: Ts0GridColumns;
    FAccessor: Ts0BindGridAccessor;
    FAutoEditingMode: Boolean;
    FUpdateViewCount: Integer;
    FOnChangeCurrent: K0GridChangeCurrentEvent;
    FOptions: K0GridOptions;
    procedure SetBindSeals(const Value: Ts0BindingSeals);
    procedure SetMultiLine(const Value: Boolean);
    procedure SetReadOnlySeals(const Value: Ts0ReadOnlySeals);
    procedure SetColumns(const Value: Ts0GridColumns);
    procedure SetAccessor(const Value: Ts0BindGridAccessor);
    procedure SetOptions(const Value: K0GridOptions);
  protected
    //FEditor: TWinControl;
    function CellRectForInplaceEditor(ACol, ARow: Longint): TRect; virtual;
    function GetInplaceEdit: TWinControl; override;
    function GetInplaceEditText(AControl: TWinControl): string; override;
    procedure SetInplaceEditText(AControl: TWinControl; const Value: string); override;
    procedure InplaceEditMove(ACol, ARow: Integer); override;
    function IsDrawable(ACol, ARow: Integer): Boolean; override;
    procedure HideEdit; override;
    procedure UpdateEdit; override;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure SizeChanged(OldColCount, OldRowCount: Longint); override;
  protected
    procedure DoChangeCurrent(ANewCol, ANewRow, AOldCol, AOldRow: Integer); virtual;
    procedure MoveCurrent(ACol, ARow: Longint; MoveAnchor, Show: Boolean); override;
  private
    FActiveMode: Ts0GridMode;
  protected
    FModeSet: array[K0GridMode] of Ts0GridMode;
    procedure ChangeModeForAT(ATrigger: K0GridModeTrigger; AKey: Word; AShift:
      TShiftState; AButton: TMouseButton; X, Y: Integer); virtual;
    function GetMode: K0GridMode;
    procedure PrepareModeSet; virtual;
    procedure SetMode(const Value: K0GridMode);
    property ActiveMode: Ts0GridMode read FActiveMode;
  protected
    { Old Options }
    function GetOldOptions: TGridOptions;
    procedure SetOldOptions(const Value: TGridOptions);
    property OldOptions: TGridOptions read GetOldOptions write SetOldOptions;
  protected
    function CalcCoordFromPoint(X, Y: Integer;
      const DrawInfo: TGridDrawInfo): TGridCoord; override;
//    function CanEditModify: Boolean; override;
    function CanEditShow: Boolean; override;
    procedure Click; override;
    procedure DoExit; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure GridRectToScreenRect(GridRect: TGridRect;
      var ScreenRect: TRect; IncludeLine: Boolean); override;
    function IsReadOnly(ACol, ARow: Integer): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
      Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
      Integer); override;
  protected
    procedure InhrSetCells(ACol, ARow: Integer; const Value: string);
    procedure InhrSetRowCount(const Value: Integer);
  protected
    procedure SetColCount(Value: Longint); override;
    procedure SetRowCount(Value: Longint); override;
    procedure TopLeftChanged;override;
    function ValidateColIndex(AColIndex: Integer): Boolean;
    function ValidateRowIndex(ARowIndex: Integer): Boolean;
  protected
    { for CellDrawer }
    function NewDrawer: Ts0GridCellDrawer; virtual;
    function GetCellDrawer: Ts0GridCellDrawer;
    procedure SetCellDrawer(const Value: Ts0GridCellDrawer);
    function IsSelected(ACol, ARow: Integer): Boolean; virtual;
    procedure Paint; override;
  protected
    function IsWordWrapCell(ACol, ARow: Integer): Boolean; virtual;
    function NewAccessor: Ts0BindGridAccessor; virtual;
    function NewBindSeals: Ts0BindingSeals; virtual;
    function NewReadOnlySeals: Ts0ReadOnlySeals; virtual;
    function NewColums: Ts0GridColumns; virtual;
  protected
  	{ セルの結合を設定するデコレータのコレクション。
      Ts0BindingSealsを参照。 }
    property BindSeals: Ts0BindingSeals read FBindSeals write SetBindSeals;
    { 複数行表示を行えうかどうか。デフォルトTrue。 }
    property MultiLine: Boolean read FMultiLine write SetMultiLine default True;
    { セルを書込み禁止にするデコレータのコレクション。
      Ts0ReadOnlySealsを参照。書込み禁止セルの色についてはTs0GridCellDrawerの
      ColorReadOnlyプロパティも参照のこと}
    property ReadOnlySeals: Ts0ReadOnlySeals read FReadOnlySeals write SetReadOnlySeals;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdateView; virtual;
    procedure EndUpdateView; virtual;
    property Mode: K0GridMode read GetMode write SetMode;
    property UpdateViewCount: Integer read FUpdateViewCount;
  public
    procedure ClearCol(AColIndex: Integer); virtual;
    procedure ClearRow(ARowIndex: Integer; SetDefault: Boolean = True); virtual;
    property AutoEditingMode: Boolean read FAutoEditingMode write FAutoEditingMode default True;
    property Accessor: Ts0BindGridAccessor read FAccessor write SetAccessor;
    property Columns: Ts0GridColumns read FColumns write SetColumns;
    property Selection;
  published
  	{ セルを描画する場合の一般的な設定のためのプロパティ }
    property CellDrawer: Ts0GridCellDrawer read GetCellDrawer write
      SetCellDrawer;
    property DefaultColWidth default 100;
    property DefaultRowHeight default 16;
    property OnChangeCurrent: K0GridChangeCurrentEvent read FOnChangeCurrent
      write FOnChangeCurrent;
    property BOptions: K0GridOptions read FOptions write SetOptions
      default [k0goFixedVertLine, k0goFixedHorzLine, k0goVertLine, k0goHorzLine,
      k0goRangeSelect];
  end;

  Ts0GridCellDrawer = class(Ts0VCLPersistent)
  private
    FOwnerGrid: Ts0CustomBindGrid;
    FColorSelected: TColor;
    FDrawOption: K0GridCellDrawOptionSet;
    FColorReadOnly: TColor;
    procedure SetColorSelected(const Value: TColor);
    procedure SetDrawOption(const Value: K0GridCellDrawOptionSet);
    procedure SetColorReadOnly(const Value: TColor);
    function GetDoubleBuffered: Boolean;
    procedure SetDoubleBuffered(const Value: Boolean);
  private
    function GetColor: TColor;
    function GetColorFixed: TColor;
    procedure SetColor(const Value: TColor);
    procedure SetColorFixed(const Value: TColor);
  protected
    function GetFont: TFont; virtual;
    procedure SetFont(const Value: TFont); virtual;
    procedure DrawText(ACanvas: TCanvas; ACol, ARow: Integer;
      ARect: TRect; AState: TGridDrawState); virtual;
    procedure Draw3DFrame(ACanvas: TCanvas; ACol, ARow: Integer;
      ARect: TRect; AState: TGridDrawState); virtual;
    function GetCellDrawOption(ACol, ARow: Integer): UINT; virtual;
    procedure SetCanvasColors(ACanvas: TCanvas; ACol, ARow: Integer;
      ARect: TRect; AState: TGridDrawState); virtual;
    function GetCellFont(ACol, ARow: Integer): TFont; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Change; override;
    procedure Draw(ACanvas: TCanvas; ACol, ARow: Longint;
      ARect: TRect; AState: TGridDrawState); virtual;
    property OwnerGrid: Ts0CustomBindGrid read FOwnerGrid;
  published
    property Color: TColor read GetColor write SetColor default clWindow;
    property ColorFixed: TColor read GetColorFixed write SetColorFixed default clBtnFace;
    property ColorReadOnly: TColor read FColorReadOnly write SetColorReadOnly default clBtnFace;
    property ColorSelected: TColor read FColorSelected write SetColorSelected default clTeal;
    property DoubleBuffered: Boolean read GetDoubleBuffered write SetDoubleBuffered default False;
    property Font: TFont read GetFont write SetFont;
    property DrawOption: K0GridCellDrawOptionSet read FDrawOption write
      SetDrawOption default [k0gcdoRaiseFixedCell, k0gcdoUseReadOnlyColor];
  end;

type
  Ts0MovingMode = class(Ts0GridMode)
  protected
    procedure Activate; override;
    procedure Deactivate; override;
  public
    constructor Create(AGrid: Ts0CustomBindGrid); override;
    function GetNextMode(ATrigger: K0GridModeTrigger; AKey: Word; AShift:
      TShiftState; AButton: TMouseButton; X, Y: Integer): K0GridMode; override;
  end;

type
  Ts0SelectingMode = class(Ts0GridMode)
  protected
    procedure Activate; override;
    procedure Deactivate; override;
  public
    constructor Create(AGrid: Ts0CustomBindGrid); override;
    function GetNextMode(ATrigger: K0GridModeTrigger; AKey: Word; AShift:
      TShiftState; AButton: TMouseButton; X, Y: Integer): K0GridMode; override;
  end;

type
  Ts0EditingMode = class(Ts0GridMode)
  protected
    procedure Activate; override;
    procedure Deactivate; override;
  public
    constructor Create(AGrid: Ts0CustomBindGrid); override;
    function GetNextMode(ATrigger: K0GridModeTrigger; AKey: Word; AShift:
      TShiftState; AButton: TMouseButton; X, Y: Integer): K0GridMode; override;
  end;


type
  Ts0BindGrid = class(Ts0CustomBindGrid)
  published
    property DefaultColWidth;
    property DefaultRowHeight;
    //property DefaultDrawing;
//    property FixedColor;
    property FixedCols;
    property FixedRows;
    property ColCount; //必ずFixedColsより後に宣言
    property RowCount; //必ずFixedRowsより後に宣言
    property GridLineColor;
    property GridLineWidth;
    property Options;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
//    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
//    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property VisibleColCount;
    property VisibleRowCount;
    property OnClick;
    property OnColumnMoved;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawCell;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetEditMask;
    property OnGetEditText;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnRowMoved;
    property OnSelectCell;
    property OnSetEditText;
    property OnStartDock;
    property OnStartDrag;
    property OnTopLeftChanged;
  published
    property BindSeals;
    property Columns;
    property MultiLine;
    property ReadOnlySeals;
  end;

type
  Ts0BindGridDistiller = class(Ts0CtrlDistiller)
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
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

implementation

uses
  s0GraphHelper;

{ Ts0BindingSeal }

procedure Ts0BindingSeal.DrawBindCell;
var
  grd: Ts0CustomBindGrid;
  r: TRect;
  s: TGridDrawState;
  // = set of (gdSelected, gdFocused, gdFixed);
begin
  if not (GetOwnerGrid is Ts0CustomBindGrid) then Exit;
  grd := Ts0CustomBindGrid(GetOwnerGrid);
  if (Left > grd.FixedCols -1) and (Right < grd.LeftCol) then Exit;
  if (Top > grd.FixedRows -1) and (Bottom < grd.TopRow) then Exit;
  r := grd.BoxRect(Left, Top, Right, Bottom);
  s := [];
  if (Top = grd.Col) and (Left = grd.Row) then
    s := s + [gdFocused];
  if (Top < grd.FixedRows) or (Left < grd.FixedCols) then
    s := s + [gdFixed];
  if grd.IsSelected(Left, Top) then
    s := s + [gdSelected];
  grd.CellDrawer.Draw(grd.Canvas, Left, Top, r, s);
end;

function Ts0BindingSeal.IsBaseCell(ACol, ARow: Integer): Boolean;
begin
  Result := (Region.Top = ARow) and (Region.Left = ACol);
end;

function Ts0BindingSeal.IsDrawTarget(ACol, ARow: Integer): Boolean;
begin
  Result := (Region.Bottom = ARow) and (Region.Right = ACol);
end;

{ Ts0BindingSeals }

function Ts0BindingSeals.GetSeals(const Index: Integer): Ts0BindingSeal;
begin
  Result := Ts0BindingSeal( inherited Decorators[Index] );
end;

function Ts0BindingSeals.SealByPos(ACol, ARow: Integer): Ts0BindingSeal;
begin
  Result := Ts0BindingSeal( inherited DecoByPos(ACol, ARow) );
end;

procedure Ts0BindingSeals.SetSeals(const Index: Integer;
  const Value: Ts0BindingSeal);
begin
  inherited Decorators[Index] := Value;
end;

{ Ts0ReadOnlySeal }

procedure Ts0ReadOnlySeal.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

{ Ts0ReadOnlySeals }

function Ts0ReadOnlySeals.GetSeals(const Index: Integer): Ts0ReadOnlySeal;
begin
  Result := Ts0ReadOnlySeal(inherited Decorators[Index]);
end;

procedure Ts0ReadOnlySeals.SetSeals(const Index: Integer;
  const Value: Ts0ReadOnlySeal);
begin
  inherited Decorators[Index] := Value;
end;

{ Ts0GridColumn }

procedure Ts0GridColumn.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0GridColumn) then Exit;
  Self.DefaultValue := Ts0GridColumn(Source).FDefaultValue;
  Self.Title := Ts0GridColumn(Source).Title;
  Self.TitleRow := Ts0GridColumn(Source).TitleRow;
end;

function Ts0GridColumn.GetDisplayName: string;
begin
  Result := Self.Title;
  if Result = '' then
    Result := inherited GetIdentifier;
end;

function Ts0GridColumn.GetIdentifier: string;
begin
  Result := Self.Title;
  if Result = '' then
    Result := inherited GetIdentifier;
end;

function Ts0GridColumn.GetOwnerGrid: Ts0CustomBindGrid;
begin
  if FOwnerGrid = nil then
    if OwnerComponent is Ts0CustomBindGrid then
      FOwnerGrid := Ts0BindGrid(OwnerComponent);
  Result := FOwnerGrid;
end;

function Ts0GridColumn.GetTitle: string;
begin
  Result := FTitle;
  if FTitleRow < 0 then Exit;
  if OwnerGrid = nil then Exit;
  if FTitleRow > OwnerGrid.RowCount -1 then Exit;
  Result := OwnerGrid.Cells[Self.Index, FTitleRow];
end;

function Ts0GridColumn.GetWidth: Integer;
begin
  Result := 0;
  if Self.Index > OwnerGrid.ColCount -1 then Exit;
  Result := OwnerGrid.ColWidths[Self.Index];
end;

procedure Ts0GridColumn.ResetPropToGrid;
begin
  SetTitleToGrid;
end;

procedure Ts0GridColumn.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
  if Collection is Ts0GridColumns then
    Ts0GridColumns(Collection).ResetPropsToGrid;
end;

procedure Ts0GridColumn.SetTitle(const Value: string);
begin
  FTitle := Value;
  SetTitleToGrid;
end;

procedure Ts0GridColumn.SetTitleRow(const Value: Integer);
var
  s: string;
begin
  s := Title;
  SetTitle('');
  FTitleRow := Value;
  Title := s;
end;

procedure Ts0GridColumn.SetTitleToGrid;
begin
  if OwnerGrid = nil then Exit;
  if FTitleRow < 0 then Exit;
  if FTitleRow > OwnerGrid.RowCount -1 then Exit;
  OwnerGrid.InhrSetCells(Self.Index, FTitleRow, FTitle);
end;

procedure Ts0GridColumn.SetWidth(const Value: Integer);
begin
  if Self.Index > OwnerGrid.ColCount -1 then Exit;
  OwnerGrid.ColWidths[Self.Index] := Value;
end;

{ Ts0GridColumns }

function Ts0GridColumns.ColByVirtualIndex(AVirtualIndex: Integer): Ts0GridColumn;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Columns[i].VirtualIndex = AVirtualIndex then
    begin
      Result := Columns[i];
      Exit;
    end;  
end;

function Ts0GridColumns.GetAllColWidth: Integer;
var
  i: Integer;
  lineWidth: Integer;
begin
  Result := 0;
  lineWidth := Ts0CustomBindGrid(OwnerComponent).GridLineWidth;
  for i := 0 to Self.Count -1 do
    Result := Result + Columns[i].Width + lineWidth;
end;

function Ts0GridColumns.GetColumns(const Index: Integer): Ts0GridColumn;
begin
  Result := Ts0GridColumn(inherited Items[Index]);
end;

function Ts0GridColumns.GetRealIndex(AVirtualIndex: Integer): Integer;
var
  col: Ts0GridColumn;
begin
  Result := -1;
  col := ColByVirtualIndex(AVirtualIndex);
  if col = nil then Exit;
  Result := col.Index;
end;

procedure Ts0GridColumns.PrepareColCout(AColCount: Integer);
var
  i: Integer;
  d: Integer;
begin
  d := AColCount - Self.Count;
  if d = 0 then
    Exit;
  if d > 0 then
  begin
    for i := 0 to d - 1 do
      Add;
  end
  else
  begin
    d := Abs(d);
    for i := 0 to d - 1 do
      Self.Delete(Self.Count - 1);
  end;
end;

procedure Ts0GridColumns.ResetPropsToGrid;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Columns[i].ResetPropToGrid;
end;

procedure Ts0GridColumns.SetColumns(const Index: Integer;
  const Value: Ts0GridColumn);
begin
  inherited Items[Index] := Value;
end;

procedure Ts0GridColumns.Update(Item: TCollectionItem);
  function GetVisibleColCount: Integer;
  begin
    Result := Self.Count;
  end;
  procedure AdjustColCount;
  var
    grd: Ts0CustomBindGrid;
  begin
    if not(OwnerComponent is Ts0CustomBindGrid) then Exit;
    grd := Ts0CustomBindGrid(OwnerComponent);
    if [csLoading, csReading, csDestroying] * grd.ComponentState <> [] then Exit;
    if grd.ColCount <> GetVisibleColCount then
      grd.ColCount := GetVisibleColCount;
  end;
begin
  inherited Update(Item);
  AdjustColCount;
  if Item = nil then
    ResetPropsToGrid;
end;

{ Ts0BindGridAccessor }

function Ts0BindGridAccessor.GetAsString: String;
begin
  Result := '';
end;

function Ts0BindGridAccessor.GetGrid: Ts0CustomBindGrid;
begin
  Result := Ts0CustomBindGrid(Owner);
end;

procedure Ts0BindGridAccessor.SetAsString(const Value: String);
begin

end;

{ Ts0GridMode }

procedure Ts0GridMode.ClickOfGrid;
begin
end;

constructor Ts0GridMode.Create(AGrid: Ts0CustomBindGrid);
begin
  inherited Create;
  FGrid := AGrid;
end;

function Ts0GridMode.DidNotMove(AX, AY: Integer): Boolean;
var
  c: TGridCoord;
begin
  c := FGrid.MouseCoord(AX, AY);
  Result := (FGrid.Col = c.X) and (FGrid.Row = c.Y);
end;

class function Ts0GridMode.IsModeKey(k: Word): Boolean;
begin
  Result := k in [VK_F2];
end;

class function Ts0GridMode.IsMoveKey(k: Word): Boolean;
begin
  Result := k in [VK_ESCAPE, VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN];
end;

procedure Ts0GridMode.KeyDownOfGrid(AKey: Word; AShift: TShiftState);
begin
end;

{ Ts0CustomBindGrid }

procedure Ts0CustomBindGrid.BeginUpdateView;
begin
  Inc(FUpdateViewCount);
end;

function Ts0CustomBindGrid.CalcCoordFromPoint(X, Y: Integer;
  const DrawInfo: TGridDrawInfo): TGridCoord;
var
  d: Ts0CellDecorator;
begin
  Result := inherited CalcCoordFromPoint(X, Y, DrawInfo);
  d := FBindSeals.DecoByPos(Result.X, Result.Y);
  if d = nil then Exit;
  Result.X := d.Left;
  Result.Y := d.Top;
end;

function Ts0CustomBindGrid.CanEditShow: Boolean;
begin
  Result := False;
  if FActiveMode.ModeValue <> k0gmEditing then Exit;
  if not IsReadOnly(Col, Row) then
    Result := inherited CanEditShow;
end;

function Ts0CustomBindGrid.CellRectForInplaceEditor(ACol,
  ARow: Integer): TRect;
begin
	Result := CellRect(ACol, ARow); 
end;

procedure Ts0CustomBindGrid.ChangeModeForAT(ATrigger: K0GridModeTrigger;
  AKey: Word; AShift: TShiftState; AButton: TMouseButton; X, Y: Integer);
begin
  if not AutoEditingMode then Exit;
  SetMode( FActiveMode.GetNextMode(ATrigger, AKey, AShift, AButton, X, Y) );
end;

procedure Ts0CustomBindGrid.ClearCol(AColIndex: Integer);
var
  i: Integer;
begin
  if not ValidateColIndex(AColIndex) then Exit;
  BeginUpdateView;
  try
    for i := 0 to Self.RowCount - 1 do
      InhrSetCells(AColIndex, i, '');
  finally
    EndUpdateView;
  end;
end;

procedure Ts0CustomBindGrid.ClearRow(ARowIndex: Integer;
  SetDefault: Boolean);
var
  i: Integer;
begin
  if not ValidateRowIndex(ARowIndex) then Exit;
  BeginUpdateView;
  try
    for i := 0 to Self.ColCount - 1 do
      if SetDefault then
        InhrSetCells(i, ARowIndex, Columns[i].DefaultValue)
      else
        InhrSetCells(i, ARowIndex, '');
  finally
    EndUpdateView;
  end;
end;

procedure Ts0CustomBindGrid.Click;
begin
  inherited;
  FActiveMode.ClickOfGrid;
end;

procedure Ts0CustomBindGrid.ColumnMoved(FromIndex, ToIndex: Integer);
begin
  inherited ColumnMoved(FromIndex, ToIndex);
  FColumns.Columns[FromIndex].Index := ToIndex;
end;

constructor Ts0CustomBindGrid.Create(AOnwer: TComponent);
begin
  FAutoEditingMode := True;
  FMultiLine := True;
  FOptions := [k0goFixedVertLine, k0goFixedHorzLine, k0goVertLine, k0goHorzLine, k0goRangeSelect];
  PrepareModeSet;
  FActiveMode := FModeSet[k0gmMoving];
  inherited Create(AOnwer);
  FAccessor := NewAccessor;
  FCellDrawer := NewDrawer;
  FColumns := NewColums;
  FBindSeals := NewBindSeals;
  FReadOnlySeals := NewReadOnlySeals;
  AddToDecosList(FBindSeals);
  AddToDecosList(FReadOnlySeals);
  inherited DefaultColWidth := 100;
  inherited DefaultRowHeight := 16;
end;

destructor Ts0CustomBindGrid.Destroy;
begin
  RemoveFromDecosList(FBindSeals);
  RemoveFromDecosList(FReadOnlySeals);
  FreeAndNil(FModeSet[k0gmMoving]);
  FreeAndNil(FModeSet[k0gmSelecting]);
  FreeAndNil(FModeSet[k0gmEditing]);
  FreeAndNil(FAccessor);
  FreeAndNil(FReadOnlySeals);
  FreeAndNil(FBindSeals);
  FreeAndNil(FColumns);
  FreeAndNil(FCellDrawer);
  inherited;
end;

procedure Ts0CustomBindGrid.DoChangeCurrent(ANewCol, ANewRow, AOldCol, AOldRow: Integer);
var
  n, o: TGridCoord;
begin
  n.X := ANewCol;
  n.Y := ANewRow;
  o.X := AOldCol;
  o.Y := AOldRow;
  if Assigned(FOnChangeCurrent) then
    FOnChangeCurrent(Self, o, n);
end;

procedure Ts0CustomBindGrid.DoExit;
begin
  inherited DoExit;
//  Invalidate;
end;

procedure Ts0CustomBindGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  d: Ts0BindingSeal;
begin
  d := FBindSeals.SealByPos(ACol, ARow);
  if d <> nil then
  begin
    d.DrawBindCell;
  end
  else
    CellDrawer.Draw(Canvas, ACol, ARow, ARect, AState);
end;

procedure Ts0CustomBindGrid.EndUpdateView;
begin
  Dec(FUpdateViewCount);
  if FUpdateViewCount < 0 then FUpdateViewCount := 0;
  if FUpdateViewCount < 1 then
    Invalidate;
end;

function Ts0CustomBindGrid.GetCellDrawer: Ts0GridCellDrawer;
begin
  Result := FCellDrawer;
end;

function Ts0CustomBindGrid.GetInplaceEdit: TWinControl;
begin
  Result := nil;
end;

function Ts0CustomBindGrid.GetInplaceEditText(
  AControl: TWinControl): string;
begin
  Result := '';
end;

function Ts0CustomBindGrid.GetMode: K0GridMode;
begin
  Result := FActiveMode.ModeValue;
end;

function Ts0CustomBindGrid.GetOldOptions: TGridOptions;
begin
  Result := inherited Options;
end;

procedure Ts0CustomBindGrid.GridRectToScreenRect(GridRect: TGridRect;
  var ScreenRect: TRect; IncludeLine: Boolean);
var
  d: Ts0BindingSeal;
begin
  if csDestroying in Self.ComponentState then Exit;
  if BindSeals = nil then Exit;
  d := BindSeals.SealByPos(GridRect.Right, GridRect.Bottom);
  if d <> nil then
  begin
    GridRect.BottomRight := d.DecoRect.BottomRight;
  end;
  inherited GridRectToScreenRect(GridRect, ScreenRect, IncludeLine);
end;

procedure Ts0CustomBindGrid.HideEdit;
  function FocusIsInplaceEditor: Boolean;
  var
    frm: TCustomForm;
  begin
    Result := False;
    if InplaceEditor = nil then Exit;
    frm := GetParentForm(Self);
    if frm <> nil then
      Result := frm.ActiveControl = InplaceEditor;
  end;
var
  focusMySelf: Boolean;
begin
  focusMySelf := FocusIsInplaceEditor; 
  inherited HideEdit;
  if not focusMySelf then Exit;
  if not Enabled then Exit;
  if not Showing then Exit;
  Self.SetFocus; 
end;

procedure Ts0CustomBindGrid.InhrSetCells(ACol, ARow: Integer;
  const Value: string);
begin
  inherited SetCells(ACol, ARow, Value);
end;

procedure Ts0CustomBindGrid.InhrSetRowCount(const Value: Integer);
begin
  if Value < 0 then Exit;
  if Value < FixedRows + 1 then
  begin
    inherited SetRowCount(FixedRows + 1);
    ClearRow(FixedRows + 1);
  end
  else
    inherited SetRowCount(Value);
end;

procedure Ts0CustomBindGrid.InplaceEditMove(ACol, ARow: Integer);
const
	c9Ctrl3DFrameSize = 2;
var
  r: TRect;
begin
  if InplaceEditor = nil then Exit;
  r := CellRectForInplaceEditor(ACol, ARow);
  InplaceEditor.SetBounds(
    Left + r.Left + c9Ctrl3DFrameSize,
    Top  + r.Top  + c9Ctrl3DFrameSize,
    r.Right - r.Left,
    r.Bottom - r.Top
  );
  if InplaceEditor = nil then Exit;
  //InplaceEditor.Show;
  if not InplaceEditor.Enabled then Exit;
  if not InplaceEditor.Showing then Exit;
  InplaceEditor.SetFocus;
end;

function Ts0CustomBindGrid.IsDrawable(ACol, ARow: Integer): Boolean;
var
  d: Ts0BindingSeal;
begin
  Result := True;
  d := FBindSeals.SealByPos(ACol, ARow);
  if d = nil then Exit;
  if d.IsDrawTarget(ACol, ARow) then Exit;
  Result := False;
end;

function Ts0CustomBindGrid.IsReadOnly(ACol, ARow: Integer): Boolean;
begin
  Result := (FReadOnlySeals.DecoByPos(ACol, ARow) <> nil);
end;

function Ts0CustomBindGrid.IsSelected(ACol, ARow: Integer): Boolean;
begin
  Result := (ARow >= Selection.Top) and (ARow <= Selection.Bottom) and
            (ACol >= Selection.Left) and (ACol <= Selection.Right);
end;

function Ts0CustomBindGrid.IsWordWrapCell(ACol, ARow: Integer): Boolean;
begin
  Result := True;
end;

procedure Ts0CustomBindGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  ancBuf: TGridCoord;

  procedure MoveOnBindCell(AOldCol, AOldRow: Integer);
    procedure SetCol(Value: Integer);
    begin
      if Col = Value then Exit;
      Col := Value;
      if FActiveMode.ModeValue = k0gmSelecting then
        Anchor := ancBuf;
    end;
    procedure SetRow(Value: Integer);
    begin
      if Row = Value then Exit;
      Row := Value;
      if FActiveMode.ModeValue = k0gmSelecting then
        Anchor := ancBuf;
    end;
  var
    bsNew: Ts0BindingSeal;
  begin
    bsNew := BindSeals.SealByPos(Col, Row);
    if bsNew <> nil then
    begin
      if (AOldCol = bsNew.Left) and (AOldRow = bsNew.Top) then
      begin
        if Col > AOldCol then
        begin
          if bsNew.Right + 1 < ColCount then
            SetCol(bsNew.Right + 1);
        end;
        if Row > AOldRow then
        begin
          if bsNew.Bottom + 1 < RowCount then
            SetRow(bsNew.Bottom + 1);
        end;
      end
      else
      begin
        SetCol(bsNew.Left);
        SetRow(bsNew.Top);
      end;
    end;
  end;
var
  oldX, oldY: Integer;
begin
  ChangeModeForAT(k0gmtKeyDown, Key, Shift, mbLeft, 0, 0);
  oldX := Self.Col;
  oldY := Self.Row;
  ancBuf := Anchor;
  inherited KeyDown(Key, Shift);
  MoveOnBindCell(oldX, oldY);
  FActiveMode.KeyDownOfGrid(Key, Shift);
//  Invalidate;
end;

procedure Ts0CustomBindGrid.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  ChangeModeForAT(k0gmtKeyUp, Key, Shift, mbLeft, 0, 0);
end;

procedure Ts0CustomBindGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChangeModeForAT(k0gmtMouseDown, 0, Shift, Button, X, Y);
  inherited MouseDown(Button, Shift, X, Y);
  Invalidate;
end;

procedure Ts0CustomBindGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  //Invalidate;
end;

procedure Ts0CustomBindGrid.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ChangeModeForAT(k0gmtMouseUp, 0, Shift, Button, X, Y);
end;

procedure Ts0CustomBindGrid.MoveCurrent(ACol, ARow: Integer; MoveAnchor,
  Show: Boolean);
var
  oldCol, oldRow: Integer;
begin
  oldCol := Self.Col;
  oldRow := Self.Row;
  inherited MoveCurrent(ACol, ARow, MoveAnchor, Show);
  if (ACol <> oldCol) or (ARow <> oldRow) then
    DoChangeCurrent(ACol, ARow, oldCol, oldRow);
end;

function Ts0CustomBindGrid.NewAccessor: Ts0BindGridAccessor;
begin
  Result := Ts0BindGridAccessor.Create(Self);
end;

function Ts0CustomBindGrid.NewBindSeals: Ts0BindingSeals;
begin
  Result := Ts0BindingSeals.Create(Self, Ts0BindingSeal);
end;

function Ts0CustomBindGrid.NewColums: Ts0GridColumns;
begin
  Result := Ts0GridColumns.Create(Self, Ts0GridColumn);
end;

function Ts0CustomBindGrid.NewDrawer: Ts0GridCellDrawer;
begin
  Result := Ts0GridCellDrawer.Create(Self);
end;

function Ts0CustomBindGrid.NewReadOnlySeals: Ts0ReadOnlySeals;
begin
  Result := Ts0ReadOnlySeals.Create(Self, Ts0ReadOnlySeal);
end;

procedure Ts0CustomBindGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if FColumns <> nil then
    FColumns.Notification(AComponent, Operation);
end;

procedure Ts0CustomBindGrid.Paint;
begin
  if UpdateViewCount < 1 then
    inherited Paint
end;

procedure Ts0CustomBindGrid.PrepareModeSet;
begin
  FModeSet[k0gmMoving   ] := Ts0MovingMode.Create(Self);
  FModeSet[k0gmSelecting] := Ts0SelectingMode.Create(Self);
  FModeSet[k0gmEditing  ] := Ts0EditingMode.Create(Self);
end;


procedure Ts0CustomBindGrid.SetAccessor(const Value: Ts0BindGridAccessor);
begin
  FAccessor.Assign(Value);
end;

procedure Ts0CustomBindGrid.SetBindSeals(const Value: Ts0BindingSeals);
begin
  FBindSeals.Assign(Value);
  Invalidate;
end;

procedure Ts0CustomBindGrid.SetCellDrawer(const Value: Ts0GridCellDrawer);
begin
  FCellDrawer.Assign(Value);
  Invalidate;
end;

procedure Ts0CustomBindGrid.SetColCount(Value: Integer);
begin
  if Value < 0 then Exit;
  if Value < FixedCols + 1 then
  begin
    inherited SetColCount(FixedCols + 1);
    ClearCol(FixedCols + 1);
  end
  else
    inherited SetColCount(Value);
  Columns.PrepareColCout(ColCount);
end;

procedure Ts0CustomBindGrid.SetColumns(const Value: Ts0GridColumns);
begin
  FColumns.Assign(Value);
end;

procedure Ts0CustomBindGrid.SetInplaceEditText(AControl: TWinControl;
  const Value: string);
begin
end;

procedure Ts0CustomBindGrid.SetMode(const Value: K0GridMode);
begin
  if FActiveMode = FModeSet[Value] then Exit;
  FActiveMode.Deactivate;
  FActiveMode := FModeSet[Value];
  FActiveMode.Activate;
end;

procedure Ts0CustomBindGrid.SetMultiLine(const Value: Boolean);
begin
  FMultiLine := Value;
  Invalidate;
end;

procedure Ts0CustomBindGrid.SetOldOptions(const Value: TGridOptions);
begin
  inherited Options := Value;
end;

procedure Ts0CustomBindGrid.SetOptions(const Value: K0GridOptions);
begin
  FOptions := Value;
end;

procedure Ts0CustomBindGrid.SetReadOnlySeals(
  const Value: Ts0ReadOnlySeals);
begin
  FReadOnlySeals.Assign(Value);
end;

procedure Ts0CustomBindGrid.SetRowCount(Value: Integer);
begin
  InhrSetRowCount(Value);
end;

procedure Ts0CustomBindGrid.SizeChanged(OldColCount, OldRowCount: Integer);
begin
  inherited;
  FColumns.PrepareColCout(Self.ColCount);
end;

procedure Ts0CustomBindGrid.TopLeftChanged;
begin
  inherited TopLeftChanged;
  Invalidate;
end;

procedure Ts0CustomBindGrid.UpdateEdit;
begin
  inherited UpdateEdit;
end;

function Ts0CustomBindGrid.ValidateColIndex(AColIndex: Integer): Boolean;
begin
  Result := False;
  if AColIndex < Self.FixedCols then Exit;
  if AColIndex > Self.ColCount -1 then Exit;
  Result := True;
end;

function Ts0CustomBindGrid.ValidateRowIndex(ARowIndex: Integer): Boolean;
begin
  Result := False;
  if ARowIndex < Self.FixedRows then Exit;
  if ARowIndex > Self.RowCount -1 then Exit;
  Result := True;
end;

{ Ts0GridCellDrawer }

procedure Ts0GridCellDrawer.Assign(Source: TPersistent);
begin
  if not (Source is Ts0GridCellDrawer) then Exit;
  FColorSelected := Ts0GridCellDrawer(Source).ColorSelected;
  FDrawOption := Ts0GridCellDrawer(Source).DrawOption;
end;

procedure Ts0GridCellDrawer.Change;
begin
  FOwnerGrid.Invalidate;
end;

constructor Ts0GridCellDrawer.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FDrawOption := [k0gcdoRaiseFixedCell, k0gcdoUseReadOnlyColor];
  if AOwner is Ts0CustomBindGrid then
    FOwnerGrid := Ts0CustomBindGrid(AOwner);
  FColorReadOnly := clBtnFace;
  FColorSelected := clTeal;
end;

destructor Ts0GridCellDrawer.Destroy;
begin
  inherited;
end;

procedure Ts0GridCellDrawer.Draw(ACanvas: TCanvas; ACol, ARow: Integer;
  ARect: TRect; AState: TGridDrawState);
var
	bakFont: TFont;
begin
	bakFont := TFont.Create;
  bakFont.Assign(ACanvas.Font);
  ACanvas.Font.Assign(Self.GetCellFont(ACol, ARow));
	try
    if FOwnerGrid.UpdateViewCount > 0 then Exit;
    SetCanvasColors(ACanvas, ACol, ARow, ARect, AState);
    ACanvas.FillRect(ARect);
    Draw3DFrame(ACanvas, ACol, ARow, ARect, AState);
    DrawText(ACanvas, ACol, ARow, ARect, AState);
    if gdFocused in AState then
      ACanvas.DrawFocusRect(ARect);
  finally
	  ACanvas.Font.Assign(bakFont);
  end;
end;

procedure Ts0GridCellDrawer.Draw3DFrame(ACanvas: TCanvas; ACol,
  ARow: Integer; ARect: TRect; AState: TGridDrawState);
begin
  if not (gdFixed in AState) then Exit;
  if FOwnerGrid.IsSelected(ACol, ARow) then Exit;
  if not (k0gcdoRaiseFixedCell in DrawOption) then Exit;
  DrawEdge(ACanvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT);
end;

procedure Ts0GridCellDrawer.DrawText(ACanvas: TCanvas; ACol, ARow: Integer;
  ARect: TRect; AState: TGridDrawState);
  procedure DrawCellText;
  var
    S: string;
    Options: UINT;
  begin
    S := FOwnerGrid.Cells[ACol, ARow];
    ARect.Left := ARect.Left + 2;
    ARect.Top := ARect.Top + 2;
    // メモの表示で描画
    Options := GetCellDrawOption(ACol, ARow);
    DrawTextEx(ACanvas.Handle, PChar(S),
      Length(S), ARect, Options, nil);
  end;
begin
  if FOwnerGrid.MultiLine then
    DrawCellText
  else
    ACanvas.TextRect(ARect, ARect.Left + 2, ARect.Top + 2,
      FOwnerGrid.Cells[ACol, ARow]);
end;

function Ts0GridCellDrawer.GetCellDrawOption(ACol, ARow: Integer): UINT;
begin
  Result := DT_EDITCONTROL;
  if FOwnerGrid.IsWordWrapCell(ACol, ARow) then
    Result := Result or DT_WORDBREAK;
end;

function Ts0GridCellDrawer.GetCellFont(ACol, ARow: Integer): TFont;
begin
	Result := Self.Font;
end;

function Ts0GridCellDrawer.GetColor: TColor;
begin
  Result := FOwnerGrid.Color;
end;

function Ts0GridCellDrawer.GetColorFixed: TColor;
begin
  Result := FOwnerGrid.FixedColor;
end;

function Ts0GridCellDrawer.GetDoubleBuffered: Boolean;
begin
  Result := FOwnerGrid.DoubleBuffered;
end;

function Ts0GridCellDrawer.GetFont: TFont;
begin
  Result := FOwnerGrid.Font;
end;

procedure Ts0GridCellDrawer.SetCanvasColors(ACanvas: TCanvas; ACol, ARow:
  Integer;
  ARect: TRect; AState: TGridDrawState);
var
  brsh: TBrush;
begin
  brsh := ACanvas.Brush;
  if gdFixed in AState then
  begin
    if brsh.Color <> ColorFixed then brsh.Color := ColorFixed;
  end
  else if FOwnerGrid.IsSelected(ACol, ARow) then
  begin
    if brsh.Color <> ColorSelected then brsh.Color := ColorSelected;
  end
  else
  if (k0gcdoUseReadOnlyColor in DrawOption) and FOwnerGrid.IsReadOnly(ACol, ARow) then
  begin
    if brsh.Color <> ColorReadOnly then brsh.Color := ColorReadOnly;
  end
  else
  begin
    if brsh.Color <> Color then brsh.Color := Color;
  end;
end;

procedure Ts0GridCellDrawer.SetColor(const Value: TColor);
begin
  FOwnerGrid.Color := Value;
end;

procedure Ts0GridCellDrawer.SetColorFixed(const Value: TColor);
begin
  FOwnerGrid.FixedColor := Value;
end;

procedure Ts0GridCellDrawer.SetColorReadOnly(const Value: TColor);
begin
  FColorReadOnly := Value;
  Change;
end;

procedure Ts0GridCellDrawer.SetColorSelected(const Value: TColor);
begin
  FColorSelected := Value;
  Change;
end;

procedure Ts0GridCellDrawer.SetDoubleBuffered(const Value: Boolean);
begin
  FOwnerGrid.DoubleBuffered := Value;
end;

procedure Ts0GridCellDrawer.SetDrawOption(
  const Value: K0GridCellDrawOptionSet);
begin
  FDrawOption := Value;
  FOwnerGrid.Invalidate;
end;

procedure Ts0GridCellDrawer.SetFont(const Value: TFont);
begin
  FOwnerGrid.Font := Value;
end;

{ Ts0MovingMode }

procedure Ts0MovingMode.Activate;
begin
  FGrid.OldOptions := FGrid.OldOptions - [goEditing];
  FGrid.HideEditor;
end;

constructor Ts0MovingMode.Create(AGrid: Ts0CustomBindGrid);
begin
  inherited Create(AGrid);
  FModeValue := k0gmMoving;
end;

procedure Ts0MovingMode.Deactivate;
begin
end;

function Ts0MovingMode.GetNextMode(ATrigger: K0GridModeTrigger; AKey: Word;
  AShift: TShiftState; AButton: TMouseButton; X, Y: Integer): K0GridMode;
begin
  Result := FModeValue;
  case ATrigger of
    k0gmtKeyDown  :
      if IsMoveKey(AKey) then
      begin
        if [ssCtrl, ssShift] * AShift <> [] then
          Result := k0gmSelecting;
      end
      else
      if not(AKey in [VK_BACK, VK_TAB, VK_CLEAR, VK_INSERT, VK_DELETE]) then 
      begin
        Result := k0gmEditing;
      end;
    k0gmtKeyUp    : ;
    k0gmtMouseDown:
      if [ssShift, ssCtrl] * AShift <> [] then
        Result := k0gmSelecting
      else
      if (AButton = mbLeft) and DidNotMove(X, Y) then
        Result := k0gmEditing;
    k0gmtMouseUp  : ;
    k0gmtOther    : ;
  end;
end;

{ Ts0SelectingMode }

procedure Ts0SelectingMode.Activate;
begin
  FGrid.OldOptions := FGrid.OldOptions - [goEditing];
  FGrid.HideEditor;
end;

constructor Ts0SelectingMode.Create(AGrid: Ts0CustomBindGrid);
begin
  inherited Create(AGrid);
  FModeValue := k0gmSelecting;
end;

procedure Ts0SelectingMode.Deactivate;
begin
end;

function Ts0SelectingMode.GetNextMode(ATrigger: K0GridModeTrigger;
  AKey: Word; AShift: TShiftState; AButton: TMouseButton; X, Y: Integer): K0GridMode;
begin
  Result := FModeValue;
  case ATrigger of
    k0gmtKeyDown  : ;
    k0gmtKeyUp    :
      if [ssShift, ssCtrl] * AShift = [] then
        Result := k0gmMoving;
    k0gmtMouseDown: ;
    k0gmtMouseUp  :
      if [ssShift, ssCtrl] * AShift = [] then
        Result := k0gmMoving;
    k0gmtOther    : ;
  end;
end;

{ Ts0EditingMode }

procedure Ts0EditingMode.Activate;
begin
  FGrid.OldOptions := FGrid.OldOptions + [goEditing];
  FGrid.ShowEditor;
end;

constructor Ts0EditingMode.Create(AGrid: Ts0CustomBindGrid);
begin
  inherited Create(AGrid);
  FModeValue := k0gmEditing;
end;

procedure Ts0EditingMode.Deactivate;
begin
end;

function Ts0EditingMode.GetNextMode(ATrigger: K0GridModeTrigger; AKey: Word;
  AShift: TShiftState; AButton: TMouseButton; X, Y: Integer): K0GridMode;
begin
  Result := FModeValue;
  case ATrigger of
    k0gmtKeyDown  :
      if IsMoveKey(AKey) or IsModeKey(AKey) then
        Result := k0gmMoving;
    k0gmtKeyUp    : ;
    k0gmtMouseDown:
      if not DidNotMove(X, Y)  then
        Result := k0gmMoving;
    k0gmtMouseUp  : ;
    k0gmtOther    : ;
  end;
end;

{ Ts0BindGridDistiller }

class procedure Ts0BindGridDistiller.Click(AControl: TObject);
begin
  Ts0CustomBindGrid(AControl).Click;
end;

class function Ts0BindGridDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomBindGrid(AControl).Accessor;
end;

class function Ts0BindGridDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0CustomBindGrid(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomBindGrid(AControl).OnExit ;
end;

class function Ts0BindGridDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0CustomBindGrid(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomBindGrid(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomBindGrid(AControl).OnKeyUp   ;
  Result.FOnChange   := nil;
end;

class function Ts0BindGridDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0CustomBindGrid(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0CustomBindGrid(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0CustomBindGrid(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomBindGrid(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomBindGrid(AControl).OnMouseUp  ;
end;

class function Ts0BindGridDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CustomBindGrid(AControl).OnCanResize;
  Result.FOnResize    := Ts0CustomBindGrid(AControl).OnResize   ;
end;

class function Ts0BindGridDistiller.GetTitle(AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0BindGridDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnExit, k0cetOnPressEnter];
end;

class function Ts0BindGridDistiller.GetValue(AControl: TObject): string;
begin
  Result := GetAccessor(AControl).AsString;
end;

class function Ts0BindGridDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CustomBindGrid;
end;

class procedure Ts0BindGridDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0CustomBindGrid(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0BindGridDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomBindGrid(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0BindGridDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomBindGrid(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomBindGrid(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0BindGridDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomBindGrid(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomBindGrid(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomBindGrid(AControl).OnKeyUp    := Value.FOnKeyUp   ;
end;

class procedure Ts0BindGridDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomBindGrid(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomBindGrid(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomBindGrid(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomBindGrid(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomBindGrid(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0BindGridDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomBindGrid(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomBindGrid(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0BindGridDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
end;

class procedure Ts0BindGridDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  GetAccessor(AControl).AsString := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0BindGridDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0BindGridDistiller);

end.
