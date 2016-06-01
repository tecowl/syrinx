unit s0CalendarGrid;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls,
  s0Persistent, s0Observer, s0collection,
  s0Grids, s0CellDecorator, s0BindGrid, s0CtrlGrid, s0DecoGrid, s0BaseGrid;

type
	Ts0CalendarWeek = class(Ts0Persistent)
  private
  	FValues: array[1..7] of String;
  public
    function GetValue(const Index: Integer): String;
    procedure SetValue(const Index: Integer; const Value: String);
    procedure SetValues(AValues: array of String);
  published
  	property Sunday: String index 1 read GetValue write SetValue;
  	property Monday: String index 2 read GetValue write SetValue;
  	property Tuesday: String index 3 read GetValue write SetValue;
  	property Wednesday: String index 4 read GetValue write SetValue;
  	property Thursday: String index 5 read GetValue write SetValue;
  	property Friday: String index 6 read GetValue write SetValue;
  	property Saturday: String index 7 read GetValue write SetValue;
  end;

type
	Ts0DatesOfWeek = array[1..7] of TDate;

type
	Ts0CalendarQueryEvent = procedure(Sender: TObject; ADate: TDate; var typeOfDateIndex: Integer) of object;

type
	Rs0TypeOfDate = packed record
  	Index: Integer;
    FontSize: Integer;
    FontStyle: TFontStyles;
    FontColor: TColor;
    Caption: String;
  end;

const
	//�����Ŏw�肵�Ă���Caption�͓��ɈӖ�������܂���B�R�[�h�̓ǂ݂₷���̂��߂ɏ�����Ă��܂��B
  Cs0DEFAULT_TYPES_OF_DATE: array[1..3] of Rs0TypeOfDate = (
  	(Index: 0; FontSize: 12; FontStyle: [fsUnderline]; FontColor: clBlack; Caption: '����'),
  	(Index: 1; FontSize: 12; FontStyle: [fsUnderline]; FontColor: clBlue; Caption: '�y�j��'),
  	(Index: 2; FontSize: 12; FontStyle: [fsUnderline]; FontColor: clRed; Caption: '���j��')
  );


type
	Ts0TypeOfDate = class(Ts0CollectionItem)
  private
    FCaption: String;
    FFont: TFont;
    FAlignment: TAlignment;
    procedure SetCaption(const Value: String);
    procedure SetFont(const Value: TFont);
    procedure SetAlignment(const Value: TAlignment);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
  	{ ���t�̐����\���ʒu�B������/����/�E�񂹁B�f�t�H���g��taLeftJustify }
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    { ���Ɏg�p����邱�Ƃ͂Ȃ��v���p�e�B�B�݌v���̎��ʗp�B }
    property Caption: String read FCaption write SetCaption;
    { ���t�̃t�H���g���w�� }
    property Font: TFont read FFont write SetFont;
  end;

type
	Ts0TypesOfDate = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0TypeOfDate;
    procedure SetItems(const Index: Integer;
      const Value: Ts0TypeOfDate);
  public
  	procedure CreateDefaultItems;
    property Items[const Index: Integer]: Ts0TypeOfDate read GetItems write SetItems;
  end;

type
  Ts0CustomCalendarGrid = class(Ts0CustomBaseGrid)
  private
    FMonth: Word;
    FYear: Word;
    FDayNamesOfWeek: Ts0CalendarWeek;
    FDayNamesOfWeekListener: Ts0EventListener;
    FFirstDayOfWeek: Word;
    FWeeks: array of Ts0DatesOfWeek;
    FWeekCount: Integer;
    FOnQueryTypeOfDate: Ts0CalendarQueryEvent;
    FTypesOfDate: Ts0TypesOfDate;
    FMaxDateHeight: Integer;
    FAutoAdjust: Boolean;
    procedure SetMonth(const Value: Word);
    procedure SetYear(const Value: Word);
    procedure SetDayNamesOfWeek(const Value: Ts0CalendarWeek);
    procedure SetFirstDayOfWeek(const Value: Word);
    procedure SetWeekCount(const Value: Integer);
    procedure SetTypesOfDate(const Value: Ts0TypesOfDate);
    procedure SetAutoAdjust(const Value: Boolean);
  protected
  	procedure AdjustCellSize;
  	procedure DayNamesOfWeekChange(Sender: TObject);
  protected
    function CellRectForInplaceEditor(ACol, ARow: Longint): TRect; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure Resize; override;
  protected
  	procedure CalcWeeks;
		procedure RenderDayNamesOfWeek;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { �Z���̈ʒu(��E�s)����Ή�������t���擾���郁�\�b�h�B
      �Ή�������t�̂Ȃ��ʒu�̏ꍇ 0 ���Ԃ����B}
    function GetDate(ACol, ARow: Integer): TDate;
    { ���t�̎�ނ̃C���f�b�N�X��Ԃ����\�b�h�B
      �f�t�H���g�ł́A����/�y�j��/���j���𔻒f����B
      ���̖߂�l��TypesOfDate�v���p�e�B�̗v�f��Index�ɊY������B
    	�܂��A�x���Ȃǂ̃A�v���P�[�V�����ŗL�̓��t�̎�ނ̏ꍇ�A
      OnQueryTypeOfDate�C�x���g���n���h�����O���邱�Ƃł��̃��\�b�h�̖߂�l��
      �ύX���邱�Ƃ��ł���B}
    function GetTypeOfDate(ADate: TDate): Ts0TypeOfDate;
  protected
  	{ �\�������N }
  	property Year: Word read FYear write SetYear;
  	{ �\������錎 }
  	property Month: Word read FMonth write SetMonth;
  	{ �T�̍ŏ��̗j���B�f�t�H���g�͓��j����1�BDayOfWeek�֐����Q�ƁB }
    property FirstDayOfWeek: Word read FFirstDayOfWeek write SetFirstDayOfWeek default 1;
    { �j���̖��O�B�f�t�H���g�͓����ΐ��؋��y }
    property DayNamesOfWeek: Ts0CalendarWeek read FDayNamesOfWeek write SetDayNamesOfWeek;
    { �\������T�̐��B�f�t�H���g6 }
    property WeekCount: Integer read FWeekCount write SetWeekCount default 6;
    { ���t�̎�ނ̃R���N�V�����B
      �f�t�H���g�ł͕����A�y�j���A���j�����ݒ肳��Ă���B }
    property TypesOfDate: Ts0TypesOfDate read FTypesOfDate write SetTypesOfDate;
    { �O���b�h�̑傫���ɍ��킹�Ċe�Z���̑傫���������I�ɍ��킹�邩�ǂ����B
      �f�t�H���g��True }
  	property AutoAdjust: Boolean read FAutoAdjust write SetAutoAdjust default True;
  protected
    { GetTypeOfDate���\�b�h�̖߂�l���J�X�^�}�C�Y���邽�߂̃C�x���g�B
			����typeOfDateIndex�ɒl���Z�b�g���邱�ƂŖ߂�l���ύX�����B}
  	property OnQueryTypeOfDate: Ts0CalendarQueryEvent read FOnQueryTypeOfDate write FOnQueryTypeOfDate;
  end;

type
  Ts0CalendarGrid = class(Ts0CustomCalendarGrid)
  published
  	property Year;
  	property Month;
    property FirstDayOfWeek;
    property DayNamesOfWeek;
    property WeekCount;
    property TypesOfDate;
    property AutoAdjust;
  published
  	property OnQueryTypeOfDate;
  published
    property ReadOnlySeals;
    property CtrlDecos;
    property AlignmentDecos;
    property ColorDecos;
    property FontDecos;
    property MultiLine;
  published
  	property FixedCols;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GridLineColor;
    property GridLineWidth;
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
  published
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
  end;

procedure Register;

implementation

uses
	s0DateHelper;

procedure Register;
begin
  RegisterComponents('P Grid', [Ts0CalendarGrid]);
end;

{ Ts0CalendarWeek }

function Ts0CalendarWeek.GetValue(const index: Integer): String;
begin
	Result := FValues[Index];
end;

procedure Ts0CalendarWeek.SetValue(const Index: Integer;
  const Value: String);
begin
	FValues[Index] := Value;
end;

procedure Ts0CalendarWeek.SetValues(AValues: array of String);
var
	i: Integer;
begin
	for i := 1 to 7 do
  	Self.FValues[i] := AValues[i -1];
end;

{ Ts0TypeOfDate }

constructor Ts0TypeOfDate.Create(ACollection: TCollection);
begin
  inherited;
  FAlignment := taLeftJustify;
	FFont := TFont.Create;
end;

destructor Ts0TypeOfDate.Destroy;
begin
	FreeAndNil(FFont);
  inherited;
end;

procedure Ts0TypeOfDate.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
  Changed(False);
end;

procedure Ts0TypeOfDate.SetCaption(const Value: String);
begin
  FCaption := Value;
  Changed(False);
end;

procedure Ts0TypeOfDate.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

{ Ts0TypesOfDate }

procedure Ts0TypesOfDate.CreateDefaultItems;
var
	i: Integer;
  item: Ts0TypeOfDate;
begin
	for i := Low(Cs0DEFAULT_TYPES_OF_DATE) to High(Cs0DEFAULT_TYPES_OF_DATE) do
  begin
  	item := Ts0TypeOfDate(inherited Add);
    item.Caption := Cs0DEFAULT_TYPES_OF_DATE[i].Caption;
    item.Font.Style := Cs0DEFAULT_TYPES_OF_DATE[i].FontStyle;
    item.Font.Color := Cs0DEFAULT_TYPES_OF_DATE[i].FontColor;
    item.Font.Size := Cs0DEFAULT_TYPES_OF_DATE[i].FontSize;
  end;
end;

function Ts0TypesOfDate.GetItems(const Index: Integer): Ts0TypeOfDate;
begin
  Result := Ts0TypeOfDate(inherited Items[Index]);
end;

procedure Ts0TypesOfDate.SetItems(const Index: Integer;
  const Value: Ts0TypeOfDate);
begin
	inherited Items[Index] := Value;
end;

{ Ts0CustomCalendarGrid }

const
	c9DayCountOfWeek = 7;

procedure Ts0CustomCalendarGrid.AdjustCellSize;
const
	c9Margin = 10;
var
	w, h: Integer;
  colW, rowH: Integer;
  i: Integer;
begin
	if not AutoAdjust then
  	Exit;
	w := Self.ClientWidth - c9Margin;
  h := Self.ClientHeight - c9Margin;
  for i := 0 to FixedCols -1 do
  	w := w - ColWidths[i];
  for i := 0 to FixedRows -1 do
  	h := h - RowHeights[i];
  colW := w div (Self.ColCount - FixedCols);
  rowH := h div (Self.RowCount - FixedRows);
  for i := FixedCols to ColCount -1 do
  	ColWidths[i] := colW;
  for i := FixedRows to RowCount -1 do
  	RowHeights[i] := rowH;
end;

procedure Ts0CustomCalendarGrid.CalcWeeks;
	function GetLastMonth: Word;
  begin
    if Self.Month = 1 then
    	Result := 12
    else
    	Result := Self.Month -1;
  end;
  function AddDate(ADate: TDate; Diff: Integer): TDate;
  var
  	value: Double;
  begin
  	value := ADate + Diff;
    Result := TDate(Value);
  end;
var
  firstDate: TDate;
  dayIndex, weekIndex: Integer;
  d: Integer;
  lastMonthDays: Integer;
  dayOfFirstDate: Integer;
  week: Ts0DatesOfWeek;
begin
	if csLoading in Self.ComponentState then
  	Exit;
	ColCount := FixedCols + 7;
	SetLength(FWeeks, WeekCount);
  firstDate := EncodeDate(Self.Year, Self.Month, 1);
  dayOfFirstDate := DayOfWeek(firstDate);
  lastMonthDays := (dayOfFirstDate - FirstDayOfWeek) mod 7;
  dayIndex := 1;
  //�ŏ��̏T�̑O����
  for d := - lastMonthDays to 0 do
  begin
  	week[dayIndex] := AddDate(firstDate, d);
    Inc(dayIndex);
  end;
  //�ŏ��̏T�̍�����
  for d := 1 to 7 - lastMonthDays -1 do
  begin
  	week[dayIndex] := AddDate(firstDate, d);
    Inc(dayIndex);
  end;
  FWeeks[0] := week;
  //��2�T�ȍ~
  for weekIndex := 1 to WeekCount -1 do
  begin
    for dayIndex := 1 to 7 do
    begin
      week[dayIndex] := AddDate(firstDate, weekIndex * 7 + dayIndex - lastMonthDays -1);
    end;
    FWeeks[weekIndex] := week;
  end;
end;

const
	c9WeekNames: array[1..7] of string = ('��', '��', '��', '��', '��', '��', '�y');

function Ts0CustomCalendarGrid.CellRectForInplaceEditor(ACol,
  ARow: Integer): TRect;
begin
  Result := inherited CellRectForInplaceEditor(ACol, ARow);
  if (ACol < FixedCols) or (ARow < FixedRows) then
  	Exit;
  Result.Top := Result.Top + FMaxDateHeight;
end;

constructor Ts0CustomCalendarGrid.Create(AOwner: TComponent);
var
	y, m, d: Word;
begin
  inherited;
  FDayNamesOfWeek := Ts0CalendarWeek.Create(Self);
  FDayNamesOfWeekListener := Ts0EventListener.Create(DayNamesOfWeekChange);
  FDayNamesOfWeek.OnChange.Attach(FDayNamesOfWeekListener);
  FDayNamesOfWeek.SetValues(c9WeekNames);
  //
  FTypesOfDate := Ts0TypesOfDate.Create(Self, Ts0TypeOfDate);
  FTypesOfDate.CreateDefaultItems;
  //
  DecodeDate(Now, y, m, d);
  Self.FYear := y;
  Self.FMonth := m;
  //
  FAutoAdjust := True;
  FMaxDateHeight := 0;
  //
  FFirstDayOfWeek := 1;
  FWeekCount := 6;
  //
  Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
  	goDrawFocusSelected, goRowSizing, goColSizing, goTabs];
  {
		goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving,
    goColMoving, goEditing, goTabs, goRowSelect,
    goAlwaysShowEditor, goThumbTracking
  }

  FixedRows := 1;
  FixedCols := 1;
  ColCount := 8;
  RowCount := 7;
  DefaultRowHeight := 80;
  ColWidths[0] := 8;
  RowHeights[0] := 16;
	//
  RenderDayNamesOfWeek;
  CalcWeeks;
end;

procedure Ts0CustomCalendarGrid.DayNamesOfWeekChange(Sender: TObject);
begin
  RenderDayNamesOfWeek;
end;

destructor Ts0CustomCalendarGrid.Destroy;
begin
	FreeAndNil(FTypesOfDate);
	FreeAndNil(FDayNamesOfWeek);
  inherited;
end;

procedure Ts0CustomCalendarGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
  function getDateStr(ADate: TDate): String;
  var
	  y, m, d: Word;
  begin
    DecodeDate(ADate, y, m, d);
    Result := IntToStr(d);
    if d = 1 then
    begin
      Result := IntToStr(m) + '/' + Result;
      if m = 1 then
      	Result := IntToStr(y) + '/' + Result;
    end;
  end;
  function getPosition(typeOfDate: Ts0TypeOfDate; w, h: Integer; s: String): TPoint;
  const
    c9Margin = 1;
  begin
  	case typeOfDate.Alignment of
      taCenter:
				Result.x := ARect.Left + ((ARect.Right - ARect.Left) - w) div 2;
      taLeftJustify:
        Result.x := ARect.Left + c9Margin;
      taRightJustify:
        Result.x := ARect.Right - w - c9Margin;
    end;
     Result.y := ARect.Top + c9Margin;
  end;
var
	d: TDate;
  fontBak: TFont;
  bgcolorBak: TColor;
  typeOfDate: Ts0TypeOfDate;
  s: String;
  w, h: Integer;
  p: TPoint;
  r: TRect;
begin
	d := GetDate(ACol, ARow);
	if d = 0 then
  begin
	  inherited DrawCell(ACol, ARow, ARect, AState);
    Exit;
  end;
  s := getDateStr(d);
  typeOfDate := GetTypeOfDate(d);
  if typeOfDate = nil then
  	Exit;
  fontBak := TFont.Create;
  fontBak.Assign(Canvas.Font);
  bgcolorBak := Canvas.Brush.Color;
  try
    try
      Canvas.Brush.Color := Self.Color;
      Canvas.Font.Assign(typeOfDate.Font);
      w := Canvas.TextWidth(s);
      h := Canvas.TextHeight(s);
      if FMaxDateHeight < h then
        FMaxDateHeight := h;
      p := getPosition(typeOfDate, w, h, s);
      //
      r.Left := ARect.Left;
      r.Top := ARect.Top;
      r.Right := ARect.Right;
      r.Bottom := r.Top + h;
      Canvas.TextRect(r, p.x, p.y, s);
    finally
      Canvas.Brush.Color := bgcolorBak;
      Canvas.Font.Assign(fontBak);
    end;
  finally
		FreeAndNil(fontBak);
  end;
  ARect.Top := ARect.Top + h;
  inherited DrawCell(ACol, ARow, ARect, AState);
end;

function Ts0CustomCalendarGrid.GetDate(ACol, ARow: Integer): TDate;
var
	rowIndex, colIndex: Integer;
  week: Ts0DatesOfWeek;
begin
  rowIndex := ARow - FixedRows;
  colIndex := ACol - FixedCols + 1;
	if (rowIndex < 0) or (rowIndex > WeekCount) or
  	(colIndex < 1) or (colIndex > 7) then
  begin
  	Result := 0;
    Exit;
  end;
  week := FWeeks[rowIndex];
  Result := week[colIndex];
end;

function Ts0CustomCalendarGrid.GetTypeOfDate(ADate: TDate): Ts0TypeOfDate;
var
  index: Integer;
	day: Integer;
begin
	day := DayOfWeek(ADate);
  if day = 1 then
  	index := 2
  else if day = 7 then
  	index := 1
  else
  	index := 0;
  if Assigned(FOnQueryTypeOfDate) then
		FOnQueryTypeOfDate(Self, ADate, index);
  Result := Self.TypesOfDate.Items[index];
end;

procedure Ts0CustomCalendarGrid.RenderDayNamesOfWeek;
var
  col: Integer;
	i: Integer;
  d: Integer;
begin
	if FixedRows < 1 then
  	Exit;
  for i := 0 to FixedCols do
  	Self.Cells[i, FixedRows -1] := '';
	col := FixedCols;
	for i := FirstDayOfWeek to FirstDayOfWeek + 7 do
  begin
  	d := (i - 1) mod 7 + 1;
    Self.Cells[col, FixedRows -1] := Self.DayNamesOfWeek.GetValue(d);
    Inc(col);
  end;
end;

procedure Ts0CustomCalendarGrid.Resize;
begin
  inherited;
	AdjustCellSize;
end;

procedure Ts0CustomCalendarGrid.SetAutoAdjust(const Value: Boolean);
begin
  FAutoAdjust := Value;
  AdjustCellSize;
end;

procedure Ts0CustomCalendarGrid.SetDayNamesOfWeek(const Value: Ts0CalendarWeek);
begin
  FDayNamesOfWeek.Assign(Value);
  CalcWeeks;
  Invalidate;
end;

procedure Ts0CustomCalendarGrid.SetFirstDayOfWeek(const Value: Word);
begin
  FFirstDayOfWeek := Value;
  RenderDayNamesOfWeek;
  CalcWeeks;
  Invalidate;
end;

{
procedure Ts0CustomCalendarGrid.SetFixedCols(Value: Integer);
begin
	if Value < 0 then
  	Value := 0;
  inherited SetColCount(Value + c9DayCountOfWeek);
  inherited SetFixedCols(Value);
end;
}

{
procedure Ts0CustomCalendarGrid.SetFixedRows(Value: Integer);
begin
  inherited;
  SetRowCount( Value + WeekCount );
end;
}

procedure Ts0CustomCalendarGrid.SetMonth(const Value: Word);
begin
  FMonth := Value;
  CalcWeeks;
  Invalidate;
end;

procedure Ts0CustomCalendarGrid.SetTypesOfDate(const Value: Ts0TypesOfDate);
begin
  FTypesOfDate.Assign(Value);
  CalcWeeks;
  Invalidate;
end;

procedure Ts0CustomCalendarGrid.SetWeekCount(const Value: Integer);
begin
  FWeekCount := Value;
  SetRowCount( Value + FixedRows );
  CalcWeeks;
  Invalidate;
end;

procedure Ts0CustomCalendarGrid.SetYear(const Value: Word);
begin
  FYear := Value;
  CalcWeeks;
  Invalidate;
end;

end.
