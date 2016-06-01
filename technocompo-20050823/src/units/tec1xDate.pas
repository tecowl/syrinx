unit tec1xDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CustomComplexCtrl, s0DateEdit, tec1DateEdit;

type
  Ttec1xDate = class(Ttec1DateEdit)
  private
    function GetDayValue: Smallint;
    function GetMonthValue: Smallint;
    function GetYearValue: Smallint;
    procedure SetDayValue(const Value: Smallint);
    procedure SetMonthValue(const Value: Smallint);
    procedure SetYearValue(const Value: Smallint);
    function GetValue: TDateTime;
    procedure SetValue(const Value: TDateTime);
    function GetBackColor: TColor;
    procedure SetBackColor(const Value: TColor);
    function GetInputMode: Smallint;
    procedure SetInputMode(const Value: Smallint);
    function GetInputAreaColor: TColor;
    procedure SetInputAreaColor(const Value: TColor);
    function GetSpinButton: Boolean;
    procedure SetSpinButton(const Value: Boolean);
    function GetInputArea3D: Boolean;
    procedure SetInputArea3D(const Value: Boolean);
  protected
  	procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetYYYYMMDD: string;
  published
    property EraType default k0ekJapanese;
  	property Ctl3D stored False default False;
    property AutoAdjustSize stored False default False;
  published
    property ParentColor;
    property ParentFont;
    property TabStop;
    property DragCursor;
    property DragMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    //property OnDragDrop;
    //property OnDragOver;
    //property OnEndDrag;
    //property OnEnter;
    //property OnExit;
    //property OnStartDrag;
    //property OnClick;
    //property OnDblClick;
    //property OnKeyDown;
    //property OnKeyPress;
    //property OnKeyUp;
    //property OnMouseDown;
    //property OnMouseMove;
    //property OnMouseUp;
    property BackColor: TColor read GetBackColor write SetBackColor;
    //property Enabled: TOleBool index -514 read GetOleBoolProp write SetOleBoolProp stored False;
    //property Font: Variant index -512 read GetVariantProp write SetVariantProp stored False;
    //property ForeColor: TColor index -513 read GetColorProp write SetColorProp stored False;
    //property AlignmentH: Smallint index 10 read GetSmallintProp write SetSmallintProp stored False;
    //property AlignmentV: Smallint index 11 read GetSmallintProp write SetSmallintProp stored False;
    //property BorderStyle: Smallint index 28 read GetSmallintProp write SetSmallintProp stored False;
    //property CharacterSize: Smallint index 12 read GetSmallintProp write SetSmallintProp stored False;
    //property DateFormat: Smallint index 13 read GetSmallintProp write SetSmallintProp stored False;
    //property DayInput: TOleBool index 1 read GetOleBoolProp write SetOleBoolProp stored False;
    //property DayStep: Smallint index 14 read GetSmallintProp write SetSmallintProp stored False;
    property DayValue: Smallint read GetDayValue write SetDayValue;
    //property DisplayItem: Smallint index 16 read GetSmallintProp write SetSmallintProp stored False;
    //property DisplayString: string index 17 read GetStringProp write SetStringProp stored False;
    //property FocusBorder: Smallint index 18 read GetSmallintProp write SetSmallintProp stored False;
    //property FocusColor: TColor index 2 read GetColorProp write SetColorProp stored False;
    //property HintText: string index 3 read GetStringProp write SetStringProp stored False;
    //property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    //property InputMode: Smallint index 19 read GetSmallintProp write SetSmallintProp stored False;
    property InputMode: Smallint read GetInputMode write SetInputMode;
    //property InputArea3D: TOleBool index 4 read GetOleBoolProp write SetOleBoolProp stored False;
    property InputArea3D: Boolean read GetInputArea3D write SetInputArea3D; 
    property InputAreaColor: TColor read GetInputAreaColor write SetInputAreaColor;
    //property MaxDate: string index 20 read GetStringProp write SetStringProp stored False;
    //property MinDate: string index 21 read GetStringProp write SetStringProp stored False;
    //property MonthInput: TOleBool index 6 read GetOleBoolProp write SetOleBoolProp stored False;
    //property MonthStep: Smallint index 22 read GetSmallintProp write SetSmallintProp stored False;
    property MonthValue: Smallint read GetMonthValue write SetMonthValue;
    //property Show: TOleBool index 7 read GetOleBoolProp write SetOleBoolProp stored False;
    //property SpinButton: TOleBool index 8 read GetOleBoolProp write SetOleBoolProp stored False;
    property SpinButton: Boolean read GetSpinButton write SetSpinButton;
    //property UpDownMode: Smallint index 24 read GetSmallintProp write SetSmallintProp stored False;
    //property Week: Smallint index 25 read GetSmallintProp write SetSmallintProp stored False;
    //property YearInput: TOleBool index 9 read GetOleBoolProp write SetOleBoolProp stored False;
    //property YearStep: Smallint index 26 read GetSmallintProp write SetSmallintProp stored False;
    property YearValue: Smallint read GetYearValue write SetYearValue;
    //property MousePointer: Smallint index 29 read GetSmallintProp write SetSmallintProp stored False;
    //property MouseIcon: Variant index 30 read GetVariantProp write SetVariantProp stored False;
    //property Value: TOleDate index 31 read GetOleDateProp write SetOleDateProp stored False;
    property Value: TDateTime read GetValue write SetValue stored False;
    //property OnChangeValue: TNotifyEvent read FOnChangeValue write FOnChangeValue;
    //property OnErrorInput: TNotifyEvent read FOnErrorInput write FOnErrorInput;
    //property OnOutofRange: TNotifyEvent read FOnOutofRange write FOnOutofRange;
    //property OnSpinUp: TNotifyEvent read FOnSpinUp write FOnSpinUp;
    //property OnSpinDown: TNotifyEvent read FOnSpinDown write FOnSpinDown;
  end;

procedure Register;

implementation

uses
	s0DigitEdit, s0DateHelper;

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1xDate]);
end;

{ Ttec1xDate }

constructor Ttec1xDate.Create(AOwner: TComponent);
begin
  inherited;
	Self.Ctl3D := False;
  Self.EraType := k0ekJapanese;
  Self.AutoAdjustSize := False;
end;

function Ttec1xDate.GetBackColor: TColor;
begin
	Result := inherited Color;
end;

function Ttec1xDate.GetDayValue: Smallint;
begin
  Result := inherited Day;
end;

function Ttec1xDate.GetInputArea3D: Boolean;
begin
	Result := True;
end;

function Ttec1xDate.GetInputAreaColor: TColor;
begin
	Result := EditYear.Color;	
end;

function Ttec1xDate.GetInputMode: Smallint;
begin
	Result := 0;
end;

function Ttec1xDate.GetMonthValue: Smallint;
begin
  Result := inherited Month;
end;

function Ttec1xDate.GetSpinButton: Boolean;
begin
	Result := False;
end;

function Ttec1xDate.GetValue: TDateTime;
begin
	Result := inherited AsDateTime;
end;

function Ttec1xDate.GetYearValue: Smallint;
var
	date: TDateTime;
  y, m, d: Word;
begin
  if (Self.EraType = k0ekJapanese) then
  begin
  	date := AsDateTime;
    DecodeDate(date, y, m, d);
    Result := y;
  end
  else
  begin
	  Result := inherited Year;
  end;
end;

function Ttec1xDate.GetYYYYMMDD: string;
var
  Y, M, D: string;
begin
  Y := IntToStr(Self.YearValue);
  M := IntToStr(Self.MonthValue);
  D := IntToStr(Self.DayValue);
  while Length(Trim(M)) < 2 do
    M := '0' + M;
  while Length(Trim(D)) < 2 do
    D := '0' + D;
  Result := Y + M + D;
end;

procedure Ttec1xDate.Loaded;
var
	i: K0DateEditItemType;
  edit: Ts0CustomDigitEdit;
begin
  inherited Loaded;
  for i := Low(K0DateEditItemType) to High(K0DateEditItemType) do
  begin
  	edit := GetEdits(i);
    edit.Ctl3D := False;
    edit.BorderStyle := bsNone;
    edit.Font.Name := 'ＭＳ ゴシック';
    edit.Font.Size := 12;
  end;
  Self.Font.Name := 'ＭＳ ゴシック';
  Self.Font.Size := 12;
  Self.BorderStyleOfParts := bsNone;
  Self.BorderStyle := bsSingle;
  Self.Ctl3D := False;
  Self.AutoAdjustSize := False;
end;

procedure Ttec1xDate.SetBackColor(const Value: TColor);
begin
	inherited Color := Value;
end;

procedure Ttec1xDate.SetDayValue(const Value: Smallint);
begin
  inherited Day := Value;
end;

procedure Ttec1xDate.SetInputArea3D(const Value: Boolean);
begin
	//無視
end;

procedure Ttec1xDate.SetInputAreaColor(const Value: TColor);
begin
	EditYear.Color := Value;
  EditMonth.Color := Value;
  EditDay.Color := Value;
  EditHour.Color := Value;
  EditMinute.Color := Value;
  EditSecond.Color := Value;
  EditMiliSec.Color := Value;
end;

procedure Ttec1xDate.SetInputMode(const Value: Smallint);
begin
  // 0: キー入力可
  // 1: 特殊キーのみ可
  // 2: キー入力不可
	//・・・らしいけど、何もしねぇぞこのやろう！
end;

procedure Ttec1xDate.SetMonthValue(const Value: Smallint);
begin
  inherited Month := Value;
end;

procedure Ttec1xDate.SetSpinButton(const Value: Boolean);
begin
	//無視！
end;

procedure Ttec1xDate.SetValue(const Value: TDateTime);
begin
	inherited AsDateTime := Value;
end;

procedure Ttec1xDate.SetYearValue(const Value: Smallint);
var
	date: TDateTime;
begin
  if (Self.EraType = k0ekJapanese) then
  begin
	  date := EncodeDate(Value,Self.Month, Self.Day);
    inherited AsDateTime := date;
  end
  else
  begin
	  inherited Year := Value;
  end;
end;

end.

