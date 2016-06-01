unit s0CellDecorator;
{
$History: s0CellDecorator.pas $
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/12/10   Time: 10:45
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
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
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/29   Time: 1:28
 * Updated in $/source/D5Integrated
 * AddDecoメソッドを追加
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/03   Time: 23:43
 * Updated in $/source/D5Integrated
 * Ts0CellDecoratorsClassを定義した。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/18   Time: 11:51
 * Updated in $/source/D5Integrated
 * CanDecorateメソッドを修正
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/13   Time: 23:32
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/06   Time: 14:14
 * Created in $/source/p0control/p0grid
 * 新規作成
 * s0DecoGridにあったものを別のユニットとした。
}

interface

uses
  Windows, SysUtils, Classes,
  Contnrs,
  s0VCLClasses,
  s0Grids,
  s0Collection,
  s0Observer;

type
  K0GridCellRegionKind = (k0gcrRect, k0gcrCols, k0gcrRows, k0gcrCell, k0gcrWhole);
  K0GridCellRegionKindSet = set of K0GridCellRegionKind;

type
  Ts0GridCellRegionClass = class of Ts0GridCellRegion;
  Ts0GridCellRegion = class
  private
    FOnChange: Ts0Event;
    function GetOnChange: Ts0Event;
  protected
    FGrid: Ts0CustomGrid;
    function GetAsRect: TGridRect; virtual; abstract;
    function GetKind: K0GridCellRegionKind; virtual; abstract;
    function GetPosition(const Index: Integer): Integer; virtual; abstract;
    procedure SetAsRect(const Value: TGridRect); virtual; abstract;
    procedure SetPosition(const Index, Value: Integer); virtual; abstract;
  public
    constructor Create(AOwner: Ts0CustomGrid); virtual;
    destructor Destroy; override;
    procedure Assign(Source: Ts0GridCellRegion); virtual;
    procedure Change;
    function IsIncluding(const X, Y: Integer): Boolean; virtual;
    procedure Prepare; virtual;
    property AsRect: TGridRect read GetAsRect write SetAsRect;
    property Top   : Integer index 0 read GetPosition write SetPosition;
    property Left  : Integer index 1 read GetPosition write SetPosition;
    property Right : Integer index 2 read GetPosition write SetPosition;
    property Bottom: Integer index 3 read GetPosition write SetPosition;
    property Kind: K0GridCellRegionKind read GetKind;
    property OnChange: Ts0Event read GetOnChange;
  end;

type
  Es0GridCellRegionException = class(Exception);

type
  Ts0GridRegionList = class(TObjectList)
  private
  protected
    function GetItems(Index: Integer): Ts0GridCellRegion;
    procedure SetItems(Index: Integer; AItem: Ts0GridCellRegion);
  public
    function Add(AItem: Ts0GridCellRegion): Integer;
    function Remove(AItem: Ts0GridCellRegion): Integer;
    function IndexOf(AItem: Ts0GridCellRegion): Integer;
    procedure Insert(Index: Integer; AItem: Ts0GridCellRegion);
    property Items[Index: Integer]: Ts0GridCellRegion read GetItems write SetItems; default;
    function First: Ts0GridCellRegion;
    function Last: Ts0GridCellRegion;
  public
    function IsIncluding(const X, Y: Integer): Boolean; virtual;
  end;

type
  Ts0GridCellRect = class(Ts0GridCellRegion)
  private
    FRect: TGridRect;
  protected
    function GetAsRect: TGridRect; override;
    function GetKind: K0GridCellRegionKind; override;
    function GetPosition(const Index: Integer): Integer; override;
    procedure SetAsRect(const Value: TGridRect); override;
    procedure SetPosition(const Index, Value: Integer); override;
  public
    function IsIncluding(const X, Y: Integer): Boolean; override;
    procedure Prepare; override;
  end;                     

type
  Ts0GridColRect = class(Ts0GridCellRegion)
  private
    FFirstCol: Integer;
    FLastCol: Integer;
    procedure SetFirstCol(const Value: Integer);
    procedure SetLastCol(const Value: Integer);
  protected
    function GetAsRect: TGridRect; override;
    function GetKind: K0GridCellRegionKind; override;
    function GetPosition(const Index: Integer): Integer; override;
    procedure SetAsRect(const Value: TGridRect); override;
    procedure SetPosition(const Index, Value: Integer); override;
  public
    function IsIncluding(const X, Y: Integer): Boolean; override;
    procedure Prepare; override;
    property FirstCol: Integer read FFirstCol write SetFirstCol;
    property LastCol: Integer read FLastCol write SetLastCol;
  end;

type
  Ts0GridRowRect = class(Ts0GridCellRegion)
  private
    FFirstRow: Integer;
    FLastRow: Integer;
    procedure SetFirstRow(const Value: Integer);
    procedure SetLastRow(const Value: Integer);
  protected
    function GetAsRect: TGridRect; override;
    function GetKind: K0GridCellRegionKind; override;
    function GetPosition(const Index: Integer): Integer; override;
    procedure SetAsRect(const Value: TGridRect); override;
    procedure SetPosition(const Index, Value: Integer); override;
  public
    function IsIncluding(const X, Y: Integer): Boolean; override;
    procedure Prepare; override;
    property FirstRow: Integer read FFirstRow write SetFirstRow;
    property LastRow: Integer read FLastRow write SetLastRow;
  end;

type
  Ts0GridSingleCell = class(Ts0GridCellRegion)
  private
    FCol: Integer;
    FRow: Integer;
    procedure SetCol(const Value: Integer);
    procedure SetRow(const Value: Integer);
  protected
    function GetAsRect: TGridRect; override;
    function GetKind: K0GridCellRegionKind; override;
    function GetPosition(const Index: Integer): Integer; override;
    procedure SetAsRect(const Value: TGridRect); override;
    procedure SetPosition(const Index, Value: Integer); override;
  public
    constructor Create(AOwner: Ts0CustomGrid); override;
    destructor Destroy; override;
    function IsIncluding(const X, Y: Integer): Boolean; override;
    procedure Prepare; override;
    property Col: Integer read FCol write SetCol;
    property Row: Integer read FRow write SetRow;
  end;

type
  Ts0GridWholeRect = class(Ts0GridCellRegion)
  private
  protected
    function GetAsRect: TGridRect; override;
    function GetKind: K0GridCellRegionKind; override;
    function GetPosition(const Index: Integer): Integer; override;
    procedure SetAsRect(const Value: TGridRect); override;
    procedure SetPosition(const Index, Value: Integer); override;
  public
    function IsIncluding(const X, Y: Integer): Boolean; override;
  end;

var
  g0GridRectClasses: array[K0GridCellRegionKind] of Ts0GridCellRegionClass = (
    Ts0GridCellRect,
    Ts0GridColRect,
    Ts0GridRowRect,
    Ts0GridSingleCell,
    Ts0GridWholeRect
  );

type
  Ts0CustomDecoStringGrid = class;

	K0CellAvailableQuery = procedure(Sender: TObject; ACol,ARow: Integer;
  	var available: Boolean) of object;

  Ts0CellDecoratorClass = class of Ts0CellDecorator;
  Ts0CellDecorator = class(Ts0VCLCollectionItem)
  private
    FEnabled: Boolean;
    FComment: string;
    FRegion: Ts0GridCellRegion;
    FStripeRow: Boolean;
    FOnCanDecorate: K0CellAvailableQuery;
    procedure SetEnabled(const Value: Boolean);
    procedure SetDecoRect(const Value: TGridRect);
    function GetDecoRect: TGridRect;
    function GetPosition(const Index: Integer): Integer;
    function GetRegionKind: K0GridCellRegionKind;
    procedure SetRegionKind(const Value: K0GridCellRegionKind);
    procedure SetStripeRow(const Value: Boolean);
  protected
    procedure DivideByCol(FromIndex, ToIndex: Longint); virtual;
    procedure DivideByRow(FromIndex, ToIndex: Longint); virtual;
    function GetOwnerGrid: Ts0CustomStringGrid;
    procedure InvalidateGrid;
    procedure SetPosition(const Index: Integer; const Value: Integer); virtual;
    procedure SlideByCol(AStart, AEnd: Longint; ADif: Integer); virtual;
    procedure SlideByRow(AStart, AEnd: Longint; ADif: Integer); virtual;
  protected
    function NewRegion(AKind: K0GridCellRegionKind): Ts0GridCellRegion; virtual;
    property Region: Ts0GridCellRegion read FRegion;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IsStripedRow(ARow: Integer): Boolean;
    function GetCellsRect: TRect;
    function CanDecorate(ACol, ARow: Integer): Boolean; virtual;
    function HasColumn(ACol: Longint): Boolean;
    function HasRow(ARow: Longint): Boolean;
    property DecoRect: TGridRect read GetDecoRect write SetDecoRect;
    property OwnerGrid: Ts0CustomStringGrid read GetOwnerGrid;
  published
  	{ 有効か否か。デフォルトTrue }
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    { デコレータの適用範囲の上部の行の位置 }
    property Top   : Integer index 0 read GetPosition write SetPosition;
    { デコレータの適用範囲の左部の列の位置 }
    property Left  : Integer index 1 read GetPosition write SetPosition;
    { デコレータの適用範囲の右部の列の位置 }
    property Right : Integer index 2 read GetPosition write SetPosition;
    { デコレータの適用範囲の下部の行の位置 }
    property Bottom: Integer index 3 read GetPosition write SetPosition;
    { デコレータの適用範囲の種類。
      各セルがデコレータの適用範囲ないであるかどうかを以下の条件で判断する。
      k0gcrRect Top,Left,Right,Bottomのすべてのプロパティから判断。
      k0gcrCols Left,Rightから判断。
      k0gcrRows Top,Bottomから判断。
      k0gcrCell Top,Leftから判断
      k0gcrWhole すべて適用範囲であると判断。
    }
    property RegionKind: K0GridCellRegionKind read GetRegionKind write SetRegionKind default k0gcrRect;
    { StripeRowがTrueの場合、デコレータの適用範囲内であっても、
      行の位置が奇数であった場合に適用範囲外とみなされます。}
    property StripeRow: Boolean read FStripeRow write SetStripeRow;
    { 設計時にのみ使用。実行時には関係ない。 }
    property Comment: string read FComment write FComment;
  published
  	{ このデコレータが引数ACol,ARowで指定されるセルについて有効かどうかを
    	問い合わせるイベント }
  	property OnCanDecorate: K0CellAvailableQuery read FOnCanDecorate write FOnCanDecorate;
  end;          

  Ts0CellDecoratorsClass = class of Ts0CellDecorators;
  Ts0CellDecorators = class(Ts0VCLCollection)
  private
    function GetDecorators(const Index: Integer): Ts0CellDecorator;
    procedure SetDecorators(const Index: Integer; const Value: Ts0CellDecorator);
  protected
    function GetOwnerGrid: Ts0CustomStringGrid;
  public
    constructor Create(AOwner: TPersistent; AItemClass: Ts0CollectionItemClass); override;
    function AddDeco(ALeft, ATop, ARight, ABottom: Integer; AKind: K0GridCellRegionKind = k0gcrRect): Ts0CellDecorator;
    function DecoByPos(ACol, ARow: Integer): Ts0CellDecorator;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); virtual;
    procedure RowMoved(FromIndex, ToIndex: Longint); virtual;
    property Decorators[const Index: Integer]: Ts0CellDecorator read GetDecorators write SetDecorators;
  end;

  Ts0CustomDecoStringGrid = class(Ts0CustomStringGrid)
  private
    FDecosList: TObjectList;
  protected
    procedure DecoDestroy(Sender: TObject; AItem: Ts0CollectionItem); virtual;
    procedure AddToDecosList(ADecos: Ts0CellDecorators);
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RemoveFromDecosList(ADecos: Ts0CellDecorators);
    procedure RowMoved(FromIndex, ToIndex: Longint); override;
    procedure SizeChanged(OldColCount, OldRowCount: Longint); override;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure GetDecoList(Dest: TObjectList);
    function GetDecorators(ADecosClass: Ts0CellDecoratorsClass): Ts0CellDecorators;
    property ColWidths;
    property RowHeights;
  end;


type
  Es0CellDecoratorError = class(Exception);

implementation

uses
  s0GraphHelper;

procedure Exchange(var Val1, Val2: Integer);
var
  buf: Integer;
begin
  buf := Val1;
  Val2 := Val1;
  Val1 := buf;
end;

procedure PrepareRect(var r: TGridRect);
var
  tt, ll, rr, bb: Integer;
begin
  tt := r.Top;
  ll := r.Left;
  rr := r.Right;
  bb := r.Bottom;
  if ll > rr then Exchange(ll, rr);
  if tt > bb then Exchange(tt, bb);
  r.Top := tt;
  r.Left := ll;
  r.Right := rr;
  r.Bottom := bb;
end;


{ Ts0GridCellRegion }

procedure Ts0GridCellRegion.Assign(Source: Ts0GridCellRegion);
begin
  Self.AsRect := Source.AsRect;
  Change;
end;

procedure Ts0GridCellRegion.Change;
begin
  if FOnChange = nil then Exit;
  FOnChange.NotifyAll;
end;

resourcestring
  c9ErrMsg_RegionCannotCreateByNilOwner = 'Ts0GridCellRegionのコンストラクタにnilが渡されました';

constructor Ts0GridCellRegion.Create(AOwner: Ts0CustomGrid);
begin
  inherited Create;
  if AOwner = nil then
    raise Es0GridCellRegionException.Create(c9ErrMsg_RegionCannotCreateByNilOwner);
  FGrid := AOwner;
end;

destructor Ts0GridCellRegion.Destroy;
begin
  FreeAndNil(FOnChange);
  inherited;
end;

function Ts0GridCellRegion.GetOnChange: Ts0Event;
begin
  if FOnChange = nil then
    FOnChange := Ts0Event.Create(Self);
  Result := FOnChange;
end;

function Ts0GridCellRegion.IsIncluding(const X, Y: Integer): Boolean;
begin
  Result := False;
end;

procedure Ts0GridCellRegion.Prepare;
begin
end;

{ Ts0GridRegionList }

function Ts0GridRegionList.Add(AItem: Ts0GridCellRegion): Integer;
begin
  Result := inherited Add(AItem);
end;

function Ts0GridRegionList.First: Ts0GridCellRegion;
begin
  Result := Ts0GridCellRegion( inherited First );
end;

function Ts0GridRegionList.GetItems(Index: Integer): Ts0GridCellRegion;
begin
  Result := Ts0GridCellRegion( inherited Items[Index] );
end;

function Ts0GridRegionList.IndexOf(AItem: Ts0GridCellRegion): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure Ts0GridRegionList.Insert(Index: Integer;
  AItem: Ts0GridCellRegion);
begin
  inherited Insert(Index, AItem);
end;

function Ts0GridRegionList.IsIncluding(const X, Y: Integer): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Self.Count -1 do
    if Items[i].IsIncluding(X, Y) then Exit;
  Result := False;
end;

function Ts0GridRegionList.Last: Ts0GridCellRegion;
begin
  Result := Ts0GridCellRegion( inherited Last );
end;

function Ts0GridRegionList.Remove(AItem: Ts0GridCellRegion): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure Ts0GridRegionList.SetItems(Index: Integer; AItem: Ts0GridCellRegion);
begin
  inherited Items[Index] := AItem;
end;


{ Ts0GridCellRect }

function Ts0GridCellRect.GetKind: K0GridCellRegionKind;
begin
  Result := k0gcrRect;
end;

function Ts0GridCellRect.GetAsRect: TGridRect;
begin
  Result := FRect;
end;

function Ts0GridCellRect.IsIncluding(const X, Y: Integer): Boolean;
begin
  Result := (X >= FRect.Left) and (X <= FRect.Right) and
            (Y >= FRect.Top)  and (Y <= FRect.Bottom);
end;

procedure Ts0GridCellRect.Prepare;
begin
  PrepareRect(FRect);
end;

procedure Ts0GridCellRect.SetAsRect(const Value: TGridRect);
begin
  //if FRect = Value then Exit;
  FRect := Value;
  Change;
end;

function Ts0GridCellRect.GetPosition(const Index: Integer): Integer;
begin
  Result := 0;
  case Index of
    0: Result := FRect.Top;
    1: Result := FRect.Left;
    2: Result := FRect.Right;
    3: Result := FRect.Bottom;
  end;
end;

procedure Ts0GridCellRect.SetPosition(const Index, Value: Integer);
begin
  case Index of
    0: FRect.Top    := Value;
    1: FRect.Left   := Value;
    2: FRect.Right  := Value;
    3: FRect.Bottom := Value;
  end;
  Change;
end;

{ Ts0GridColRect }

function Ts0GridColRect.GetKind: K0GridCellRegionKind;
begin
  Result := k0gcrCols;
end;

function Ts0GridColRect.GetAsRect: TGridRect;
begin
  Result.Top    := 0;
  Result.Left   := FFirstCol;
  Result.Right  := FLastCol;
  Result.Bottom := FGrid.RowCount -1;
end;

function Ts0GridColRect.IsIncluding(const X, Y: Integer): Boolean;
begin
  Result := (X >= FFirstCol) and (X <= FLastCol);
end;

procedure Ts0GridColRect.Prepare;
begin
  if FFirstCol > FLastCol then Exchange(FFirstCol, FLastCol);
end;

procedure Ts0GridColRect.SetAsRect(const Value: TGridRect);
begin
  FFirstCol := Value.Left ;
  FLastCol  := Value.Right;
  Change;
end;

procedure Ts0GridColRect.SetFirstCol(const Value: Integer);
begin
  if FFirstCol = Value then Exit;
  FFirstCol := Value;
  Change;
end;

procedure Ts0GridColRect.SetLastCol(const Value: Integer);
begin
  if FLastCol = Value then Exit;
  FLastCol := Value;
  Change;
end;

function Ts0GridColRect.GetPosition(const Index: Integer): Integer;
begin
  Result := 0;
  case Index of
    0: Result := 0;
    1: Result := FFirstCol;
    2: Result := FLastCol;
    3: Result := FGrid.RowCount -1
  end;
end;

procedure Ts0GridColRect.SetPosition(const Index, Value: Integer);
begin
  case Index of
    0: ;
    1: FFirstCol := Value;
    2: FLastCol  := Value;
    3: ;
  end;
  Change;
end;

{ Ts0GridRowRect }

function Ts0GridRowRect.GetKind: K0GridCellRegionKind;
begin
  Result := k0gcrRows;
end;

function Ts0GridRowRect.GetAsRect: TGridRect;
begin
  Result.Top    := FFirstRow;
  Result.Left   := 0;
  Result.Right  := FGrid.ColCount -1;
  Result.Bottom := FFirstRow;
end;

function Ts0GridRowRect.IsIncluding(const X, Y: Integer): Boolean;
begin
  Result := (Y >= FFirstRow) and (Y <= FLastRow);
end;

procedure Ts0GridRowRect.Prepare;
begin
  if FFirstRow > FLastRow then Exchange(FFirstRow, FLastRow);
end;

procedure Ts0GridRowRect.SetAsRect(const Value: TGridRect);
begin
  FFirstRow := Value.Top;
  FLastRow  := Value.Bottom;
  Change;
end;

procedure Ts0GridRowRect.SetFirstRow(const Value: Integer);
begin
  if FFirstRow = Value then Exit;
  FFirstRow := Value;
  Change;
end;

procedure Ts0GridRowRect.SetLastRow(const Value: Integer);
begin
  if FLastRow = Value then Exit;
  FLastRow := Value;
  Change;
end;

function Ts0GridRowRect.GetPosition(const Index: Integer): Integer;
begin
  Result := 0;
  case Index of
    0: Result := FFirstRow;
    1: Result := 0;
    2: Result := FGrid.ColCount -1;
    3: Result := FLastRow;
  end;
end;

procedure Ts0GridRowRect.SetPosition(const Index, Value: Integer);
begin
  case Index of
    0: FFirstRow := Value;
    1: ;
    2: ;
    3: FLastRow  := Value;
  end;
  Change;
end;

{ Ts0GridSingleCell }

constructor Ts0GridSingleCell.Create(AOwner: Ts0CustomGrid);
begin
  inherited Create(AOwner);
  FCol := 0;
  FRow := 0;
end;

destructor Ts0GridSingleCell.Destroy;
begin
  inherited;
end;

function Ts0GridSingleCell.GetKind: K0GridCellRegionKind;
begin
  Result := k0gcrCell;
end;

function Ts0GridSingleCell.GetAsRect: TGridRect;
begin
  Result.Top    := FRow;
  Result.Left   := FCol;
  Result.Right  := FCol;
  Result.Bottom := FRow;
end;

function Ts0GridSingleCell.IsIncluding(const X, Y: Integer): Boolean;
begin
  Result := (X = FCol) and (Y = FRow);
end;

procedure Ts0GridSingleCell.Prepare;
begin
end;

procedure Ts0GridSingleCell.SetAsRect(const Value: TGridRect);
begin
  FCol := Value.Left;
  FRow := Value.Right;
  Change;
end;

procedure Ts0GridSingleCell.SetCol(const Value: Integer);
begin
  FCol := Value;
  Change;
end;

procedure Ts0GridSingleCell.SetRow(const Value: Integer);
begin
  FRow := Value;
  Change;
end;

function Ts0GridSingleCell.GetPosition(const Index: Integer): Integer;
begin
  Result := 0;
  case Index of
    0: Result := FRow;
    1: Result := FCol;
    2: Result := FCol;
    3: Result := FRow;
  end;
end;

procedure Ts0GridSingleCell.SetPosition(const Index, Value: Integer);
begin
  case Index of
    0: FRow := Value;
    1: FCol := Value;
    2: ;
    3: ;
  end;
  Change;
end;

{ Ts0GridWholeRect }

function Ts0GridWholeRect.GetAsRect: TGridRect;
begin
  Result.Left := 0;
  Result.Top := 0;
  Result.Right := FGrid.ColCount -1;
  Result.Bottom := FGrid.RowCount -1;
end;

function Ts0GridWholeRect.GetKind: K0GridCellRegionKind;
begin
  Result := k0gcrWhole;
end;

function Ts0GridWholeRect.GetPosition(const Index: Integer): Integer;
begin
  Result := 0;
  case Index of
    0: Result := 0;
    1: Result := 0;
    2: Result := FGrid.ColCount -1;
    3: Result := FGrid.RowCount -1;
  end;
end;

function Ts0GridWholeRect.IsIncluding(const X, Y: Integer): Boolean;
begin
  Result := True;
end;

procedure Ts0GridWholeRect.SetAsRect(const Value: TGridRect);
begin
end;

procedure Ts0GridWholeRect.SetPosition(const Index, Value: Integer);
begin
end;

{ Ts0CellDecorator }

procedure Ts0CellDecorator.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if not(Source is Ts0CellDecorator) then Exit;
  Top     := Ts0CellDecorator(Source).Top    ;
  Left    := Ts0CellDecorator(Source).Left   ;
  Right   := Ts0CellDecorator(Source).Right  ;
  Bottom  := Ts0CellDecorator(Source).Bottom ;
  Enabled := Ts0CellDecorator(Source).Enabled;
  StripeRow := Ts0CellDecorator(Source).StripeRow;
  Comment := Ts0CellDecorator(Source).Comment;
end;

function Ts0CellDecorator.CanDecorate(ACol, ARow: Integer): Boolean;
begin
  if Enabled then
  begin
    Result := FRegion.IsIncluding(ACol, ARow);
    if StripeRow then
    	Result := Result and IsStripedRow(ARow);
  end
  else
    Result := False;
  if Assigned(FOnCanDecorate) then
  	FOnCanDecorate(Self, ACol, ARow, Result);
end;

function Ts0CellDecorator.IsStripedRow(ARow: Integer): Boolean;
begin
	Result := (ARow mod 2) = 0;
end;

constructor Ts0CellDecorator.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FRegion := NewRegion(k0gcrRect); //inherited Createの後じゃなきゃダメっす。
  FEnabled := True;
end;

destructor Ts0CellDecorator.Destroy;
begin
  FreeAndNil(FRegion);
  inherited;
end;

function Ts0CellDecorator.GetCellsRect: TRect;
var
  r: TGridRect;
begin
  r:= FRegion.AsRect;
  Result := Rect(r.Left, r.Top, r.Right, r.Bottom);
end;

function Ts0CellDecorator.GetOwnerGrid: Ts0CustomStringGrid;
begin
  Result := nil;
  if GetOwnerComponent is Ts0CustomStringGrid then
    Result := Ts0CustomStringGrid( GetOwnerComponent );
end;

procedure Ts0CellDecorator.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  InvalidateGrid;
end;

function Ts0CellDecorator.HasColumn(ACol: Integer): Boolean;
begin
  Result := s0GraphHelper.IsBetween(ACol, Left, Right);
end;

function Ts0CellDecorator.HasRow(ARow: Integer): Boolean;
begin
  Result := s0GraphHelper.IsBetween(ARow, Top, Bottom);
end;

procedure Ts0CellDecorator.DivideByCol(FromIndex, ToIndex: Integer);
var
  l, r: Ts0CellDecorator;
begin
  if Left  < FromIndex then
  begin
    l := Ts0CellDecorator(Self.Clone);
    l.Right := FromIndex - 1;
  end;
  if Right > FromIndex then
  begin
    r := Ts0CellDecorator(Self.Clone);
    r.Left := FromIndex + 1;
  end;
  Self.Left := ToIndex;
  Self.Right := ToIndex;
end;

procedure Ts0CellDecorator.DivideByRow(FromIndex, ToIndex: Integer);
var
  t, b: Ts0CellDecorator;
begin
  if Top  < FromIndex then
  begin
    t := Ts0CellDecorator(Self.Clone);
    t.Bottom := FromIndex - 1;
  end;
  if Bottom > FromIndex then
  begin
    b := Ts0CellDecorator(Self.Clone);
    b.Top := FromIndex + 1;
  end;
  Self.Top    := ToIndex;
  Self.Bottom := ToIndex;
end;


procedure Ts0CellDecorator.SlideByCol(AStart, AEnd: Integer; ADif: Integer);
var
  d: Ts0CellDecorator;
begin
  if ADif = 0 then Exit;
  if ADif > 0 then
  begin
    if (not s0GraphHelper.IsBetween(Left , AStart, AEnd)) and
       (    s0GraphHelper.IsBetween(Right, AStart, AEnd) ) then
    begin
      d := Ts0CellDecorator(Self.Clone);
      d.Right := AStart -1;
      Self.Left := AStart;
    end;
  end
  else
  begin
    if (not s0GraphHelper.IsBetween(Right, AStart, AEnd)) and
       (    s0GraphHelper.IsBetween(Left , AStart, AEnd) ) then
    begin
      d := Ts0CellDecorator(Self.Clone);
      d.Left := AStart +1;
      Self.Right := AEnd;
    end;
  end;
  //
  if s0GraphHelper.IsBetween(Left , AStart, AEnd) and
     s0GraphHelper.IsBetween(Right, AStart, AEnd) then
  begin
    Self.Left  := Self.Left  + ADif;
    Self.Right := Self.Right + ADif;
  end;
end;

procedure Ts0CellDecorator.SlideByRow(AStart, AEnd: Integer; ADif: Integer);
var
  d: Ts0CellDecorator;
begin
  if ADif = 0 then Exit;
  if ADif > 0 then
  begin
    if (not s0GraphHelper.IsBetween(Top   , AStart, AEnd)) and
       (    s0GraphHelper.IsBetween(Bottom, AStart, AEnd) ) then
    begin
      d := Ts0CellDecorator(Self.Clone);
      d.Bottom := AStart -1;
      Self.Top := AStart;
    end;
  end
  else
  begin
    if (not s0GraphHelper.IsBetween(Bottom, AStart, AEnd)) and
       (    s0GraphHelper.IsBetween(Top   , AStart, AEnd) ) then
    begin
      d := Ts0CellDecorator(Self.Clone);
      d.Top := AStart +1;
      Self.Bottom := AEnd;
    end;
  end;
  //
  if s0GraphHelper.IsBetween(Top   , AStart, AEnd) and
     s0GraphHelper.IsBetween(Bottom, AStart, AEnd) then
  begin
    Self.Top    := Self.Top    + ADif;
    Self.Bottom := Self.Bottom + ADif;
  end;
end;

procedure Ts0CellDecorator.InvalidateGrid;
var
  grd: Ts0CustomStringGrid;
begin
  grd := GetOwnerGrid;
  if grd = nil then Exit;
  if csReading in grd.ComponentState then Exit;
  if csLoading in grd.ComponentState then Exit;
  if not grd.HandleAllocated then Exit;
  grd.Invalidate;
end;

procedure Ts0CellDecorator.SetPosition(const Index: Integer; const Value: Integer);
begin
  if Value < 0 then Exit;
  if FRegion = nil then Exit;
  case Index of
    0: FRegion.Top    := Value;
    1: FRegion.Left   := Value;
    2: FRegion.Right  := Value;
    3: FRegion.Bottom := Value;
  end;
  InvalidateGrid;
end;

procedure Ts0CellDecorator.SetDecoRect(const Value: TGridRect);
begin
  FRegion.AsRect := Value;
end;

function Ts0CellDecorator.GetDecoRect: TGridRect;
begin
  Result := FRegion.AsRect;
end;

function Ts0CellDecorator.GetPosition(const Index: Integer): Integer;
begin
  Result := 0;
  if FRegion = nil then Exit;
  case Index of
    0: Result := FRegion.Top   ;
    1: Result := FRegion.Left  ;
    2: Result := FRegion.Right ;
    3: Result := FRegion.Bottom;
  end;
end;

function Ts0CellDecorator.NewRegion(
  AKind: K0GridCellRegionKind): Ts0GridCellRegion;
begin
  Result := g0GridRectClasses[AKind].Create(GetOwnerGrid);
end;

function Ts0CellDecorator.GetRegionKind: K0GridCellRegionKind;
begin
  Result := FRegion.Kind;
end;

procedure Ts0CellDecorator.SetRegionKind(const Value: K0GridCellRegionKind);
var
  old: Ts0GridCellRegion;
begin
  if FRegion.Kind = Value then Exit;
  old := FRegion;
  FRegion := NewRegion(Value);
  FRegion.Assign(old);
  FreeAndNil(old);
end;


procedure Ts0CellDecorator.SetStripeRow(const Value: Boolean);
begin
  FStripeRow := Value;
end;

{ Ts0CellDecorators }

function Ts0CellDecorators.AddDeco(ALeft, ATop, ARight, ABottom: Integer;
  AKind: K0GridCellRegionKind): Ts0CellDecorator;
begin
  Result := Ts0CellDecorator(inherited Add);
  Result.Left := ALeft;
  Result.Top := ATop;
  Result.Right := ARight;
  Result.Bottom := ABottom;
  Result.RegionKind := AKind;
end;

procedure Ts0CellDecorators.ColumnMoved(FromIndex, ToIndex: Integer);
var
  i: Integer;
  lList: TList;
begin
  lList := TList.Create;
  try
    for i := 0 to Self.Count -1 do
    begin
      if not Decorators[i].HasColumn(FromIndex) then Continue;
      Decorators[i].DivideByCol(FromIndex, ToIndex);
      lList.Add(Decorators[i]);
    end;
    for i := 0 to Self.Count -1 do
    begin
      if lList.IndexOf(Decorators[i]) > -1 then Continue;
      if FromIndex < ToIndex then
        Decorators[i].SlideByCol(FromIndex +1, ToIndex, -1)
      else
        Decorators[i].SlideByCol(ToIndex, FromIndex -1,  1);
    end;
  finally
    FreeAndNil(lList);
  end;
end;

constructor Ts0CellDecorators.Create(AOwner: TPersistent;
  AItemClass: Ts0CollectionItemClass);
begin
  inherited Create(AOwner, AItemClass);
  CloneAssign := False;
end;

function Ts0CellDecorators.DecoByPos(ACol, ARow: Integer): Ts0CellDecorator;
var
	i: Integer;
begin
  Result := nil;
	for i := Self.Count -1 downto 0 do
//	for i := 0 to Self.Count -1 do
  begin
    if Decorators[i].CanDecorate(ACol, ARow) then
    begin
      Result := Decorators[i];
      Exit;
    end;
  end;
end;

function Ts0CellDecorators.GetDecorators(
  const Index: Integer): Ts0CellDecorator;
begin
  Result := Ts0CellDecorator(inherited Items[Index]);
end;

function Ts0CellDecorators.GetOwnerGrid: Ts0CustomStringGrid;
begin
  Result := nil;
  if GetOwnerComponent is Ts0CustomStringGrid then
    Result := Ts0CustomStringGrid( GetOwnerComponent );
end;

procedure Ts0CellDecorators.RowMoved(FromIndex, ToIndex: Integer);
var
  i: Integer;
  lList: TList;
begin
  lList := TList.Create;
  try
    for i := 0 to Self.Count -1 do
    begin
      if not Decorators[i].HasRow(FromIndex) then Continue;
      Decorators[i].DivideByRow(FromIndex, ToIndex);
      lList.Add(Decorators[i]);
    end;
    for i := 0 to Self.Count -1 do
    begin
      if lList.IndexOf(Decorators[i]) > -1 then Continue;
      if FromIndex < ToIndex then
        Decorators[i].SlideByRow(FromIndex +1, ToIndex, -1)
      else
        Decorators[i].SlideByRow(ToIndex, FromIndex -1,  1);
    end;
  finally
    FreeAndNil(lList);
  end;
end;

procedure Ts0CellDecorators.SetDecorators(const Index: Integer;
  const Value: Ts0CellDecorator);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CustomDecoStringGrid }

procedure Ts0CustomDecoStringGrid.AddToDecosList(ADecos: Ts0CellDecorators);
begin
  if FDecosList.IndexOf(ADecos) > -1 then Exit;
  FDecosList.Add(ADecos);
end;

procedure Ts0CustomDecoStringGrid.ColumnMoved(FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  inherited ColumnMoved(FromIndex, ToIndex);
  for i := 0 to FDecosList.Count -1 do
  begin
    if not(FDecosList.Items[i] is Ts0CellDecorators) then Continue;
    Ts0CellDecorators(FDecosList.Items[i]).ColumnMoved(FromIndex, ToIndex);
  end;
end;

constructor Ts0CustomDecoStringGrid.Create(AOnwer: TComponent);
begin
  inherited;
  FDecosList := TObjectList.Create(False);
end;

procedure Ts0CustomDecoStringGrid.DecoDestroy(Sender: TObject;
  AItem: Ts0CollectionItem);
begin
end;

destructor Ts0CustomDecoStringGrid.Destroy;
begin
  FreeAndNil(FDecosList);
  inherited;
end;

procedure Ts0CustomDecoStringGrid.GetDecoList(Dest: TObjectList);
var
  i: Integer;
begin
  if Dest = nil then Exit;
  Dest.OwnsObjects := False;
  for i := 0 to FDecosList.Count -1 do
    Dest.Add( FDecosList.Items[i] );
end;

function Ts0CustomDecoStringGrid.GetDecorators(
  ADecosClass: Ts0CellDecoratorsClass): Ts0CellDecorators;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FDecosList.Count -1 do
  begin
    if not (FDecosList.Items[i] is Ts0CellDecorators) then Continue;
    if not FDecosList.Items[i].ClassType.InheritsFrom(ADecosClass) then Continue;
    Result := Ts0CellDecorators(FDecosList.Items[i]);
  end;
end;

procedure Ts0CustomDecoStringGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: Integer;
begin
  inherited Notification(AComponent, Operation);
  if FDecosList = nil then Exit;
  for i := 0 to FDecosList.Count -1 do
  begin
    if not(FDecosList.Items[i] is Ts0Collection) then Continue;
    Ts0Collection(FDecosList.Items[i]).Notification(AComponent, Operation);
  end;
end;

procedure Ts0CustomDecoStringGrid.RemoveFromDecosList(ADecos: Ts0CellDecorators);
begin
  while FDecosList.Remove(ADecos) > -1 do ;
end;

procedure Ts0CustomDecoStringGrid.RowMoved(FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  inherited RowMoved(FromIndex, ToIndex);
  for i := 0 to FDecosList.Count -1 do
  begin
    if not(FDecosList.Items[i] is Ts0CellDecorators) then Continue;
    Ts0CellDecorators(FDecosList.Items[i]).RowMoved(FromIndex, ToIndex);
  end;
end;

procedure Ts0CustomDecoStringGrid.SizeChanged(OldColCount, OldRowCount: Integer);
begin
  inherited SizeChanged(OldColCount, OldRowCount);
end;

end.
