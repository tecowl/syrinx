unit s0BaseGrid;
{
$History: s0BaseGrid.pas $
 * 
 * *****************  Version 39  *****************
 * User: Akima        Date: 02/03/14   Time: 21:37
 * Updated in $/D5/source/VCL
 * Ts0GridCmdMenuItemÇÉRÉìÉ|Å[ÉlÉìÉgÉpÉåÉbÉgÇ…ìoò^
 * 
 * *****************  Version 38  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 37  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * ê⁄ì™é´ÇïœçXÅBxxSXÅ`Ç…ÇµÇΩÅB
 * 
 * *****************  Version 36  *****************
 * User: Akima        Date: 02/02/06   Time: 1:00
 * Updated in $/source/D5Integrated
 * LoadFromMatrixByRectÉÅÉ\ÉbÉhÇ≈ReadOnlyÇÃÉZÉãÇ…ílÇè„èëÇ´ÇµÇ»Ç¢ÇÊÇ§Ç…èC
 * ê≥
 * 
 * *****************  Version 35  *****************
 * User: Akima        Date: 02/02/05   Time: 4:28
 * Updated in $/source/D5Integrated
 * ExecAddRowÉÅÉ\ÉbÉhÇí«â¡
 * 
 * *****************  Version 34  *****************
 * User: Akima        Date: 02/01/28   Time: 17:14
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 33  *****************
 * User: Akima        Date: 02/01/08   Time: 15:14
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 32  *****************
 * User: Akima        Date: 02/01/06   Time: 0:18
 * Updated in $/source/D5Integrated
 * DoubleBufferedÇpublishedÇ…
 * 
 * *****************  Version 31  *****************
 * User: Akima        Date: 01/12/10   Time: 17:39
 * Updated in $/source/D5Integrated
 * ëÂÉäÉtÉ@ÉNÉ^ÉäÉìÉOå„ÅAÉOÉäÉbÉhÇ™Ç‚Å[Ç¡Ç∆à¿íËÇµÇ‹ÇµÇΩÅB
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 01/12/10   Time: 10:45
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 29  *****************
 * User: Akima        Date: 01/12/07   Time: 18:56
 * Updated in $/source/D5Integrated
 * InplaceEditorÇçÌèúÇ∑ÇÈÇ∆Ç¢Ç§ÉrÉbÉOÉäÉtÉ@ÉNÉ^ÉäÉìÉOê¨å˜ÅIÅIÅIÅI
 * s0GridsÇ…èCê≥ëΩêî
 * 
 * Ts0CustomStringGrid 
 *   <|--- Ts0CustomBindGrid
 *     <|--- Ts0CustomBaseGrid
 *       <|--- Ts0CustomDecoGrid
 *         <|--- Ts0CustomCtrlGrid
 *           <|--- Ts0ObjectGrid
 * Ç∆Ç»Ç¡ÇƒÇ¢ÇΩåpè≥ä÷åWÇà»â∫ÇÃÇÊÇ§Ç…ïœçX
 * 
 * Ts0CustomStringGrid 
 *   <|--- Ts0CustomDecoStringGrid (s0CellDecoratorÇ…êVãKçÏê¨)
 *     <|--- Ts0CustomBindGrid
 *       <|--- Ts0CustomCtrlGrid
 *         <|--- Ts0CustomDecoGrid
 *           <|--- Ts0CustomBaseGrid
 *             <|--- Ts0ObjectGrid
 * 
 * èÌÅXInplaceEditorÇ™é◊ñÇÇæÇ»Å[Ç∆évÇ¡ÇƒÇ¢ÇΩÇ™ÅAÉXÉpÉCÉNÇÃÇ¬Ç‡ÇËÇ≈
 * çÌèúÇµÇƒÇ›ÇΩÇÁëÂê¨å˜ÅIÇ‡Ç§InplaceEditorÇ∆CtrlDecoÇÃÉRÉìÉgÉçÅ[ÉãÇ
 * ãÊï ÇµÇ‹ÇπÇÒÅIÇÌÅ[Ç¢ÅBèàóùÇ™ë¨Ç≠Ç»Ç¡ÇΩÇµÅAëSëÃìIÇ…Ç∑Ç¡Ç´ÇËÇµÇΩÇ¡Ç∑ÅB
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 01/12/07   Time: 14:36
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 01/12/06   Time: 22:55
 * Updated in $/source/D5Integrated
 * ÇøÇÂÇ¡Ç∆ÉäÉtÉ@ÉNÉ^ÉäÉìÉOÇµÇΩ
 * Ts0GridModeÇÃì±ì¸
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 01/12/06   Time: 20:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 01/11/23   Time: 6:22
 * Updated in $/source/D5Integrated
 * çsë}ì¸ÅAçsçÌèúÇÃÉçÉWÉbÉNÇå©íºÇµÇΩÅB
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 01/11/13   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 01/11/02   Time: 14:14
 * Updated in $/source/D5Integrated
 * DoClickFixedCellÇÅAÉJÉâÉÄÇÃå≈íËÉZÉãÇâüâ∫ÇµÇΩÇ∆Ç´ÇæÇØÇ≈ÇÕÇ»Ç≠ÅAçsÇÃå≈
 * íËÉZÉãÇâüâ∫ÇµÇΩÇ∆Ç´Ç…Ç‡åƒÇ—èoÇ∑ÇÊÇ§Ç…èCê≥
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 01/10/11   Time: 17:20
 * Updated in $/source/D5Integrated
 * ColCount,RowCount,FixedCols,FixedRowsÇÃpublishedÇ≈ÇÃêÈåæÇÃèáî‘ÇïœçX
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/10/04   Time: 12:24
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/10/03   Time: 0:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/10/02   Time: 3:14
 * Updated in $/source/D5Integrated
 * CreateCmdMenuÉÅÉ\ÉbÉhÇpublicÇ…ÅB
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/10/01   Time: 9:06
 * Updated in $/source/D5Integrated
 * ShowAllColsÉvÉçÉpÉeÉBÇçÌèúÇµÇƒÅACommandÇ∆ÇµÇƒs0BaseGridCommandÇ…í«â¡
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/09/28   Time: 15:51
 * Updated in $/source/D5Integrated
 * SelectCellÅADoChangeCurrentÉÅÉ\ÉbÉhÇ…ä÷Ç∑ÇÈéÊÇËåàÇﬂÇçÏÇ¡ÇΩÅB
 * CommandsÇ…Ç‡DoChangeCurrentÇîzêMÇ∑ÇÈÇÊÇ§Ç…ÇµÇΩÅB
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/09/27   Time: 9:11
 * Updated in $/source/D5Integrated
 * ClearCol, ClearRowÇTs0BindGridÇ…à⁄ìÆ
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/09/18   Time: 11:53
 * Updated in $/source/D5Integrated
 * ColumnMovedÅARowMovedÅANotificationÇ»Ç«Ç≈ÇÃDecoratorsÇåƒÇ—èoÇµÇ
 * Ts0BindGridÇæÇØÇ≈çsÇ§ÇÊÇ§Ç…èCê≥
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/09/07   Time: 3:04
 * Updated in $/source/D5Integrated
 * ÉLÅ[ëÄçÏÅAÉ}ÉEÉXëÄçÏÇÃïsîıÇèCê≥
 * èÁí∑Ç»ÉRÅ[ÉhÇÉäÉtÉ@ÉNÉ^ÉäÉìÉO
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/09/06   Time: 21:18
 * Updated in $/source/D5Integrated
 * Commandä÷åWÇÇøÇÂÇ¡Ç∆â¸ó«ÅB
 * AutoCmdMenuÉvÉçÉpÉeÉBÇí«â¡
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ÉtÉ@ÉCÉãñºÅAÉNÉâÉXñºÇÃå©íºÇµÇ∆ÅAÉpÉbÉPÅ[ÉWç\ë¢ÇÃå©íºÇµÅA
 * VSSÇÃóöóÉ}ÉNÉçÇÃèëÇ©ÇÍÇƒÇ¢Ç»Ç¢ÉtÉ@ÉCÉãÇ…É}ÉNÉçÇí«â¡ÅA
 * óvÇÁÇ»Ç¢ÉtÉ@ÉCÉãÇÃçÌèúÇçsÇ¡ÇΩÅB
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0grid
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0control/p0grid
 * u0GUITypeÇ∆u0GUIViewTypeÇÉäÉtÉ@ÉNÉ^ÉäÉìÉOÇµÇΩåãâ ÅAÇªÇÍÇÁÇîpé~ÇµÅA
 * s0CommonTypesÇ∆ÇµÇƒÇ‹Ç∆ÇﬂÇΩÇÃÇ≈ÅAÇªÇÍÇ…ëŒâûÇµÇΩÅB
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/08/07   Time: 10:38
 * Updated in $/source/p0control/p0grid
 * CellDrawerä÷åWÇc0BndGridÇ÷à⁄ìÆÅB
 * PositionÇ»Ç«ÇÃïsóvÇ»ÉÅÉìÉoÇçÌèúÅB
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/08/06   Time: 14:11
 * Updated in $/source/p0control/p0grid
 * CommandÇ…ShortCutÉvÉçÉpÉeÉBÇ»Ç«Çí«â¡
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/07/30   Time: 23:59
 * Updated in $/source/p0control/p0grid
 * çsë}ì¸ÅAçsçÌèúÇ»Ç«Ç∆ëŒÇ…Ç»ÇÈÇÊÇ§Ç…óÒë}ì¸ÅAóÒçÌèúÇí«â¡
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/07/30   Time: 21:31
 * Updated in $/source/p0control/p0grid
 * ÇøÇ·ÇÒÇ∆NameÉvÉçÉpÉeÉBÇê›íËÇ∑ÇÈÇÊÇ§Ç…ÇµÇΩ
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/07/30   Time: 15:05
 * Updated in $/source/p0control/p0grid
 * çsÇ‚óÒÇÃÉTÉCÉYïœçXíÜÇ©Ç«Ç§Ç©ÇîªífÇ∑ÇÈÇÊÇ§Ç…ÇµÇΩÅB
 * ÉRÉ}ÉìÉhÇÕÅAcsLoadingÇ†ÇÈÇ¢ÇÕcsReadingíÜÇ…é¿çsÇ∑ÇÈÇ∆ÉAÉhÉåÉXà·îΩÇ™ãNÇ´
 * ÇÈÇÃÇ≈ÅAé¿çsÇ≈Ç´Ç»Ç¢ÇÊÇ§Ç…èCê≥ÅB
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/07/30   Time: 10:15
 * Updated in $/source/p0control/p0grid
 * ÇÆÇËÇ¡Ç«ÇÃÉRÉ}ÉìÉhTs0GridCommandÇå„Ç©ÇÁí«â¡Ç≈Ç´ÇÈÇÊÇ§Ç…ïœçX
 * ÇªÇÃëºèCê≥ëΩêîÅB
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/23   Time: 22:29
 * Updated in $/source/p0control/p0grid
 * Tc0StringGridÇÉRÉ} ÉìÉhÇ∆ñ {ëÃÇ…ï™ó£ÅB
* Tc0StringGridÇTs0BaseGridÇ∆â¸ñºÅB
*
* *****************  Version 2  *****************
* User: Akima        Date: 01/07/18   Time: 19:23
* Updated in $/source/p0control/p0grid
*
* *****************  Version 1  *****************
* User: Takima       Date: 01/07/05   Time: 19:03
* Created in $/Projects/Pleiades/source/p0grid
* êVãKí«â¡
* Ç±ÇÍÇÁÇÃÉ\Å[ÉXÇÕÉ`ÉFÉbÉNÉAÉEÉgÇµÇøÇ·É_ÉÅÇ≈Ç∑ÅB
*
* *****************  Version 32  *****************
* User: Hirakawa     Date: 01/06/22   Time: 15:36
* Updated in $/GUI/Source/View
* FixedColsÇ…ÇÊÇÁÇ∏ÅAÉfÅ[É^ÇÃëÄçÏÇçsÇ§ÇÊÇ§Ç…ïœçXÅB
*
* ÅÉÇøÇÂÅ[Ç∂Ç„Å[ÇÊÅ[ÅÑ
* ÉAÉvÉääJî≠é“ÇÕÅAÉOÉäÉbÉhÇ…ä÷òAïtÇØÇƒÇ¢ÇÈÉtÉBÅ[ÉãÉhÇ‚DecoÇ»Ç«ÇïœçXÇ∑ÇÈ
* ïKóvÇ†ÇËÅB
*
* *****************  Version 31  *****************
* User: Hirakawa     Date: 01/06/19   Time: 14:46
* Updated in $/GUI/Source/View
* ÉRÉÅÉìÉgï\é¶ÉRÉ} ÉìÉhí«â¡
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Contnrs,
  Menus,
  s0VCLClasses,
  s0Grids,
  s0CellDecorator,
  s0BindGrid,
  s0CtrlGrid,
  s0DecoGrid,
  s0Matrix,
  s0Observer;

type
  K0InsertModeType = (k0imkPrev, k0imkNext);

type
  K0GridRectChangingEvent = procedure(Sender: TObject; ARect: TGridRect;
    var Able: Boolean) of object;

  K0GridMatrixChangingEvent = procedure(Sender: TObject; AMatrix: Ts0Matrix;
    ARect: TGridRect; var Able: Boolean) of object;

  K0GridRowChangingEvent = procedure(Sender: TObject; ARowIndex: Integer;
    ARowCount: Integer; var Able: Boolean) of object;

  K0GridCellEvent = procedure(Sender: TObject; ACol, ARow: Integer) of object;
  
type
  Ts0GridCommand = class;
  Ts0GridCommandList = class;

  Ts0CustomBaseGridClass = class of Ts0CustomBaseGrid;
  Ts0CustomBaseGrid = class(Ts0CustomDecoGrid)
  private
    FCommands: Ts0GridCommandList;
    FInsertMode: K0InsertModeType;
    FOnClickFixedCell: K0GridCellEvent;
    FOnInsertRow: K0MatrixRowEvent;
    FOnRemoveRow: K0MatrixRowEvent;
    FAlwaysShowScrollBar: TScrollStyle;
    FMultiSelect: Boolean;
    FAutoCmdMenu: Boolean;
    FSelectedPrepared: Boolean;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetFCommands(const Value: Ts0GridCommandList);
    procedure AddSelected(ACol, ARow: Integer; Shift: TShiftState);
    procedure ExtendSelected(ACol, ARow: Integer; Shift: TShiftState);
  private
    { for Selected }
    FSelected: Ts0GridRegionList;
  protected
    { for Selected }
    procedure SelectionMoved(const OldSel: TGridRect); override;
    function GetSelected: Ts0GridRegionList;
    function NewSelected: Ts0GridRegionList; virtual;
    function NewSelRegion(AKind: K0GridCellRegionKind): Ts0GridCellRegion;
      virtual;
    procedure PrepareSelected;
    property SelectedPrepared: Boolean read FSelectedPrepared;
  protected
    { for Commands }
    procedure ColWidthsChanged; override;
    procedure RowHeightsChanged; override;
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
      Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    {ÉZÉãÉfÅ[É^ÇÃDFMì«Ç›èëÇ´}
    procedure ReadCellData(Reader: TReader);
    procedure WriteCellData(Writer: TWriter);
  protected
    { for CellDrawer }
    function IsSelected(ACol, ARow: Integer): Boolean; override;
  protected
    procedure SizeChanged(OldColCount, OldRowCount: Longint); override;
    procedure DoChangeCurrent(ANewCol, ANewRow, AOldCol, AOldRow: Integer); override;
    procedure DoInsertRow(ARowIndex, ARowCount: Integer); virtual;
    procedure DoRemoveRow(ARowIndex, ARowCount: Integer); virtual;
    procedure DoClickFixedCell(ACol, ARow: Integer); virtual;
  protected
    { for AlwaysShowScrollBar }
    procedure ShowScrBar(AStyle: TScrollStyle);
  protected
    { for ShwoAllCols }
    FChangingColWidths: Boolean;
  protected
    { for Insert/Remove Col/Row }
    procedure MoveColValues(AColIndex: Integer; AMoveCols: Integer); virtual;
    procedure MoveRowValues(ARowIndex: Integer; AMoveRows: Integer); virtual;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure CreateCmdMenu;
    property MultiLine;
    //property InplaceEditor;
  public
    procedure ExecAddRow(ARowCount: Integer = 1); virtual;
    procedure ExecInsertCol(AColIndex: Integer; AColCount: Integer = 1); virtual;
    procedure ExecInsertRow(ARowIndex: Integer; ARowCount: Integer = 1); virtual;
    procedure ExecRemoveCol(AColIndex: Integer; AColCount: Integer = 1); virtual;
    procedure ExecRemoveRow(ARowIndex: Integer; ARowCount: Integer = 1); virtual;
    procedure DeleteRect(ARect: TGridRect);
    procedure SaveToMatrixByRect(AMatrix: Ts0Matrix; ARect: TGridRect);
    procedure LoadFromMatrixByRect(AMatrix: Ts0Matrix; ACoord: TGridCoord);
      virtual;
  public
    property Canvas;
    property Col;
    property Row;
    property Selection;
    property Selected: Ts0GridRegionList read GetSelected;
  public
    property ColWidths;
    property EditorMode;
    property GridHeight;
    property GridWidth;
    property LeftCol;
    property RowHeights;
    property TabStops;
    property TopRow;
    property ColCount;
    property DefaultColWidth;
    property DefaultRowHeight;
    property FixedColor;
    property FixedCols;
    property FixedRows;
    property RowCount;
    property GridLineWidth;
    property Options;
  published
    property AlwaysShowScrollBar: TScrollStyle read FAlwaysShowScrollBar write
      FAlwaysShowScrollBar default ssNone;
    property Commands: Ts0GridCommandList read FCommands write SetFCommands;
    property InsertMode: K0InsertModeType read FInsertMode write FInsertMode
      default k0imkPrev;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default
      True;
    property OnInsertRow: K0MatrixRowEvent read FOnInsertRow write FOnInsertRow;
    property OnRemoveRow: K0MatrixRowEvent read FOnRemoveRow write FOnRemoveRow;
  published
    property AutoCmdMenu: Boolean read FAutoCmdMenu write FAutoCmdMenu default True;
    property OnClickFixedCell: K0GridCellEvent read FOnClickFixedCell write
      FOnClickFixedCell;
  end;

  Ts0GridCommandClass = class of Ts0GridCommand;
  Ts0GridCommand = class(Ts0VCLComponent)
  private
    FTarget: Ts0CustomBaseGrid;
    FEnabled: Boolean;
    FShortCut: TShortCut;
    FCaption: TCaption;
    FAfterExecute: TNotifyEvent;
    FBeforeExecute: TNotifyEvent;
    function GetTarget: Ts0CustomBaseGrid;
    procedure SetEnabled(const Value: Boolean);
    procedure SetShortCut(const Value: TShortCut);
    procedure SetCaption(const Value: TCaption);
  protected
    procedure CoreExecute; virtual;
    procedure DoAfterExecute;
    procedure DoBeforeExecute;
    function GetCommandClass: Ts0GridCommandClass;
    procedure RaiseCannotCreate;
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetTarget(const Value: Ts0CustomBaseGrid); virtual;
  protected
    procedure DoChangeCurrent(ANewCol, ANewRow: Integer); virtual;
    procedure GridColWidthChanged; virtual;
    procedure GridRowHeightChanged; virtual;
    procedure GridSizeChanged(OldColCount, OldRowCount: Longint); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    function IsShortCut(var Key: Word; Shift: TShiftState): Boolean;
  protected
    function ForMenuItem: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CanExecute: Boolean; virtual;
    function Clone(AOwner: TComponent; ATarget: Ts0CustomBaseGrid):
      Ts0GridCommand;
    procedure Execute; virtual;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
  public
    class function GetCommandName: string; virtual;
    class function GetCommandByName(AName: string): Ts0GridCommandClass;
    class function GetRegisteredClasses: TClassList;
    class procedure GetRegisteredClassNames(Dest: TStrings);
    class procedure RegisterClass(AClass: Ts0GridCommandClass);
    class procedure UnRegisterClass(AClass: Ts0GridCommandClass);
  published
    property Caption: TCaption read FCaption write SetCaption;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property ShortCut: TShortCut read FShortCut write SetShortCut;
    property Target: Ts0CustomBaseGrid read GetTarget write SetTarget;
    property AfterExecute: TNotifyEvent read FAfterExecute write FAfterExecute;
    property BeforeExecute: TNotifyEvent read FBeforeExecute write FBeforeExecute;
  end;

  Ts0GridCommandList = class(TComponentList)
  private
    FOnChange: Ts0Event;
    function GetOnChange: Ts0Event;
  protected
    FOwner: Ts0CustomBaseGrid;
    function GetItems(Index: Integer): Ts0GridCommand;
    procedure SetItems(Index: Integer; AItem: Ts0GridCommand);
    procedure FreeCommands;
  protected
    procedure DoChangeCurrent(ANewCol, ANewRow: Integer);
    procedure GridColWidthChanged;
    procedure GridRowHeightChanged;
    procedure GridSizeChanged(OldColCount, OldRowCount: Longint);
    procedure KeyDown(var Key: Word; Shift: TShiftState);
    function HasItemByKey(var Key: Word; Shift: TShiftState): Boolean;
  public
    constructor Create(AOnwer: Ts0CustomBaseGrid); reintroduce; virtual;
    destructor Destroy; override;
    function Add(AItem: Ts0GridCommand): Integer;
    function AddItem(AClass: Ts0GridCommandClass): Ts0GridCommand;
    procedure Assign(Source: Ts0GridCommandList); virtual;
    function Remove(AItem: Ts0GridCommand): Integer;
    procedure RemoveItem(AClass: Ts0GridCommandClass);
    function IndexOf(AItem: Ts0GridCommand): Integer;
    function ItemByClass(AClass: Ts0GridCommandClass): Ts0GridCommand;
    procedure Insert(Index: Integer; AItem: Ts0GridCommand);
    property Items[Index: Integer]: Ts0GridCommand read GetItems write SetItems;
    default;
    function HasItem(AItemClass: Ts0GridCommandClass): Boolean;
    function First: Ts0GridCommand;
    function Last: Ts0GridCommand;
    property OnChange: Ts0Event read GetOnChange;
  end;

type
  Es0GridCommandException = class(Exception);

type
  Ts0BaseGrid = class(Ts0CustomBaseGrid)
  published
    property DoubleBuffered;
  published
    property DefaultColWidth;
    property DefaultRowHeight;
    //property DefaultDrawing;
    property FixedColor;
    property FixedCols;
    property FixedRows;
    property ColCount; //ïKÇ∏FixedColsÇÊÇËå„Ç…êÈåæ
    property RowCount; //ïKÇ∏FixedRowsÇÊÇËå„Ç…êÈåæ
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

function PrepareGridRect(var ARect: TGridRect): Boolean;
function MakeupLegalRect(ARect: TGridRect): TGridRect;

type
  Ts0GridCmdMenuItem = class(TMenuItem)
  private
    FCommand: Ts0GridCommand;
    procedure SetCommand(const Value: Ts0GridCommand);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure Click; override;
  published
    property Command: Ts0GridCommand read FCommand write SetCommand;
  end;

implementation

uses
  Forms,
  s0ComponentHelper,
  s0GridFocusController,
  s0GraphHelper
  ;

function PrepareGridRect(var ARect: TGridRect): Boolean;
var
  buf: Integer;
begin
  Result := True;
  if ARect.Top > ARect.Bottom then
  begin
    Result := False;
    buf := ARect.Top;
    ARect.Top := ARect.Bottom;
    ARect.Bottom := buf;
  end;
  if ARect.Left > ARect.Right then
  begin
    Result := False;
    buf := ARect.Left;
    ARect.Left := ARect.Right;
    ARect.Right := buf;
  end;
end;

function MakeupLegalRect(ARect: TGridRect): TGridRect;
begin
  Result := ARect;
  PrepareGridRect(Result);
end;

{ Ts0CustomBaseGrid }

procedure Ts0CustomBaseGrid.Assign(Source: TPersistent);
  procedure CopyRowHeight(AGrid: Ts0CustomBaseGrid);
  var
    i: Integer;
  begin
    for i := 0 to AGrid.RowCount - 1 do
      Self.RowHeights[i] := AGrid.RowHeights[i];
  end;
  procedure CopyColWidth(AGrid: Ts0CustomBaseGrid);
  var
    i: Integer;
  begin
    for i := 0 to AGrid.ColCount - 1 do
      Self.ColWidths[i] := AGrid.ColWidths[i];
  end;
  procedure CopyCells(AGrid: Ts0CustomBaseGrid);
  var
    i, j: Integer;
  begin
    for i := 0 to AGrid.RowCount - 1 do
      for j := 0 to AGrid.ColCount - 1 do
        Self.Cells[j, i] := AGrid.Cells[j, i];
  end;
var
  src: Ts0CustomBaseGrid;
begin
  if not (Source is Ts0CustomBaseGrid) then Exit;
  src := Ts0CustomBaseGrid(Source);
  //Self.Align := src.Align;
  //Self.Anchors := src.Anchors;
  Self.BiDiMode := src.BiDiMode;
  Self.BorderStyle := src.BorderStyle;
  Self.Color := src.Color;
  //Self.Constraints := src.Constraints;
  Self.Ctl3D := src.Ctl3D;
  Self.DragCursor := src.DragCursor;
  Self.DragKind := src.DragKind;
  Self.DragMode := src.DragMode;
  Self.Enabled := src.Enabled;
  Self.Font := src.Font;
  Self.ParentBiDiMode := src.ParentBiDiMode;
  Self.ParentColor := src.ParentColor;
  Self.ParentCtl3D := src.ParentCtl3D;
  //Self.ParentFont := src.ParentFont;
  Self.ParentShowHint := src.ParentShowHint;
  Self.PopupMenu := src.PopupMenu;
  Self.ScrollBars := src.ScrollBars;
  Self.ShowHint := src.ShowHint;
  Self.TabOrder := src.TabOrder;
  Self.TabStop := src.TabStop;
  Self.Visible := src.Visible;
  //
  Self.Options := src.Options;
  Self.ColCount := src.ColCount;
  Self.RowCount := src.RowCount;
  Self.DefaultColWidth := src.DefaultColWidth;
  Self.DefaultRowHeight := src.DefaultRowHeight;
  Self.DefaultDrawing := src.DefaultDrawing;
  Self.FixedColor := src.FixedColor;
  Self.FixedCols := src.FixedCols;
  Self.FixedRows := src.FixedRows;
  Self.GridLineWidth := src.GridLineWidth;
  //
  Self.AlwaysShowScrollBar := src.AlwaysShowScrollBar;
  Self.MultiSelect := src.MultiSelect;
  Self.MultiLine := src.MultiLine;
  Self.Commands.Assign(src.Commands);
  //
  CopyRowHeight(src);
  CopyColWidth(src);
  CopyCells(src);
end;

constructor Ts0CustomBaseGrid.Create(AOwner: TComponent);
begin
  FAutoCmdMenu := True;
  FCommands := Ts0GridCommandList.Create(Self);
  FSelected := NewSelected;
  inherited;
  FMultiSelect := True;
  DefaultDrawing := False;
end;

destructor Ts0CustomBaseGrid.Destroy;
begin
  FCommands.FreeCommands;
  FreeAndNil(FCommands);
  FreeAndNil(FSelected);
  inherited;
end;

procedure Ts0CustomBaseGrid.LoadFromMatrixByRect(AMatrix: Ts0Matrix; ACoord:
  TGridCoord);
var
  i, j: Integer;
begin
  for i := 0 to AMatrix.RowCount - 1 do
    for j := 0 to AMatrix.ColCount - 1 do
    begin
      if IsReadOnly(j, i) then Continue;
      Self.Cells[ACoord.X + j, ACoord.Y + i] := AMatrix.Cells[j, i];
      Self.Objects[ACoord.X + j, ACoord.Y + i] := AMatrix.Rows[i].Objects[j];
    end;
end;

procedure Ts0CustomBaseGrid.SaveToMatrixByRect(AMatrix: Ts0Matrix; ARect:
  TGridRect);
var
  sl: TStringList;
  i, j: Integer;
  r: TGridRect;
begin
  r := MakeupLegalRect(ARect);
  sl := TStringList.Create;
  try
    for i := r.Top to r.Bottom do
    begin
      sl.Clear;
      for j := r.Left to r.Right do
        sl.AddObject(Self.Cells[j, i], Self.Objects[j, i]);
      AMatrix.AddRow(sl);
    end;
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0CustomBaseGrid.MoveColValues(AColIndex, AMoveCols: Integer);
  procedure SaveToMatrixByCol(AMatrix: Ts0Matrix; AStart, AEnd: Integer);
  var
    r: TGridRect;
  begin
    if AStart > AEnd then Exit;
    r.Top := 0;
    r.Left := AStart;
    r.Right := AEnd;
    r.Bottom := Self.RowCount - 1;
    SaveToMatrixByRect(AMatrix, r);
  end;
  procedure LoadFromMatrixByCol(AMatrix: Ts0Matrix; AStart: Integer);
  var
    s: TGridCoord;
  begin
    if AStart > ColCount -1 then Exit;
    if not Self.ValidateColIndex(AStart) then Exit;
    s.X := AStart;
    s.Y := 0;
    LoadFromMatrixByRect(AMatrix, s);
  end; 
var
  mtrx: Ts0Matrix;
  i: Integer;
begin
  if not Self.ValidateColIndex(AColIndex) then Exit;
  BeginUpdateView;
  try
    mtrx := Ts0RowBaseMatrix.Create;
    try
      SaveToMatrixByCol(mtrx, AColIndex, Self.ColCount - 1);
      if AMoveCols < 0 then
      begin
        //çÌèúÇæÇ¡ÇΩèÍçáÇÕçÌèúÇ≥ÇÍÇÈçsÇÉNÉäÉAÇµÇƒÇ®Ç≠ÅB
        for i := AColIndex + AMoveCols to AColIndex -1 do
          ClearCol(i);
      end;
      ColCount := Self.ColCount + AMoveCols;
      if AMoveCols > 0 then
      begin
        //ë}ì¸ÇæÇ¡ÇΩèÍçáÇÕë}ì¸ÇµÇΩóÒÇÉNÉäÉAÇµÇ»Ç¢Ç∆ÇÀÅB
        for i := AColIndex to AColIndex + AMoveCols -1 do
          ClearCol(i);
      end;
      LoadFromMatrixByCol(mtrx, AColIndex + AMoveCols);
    finally
      FreeAndNil(mtrx);
    end;
  finally
    EndUpdateView;
  end;
end;

procedure Ts0CustomBaseGrid.MoveRowValues(ARowIndex, AMoveRows: Integer);

  procedure SaveToMatrixByRow(AMatrix: Ts0Matrix; AStart, AEnd: Integer);
  var
    r: TGridRect;
  begin
    if AStart > AEnd then Exit;
    r.Top := AStart;
    r.Left := 0;
    r.Right := Self.ColCount - 1;
    r.Bottom := AEnd;
    SaveToMatrixByRect(AMatrix, r);
  end;
  procedure LoadFromMatrixByRow(AMatrix: Ts0Matrix; AStart: Integer);
  var
    s: TGridCoord;
  begin
    if AStart > RowCount -1 then Exit;
    if not Self.ValidateRowIndex(AStart) then Exit;
    s.X := 0;
    s.Y := AStart;
    LoadFromMatrixByRect(AMatrix, s);
  end;
var
  mtrx: Ts0Matrix;
  i: Integer;
begin
  if not Self.ValidateRowIndex(ARowIndex) then Exit;
  BeginUpdateView;
  try
    mtrx := Ts0RowBaseMatrix.Create;
    try
      SaveToMatrixByRow(mtrx, ARowIndex, Self.RowCount - 1);
      if AMoveRows < 0 then
      begin
        //çÌèúÇæÇ¡ÇΩèÍçáÇÕçÌèúÇ≥ÇÍÇÈçsÇÉNÉäÉAÇµÇƒÇ®Ç≠ÅB
        for i := ARowIndex + AMoveRows to ARowIndex -1 do
          ClearRow(i);
      end;
      RowCount := Self.RowCount + AMoveRows;
      if AMoveRows > 0 then
      begin
        //ë}ì¸ÇæÇ¡ÇΩèÍçáÇÕë}ì¸ÇµÇΩçsÇÉNÉäÉAÇµÇ»Ç¢Ç∆ÇÀÅB
        for i := ARowIndex to ARowIndex -1 + AMoveRows do
          ClearRow(i);
      end;
      LoadFromMatrixByRow(mtrx, ARowIndex + AMoveRows);
    finally
      FreeAndNil(mtrx);
    end;
  finally
    EndUpdateView;
  end;
end;

procedure Ts0CustomBaseGrid.ExecInsertCol(AColIndex, AColCount: Integer);
begin
  if FInsertMode = k0imkNext then
    AColIndex := AColIndex + 1;
  MoveColValues(AColIndex, AColCount);
end;

procedure Ts0CustomBaseGrid.ExecInsertRow(ARowIndex: Integer; ARowCount: Integer);
begin
  if FInsertMode = k0imkNext then
    ARowIndex := ARowIndex + 1;
  MoveRowValues(ARowIndex, ARowCount);
end;

procedure Ts0CustomBaseGrid.ExecRemoveCol(AColIndex, AColCount: Integer);
begin
  MoveColValues(AColIndex + AColCount , - AColCount);
end;

procedure Ts0CustomBaseGrid.ExecRemoveRow(ARowIndex: Integer; ARowCount: Integer);
begin
  MoveRowValues(ARowIndex + ARowCount , - ARowCount);
end;

procedure Ts0CustomBaseGrid.DeleteRect(ARect: TGridRect);
var
  i, j: Integer;
begin
  if UpdateViewCount > 0 then Exit;
  BeginUpdateView;
  try
    for i := ARect.Top to ARect.Bottom do
      for j := ARect.Left to ARect.Right do
        Self.Cells[j, i] := '';
  finally
    EndUpdateView;
  end;
end;

procedure Ts0CustomBaseGrid.DoChangeCurrent(ANewCol, ANewRow, AOldCol, AOldRow: Integer);
begin
  inherited DoChangeCurrent(ANewCol, ANewRow, AOldCol, AOldRow);
  Commands.DoChangeCurrent(ANewCol, ANewRow);
end;

procedure Ts0CustomBaseGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FSelectedPrepared := False;
  if ([ssAlt, ssCtrl] * Shift <> []) or Commands.HasItemByKey(Key, Shift) then
  begin
    Commands.KeyDown(Key, Shift);
  end
  else
  begin
    inherited KeyDown(Key, Shift);
  end;
end;

procedure Ts0CustomBaseGrid.PrepareSelected;
var
  r: Ts0GridCellRect;
begin
  if Selected.Count < 1 then
  begin
    r := Ts0GridCellRect.Create(Self);
    Selected.Add(r);
  end;
  if Selected.Last is Ts0GridCellRect then
    Ts0GridCellRect(Selected.Last).AsRect := Self.Selection;
  FSelectedPrepared := True;
end;

procedure Ts0CustomBaseGrid.AddSelected(ACol, ARow: Integer; Shift: TShiftState);
var
  r: Ts0GridCellRegion;
  newRect: Boolean;
begin
  r := nil;
  if not(ssCtrl in Shift) then
    Selected.Clear;
  newRect :=(ssCtrl in Shift) and FMultiSelect;
  if (ACol < FixedCols) and (ARow < FixedRows) then
  begin
    //do nothing
  end
  else if ACol < FixedCols then
  begin
    r := Ts0GridRowRect.Create(Self);
    Ts0GridRowRect(r).FirstRow := ARow;
    Ts0GridRowRect(r).LastRow := ARow;
  end
  else if ARow < FixedRows then
  begin
    r := Ts0GridColRect.Create(Self);
    Ts0GridColRect(r).FirstCol := ACol;
    Ts0GridColRect(r).LastCol := ACol;
  end
  else if newRect then
  begin
    r := Ts0GridCellRect.Create(Self);
    Ts0GridCellRect(r).AsRect := Selection;
  end;
  if r = nil then Exit;
  Selected.Add(r);
end;

procedure Ts0CustomBaseGrid.ExtendSelected(ACol, ARow: Integer; Shift: TShiftState);
var
  r: Ts0GridCellRegion;
begin
  if not (ssShift in Shift) then Exit;
  if Selected.Count < 1 then Exit;
  r := Selected.Last;
  case r.Kind of
    k0gcrRect: Ts0GridCellRect(r).AsRect := Selection;
    k0gcrCols: Ts0GridColRect(r).LastCol := ACol;
    k0gcrRows: Ts0GridRowRect(r).LastRow := ARow;
    k0gcrCell: ;
  end;
  r.Prepare;
end;

procedure Ts0CustomBaseGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
  procedure RightClick(ACol, ARow: Integer);
  begin
    if ACol < 0 then Exit;
    if ARow < 0 then Exit;
    if Button <> mbRight then Exit;
    if not s0GraphHelper.IsInRect(
      Point(ACol, ARow),
      Rect(Selection.Left, Selection.Top, Selection.Right, Selection.Bottom)
    ) then
    begin
      if ACol < FixedCols then Exit;
      if ARow < FixedRows then Exit;
      if ACol > ColCount -1 then Exit;
      if ARow > RowCount -1 then Exit;
      Col := ACol;
      Row := ARow;
    end;
  end;
var
  curCol, curRow: Integer;
begin
  MouseToCell(X, Y, curCol, curRow);
  inherited MouseDown(Button, Shift, X, Y);
  if Self.Sizing(X, Y) then Exit;
  RightClick(curCol, curRow);
  //
  ExtendSelected(curCol, curRow, Shift);
  AddSelected(curCol, curRow, Shift);
  Self.Invalidate;
end;

procedure Ts0CustomBaseGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure Ts0CustomBaseGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  c: TGridCoord;
  procedure FixedCellClick;
  begin
    if (c.X < 0) or (c.Y < 0) then Exit;
    if (c.X < FixedCols) or (c.Y < FixedRows) then
      DoClickFixedCell(c.X, c.Y)
  end;
begin
  inherited MouseUp(Button, Shift, X, Y);
  c := MouseCoord(X, Y);
  FixedCellClick;
  PrepareSelected;
  Self.Invalidate;
end;

procedure Ts0CustomBaseGrid.DoClickFixedCell(ACol, ARow: Integer);
begin
  if Assigned(FOnClickFixedCell) then
    FOnClickFixedCell(Self, ACol, ARow);
end;

procedure Ts0CustomBaseGrid.DefineProperties(Filer: TFiler);
begin
  inherited;
  filer.DefineProperty('CellData', ReadCellData, WriteCellData, True);
end;

procedure Ts0CustomBaseGrid.ReadCellData(Reader: TReader);
var
  r, c: LongInt;
begin
  Reader.ReadListBegin;
  while not Reader.EndOfList do
  begin
    c := Reader.ReadInteger;
    r := Reader.ReadInteger;
    Cells[c, r] := Reader.ReadString;
  end;
  Reader.ReadListEnd;
end;

procedure Ts0CustomBaseGrid.WriteCellData(Writer: TWriter);
var
  r, c: LongInt;
begin
  Writer.WriteListBegin;
  for r := 0 to RowCount - 1 do
    for c := 0 to ColCount - 1 do
    begin
      Writer.WriteInteger(c);
      Writer.WriteInteger(r);
      Writer.WriteString(Cells[c, r]);
    end;
  Writer.WriteListEnd;
end;

procedure Ts0CustomBaseGrid.SizeChanged(OldColCount, OldRowCount: Integer);
begin
  inherited SizeChanged(OldColCount, OldRowCount);
  Commands.GridSizeChanged(OldColCount, OldRowCount);
end;

procedure Ts0CustomBaseGrid.DoInsertRow(ARowIndex, ARowCount: Integer);
begin
  if Assigned(FOnInsertRow) then
    FOnInsertRow(Self, ARowIndex, ARowCount);
end;

procedure Ts0CustomBaseGrid.DoRemoveRow(ARowIndex, ARowCount: Integer);
begin
  if Assigned(FOnRemoveRow) then
    FOnRemoveRow(Self, ARowIndex, ARowCount);
end;

function Ts0CustomBaseGrid.GetSelected: Ts0GridRegionList;
begin
  Result := FSelected;
end;

function Ts0CustomBaseGrid.NewSelRegion(
  AKind: K0GridCellRegionKind): Ts0GridCellRegion;
begin
  Result := g0GridRectClasses[AKind].Create(Self);
end;

function Ts0CustomBaseGrid.NewSelected: Ts0GridRegionList;
begin
  Result := Ts0GridRegionList.Create(True);
end;

procedure Ts0CustomBaseGrid.ColWidthsChanged;
begin
  inherited ColWidthsChanged;
  Commands.GridColWidthChanged;
end;

procedure Ts0CustomBaseGrid.RowHeightsChanged;
begin
  inherited RowHeightsChanged;
  Commands.GridRowHeightChanged;
end;

procedure Ts0CustomBaseGrid.WMSize(var Msg: TWMSize);
begin
  inherited;
  if FAlwaysShowScrollBar <> ssNone then ShowScrBar(FAlwaysShowScrollBar);
end;

procedure Ts0CustomBaseGrid.ShowScrBar(AStyle: TScrollStyle);
begin
  case AStyle of
    ssNone:
      Windows.ShowScrollBar(Self.Handle, SB_BOTH, False);
    ssHorizontal:
      begin
        SetScrollRange(Handle, SB_HORZ, 0, High(ShortInt), True);
        SetScrollPos(Handle, SB_HORZ, 0, True);
      end;
    ssVertical:
      begin
        SetScrollRange(Handle, SB_VERT, 0, High(ShortInt), True);
        SetScrollPos(Handle, SB_VERT, 0, True);
      end;
    ssBoth:
      begin
        SetScrollRange(Handle, SB_HORZ, 0, High(ShortInt), True);
        SetScrollRange(Handle, SB_VERT, 0, High(ShortInt), True);
        SetScrollPos(Handle, SB_HORZ, 0, True);
        SetScrollPos(Handle, SB_VERT, 0, True);
      end;
  end;
end;

procedure Ts0CustomBaseGrid.SetMultiSelect(const Value: Boolean);
begin
  FMultiSelect := Value;
end;

procedure Ts0CustomBaseGrid.GetChildren(Proc: TGetChildProc;
  Root: TComponent);
var
  i: Integer;
begin
  inherited GetChildren(Proc, Root);
  for i := 0 to FCommands.Count - 1 do
    Proc(FCommands.Items[i]);
end;

procedure Ts0CustomBaseGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if AComponent is Ts0GridCommand then
    FCommands.Remove(Ts0GridCommand(AComponent));
end;

procedure Ts0CustomBaseGrid.SetFCommands(const Value: Ts0GridCommandList);
begin
  FCommands.Assign(Value);
end;

function Ts0CustomBaseGrid.IsSelected(ACol, ARow: Integer): Boolean;
begin
  if FSelectedPrepared then
    PrepareSelected;
  Result := FSelected.IsIncluding(ACol, ARow);
end;

procedure Ts0CustomBaseGrid.SelectionMoved(const OldSel: TGridRect);
begin
  Selected.Clear;
  inherited;
  PrepareSelected;
end;

procedure Ts0CustomBaseGrid.CreateCmdMenu;
var
  i: Integer;
  mi: Ts0GridCmdMenuItem;
begin
  PopupMenu := TPopupMenu.Create(Owner);
  PopupMenu.Name := Ts0ComponentHelper.GetNewComponentName(PopupMenu);
  for i := 0 to Commands.Count -1 do
  begin
    if not Commands.Items[i].ForMenuItem then Continue; 
    mi := Ts0GridCmdMenuItem.Create(Owner);
    mi.Name := Ts0ComponentHelper.GetNewComponentName(mi);
    mi.FCommand := Commands.Items[i];
    mi.Caption := Commands.Items[i].Caption;
    mi.ShortCut := Commands.Items[i].ShortCut;
    PopupMenu.Items.Add(mi);
  end;
end;

procedure Ts0CustomBaseGrid.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then Exit;
  if AutoCmdMenu then
    CreateCmdMenu;
end;

procedure Ts0CustomBaseGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
begin
  if IsSelected(ACol, ARow) then
    AState := AState + [gdSelected]
  else
    AState := AState - [gdSelected];
  inherited DrawCell(ACol, ARow, ARect, AState);
end;

procedure Ts0CustomBaseGrid.ExecAddRow(ARowCount: Integer);
var
  i: Integer;
begin
  InhrSetRowCount(Self.RowCount + ARowCount);
  for i := Self.RowCount - ARowCount -1 to Self.RowCount -1 do
    ClearRow(i);
end;

{ Ts0GridCommand }

procedure Ts0GridCommand.Assign(Source: TPersistent);
begin
  //ì¡Ç…Ç»Ç…Ç‡ÇµÇ»Ç¢ÅB
  //ÅiÇ«Ç§Ç≈Ç‡Ç¢Ç¢Ç±Ç∆ÇæÇØÇ«ÅuÇ∆Ç≠Ç…ÅvÇÅuÇÎÇ≠Ç…ÅvÇ∆ë≈Çøä‘à·Ç¶ÇøÇ·Ç¡ÇΩÅBÇ≠Ç∑Åj
end;

function Ts0GridCommand.CanExecute: Boolean;
begin
  Result := False;
  if csLoading in Self.ComponentState then Exit;
  if csReading in Self.ComponentState then Exit;
  if Owner is TCustomForm then
    if TCustomForm(Owner).ActiveControl <> FTarget then Exit;
  Result := (Target <> nil) and Enabled;
end;

function Ts0GridCommand.Clone(AOwner: TComponent; ATarget: Ts0CustomBaseGrid):
  Ts0GridCommand;
begin
  Result := GetCommandClass.Create(AOwner);
  Result.Target := ATarget;
  Result.Assign(Self);
end;

procedure Ts0GridCommand.CoreExecute;
begin
end;

constructor Ts0GridCommand.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  if Self.ClassType = Ts0GridCommand then
    RaiseCannotCreate;
  Name := Ts0ComponentHelper.GetNewComponentName(Self);
  Caption := GetCommandName;
end;

destructor Ts0GridCommand.Destroy;
begin
  inherited;
end;

procedure Ts0GridCommand.Execute;
begin
  if not CanExecute then Exit;
  DoBeforeExecute;
  CoreExecute;
  DoAfterExecute;
end;

var
  g9CmdClassList: TClassList = nil;

class function Ts0GridCommand.GetCommandByName(
  AName: string): Ts0GridCommandClass;
var
  i: Integer;
begin
  Result := nil;
  if g9CmdClassList = nil then Exit;
  for i := 0 to g9CmdClassList.Count - 1 do
    if Ts0GridCommandClass(g9CmdClassList.Items[i]).GetCommandName = AName then
    begin
      Result := Ts0GridCommandClass(g9CmdClassList.Items[i]);
      Exit;
    end;
end;

function Ts0GridCommand.GetCommandClass: Ts0GridCommandClass;
begin
  Result := Ts0GridCommandClass(Self.ClassType);
end;

class function Ts0GridCommand.GetCommandName: string;
begin
  Result := Self.ClassName;
end;

function Ts0GridCommand.GetParentComponent: TComponent;
begin
  Result := Target;
end;

class function Ts0GridCommand.GetRegisteredClasses: TClassList;
begin
  Result := g9CmdClassList;
end;

class procedure Ts0GridCommand.GetRegisteredClassNames(Dest: TStrings);
var
  i: Integer;
begin
  if g9CmdClassList = nil then Exit;
  for i := 0 to g9CmdClassList.Count - 1 do
    Dest.Add(Ts0GridCommandClass(g9CmdClassList.Items[i]).GetCommandName);
end;

function Ts0GridCommand.GetTarget: Ts0CustomBaseGrid;
begin
  Result := FTarget;
end;

procedure Ts0GridCommand.GridSizeChanged(OldColCount,
  OldRowCount: Integer);
begin
end;

resourcestring
  c9ErrMsg_CannnotCreate = 'Ç±ÇÃÉNÉâÉXÇÃÉCÉìÉXÉ^ÉìÉXÇÕê∂ê¨Ç≈Ç´Ç‹ÇπÇÒ "%s"';

function Ts0GridCommand.HasParent: Boolean;
begin
  Result := (Target <> nil);
end;

procedure Ts0GridCommand.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if FShortCut = 0 then Exit;
  if IsShortCut(Key, Shift) then
    Execute;
end;

procedure Ts0GridCommand.RaiseCannotCreate;
begin
  raise Es0GridCommandException.CreateFmt(c9ErrMsg_CannnotCreate, [ClassName]);
end;

class procedure Ts0GridCommand.RegisterClass(AClass: Ts0GridCommandClass);
begin
  if g9CmdClassList = nil then
    g9CmdClassList := TClassList.Create;
  Classes.RegisterClass(AClass);
  if g9CmdClassList.IndexOf(AClass) > -1 then Exit;
  g9CmdClassList.Add(AClass);
end;

class procedure Ts0GridCommand.UnRegisterClass(
  AClass: Ts0GridCommandClass);
begin
  Classes.UnRegisterClass(AClass);
  if g9CmdClassList = nil then Exit;
  while g9CmdClassList.Remove(AClass) > -1 do;
end;

procedure Ts0GridCommand.SetCaption(const Value: TCaption);
begin
  FCaption := Value;
end;

procedure Ts0GridCommand.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure Ts0GridCommand.SetParentComponent(Value: TComponent);
begin
  if csLoading in ComponentState then Exit;
  if Value is Ts0CustomBaseGrid then
    Target := Ts0CustomBaseGrid(Value)
  else
    Target := nil;
end;

procedure Ts0GridCommand.SetShortCut(const Value: TShortCut);
begin
  FShortCut := Value;
end;

procedure Ts0GridCommand.SetTarget(const Value: Ts0CustomBaseGrid);
begin
  if Target = Value then Exit;
  if Target <> nil then
    Target.Commands.Remove(self);
  FTarget := Value;
  if (Target <> nil) and (Target.Commands.IndexOf(Self) < 0) then
    Target.Commands.Add(Self);
end;

procedure Ts0GridCommand.DoAfterExecute;
begin
  if Assigned(FAfterExecute) then
    FAfterExecute(Self);
end;

procedure Ts0GridCommand.DoBeforeExecute;
begin
  if Assigned(FBeforeExecute) then
    FBeforeExecute(Self);
end;

function Ts0GridCommand.ForMenuItem: Boolean;
begin
  Result := True;
end;

procedure Ts0GridCommand.DoChangeCurrent(ANewCol, ANewRow: Integer);
begin
end;

procedure Ts0GridCommand.GridColWidthChanged;
begin
end;

procedure Ts0GridCommand.GridRowHeightChanged;
begin
end;


function Ts0GridCommand.IsShortCut(var Key: Word;
  Shift: TShiftState): Boolean;
begin
  Result := (Menus.ShortCut(Key, Shift) = FShortCut);
end;

{ Ts0GridCommandList }

function Ts0GridCommandList.Add(AItem: Ts0GridCommand): Integer;
begin
  if AItem.Target <> FOwner then
    AItem.Target := FOwner;
  Result := Self.IndexOf(AItem);
  if Result > -1 then Exit;
  Result := inherited Add(AItem);
end;

function Ts0GridCommandList.AddItem(
  AClass: Ts0GridCommandClass): Ts0GridCommand;
begin
  Result := ItemByClass(AClass);
  if Result <> nil then Exit;
  Result := AClass.Create(FOwner.Owner);
  Add(Result);
end;

procedure Ts0GridCommandList.Assign(Source: Ts0GridCommandList);
  function GetCompoByClass(AList: TComponentList; AClass: TComponentClass):
      Ts0GridCommand;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to AList.Count - 1 do
      if AList.Items[i].ClassType = AClass then
        if AList.Items[i] is Ts0GridCommand then
        begin
          Result := Ts0GridCommand(AList.Items[i]);
          Exit;
        end;
  end;
var
  i: Integer;
  item: Ts0GridCommand;
  oldList: TComponentList;
  compo: Ts0GridCommand;
begin
  // Ç¢Ç´Ç»ÇËÇŒÇ¡Ç≥ÇËÉCÉìÉXÉ^ÉìÉXÇFreeÇµÇøÇ·Ç§Ç∆ÅAÇªÇÍÇéQè∆ÇµÇƒÇ¢ÇÈêlÇΩÇø
  // Ç™ç¢Ç¡ÇƒÇµÇ‹Ç§ÇÃÇ≈ÅAïsïKóvÇ»Ç‡ÇÃÇæÇØçÌèú
  //FreeCommands;
  oldList := TComponentList.Create(False);
  try
    for i := 0 to Self.Count - 1 do
      oldList.Add(Self.Items[i]);
    //
    for i := 0 to Source.Count - 1 do
    begin
      compo := GetCompoByClass(Self,
        TComponentClass(Source.Items[i].ClassType));
      if compo = nil then
      begin
        item := Source.Items[i].Clone(Self.FOwner.Owner, Self.FOwner);
        Add(item);
      end
      else
      begin
        compo.Assign(Source.Items[i]);
        oldList.Remove(compo);
      end;
    end;
    //
    while oldList.Count > 0 do
      TComponent(oldList.First).Free;
  finally
    FreeAndNil(oldList);
  end;
end;

constructor Ts0GridCommandList.Create(AOnwer: Ts0CustomBaseGrid);
begin
  inherited Create(False);
  FOwner := AOnwer;
end;

destructor Ts0GridCommandList.Destroy;
begin
  FreeAndNil(FOnChange);
  inherited;
end;

procedure Ts0GridCommandList.DoChangeCurrent(ANewCol, ANewRow: Integer);
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].DoChangeCurrent(ANewCol, ANewRow);
end;

function Ts0GridCommandList.First: Ts0GridCommand;
begin
  Result := Ts0GridCommand(inherited First);
end;

procedure Ts0GridCommandList.FreeCommands;
var
  obj: TComponent;
begin
  while Self.Count > 0 do
  begin
    obj := Self.Last;
    Self.Delete(Count - 1);
    FreeAndNil(obj);
  end;
  Self.Clear;
end;

function Ts0GridCommandList.GetItems(Index: Integer): Ts0GridCommand;
begin
  Result := Ts0GridCommand(inherited Items[Index]);
end;

function Ts0GridCommandList.GetOnChange: Ts0Event;
begin
  if FOnChange = nil then
    FOnChange := Ts0Event.Create(Self);
  Result := FOnChange;
end;

procedure Ts0GridCommandList.GridColWidthChanged;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].GridColWidthChanged;
end;

procedure Ts0GridCommandList.GridRowHeightChanged;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].GridRowHeightChanged;
end;

procedure Ts0GridCommandList.GridSizeChanged(OldColCount,
  OldRowCount: Integer);
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
    Items[i].GridSizeChanged(OldColCount, OldRowCount);
end;

function Ts0GridCommandList.HasItem(AItemClass: Ts0GridCommandClass): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Self.Count - 1 do
    if Items[i].ClassType = AItemClass then
    begin
      Result := True;
      Exit;
    end;
end;

function Ts0GridCommandList.HasItemByKey(var Key: Word;
  Shift: TShiftState): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Self.Count -1 do
    if Items[i].IsShortCut(Key, Shift) then
      Exit;
  Result := False;
end;

function Ts0GridCommandList.IndexOf(AItem: Ts0GridCommand): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure Ts0GridCommandList.Insert(Index: Integer;
  AItem: Ts0GridCommand);
begin
  inherited Insert(Index, AItem);
end;

function Ts0GridCommandList.ItemByClass(
  AClass: Ts0GridCommandClass): Ts0GridCommand;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count - 1 do
    if Items[i].ClassType = AClass then
    begin
      Result := Items[i];
      Exit;
    end;
end;

procedure Ts0GridCommandList.KeyDown(var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].KeyDown(Key, Shift);
end;

function Ts0GridCommandList.Last: Ts0GridCommand;
begin
  Result := Ts0GridCommand(inherited Last);
end;

function Ts0GridCommandList.Remove(AItem: Ts0GridCommand): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure Ts0GridCommandList.RemoveItem(AClass: Ts0GridCommandClass);
var
  item: Ts0GridCommand;
begin
  repeat
    item := ItemByClass(AClass);
    Remove(item);
  until item = nil;
end;

procedure Ts0GridCommandList.SetItems(Index: Integer; AItem: Ts0GridCommand);
begin
  inherited Items[Index] := AItem;
end;

{ Ts0GridCmdMenuItem }

procedure Ts0GridCmdMenuItem.Click;
begin
  inherited;
  if FCommand = nil then Exit;
  FCommand.Execute;
end;

procedure Ts0GridCmdMenuItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FCommand = AComponent then
    FCommand := nil;
end;

procedure Ts0GridCmdMenuItem.SetCommand(const Value: Ts0GridCommand);
begin
  if FCommand = Value then Exit;
  FCommand := Value;
end;

initialization

finalization
  FreeAndNil(g9CmdClassList);

end.

