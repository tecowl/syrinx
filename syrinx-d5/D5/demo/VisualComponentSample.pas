unit VisualComponentSample;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, s0Database, s0ComponentEventWrapper, s0FormEventPublisher,
  s0ObjPropStocker, s0IniPropStocker, StdCtrls, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, s0GridCellControl, s0GridCellCheck,
  s0BaseGridCommand, s0VCLClasses, s0BaseGrid, s0Grids, s0CellDecorator,
  s0BindGrid, s0CtrlGrid, s0DecoGrid, s0Edit, s0DigitEdit, s0Label,
  ExtCtrls, s0BarGraph, ComCtrls, s0PageControl;

type
  TForm1 = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0PageControl1: Ts0PageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    s0BarGraph1: Ts0BarGraph;
    Panel1: TPanel;
    Panel2: TPanel;
    s0Label1: Ts0Label;
    s0Label2: Ts0Label;
    s0Label3: Ts0Label;
    s0Label4: Ts0Label;
    Button1: TButton;
    ComboBox1: TComboBox;
    s0DigitEdit1: Ts0DigitEdit;
    s0DigitEdit2: Ts0DigitEdit;
    ComboBox2: TComboBox;
    s0BaseGrid1: Ts0BaseGrid;
    s0GridCmd_AddRow2: Ts0GridCmd_AddRow;
    s0GridCmd_InsertRow2: Ts0GridCmd_InsertRow;
    s0GridCmd_RemoveRow3: Ts0GridCmd_RemoveRow;
    s0GridCellCheck1: Ts0GridCellCheck;
    JvDBUltimGrid1: TJvDBUltimGrid;
    s0BaseGrid2: Ts0BaseGrid;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    s0Database1: Ts0Database;
    Table1F001: TIntegerField;
    Table1F002: TStringField;
    Table1F003: TStringField;
    Table1F004: TStringField;
    Table1F005: TStringField;
    Table1F006: TStringField;
    Table1F007: TStringField;
    Table1F008: TStringField;
    Table1F009: TStringField;
    Table1F010: TStringField;
    Table1F011: TStringField;
    Table1F012: TSmallintField;
    Table1F013: TIntegerField;
    Table1F014: TSmallintField;
    Table1F015: TIntegerField;
    Table1F016: TIntegerField;
    Table1F017: TIntegerField;
    Table1F018: TIntegerField;
    Table1F019: TSmallintField;
    Table1F020: TIntegerField;
    Table1F021: TSmallintField;
    Table1F022: TIntegerField;
    Table1F023: TIntegerField;
    Table1F024: TStringField;
    Table1F025: TStringField;
    Table1F026: TSmallintField;
    Table1F027: TStringField;
    Table1F028: TStringField;
    Table1F029: TStringField;
    Table1F030: TStringField;
    Table1F031: TStringField;
    Table1F032: TStringField;
    Table1F033: TStringField;
    Table1F034: TStringField;
    Table1F035: TStringField;
    Table1F036: TSmallintField;
    Table1F037: TIntegerField;
    Table1F038: TSmallintField;
    Table1F039: TStringField;
    Table1F040: TStringField;
    Table1F041: TStringField;
    Table1F042: TStringField;
    Table1F043: TStringField;
    Table1F044: TStringField;
    Table1F045: TStringField;
    Table1F046: TSmallintField;
    Table1F047: TSmallintField;
    Table1F048: TStringField;
    Table1F049: TStringField;
    Table1F050: TStringField;
    Table1F051: TStringField;
    Table1F052: TStringField;
    Table1F053: TStringField;
    Table1F054: TStringField;
    Table1F055: TStringField;
    Table1F056: TStringField;
    Table1F057: TStringField;
    Table1F058: TStringField;
    Table1F059: TIntegerField;
    Table1F060: TSmallintField;
    Table1STUDENTCODE: TStringField;
    Table1INSURANCEKINDID: TIntegerField;
    Table1USERNAME: TStringField;
    Table1STUDENTMEMO: TMemoField;
    Table1IMPORTANCETELCOLORS: TMemoField;
    Table1HIRANAME: TStringField;
    Table1PETNAME: TStringField;
    Table1HOMEGUIDE: TMemoField;
    Table1NOTE: TMemoField;
    Table1HISTORY: TMemoField;
    Table1CLASSDATASTR: TMemoField;
    Table1SIBLINGSID: TIntegerField;
    Table1CONNECTIONGRPID: TIntegerField;
    Table1PRIPARENTID: TIntegerField;
    Table1GRADEID: TIntegerField;
    Table1AREAID: TIntegerField;
    Table1EXCARECD1: TIntegerField;
    Table1EXCAREDEM1: TFloatField;
    Panel3: TPanel;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure JvDBUltimGrid1IndexNotFound(Sender: TJvDBUltimGrid;
      FieldsToSort: TSortFields; IndexFieldNames, DescFields: string;
      var Retry: Boolean);
  private
    procedure InitCalendar;
    procedure RefreshColumnNames;
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
  function BoolToStr(value: Boolean): string;
  begin
    if value then
      Result := 'True'
    else
      Result := 'False';
  end;
  procedure initGrid();
  var
    i: Integer;
    curr: Ts0BarGraphItem;
  begin
    s0BaseGrid1.RowCount := s0BarGraph1.Items.Count + 1;
    for i := 0 to s0BarGraph1.Items.Count - 1 do
    begin
      curr := s0BarGraph1.Items[i];
      s0BaseGrid1.Cells[1, i + 1] := IntToStr(curr.BarLength);
      s0BaseGrid1.Cells[2, i + 1] := IntToStr(curr.BarWidth);
      s0BaseGrid1.Cells[3, i + 1] := BoolToStr(curr.RenderText);
      s0BaseGrid1.Cells[4, i + 1] := BoolToStr(curr.ShowHint);
      s0BaseGrid1.Cells[5, i + 1] := curr.Hint;
      s0BaseGrid1.Cells[6, i + 1] := ColorToString(curr.color);
    end;
  end;
  procedure initDirection();
  const
    Directions: array[K0bgDirection] of string = ('k0bgdToTop', 'k0bgdToBottom',
      'k0bgdToRight', 'k0bgdToLeft');
  var
    i: K0bgDirection;
  begin
    for i := Low(K0bgDirection) to High(K0bgDirection) do
      ComboBox1.Items.AddObject(Directions[i], TObject(i));
  end;
  procedure initValueUnit;
  const
    ValueUnits: array[K0bgValueUnit] of string = ('k0bgvuPercentage',
      'k0bgvuPixel');
  var
    i: K0bgValueUnit;
  begin
    for i := Low(K0bgValueUnit) to High(K0bgValueUnit) do
      ComboBox2.Items.AddObject(ValueUnits[i], TObject(i));
  end;
begin
  initDirection;
  initValueUnit;
  initGrid;
  InitCalendar;
  RefreshColumnNames;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  s0BarGraph1.Direction :=
    K0bgDirection(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  s0BarGraph1.ValueUnit :=
    K0bgValueUnit(ComboBox2.Items.Objects[ComboBox2.ItemIndex]);
end;

procedure TForm1.Button1Click(Sender: TObject);
  function StrToBool(value: string): Boolean;
  begin
    if value = 'True' then
      Result := True
    else
      Result := False;
  end;
var
  i: Integer;
  item: Ts0BarGraphItem;
begin
  s0BarGraph1.Items.Clear;
  for i := s0BaseGrid1.FixedRows to s0BaseGrid1.RowCount - 1 do
  begin
    item := Ts0BarGraphItem(s0BarGraph1.Items.Add);
    item.BarLength := StrToInt(s0BaseGrid1.Cells[1, i]);
    item.BarWidth := StrToInt(s0BaseGrid1.Cells[2, i]);
    item.RenderText := StrToBool(s0BaseGrid1.Cells[3, i]);
    item.ShowHint := StrToBool(s0BaseGrid1.Cells[4, i]);
    item.Hint := s0BaseGrid1.Cells[5, i];
    item.Color := StringToColor(s0BaseGrid1.Cells[6, i]);
  end;
  s0BarGraph1.Denominator4Length := s0DigitEdit1.AsInteger;
  s0BarGraph1.Denominator4Width := s0DigitEdit2.AsInteger;
end;

procedure TForm1.JvDBUltimGrid1IndexNotFound(Sender: TJvDBUltimGrid;
  FieldsToSort: TSortFields; IndexFieldNames, DescFields: string;
  var Retry: Boolean);
begin
  Retry := False;
end;

procedure TForm1.InitCalendar;
var
  x, y: Integer;
  deco: Ts0CtrlDecorator;
  grid: Ts0BaseGrid;
  graph: Ts0BarGraph;
begin
  grid := s0BaseGrid2;
  for y := grid.FixedRows to grid.RowCount - 1 do
  begin
    for x := grid.FixedCols to grid.ColCount - 1 do
    begin
      graph := Ts0BarGraph.Create(Self);
      graph.Parent := TabSheet6;
      deco := grid.CtrlDecos.Add(graph);
      deco.RegionKind := k0gcrCols;
      deco.Left := x;
      deco.Right := x;
      deco.Top := y;
      deco.Bottom := y;
    end;
  end;
  grid.CtrlDecos.HideControls;
end;

procedure TForm1.RefreshColumnNames;
var
	i: Integer;
begin
  ListBox1.Items.Clear;
  for i := 0 to JvDBUltimGrid1.Columns.Count -1 do
  begin
  	ListBox1.Items.Add(JvDBUltimGrid1.Columns[i].DisplayName);
  end;
end;

end.

