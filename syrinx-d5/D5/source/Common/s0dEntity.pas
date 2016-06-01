unit s0dEntity;

interface

uses
  SysUtils, Classes,
  Contnrs,
  s0Entity;

type
  Tdm0Entity = TDataModule;
  Ts0dmEntityClass = class of Tdm0Entity;

type
  Ts0dmEntityDummy = class(TDataModule)
  private
  public
  end;

type
  Ts0EtyDMClassMap = class
  private
    FMapItemList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddMapItem(AEntityClass: Ts0EntityClass; ADMClass: Ts0dmEntityClass);
    function FindDMClass(AEntityClass: Ts0EntityClass): Ts0dmEntityClass;
    function FindDMClassByName(ADMClassName: string): Ts0dmEntityClass;
    procedure RemoveMapItem(ADMClass: Ts0dmEntityClass);
  end;

type
  Ts0EntityDMClassBroker = class
  private
    FEtyDMClassMap: Ts0EtyDMClassMap;
  public
    constructor Create;
    destructor Destroy; override;
    function FindEntityDMClassByName(AClassName: string): Ts0dmEntityClass;
    procedure RegisterEntityDMClass(ADM: Ts0dmEntityClass; AEntityClass: Ts0EntityClass);
    procedure UnRegisterEntityDMClass(ADM: Ts0dmEntityClass);
    function GetRegisteredDMClass(AEntityClass: Ts0EntityClass): Ts0dmEntityClass;
    class function Instance: Ts0EntityDMClassBroker;
  end;

procedure RegisterEntityDMClass(ADM: Ts0dmEntityClass; AEntityClass: Ts0EntityClass);
procedure UnRegisterEntityDMClass(ADM: Ts0dmEntityClass);

var
  dm0EntityDummy: Ts0dmEntityDummy;

implementation

{$R *.dfm}

procedure RegisterEntityDMClass(ADM: Ts0dmEntityClass; AEntityClass: Ts0EntityClass);
begin
  Ts0EntityDMClassBroker.Instance.RegisterEntityDMClass(ADM, AEntityClass);
end;

procedure UnRegisterEntityDMClass(ADM: Ts0dmEntityClass);
begin
  Ts0EntityDMClassBroker.Instance.UnRegisterEntityDMClass(ADM);
end;

type
  T9EtyDMClassMapItem = class
  protected
    FEtyClass: Ts0EntityClass;
    FDMClass: Ts0dmEntityClass;
  public
    constructor Create(AEtyClass: Ts0EntityClass; ADMClass: Ts0dmEntityClass);
  end;

{ T9EtyDMClassMapItem }

constructor T9EtyDMClassMapItem.Create(AEtyClass: Ts0EntityClass;
  ADMClass: Ts0dmEntityClass);
begin
  inherited Create;
  FEtyClass := AEtyClass;
  FDMClass := ADMClass;
end;

{ Ts0EtyDMClassMap }

procedure Ts0EtyDMClassMap.AddMapItem(AEntityClass: Ts0EntityClass;
  ADMClass: Ts0dmEntityClass);
var
  mi: T9EtyDMClassMapItem;
begin
  if FindDMClass(AEntityClass) <> nil then Exit;
  mi := T9EtyDMClassMapItem.Create(AEntityClass, ADMClass);
  FMapItemList.Add(mi);
end;

constructor Ts0EtyDMClassMap.Create;
begin
  inherited Create;
  FMapItemList := TObjectList.Create(True);
end;

destructor Ts0EtyDMClassMap.Destroy;
begin
  FreeAndNil(FMapItemList);
  inherited;
end;

function Ts0EtyDMClassMap.FindDMClass(
  AEntityClass: Ts0EntityClass): Ts0dmEntityClass;
var
  i: Integer;
  mi: T9EtyDMClassMapItem;
begin
  Result := nil;
  for i := 0 to FMapItemList.Count -1 do
  begin
    Assert(FMapItemList.Items[i] <> nil);
    Assert(FMapItemList.Items[i] is T9EtyDMClassMapItem);
    mi := T9EtyDMClassMapItem(FMapItemList.Items[i]);
    if not mi.FEtyClass.InheritsFrom(AEntityClass) then Continue;
    Result := Ts0dmEntityClass(mi.FDMClass);
    Exit;
  end;
end;

function Ts0EtyDMClassMap.FindDMClassByName(
  ADMClassName: string): Ts0dmEntityClass;
var
  i: Integer;
  mi: T9EtyDMClassMapItem;
begin
  Result := nil;
  for i := 0 to FMapItemList.Count -1 do
  begin
    Assert(FMapItemList.Items[i] <> nil);
    Assert(FMapItemList.Items[i] is T9EtyDMClassMapItem);
    mi := T9EtyDMClassMapItem(FMapItemList.Items[i]);
    if mi.FDMClass = nil then Continue;
    if not mi.FDMClass.ClassNameIs(ADMClassName) then Continue;
    Result := Ts0dmEntityClass(mi.FDMClass);
    Exit;
  end;
end;

procedure Ts0EtyDMClassMap.RemoveMapItem(ADMClass: Ts0dmEntityClass);
var
  i: Integer;
  mi: T9EtyDMClassMapItem;
begin
  for i := FMapItemList.Count -1 downto 0 do
  begin
    Assert(FMapItemList.Items[i] <> nil);
    Assert(FMapItemList.Items[i] is T9EtyDMClassMapItem);
    mi := T9EtyDMClassMapItem(FMapItemList.Items[i]);
    if mi.FDMClass <> ADMClass then Continue;
    FMapItemList.Delete(i);
  end;
end;

{ Ts0EntityDMClassBroker }

constructor Ts0EntityDMClassBroker.Create;
begin
  inherited Create;
  FEtyDMClassMap := Ts0EtyDMClassMap.Create;
end;

destructor Ts0EntityDMClassBroker.Destroy;
begin
  FreeAndNil(FEtyDMClassMap);
  inherited;
end;

function Ts0EntityDMClassBroker.FindEntityDMClassByName(
  AClassName: string): Ts0dmEntityClass;
begin
  Result := FEtyDMClassMap.FindDMClassByName(AClassName);
end;

function Ts0EntityDMClassBroker.GetRegisteredDMClass(
  AEntityClass: Ts0EntityClass): Ts0dmEntityClass;
begin
  Result := nil;
  if FEtyDMClassMap = nil then Exit;
  Result := FEtyDMClassMap.FindDMClass(AEntityClass);
end;

var
  g9DMClassBroker: Ts0EntityDMClassBroker = nil;

class function Ts0EntityDMClassBroker.Instance: Ts0EntityDMClassBroker;
begin
  if g9DMClassBroker = nil then
    g9DMClassBroker := Ts0EntityDMClassBroker.Create;
  Result := g9DMClassBroker;
end;

procedure Ts0EntityDMClassBroker.RegisterEntityDMClass(ADM: Ts0dmEntityClass;
  AEntityClass: Ts0EntityClass);
begin
  if FEtyDMClassMap = nil then
    FEtyDMClassMap := Ts0EtyDMClassMap.Create;
  if FEtyDMClassMap.FindDMClass(AEntityClass) <> nil then Exit;
  FEtyDMClassMap.AddMapItem(AEntityClass, ADM);
end;

procedure Ts0EntityDMClassBroker.UnRegisterEntityDMClass(
  ADM: Ts0dmEntityClass);
begin
  if FEtyDMClassMap = nil then Exit;
  FEtyDMClassMap.RemoveMapItem(ADM);
end;

end.
