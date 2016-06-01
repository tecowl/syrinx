unit s0ObjectsPropFilter;

interface

uses
  SysUtils, Classes,
  Contnrs,
  s0Collection;

type
  Ts0ObjectsPropFileterItem = class(Ts0CollectionItem)
  private
    FObjectCaption: string;
    FPropValue: string;
    FObj: TObject;
    procedure SetObjectCaption(const Value: string);
    procedure SetPropValue(const Value: string);
  protected
    procedure SetObj(Value: TObject);
  public
    constructor Create(ACollection: TCollection); override;
    property Obj: TObject read FObj;
    procedure LoadFromObj;
    procedure SaveToObj;
  published
    property ObjectCaption: string read FObjectCaption write SetObjectCaption;
    property PropValue: string read FPropValue write SetPropValue;
  end;

type
  Ts0ObjectsPropFileterItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0ObjectsPropFileterItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0ObjectsPropFileterItem);
  public
    function Add(AObj: TObject): Ts0ObjectsPropFileterItem;
    procedure RemoveByObj(AObj: TObject);
    property Items[const Index: Integer]: Ts0ObjectsPropFileterItem
      read GetItems write SetItems;
  end;

type
  Ts0ObjectsPropFilter = class(TComponent)
  private
    FPropertyName: string;
    FItems: Ts0ObjectsPropFileterItems;
    FSourceList: TObjectList;
    FFilterClassName: string;
    procedure SetItems(const Value: Ts0ObjectsPropFileterItems);
    procedure SetPropertyName(const Value: string);
    procedure SetSourceList(const Value: TObjectList);
    procedure SetFilterClassName(const Value: string);
    function GetFilterClass: TClass;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshItems;
    procedure SaveItemValues;
    procedure SourceObjRemoved(AObj: TObject);
    property SourceList: TObjectList read FSourceList write SetSourceList;
    property FilterClass: TClass read GetFilterClass;
  published
    property FilterClassName: string read FFilterClassName write SetFilterClassName;
    property PropertyName: string read FPropertyName write SetPropertyName;
    property Items: Ts0ObjectsPropFileterItems read FItems write SetItems;
  end;

type
  Es0ObjectsPropFilter = class(Exception);

procedure Register;

implementation

uses
  s0ObjectHelper,
  s0TypInfoWrapper;

procedure Register;
begin
  RegisterComponents('P DM', [Ts0ObjectsPropFilter]);
end;

{ Ts0ObjectsPropFileterItem }

resourcestring
  c9ErrMsg_CannotAddItemOnDesigning = 'ê›åvéûÇ…çÄñ⁄Çí«â¡Ç∑ÇÈÇ±Ç∆ÇÕÇ≈Ç´Ç‹ÇπÇÒ';

constructor Ts0ObjectsPropFileterItem.Create(ACollection: TCollection);
begin
  inherited;
  if (OwnerComponent = nil) or (csDesigning in OwnerComponent.ComponentState) then
    raise Es0ObjectsPropFilter.Create(c9ErrMsg_CannotAddItemOnDesigning);
end;

procedure Ts0ObjectsPropFileterItem.LoadFromObj;
var
  acsr: Ts0RTTIPublishedAccessor;
  fltr: Ts0ObjectsPropFilter;
begin
  Assert(OwnerComponent is Ts0ObjectsPropFilter);
  fltr := Ts0ObjectsPropFilter(OwnerComponent);
  acsr := Ts0RTTIPublishedAccessor.Create(FObj);
  try
    FPropValue := acsr.PropAsString[ fltr.PropertyName ];
  finally
    FreeAndNil(acsr);
  end;
  Changed(False);
end;

procedure Ts0ObjectsPropFileterItem.SaveToObj;
var
  acsr: Ts0RTTIPublishedAccessor;
  fltr: Ts0ObjectsPropFilter;
begin
  Assert(OwnerComponent is Ts0ObjectsPropFilter);
  fltr := Ts0ObjectsPropFilter(OwnerComponent);
  acsr := Ts0RTTIPublishedAccessor.Create(FObj);
  try
    acsr.PropAsString[ fltr.PropertyName ] := FPropValue;
  finally
    FreeAndNil(acsr);
  end;
end;

procedure Ts0ObjectsPropFileterItem.SetObj(Value: TObject);
begin
  FObj := Value;
  FObjectCaption := Ts0ObjectHelper.GetObjectCaption(FObj);
  LoadFromObj;
end;

procedure Ts0ObjectsPropFileterItem.SetObjectCaption(const Value: string);
begin
end;

procedure Ts0ObjectsPropFileterItem.SetPropValue(const Value: string);
begin
  FPropValue := Value;
  Changed(False);
end;

{ Ts0ObjectsPropFileterItems }

function Ts0ObjectsPropFileterItems.Add(
  AObj: TObject): Ts0ObjectsPropFileterItem;
begin
  Result := Ts0ObjectsPropFileterItem(inherited Add);
  Result.SetObj(AObj);
end;

function Ts0ObjectsPropFileterItems.GetItems(
  const Index: Integer): Ts0ObjectsPropFileterItem;
begin
  Result := Ts0ObjectsPropFileterItem(inherited Items[Index]);
end;

procedure Ts0ObjectsPropFileterItems.RemoveByObj(AObj: TObject);
var
  i: Integer;
begin
  for i := Self.Count -1 downto 0 do
    if Items[i].FObj = AObj then
      Delete(i);
end;

procedure Ts0ObjectsPropFileterItems.SetItems(const Index: Integer;
  const Value: Ts0ObjectsPropFileterItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0ObjectsPropFilter }

constructor Ts0ObjectsPropFilter.Create(AOwner: TComponent);
begin
  inherited;
  FItems := Ts0ObjectsPropFileterItems.Create(Self, Ts0ObjectsPropFileterItem);
  FSourceList := TObjectList.Create(False);
end;

destructor Ts0ObjectsPropFilter.Destroy;
begin
  FreeAndNil(FSourceList);
  FreeAndNil(FItems);
  inherited;         
end;

function Ts0ObjectsPropFilter.GetFilterClass: TClass;
begin
  Result := GetClass(FFilterClassName);
  if Result <> nil then Exit;
  Result := TObject;
end;

procedure Ts0ObjectsPropFilter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  SourceObjRemoved(AComponent);
end;

procedure Ts0ObjectsPropFilter.RefreshItems;
  function HasProp(AObj: TObject): Boolean;
  var
    acsr: Ts0RTTIPublishedAccessor;
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      Result := acsr.PropertyExists(PropertyName);
    finally
      FreeAndNil(acsr);
    end;
  end;
var
  i: Integer;
  obj: TObject;
begin
  FItems.Clear;
  if PropertyName = '' then Exit;
  for i := 0 to FSourceList.Count -1 do
  begin
    obj := FSourceList.Items[i];
    if not(obj is FilterClass) then Continue;
    if not HasProp(obj) then Continue;
    FItems.Add(obj);
  end;
end;

procedure Ts0ObjectsPropFilter.SaveItemValues;
var
  i: Integer;
begin
  for i := 0 to FItems.Count -1 do
    FItems.Items[i].SaveToObj;
end;

procedure Ts0ObjectsPropFilter.SetFilterClassName(const Value: string);
begin
  if FFilterClassName = Value then Exit;
  FFilterClassName := Value;
  Items.Clear;
end;

procedure Ts0ObjectsPropFilter.SetItems(
  const Value: Ts0ObjectsPropFileterItems);
begin
  FItems.Assign(Value);
end;

procedure Ts0ObjectsPropFilter.SetPropertyName(const Value: string);
begin
  if FPropertyName = Value then Exit;
  FPropertyName := Value;
  Items.Clear;
end;

procedure Ts0ObjectsPropFilter.SetSourceList(const Value: TObjectList);
var
  i: Integer;
  obj: TObject;
begin
  FSourceList.Clear;
  if Value = nil then Exit;
  for i := 0 to Value.Count -1 do
  begin
    obj := Value.Items[i];
    FSourceList.Add(obj);
    if obj is TComponent then
      FreeNotification( TComponent(obj) );
  end;
end;

procedure Ts0ObjectsPropFilter.SourceObjRemoved(AObj: TObject);
begin
  if AObj is TComponent then
    RemoveFreeNotification( TComponent(AObj) );
  FSourceList.Remove(AObj);
  FItems.RemoveByObj(AObj);
end;

end.
 
