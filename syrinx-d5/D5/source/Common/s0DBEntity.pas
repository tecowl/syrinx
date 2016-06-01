unit s0DBEntity;
{
$History: s0DBEntity.pas $
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/03/14   Time: 4:07
 * Updated in $/D5/source/Common
 * LocateEntityOnListを基底クラスでvirtualに宣言するように変更
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/02/14   Time: 21:54
 * Updated in $/source/D5Integrated
 * Saveメソッドが呼び出されたときに、InsertあるいはUpdateのどちらを行うの
 * かを
 * 判断する基準としてエンティティのIDだけではなく、Resotedにも基づいて行え
 * るようにした。
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/06   Time: 19:53
 * Updated in $/source/D6VCLIntegrated
 * Ts0DBEntityManIteratorで、ａｂｓｔｒａｃｔメソッドをoverrideした
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/01/17   Time: 23:57
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/11/13   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/11/13   Time: 2:28
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/11/12   Time: 14:54
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/10/23   Time: 15:51
 * Updated in $/source/D5Integrated
 * FindEntityOnListメソッドで、DSListがOpenされていなかったらOpenする。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/10/23   Time: 1:20
 * Updated in $/source/D5Integrated
 * FindEntityOnListのフィールド名の取得方法を変更
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/22   Time: 22:37
 * Updated in $/source/D5Integrated
 * FindEntityOnListメソッドを追加
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/09   Time: 9:08
 * Updated in $/source/D5Integrated
 * イベントを追加
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/04   Time: 12:23
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/28   Time: 1:51
 * Updated in $/source/D5Integrated
 * Load、Remove、Saveメソッドをpublicにした
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/21   Time: 17:01
 * Updated in $/source/D5Integrated
 * Ts0PropertyProtoTypesではなく、Ts0EntityPropProtosを使用するように変更
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/16   Time: 23:32
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/06   Time: 21:22
 * Updated in $/source/D5Integrated
 * K0EntityDataSetTypeSetを追加した
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0entity
 * p0entityひとまずOK。
 * しかし、汎用的なフォームのためにリファクタリングを思案中・・・
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/28   Time: 8:22
 * Updated in $/source/D5/p0entity
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/27   Time: 20:04
 * Updated in $/source/D5/p0entity
}

interface

uses
  SysUtils, Classes, DB, //DBTables,
  s0Entity,
  s0Observer,
  s0EntityPool,
  s0PropertyProtoType,
  s0EntityPropProto;

type
  K0EntityDSEvent = procedure(Sender: TObject; ADataSet: TDataSet;
    AEntity: Ts0Entity) of object;

type
  K0EntityNaviDSEvent = procedure(Sender: TObject; ADataSet: TDataSet;
    ANavi: Ts0EntityNavi) of object;

type
  K0EntityDataSetType = (k0edsDetail, k0edsLoadKey, k0edsInsert, k0edsUpdate, k0edsRemove);
  K0EntityDataSetTypeSet = set of K0EntityDataSetType;

type
  K0SavigActionKind = (k0sakNone, k0sakInsert, k0sakUpdate, k0sakDelete);
  K0SavigActionKindSet = set of K0SavigActionKind;

  K0SaveActionEvent = procedure(Sender: TObject; AEntity: Ts0Entity;
    var Action: K0SavigActionKind) of object;  

  K0SavingActionOption = (k0saoByID, k0saoByRestored);

type
  K0DBEtyManOption = (k0dbemoCustomRefreshPool);
  K0DBEtyManOptions = set of K0DBEtyManOption;

type
  Ts0DBEntityManager = class(Ts0EntityManager)
  private
    FDataSets: array[K0EntityDataSetType] of TDataSet;
    FExecEvents: array[K0EntityDataSetType] of K0EntityDSEvent;
    FOnLoadNaviKey: K0EntityNaviDSEvent;
    FAfterRefreshList: TNotifyEvent;
    FBeforeRefreshList: TNotifyEvent;
    FPool: Ts0EntityPool;
    FOptions: K0DBEtyManOptions;
    FOnCustomRefreshPool: TNotifyEvent;
    FBeforeRefreshPool: TNotifyEvent;
    FAfterRefreshPool: TNotifyEvent;
    FOnNeedSavingAction: K0SaveActionEvent;
    FSavingOption: K0SavingActionOption;
    function GetDataSets(const Index: Integer): TDataSet;
    function GetExecEvent(const Index: Integer): K0EntityDSEvent;
    function GetTypeByDSIndex(Index: Integer): K0EntityDataSetType;
    function GetTypeByEEIndex(Index: Integer): K0EntityDataSetType;
    procedure SetDataSets(const Index: Integer; const Value: TDataSet);
    procedure SetExecEvent(const Index: Integer;
      const Value: K0EntityDSEvent);
    procedure SetPool(const Value: Ts0EntityPool);
    procedure SetOptions(const Value: K0DBEtyManOptions);
    procedure SetSavingOption(const Value: K0SavingActionOption);
  protected
    procedure DoAfterRefreshList;
    procedure DoBeforeRefreshList;
    procedure DoAfterRefreshPool;
    procedure DoBeforeRefreshPool;
    procedure DoExecEvent(AType: K0EntityDataSetType; ADataSet: TDataSet;
      AEntity: Ts0Entity);
    procedure DoCustomRefreshPool;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    function DecideSavingAction(AEntity: Ts0Entity): K0SavigActionKind;
    procedure DoNeedSavingAction(AEntity: Ts0Entity; var Action: K0SavigActionKind);
  public
    procedure Insert(AEntity: Ts0Entity); override;
    procedure Load(AEntity: Ts0Entity); override;
    procedure Remove(AEntity: Ts0Entity); override;
    procedure Save(AEntity: Ts0Entity); override;
    procedure Update(AEntity: Ts0Entity); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshPool;
    function FindEntity(AID: Integer): Ts0Entity; override;
    function FindEntityOnPool(AEntityID: Integer): Ts0Entity; virtual;
    procedure LoadKeyFromList(AEntity: Ts0Entity); override;
    procedure LoadNaviKeyFromList(ANavi: Ts0EntityNavi); override;
    function LocateEntityOnList(AEntityID: Integer;
      AOption: K0NotFoundOnListOption{ = k0leoNone}): Boolean; override;
    function NewIterator: Ts0EntityIterator; override;
    procedure PrepareList; override;
    procedure UnPrepareList; override;
    procedure RefreshList; override;
  published
    property Options: K0DBEtyManOptions read FOptions write SetOptions default [];
    property SavingOption: K0SavingActionOption read FSavingOption write SetSavingOption default k0saoByID;
    property Pool: Ts0EntityPool read FPool write SetPool;
    property DSDetail: TDataSet index 0 read GetDataSets write SetDataSets;
    property DSList  : TDataSet index 1 read GetDataSets write SetDataSets;
    property DSInsert: TDataSet index 2 read GetDataSets write SetDataSets;
    property DSUpdate: TDataSet index 3 read GetDataSets write SetDataSets;
    property DSRemove: TDataSet index 4 read GetDataSets write SetDataSets;
    property AfterRefreshList : TNotifyEvent read FAfterRefreshList  write FAfterRefreshList ;
    property BeforeRefreshList: TNotifyEvent read FBeforeRefreshList write FBeforeRefreshList;
    property AfterRefreshPool : TNotifyEvent read FAfterRefreshPool  write FAfterRefreshPool ;
    property BeforeRefreshPool: TNotifyEvent read FBeforeRefreshPool write FBeforeRefreshPool;
    property OnExecDetail: K0EntityDSEvent index 10 read GetExecEvent write SetExecEvent;
    property OnLoadKey   : K0EntityDSEvent index 11 read GetExecEvent write SetExecEvent;
    property OnExecInsert: K0EntityDSEvent index 12 read GetExecEvent write SetExecEvent;
    property OnExecUpdate: K0EntityDSEvent index 13 read GetExecEvent write SetExecEvent;
    property OnExecRemove: K0EntityDSEvent index 14 read GetExecEvent write SetExecEvent;
    property OnLoadNaviKey: K0EntityNaviDSEvent read FOnLoadNaviKey write FOnLoadNaviKey;
    property OnCustomRefreshPool: TNotifyEvent read FOnCustomRefreshPool write FOnCustomRefreshPool;
    property OnNeedSavingAction: K0SaveActionEvent read FOnNeedSavingAction write FOnNeedSavingAction;
 end;

type
  Ts0DBEntityManIterator = class(Ts0EntityIterator)
  private
    FManager: Ts0DBEntityManager;
    FDSList: TDataSet;
    FListener: Ts0EventListener;
  protected
    function ValidateDSList: Boolean;
    procedure ManagerDestroy(Sender: TObject);
  public
    constructor Create(AManager: Ts0DBEntityManager); reintroduce;
    destructor Destroy; override;
    procedure AssignCurrent(Dest: Ts0Entity); override;
    procedure First; override;
    procedure GotoEnd; override;
    procedure Last;  override;
    procedure Next; override;
    procedure Prior; override;
    function IsEnd: Boolean; override;
    function IsFirst: Boolean; override;
    function IsLast: Boolean; override;
    function HasNext: Boolean; override;
    function HasPrior: Boolean; override;
  end;


type
  Es0NaviTableCreatorException = class(Exception);

implementation

{ Ts0DBEntityManager }

constructor Ts0DBEntityManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [];
  FSavingOption := k0saoByID;
end;

function Ts0DBEntityManager.DecideSavingAction(
  AEntity: Ts0Entity): K0SavigActionKind;
begin
  Result := k0sakNone;
  case Self.SavingOption of
    k0saoByID:
      if AEntity.ID < 1 then
        Result := k0sakInsert
      else
        Result := k0sakUpdate;
    k0saoByRestored:
      if AEntity.Restored then
        Result := k0sakUpdate
      else
        Result := k0sakInsert;
  end;
  DoNeedSavingAction(AEntity, Result);
end;

destructor Ts0DBEntityManager.Destroy;
begin
  inherited Destroy;              
end;

procedure Ts0DBEntityManager.DoAfterRefreshList;
begin
  if Assigned(FAfterRefreshList) then
    FAfterRefreshList(Self)
end;

procedure Ts0DBEntityManager.DoAfterRefreshPool;
begin
  if Assigned(FAfterRefreshPool) then
    FAfterRefreshPool(Self);
end;

procedure Ts0DBEntityManager.DoBeforeRefreshList;
begin
  if Assigned(FBeforeRefreshList) then
    FBeforeRefreshList(Self)
end;

procedure Ts0DBEntityManager.DoBeforeRefreshPool;
begin
  if Assigned(FBeforeRefreshPool) then
    FBeforeRefreshPool(Self);
end;

procedure Ts0DBEntityManager.DoCustomRefreshPool;
begin
  if Assigned(FOnCustomRefreshPool) then
    FOnCustomRefreshPool(Self);
end;

procedure Ts0DBEntityManager.DoExecEvent(AType: K0EntityDataSetType;
  ADataSet: TDataSet; AEntity: Ts0Entity);
begin
  if Assigned(FExecEvents[AType]) then
    FExecEvents[AType](Self, ADataSet , AEntity);
end;

procedure Ts0DBEntityManager.DoNeedSavingAction(AEntity: Ts0Entity;
  var Action: K0SavigActionKind);
begin
  if Assigned(FOnNeedSavingAction) then
    FOnNeedSavingAction(Self, AEntity, Action);
end;

function Ts0DBEntityManager.FindEntity(AID: Integer): Ts0Entity;
begin
  Result := Self.FindEntityOnPool(AID);
end;

function Ts0DBEntityManager.FindEntityOnPool(AEntityID: Integer): Ts0Entity;
begin
  Result := nil;
  if FPool = nil then Exit;
  Result := FPool.FindByID(AEntityID);
end;

function Ts0DBEntityManager.GetDataSets(const Index: Integer): TDataSet;
begin
  Result := FDataSets[ GetTypeByDSIndex(Index) ];
end;

function Ts0DBEntityManager.GetExecEvent(
  const Index: Integer): K0EntityDSEvent;
begin
  Result := FExecEvents[ GetTypeByEEIndex(Index) ];
end;

function Ts0DBEntityManager.GetTypeByDSIndex(
  Index: Integer): K0EntityDataSetType;
const
  c9TypeArray: array[0..4] of K0EntityDataSetType = (
    k0edsDetail, k0edsLoadKey, k0edsInsert, k0edsUpdate, k0edsRemove
  );
begin
  Result := c9TypeArray[Index];
end;

function Ts0DBEntityManager.GetTypeByEEIndex(
  Index: Integer): K0EntityDataSetType;
begin
  Result := GetTypeByDSIndex(Index - 10);
end;

procedure Ts0DBEntityManager.Insert(AEntity: Ts0Entity);
begin
  DoExecEvent(k0edsInsert, DSInsert, AEntity);
end;

procedure Ts0DBEntityManager.Load(AEntity: Ts0Entity);
  function GetEntityFromPool(AID: Integer): Ts0Entity;
  begin
    Result := nil;
    if FPool = nil then Exit;
    Result := FPool.FindByID(AID);
  end;
var
  ety: Ts0Entity;
begin
  if AEntity.Owner is Ts0EntityPool then
  begin
    DoExecEvent(k0edsDetail, DSDetail, AEntity);
  end
  else
  begin
    ety := GetEntityFromPool(AEntity.ID);
    if ety = nil then
      DoExecEvent(k0edsDetail, DSDetail, AEntity)
    else
      AEntity.Assign(ety);
  end;
end;

procedure Ts0DBEntityManager.Loaded;
begin
  inherited;
end;

procedure Ts0DBEntityManager.LoadKeyFromList(AEntity: Ts0Entity);
begin
  DoExecEvent(k0edsLoadKey, DSList, AEntity);
end;

procedure Ts0DBEntityManager.LoadNaviKeyFromList(ANavi: Ts0EntityNavi);
begin
  if Assigned(FOnLoadNaviKey) then
    FOnLoadNaviKey(Self, DSList, ANavi);
end;

function Ts0DBEntityManager.LocateEntityOnList(AEntityID: Integer;
  AOption: K0NotFoundOnListOption): Boolean;
var
  fld: TField;
begin
  Result := False;
  if DSList = nil  then Exit;
  if ProtoTypes.IDProp = nil then Exit;
  //
  fld := DSList.FindField(ProtoTypes.IDProp.PropertyName);
  if fld = nil then
    fld := DSList.FindField(ProtoTypes.IDProp.FieldName);
  //
  if fld = nil then Exit;
  if not DSList.Active then
    DSList.Open;
  Result := DSList.Locate(fld.FieldName, AEntityID, []);
  case AOption of
    k0leoNone : ;
    k0leoFirst: DSList.First;
    k0leoLast : DSList.Last;
  end;
end;

function Ts0DBEntityManager.NewIterator: Ts0EntityIterator;
begin
  Result := Ts0DBEntityManIterator.Create(Self);
end;

procedure Ts0DBEntityManager.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: K0EntityDataSetType;
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FPool = AComponent then
    FPool := nil;
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    if FDataSets[i] = AComponent then
      FDataSets[i] := nil;
end;

procedure Ts0DBEntityManager.PrepareList;
begin
  if not DSList.Active then
    DSList.Open;
end;

procedure Ts0DBEntityManager.RefreshList;
begin
  DoBeforeRefreshList;
  if DSList <> nil then
  begin
    DSList.Close;
    DSList.Open;
  end;
  DoAfterRefreshList;
end;

procedure Ts0DBEntityManager.RefreshPool;
var
  ety: Ts0Entity;
  buf: Boolean;
begin
  DoBeforeRefreshPool;
  if k0dbemoCustomRefreshPool in Options then
  begin
    DoCustomRefreshPool;
    Exit;
  end;
  //
  if Pool = nil then Exit;
  if DSList = nil then Exit;
  buf := DSList.Active;
  DSList.Active := True;
  try
    ety := Self.NewEntity(nil);
    try
      DSList.First;
      while not DSList.Eof do
      begin
        ety.LoadKey;
        ety.Load;
        Pool.AddClone(ety);
        DSList.Next;
      end;
    finally
      FreeAndNil(ety);
    end;
  finally
    DSList.Active := buf;
  end;
  DoAfterRefreshPool;
end;

procedure Ts0DBEntityManager.Remove(AEntity: Ts0Entity);
begin
  DoExecEvent(k0edsRemove, DSRemove, AEntity);
end;

procedure Ts0DBEntityManager.Save(AEntity: Ts0Entity);
begin
  if AEntity = nil then Exit;
  case DecideSavingAction(AEntity) of
    k0sakNone  : ;
    k0sakInsert: Insert(AEntity);
    k0sakUpdate: Update(AEntity);
    k0sakDelete: Remove(AEntity);
  end;
end;

procedure Ts0DBEntityManager.SetDataSets(const Index: Integer;
  const Value: TDataSet);
begin
  FDataSets[ GetTypeByDSIndex(Index) ] := Value;
end;

procedure Ts0DBEntityManager.SetExecEvent(const Index: Integer;
  const Value: K0EntityDSEvent);
begin
  FExecEvents[ GetTypeByEEIndex(Index) ] := Value;
end;

procedure Ts0DBEntityManager.SetOptions(const Value: K0DBEtyManOptions);
begin
  FOptions := Value;
end;

procedure Ts0DBEntityManager.SetPool(const Value: Ts0EntityPool);
begin
  if FPool <> nil then
    if FPool.Manager = Self then
      FPool.Manager := nil;
  FPool := Value;
  if FPool <> nil then
    if FPool.Manager <> Self then
      FPool.Manager := Self;
end;

procedure Ts0DBEntityManager.SetSavingOption(
  const Value: K0SavingActionOption);
begin
  FSavingOption := Value;
end;

procedure Ts0DBEntityManager.UnPrepareList;
begin
  if DSList.Active then
    DSList.Close;
end;

procedure Ts0DBEntityManager.Update(AEntity: Ts0Entity);
begin
  DoExecEvent(k0edsUpdate, DSUpdate, AEntity);
end;

{ Ts0DBEntityManIterator }

procedure Ts0DBEntityManIterator.AssignCurrent(Dest: Ts0Entity);
begin
  Dest.LoadKey;
  Dest.Load;
end;

constructor Ts0DBEntityManIterator.Create(AManager: Ts0DBEntityManager);
begin
  inherited Create(AManager);
  FManager := AManager;
  FListener := Ts0EventListener.Create(ManagerDestroy);
  if FManager = nil then
    FDSList := nil
  else
  begin
    FDSList := FManager.DSList;
    FManager.OnDestroy.Attach(FListener);
  end;
end;

destructor Ts0DBEntityManIterator.Destroy;
begin
  FreeAndNil(FListener);
  inherited;
end;

procedure Ts0DBEntityManIterator.First;
begin
  if not ValidateDSList then Exit;
  FDSList.First;
end;

procedure Ts0DBEntityManIterator.GotoEnd;
begin
  if not ValidateDSList then Exit;
  FDSList.Last;
end;

function Ts0DBEntityManIterator.HasNext: Boolean;
begin
  Result := False;
  if not ValidateDSList then Exit;
  Result := not FDSList.Eof;
end;

function Ts0DBEntityManIterator.HasPrior: Boolean;
begin
  Result := False;
  if not ValidateDSList then Exit;
  Result := not FDSList.Bof;
end;

function Ts0DBEntityManIterator.IsEnd: Boolean;
begin
  Result := False;
  if not ValidateDSList then Exit;
  Result := FDSList.Eof;
end;

function Ts0DBEntityManIterator.IsFirst: Boolean;
begin
  Result := False;
  if not ValidateDSList then Exit;
  Result := FDSList.Bof;
end;

function Ts0DBEntityManIterator.IsLast: Boolean;
begin
  Result := False;
  if not ValidateDSList then Exit;
  Result := FDSList.Eof;
end;

procedure Ts0DBEntityManIterator.Last;
begin
  if not ValidateDSList then Exit;
  FDSList.Last;
end;

procedure Ts0DBEntityManIterator.ManagerDestroy(Sender: TObject);
begin
  FManager := nil;
  FDSList := nil;
end;

procedure Ts0DBEntityManIterator.Next;
begin
  if not ValidateDSList then Exit;
  FDSList.Next;
end;

procedure Ts0DBEntityManIterator.Prior;
begin
  if not ValidateDSList then Exit;
  FDSList.Prior;
end;

function Ts0DBEntityManIterator.ValidateDSList: Boolean;
begin
  Result := False;
  if FDSList = nil then Exit;
  Result := True;
end;

end.

