unit s0DecoGrid;
{
$History: s0DecoGrid.pas $
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/02/05   Time: 4:31
 * Updated in $/source/D5Integrated
 * Ts0DecoGridDrawer.SetCanvasColorsで、デコが見つからない場合に、上位クラ
 * ス
 * のメソッドを呼び出すように修正
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 02/01/08   Time: 15:14
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/01/06   Time: 0:19
 * Updated in $/source/D5Integrated
 * DoubleBufferedをpublishedに
 * 
 * *****************  Version 22  *****************
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
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/12/06   Time: 22:55
 * Updated in $/source/D5Integrated
 * ちょっとリファクタリングした
 * Ts0GridModeの導入
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/11/13   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/10/11   Time: 17:21
 * Updated in $/source/D5Integrated
 * ColCount,RowCount,FixedCols,FixedRowsのpublishedでの宣言の順番を変更
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/10/03   Time: 0:25
 * Updated in $/source/D5Integrated
 * AddToDecosList、RemoveFromDecosListを使用するようにした。
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/10/01   Time: 9:10
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/09/18   Time: 11:53
 * Updated in $/source/D5Integrated
 * ColumnMoved、RowMoved、NotificationなどでのDecoratorsを呼び出しを
 * Ts0BindGridだけで行うように修正
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/09/13   Time: 23:26
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/09/06   Time: 21:20
 * Updated in $/source/D5Integrated
 * CtrlClickedメソッドは使われていなかったので削除した
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/08/31   Time: 22:32
 * Updated in $/source/D5/p0grid
 * Decoratorが設定されていない場合にセルの色を設定するように修正。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0grid
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/07/30   Time: 21:34
 * Updated in $/source/p0control/p0grid
 * 余計なメソッド、プロパティを削除した
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/07/30   Time: 12:15
 * Updated in $/source/p0control/p0grid
 * Ts0CtrlDecoratorをs0CtrlGridに移動。
 * それに伴い大変更。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/07/30   Time: 11:18
 * Updated in $/source/p0control/p0grid
 * FLineEraserを削除し損なっていたので、全て削除した。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/07/30   Time: 11:13
 * Updated in $/source/p0control/p0grid
 * ユニットの追加削除、余計なメソッドの削除を行った。
 * またs0CtrlDistillerを使用するように変更
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/07/30   Time: 10:43
 * Updated in $/source/p0control/p0grid
 * T0LineDecoratorとそれに関係するクラス、メソッドを削除
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/07/30   Time: 10:16
 * Updated in $/source/p0control/p0grid
 * Ts0CellDecorator、Ts0CellDecoratorsをs0BindGridに移行
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/18   Time: 19:23
 * Updated in $/source/p0control/p0grid
 * 
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/07/05   Time: 19:03
 * Created in $/Projects/Pleiades/source/p0grid
 * 新規追加
 * これらのソースはチェックアウトしちゃダメです。
 * 
 * *****************  Version 55  *****************
 * User: Hirakawa     Date: 01/06/22   Time: 13:44
 * Updated in $/GUI/Source/View
 * LoadedでTs0ColorManager.Instanceのnilチェック追加
 * 
 * *****************  Version 53  *****************
 * User: Hirakawa     Date: 01/06/22   Time: 9:31
 * Updated in $/GUI/Source/View
 * Ts0ColorSetコンポーネントを作成したので、それに対応した。
 * 
 * *****************  Version 52  *****************
 * User: Hirakawa     Date: 01/06/21   Time: 18:25
 * Updated in $/GUI/Source/View
 * DefaultDrawingのデフォルトを変更
 * 
 * *****************  Version 51  *****************
 * User: Hirakawa     Date: 01/06/21   Time: 16:20
 * Updated in $/GUI/Source/View
 * Tc1GridCellCheck、Tc1GridRadioGroupがFixedCellに設定できてしまうバグを
 * 修正
 * Tc1ExGridに関連づけたコントロールがEnabledに設定されていた場合等に「無
 * 効/非表示ウィンドウにはフォーカスを設定できません」というエラーが発生す
 * るバグを修正
 *
 * *****************  Version 50  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマンド追加
 *
 * *****************  Version   *****************
 * User: Akima     Date: 01/06/15
 * Updated in $/GUI/Source/View
 * コメント表示コマンド追加
 * Ts0CtrlDecorator.CtrlKeyDownで、SetFocusを行う順番を変更。
 * Ts0CustomDecoGrid.HideCtrlでFCurrentをHideするときに、グリッドにフォーカスを
 * あてるように変更。
 *
 * *****************  Version   *****************
 * User: Hirakawa     Date: 01/06/15
 * Updated in $/GUI/Source/View
 * Ts0CtrlDecoratorのAssignメソッド変更
 * Ts0ColorDecoratorのSetRegionをProtectedに変更
 *
 * *****************  Version   *****************
 * User: Hirakawa     Date: 01/06/15
 * Updated in $/GUI/Source/View
 * Ts0CellDecoratorのIsFoundationプロパティ削除
 * Ts0CellDecoratorsのFoundationプロパティ削除
 *
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  s0CommonTypes,
  s0CellDecorator,
  s0Grids,
  s0BindGrid,
  //s0BaseGrid,
  s0CtrlGrid,
  s0Observer,
  s0Collection;

type
	{
  	セルの色を指定するデコレータ。
  }
  Ts0ColorDecorator = class(Ts0CellDecorator)
  private
    FFontColor: TColor;
    FColor: TColor;
    FSelColor: TColor;
    FSelFontColor: TColor;
    FFixedFontColor: TColor;
    FFixedColor: TColor;
    FColorIdentifier: string;
    procedure SetColor(Const Index: Integer; const Value: TColor);
    procedure SetColorIdentifier(const Value: string);
  protected
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    { 通常背景色 }
  	property Color: TColor          index 0 read  FColor          write SetColor default clWindow;
    { 通常文字色 }
    property FontColor: TColor      index 1 read  FFontColor      write SetColor default clWindowText;
    { 選択時背景色 }
    property SelColor: TColor       index 2 read  FSelColor       write SetColor default clTeal;
    { 選択時文字色 }
    property SelFontColor: TColor   index 3 read  FSelFontColor   write SetColor default clWindowText;
    { 固定セル背景色 }
  	property FixedColor: TColor     index 4 read  FFixedColor     write SetColor default clBtnFace;
    { 固定セル文字色 }
    property FixedFontColor: TColor index 5 read  FFixedFontColor write SetColor default clWindowText;
    { 識別子。あまり使用しない }
    property ColorIdentifier: string read FColorIdentifier write SetColorIdentifier;
  end;

type
  Ts0ColorDecorators = class(Ts0CellDecorators)
  protected
    function SetColors(ACanvas: TCanvas; ACol, ARow: Integer; AState: TGridDrawState): Boolean; virtual;
  public
    class function SelectColorByState(AState: TGridDrawState; ANormal, AFixed,
      ASelected: TColor): TColor;
  end;

type
	{
  	セルの内容の表示位置を設定するデコレータ。
  }
  Ts0AlignmentDecorator = class(Ts0CellDecorator)
  private
    FVertical: K0VerticalAlignment;
    FHorizontal: TAlignment;
    procedure SetHorizontal(const Value: TAlignment);
    procedure SetVertical(const Value: K0VerticalAlignment);
  protected
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    function GetAlignVal: UINT;
  published
    { 水平位置。
    	taLeftJustify 左寄せ
      taRightJustify 右寄せ
      taCenter 中央寄せ }
    property Horizontal: TAlignment read FHorizontal write SetHorizontal default taLeftJustify;
    { 垂直位置
      k0vaTop 上寄せ
      k0vaCenter 中央寄せ
      k0vaBottom 下寄せ }
    property Vertical: K0VerticalAlignment read FVertical write SetVertical default k0vaTop;
  end;

type
  Ts0AlignmentDecorators = class(Ts0CellDecorators)
  private
    function GetItems(const Index: Integer): Ts0AlignmentDecorator;
    procedure SetItems(const Index: Integer;
      const Value: Ts0AlignmentDecorator);
  public
    property Items[const Index: Integer]: Ts0AlignmentDecorator read GetItems write SetItems;
  end;

type
	{
  	セルのフォントを設定するデコレータ。
  }
  Ts0FontDecorator = class(Ts0CellDecorator)
  private
    FFont: TFont;
    procedure SetFont(const Value: TFont);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Font: TFont read FFont write SetFont;
  end;

type
  Ts0FontDecorators = class(Ts0CellDecorators)
  private
    function GetItems(const Index: Integer): Ts0FontDecorator;
    procedure SetItems(const Index: Integer;
      const Value: Ts0FontDecorator);
  public
    property Items[const Index: Integer]: Ts0FontDecorator read GetItems write SetItems;
  end;

type
  Ts0CustomDecoGrid = class(Ts0CustomCtrlGrid)  //(Ts0CustomBaseGrid)
  private
    FColorDecos: Ts0ColorDecorators;
    FShowControls: Boolean;
    FColorSetLoadedListener: Ts0EventListener;
    FAlignmentDecos: Ts0AlignmentDecorators;
    FFontDecos: Ts0FontDecorators;
    procedure SetColorDecos(const Value: Ts0ColorDecorators);
    procedure SetAlignmentDecos(const Value: Ts0AlignmentDecorators);
    procedure SetFontDecos(const Value: Ts0FontDecorators);
  protected
    procedure ColorSetLoaded(Sender: TObject);
    function NewAlignmentDecos: Ts0AlignmentDecorators; virtual;
    function NewColorDecos: Ts0ColorDecorators; virtual;
    function NewFontDecos: Ts0FontDecorators; virtual;
    function NewDrawer: Ts0GridCellDrawer; override;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property ImeMode;
    property ImeName;
  protected
  	{ セルの中身の表示位置を設定するデコレータのコレクション。
      Ts0AlignmentDecoratorsを参照。}
    property AlignmentDecos: Ts0AlignmentDecorators read FAlignmentDecos write SetAlignmentDecos;
    { セルの色を設定するデコレータのコレクション。
      Ts0ColorDecoratorsを参照 }
    property ColorDecos: Ts0ColorDecorators read FColorDecos write SetColorDecos;
    { セルのフォントを設定するデコレータのコレクション。
      Ts0FontDecoratorsを参照 }
    property FontDecos: Ts0FontDecorators read FFontDecos write SetFontDecos;
  end;

type
  Ts0DecoGrid = class(Ts0CustomDecoGrid)
  published
    property DoubleBuffered;
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
  published
    property AlignmentDecos;
    property ColorDecos;
    property FontDecos;
  end;

type
  Ts0DecoGridDrawer = class(Ts0CtrlGridDrawer)
  protected
    function GetCellDrawOption(ACol, ARow: Integer): UINT; override;
    function GetCellFont(ACol, ARow: Integer): TFont; override;
    procedure SetCanvasColors(ACanvas: TCanvas; ACol, ARow: Integer;
      ARect: TRect; AState: TGridDrawState); override;
  public
  end;

implementation

uses
  s0ColorSet;

{ Ts0ColorDecorator }

procedure Ts0ColorDecorator.Assign(Source: TPersistent);
var
  src: Ts0ColorDecorator;
  cs: Ts0ColorSet;
begin
  inherited Assign(Source);
  if Source is Ts0ColorDecorator then
  begin
    src := Ts0ColorDecorator(Source);
    Self.FColor          := src.FColor         ;
    Self.FFontColor      := src.FFontColor     ;
    Self.FSelColor       := src.FSelColor      ;
    Self.FSelFontColor   := src.FSelFontColor  ;
    Self.FFixedColor     := src.FFixedColor    ;
    Self.FFixedFontColor := src.FFixedFontColor;
  end
  else
  if Source is Ts0ColorSet then
  begin
    cs := Ts0ColorSet(Source);
    Self.FColor          := cs.Color             ;
    Self.FFontColor      := cs.FontColor         ;
    Self.FSelColor       := cs.GridSelColor      ;
    Self.FSelFontColor   := cs.GridSelFontColor  ;
    Self.FFixedColor     := cs.GridFixedColor    ;
    Self.FFixedFontColor := cs.GridFixedFontColor;
  end;
end;

constructor Ts0ColorDecorator.Create(Collection: TCollection);
begin
  inherited;
  FColor          := clWindow;
  FFontColor      := clWindowText;
  FSelColor       := clTeal;
  FSelFontColor   := clWindowText;
  FFixedColor     := clBtnFace;
  FFixedFontColor := clWindowText;
  if GetOwnerGrid is Ts0CustomDecoGrid then
  begin
    FColor := Ts0CustomDecoGrid(GetOwnerGrid).Color;
    FFontColor := Ts0CustomDecoGrid(GetOwnerGrid).Font.Color;
    FFixedColor := Ts0CustomDecoGrid(GetOwnerGrid).FixedColor;
  end;
end;

procedure Ts0ColorDecorator.SetColor(const Index: Integer; const Value: TColor);
begin
  if FColorIdentifier <> '' then Exit;
  case Index of
  	0: FColor          := Value;
    1: FFontColor      := Value;
    2: FSelColor       := Value;
    3: FSelFontColor   := Value;
  	4: FFixedColor     := Value;
    5: FFixedFontColor := Value;
  end;
  InvalidateGrid;
end;

//resourcestring
//  c9ErrMsg_ColorSetNotExists = 'Ts0ColorSet( %s ) does not exists.';

procedure Ts0ColorDecorator.SetColorIdentifier(const Value: string);
var
  cs: Ts0ColorSet;
begin
  if Trim(Value) = '' then
  begin
    FColorIdentifier := '';
    InvalidateGrid;
    Changed(False);
    Exit;
  end;
  //
  if Ts0ColorManager.Instance <> nil then
  begin
    cs := Ts0ColorManager.Instance.FindColorSet(Value);
    if cs = nil then
    begin
      //raise Es0ColorSetException.CreateFmt(c9ErrMsg_ColorSetNotExists, [Value]);
      Self.SetColorIdentifier('');
      Exit;
    end;
    FColorIdentifier := Value;
    Self.Assign(cs);
    InvalidateGrid;
    Changed(False);
  end
  else
  begin
    FColorIdentifier := Value;
  end;
end;


{ Ts0ColorDecorators }

class function Ts0ColorDecorators.SelectColorByState(AState: TGridDrawState; ANormal, AFixed, ASelected: TColor): TColor;
begin
       if  gdFixed    in AState  then Result := AFixed
  else if  gdSelected in AState  then Result := ASelected
  else Result := ANormal;
end;

function Ts0ColorDecorators.SetColors(ACanvas: TCanvas; ACol, ARow: Integer; AState: TGridDrawState): Boolean;
var
  d: Ts0ColorDecorator;
begin
  d := Ts0ColorDecorator( Self.DecoByPos(ACol, ARow) );
  Result := d <> nil;
  if not Result then Exit;
  ACanvas.Brush.Color := SelectColorByState(AState, d.Color    , d.FixedColor    , d.SelColor    );
  ACanvas.Font.Color  := SelectColorByState(AState, d.FontColor, d.FixedFontColor, d.SelFontColor);
end;


{ Ts0AlignmentDecorator }

procedure Ts0AlignmentDecorator.Assign(Source: TPersistent);
begin
  inherited;   
end;

constructor Ts0AlignmentDecorator.Create(Collection: TCollection);
begin
  inherited;
  FHorizontal := taLeftJustify;
  FVertical := k0vaTop;
end;

function Ts0AlignmentDecorator.GetAlignVal: UINT;
const
  c9AlignmentHorz: array[TAlignment] of UINT = (DT_LEFT, DT_RIGHT, DT_CENTER);
  c9AlignmentVert: array[K0VerticalAlignment] of UINT = (DT_TOP, DT_VCENTER, DT_BOTTOM);
begin
  Result := c9AlignmentHorz[FHorizontal] or c9AlignmentVert[FVertical];
end;

procedure Ts0AlignmentDecorator.SetHorizontal(const Value: TAlignment);
begin
  FHorizontal := Value;
  Changed(False);
end;

procedure Ts0AlignmentDecorator.SetVertical(
  const Value: K0VerticalAlignment);
begin
  FVertical := Value;
  Changed(False);
end;


{ Ts0AlignmentDecorators }

function Ts0AlignmentDecorators.GetItems(
  const Index: Integer): Ts0AlignmentDecorator;
begin
  Result := Ts0AlignmentDecorator(inherited Items[Index]);
end;

procedure Ts0AlignmentDecorators.SetItems(const Index: Integer;
  const Value: Ts0AlignmentDecorator);
begin
  inherited Items[Index] := Value;
end;



{ Ts0CustomDecoGrid }

procedure Ts0CustomDecoGrid.Assign(Source: TPersistent);
begin
  inherited;
end;

constructor Ts0CustomDecoGrid.Create(AOwner: TComponent);
begin
  inherited;
  FShowControls := True;
  FColorDecos := NewColorDecos;
  FAlignmentDecos := NewAlignmentDecos;
  FFontDecos := NewFontDecos;
  FColorSetLoadedListener := Ts0EventListener.Create(ColorSetLoaded);
  AddToDecosList(FColorDecos);
  AddToDecosList(FAlignmentDecos);
end;

destructor Ts0CustomDecoGrid.Destroy;
begin
  RemoveFromDecosList(FFontDecos);
  RemoveFromDecosList(FAlignmentDecos);
  RemoveFromDecosList(FColorDecos);
  FreeAndNil(FColorSetLoadedListener);
  FreeAndNil(FFontDecos);
  FreeAndNil(FColorDecos);
  FreeAndNil(FAlignmentDecos);
  inherited;
end;

procedure Ts0CustomDecoGrid.SetColorDecos(const Value: Ts0ColorDecorators);
begin
  FColorDecos.Assign(Value);
end;

procedure Ts0CustomDecoGrid.Loaded;
begin
  inherited Loaded;
  if Ts0ColorManager.Instance <> nil then
  begin
    Ts0ColorManager.Instance.OnLoadItems.Attach(FColorSetLoadedListener);
    if Ts0ColorManager.Instance.LoadedItems then
      ColorSetLoaded(nil);
  end;
end;

function Ts0CustomDecoGrid.NewColorDecos: Ts0ColorDecorators;
begin
  Result := Ts0ColorDecorators.Create(Self, Ts0ColorDecorator);
end;

procedure Ts0CustomDecoGrid.ColorSetLoaded(Sender: TObject);
var
  i: Integer;
  cd: Ts0ColorDecorator;
begin
  for i := 0 to FColorDecos.Count -1 do
  begin
    cd := Ts0ColorDecorator( FColorDecos.Decorators[i] );
    cd.SetColorIdentifier( cd.ColorIdentifier );
  end;
end;

function Ts0CustomDecoGrid.NewDrawer: Ts0GridCellDrawer;
begin
  Result := Ts0DecoGridDrawer.Create(Self);
end;

procedure Ts0CustomDecoGrid.SetAlignmentDecos(
  const Value: Ts0AlignmentDecorators);
begin
  FAlignmentDecos.Assign(Value);
end;

function Ts0CustomDecoGrid.NewAlignmentDecos: Ts0AlignmentDecorators;
begin
  Result := Ts0AlignmentDecorators.Create(Self, Ts0AlignmentDecorator);
end;


procedure Ts0CustomDecoGrid.SetFontDecos(const Value: Ts0FontDecorators);
begin
  FFontDecos.Assign(Value);
end;

function Ts0CustomDecoGrid.NewFontDecos: Ts0FontDecorators;
begin
  Result := Ts0FontDecorators.Create(Self, Ts0FontDecorator);
end;

{ Ts0DecoGridDrawer }

function Ts0DecoGridDrawer.GetCellDrawOption(ACol, ARow: Integer): UINT;
var
  d: Ts0AlignmentDecorator;
begin
  Result := 0;
  if not(OwnerGrid is Ts0CustomDecoGrid) then Exit;
  d := Ts0AlignmentDecorator( Ts0CustomDecoGrid(OwnerGrid).AlignmentDecos.DecoByPos(ACol, ARow) );
  if d = nil then Exit;
  Result := d.GetAlignVal;
end;

function Ts0DecoGridDrawer.GetCellFont(ACol, ARow: Integer): TFont;
var
  d: Ts0FontDecorator;
begin
	Result := Self.Font;
  if not(OwnerGrid is Ts0CustomDecoGrid) then Exit;
  d := Ts0FontDecorator( Ts0CustomDecoGrid(OwnerGrid).FontDecos.DecoByPos(ACol, ARow) );
  if d = nil then Exit;
  Result := d.Font;
end;

procedure Ts0DecoGridDrawer.SetCanvasColors(ACanvas: TCanvas; ACol,
  ARow: Integer; ARect: TRect; AState: TGridDrawState);
var
	fontDeco: Ts0FontDecorator;
begin
  if not(OwnerGrid is Ts0CustomDecoGrid) then Exit;
  if not Ts0CustomDecoGrid(OwnerGrid).ColorDecos.SetColors(ACanvas, ACol, ARow, AState) then
  begin
  	fontDeco := Ts0FontDecorator(Ts0CustomDecoGrid(OwnerGrid).FontDecos.DecoByPos(ACol, ARow));
    if (fontDeco <> nil) then
    begin
    	ACanvas.Font.Color := fontDeco.Font.Color;
		  ACanvas.Brush.Color := Ts0ColorDecorators.SelectColorByState(AState, Self.Color, Self.ColorFixed, Self.ColorSelected);
    end
    else
    begin
	    inherited SetCanvasColors(ACanvas, ACol, ARow, ARect, AState);
    end;
  end;
end;

{ Ts0FontDecorator }

procedure Ts0FontDecorator.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source is Ts0FontDecorator) then
		Self.Font := Ts0FontDecorator(Source).Font;
end;

constructor Ts0FontDecorator.Create(Collection: TCollection);
begin
  inherited;
  FFont := TFont.Create();
end;

destructor Ts0FontDecorator.Destroy;
begin
	FreeAndNil(FFont);
  inherited;
end;

procedure Ts0FontDecorator.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

{ Ts0FontDecorators }

function Ts0FontDecorators.GetItems(
  const Index: Integer): Ts0FontDecorator;
begin
  Result := Ts0FontDecorator( inherited Items[Index] );
end;

procedure Ts0FontDecorators.SetItems(const Index: Integer;
  const Value: Ts0FontDecorator);
begin
  inherited Items[Index] := Value;
end;

end.
