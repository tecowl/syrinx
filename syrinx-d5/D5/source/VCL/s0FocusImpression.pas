unit s0FocusImpression;

interface

uses
	SysUtils, Classes, Controls,
  s0FieldImpression, s0FocusExpression;

type
  Ts0FocusImpression = class(Ts0FocusExpression)
  private
    FFieldImpression: Ts0FieldImpression;
    FDeactivateOnExit: Boolean;
    procedure SetFieldImpression(const Value: Ts0FieldImpression);
    procedure SetDeactivateOnExit(const Value: Boolean);
  protected
    procedure CtrlEnter(AControl: TCOntrol); override;
    procedure CtrlExit(AControl: TCOntrol); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
		property FieldImpression: Ts0FieldImpression read FFieldImpression write SetFieldImpression;
    property DeactivateOnExit: Boolean read FDeactivateOnExit write SetDeactivateOnExit default False;
    property OnEnter;
    property OnExit;
  end;

procedure Register;
  
implementation

procedure Register;
begin
  RegisterComponents('P Form', [Ts0FocusImpression]);
end;

{ Ts0FocusImpression }

constructor Ts0FocusImpression.Create(AOwner: TComponent);
begin
  inherited;
  FDeactivateOnExit := False;
end;

procedure Ts0FocusImpression.CtrlEnter(AControl: TCOntrol);
begin
  if not CanExpressOnEnter(AControl) then
  	Exit;
  if FieldImpression <> nil then
  	FFieldImpression.ActivateOn(AControl);
end;

procedure Ts0FocusImpression.CtrlExit(AControl: TCOntrol);
begin
  if not DeactivateOnExit then
  	Exit;
  if not CanExpressOnExit(AControl) then
  	Exit;
  if FieldImpression <> nil then
  	FFieldImpression.Deactivate;
end;

destructor Ts0FocusImpression.Destroy;
begin
  inherited;
end;

procedure Ts0FocusImpression.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
	if Operation = opRemove then
  begin
		if FFieldImpression = AComponent then
    	FFieldImpression := nil;
  end;
end;

procedure Ts0FocusImpression.SetDeactivateOnExit(const Value: Boolean);
begin
  FDeactivateOnExit := Value;
end;

procedure Ts0FocusImpression.SetFieldImpression(
  const Value: Ts0FieldImpression);
begin
  FFieldImpression := Value;
end;

end.
