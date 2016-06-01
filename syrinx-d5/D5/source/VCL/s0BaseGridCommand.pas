unit s0BaseGridCommand;
{
$History: s0BaseGridCommand.pas $
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/03/15   Time: 11:38
 * Updated in $/D5/source/VCL
 * Ts0GridCmd_AddRowをRegisterClassするようにした。
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/02/05   Time: 4:28
 * Updated in $/source/D5Integrated
 * Ts0GridCmd_AddRow.CoreExecuteでExecAddRowメソッドを呼び出すように変更
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/01/30   Time: 17:33
 * Updated in $/source/D5Integrated
 * Ts0GridCmd_AddRowを追加
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/12/10   Time: 17:39
 * Updated in $/source/D5Integrated
 * 大リファクタリング後、グリッドがやーっと安定しました。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/12/07   Time: 14:36
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/12/06   Time: 20:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/11/23   Time: 6:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/11/22   Time: 18:40
 * Updated in $/source/D5Integrated
 * Ts0ChangeCellSizeのSelectionHeightプロパティのデフォルトを変更
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/04   Time: 12:24
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/04   Time: 0:09
 * Updated in $/source/D5Integrated
 * IncludeFixedCols、IncludeFixedRowsのデフォルト値を変更
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/01   Time: 9:08
 * Updated in $/source/D5Integrated
 * Ts0ShowAllColumnsクラスを追加。
 * Ts0ChangeCellSizeの行を移動したときと、列を移動したときの処理を分離した
 * 。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0ChangeCellSizeのSelectWidthプロパティのデフォルト値を０にした。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/28   Time: 15:52
 * Updated in $/source/D5Integrated
 * Ts0ChangeCellSizeクラスを追加
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/07   Time: 3:06
 * Updated in $/source/D5Integrated
 * Ts0MoveCellKeyDownを追加
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/06   Time: 21:18
 * Updated in $/source/D5Integrated
 * ShortCutのデフォルト値を設定
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0control/p0grid
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/30   Time: 23:58
 * Updated in $/source/p0control/p0grid
 * Ts0GridCmd_InsertCol、Ts0GridCmd_RemoveColを追加
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/30   Time: 15:05
 * Updated in $/source/p0control/p0grid
 * SetAutoNumbering、SetNumberingColを修正
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/30   Time: 10:15
 * Created in $/source/p0control/p0grid
 * 新規作成
}
interface

uses
  Windows, {Messages,} SysUtils, Classes, Controls,
  Masks,
  s0Grids,
  s0CtrlEventSnatcher,
  s0CommonTypes,
  s0Matrix,
  s0BaseGrid;


type
  Ts0GridNumbering = class(Ts0GridCommand)
  private
    FAutoNumbering: Boolean;
    FNumberingCol: Integer;
    procedure SetAutoNumbering(const Value: Boolean);
    procedure SetNumberingCol(const Value: Integer);
  protected
    procedure CoreExecute; override;
    function ForMenuItem: Boolean; override;
    procedure GridSizeChanged(OldColCount, OldRowCount: Longint); override;
    procedure Numbering(ACol: Integer; AOrigin: Integer = 1); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    class function GetCommandName: string; override;
  published
    property AutoNumbering: Boolean read FAutoNumbering write SetAutoNumbering default False;
    property NumberingCol: Integer read FNumberingCol write SetNumberingCol default 0;
  end;


type
  K0GridSortEvent = procedure(Sender: TObject; ARect: TGridRect) of object;

type
  Ts0CustomGridSorter = class(Ts0GridCommand)
  private
    FSortOnClickFixedCell: Boolean;
    FSortReverse: Boolean;
    FSortColIndex: Integer;
    FOnAfterSort: K0GridSortEvent;
    FOnBeforeSort: K0GridSortEvent;
    procedure SetSortOnClickFixedCell(const Value: Boolean);
    procedure SetSortReverse(const Value: Boolean);
    procedure SetSortColIndex(const Value: Integer);
  protected
    procedure CoreExecute; override;
    procedure DoBeforeSort(ARect: TGridRect);
    procedure DoAfterSort(ARect: TGridRect);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure SortPart(ARect: TGridRect); virtual;
    class function GetCommandName: string; override;
  published
    property Reverse : Boolean read FSortReverse write SetSortReverse default False;
    property SortOnClickFixedCell: Boolean read FSortOnClickFixedCell write SetSortOnClickFixedCell default True;
    property SortColIndex: Integer read FSortColIndex write SetSortColIndex;
  published
    property OnBeforeSort: K0GridSortEvent read FOnBeforeSort write FOnBeforeSort;
    property OnAfterSort  : K0GridSortEvent read FOnAfterSort   write FOnAfterSort  ;
  end;


type
  K0GridFindEvent = procedure(Sender: TObject; ACol, ARow: Integer; var Accept: Boolean) of object;

type
  Ts0CustomGridCellFinder = class(Ts0GridCommand)
  private
    FFindColRowIndex: Integer;
    FOnCustomFind: K0GridFindEvent;
    FFindOrientation: K0GUIOrientation;
    FFindMask: string;
    FFindArea: TGridRect;
    function GetFindValue(const AIndex: Integer): string;
    procedure SetFindArea(const Value: TGridRect);
    procedure SetFindColRowIndex(const Value: Integer);
    procedure SetFindOrientation(const Value: K0GUIOrientation);
  protected
    FMaskToFind: TMask;
    FIndexToFind: Integer;
    procedure CoreExecute; override;
    procedure SeekToFind(APrev: Boolean);
    procedure DoCustomFind(ACol, ARow: Integer; var AMatch: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    class function GetCommandName: string; override;
  public
    property FindArea: TGridRect read FFindArea write SetFindArea;
    property FindColRowIndex: Integer read FFindColRowIndex write SetFindColRowIndex;
    property FindMask: string read FFindMask write FFindMask;
    property FindValue[const AIndex: Integer]: string read GetFindValue;
    procedure FindFirst;
    procedure FindNext;
    procedure FindPrev;
  published
    property FindOrientation: K0GUIOrientation read FFindOrientation write SetFindOrientation default k0goVertical;
    property OnCustomFind: K0GridFindEvent read FOnCustomFind write FOnCustomFind;
  end;


type
  K0GridActionKind = (k0gakCut, k0gakCopy, k0gakPaste, k0gakDelete, k0gakSelectAll, k0gakInsertRow, k0gakRemoveRow);
  K0GridActionKindSet = set of K0GridActionKind;

type
  Ts0GridEditCommand = class(Ts0GridCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_AddRow = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_CopyToClipBoard = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanExecute: Boolean; override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_CutToClipBoard = class(Ts0GridCmd_CopyToClipBoard)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_DeleteSelection = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanExecute: Boolean; override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_InsertCol = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_InsertRow = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_PasteFromClipBoard = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanExecute: Boolean; override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_RemoveCol = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanExecute: Boolean; override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_RemoveRow = class(Ts0GridEditCommand)
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanExecute: Boolean; override;
    class function GetCommandName: string; override;
  end;

type
  Ts0GridCmd_SelectAll = class(Ts0GridEditCommand)
  private
    FIncludeFixedCols: Boolean;
    FIncludeFixedRows: Boolean;
  protected
    procedure CoreExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetCommandName: string; override;
  published
    property IncludeFixedCols: Boolean read FIncludeFixedCols write FIncludeFixedCols default False;
    property IncludeFixedRows: Boolean read FIncludeFixedRows write FIncludeFixedRows default False;
  end;


type
  K0MoveCellOrientation = (
    k0mcoHorz, k0mcoHorzEndStop, k0cmoVert, k0cmoVertEndStop );

  K0K0MoveCellKeyKind = (k0mckkReturn, k0mckkTab, k0mckkSpace);


type
  Ts0MoveCellKeyDown = class(Ts0GridCommand)
  private
    FOrientation: K0MoveCellOrientation;
    FOnKeyDown: TKeyEvent;
    FMoveKey: K0K0MoveCellKeyKind;
    FMoveShift: TShiftState;
  protected
    procedure CoreExecute; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function ForMenuItem: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    class function GetCommandName: string; override;
  published
    property MoveKey: K0K0MoveCellKeyKind read FMoveKey write FMoveKey default k0mckkReturn;
    property MoveShift: TShiftState read FMoveShift write FMoveShift default [];
    property Orientation: K0MoveCellOrientation read FOrientation write FOrientation default k0cmoVert;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
  end;

type
  Ts0ChangeCellSize = class(Ts0GridCommand)
  private
    FSelCol: Integer;
    FSelRow: Integer;
    FSelectionWidth: Integer;
    FSelectionHeight: Integer;
    FBufWidth: Integer;
    FBufHeight: Integer;
    procedure SetSelectionHeight(const Value: Integer);
    procedure SetSelectionWidth(const Value: Integer);
  protected
    procedure CoreExecute; override;
    function ForMenuItem: Boolean; override;
    procedure LoadFromBufOfCol(ACol: Integer);
    procedure LoadFromBufOfRow(ARow: Integer);
    procedure SaveToBufOfCol(ACol: Integer);
    procedure SaveToBufOfRow(ARow: Integer);
    procedure SetSizeToGridOfCol(ACol: Integer; AWidth: Integer);
    procedure SetSizeToGridOfRow(ARow: Integer; AHeight: Integer);
  protected
    procedure GridColWidthChanged; override;
    procedure GridRowHeightChanged; override;
    procedure DoChangeCurrent(ANewCol, ANewRow: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    class function GetCommandName: string; override;
  published
    property SelectionWidth: Integer read FSelectionWidth write SetSelectionWidth default 0;
    property SelectionHeight: Integer read FSelectionHeight write SetSelectionHeight default 36;
  end;

type
  Ts0ShowAllColumns = class(Ts0GridCommand)
  private
    FChangingColWidths: Boolean;
    FListener: Ts0CtrlEventListener;
  protected
    procedure CoreExecute; override;
    function ForMenuItem: Boolean; override;
    procedure SetTarget(const Value: Ts0CustomBaseGrid); override;
  protected
    procedure GridResized;
    procedure GridColWidthChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    class function GetCommandName: string; override;
  end;


implementation

uses
  Forms,
  Menus,
  ClipBrd;

resourcestring
  c9CmdName_Numbering          =  'ナンバリング';
  c9CmdName_Sorter             = '並び替え';
  c9CmdName_CellFinder         = '検索(&F)';
  c9CmdName_AddRow             = '行追加';
  c9CmdName_CopyToClipBoard    = 'コピー(&C)';
  c9CmdName_CutToClipBoard     = '切り取り(&T)';
  c9CmdName_DeleteSelection    = '削除(&D)';
  c9CmdName_InsertCol          = '列挿入';
  c9CmdName_InsertRow          = '行挿入';
  c9CmdName_PasteFromClipBoard = '貼り付け(&P)';
  c9CmdName_RemoveCol          = '列削除';
  c9CmdName_RemoveRow          = '行削除';
  c9CmdName_SelectAll          = '全て選択(&A)';
  c9CmdName_MoveCellKeyDown    = 'キーによるセルの移動';
  c9CmdName_ChangeCellSize     = '選択セル列行幅変更';
  c9CmdName_ShowAllColumns     = '全ての列を表示';


{ Ts0GridNumbering }

procedure Ts0GridNumbering.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0GridNumbering) then Exit;
  Self.AutoNumbering := Ts0GridNumbering(Source).AutoNumbering;
  Self.NumberingCol  := Ts0GridNumbering(Source).NumberingCol ;
end;

procedure Ts0GridNumbering.CoreExecute;
begin
  Numbering(FNumberingCol);
end;

constructor Ts0GridNumbering.Create(AOwner: TComponent);
begin
  inherited;
  FAutoNumbering := False;
  FNumberingCol := 0;
end;

function Ts0GridNumbering.ForMenuItem: Boolean;
begin
  Result := False;
end;

class function Ts0GridNumbering.GetCommandName: string;
begin
  Result := c9CmdName_Numbering;
end;

procedure Ts0GridNumbering.GridSizeChanged(OldColCount,
  OldRowCount: Integer);
begin
  Execute;
end;

procedure Ts0GridNumbering.Numbering(ACol, AOrigin: Integer);
var
  i, n: Integer;
begin
  if ACol < 0 then Exit;
  if ACol > Target.ColCount -1 then Exit;
  n := AOrigin;
  for i :=0 to Target.RowCount -1 do
    Target.Cells[ACol, i] := '';
  for i := Target.FixedRows to Target.RowCount -1 do
  begin
    Target.Cells[ACol, i] := IntToStr(n);
    Inc(n);
  end;
end;

procedure Ts0GridNumbering.SetAutoNumbering(const Value: Boolean);
begin
  FAutoNumbering := Value;
  if FAutoNumbering then
    Execute;
end;

procedure Ts0GridNumbering.SetNumberingCol(const Value: Integer);
begin
  FNumberingCol := Value;
  if FAutoNumbering then
    Execute;
end;



{ Ts0CustomGridSorter }

procedure Ts0CustomGridSorter.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0CustomGridSorter) then Exit;
  Self.SortColIndex := Ts0CustomGridSorter(Source).SortColIndex;
  Self.Reverse      := Ts0CustomGridSorter(Source).Reverse;
  Self.SortOnClickFixedCell := Ts0CustomGridSorter(Source).SortOnClickFixedCell;
end;

procedure Ts0CustomGridSorter.CoreExecute;
var
  r: TGridRect;
begin
  r.Left   := 0;
  r.Top    := Target.FixedRows;
  r.Right  := Target.ColCount -1;
  r.Bottom := Target.RowCount -1;
  SortPart(r);
end;

constructor Ts0CustomGridSorter.Create(AOwner: TComponent);
begin
  inherited;
  FSortOnClickFixedCell := True;
  FSortColIndex := -1;
//  FSortedMark := '△';
//  FSortedMarkReverse := '▽';
end;

procedure Ts0CustomGridSorter.DoAfterSort(ARect: TGridRect);
begin
  if Assigned(FOnAfterSort) then
    FOnAfterSort(Self, ARect);
end;

procedure Ts0CustomGridSorter.DoBeforeSort(ARect: TGridRect);
begin
  if Assigned(FOnBeforeSort) then
    FOnBeforeSort(Self, ARect);
end;

class function Ts0CustomGridSorter.GetCommandName: string;
begin
  Result := c9CmdName_Sorter;
end;

procedure Ts0CustomGridSorter.SetSortColIndex(const Value: Integer);
begin
  FSortColIndex := Value;
end;

procedure Ts0CustomGridSorter.SetSortOnClickFixedCell(
  const Value: Boolean);
begin
  FSortOnClickFixedCell := Value;
end;

procedure Ts0CustomGridSorter.SetSortReverse(const Value: Boolean);
begin
  FSortReverse := Value;
end;

procedure Ts0CustomGridSorter.SortPart(ARect: TGridRect);
var
  mtrx: Ts0Matrix;
begin
  DoBeforeSort(ARect);
  Target.BeginUpdateView;
  try
    mtrx := Ts0RowBaseMatrix.Create;
    try
      Target.SaveToMatrixByRect(mtrx, ARect);
      mtrx.SortIndex := SortColIndex - ARect.Left;
      mtrx.Sort(Reverse);
      Target.LoadFromMatrixByRect(mtrx, ARect.TopLeft);
      DoAfterSort(ARect);
    finally
      FreeAndNil(mtrx);
    end;
  finally
    Target.EndUpdateView;
  end;
end;
        
{ Ts0CustomGridCellFinder }

procedure Ts0CustomGridCellFinder.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0CustomGridCellFinder) then Exit;
  Self.FindArea := Ts0CustomGridCellFinder(Source).FindArea;
  Self.FindMask := Ts0CustomGridCellFinder(Source).FindMask;
  Self.FindColRowIndex := Ts0CustomGridCellFinder(Source).FindColRowIndex;
  Self.FindOrientation := Ts0CustomGridCellFinder(Source).FindOrientation;
end;

procedure Ts0CustomGridCellFinder.CoreExecute;
begin
  FindFirst;
end;

constructor Ts0CustomGridCellFinder.Create(AOwner: TComponent);
begin
  inherited;
  FFindOrientation := k0goVertical;
  ShortCut := Menus.ShortCut(Word('F'), [ssCtrl]);
end;

procedure Ts0CustomGridCellFinder.DoCustomFind(ACol, ARow: Integer;
  var AMatch: Boolean);
begin
  if Assigned(FOnCustomFind) then
    FOnCustomFind(Self, ACol, ARow, AMatch);
end;

procedure Ts0CustomGridCellFinder.FindFirst;
begin
  FreeAndNil(FMaskToFind);
  case FFindOrientation of
    k0goHorizontal: FIndexToFind := FFindArea.Left;
    k0goVertical  : FIndexToFind := FFindArea.Top;
  end;
  FMaskToFind := TMask.Create(FFindMask);
  SeekToFind(False);
end;

procedure Ts0CustomGridCellFinder.FindNext;
begin
  if FMaskToFind = nil then Exit;
  case FFindOrientation of
    k0goHorizontal: FIndexToFind := Target.Col;
    k0goVertical  : FIndexToFind := Target.Row;
  end;
  Inc(FIndexToFind);
  SeekToFind(False);
end;

procedure Ts0CustomGridCellFinder.FindPrev;
begin
  if FMaskToFind = nil then Exit;
  case FFindOrientation of
    k0goHorizontal: FIndexToFind := Target.Col;
    k0goVertical  : FIndexToFind := Target.Row;
  end;
  Dec(FIndexToFind);
  SeekToFind(True);
end;

class function Ts0CustomGridCellFinder.GetCommandName: string;
begin
  Result := c9CmdName_CellFinder;
end;

function Ts0CustomGridCellFinder.GetFindValue(
  const AIndex: Integer): string;
begin
  Result := '';
  case FFindOrientation of
    k0goHorizontal: Result := Target.Cells[AIndex, FFindColRowIndex];
    k0goVertical  : Result := Target.Cells[FFindColRowIndex, AIndex];
  end;
end;

procedure Ts0CustomGridCellFinder.SeekToFind(APrev: Boolean);
  function IsLoopEnd: Boolean;
  begin
    Result := True;
    if APrev then
    begin
      case FFindOrientation of
        k0goHorizontal: Result := FIndexToFind < FFindArea.Left;
        k0goVertical  : Result := FIndexToFind < FFindArea.Top;
      end;
    end
    else
    begin
      case FFindOrientation of
        k0goHorizontal: Result := FIndexToFind > FFindArea.Right;
        k0goVertical  : Result := FIndexToFind > FFindArea.Bottom;
      end;
    end;
  end;
  function MatchValue: Boolean;
  begin
    Result := FMaskToFind.Matches( FindValue[FIndexToFind] );
    case FFindOrientation of
      k0goHorizontal: DoCustomFind(FIndexToFind, FFindColRowIndex, Result);
      k0goVertical  : DoCustomFind(FFindColRowIndex, FIndexToFind, Result);
    end;
  end;
begin
  if FMaskToFind = nil then Exit;
  while IsLoopEnd do
  begin
    if FMaskToFind.Matches( FindValue[FIndexToFind] ) then
    begin
      case FFindOrientation of
        k0goHorizontal: Target.Col := FIndexToFind;
        k0goVertical  : Target.Row := FIndexToFind;
      end;
      Exit;
    end;
    if APrev then
      Dec(FIndexToFind)
    else
      Inc(FIndexToFind);
  end;
end;

procedure Ts0CustomGridCellFinder.SetFindArea(const Value: TGridRect);
begin
  FFindArea := Value;
end;

procedure Ts0CustomGridCellFinder.SetFindColRowIndex(const Value: Integer);
begin
  FFindColRowIndex := Value;
  case FFindOrientation of
    k0goHorizontal:
      if FFindColRowIndex < Target.FixedRows then
        FFindColRowIndex := Target.FixedRows
      else
      if FFindColRowIndex > Target.RowCount -1 then
        FFindColRowIndex := Target.RowCount -1;

    k0goVertical:
      if FFindColRowIndex < Target.FixedCols then
        FFindColRowIndex := Target.FixedCols
      else
      if FFindColRowIndex > Target.ColCount -1 then
        FFindColRowIndex := Target.ColCount -1;
  end;
end;

procedure Ts0CustomGridCellFinder.SetFindOrientation(
  const Value: K0GUIOrientation);
begin
  FFindOrientation := Value;
end;

{ Ts0GridEditCommand }

procedure Ts0GridEditCommand.CoreExecute;
begin
  inherited;
end;

constructor Ts0GridEditCommand.Create(AOwner: TComponent);
begin
  inherited;
  if Self.ClassType = Ts0GridEditCommand then
    Self.RaiseCannotCreate;
end;

class function Ts0GridEditCommand.GetCommandName: string;
begin
  Result := '編集系';
end;

{ Ts0GridCmd_AddRow }

procedure Ts0GridCmd_AddRow.CoreExecute;
begin
  Target.ExecAddRow(Target.Selection.Bottom - Target.Selection.Top + 1);
end;

constructor Ts0GridCmd_AddRow.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(VK_INSERT, [ssCtrl]);
end;

class function Ts0GridCmd_AddRow.GetCommandName: string;
begin
  Result := c9CmdName_AddRow;
end;

{ Ts0GridCmd_CopyToClipBoard }

function Ts0GridCmd_CopyToClipBoard.CanExecute: Boolean;
begin
  Result := (inherited CanExecute);
end;

procedure Ts0GridCmd_CopyToClipBoard.CoreExecute;
var
  mtrx: Ts0Matrix;
  ss: TStringStream;
begin
//  if CanCopyToClipBoard then Exit;
  mtrx := Ts0RowBaseMatrix.Create;
  try
    Target.SaveToMatrixByRect(mtrx, Target.Selection);
    ss := TStringStream.Create('');
    try
      mtrx.SaveToStream(ss, #9, '"');
      Clipboard.AsText := ss.DataString;
    finally
      FreeAndNil(ss);
    end;
  finally
    FreeAndNil(mtrx);
  end;
end;

constructor Ts0GridCmd_CopyToClipBoard.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(Word('C'), [ssCtrl]);
end;

class function Ts0GridCmd_CopyToClipBoard.GetCommandName: string;
begin
  Result := c9CmdName_CopyToClipBoard;
end;

{ Ts0GridCmd_CutToClipBoard }

procedure Ts0GridCmd_CutToClipBoard.CoreExecute;
begin
  inherited CoreExecute;
  Target.DeleteRect(Target.Selection);
end;

constructor Ts0GridCmd_CutToClipBoard.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(Word('X'), [ssCtrl]);
end;

class function Ts0GridCmd_CutToClipBoard.GetCommandName: string;
begin
  Result := c9CmdName_CutToClipBoard;
end;

{ Ts0GridCmd_DeleteSelection }

function Ts0GridCmd_DeleteSelection.CanExecute: Boolean;
begin
  Result := (inherited CanExecute); // and (not Target.InplaceEditor.Focused);
end;

procedure Ts0GridCmd_DeleteSelection.CoreExecute;
begin
  Target.DeleteRect(Target.Selection);
end;

constructor Ts0GridCmd_DeleteSelection.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(VK_DELETE, []);
end;

class function Ts0GridCmd_DeleteSelection.GetCommandName: string;
begin
  Result := c9CmdName_DeleteSelection;
end;

{ Ts0GridCmd_InsertCol }

procedure Ts0GridCmd_InsertCol.CoreExecute;
begin
  Target.ExecInsertCol(Target.Col, Target.Selection.Right - Target.Selection.Left + 1);
end;

constructor Ts0GridCmd_InsertCol.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(VK_INSERT, [ssShift, ssCtrl]);
end;

class function Ts0GridCmd_InsertCol.GetCommandName: string;
begin
  Result := c9CmdName_InsertCol;
end;

{ Ts0GridCmd_InsertRow }

procedure Ts0GridCmd_InsertRow.CoreExecute;
begin
  Target.ExecInsertRow(Target.Row, Target.Selection.Bottom - Target.Selection.Top + 1);
end;

constructor Ts0GridCmd_InsertRow.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(VK_INSERT, [ssAlt, ssCtrl]);
end;

class function Ts0GridCmd_InsertRow.GetCommandName: string;
begin
  Result := c9CmdName_InsertRow;
end;

{ Ts0GridCmd_PasteFromClipBoard }

function Ts0GridCmd_PasteFromClipBoard.CanExecute: Boolean;
begin
  Result := (inherited CanExecute);
end;

procedure Ts0GridCmd_PasteFromClipBoard.CoreExecute;
var
  mtrx: Ts0Matrix;
  ss: TStringStream;
  sel: TGridCoord;
  r: TGridRect;
begin
//  if CanPasteFromClipBoard then Exit;
  if not Clipboard.HasFormat(CF_TEXT) then Exit;
  sel.X := Target.Col;
  sel.Y := Target.Row;
  Target.BeginUpdateView;
  try
    mtrx := Ts0RowBaseMatrix.Create;
    try
      ss := TStringStream.Create(Clipboard.AsText);
      try
        mtrx.LoadFromStream(ss, #9);
      finally
        FreeAndNil(ss);
      end;
      r.TopLeft := sel;
      r.Bottom := sel.Y + mtrx.RowCount -1;
      r.Right  := sel.X + mtrx.ColCount -1;
      Target.LoadFromMatrixByRect(mtrx, sel);
    finally
      FreeAndNil(mtrx);
    end;
  finally
    Target.EndUpdateView;
  end;
end;


constructor Ts0GridCmd_PasteFromClipBoard.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(Word('V'), [ssCtrl]);
end;

class function Ts0GridCmd_PasteFromClipBoard.GetCommandName: string;
begin
  Result := c9CmdName_PasteFromClipBoard;
end;

{ Ts0GridCmd_RemoveCol }

function Ts0GridCmd_RemoveCol.CanExecute: Boolean;
begin
  Result := (inherited CanExecute);
end;

procedure Ts0GridCmd_RemoveCol.CoreExecute;
begin
  Target.ExecRemoveCol(Target.Selection.Left, Target.Selection.Right - Target.Selection.Left + 1);
end;

constructor Ts0GridCmd_RemoveCol.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(VK_DELETE, [ssShift, ssCtrl]);
end;

class function Ts0GridCmd_RemoveCol.GetCommandName: string;
begin
  Result := c9CmdName_RemoveCol;
end;

{ Ts0GridCmd_RemoveRow }

function Ts0GridCmd_RemoveRow.CanExecute: Boolean;
begin
  Result := (inherited CanExecute);
end;

procedure Ts0GridCmd_RemoveRow.CoreExecute;
begin
  Target.ExecRemoveRow(Target.Selection.Top, Target.Selection.Bottom - Target.Selection.Top + 1);
end;

constructor Ts0GridCmd_RemoveRow.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := Menus.ShortCut(VK_DELETE, [ssCtrl]);
end;

class function Ts0GridCmd_RemoveRow.GetCommandName: string;
begin
  Result := c9CmdName_RemoveRow;
end;

{ Ts0GridCmd_SelectAll }

procedure Ts0GridCmd_SelectAll.CoreExecute;
var
  r: TGridRect;
begin
  if FIncludeFixedRows then r.Top  := 0 else r.Top  := Target.FixedRows;
  if FIncludeFixedCols then r.Left := 0 else r.Left := Target.FixedCols;
  r.Right  := Target.ColCount -1;
  r.Bottom := Target.RowCount -1;
  Target.Selection := r;
end;


constructor Ts0GridCmd_SelectAll.Create(AOwner: TComponent);
begin
  inherited;
  FIncludeFixedCols := False;
  FIncludeFixedRows := False;
  ShortCut := Menus.ShortCut(Word('A'), [ssCtrl]);
end;

class function Ts0GridCmd_SelectAll.GetCommandName: string;
begin
  Result := c9CmdName_SelectAll;
end;

{ Ts0MoveCellKeyDown }

procedure Ts0MoveCellKeyDown.Assign(Source: TPersistent);
begin
  inherited;
end;

procedure Ts0MoveCellKeyDown.CoreExecute;
var
  x, y: Integer;
begin
  if Target = nil then Exit;
  x := Target.Col;
  y := Target.Row;
  case FOrientation of
    k0mcoHorz,
    k0cmoVert:
      if (x >= Target.ColCount -1) and
         (y >= Target.RowCount -1) then Exit;
  end;
  case FOrientation of
    k0mcoHorz,
    k0mcoHorzEndStop: x := x +1;
    k0cmoVert,
    k0cmoVertEndStop: y := y +1;
  end;
  case FOrientation of
    k0mcoHorz:
    begin
      if x > Target.ColCount -1 then
      begin
        x := Target.FixedCols;
        y := y + 1;
        if y > Target.RowCount -1 then
          y := Target.RowCount -1;
      end;
    end;
    k0mcoHorzEndStop:
      if x > Target.ColCount -1 then
        x := Target.ColCount -1;
    k0cmoVert:
    begin
      if y > Target.RowCount -1 then
      begin
        y := Target.FixedRows;
        x := x + 1;
        if x > Target.ColCount -1 then
          x := Target.ColCount -1;
      end;
    end;
    k0cmoVertEndStop:
      if y > Target.RowCount -1 then
        y := Target.RowCount -1;
  end;
  Target.Col := x;
  Target.Row := y;
end;

constructor Ts0MoveCellKeyDown.Create(AOwner: TComponent);
begin
  inherited;
  FOrientation := k0cmoVert;
  FMoveKey := k0mckkReturn;
  FMoveShift := [];
end;

function Ts0MoveCellKeyDown.ForMenuItem: Boolean;
begin
  Result := False;
end;

class function Ts0MoveCellKeyDown.GetCommandName: string;
begin
  Result := c9CmdName_MoveCellKeyDown;
end;

procedure Ts0MoveCellKeyDown.KeyDown(var Key: Word; Shift: TShiftState);
const
  c9MoveKeys: array[K0K0MoveCellKeyKind] of Word= (
    VK_RETURN, VK_TAB, VK_SPACE
  );
begin
  if Assigned(FOnKeyDown) then
    FOnKeyDown(Self, Key, Shift);
  if (Key = c9MoveKeys[FMoveKey]) and (Shift = MoveShift) then
    Execute;
end;

{ Ts0ChangeCellSize }

procedure Ts0ChangeCellSize.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0ChangeCellSize) then Exit;
  SelectionWidth := Ts0ChangeCellSize(Source).SelectionWidth;
  SelectionHeight := Ts0ChangeCellSize(Source).SelectionHeight;
end;

procedure Ts0ChangeCellSize.CoreExecute;
begin
end;

constructor Ts0ChangeCellSize.Create(AOwner: TComponent);
begin
  inherited;
  FSelectionWidth := 0;
  FSelectionHeight := 72;
  if Target = nil then Exit;
  SaveToBufOfCol(Target.Col);
  SaveToBufOfRow(Target.Row);
  FSelCol := Target.Col;
  FSelRow := Target.Row;
end;

procedure Ts0ChangeCellSize.DoChangeCurrent(ANewCol, ANewRow: Integer);
begin
  if not Enabled then Exit;
  Target.BeginUpdateView;
  try
    if (ANewCol <> FSelCol) and (ANewRow = FSelRow) then
    begin
      LoadFromBufOfCol(FSelCol);
      SaveToBufOfCol(ANewCol);
      SetSizeToGridOfCol(ANewCol, SelectionWidth);
    end
    else
    if (ANewCol = FSelCol) and (ANewRow <> FSelRow) then
    begin
      LoadFromBufOfRow(FSelRow);
      SaveToBufOfRow(ANewRow);
      SetSizeToGridOfRow(ANewRow, SelectionHeight);
    end
    else
    begin
      LoadFromBufOfCol(FSelCol);
      LoadFromBufOfRow(FSelRow);
      SaveToBufOfCol(ANewCol);
      SaveToBufOfRow(ANewRow);
      SetSizeToGridOfCol(ANewCol, SelectionWidth);
      SetSizeToGridOfRow(ANewRow, SelectionHeight);
    end;
    FSelCol := ANewCol;
    FSelRow := ANewRow;
  finally
    Target.EndUpdateView;
  end;
end;

function Ts0ChangeCellSize.ForMenuItem: Boolean;
begin
  Result := False;
end;

class function Ts0ChangeCellSize.GetCommandName: string;
begin
  Result := c9CmdName_ChangeCellSize;
end;

procedure Ts0ChangeCellSize.GridColWidthChanged;
begin
end;

procedure Ts0ChangeCellSize.GridRowHeightChanged;
begin
end;

procedure Ts0ChangeCellSize.LoadFromBufOfCol(ACol: Integer);
begin
  SetSizeToGridOfCol(ACol, FBufWidth);
end;

procedure Ts0ChangeCellSize.LoadFromBufOfRow(ARow: Integer);
begin
  SetSizeToGridOfRow(ARow, FBufHeight);
end;

procedure Ts0ChangeCellSize.SaveToBufOfCol(ACol: Integer);
begin
  if (ACol > -1) and (ACol < Target.ColCount) then
    FBufWidth := Target.ColWidths[ACol];
end;

procedure Ts0ChangeCellSize.SaveToBufOfRow(ARow: Integer);
begin
  if (ARow > -1) and (ARow < Target.RowCount) then
    FBufHeight := Target.RowHeights[ARow];
end;

procedure Ts0ChangeCellSize.SetSelectionHeight(const Value: Integer);
begin
  FSelectionHeight := Value;
end;

procedure Ts0ChangeCellSize.SetSelectionWidth(const Value: Integer);
begin
  FSelectionWidth := Value;
end;

procedure Ts0ChangeCellSize.SetSizeToGridOfCol(ACol, AWidth: Integer);
begin
  //if Target.UpdateViewCount > 0 then Exit;
  Target.BeginUpdateView;
  try
    if (ACol > -1) and (ACol < Target.ColCount) and (AWidth > 0) then
      if Target.ColWidths[ACol] <> AWidth then
        Target.ColWidths[ACol] := AWidth;
  finally
    Target.EndUpdateView;
  end;
end;

procedure Ts0ChangeCellSize.SetSizeToGridOfRow(ARow, AHeight: Integer);
begin
  //if Target.UpdateViewCount > 0 then Exit;
  Target.BeginUpdateView;
  try
    if (ARow > -1) and (ARow < Target.RowCount) and (AHeight > 0) then
      if Target.RowHeights[ARow] <> AHeight then
        Target.RowHeights[ARow] := AHeight;
  finally
    Target.EndUpdateView;
  end;
end;


type
  T9GridEventsListener = class(Ts0CtrlEventListener)
  private
    FOwner: TComponent;
  protected
    procedure CtrlOnResize(Sender: TObject); override;
  end;

{ T9GridEventsListener }

procedure T9GridEventsListener.CtrlOnResize(Sender: TObject);
begin
  if FOwner is Ts0ShowAllColumns then
    Ts0ShowAllColumns(FOwner).GridResized;
end;

{ Ts0ShowAllColumns }

procedure Ts0ShowAllColumns.Assign(Source: TPersistent);
begin
  inherited;
end;

procedure Ts0ShowAllColumns.CoreExecute;
begin
end;

constructor Ts0ShowAllColumns.Create(AOwner: TComponent);
begin
  inherited;
  FListener := T9GridEventsListener.Create;
  T9GridEventsListener(FListener).FOwner := Self;
end;

destructor Ts0ShowAllColumns.Destroy;
begin
  FreeAndNil(FListener);
  inherited;            
end;

function Ts0ShowAllColumns.ForMenuItem: Boolean;
begin
  Result := False;
end;

class function Ts0ShowAllColumns.GetCommandName: string;
begin
  Result := c9CmdName_ShowAllColumns;
end;

procedure Ts0ShowAllColumns.GridColWidthChanged;
const
  c9Min_CclWidth = 25;
var
  WidthGap: Integer;
  ColIndex: Integer;
begin
  if not Enabled then Exit;
  if FChangingColWidths then Exit;
  FChangingColWidths := True;
  try
    WidthGap := Target.Columns.AllColWidth - Target.ClientWidth;
    ColIndex := Target.ColCount - 1;
    if WidthGap < 0 then
    begin
      Target.ColWidths[ColIndex] := Target.ColWidths[ColIndex] - WidthGap;
    end;
    while WidthGap > 0 do
    begin
      if Target.ColWidths[ColIndex] - WidthGap < c9Min_CclWidth then
        Target.ColWidths[ColIndex] := c9Min_CclWidth
      else
        Target.ColWidths[ColIndex] := Target.ColWidths[ColIndex] - WidthGap - Target.GridLineWidth;

      ColIndex := ColIndex - 1;
      if ColIndex < 0 then
      begin
        Exit;
      end;
      WidthGap := Target.Columns.AllColWidth - Target.ClientWidth;
    end;
  finally
    FChangingColWidths := False;
  end;
end;

procedure Ts0ShowAllColumns.GridResized;
var
  WidthGap: Integer;
  ColIndex: Integer;
begin
  if not Enabled then Exit;
  if not Target.HandleAllocated then Exit;
  WidthGap := Target.Columns.AllColWidth - Target.ClientWidth;
  ColIndex := Target.ColCount - 1;
  if WidthGap < 0 then
  begin
    Target.ColWidths[ColIndex] := Target.ColWidths[ColIndex] - WidthGap
  end
  else
  begin
    GridColWidthChanged;
  end;
end;

procedure Ts0ShowAllColumns.SetTarget(const Value: Ts0CustomBaseGrid);
begin
  if Target <> nil then
    Ts0CtrlEventSnatcher.Instance.UnRegisterListener(Target, FListener);
  inherited SetTarget(Value);
  if Target <> nil then
    Ts0CtrlEventSnatcher.Instance.RegisterListener(Target, FListener);
end;

initialization
  Ts0GridCommand.RegisterClass( Ts0GridNumbering              );
  Ts0GridCommand.RegisterClass( Ts0CustomGridSorter           );
  Ts0GridCommand.RegisterClass( Ts0CustomGridCellFinder       );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_AddRow             );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_CopyToClipBoard    );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_CutToClipBoard     );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_DeleteSelection    );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_InsertCol          );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_InsertRow          );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_PasteFromClipBoard );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_RemoveCol          );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_RemoveRow          );
  Ts0GridCommand.RegisterClass( Ts0GridCmd_SelectAll          );
  Ts0GridCommand.RegisterClass( Ts0MoveCellKeyDown            );
  Ts0GridCommand.RegisterClass( Ts0ChangeCellSize             );
  Ts0GridCommand.RegisterClass( Ts0ShowAllColumns             );

finalization
  Ts0GridCommand.UnRegisterClass( Ts0GridNumbering              );
  Ts0GridCommand.UnRegisterClass( Ts0CustomGridSorter           );
  Ts0GridCommand.UnRegisterClass( Ts0CustomGridCellFinder       );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_AddRow             );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_CopyToClipBoard    );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_CutToClipBoard     );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_DeleteSelection    );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_InsertCol          );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_InsertRow          );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_PasteFromClipBoard );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_RemoveCol          );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_RemoveRow          );
  Ts0GridCommand.UnRegisterClass( Ts0GridCmd_SelectAll          );
  Ts0GridCommand.UnRegisterClass( Ts0MoveCellKeyDown            );
  Ts0GridCommand.UnRegisterClass( Ts0ChangeCellSize             );
  Ts0GridCommand.UnRegisterClass( Ts0ShowAllColumns             );

end.
