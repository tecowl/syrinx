unit s0CtrlGrid;
{
$History: s0CtrlGrid.pas $
 * 
 * *****************  Version 46  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 45  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 44  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 43  *****************
 * User: Akima        Date: 02/02/14   Time: 21:51
 * Updated in $/source/D5Integrated
 * Ts0CtrlDecoratorにOnClick、OnDblClick、OnEnter、OnExitを追加。
 * また、セルに割り当てられているコントロールがコンボボックスなどであった
 * 場合、
 * 上下キーでセルを移動しないように修正。
 * 
 * *****************  Version 42  *****************
 * User: Akima        Date: 02/02/06   Time: 1:02
 * Updated in $/source/D5Integrated
 * NotificationでFCurCtrlがFreeされたときにnilクリアする処理を追加。
 * T9CtrlDecoListener.UpdateCellValueでセルの値を更新するときに、InhrSetCe
 * llsではなくSetCellsを使用するように変更
 * 
 * *****************  Version 41  *****************
 * User: Akima        Date: 02/02/05   Time: 4:28
 * Updated in $/source/D5Integrated
 * Ts0CustomCtrlGrid.InplaceEditMoveで、InplaceEditが存在しないときに、そ
 * れを
 * 生成するように条件文にnilチェックを加えた。
 * 
 * *****************  Version 40  *****************
 * User: Akima        Date: 02/01/10   Time: 3:13
 * Updated in $/source/D5Integrated
 * 余計な処理を行っていたTs0CGEditingMode.KeyDownOfGridの実装をコメントアウ
 * ト
 * 
 * *****************  Version 39  *****************
 * User: Akima        Date: 02/01/08   Time: 15:14
 * Updated in $/source/D5Integrated
 * 実行時に動的にグリッドを生成すると、Loadedメソッドが呼ばれないために
 * InitDefaultEditorメソッドも呼ばれない。
 * 仕方ないのでCMShowingChangedメソッドで表示されたときにInitDefaultEditor
 * メソッドを呼び出すようにした。
 * 
 * *****************  Version 38  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 37  *****************
 * User: Akima        Date: 02/01/06   Time: 0:19
 * Updated in $/source/D5Integrated
 * DoubleBufferedをpublishedに。
 * 固定セルでもコントロールを描画するようにした
 * 
 * *****************  Version 36  *****************
 * User: Akima        Date: 01/12/10   Time: 17:39
 * Updated in $/source/D5Integrated
 * 大リファクタリング後、グリッドがやーっと安定しました。
 * 
 * *****************  Version 35  *****************
 * User: Akima        Date: 01/12/10   Time: 16:15
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 33  *****************
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
 * *****************  Version 32  *****************
 * User: Akima        Date: 01/12/07   Time: 14:36
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 01/12/06   Time: 20:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 29  *****************
 * User: Akima        Date: 01/11/23   Time: 6:23
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 01/11/22   Time: 18:39
 * Updated in $/source/D5Integrated
 * 「チェックボックスが割り当てられているセルの隣のセルにFalseやＴｒｕｅ
 * と表示されることがある。セルの移動時に発生する」というバグを修正。
 * Ts0CtrlDecorator.SaveToCtrlとLoadFromCtrlが、デコの範囲外では無効
 * になるようにチェックを加えた。
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 01/11/13   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 01/11/02   Time: 14:17
 * Updated in $/source/D5Integrated
 * SetFovusを設計時に呼び出さないように修正。
 * Ts0CtrlDecorator.FreeCtrlで余計な処理をしているのでコメントアウト（実は
 * 自信が無い。）
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 01/10/30   Time: 1:08
 * Updated in $/source/D5Integrated
 * ShowControlメソッドでコントロールにSetFocusするようにした。
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 01/10/24   Time: 5:17
 * Updated in $/source/D5Integrated
 * 使用するコントロールに対してFreeNotificationするようにした
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 01/10/22   Time: 9:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/10/11   Time: 17:21
 * Updated in $/source/D5Integrated
 * ColCount,RowCount,FixedCols,FixedRowsのpublishedでの宣言の順番を変更
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/10/03   Time: 0:25
 * Updated in $/source/D5Integrated
 * ChangingForAutoEditingメソッドをoverride。
 * AddToDecosList、RemoveFromDecosListを使用するようにした。
 * ShowControlsプロパティを削除。
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/10/01   Time: 9:10
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/09/30   Time: 2:31
 * Updated in $/source/D5Integrated
 * Ts0CtrlGridDrawer.DrawControlメソッドで、コントロール描画の前に
 * 色を指定してなかったのでその処理を追加。
 *
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/09/28   Time: 15:54
 * Updated in $/source/D5Integrated
 * SelectCellのoverrideをやめて、DoChangeCurrentをoverrideした。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/09/27   Time: 9:13
 * Updated in $/source/D5Integrated
 * Ts0CtrlDecorator.GridKeyDownでControlプロパティのnilチェックを行うように
 * した
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/09/25   Time: 10:07
 * Updated in $/source/D5Integrated
 * Ts0CtrlDecoratorsにAddメソッドを追加
 *
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/09/18   Time: 11:53
 * Updated in $/source/D5Integrated
 * ColumnMoved、RowMoved、NotificationなどでのDecoratorsを呼び出しを
 * Ts0BindGridだけで行うように修正
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/09/13   Time: 23:30
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 *
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/09/07   Time: 3:05
 * Updated in $/source/D5Integrated
 * キー操作、マウス操作の不備を修正
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/06   Time: 21:21
 * Updated in $/source/D5Integrated
 * コントロールの値に変更があったときにCellにそれを反映するようにした
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0grid
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0grid
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0control/p0grid
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/08   Time: 18:37
 * Updated in $/source/p0control/p0grid
 * R0KeyEvents.FOnChange追加対応
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 14:20
 * Updated in $/source/p0control/p0grid
 * 削除したｃ0LogManagerをusesしていたので、usesから削除した。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/31   Time: 0:00
 * Updated in $/source/p0control/p0grid
 * バグが取れなーい！
 * とりあえず、ログに出力するようにした。
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/30   Time: 21:33
 * Updated in $/source/p0control/p0grid
 * Ts0CtrlGridが実装していた機能をできるだけ別のクラスに実装するようにリフ
 * ァクタリング
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/30   Time: 12:15
 * Created in $/source/p0control/p0grid
 * 新規作成
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, 
  StdCtrls,
  s0Collection,
  s0CtrlDistiller,
  s0CtrlEventSnatcher,
  s0GridCellControl,
  s0CellDecorator,
  s0Grids,
  s0BindGrid; 

type
  K0GridCtrlEvent = procedure(Sender: TObject; ACol, ARow: Integer; var Value: string) of object;

type
  Ts0CGMovingMode = class(Ts0MovingMode)
  public
    procedure ClickOfGrid; override;
  end;

  Ts0CGSelectingMode = class(Ts0SelectingMode)
  public
    procedure ClickOfGrid; override;
  end;

  Ts0CGEditingMode = class(Ts0EditingMode)
  private
  protected
  public
    procedure KeyDownOfGrid(AKey: Word; AShift: TShiftState); override;
    procedure ClickOfGrid; override;
  end;

type
  K0CtrlDecoEvent = procedure(Sender: TObject; ACtrl: TWinControl; ACol, ARow: Integer) of object;
  K0CtrlDecoEventKind = (k0cdekClick, k0cdekDblClick, k0cdekEnter, k0cdekExit);

type
  Ts0CustomCtrlGrid = class;

  {
  	セルにコントロールを表示するデコレータ。
  }
  Ts0CtrlDecorator = class(Ts0CellDecorator)
  private
    FControl: TWinControl;
    FOwnerGrid: Ts0CustomCtrlGrid;
    FOnLoadFromCtrl: K0GridCtrlEvent;
    FOnSaveToCtrl: K0GridCtrlEvent;
    FFreeWithCtrl: Boolean;
    FListener: Ts0CtrlEventListener;
    FListenerNotified: Boolean;
    FUpdateEventKinds: K0CtrlEventTypeSet;
    FCtrlEvents: array[K0CtrlDecoEventKind] of K0CtrlDecoEvent;
    procedure SetControl(const Value: TWinControl);
    procedure FreeCtrl;
    function GetCtrlDecoEvents(const Index: Integer): K0CtrlDecoEvent;
    procedure SetCtrlDecoEvents(const Index: Integer;
      const Value: K0CtrlDecoEvent);
  protected
    procedure DoCtrlDecoEvent(AKind: K0CtrlDecoEventKind);
    procedure CtrlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
  protected
    FIsDefaultEditor: Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetDisplayName: string; override; //TCollectionItem virtual method.
  protected
    procedure OverrideCtrlEvent; virtual;
    procedure PutCtrlEventBack; virtual;
    function GetDataFromCtrl: string;
    procedure SetDataToCtrl(AData: string);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CanDecorate(ACol, ARow: Integer): Boolean; override;
    property FreeWithCtrl: Boolean read FFreeWithCtrl write FFreeWithCtrl default False;
  published
  	{ 表示されるコントロール。 }
    property Control: TWinControl read FControl write SetControl;
    { コントロールの内容からセルに反映させるためのイベントを指定する。 }
    property UpdateEventKinds: K0CtrlEventTypeSet read FUpdateEventKinds write FUpdateEventKinds default [];
    property OnLoadFromCtrl: K0GridCtrlEvent read FOnLoadFromCtrl write FOnLoadFromCtrl;
    property OnSaveToCtrl: K0GridCtrlEvent read FOnSaveToCtrl write FOnSaveToCtrl;
    property OnClick   : K0CtrlDecoEvent index 1 read GetCtrlDecoEvents write SetCtrlDecoEvents;
    property OnDblClick: K0CtrlDecoEvent index 2 read GetCtrlDecoEvents write SetCtrlDecoEvents;
    property OnEnter   : K0CtrlDecoEvent index 3 read GetCtrlDecoEvents write SetCtrlDecoEvents;
    property OnExit    : K0CtrlDecoEvent index 4 read GetCtrlDecoEvents write SetCtrlDecoEvents;
  end;

  Ts0CtrlDecorators = class(Ts0CellDecorators)
  private
    function GetItems(const Index: Integer): Ts0CtrlDecorator;
    procedure SetItems(const Index: Integer; const Value: Ts0CtrlDecorator);
    function GetDefaultEditor: Ts0CtrlDecorator;
  public
    function Add(ACtrl: TWinControl): Ts0CtrlDecorator;
    property DefaultEditor: Ts0CtrlDecorator read GetDefaultEditor;
    function FindControl(ACol, ARow: Integer): TWinControl;
    procedure HideControls;
    function ItemByCtrl(AControl: TWinControl): Ts0CtrlDecorator;
    function ItemByPos(ACol, ARow: Integer): Ts0CtrlDecorator;
    procedure InitDefaultEditor;
    procedure OverrideCtrlEvent;
    property Items[const Index: Integer]: Ts0CtrlDecorator read GetItems write SetItems; default;
  end;

  Ts0CustomCtrlGrid = class(Ts0CustomBindGrid)
  private
    FCtrlDecos: Ts0CtrlDecorators;
    FCurCtrl: TWinControl;
    FInplaceEditorLoaded: Boolean;
    procedure SetCtrlDecos(const Value: Ts0CtrlDecorators);
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
  protected
    function NewCtrlDecos: Ts0CtrlDecorators; virtual;
    function NewDrawer: Ts0GridCellDrawer; override;
    procedure PrepareModeSet; override;
  public
    function GetInplaceEdit: TWinControl; override;
  protected
    function GetInplaceEditText(AControl: TWinControl): string; override;
    procedure InplaceEditorMoveTo(ACol, ARow: Integer); override;
    procedure InplaceEditMove(ACol, ARow: Integer); override;
    procedure SetInplaceEditText(AControl: TWinControl; const Value: string); override;
    procedure UpdateEdit; override;
  protected
    procedure ColWidthsChanged; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
  	{ セルにコントロールを表示させるデコレータのコレクション。
    	Ts0CtrlDecoratorsを参照。 }
    property CtrlDecos: Ts0CtrlDecorators read FCtrlDecos write SetCtrlDecos;
  end;

type
  Ts0CtrlGridDrawer = class(Ts0GridCellDrawer)
  protected
    procedure DrawCellBtn(ACanvas: TCanvas; ARect: TRect; AButton: TButton; Focus, Down: Boolean);
    function DrawControl(ACanvas: TCanvas; ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState; ACtrl: TWinControl): Boolean;
  public
    procedure Draw(ACanvas: TCanvas; ACol, ARow: Longint;
      ARect: TRect; AState: TGridDrawState); override;
  end;


type
  Ts0CtrlGrid = class(Ts0CustomCtrlGrid)
  published
    property DefaultColWidth;
    property DefaultRowHeight;
    //property DefaultDrawing;
    property FixedColor;
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
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
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
  published
    property CtrlDecos;
  end;

implementation

uses
  Forms,
  s0Edit,
  s0ComponentHelper,
  s0ControlHelper,
  s0VCLStdCtrlsDistiller,
  s0GraphHelper,
  s0TypInfoWrapper,
  Buttons,
  ExtCtrls
  ;

type
  T9CtrlDecoListener = class(Ts0CtrlEventListener)
  private
    FInUpdate: Boolean;
    FOwnerDeco: Ts0CtrlDecorator;
    procedure UpdateCellValue;
  public
    constructor Create(ADeco: Ts0CtrlDecorator);
    procedure CtrlOnChange(Sender: TObject); override;
    procedure CtrlOnClick(Sender: TObject); override;
    procedure CtrlOnDblClick(Sender: TObject); override;
    procedure CtrlOnEnter(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
    procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); override;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnResize(Sender: TObject); override;
  end;

{ T9CtrlDecoListener }

constructor T9CtrlDecoListener.Create(ADeco: Ts0CtrlDecorator);
begin
  inherited Create;
  FOwnerDeco := ADeco;
end;

procedure T9CtrlDecoListener.CtrlOnChange(Sender: TObject);
begin
  if k0cetOnChange in FOwnerDeco.UpdateEventKinds then
    UpdateCellValue;
end;

procedure T9CtrlDecoListener.CtrlOnClick(Sender: TObject);
begin
  if k0cetOnClick in FOwnerDeco.UpdateEventKinds then
    UpdateCellValue;
  FOwnerDeco.DoCtrlDecoEvent(k0cdekClick);
end;

procedure T9CtrlDecoListener.CtrlOnDblClick(Sender: TObject);
begin
  FOwnerDeco.DoCtrlDecoEvent(k0cdekDblClick);
end;

procedure T9CtrlDecoListener.CtrlOnEnter(Sender: TObject);
begin
  FOwnerDeco.DoCtrlDecoEvent(k0cdekEnter);
end;

procedure T9CtrlDecoListener.CtrlOnExit(Sender: TObject);
begin
  if k0cetOnExit in FOwnerDeco.UpdateEventKinds then
    UpdateCellValue;
  FOwnerDeco.DoCtrlDecoEvent(k0cdekExit);
end;

procedure T9CtrlDecoListener.CtrlOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FOwnerDeco.CtrlKeyDown(Sender, Key, Shift);
end;

procedure T9CtrlDecoListener.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (k0cetOnPressEnter in FOwnerDeco.UpdateEventKinds) and (Key = #$D) then
    UpdateCellValue;
end;

procedure T9CtrlDecoListener.CtrlOnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if k0cetOnKeyUp in FOwnerDeco.UpdateEventKinds then
    UpdateCellValue;
end;

procedure T9CtrlDecoListener.CtrlOnResize(Sender: TObject);
begin
  FOwnerDeco.InvalidateGrid;
end;

procedure T9CtrlDecoListener.UpdateCellValue;
var
  grd: Ts0CustomCtrlGrid;
  s: string;
begin
  if FInUpdate then Exit;
  FInUpdate := True;
  try
    if not(FOwnerDeco.GetOwnerGrid is Ts0CustomCtrlGrid) then Exit;
    grd := Ts0CustomCtrlGrid(FOwnerDeco.GetOwnerGrid);
    s := FOwnerDeco.GetDataFromCtrl;
    if grd.Cells[grd.Col, grd.Row] <> s then
      grd.SetCells(grd.Col, grd.Row, s);
  finally
    FInUpdate := False;
  end;
end;

{ Ts0CGMovingMode }

procedure Ts0CGMovingMode.ClickOfGrid;
begin
end;

{ Ts0CGSelectingMode }

procedure Ts0CGSelectingMode.ClickOfGrid;
begin
end;

{ Ts0CGEditingMode }

procedure Ts0CGEditingMode.ClickOfGrid;
var
  ctrl: TWinControl;
begin
  ctrl := FindVCLWindow(Mouse.CursorPos);
  if ctrl = nil then Exit;
  if ctrl = FGrid then Exit;
  Ts0CtrlDistillBroker.Click(ctrl);
end;

procedure Ts0CGEditingMode.KeyDownOfGrid(AKey: Word; AShift: TShiftState);
//var
//  grd: Ts0CustomCtrlGrid;
begin
{
  if not(FGrid is Ts0CustomCtrlGrid) then Exit;
  if IsModeKey(AKey) then Exit;
  grd := Ts0CustomCtrlGrid(FGrid);
  if grd.FCurCtrl = nil then Exit;
  if (grd.FCurCtrl is TCustomComboBox) and TCustomComboBox(grd.FCurCtrl).DroppedDown then
  begin
  end
  else
  if not IsMoveKey(AKey) then
    ;
    //PostMessage(grd.FCurCtrl.Handle, WM_KEYDOWN, AKey, 0);
}
end;

{ Ts0CtrlDecorator }

procedure Ts0CtrlDecorator.Assign(Source: TPersistent);
  function GetCtrlOnForm(AControlName: string): TWinControl;
  var
    i: Integer;
    lOwner: TComponent;
  begin
    Result := nil;
    lOwner := Self.OwnerComponent.Owner;
    if lOwner = nil then Exit;
    for i := 0 to lOwner.ComponentCount -1 do
      if lOwner.Components[i].Name = AControlName then
        if lOwner.Components[i] is TWinControl then
          Result := TWinControl(lOwner.Components[i]);
  end;
begin
  inherited;
  if not(Source is Ts0CtrlDecorator) then Exit;
  {
    Controlプロパティについて。
    Sourceが同じフォーム上のものなら、同じコントロールを参照する。
    Sourceが別のフォームのものなら、同じ名前のコントロールを探して、
    それを参照する。見つからなかった場合はnil。
  }
  if Ts0CtrlDecorator(Source).OwnerComponent.Owner = Self.OwnerComponent.Owner then
  begin
    Self.Control := Ts0CtrlDecorator(Source).Control;
  end
  else
  begin
    if Ts0CtrlDecorator(Source).Control = nil then
      Self.Control := nil
    else
      Self.Control := GetCtrlOnForm( Ts0CtrlDecorator(Source).Control.Name );
  end;
end;

function Ts0CtrlDecorator.CanDecorate(ACol, ARow: Integer): Boolean;
begin
  Result := inherited CanDecorate(ACol, ARow) and (Control <> nil);
end;

constructor Ts0CtrlDecorator.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FUpdateEventKinds := [];
  FFreeWithCtrl := False;
  FOwnerGrid := nil;
  if GetOwnerGrid is Ts0CustomCtrlGrid then
    FOwnerGrid := Ts0CustomCtrlGrid(GetOwnerGrid);
  if FOwnerGrid = nil then
    raise Exception.Create('Illegal CtrlDecorator');
end;

procedure Ts0CtrlDecorator.CtrlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  function IsNotifyKeyEvent(var Key: Word; Shift: TShiftState): Boolean;
    function ForwardMovement: Boolean;
    begin
      Result := goAlwaysShowEditor in FOwnerGrid.OldOptions;
    end;
    function Ctrl: Boolean;
    begin
      Result := ssCtrl in Shift;
    end;

    type
      R9EditInfo = packed record
        FStartPos: Integer;
        FEndPos: Integer;
        FTextLength: Integer;
      end;

    function Selection: R9EditInfo;
    begin
      FillChar(Result, SizeOf(Result), 0);
      if not(Sender is TCustomEdit) then Exit;
      SendMessage( TCustomEdit(Sender).Handle, EM_GETSEL, Longint(@Result.FStartPos), Longint(@Result.FEndPos));
      Result.FTextLength := Length(TCustomEdit(Sender).Text);
    end;
    function RightSide: Boolean;
    var
      s: R9EditInfo;
    begin
      s := Selection;
      Result := ((s.FStartPos = 0) or (s.FEndPos = s.FStartPos)) and
        (s.FEndPos = s.FTextLength);
    end;
    function LeftSide: Boolean;
    var
      s: R9EditInfo;
    begin
      s := Selection;
      Result := (s.FStartPos = 0) and ((s.FEndPos = 0) or (s.FEndPos = s.FTextLength));
    end;
    function ChangeEditorModeF2: Boolean;
    var
      edt: TCustomEdit;
    begin
      Result := True;
      if not(Sender is TCustomEdit) then Exit;
      edt := TCustomEdit(Sender);
      if edt.SelLength = 0 then
        Exit
      else
      if edt.SelLength = Length(edt.Text) then
      begin
        edt.SelLength := 0;
        edt.SelStart := Length(edt.Text);
      end
      else
      begin
        edt.SelStart := 0; 
        edt.SelLength := Length(edt.Text);
      end;
      Result := False;
    end;
    function IsSelectable(ACtrl: TControl): Boolean;
    begin
      Result := True;
      if ACtrl is TCustomComboBox then Exit;
      if ACtrl is TCustomListBox then Exit;
      if ACtrl is TCustomRadioGroup then Exit;
      Result := False;
    end;
  begin
    Result := True;
    case Key of
      VK_UP, VK_DOWN:
        begin
          if not(Sender is TControl) then Exit;
          if not IsSelectable(TControl(Sender)) then Exit;
        end;
      VK_PRIOR, VK_NEXT, VK_ESCAPE: Exit;
      VK_LEFT: if Ctrl or LeftSide then Exit;
      VK_RIGHT: if Ctrl or RightSide then Exit;
      VK_HOME: if Ctrl or LeftSide then Exit;
      VK_END: if Ctrl or RightSide then Exit;
      VK_F2:
        begin
          Result := ChangeEditorModeF2;
          Exit;
        end;
      VK_TAB: if not (ssAlt in Shift) then Exit;
    end;
    Result := False;
  end;
begin
  if FListenerNotified then Exit;
  FListenerNotified := True;
  try
//    FOwnerGrid.ChangeModeForAT(k0gmtKeyDown, Key, Shift, 0, 0);
    if not(FOwnerGrid is Ts0CustomCtrlGrid) then Exit;
    if IsNotifyKeyEvent(Key, Shift) then
      FOwnerGrid.KeyDown(Key, Shift);
  finally
    FListenerNotified := False;
  end;
end;

destructor Ts0CtrlDecorator.Destroy;
begin
  if FFreeWithCtrl then
    FreeCtrl;
  inherited Destroy;
end;

procedure Ts0CtrlDecorator.FreeCtrl;
begin
  if FControl = nil then Exit;
  FreeAndNil(FControl);
end;

function Ts0CtrlDecorator.GetDisplayName: string;
begin
  if Control = nil then
    Result := inherited GetDisplayName
  else
    Result := Control.Name;
end;

procedure Ts0CtrlDecorator.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FControl = AComponent then
    FControl := nil;
end;

procedure Ts0CtrlDecorator.OverrideCtrlEvent;
begin
  if FControl = nil then Exit;
  if FListener <> nil then Exit;
  FListener := T9CtrlDecoListener.Create(Self);
  Ts0CtrlEventSnatcher.Instance.RegisterListener(FControl, FListener);
end;

procedure Ts0CtrlDecorator.PutCtrlEventBack;
begin
  if FControl = nil then Exit;
  if FListener = nil then Exit;
  Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FListener);
  FreeAndNil(FListener);
end;

procedure Ts0CtrlDecorator.SetControl(const Value: TWinControl);
begin
  if FControl = Value then Exit;
  if (Value <> nil) and (not Ts0CtrlDistillBroker.IsTarget(Value)) then Exit;
  if FControl <> nil then
    FControl.RemoveFreeNotification(OwnerComponent);
  if [csLoading, csReading, csDestroying, csDesigning] * OwnerComponent.ComponentState = [] then
    PutCtrlEventBack;
  if (FControl <> nil) and FFreeWithCtrl then FreeCtrl;
  //
  FControl := Value;
  if FControl <> nil then
  begin
    if FControl.Owner <> Self.OwnerComponent.Owner then
      FControl.FreeNotification(OwnerComponent);
    FUpdateEventKinds := Ts0CtrlDistillBroker.GetUpdateEvents(FControl);
  end;
  if [csLoading, csReading, csDestroying, csDesigning] * OwnerComponent.ComponentState = [] then
    OverrideCtrlEvent;
  
  InvalidateGrid;
end;

function Ts0CtrlDecorator.GetDataFromCtrl: string;
begin
  Result := '';
  if FControl = nil then Exit;
  try
    Result := Ts0CtrlDistillBroker.GetValue(FControl);
  except
  end;
end;

procedure Ts0CtrlDecorator.SetDataToCtrl(AData: string);
begin
  if FControl = nil then Exit;
  try
    Ts0CtrlDistillBroker.SetValue(AData, FControl);
  except
  end;
end;

const
  c9CtrlDecoEventIndexToKind: array[1..4] of K0CtrlDecoEventKind = (
    k0cdekClick, k0cdekDblClick, k0cdekEnter, k0cdekExit
  );

function Ts0CtrlDecorator.GetCtrlDecoEvents(const Index: Integer): K0CtrlDecoEvent;
begin
  Result := FCtrlEvents[ c9CtrlDecoEventIndexToKind[Index] ];
end;

procedure Ts0CtrlDecorator.SetCtrlDecoEvents(const Index: Integer;
  const Value: K0CtrlDecoEvent);
begin
  FCtrlEvents[ c9CtrlDecoEventIndexToKind[Index] ] := Value;
end;

procedure Ts0CtrlDecorator.DoCtrlDecoEvent(AKind: K0CtrlDecoEventKind);
var
  grd: Ts0CustomCtrlGrid;
begin
  if not Assigned(FCtrlEvents[AKind]) then Exit;
  if not(GetOwnerGrid is Ts0CustomCtrlGrid) then Exit;
  grd := Ts0CustomCtrlGrid(GetOwnerGrid);
  FCtrlEvents[AKind](Self, FControl, grd.FInplaceCol, grd.FInplaceRow);
end;

{ Ts0CtrlDecorators }

function Ts0CtrlDecorators.Add(ACtrl: TWinControl): Ts0CtrlDecorator;
begin
  Result := Ts0CtrlDecorator(inherited Add);
  Result.Control := ACtrl;
end;

function Ts0CtrlDecorators.FindControl(ACol, ARow: Integer): TWinControl;
var
  deco: Ts0CtrlDecorator;
begin
  Result := nil;
  deco := Self.ItemByPos(ACol, ARow);
  if deco = nil then Exit;
  Result := deco.Control;
end;

function Ts0CtrlDecorators.GetDefaultEditor: Ts0CtrlDecorator;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if Result.FIsDefaultEditor then Exit;
  end;
  Result := nil;
end;

function Ts0CtrlDecorators.GetItems(const Index: Integer): Ts0CtrlDecorator;
begin
  Result := Ts0CtrlDecorator(inherited Decorators[Index] );
end;

procedure Ts0CtrlDecorators.HideControls;
var
  i: Integer;
begin
  for i := 0 to Count -1 do
    if Items[i].Control <> nil then
      Items[i].Control.Hide;
end;

procedure Ts0CtrlDecorators.InitDefaultEditor;
  function CreateEdit: Ts0Edit;
  begin
    Result := Ts0Edit.Create(GetOwnerGrid.Owner);
    Result.ParentFont := False;
    Result.Parent := GetOwnerGrid.Parent;
    Result.Name := Ts0ComponentHelper.GetNewComponentName(Result);
    Result.Text := '';
    Result.BorderStyle := bsNone;
  end;
var
  de: Ts0CtrlDecorator;
begin
  if DefaultEditor <> nil then Exit;
  de := Self.Add(CreateEdit);
  de.RegionKind := k0gcrWhole;
  de.FIsDefaultEditor := True;
  de.FreeWithCtrl := True;
  de.Index := 0;
end;

function Ts0CtrlDecorators.ItemByCtrl(
  AControl: TWinControl): Ts0CtrlDecorator;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].Control = AControl then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0CtrlDecorators.ItemByPos(ACol, ARow: Integer): Ts0CtrlDecorator;
begin
  Result := Ts0CtrlDecorator(inherited DecoByPos(ACol, ARow));
end;

procedure Ts0CtrlDecorators.OverrideCtrlEvent;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].OverrideCtrlEvent;
end;

procedure Ts0CtrlDecorators.SetItems(const Index: Integer;
  const Value: Ts0CtrlDecorator);
begin
  inherited Decorators[Index] := Value;
end;

{ Ts0CustomCtrlGrid }

procedure Ts0CustomCtrlGrid.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  {
    実行時に動的にグリッドを生成すると、Loadedメソッドが呼ばれないために、
    InitDefaultEditorメソッドも呼ばれない。
    仕方ないので表示されたときにInitDefaultEditorメソッドを呼び出すようにした。
  }
  if not Self.Showing then Exit;
  if [csDesigning, csLoading, csReading, csDestroying] * Self.ComponentState <> [] then Exit;
  if FInplaceEditorLoaded then Exit;
  FCtrlDecos.InitDefaultEditor;
  FCtrlDecos.HideControls;
  FCtrlDecos.OverrideCtrlEvent;
  FInplaceEditorLoaded := True;
end;

procedure Ts0CustomCtrlGrid.ColWidthsChanged;
begin
  inherited ColWidthsChanged;
  UpdateEdit;
end;

constructor Ts0CustomCtrlGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInplaceEditorLoaded := False;
  FCtrlDecos := NewCtrlDecos;
  AddToDecosList(FCtrlDecos);
end;

destructor Ts0CustomCtrlGrid.Destroy;
begin
  RemoveFromDecosList(FCtrlDecos);
  FreeAndNil(FCtrlDecos);
  inherited Destroy;
end;

function Ts0CustomCtrlGrid.GetInplaceEdit: TWinControl;
begin
  Result := FCurCtrl;
end;

function Ts0CustomCtrlGrid.GetInplaceEditText(
  AControl: TWinControl): string;
var
  d: Ts0CtrlDecorator;
begin
  Result := '';
  d := FCtrlDecos.ItemByCtrl(AControl);
  if d = nil then Exit;
  Result := d.GetDataFromCtrl;
end;

procedure Ts0CustomCtrlGrid.InplaceEditMove(ACol, ARow: Integer);
begin
  if (FInplaceCol <> ACol) or (FInplaceRow <> ARow) or (InplaceEditor = nil) then
    InplaceEditorMoveTo(ACol, ARow);
  SetInplaceEditText(InplaceEditor, GetEditText(ACol, ARow));
  inherited InplaceEditMove(ACol, ARow);
end;

procedure Ts0CustomCtrlGrid.InplaceEditorMoveTo(ACol, ARow: Integer);
	procedure SetCurCtrlFont(ACtrl: TWinControl);
  var
  	acsr: Ts0RTTIPublishedAccessor;
  begin
		if ACtrl = nil then
    	Exit;
    if Self.ComponentState * [csLoading, csDestroying, csDesigning, csFreeNotification ] <> [] then
    	Exit;
    acsr := Ts0RTTIPublishedAccessor.Create(ACtrl);
    try
    	if acsr.PropertyExists( 'Font' ) then
	    	acsr.ObjectProp['Font'] := Self.Font;
    finally
			FreeAndNil(acsr);
    end;
  end;
begin
  if (ACol < 0) and (ACol < 0) then
    if InplaceEditor <> nil then
      InplaceEditor.Hide;
  FInplaceCol := ACol;
  FInplaceRow := ARow;
  if (FInplaceCol > -1) and (FInplaceRow > -1) then
    FCurCtrl := FCtrlDecos.FindControl(FInplaceCol, FInplaceRow)
  else
    FCurCtrl := nil;
  SetCurCtrlFont(FCurCtrl);
end;

procedure Ts0CustomCtrlGrid.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then Exit;
  FCtrlDecos.InitDefaultEditor;
  FCtrlDecos.HideControls;
  FCtrlDecos.OverrideCtrlEvent;
  FInplaceEditorLoaded := True;
end;

function Ts0CustomCtrlGrid.NewCtrlDecos: Ts0CtrlDecorators;
begin
  Result := Ts0CtrlDecorators.Create(Self, Ts0CtrlDecorator);
end;

function Ts0CustomCtrlGrid.NewDrawer: Ts0GridCellDrawer;
begin
  Result := Ts0CtrlGridDrawer.Create(Self);
end;

procedure Ts0CustomCtrlGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if FCurCtrl = AComponent then
    FCurCtrl := nil;
end;

procedure Ts0CustomCtrlGrid.PrepareModeSet;
begin
  FModeSet[k0gmMoving   ] := Ts0CGMovingMode.Create(Self);
  FModeSet[k0gmSelecting] := Ts0CGSelectingMode.Create(Self);
  FModeSet[k0gmEditing  ] := Ts0CGEditingMode.Create(Self);
end;

procedure Ts0CustomCtrlGrid.SetCtrlDecos(const Value: Ts0CtrlDecorators);
begin
  FCtrlDecos.Assign(Value);
end;

procedure Ts0CustomCtrlGrid.SetInplaceEditText(AControl: TWinControl;
  const Value: string);
var
  d: Ts0CtrlDecorator;
begin
  d := FCtrlDecos.ItemByCtrl(AControl);
  if d = nil then Exit;
  d.SetDataToCtrl(Value);
end;

procedure Ts0CustomCtrlGrid.UpdateEdit;
begin
  if FCtrlDecos = nil then Exit; //このコードを消したらアクセス違反が出ちゃうぞー。
  inherited UpdateEdit;
end;

{ Ts0CtrlGridDrawer }

procedure Ts0CtrlGridDrawer.Draw(ACanvas: TCanvas; ACol, ARow: Integer;
  ARect: TRect; AState: TGridDrawState);
  function GetControl(ACol, ARow: Integer): TWinControl;
  var
    d: Ts0CtrlDecorator;
  begin
    Result := nil;
    if not(OwnerGrid is Ts0CustomCtrlGrid) then Exit;
    d := Ts0CustomCtrlGrid(OwnerGrid).CtrlDecos.ItemByPos(ACol, ARow);
    if d = nil then Exit;
    Result := d.Control;
  end;
begin
  if OwnerGrid.UpdateViewCount > 0 then Exit;
  if not DrawControl(ACanvas, ACol, ARow, ARect, AState, GetControl(ACol, ARow)) then
    inherited Draw(ACanvas, ACol, ARow, ARect, AState);
end;

procedure Ts0CtrlGridDrawer.DrawCellBtn(ACanvas: TCanvas;
  ARect: TRect; AButton: TButton; Focus, Down: Boolean);
var
  bufFont: TFont;
  p: TPoint;
begin
  if Focus then
    s0GraphHelper.ReduceTranslateRect(ARect, 1);
  ARect := DrawButtonFace(ACanvas, ARect, 1, bsNew, False, Down, False);
  //
  bufFont := TFont.Create;
  bufFont.Assign(ACanvas.Font);
  ACanvas.Font.Assign(AButton.Font);
  try
    p := Ts0ControlHelper.GetTextPosition(ACanvas, AButton.Caption, ARect);
    ACanvas.TextOut(p.x, p.y, AButton.Caption);
  finally
    ACanvas.Font.Assign(bufFont);
    FreeAndNil(bufFont);
  end;
  //
  if Focus then
    if Down then Frame3D(ACanvas, ARect, clBtnShadow, clWhite     ,1)
            else Frame3D(ACanvas, ARect, clWhite,     clBtnShadow ,1);
end;

function Ts0CtrlGridDrawer.DrawControl(ACanvas: TCanvas; ACol,
  ARow: Integer; ARect: TRect; AState: TGridDrawState; ACtrl: TWinControl): Boolean;
  function CtrlCanDraw(ACtrl: TWinControl; AState: TGridDrawState): Boolean;
  begin
    Result := False;
    if not(ACtrl is Ts0GridCellControl) then Exit;
    if gdFixed in AState then
      Result := Ts0GridCellControl(ACtrl).DrawFixedCells
    else
      Result := True;
  end;
begin
  SetCanvasColors(ACanvas, ACol, ARow, ARect, AState);
  ACanvas.FillRect(ARect);
  Result := ACtrl <> nil;
  if not Result then Exit;
  if CtrlCanDraw(ACtrl, AState) then
  begin
    Ts0GridCellControl(ACtrl).DrawToCanvas(ACanvas, ARect, AState, OwnerGrid.Cells[ACol, ARow])
  end
  else
  if (ACtrl is TButton) and (not (gdFixed in AState)) then
    DrawCellBtn(ACanvas, ARect, TButton(ACtrl), gdFocused in AState, False)
  else
    Result := False;
end;

end.
