unit s0GridCellBarGraph;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Grids, s0DataAccessor, s0CtrlDistiller,
  s0GridCellControl;

type
	Rs0BarGraph = packed record
  	Value: Double;
    Color: TColor;
    Caption: String;
  end;

type
	Ts0BarGraphs = array of Rs0BarGraph;

type
	Ts0BarGraphQuery = procedure(Sender: TObject; AText: String; var AGraphs: Ts0BarGraphs) of object;

type
	Ts0GridCellBarGraph = class;

  Ts0GridCellBarGraphAccessor = class(Ts0DataAccessor)
	private
  	FStringValue: String;
  protected
    function GetAsBoolean: Boolean; override;
    function GetAsInteger: Integer; override;
    function GetAsString: String; override;
    procedure SetAsBoolean(const Value: Boolean); override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: String); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  {
  	セルの中に棒グラフを描画するコンポーネントです。
  }
  Ts0GridCellBarGraph = class(Ts0GridCellControl)
  private
    FMaxValue: Double;
    FGraphColor: TColor;
    FFrameColor: TColor;
    FAccessor: Ts0GridCellBarGraphAccessor;
    FOnQuery: Ts0BarGraphQuery;
    FBaseRowHeight: Integer;
    procedure SetMaxValue(const Value: Double);
    procedure ReduceTranslateRect(var ARect: TRect; Margin: Integer);
    procedure SetFrameColor(const Value: TColor);
    procedure SetGraphColor(const Value: TColor);
    procedure SetAccessor(const Value: Ts0GridCellBarGraphAccessor);
    procedure SetBaseRowHeight(const Value: Integer);
  protected
  	function GetGraphValues(AText: String): Ts0BarGraphs;
  public
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRect; AState: TGridDrawState; CellValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Accessor: Ts0GridCellBarGraphAccessor read FAccessor write SetAccessor;
    { グラフの枠の色 }
    property FrameColor: TColor read FFrameColor write SetFrameColor default clBlack;
    { グラフの内側の色 }
    property GraphColor: TColor read FGraphColor write SetGraphColor  default clTeal;
    { 値の最大値。
      最大値を超えた値をセルに設定するとセルから飛び出すように描画されます。 }
  	property MaxValue: Double read FMaxValue write SetMaxValue;
    { セル一つあたりの基準となる高さ。デフォルト80
      最大値MaxValueがこのピクセル数の高さで描画されます}
  	property BaseRowHeight: Integer read FBaseRowHeight write SetBaseRowHeight default 80;
    { セルの値から棒グラフの値と色などを取得できるイベント。
      このイベントをハンドリングする際は、引数ATextを元に、
      AGraphsを設定してください。 }
    property OnQuery: Ts0BarGraphQuery read FOnQuery write FOnQuery;
  published
    property Color stored True default clWindow;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    //property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

type
  Ts0GridCellBarGraphDistiller = class(Ts0CtrlDistiller)
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
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;


procedure Register;

implementation

uses
	Math,
	s0StringHelper,
  s0TypeConvertor;

procedure Register;
begin
  RegisterComponents('P Grid', [Ts0GridCellBarGraph]);
end;

{ Ts0GridCellBarGraphAccessor }

constructor Ts0GridCellBarGraphAccessor.Create(AOwner: TComponent);
begin
  inherited;
end;

function Ts0GridCellBarGraphAccessor.GetAsBoolean: Boolean;
begin
	Result := False;
end;

function Ts0GridCellBarGraphAccessor.GetAsInteger: Integer;
begin
	Result := 0;
end;

function Ts0GridCellBarGraphAccessor.GetAsString: String;
begin
	Result := FStringValue;
end;

procedure Ts0GridCellBarGraphAccessor.SetAsBoolean(const Value: Boolean);
begin
end;

procedure Ts0GridCellBarGraphAccessor.SetAsInteger(const Value: Integer);
begin
end;

procedure Ts0GridCellBarGraphAccessor.SetAsString(const Value: String);
begin
	FStringValue := Value;
end;

{ Ts0GridCellBarGraph }

constructor Ts0GridCellBarGraph.Create(AOwner: TComponent);
begin
  inherited;
  FFrameColor := clBlack;
  FGraphColor := clTeal;
  FBaseRowHeight := 80;
  FMaxValue := 0;
  ControlStyle := [csCaptureMouse, csOpaque, csClickEvents];
  SetBounds(Left, Top, 40, 40);
  Color := clWindow;
end;

destructor Ts0GridCellBarGraph.Destroy;
begin
  inherited;
end;

procedure Ts0GridCellBarGraph.DrawToCanvas(ACanvas: TCanvas; ARect: TRect;
  AState: TGridDrawState; CellValue: string);
  function GetBarTop(ARect: TRect; h: Integer): Integer;
  var
  	d: Integer;
  begin
    if h > 0 then
      d := -3
    else
      d := 3;
    //3項演算子を使えたらこう書きたい。java風なら
    //d := (h > 0) ? -3 : 3;
    Result := Min(ARect.Bottom - h, ARect.Bottom + d);
  end;
var
  graphs: Ts0BarGraphs;
  graph: Rs0BarGraph;
  i, valueLength: Integer;
  h, w: Integer;
  r: TRect;
  percentage: Double;
  brushColorBak: TColor;
begin
  if csDesigning in Self.ComponentState then
  begin
    ACanvas.TextOut(ARect.Left, ARect.Top, '実行時にセルの値からグラフを表示します');
    Exit;
  end;
  graphs := GetGraphValues(CellValue);
  valueLength := Length(graphs);
  if valueLength = 0 then
    Exit;
  w := (ARect.Right - ARect.Left) div valueLength;
  if MaxValue = 0 then
    Exit;
  if BaseRowHeight < 1 then
  	percentage := (ARect.Bottom - ARect.Top) / MaxValue
  else
  	percentage := BaseRowHeight / MaxValue;
  //
  brushColorBak := ACanvas.Brush.Color;
  try
    for i := 0 to valueLength -1 do
    begin
    	graph := graphs[i];
			//値が0の時、グラフを描かない  T.Hoshina
      if graph.Value = 0 then
        Continue;
			//
      h := Round(graph.Value * percentage);
      r.Left := ARect.Left + w * i;
      r.Right := r.Left + w;
      r.Top := GetBarTop(ARect, h); //TopがBottomの下に行かないようにする  T.Hoshina
      r.Bottom := ARect.Bottom;
      //
		  ReduceTranslateRect(r, 1);
      ACanvas.Brush.Color := FrameColor;
      ACanvas.FrameRect(r);
		  ReduceTranslateRect(r, 1);
  		ACanvas.Brush.Color := graph.Color;
  		ACanvas.FillRect(r);
    end;
  finally
    ACanvas.Brush.Color := brushColorBak;
  end;
end;
function Ts0GridCellBarGraph.GetGraphValues(AText: String): Ts0BarGraphs;
type
	T9Values = array of Double;
  
  function GetValues: T9Values;
  var
    sl: TStrings;
    i: Integer;
  begin
    sl := TStringList.Create;
    try
      Ts0StringHelper.SliceString(AText, sl, ',');
      SetLength(Result, sl.Count);
      for i := Low(Result) to High(Result) do
      begin
      	try
      		Result[i] := Ts0TypeConv.StrToFloat(sl.Strings[i]);
        except
        	on E: Exception do
        		Result[i] := 0;
        end;
      end;
    finally
      FreeAndNil(sl);
    end;
  end;
  function GetGraphs(): Ts0BarGraphs;
  var
  	i: Integer;
	  values: T9Values;
    valuesLength: Integer;
  begin
  	values := GetValues;
    valuesLength := Length(values);
  	SetLength(Result, valuesLength);
    for i := Low(Result) to High(Result) do
    begin
      Result[i].Value := values[i];
      Result[i].Color := Self.GraphColor;
      Result[i].Caption := '';
    end;
  end;
var
  graphs: Ts0BarGraphs;
begin
	if Assigned(FOnQuery) then
  begin
  	FOnQuery(Self, AText, graphs);
  end;
  if (graphs = nil) or (Length(graphs) = 0) then
  begin
		graphs := GetGraphs;
  end;
  Result := graphs;
end;

procedure Ts0GridCellBarGraph.ReduceTranslateRect(var ARect: TRect; Margin: Integer);
begin
  ARect.Top := ARect.Top + Margin;
  ARect.Left := ARect.Left + Margin;
  ARect.Right := ARect.Right - Margin;
  ARect.Bottom := ARect.Bottom - Margin;
end;

procedure Ts0GridCellBarGraph.SetAccessor(
  const Value: Ts0GridCellBarGraphAccessor);
begin
  FAccessor.Assign(Value);
end;

procedure Ts0GridCellBarGraph.SetBaseRowHeight(const Value: Integer);
begin
  FBaseRowHeight := Value;
end;

procedure Ts0GridCellBarGraph.SetFrameColor(const Value: TColor);
begin
  FFrameColor := Value;
end;

procedure Ts0GridCellBarGraph.SetGraphColor(const Value: TColor);
begin
  FGraphColor := Value;
end;

procedure Ts0GridCellBarGraph.SetMaxValue(const Value: Double);
begin
  FMaxValue := Value;
end;

{ Ts0GridCellBarGraphDistiller }

class procedure Ts0GridCellBarGraphDistiller.Click(AControl: TObject);
begin
  Ts0GridCellBarGraph(AControl).Click;
end;

class function Ts0GridCellBarGraphDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
	Result := Ts0GridCellBarGraph(AControl).Accessor;
end;

class function Ts0GridCellBarGraphDistiller.GetColor(
  AControl: TObject): TColor;
begin
	Result := Ts0GridCellBarGraph(AControl).GraphColor;
end;

class function Ts0GridCellBarGraphDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
	Result.FOnEnter := Ts0GridCellBarGraph(AControl).OnEnter;
  Result.FOnExit := Ts0GridCellBarGraph(AControl).OnExit;
end;

class function Ts0GridCellBarGraphDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
	Result.FOnChange := nil;
  Result.FOnKeyDown := Ts0GridCellBarGraph(AControl).OnKeyDown;
  Result.FOnKeyPress := Ts0GridCellBarGraph(AControl).OnKeyPress;
  Result.FOnKeyUp := Ts0GridCellBarGraph(AControl).OnKeyUp;
end;

class function Ts0GridCellBarGraphDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
	Result.FOnClick := Ts0GridCellBarGraph(AControl).OnClick;
	Result.FOnDblClick := Ts0GridCellBarGraph(AControl).OnDblClick;
  Result.FOnMouseDown := Ts0GridCellBarGraph(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0GridCellBarGraph(AControl).OnMouseMove;
  Result.FOnMouseUp := Ts0GridCellBarGraph(AControl).OnMouseUp;
end;

class function Ts0GridCellBarGraphDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
	Result.FOnCanResize := Ts0GridCellBarGraph(AControl).OnCanResize;
  Result.FOnResize := Ts0GridCellBarGraph(AControl).OnResize;
end;

class function Ts0GridCellBarGraphDistiller.GetTitle(
  AControl: TObject): string;
begin
	Result := '';
end;

class function Ts0GridCellBarGraphDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
	Result := [];
end;

class function Ts0GridCellBarGraphDistiller.GetValue(
  AControl: TObject): string;
begin
	Result := Ts0GridCellBarGraph(AControl).Accessor.AsString;
end;

class function Ts0GridCellBarGraphDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := (AControl is Ts0GridCellBarGraph);
end;

class procedure Ts0GridCellBarGraphDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.SetKeyEvents(
  Value: R0KeyEvents; AControl: TObject);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.SetSizeEvents(
  Value: R0SizeEvents; AControl: TObject);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  inherited;

end;

class procedure Ts0GridCellBarGraphDistiller.SetValue(Value: string;
  AControl: TObject);
begin
	Ts0GridCellBarGraph(AControl).Accessor.AsString := Value;
end;


initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0GridCellBarGraphDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0GridCellBarGraphDistiller);


end.
