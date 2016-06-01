unit tec1xNum;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, s0Edit, s0DigitEdit, tec1DigitEdit;

type
  Ttec1xNum = class(Ttec1DigitEdit)
  private
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
  private
    function GetValue: Double;
    procedure SetValue(const Value: Double);
    function GetBackColor: TColor;
    procedure SetBackColor(const Value: TColor);
    function GetKeyInput: Boolean;
    procedure SetKeyInput(const Value: Boolean);
  protected
  	procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  	property Ctl3D stored False default False;
    property ReadOnly stored False default False;
    property ExpoCommaWithInteger stored False default True;
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
    //property hWnd: Integer index -515 read GetIntegerProp write SetIntegerProp stored False;
    //property BorderStyle: Smallint index 27 read GetSmallintProp write SetSmallintProp stored False;
    //property Text: string index -517 read GetStringProp write SetStringProp stored False;
    //property IntZen: TOleBool index 13 read GetOleBoolProp write SetOleBoolProp stored False;
    //property AlignmentV: Smallint index 18 read GetSmallintProp write SetSmallintProp stored False;
    //property FormatNo: Smallint index 19 read GetSmallintProp write SetSmallintProp stored False;
    //property IntFigs: Smallint index 20 read GetSmallintProp write SetSmallintProp stored False;
    //property DecimalZen: TOleBool index 14 read GetOleBoolProp write SetOleBoolProp stored False;
    //property UpDown: TOleBool index 15 read GetOleBoolProp write SetOleBoolProp stored False;
    //property FixedCaret: TOleBool index 16 read GetOleBoolProp write SetOleBoolProp stored False;
    //property DecimalUnderline: TOleBool index 17 read GetOleBoolProp write SetOleBoolProp stored False;
    //property DecimalFigs: Smallint index 21 read GetSmallintProp write SetSmallintProp stored False;
    //property Comma: TOleBool index 1 read GetOleBoolProp write SetOleBoolProp stored False;
    //property MinusColor: TColor index 9 read GetColorProp write SetColorProp stored False;
    //property ZeroFill: TOleBool index 4 read GetOleBoolProp write SetOleBoolProp stored False;
    property Value: Double read GetValue write SetValue;
    //property MaxValue: Double index 23 read GetDoubleProp write SetDoubleProp stored False;
    //property MinValue: Double index 24 read GetDoubleProp write SetDoubleProp stored False;
    //property Unit_: string index 5 read GetStringProp write SetStringProp stored False;
    //property Plus: string index 6 read GetStringProp write SetStringProp stored False;
    //property Show: TOleBool index 2 read GetOleBoolProp write SetOleBoolProp stored False;
    //property SpinButton: TOleBool index 3 read GetOleBoolProp write SetOleBoolProp stored False;
    //property HintText: string index 10 read GetStringProp write SetStringProp stored False;
    //property FocusBorder: Smallint index 25 read GetSmallintProp write SetSmallintProp stored False;
    //property InputMode: Smallint index 26 read GetSmallintProp write SetSmallintProp stored False;
    //property FocusColor: TColor index 8 read GetColorProp write SetColorProp stored False;
    //property Minus: string index 7 read GetStringProp write SetStringProp stored False;
    //property Step: Double index 11 read GetDoubleProp write SetDoubleProp stored False;
    //property KeyInput: TOleBool index 12 read GetOleBoolProp write SetOleBoolProp stored False;
    property KeyInput: Boolean read GetKeyInput write SetKeyInput; 
    //property MouseIcon: Variant index 28 read GetVariantProp write SetVariantProp stored False;
    //property MousePointer: Smallint index 29 read GetSmallintProp write SetSmallintProp stored False;
    //property OnChangeValue: TNotifyEvent read FOnChangeValue write FOnChangeValue;
    //property OnErrorX: TxNumErrorX read FOnErrorX write FOnErrorX;
    //property OnSpinDown: TNotifyEvent read FOnSpinDown write FOnSpinDown;
    //property OnSpinUp: TNotifyEvent read FOnSpinUp write FOnSpinUp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1xNum]);
end;

{ Ttec1xNum }

procedure Ttec1xNum.CMEnter(var Message: TCMGotFocus);
begin
  //TCustomEdit implementation
  //if FAutoSelect and not (csLButtonDown in ControlState) and
  //  (GetWindowLong(Handle, GWL_STYLE) and ES_MULTILINE = 0) then SelectAll;

  if not (csLButtonDown in ControlState) and
  	(GetWindowLong(Handle, GWL_STYLE) and ES_MULTILINE = 0) then
  begin
		Self.SelStart := Length(Self.Text);
    Self.SelLength := 0;
  end;
	inherited;
end;

constructor Ttec1xNum.Create(AOwner: TComponent);
begin
  inherited;
  Self.AutoSelect := False;
	Self.Ctl3D := False;
  Self.ReadOnly := False;
  Self.ExpoCommaWithInteger := True;
end;

function Ttec1xNum.GetBackColor: TColor;
begin
	Result := inherited Color;
end;

function Ttec1xNum.GetKeyInput: Boolean;
begin
	Result := True;
end;

function Ttec1xNum.GetValue: Double;
begin
	Result := inherited AsFloat;
end;

procedure Ttec1xNum.Loaded;
begin
  inherited;
  Self.Ctl3D := False;
  Self.ReadOnly := False;
  Self.ExpoCommaWithInteger := True;
end;

procedure Ttec1xNum.SetBackColor(const Value: TColor);
begin
	inherited Color := Value;
end;

procedure Ttec1xNum.SetKeyInput(const Value: Boolean);
begin
	//ñ≥éãÅI
end;

procedure Ttec1xNum.SetValue(const Value: Double);
begin
	inherited AsFloat := Value;
end;

end.
