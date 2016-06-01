unit s0BoundsLayout;

interface

uses
  SysUtils, Classes,
  s0Bounds,
  s0Collection;

type
  Ts0BoundsLayoutItems = class;

  Ts0BoundsLayoutItem = class(Ts0InterfacedCollectionItem, Is0Bounds)
  private
    FTarget: TObject;
    FTargetName: string;
    FSubItems: Ts0BoundsLayoutItems;
  private
    { Is0Bounds }
    FCtrlBounds: array[Ks0BoundsItemKind] of Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetLeft(Value: Integer);
    procedure SetTop(Value: Integer);
    procedure SetWidth(Value: Integer);
    procedure SetHeight(Value: Integer);
  protected
    procedure SetTargetName(const Value: string);
    procedure SetSubItems(Value: Ts0BoundsLayoutItems);
    function GetTarget: TObject;
  protected
    function FindTarget(AName: string): TObject;
    class function FindTargetByParent(AParent: TObject; AName: string): TObject;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Target: TObject read GetTarget;
    procedure BuildFromTarget(ATarget: TObject);
    procedure Layout;
    class function IsSupportedObj(ATarget: TObject): Boolean;
  public
    { Is0Bounds }
    function GetValue(const AKind: Ks0BoundsItemKind): Integer;
    procedure SetValue(const AKind: Ks0BoundsItemKind; Value: Integer);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
  published
    property TargetName: string read FTargetName write SetTargetName;
    property Left  : Integer read GetLeft   write SetLeft   ;
    property Top   : Integer read GetTop    write SetTop    ;
    property Width : Integer read GEtWidth  write SetWidth  ;
    property Height: Integer read GetHeight write SetHeight ;
    property SubItems: Ts0BoundsLayoutItems read FSubItems write SetSubItems;
  end;

  Ts0BoundsLayoutItems = class(Ts0InterfacedCollection)
  private
    function GetItems(const Index: Integer): Ts0BoundsLayoutItem;
    procedure SetItems(const Index: Integer; Value: Ts0BoundsLayoutItem);
  protected
    procedure BuildItems(ATarget: TObject);
  public
    function Add(ATarget: TObject): Ts0BoundsLayoutItem;
    function AddAndBuild(ATarget: TObject): Ts0BoundsLayoutItem;
    function AddName(ATargetName: string): Ts0BoundsLayoutItem;
    function AddNameAndBounds(ATargetName: string; ALeft, ATop, AWidth, AHeight: Integer): Ts0BoundsLayoutItem;
    function ItemByName(AName: string): Ts0BoundsLayoutItem;
    function ItemByTarget(ATarget: TObject): Ts0BoundsLayoutItem;
    property Items[const Index: Integer]: Ts0BoundsLayoutItem read GetItems write SetItems; default;
  end;

type
  Ts0BoundsLayout = class(TComponent)
  private
    FItems: Ts0BoundsLayoutItems;
    FTarget: TObject;
    procedure SetItems(Value: Ts0BoundsLayoutItems);
    procedure SetTarget(Value: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function FindTarget(AName: string): TObject;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BuildItems; virtual;
    procedure LayoutTargets; virtual;
  published
    property Target: TObject read FTarget write SetTarget;
    property Items: Ts0BoundsLayoutItems read FItems write SetItems;
  end;

type
  Ks0SetItemNameKind = (
    ks0sinkUOCTargetClass, //Ts0UnifiedObjCtrlなどのTargetとなるクラス
    ks0sinkIdentifier      //任意の識別子
  );

type
  Ts0LayoutSetItem = class(Ts0CollectionItem)
  private
    FLayout: Ts0BoundsLayout;
    FSetItemName: string;
    FSetItemNameKind: Ks0SetItemNameKind;
    function GetItems: Ts0BoundsLayoutItems;
    procedure SetItems(Value: Ts0BoundsLayoutItems);
    procedure SetSetItemName(const Value: string);
    procedure SetSetItemNameKind(const Value: Ks0SetItemNameKind);
    function GetTarget: TObject;
    procedure SetTarget(Value: TObject);
  protected
    function GetIdentifier: string; override;
    function GetDisplayName: string; override;
    function NewLayout: Ts0BoundsLayout; virtual;
    property Layout: Ts0BoundsLayout read FLayout;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure BuildItems; virtual;
    procedure LayoutTargets; virtual;
    property Target: TObject read GetTarget write SetTarget;
  published
    property SetItemName: string read FSetItemName write SetSetItemName;
    property SetItemNameKind: Ks0SetItemNameKind read FSetItemNameKind write SetSetItemNameKind default ks0sinkUOCTargetClass;
    property Items: Ts0BoundsLayoutItems read GetItems write SetItems;
  end;

type
  Ts0LayoutSetItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0LayoutSetItem;
    procedure SetItems(const Index: Integer; Value: Ts0LayoutSetItem);
  public
    function Add(ASetItemName: string;
      AKind: Ks0SetItemNameKind = ks0sinkUOCTargetClass): Ts0LayoutSetItem;
    function ItemByName(AName: string): Ts0LayoutSetItem;
    property Items[const Index: Integer]: Ts0LayoutSetItem read GetItems write SetItems; default;
  end;

type
  Ts0LayoutSet = class(TComponent)
  private
    FItems: Ts0LayoutSetItems;
    procedure SetItems(Value: Ts0LayoutSetItems);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Items: Ts0LayoutSetItems read FItems write SetItems;
  end;

type
  Es0BoundsLayout = class(Exception);

procedure Register;

implementation

uses
  s0Iterator,
  s0Classes;

procedure Register;
begin
  RegisterComponents('P Form', [Ts0BoundsLayout]);
  RegisterComponents('P Form', [Ts0LayoutSet]);
end;

{ Ts0BoundsLayoutItem }

procedure Ts0BoundsLayoutItem.Assign(Source: TPersistent);
var
  i: Ks0BoundsItemKind;
begin
  inherited Assign(Source);
  if not(Source is Ts0BoundsLayoutItem) then Exit;
  for i := Low(Ks0BoundsItemKind) to High(Ks0BoundsItemKind) do
    FCtrlBounds[i] := Ts0BoundsLayoutItem(Source).FCtrlBounds[i];
  FTargetName := Ts0BoundsLayoutItem(Source).FTargetName;
end;

resourcestring
  c9ErrMsg_TargetIsNil = 'コントロールがnilです';

procedure Ts0BoundsLayoutItem.BuildFromTarget(ATarget: TObject);
var
  bounds: Is0Bounds;
  ident: Is0Identified;
begin
  if ATarget = nil then
    raise Es0BoundsLayout.Create(c9ErrMsg_TargetIsNil);
  if Supports(ATarget, Is0Bounds, bounds) and Supports(ATarget, Is0Identified, ident) then
  begin
    SetBounds(bounds.Left, bounds.Top, bounds.Width, bounds.Height);
    FTargetName := ident.Identifier;
  end;
  SubItems.BuildItems(ATarget);
end;

constructor Ts0BoundsLayoutItem.Create(ACollection: TCollection);
begin
  inherited;
  FSubItems := Ts0BoundsLayoutItems.Create(Self, Ts0BoundsLayoutItem);
end;

destructor Ts0BoundsLayoutItem.Destroy;
begin
  FreeAndNil(FSubItems);
  inherited;
end;

function Ts0BoundsLayoutItem.FindTarget(AName: string): TObject;
begin
  Result := FindTargetByParent(Target, AName);
end;

class function Ts0BoundsLayoutItem.FindTargetByParent(AParent: TObject;
  AName: string): TObject;
var
  aggr: Is0Aggregate;
  ite: Is0ObjIterator;
  ident: Is0Identified;
begin
  Result := nil;
  if AParent = nil then Exit;
  if not Supports(AParent, Is0Aggregate, aggr) then Exit;
  ite := aggr.Iterator;
  while ite.HasNext do
  begin
    Result := ite.Next;
    if not Supports(Result, Is0Identified, ident) then Continue;
    if SameText(ident.Identifier, AName) then Exit;
  end;
  Result := nil;
end;

function Ts0BoundsLayoutItem.GetTarget: TObject;
  function FindTargetObj: TObject;
  begin
    Result := nil;
    if OwnerObj is Ts0BoundsLayoutItem then
      Result := Ts0BoundsLayoutItem(OwnerObj).FindTarget(FTargetName)
    else
    if OwnerObj is Ts0BoundsLayout then
      Result := Ts0BoundsLayout(OwnerObj).FindTarget(FTargetName);
  end;
begin
  if FTarget = nil then
    FTarget := FindTargetObj;
  Result := FTarget;
end;

class function Ts0BoundsLayoutItem.IsSupportedObj(ATarget: TObject): Boolean;
var
  bounds: Is0Bounds;
begin
  Result := Supports(ATarget, Is0Bounds, bounds);
end;

procedure Ts0BoundsLayoutItem.Layout;
var
  i: Integer;
  bounds: Is0Bounds;
begin
  if Supports(Target, Is0Bounds, bounds) then
    bounds.SetBounds(Self.Left, Self.Top, Self.Width, Self.Height);
  for i := 0 to FSubItems.Count -1 do
    FSubItems[i].Layout;
end;

procedure Ts0BoundsLayoutItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
end;

procedure Ts0BoundsLayoutItem.SetTargetName(const Value: string);
begin
  FTargetName := Value;
end;

procedure Ts0BoundsLayoutItem.SetHeight(Value: Integer);
begin
  FCtrlBounds[ks0bkHeight] := Value;
end;

procedure Ts0BoundsLayoutItem.SetLeft(Value: Integer);
begin
  FCtrlBounds[ks0bkLeft] := Value;
end;

procedure Ts0BoundsLayoutItem.SetSubItems(Value: Ts0BoundsLayoutItems);
begin
  FSubItems.Assign(Value);
end;

procedure Ts0BoundsLayoutItem.SetTop(Value: Integer);
begin
  FCtrlBounds[ks0bkTop] := Value;
end;

procedure Ts0BoundsLayoutItem.SetWidth(Value: Integer);
begin
  FCtrlBounds[ks0bkWidth] := Value;
end;

procedure Ts0BoundsLayoutItem.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FCtrlBounds[ks0bkLeft  ] := ALeft  ;
  FCtrlBounds[ks0bkTop   ] := ATop   ;
  FCtrlBounds[ks0bkWidth ] := AWidth ;
  FCtrlBounds[ks0bkHeight] := AHeight;
end;

function Ts0BoundsLayoutItem.GetHeight: Integer;
begin
  Result := FCtrlBounds[ks0bkHeight];
end;

function Ts0BoundsLayoutItem.GetLeft: Integer;
begin
  Result := FCtrlBounds[ks0bkLeft];
end;

function Ts0BoundsLayoutItem.GetTop: Integer;
begin
  Result := FCtrlBounds[ks0bkTop];
end;

function Ts0BoundsLayoutItem.GetWidth: Integer;
begin
  Result := FCtrlBounds[ks0bkWidth];
end;

function Ts0BoundsLayoutItem.GetValue(const AKind: Ks0BoundsItemKind): Integer;
begin
  Result := FCtrlBounds[AKind];
end;

procedure Ts0BoundsLayoutItem.SetValue(const AKind: Ks0BoundsItemKind;
  Value: Integer);
begin
  FCtrlBounds[AKind] := Value;
end;

{ Ts0BoundsLayoutItems }

resourcestring
  c9ErrMsg_ATargetIsNotSupported = '引数ATargetで指定されたインスタンスはサポートされていません。';

function Ts0BoundsLayoutItems.Add(ATarget: TObject): Ts0BoundsLayoutItem;
var
  ident: Is0Identified;
begin
  if not Ts0BoundsLayoutItem.IsSupportedObj(ATarget) then
    raise Es0BoundsLayout.Create( c9ErrMsg_ATargetIsNotSupported);
  Result := Ts0BoundsLayoutItem(inherited Add);
  if Supports(ATarget, Is0Identified, ident) then
    Result.TargetName := ident.Identifier
end;

function Ts0BoundsLayoutItems.AddAndBuild(ATarget: TObject): Ts0BoundsLayoutItem;
begin
  Result := Add(ATarget);
  Result.BuildFromTarget( ATarget );
end;

function Ts0BoundsLayoutItems.AddName(ATargetName: string): Ts0BoundsLayoutItem;
begin
  Result := Ts0BoundsLayoutItem(inherited Add);
  Result.TargetName := ATargetName;
end;

function Ts0BoundsLayoutItems.AddNameAndBounds(ATargetName: string; ALeft, ATop,
  AWidth, AHeight: Integer): Ts0BoundsLayoutItem;
begin
  Result := AddName(ATargetName);
  Result.SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure Ts0BoundsLayoutItems.BuildItems(ATarget: TObject);
var
  aggr: Is0Aggregate;
  ite: Is0ObjIterator;
  obj: TObject;
begin
  if not Supports(ATarget, Is0Aggregate, aggr) then Exit;
  ite := aggr.Iterator;
  while ite.HasNext do
  begin
    obj := ite.Next;
    if Ts0BoundsLayoutItem.IsSupportedObj(obj) then
      AddAndBuild(obj);
  end;
end;

function Ts0BoundsLayoutItems.GetItems(const Index: Integer): Ts0BoundsLayoutItem;
begin
  Result := Ts0BoundsLayoutItem(inherited Items[Index]);
end;

function Ts0BoundsLayoutItems.ItemByName(AName: string): Ts0BoundsLayoutItem;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if SameText( Result.TargetName, AName ) then Exit;
  end;
  Result := nil;
end;

function Ts0BoundsLayoutItems.ItemByTarget(ATarget: TObject): Ts0BoundsLayoutItem;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if Result.Target = ATarget then Exit;
  end;
  Result := nil;
end;

procedure Ts0BoundsLayoutItems.SetItems(const Index: Integer;
  Value: Ts0BoundsLayoutItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0BoundsLayout }

procedure Ts0BoundsLayout.BuildItems;
begin
  FItems.Clear;
  FItems.BuildItems( FTarget );
end;

constructor Ts0BoundsLayout.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := Ts0BoundsLayoutItems.Create(Self, Ts0BoundsLayoutItem);
end;

destructor Ts0BoundsLayout.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

function Ts0BoundsLayout.FindTarget(AName: string): TObject;
begin
  Result := Ts0BoundsLayoutItem.FindTargetByParent(Target, AName);
end;

procedure Ts0BoundsLayout.LayoutTargets;
var
  i: Integer;
begin
  for i := 0 to FItems.Count -1 do
    FItems[i].Layout;
end;

procedure Ts0BoundsLayout.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FItems <> nil then
    FItems.Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if FTarget = AComponent then
    FTarget := nil; 
end;

procedure Ts0BoundsLayout.SetItems(Value: Ts0BoundsLayoutItems);
begin
  FItems.Assign(Value);
end;           

resourcestring
  c9ErrMsg_TargetDontImplmentsNotAggregate = 'TargetがIs0Aggregateをimplementsしていません';

procedure Ts0BoundsLayout.SetTarget(Value: TObject);
var
  aggr: Is0Aggregate;
begin
  if FTarget = Value then Exit;
  if Value is Ts0InterfacedCollection then
    Ts0InterfacedCollection(Value).Iterator;

  if not Supports(Value, Is0Aggregate, aggr) then
    raise Es0BoundsLayout.Create(c9ErrMsg_TargetDontImplmentsNotAggregate);
  FTarget := Value;
end;

{ Ts0LayoutSetItem }

procedure Ts0LayoutSetItem.BuildItems;
begin
  FLayout.BuildItems;
end;

constructor Ts0LayoutSetItem.Create(ACollection: TCollection);
begin
  inherited;
  FLayout := NewLayout;
  FSetItemNameKind := ks0sinkUOCTargetClass;
end;

destructor Ts0LayoutSetItem.Destroy;
begin
  FreeAndNil(FLayout);
  inherited;
end;

function Ts0LayoutSetItem.GetDisplayName: string;
begin
  Result := SetItemName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function Ts0LayoutSetItem.GetIdentifier: string;
begin
  Result := SetItemName;
  if Result = '' then
    Result := inherited GetIdentifier;
end;

function Ts0LayoutSetItem.GetItems: Ts0BoundsLayoutItems;
begin
  Result := FLayout.Items;
end;

function Ts0LayoutSetItem.GetTarget: TObject;
begin
  Result := FLayout.Target;
end;

procedure Ts0LayoutSetItem.LayoutTargets;
begin
  FLayout.LayoutTargets;
end;

function Ts0LayoutSetItem.NewLayout: Ts0BoundsLayout;
begin
  Result := Ts0BoundsLayout.Create(nil);
end;

procedure Ts0LayoutSetItem.SetItems(Value: Ts0BoundsLayoutItems);
begin
  FLayout.Items := Value;
end;

procedure Ts0LayoutSetItem.SetSetItemName(const Value: string);
begin
  FSetItemName := Value;
end;

procedure Ts0LayoutSetItem.SetSetItemNameKind(
  const Value: Ks0SetItemNameKind);
begin
  FSetItemNameKind := Value;
end;

procedure Ts0LayoutSetItem.SetTarget(Value: TObject);
begin
  FLayout.Target := Value;
end;

{ Ts0LayoutSetItems }

function Ts0LayoutSetItems.Add(ASetItemName: string;
  AKind: Ks0SetItemNameKind): Ts0LayoutSetItem;
begin
  Result := Ts0LayoutSetItem(inherited Add);
  Result.SetItemName := ASetItemName;
  Result.SetItemNameKind := AKind;
end;

function Ts0LayoutSetItems.GetItems(
  const Index: Integer): Ts0LayoutSetItem;
begin
  Result := Ts0LayoutSetItem(inherited Items[Index]);
end;

function Ts0LayoutSetItems.ItemByName(AName: string): Ts0LayoutSetItem;
begin
  Result := Ts0LayoutSetItem(inherited FindByIdentifier(AName));
end;

procedure Ts0LayoutSetItems.SetItems(const Index: Integer; Value: Ts0LayoutSetItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0LayoutSet }

constructor Ts0LayoutSet.Create(AOwner: TComponent);
begin
  inherited;
  FItems := Ts0LayoutSetItems.Create(Self, Ts0LayoutSetItem);
end;

destructor Ts0LayoutSet.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure Ts0LayoutSet.SetItems(Value: Ts0LayoutSetItems);
begin
  FItems.Assign(Value);
end;

end.
