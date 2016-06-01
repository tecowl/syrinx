{-----------------------------------------------------------------------------
 Unit Name: s0EnumCollection
 Author:    akima
 Purpose:
 TestCase: tc_s0EnumCollection
 $History: s0EnumCollection.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/11   Time: 3:39
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/12/10   Time: 16:13
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/12/06   Time: 13:33
 * Updated in $/source/D5Integrated
 * Ts0EnumCollectionBrokerを追加。Ts0EntityManagerが利用する。
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/06   Time: 12:10
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0EnumCollection;

interface

uses
  SysUtils, Classes,
  Contnrs,
  s0Collection;

type
  Ts0EnumItem = class(Ts0CollectionItem)
  private
    FText: string;
    FItemID: Integer;
    procedure SetText(const Value: string);
    procedure SetItemID(const Value: Integer);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ItemID: Integer read FItemID write SetItemID;
    property Text: string read FText write SetText;
  end;

type
  Ts0EnumItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0EnumItem;
    procedure SetItems(const Index: Integer; const Value: Ts0EnumItem);
  public
    function AddItem(AText: String; AItemID: Integer = -1): Ts0EnumItem;
    function FindByItemID(AItemID: Integer): Ts0EnumItem;
    function FindByText(AText: string): Ts0EnumItem;
    function IndexOfItemID(AItemID: Integer): Integer;
    function IndexOfText(AText: string): Integer;
    function ItemIDByText(AText: string): Integer;
    function TextByItemID(AItemID: Integer): string;
    property Items[const Index: Integer]: Ts0EnumItem read GetItems write SetItems; default;
  end;

type
  Ts0EnumCollection = class(TComponent)
  private
    FItems: Ts0EnumItems;
    FEnumName: string;
    FBeforeRefresh: TNotifyEvent;
    FAfterRefresh: TNotifyEvent;
    procedure SetItems(const Value: Ts0EnumItems);
    procedure SetEnumName(const Value: string);
  protected
    function NewItems: Ts0EnumItems; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoAfterRefresh;
    procedure DoBeforeRefresh;
    procedure DoRefresh; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh;
  published
    property EnumName: string read FEnumName write SetEnumName;
    property Items: Ts0EnumItems read FItems write SetItems;
    property AfterRefresh : TNotifyEvent read FAfterRefresh  write FAfterRefresh ;
    property BeforeRefresh: TNotifyEvent read FBeforeRefresh write FBeforeRefresh;
  end;

type
  Ts0EnumCollectionBroker = class
  private
    FItems: TComponentList;
  public
    constructor Create;
    destructor Destroy; override;
    function FindByName(AEnumName: string): Ts0EnumCollection;
    procedure RegisterEnumCollection(AEnumCol: Ts0EnumCollection);
    procedure UnRegisterEnumCollection(AEnumCol: Ts0EnumCollection);
    class function Instance: Ts0EnumCollectionBroker;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P DM', [Ts0EnumCollection]);
end;

{ Ts0EnumItem }

procedure Ts0EnumItem.Assign(Source: TPersistent);
begin
  inherited;

end;

procedure Ts0EnumItem.SetItemID(const Value: Integer);
begin
  FItemID := Value;
end;

procedure Ts0EnumItem.SetText(const Value: string);
begin
  FText := Value;
end;

{ Ts0EnumItems }

function Ts0EnumItems.AddItem(AText: string; AItemID: Integer): Ts0EnumItem;
begin
  Result := Ts0EnumItem(inherited Add);
  if AItemID = -1 then
    AItemID := Result.Index;
  Result.ItemID := AItemID;
  Result.Text := AText;
end;

function Ts0EnumItems.FindByItemID(AItemID: Integer): Ts0EnumItem;
var
  idx: Integer;
begin
  Result := nil;
  idx := IndexOfItemID(AItemID);
  if idx < 0 then Exit;
  Result := Items[idx];
end;

function Ts0EnumItems.FindByText(AText: string): Ts0EnumItem;
var
  idx: Integer;
begin
  Result := nil;
  idx := IndexOfText(AText);
  if idx < 0 then Exit;
  Result := Items[idx];
end;

function Ts0EnumItems.GetItems(const Index: Integer): Ts0EnumItem;
begin
  Result := Ts0EnumItem(inherited Items[Index]);
end;

function Ts0EnumItems.IndexOfItemID(AItemID: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count -1 do
    if Items[i].ItemID = AItemID then
    begin
      Result := i;
      Exit;
    end;
end;

function Ts0EnumItems.IndexOfText(AText: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count -1 do
    if AnsiCompareStr(Items[i].Text, AText) = 0 then
    begin
      Result := i;
      Exit;
    end;
end;

function Ts0EnumItems.ItemIDByText(AText: string): Integer;
var
  itm: Ts0EnumItem;
begin
  Result := -1;
  itm := FindByText(AText);
  if itm = nil then Exit;
  Result := itm.ItemID;
end;

procedure Ts0EnumItems.SetItems(const Index: Integer;
  const Value: Ts0EnumItem);
begin
  inherited Items[Index] := Value;
end;

function Ts0EnumItems.TextByItemID(AItemID: Integer): string;
var
  itm: Ts0EnumItem;
begin
  Result := '';
  itm := FindByItemID(AItemID);
  if itm = nil then Exit;
  Result := itm.Text;
end;

{ Ts0EnumCollection }

constructor Ts0EnumCollection.Create(AOwner: TComponent);
begin
  inherited;
  FItems := NewItems;
  Ts0EnumCollectionBroker.Instance.RegisterEnumCollection(Self);
end;

destructor Ts0EnumCollection.Destroy;
begin
  Ts0EnumCollectionBroker.Instance.UnRegisterEnumCollection(Self);
  FreeAndNil(FItems);
  inherited;
end;

procedure Ts0EnumCollection.DoAfterRefresh;
begin
  if Assigned(FAfterRefresh) then
    FAfterRefresh(Self);
end;

procedure Ts0EnumCollection.DoBeforeRefresh;
begin
  if Assigned(FBeforeRefresh) then
    FBeforeRefresh(Self);
end;

procedure Ts0EnumCollection.DoRefresh;
begin
end;

function Ts0EnumCollection.NewItems: Ts0EnumItems;
begin
  Result := Ts0EnumItems.Create(Self, Ts0EnumItem);
end;

procedure Ts0EnumCollection.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FItems <> nil then
    FItems.Notification(AComponent, Operation);
end;

procedure Ts0EnumCollection.Refresh;
begin
  DoBeforeRefresh;
  DoRefresh;
  DoAfterRefresh;
end;

procedure Ts0EnumCollection.SetEnumName(const Value: string);
begin
  FEnumName := Value;
end;

procedure Ts0EnumCollection.SetItems(const Value: Ts0EnumItems);
begin
  FItems.Assign(Value);
end;

{ Ts0EnumCollectionBroker }

constructor Ts0EnumCollectionBroker.Create;
begin
  inherited Create;
  FItems := TComponentList.Create(False);
end;

destructor Ts0EnumCollectionBroker.Destroy;
begin
  FreeAndNil(FItems);
  inherited;         
end;

function Ts0EnumCollectionBroker.FindByName(
  AEnumName: string): Ts0EnumCollection;
var
  i: Integer;
begin
  for i := 0 to FItems.Count -1 do
  begin
    Result := Ts0EnumCollection(FItems.Items[i]);
    if AnsiCompareText(Result.EnumName, AEnumName) = 0 then Exit;
  end;
  Result := nil;
end;

var
  g9Broker: Ts0EnumCollectionBroker = nil;

class function Ts0EnumCollectionBroker.Instance: Ts0EnumCollectionBroker;
begin
  if g9Broker = nil then
    g9Broker := Ts0EnumCollectionBroker.Create;
  Result := g9Broker;
end;

procedure Ts0EnumCollectionBroker.RegisterEnumCollection(
  AEnumCol: Ts0EnumCollection);
begin
  if FItems.IndexOf(AEnumCol) > -1 then Exit;
  FItems.Add(AEnumCol);
end;

procedure Ts0EnumCollectionBroker.UnRegisterEnumCollection(
  AEnumCol: Ts0EnumCollection);
begin
  while FItems.Remove(AEnumCol) > -1 do ;
end;

initialization

finalization
  FreeAndNil(g9Broker);

end.
