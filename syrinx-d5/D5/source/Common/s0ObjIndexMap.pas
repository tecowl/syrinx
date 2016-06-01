unit s0ObjIndexMap;
{
$History: s0ObjIndexMap.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes;

type

  Ts0ObjIndexMapItem = class(TObject)
  private
    FMappedItemList: TList;
    FMappedOwner: TObject;
  public
    constructor Create(AMappedOwner: TObject); virtual;
    destructor Destroy; override;
    property MapList: TList read FMappedItemList;
    property MappedOwner: TObject read FMappedOwner;
  end;

  Ts0ObjIndexMap = class(TObject)
  private
    FObjIndexMapItem: Ts0ObjIndexMapItem;
    FItems: TList;
    function GetItems(Index: Integer): Ts0ObjIndexMapItem;
    function GetItemCount: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function RegisterItem(AOwner, AItem: TObject): Integer; virtual;
    function UnRegisterItem(AOwner, AItem: TObject): Integer; virtual;
    procedure MoveItem(AOwner, AItem: TObject; ANewIndex: Integer); virtual;
    function Remove(AOwner: TObject): Integer; virtual;
    function IndexOf(AOwner: TObject): Integer; virtual;
    property Items[Index: Integer]: Ts0ObjIndexMapItem read GetItems;
    property ItemCount: Integer read GetItemCount;
  end;

implementation

{ Ts0ObjIndexMapItem }

constructor Ts0ObjIndexMapItem.Create(AMappedOwner: TObject);
begin
  FMappedItemList := TList.Create;
  FMappedOwner := AMappedOwner;
end;

destructor Ts0ObjIndexMapItem.Destroy;
begin
  FreeAndNil(FMappedItemList);
  inherited;
end;

{ Ts0ObjIndexMap }

constructor Ts0ObjIndexMap.Create;
begin
  FItems := TList.Create;
end;

destructor Ts0ObjIndexMap.Destroy;
var
  i: Integer;
begin
  for i := FItems.Count -1 downto 0 do
  begin
    Ts0ObjIndexMapItem(FItems.Items[i]).Free;
    FItems.Items[i] := nil;
  end;
  FreeAndNil(FItems);
  inherited;
end;

function Ts0ObjIndexMap.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function Ts0ObjIndexMap.GetItems(Index: Integer): Ts0ObjIndexMapItem;
begin
  Result := Ts0ObjIndexMapItem(FItems.Items[Index]);
end;

function Ts0ObjIndexMap.IndexOf(AOwner: TObject): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FItems.Count -1 do
    if Ts0ObjIndexMapItem(FItems.Items[i]).MappedOwner = AOwner then
      Result := i;
end;

procedure Ts0ObjIndexMap.MoveItem(AOwner, AItem: TObject; ANewIndex: Integer);
var
  Index, curIndex: Integer;
begin
  Index := Self.IndexOf(AOwner);
  if Index <> -1 then
  begin
    curIndex := Items[Index].MapList.IndexOf(AItem);
    if curIndex <> -1 then
      Items[Index].MapList.Move(curIndex, ANewIndex);
  end;
end;

function Ts0ObjIndexMap.RegisterItem(AOwner, AItem: TObject): Integer;
begin
  Result :=Self.IndexOf(AOwner);
  if Result <> -1 then
  begin
    if Items[Result].MapList.IndexOf(AItem) = -1 then
      Items[Result].MapList.Add(AItem)
  end else
  begin
    FObjIndexMapItem := Ts0ObjIndexMapItem.Create(AOwner);
    Items[FItems.Add(FObjIndexMapItem)].MapList.Add(AItem);
  end;
end;

function Ts0ObjIndexMap.Remove(AOwner: TObject): Integer;
begin
  Result :=Self.IndexOf(AOwner);
  if Result <> -1 then
  begin
    Ts0ObjIndexMapItem(FItems.Items[Result]).Free;
    FItems.Items[Result] := nil;
    FItems.Delete(Result);
  end;
end;

function Ts0ObjIndexMap.UnRegisterItem(AOwner, AItem: TObject): Integer;
begin
  Result :=Self.IndexOf(AOwner);
  if Result <> -1 then
    if Items[Result].MapList.IndexOf(AItem) <> -1 then
      Items[Result].MapList.Remove(AItem);
end;

end.
