{-----------------------------------------------------------------------------
 Unit Name: s0EntityPool
 Author:    akima
 Purpose:
 History:
-----------------------------------------------------------------------------}
{
$History: s0EntityPool.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/14   Time: 21:52
 * Updated in $/source/D5Integrated
 * ClearAndFreeItemsメソッドを追加
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/05   Time: 18:59
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated
}

unit s0EntityPool;

interface

uses
  SysUtils, Classes,
  Contnrs,
  s0Entity;

type
  Ts0EntityPool = class(TComponent)
  private
    FItemList: Ts0EntityList;
    FManager: Ts0EntityManager;
    FEntityClass: Ts0EntityClass;
    function GetItemCount: Integer;
    function GetItems(const Index: Integer): Ts0Entity;
    procedure SetManager(const Value: Ts0EntityManager);
    function GetEntityClass: Ts0EntityClass;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Add(AEntity: Ts0Entity): Integer;
    function AddClone(AEntity: Ts0Entity): Ts0Entity;
    procedure Clear;
    procedure ClearAndFreeItems;
    procedure Delete(Index: Integer);
    function FindByID(AID: Integer): Ts0Entity;
    procedure GetItemList(Dest: Ts0EntityList);
    function IndexOf(AEntity: Ts0Entity): Integer;
    function Remove(AEntity: Ts0Entity): Integer;
    property EntityClass: Ts0EntityClass read GetEntityClass;
    property Items[const Index: Integer]: Ts0Entity read GetItems;
    property ItemCount: Integer read GetItemCount;
  published
    property Manager: Ts0EntityManager read FManager write SetManager;
  end;

implementation

{ Ts0EntityPool }

function Ts0EntityPool.Add(AEntity: Ts0Entity): Integer;
begin
  Result := IndexOf(AEntity);
  if Result > -1 then Exit;
  Result := FItemList.Add(AEntity);
end;

function Ts0EntityPool.AddClone(AEntity: Ts0Entity): Ts0Entity;
begin
  Result := FindByID(AEntity.ID);
  if Result <> nil then
    Result.Assign(AEntity)
  else
  begin
    Result := AEntity.Clone(Self);
    FItemList.Add(Result);
  end;
end;

procedure Ts0EntityPool.Clear;
begin
  FItemList.Clear;
end;

procedure Ts0EntityPool.ClearAndFreeItems;
begin
  FItemList.OwnsObjects := True;
  try
    FItemList.Clear;
  finally
    FItemList.OwnsObjects := False;
  end;
end;

constructor Ts0EntityPool.Create(AOwner: TComponent);
begin
  inherited;
  FItemList := Ts0EntityList.Create(False);
end;

procedure Ts0EntityPool.Delete(Index: Integer);
begin
  FItemList.Delete(Index);
end;

destructor Ts0EntityPool.Destroy;
begin
  FreeAndNil(FItemList);
  inherited;
end;

function Ts0EntityPool.FindByID(AID: Integer): Ts0Entity;
var
  i: Integer;
begin
  for i := 0 to FItemList.Count -1 do
  begin
    Result := Items[i];
    if Result.ID = AID then Exit;
  end;
  Result := nil;
end;

function Ts0EntityPool.GetEntityClass: Ts0EntityClass;
begin
  if FEntityClass = nil then
    if FManager <> nil then
      FEntityClass := FManager.EntityClass;
  Result := FEntityClass;
end;

function Ts0EntityPool.GetItemCount: Integer;
begin
  Result := FItemList.Count;
end;

procedure Ts0EntityPool.GetItemList(Dest: Ts0EntityList);
var
  i: Integer;
begin
  Dest.Clear;
  Dest.OwnsObjects := False;
  for i := 0 to Self.ItemCount -1 do
    Dest.Add( Items[i] );
end;

function Ts0EntityPool.GetItems(const Index: Integer): Ts0Entity;
begin
  Result := Ts0Entity( FItemList.Items[Index] );
end;

function Ts0EntityPool.IndexOf(AEntity: Ts0Entity): Integer;
begin
  Result := FItemList.IndexOf(AEntity);
end;

procedure Ts0EntityPool.Loaded;
begin
  inherited;
  if csDesigning in Self.ComponentState then Exit;
end;

procedure Ts0EntityPool.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FManager = AComponent then
    FManager := nil;
{
  if AComponent is Ts0Entity then
  begin
    if FItemList <> nil then
      while FItemList.Remove(Ts0Entity(AComponent)) > -1 do ;
  end;
}
end;

function Ts0EntityPool.Remove(AEntity: Ts0Entity): Integer;
begin
  repeat
    Result := FItemList.Remove(AEntity);
  until Result < 0;
end;

procedure Ts0EntityPool.SetManager(const Value: Ts0EntityManager);
begin
  FManager := Value;
end;

end.
