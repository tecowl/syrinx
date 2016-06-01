unit s0PropertyOrganizer;

interface

uses
  SysUtils, Classes,
  s0Collection, s0Observer, s0ComponentEventWrapper;

type
	K0ClassNameMatchType = (k0cnmtExactllyMatch, k0cnmtInheritance);

type
  Ts0PropertyOrganizerItem = class(Ts0CollectionItem)
  private
    FEnabled: Boolean;
    FValue: string;
    FTargetItemProperty: string;
    FTargetClassName: String;
    FTargetProperty: string;
    FActive: Boolean;
    FCaption: String;
    FClassNameMatch: K0ClassNameMatchType;
    procedure SetTargetClassName(const Value: String);
    procedure SetTargetItemProperty(const Value: string);
    procedure SetTargetProperty(const Value: string);
    procedure SetValue(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetCaption(const Value: String);
    procedure SetClassNameMatch(const Value: K0ClassNameMatchType);
  protected
  	function IsTarget(AComponent: TComponent): Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Apply;
    procedure ApplyTo(AComponentOwner: TComponent);
  published
    property Active: Boolean read FActive write SetActive stored False;
    property ClassNameMatch: K0ClassNameMatchType read FClassNameMatch write SetClassNameMatch;
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property Caption: String read FCaption write SetCaption;
    property TargetClassName: String read FTargetClassName write SetTargetClassName;
    property TargetProperty: string read FTargetProperty write SetTargetProperty;
    property TargetItemProperty: string read FTargetItemProperty write SetTargetItemProperty;
    property Value: string read FValue write SetValue;
  end;

type
  Ts0PropertyOrganizerItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0PropertyOrganizerItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0PropertyOrganizerItem);
  public
    function Add(AClassNameMatch: K0ClassNameMatchType; ACaption: String; ATargetClassName: String;
    	ATargetProperty, ATargetItemProperty: string; AValue: string): Ts0PropertyOrganizerItem; virtual;
    function AddItem: Ts0PropertyOrganizerItem;
    property Items[const Index: Integer]: Ts0PropertyOrganizerItem read GetItems write SetItems; default;
  end;


type
  Ts0PropertyOrganizer = class(TComponent)
  private
    FItems: Ts0PropertyOrganizerItems;
    FApplyEvent: K0FormEventTypeSet;
    procedure SetItems(const Value: Ts0PropertyOrganizerItems);
    procedure SetApplyEvent(const Value: K0FormEventTypeSet);
  protected
    FListener: Ts0EventListener;
    procedure EventNotified(Sender: TObject);
  	procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyItemsTo(AComponentOwner: TComponent);
    procedure ApplyItems;
  published
    property ApplyEvent: K0FormEventTypeSet read FApplyEvent write SetApplyEvent;
    property Items: Ts0PropertyOrganizerItems read FItems write SetItems;
  end;

procedure Register;

implementation

uses
	s0StringHelper,
	s0TypInfoWrapper,
  s0PropertyAccessor;

procedure Register;
begin
  RegisterComponents('P DM', [Ts0PropertyOrganizer]);
end;

{ Ts0PropertyOrganizerItem }

procedure Ts0PropertyOrganizerItem.Apply;
begin
  if not Enabled then
  	Exit;
	if OwnerComponent = nil then
  	Exit;
	Self.ApplyTo(OwnerComponent.Owner);
end;

procedure Ts0PropertyOrganizerItem.ApplyTo(AComponentOwner: TComponent);
var
	i: Integer;
  c: TComponent;
  accessor: Ts0PropertyAccessor;
begin
  if not Enabled then
  	Exit;
	if AComponentOwner = nil then
  	Exit;
	accessor := Ts0PropertyAccessor.Create(FTargetProperty, FTargetItemProperty);
  try
    for i := 0 to AComponentOwner.ComponentCount -1 do
    begin
      c := AComponentOwner.Components[i];
      if IsTarget(c) then
        accessor.SetToTarget(c, Self.Value);
    end;
  finally
    FreeAndNil(accessor);
  end;
end;

constructor Ts0PropertyOrganizerItem.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
end;

function Ts0PropertyOrganizerItem.IsTarget(AComponent: TComponent): Boolean;
var
	currentClass: TClass;
begin
  if Self.ClassNameMatch = k0cnmtExactllyMatch then
  begin
		Result := AComponent.ClassNameIs(Self.TargetClassName);
  end
  else
  begin
  	currentClass := AComponent.ClassType;
  	while true do
    begin
			if currentClass.ClassNameIs(Self.TargetClassName) then
      begin
      	Result := True;
        Exit;
      end;
      if currentClass = TObject then
      	Break;
      currentClass := currentClass.ClassParent;
    end;
    Result := False;
  end;
end;

procedure Ts0PropertyOrganizerItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
end;

procedure Ts0PropertyOrganizerItem.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if FActive then
  	Apply;
end;

procedure Ts0PropertyOrganizerItem.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

procedure Ts0PropertyOrganizerItem.SetClassNameMatch(
  const Value: K0ClassNameMatchType);
begin
  FClassNameMatch := Value;
end;

procedure Ts0PropertyOrganizerItem.SetTargetClassName(const Value: String);
begin
  FTargetClassName := Value;
end;

procedure Ts0PropertyOrganizerItem.SetTargetItemProperty(
  const Value: string);
begin
  FTargetItemProperty := Value;
end;

procedure Ts0PropertyOrganizerItem.SetTargetProperty(const Value: string);
begin
  FTargetProperty := Value;
end;

procedure Ts0PropertyOrganizerItem.SetValue(const Value: string);
begin
  FValue := Value;
end;

{ Ts0PropertyOrganizerItems }

function Ts0PropertyOrganizerItems.Add(
  AClassNameMatch: K0ClassNameMatchType; ACaption, ATargetClassName,
  ATargetProperty, ATargetItemProperty, AValue: string): Ts0PropertyOrganizerItem;
begin
	Result := Self.AddItem;
  Result.ClassNameMatch := AClassNameMatch;
  Result.Caption := ACaption;
  Result.TargetClassName := ATargetClassName;
  Result.TargetProperty := ATargetProperty;
  Result.TargetItemProperty := ATargetItemProperty;
  Result.Value := AValue;
end;

function Ts0PropertyOrganizerItems.AddItem: Ts0PropertyOrganizerItem;
begin
	Result := Ts0PropertyOrganizerItem(inherited Add);
end;

function Ts0PropertyOrganizerItems.GetItems(
  const Index: Integer): Ts0PropertyOrganizerItem;
begin
	Result := Ts0PropertyOrganizerItem(inherited GetItem(Index));
end;

procedure Ts0PropertyOrganizerItems.SetItems(const Index: Integer;
  const Value: Ts0PropertyOrganizerItem);
begin
	inherited SetItem(Index, Value);
end;

{ Ts0PropertyOrganizer }

procedure Ts0PropertyOrganizer.ApplyItems;
begin
	Self.ApplyItemsTo(Self);
end;

procedure Ts0PropertyOrganizer.ApplyItemsTo(AComponentOwner: TComponent);
var
	i: Integer;
begin
	for i := 0 to FItems.Count -1 do
    FItems.Items[i].ApplyTo(AComponentOwner);
end;

constructor Ts0PropertyOrganizer.Create(AOwner: TComponent);
begin
  inherited;
  FItems := Ts0PropertyOrganizerItems.Create(Self, Ts0PropertyOrganizerItem);
  FListener := Ts0EventListener.Create(Self.EventNotified);
end;

destructor Ts0PropertyOrganizer.Destroy;
begin
	FreeAndNil(FListener);
	FreeAndNil(FItems);
  inherited;
end;

procedure Ts0PropertyOrganizer.EventNotified(Sender: TObject);
begin
  ApplyItems;
end;

procedure Ts0PropertyOrganizer.Loaded;
var
  publisher: Ts0ComponentEventWrapper;
begin
  inherited;
  publisher := Ts0ComponentEventWrapper.FindEventWrapper(Owner);
  if publisher = nil then
    Exit;
  publisher.AddListener(FListener, ApplyEvent);
end;

procedure Ts0PropertyOrganizer.SetApplyEvent(
  const Value: K0FormEventTypeSet);
begin
  FApplyEvent := Value;
end;

procedure Ts0PropertyOrganizer.SetItems(
  const Value: Ts0PropertyOrganizerItems);
begin
  FItems.Assign(Value);
end;

end.
 