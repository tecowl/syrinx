unit tec1FocusColor;

interface

uses
  SysUtils, Classes, Graphics, Controls, s0CtrlEventSnatcher;

type
	Ttec1CtrlFocusColorItem = class(Ts0CESnatcherItem)
  public
  end;

type
  Ttec1FocusColor = class(Ts0CtrlEventSnatcher)
  private
    FDefaultColor: TColor;
    FFocusedColor: TColor;
    FListener: Ts0CtrlEventListener;
    procedure SetDefaultColor(const Value: TColor);
    procedure SetFocusedColor(const Value: TColor);
  protected
  	procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  protected
    function CreateItems: Ts0CESnatcherItems; override;
    procedure HandlingEvents;
    procedure HandlingControl(AControl: TControl);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
  	property DefaultColor: TColor read FDefaultColor write SetDefaultColor default clWindow;
  	property FocusedColor: TColor read FFocusedColor write SetFocusedColor default $00BFD6FB;
  end;

procedure Register;

implementation

uses
  StdCtrls,
  s0DateEdit,
	s0CtrlDistiller;

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1FocusColor]);
end;

type
	T9CtrlEventListener = class(Ts0CtrlEventListener)
  private
    FDefaultColor: TColor;
    FFocusedColor: TColor;
    procedure SetColor(Sender: TObject; AColor: TColor);
  public
  	constructor Create(ADefaultColor: TColor; AFocusedColor: TColor);
    procedure CtrlOnEnter(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
  end;

{ T9CtrlEventListener }

constructor T9CtrlEventListener.Create(ADefaultColor,
  AFocusedColor: TColor);
begin
	FDefaultColor := ADefaultColor;
  FFocusedColor := AFocusedColor;
end;

procedure T9CtrlEventListener.CtrlOnEnter(Sender: TObject);
begin
	SetColor(Sender, FFocusedColor);
end;

procedure T9CtrlEventListener.CtrlOnExit(Sender: TObject);
begin
	SetColor(Sender, FDefaultColor);
end;

procedure T9CtrlEventListener.SetColor(Sender: TObject; AColor: TColor);
begin
	Ts0CtrlDistillBroker.SetColor(Sender, AColor);
end;

{ Ttec1FocusColor }

constructor Ttec1FocusColor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, False);
	FDefaultColor := clWindow;
  FFocusedColor := $00BFD6FB;
end;

function Ttec1FocusColor.CreateItems: Ts0CESnatcherItems;
begin
	Result := Ts0CESnatcherItems.Create(Self, Ttec1CtrlFocusColorItem);
end;

destructor Ttec1FocusColor.Destroy;
begin
	FreeAndNil(FListener);
  inherited Destroy;
end;

procedure Ttec1FocusColor.HandlingControl(AControl: TControl);
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

procedure Ttec1FocusColor.HandlingEvents;
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

procedure Ttec1FocusColor.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in Self.ComponentState) then
  begin
    FListener := T9CtrlEventListener.Create(Self.DefaultColor, Self.FocusedColor);
    HandlingEvents;
  end;
end;

procedure Ttec1FocusColor.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if not (csDesigning in Self.ComponentState) then
  begin
    if csDestroying in Self.ComponentState then
			PutEventBack;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure Ttec1FocusColor.SetDefaultColor(const Value: TColor);
begin
  FDefaultColor := Value;
end;

procedure Ttec1FocusColor.SetFocusedColor(const Value: TColor);
begin
  FFocusedColor := Value;
end;

end.
 