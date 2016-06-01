unit s0FocusExpression;

interface

uses
  SysUtils, Classes, Graphics, Controls, s0CtrlEventSnatcher;

type
	Ts0FocusExpressionEvent = procedure(Sender: TObject; AControl: TControl;
  	var AEnabled: Boolean) of object;

type
	Ts0FocusExpressionItem = class(Ts0CESnatcherItem)
  end;


type
  Ts0FocusExpression = class(Ts0CtrlEventSnatcher)
  private
    FListener: Ts0CtrlEventListener;
    FOnEnter: Ts0FocusExpressionEvent;
    FOnExit: Ts0FocusExpressionEvent;
  protected
  	procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  protected
    function CreateItems: Ts0CESnatcherItems; override;
    procedure HandlingEvents; virtual;
    procedure HandlingControl(AControl: TControl); virtual;
  protected
    function CanExpressOnEnter(AControl: TControl): Boolean; virtual;
    function CanExpressOnExit(AControl: TControl): Boolean; virtual;
    procedure CtrlEnter(AControl: TCOntrol); virtual; abstract;
    procedure CtrlExit(AControl: TCOntrol); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    property OnEnter: Ts0FocusExpressionEvent read FOnEnter write FOnEnter;
    property OnExit: Ts0FocusExpressionEvent read FOnExit write FOnExit;
  end;


type
  Ts0FocusColor = class(Ts0FocusExpression)
  private
    FDefaultColor: TColor;
    FFocusedColor: TColor;
    procedure SetDefaultColor(const Value: TColor);
    procedure SetFocusedColor(const Value: TColor);
  protected
    FLastColor: TColor;
    function GetColor(Sender: TObject): TColor; virtual;
    procedure SetColor(Sender: TObject; AColor: TColor); virtual;
    procedure CtrlEnter(AControl: TCOntrol); override;
    procedure CtrlExit(AControl: TCOntrol); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
  	property DefaultColor: TColor read FDefaultColor write SetDefaultColor default clWindow;
  	property FocusedColor: TColor read FFocusedColor write SetFocusedColor default $00BFD6FB;
    property OnEnter;
    property OnExit;
  end;

procedure Register;

implementation

uses
	Forms,
  StdCtrls,
  s0DateEdit,
	s0CtrlDistiller;

procedure Register;
begin
  RegisterComponents('Techno', [Ts0FocusColor]);
end;

type
	T9CtrlEventListener = class(Ts0CtrlEventListener)
  private
  	FOwner: Ts0FocusExpression;
  public
  	constructor Create(AOwner: Ts0FocusExpression);
    procedure CtrlOnEnter(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
  end;

{ T9CtrlEventListener }

constructor T9CtrlEventListener.Create(AOwner: Ts0FocusExpression);
begin
  FOwner := AOwner;
end;

procedure T9CtrlEventListener.CtrlOnEnter(Sender: TObject);
begin
	FOwner.CtrlEnter(TControl(Sender));
end;

procedure T9CtrlEventListener.CtrlOnExit(Sender: TObject);
begin
	FOwner.CtrlExit(TControl(Sender));
end;


{ Ts0FocusExpression }

function Ts0FocusExpression.CanExpressOnEnter(AControl: TControl): Boolean;
begin
	Result := True;
  if Assigned(FOnEnter) then
  	FOnEnter(Self, AControl, Result);
end;

function Ts0FocusExpression.CanExpressOnExit(AControl: TControl): Boolean;
begin
	Result := True;
  if Assigned(FOnExit) then
  	FOnExit(Self, AControl, Result);
end;

constructor Ts0FocusExpression.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, False);
end;

function Ts0FocusExpression.CreateItems: Ts0CESnatcherItems;
begin
	Result := Ts0CESnatcherItems.Create(Self, Ts0FocusExpressionItem);
end;

destructor Ts0FocusExpression.Destroy;
begin
	FreeAndNil(FListener);
  inherited Destroy;
end;

procedure Ts0FocusExpression.HandlingControl(AControl: TControl);
	function CanHandle(AControl: TControl): Boolean;
  const
  	handlingClasses: array[0..4] of TControlClass = (
    	TCustomEdit, TCustomComboBox, TCustomMemo, TCustomListBox,
      Ts0CustomDateEdit
    );
  var
  	i: Integer;
  begin
  	Result := False;
  	if not Ts0CtrlDistillBroker.IsTarget(AControl) then
    	Exit;
    for i := 0 to Length(handlingClasses) do
    begin
    	if AControl is handlingClasses[i] then
      begin
      	Result := True;
        Exit;
      end;
    end;
  end;
begin
	if not CanHandle(AControl) then
  	Exit;
  Controllers.Add(AControl, FListener);
end;

procedure Ts0FocusExpression.HandlingEvents;
var
	i, c: Integer;
  compo: TComponent;
begin
  Self.Controllers.Clear;
	c := Self.Owner.ComponentCount;
	for i := 0 to c -1 do
  begin
  	compo := Self.Owner.Components[i];
    if compo is TControl then
      HandlingControl(TControl(compo));
  end;
  Self.SnatchEvent;
end;

procedure Ts0FocusExpression.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in Self.ComponentState) then
  begin
    FListener := T9CtrlEventListener.Create(Self);
    HandlingEvents;
  end;
end;

procedure Ts0FocusExpression.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if not (csDesigning in Self.ComponentState) then
  begin
    if csDestroying in Self.ComponentState then
			PutEventBack;
  end;
  inherited Notification(AComponent, Operation);
end;


{ Ts0FocusColor }

constructor Ts0FocusColor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
	FDefaultColor := clWindow;
  FFocusedColor := $00BFD6FB;
end;

procedure Ts0FocusColor.CtrlEnter(AControl: TCOntrol);
begin
  if not CanExpressOnEnter(AControl) then
  	Exit;
  if FLastColor = 0 then
		FLastColor := Self.GetColor(AControl);
  try
		SetColor(AControl, FocusedColor);
  except
		FLastColor := 0;
  end;
end;

procedure Ts0FocusColor.CtrlExit(AControl: TCOntrol);
begin
  if not CanExpressOnExit(AControl) then
  	Exit;
  try
    if FLastColor <> 0 then
      SetColor(AControl, FLastColor)
    else
      SetColor(AControl, DefaultColor);
  finally
  	FLastColor := 0;
  end;
end;

destructor Ts0FocusColor.Destroy;
begin
  inherited Destroy;
end;

function Ts0FocusColor.GetColor(Sender: TObject): TColor;
begin
	Result := Ts0CtrlDistillBroker.GetColor(Sender);
end;

procedure Ts0FocusColor.SetColor(Sender: TObject; AColor: TColor);
begin
	Ts0CtrlDistillBroker.SetColor(Sender, AColor);
  if Sender is TControl then
  begin
    TControl(Sender).Refresh;
    Application.ProcessMessages;
  end;
end;

procedure Ts0FocusColor.SetDefaultColor(const Value: TColor);
begin
  FDefaultColor := Value;
end;

procedure Ts0FocusColor.SetFocusedColor(const Value: TColor);
begin
  FFocusedColor := Value;
end;


end.

