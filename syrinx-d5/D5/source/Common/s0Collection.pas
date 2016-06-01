unit s0Collection;
{
$History: s0Collection.pas $
 * 
 * *****************  Version 31  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 29  *****************
 * User: Akima        Date: 02/03/30   Time: 14:02
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/02/21   Time: 23:22
 * Updated in $/source/D5Integrated
 * Ts0CollectionにInsertメソッドを追加。
 * Ts0CollectionItemFinderのSubItemFirstプロパティを廃止。
 * 代わりにTimingOfSubFindプロパティを追加。
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 01/12/05   Time: 18:59
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemにGetOwnerObjメソッドを追加
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 01/11/21   Time: 20:55
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/11/12   Time: 21:42
 * Updated in $/source/D5Integrated
 * Updateメソッドをちょっと修正
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/11/02   Time: 14:17
 * Updated in $/source/D5Integrated
 * PropNameプロパティをpublicに。
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/10/21   Time: 15:28
 * Updated in $/source/D5Integrated
 * K0CollectionItemEventの引数の型を変更。
 * Itemが破棄されるときに、親のCollectionに通知する仕組みと、
 * それをさらにCollectionの外に通知するイベントを追加。
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/10/03   Time: 23:43
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemListにFindByIdentifierメソッドを追加。
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/09/27   Time: 9:17
 * Updated in $/source/D5Integrated
 * Ts0Collection.Updateを変更
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/09/21   Time: 15:28
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/09/20   Time: 18:35
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemFinder.Executeメソッドをvirtualに変更
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/09/20   Time: 0:07
 * Updated in $/source/D5Integrated
 * AssignByICメソッドを廃止。
 * 代わりにItemClassをベースにしたAssignを行う場合はCloneAssignをFalseに
 * 設定するという仕様に変更した。
 * CloneAssignはデフォルトTrue
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/09/19   Time: 20:47
 * Updated in $/source/D5Integrated
 * AssignByICメソッドを追加
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/09/13   Time: 23:32
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/09/12   Time: 2:13
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/11   Time: 0:26
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/10   Time: 19:46
 * Updated in $/source/D5Integrated
 * OwnerItemプロパティを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/02   Time: 1:38
 * Updated in $/source/D5/p0core
 * エンティティのジェネレータ関係がひとまずできた！
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/31   Time: 2:05
 * Updated in $/source/D5/p0core
 * Assignメソッドの実装を、inheritedするのではなく、Cloneメソッドを使って
 * 、
 * ちゃんと深いコピーを行うように変更
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0core
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0core
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/07/30   Time: 10:25
 * Updated in $/source/p0common
 * Ts0CollectionClassを定義、
 * 少しメソッドを追加。
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:28
 * Created in $/Projects/SDRFrameWork/src/lib0
 * 新規追加
 * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
 * VSSでは共有してません。
}

interface

uses
  SysUtils, Classes, Contnrs,
  s0Exception,
  s0Iterator,
  s0Observer;

type
  Ts0CollectionVisitor = class;
  Ts0CollectionClass = class of Ts0Collection;
  Ts0Collection = class;

  {
    Ts0CollectionとTs0CollectionItem

    TCollectionやTCollectionItemと違っている点
    ・Notificationメソッドを実装。
      Notificationメソッドは、他のコンポーネントの生成、破棄時に呼び出される
      メソッドで、主に参照しているコンポーネントが破棄された場合に、参照を
      クリアするために使用される。

      本フレームワークでは、Ts0CollectionItemの派生クラスで何らかのコンポーネント
      への参照を保持する場合があるので、それらのコンポーネントの破棄を
      通知するためにNotificationメソッドをoverrideしている。

    ・OwnerComponentメソッド。
      Ts0CollectionItemやTs0Collectionに集約され、Ts0Collectionは通常、何らかの
      コンポーネントに集約される。集約元のコンポーネントを、ネストした先の
      Ts0CollectionItemからでも参照したい場合に使用する。

    ・Cloneメソッド
      自身と同じクラスのインスタンスを生成し、内容をAssignする。
      このメソッドを使用するために、GetClassTypeメソッドを実装していると
      言っても過言ではない。

    ・VISITORパターンの実装。
      もう、これがあるのとないのとではぜんぜん違う！

    ・OnUpdateイベント
      TCollection.UpdateメソッドをoverrideしてTs0Eventを発生する。
  }
  Ts0CollectionItemClass = class of Ts0CollectionItem;
  Ts0CollectionItem = class(TCollectionItem)
  private
    FOnDestroy: Ts0Event;
    function GetOnDestroy: Ts0Event;
    function GetOwnerItem: Ts0CollectionItem;
    function GetOwnerObj: TPersistent;
  protected
    function GetCollectionAs0Level: Ts0Collection;
    function GetOwnerComponent: TComponent; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      virtual;
    function NewSubCollection: Ts0Collection; virtual;
    function GetSubCollection: Ts0Collection; virtual;
    function GetSubCollectionClass: Ts0CollectionClass; virtual;
    {
      GetFullName
      Ts0CollectionItemがTs0Collectionを集約し、ネストした構造を作りうる場合、
      その中のあるTs0CollectionItemを一意に決定する文字列。
      親のTs0CollectionItemのFullNameプロパティに自身のGetIdentifierメソッドを
      デリミタ付きで加えたもの。

      GetIdentifier
      識別子を取得するメソッド。

      GetFullNameDelimiter
      GetFullNameで使用するIdentifierとIdentifierを区切る文字。
    }
    function GetFullName: string; virtual;
    function GetIdentifier: string; virtual;
    class function GetFullNameDelimiter: Char; virtual;
  public
    {
      Notes:
      constructor Create(ACollection: TCollection); reintroduce; virtual;
      って宣言したいところだけど、絶対絶対絶対絶対絶対絶対絶対絶対絶対だめー！
      だってそうしたら、IDEがインスタンスを生成したときにその宣言した
      コンストラクタが呼び出されないんだもん。
      当たり前と言えば当たり前だけど、これで3時間も無駄にしました。トホホ。
    }
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Accept(v: Ts0CollectionVisitor); virtual;
    function Equals(AItem: Ts0CollectionItem): Boolean; virtual;
    function GetClassType: Ts0CollectionItemClass;
    function Clone: Ts0CollectionItem; virtual;
    property CollectionAs0Level: Ts0Collection read GetCollectionAs0Level;
    property Identifier: string read GetIdentifier;
    property FullName: string read GetFullName;
    property OwnerComponent: TComponent read GetOwnerComponent;
    property OwnerObj: TPersistent read GetOwnerObj;
    property OwnerItem: Ts0CollectionItem read GetOwnerItem;
    property SubCollection: Ts0Collection read GetSubCollection;
    property OnDestroy: Ts0Event read GetOnDestroy;
  end;

  K0CollectionItemEvent = procedure(Sender: TObject; Item: Ts0CollectionItem) of
    object;

  Ts0CollectionItemEvent = class(Ts0Event)
  private
    FItem: Ts0CollectionItem;
  public
    constructor Create(ASender: TObject); override;
    property Item: Ts0CollectionItem read FItem;
  end;

  Ts0CollectionItemEventListener = class(Ts0EventListener)
  private
    FOnEvent: K0CollectionItemEvent;
  published
    constructor Create(AHandler: K0CollectionItemEvent); reintroduce; virtual;
    procedure Update(ASubj: Ts0Subject); override;
    property OnEvent: K0CollectionItemEvent read FOnEvent;
  end;

  Ts0Collection = class(TOwnedCollection)
  private
    FOnUpdate: Ts0CollectionItemEvent;
    FCloneAssign: Boolean;
    FOnItemDestroy: K0CollectionItemEvent;
    function GetItem(Index: Integer): Ts0CollectionItem;
    procedure SetItem(Index: Integer; const Value: Ts0CollectionItem);
    function GetOnUpdate: Ts0CollectionItemEvent;
    function GetOwnerObj: TPersistent;
    function GetItemClass: Ts0CollectionItemClass;
  protected
    procedure DoItemDestroy(AItem: Ts0CollectionItem); 
    function GetOwnerComponent: TComponent; virtual;
    procedure NotifyItemDestroy(AItem: Ts0CollectionItem); virtual;
    procedure Update(Item: TCollectionItem); override;
  public
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      virtual;
  public
    constructor Create(AOwner: TPersistent; AItemClass: Ts0CollectionItemClass);
      reintroduce; virtual;
    destructor Destroy; override;
    function Add: Ts0CollectionItem;
    procedure Assign(Source: TPersistent); override;
    procedure Accept(v: Ts0CollectionVisitor); virtual;
    function Equals(ACollection: Ts0Collection): Boolean; virtual;
    function FindByIdentifier(AIdentifier: string): Ts0CollectionItem;
    function GetClassType: Ts0CollectionClass;
    function Clone(AOwner: TPersistent): Ts0Collection;
    function IndexOf(AItem: Ts0CollectionItem): Integer; virtual;
    function Insert(Index: Integer): Ts0CollectionItem;
    procedure Remove(AItem: Ts0CollectionItem); virtual;
    property Items[Index: Integer]: Ts0CollectionItem read GetItem write SetItem;
    property CloneAssign: Boolean read FCloneAssign write FCloneAssign default True;
    property OwnerObj: TPersistent read GetOwnerObj;
    property OwnerComponent: TComponent read GetOwnerComponent;
    property PropName;
    property OnUpdate: Ts0CollectionItemEvent read GetOnUpdate;
    property OnItemDestroy: K0CollectionItemEvent read FOnItemDestroy write FOnItemDestroy;
  public
    { Is0Aggregate }
    function Iterator: Is0ObjIterator; virtual;
  end;

  Ts0CollectionVisitor = class
  protected
    procedure VisitCollection(ACollection: Ts0Collection); virtual;
    procedure VisitItem(AItem: Ts0CollectionItem); virtual;
  end;

type
  Es0CollectionException = class(Exception);

type
  Ts0CollectionItemList = class(TObjectList)
  private
  protected
    function GetItems(Index: Integer): Ts0CollectionItem;
    procedure SetItems(Index: Integer; AItem: Ts0CollectionItem);
  public
    function Add(AItem: Ts0CollectionItem): Integer;
    function Remove(AItem: Ts0CollectionItem): Integer;
    function IndexOf(AItem: Ts0CollectionItem): Integer;
    procedure Insert(Index: Integer; AItem: Ts0CollectionItem);
    property Items[Index: Integer]: Ts0CollectionItem read GetItems write SetItems; default;
    function First: Ts0CollectionItem;
    function Last: Ts0CollectionItem;
    function FindByIdentifier(AIdentifier: String): Ts0CollectionItem;
  public
    procedure SortByIdentifier;
  end;

type
  K0FindSubItemKind = (k0fsikNone, k0fsikBeforeMatch, k0fsikAfterMatch);
  K0FindSubItemKinds = set of K0FindSubItemKind;

type
  Ts0CollectionItemFinder = class(Ts0CollectionVisitor)
  private
    FResultList: Ts0CollectionItemList;
    FTarget: Ts0Collection;
    FAnswerOnlyOne: Boolean;
    FTimingOfSubFind: K0FindSubItemKind;
  protected
    procedure VisitCollection(ACollection: Ts0Collection); override;
    procedure VisitItem(AItem: Ts0CollectionItem); override;
    function Match(AItem: Ts0CollectionItem): Boolean; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property AnswerOnlyOne: Boolean read FAnswerOnlyOne write FAnswerOnlyOne;
    procedure Execute; virtual;
    property Target: Ts0Collection read FTarget write FTarget;
    property ResultList: Ts0CollectionItemList read FResultList;
    property TimingOfSubFind: K0FindSubItemKind read FTimingOfSubFind write FTimingOfSubFind default k0fsikAfterMatch; 
  end;

type
  Ts0ItemFinderByName = class(Ts0CollectionItemFinder)
  private
    FSearchByFullName: Boolean;
    FName: string;
  protected
    function Match(AItem: Ts0CollectionItem): Boolean; override;
  public
    property SearchByFullName: Boolean read FSearchByFullName write FSearchByFullName;
    property Name: string read FName write FName;
  end;

type
  Ts0InterfacedCollectionItem = class(Ts0CollectionItem, IUnknown)
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

type
  Ts0InterfacedCollection = class(Ts0Collection, IUnknown, Is0Aggregate)
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

type
  Es0CollectionError = class(Es0ProgExcept);
  Es0CollectionItemError = class(Es0ProgExcept);

type
  Es0InvalidPointer = class(Exception);

resourcestring
  c0ErrMsg_IllegalOwnerClass = 'Illegal Owner Class.';
  c0ErrMsg_IllegalClass = 'Illegal Collection Class.';
  c0ErrMsg_IllegalItemClass = 'Illegal Collection Item Class.';

implementation

uses
  s0Classes,
  s0Persistent;

{ Ts0CollectionItem }

procedure Ts0CollectionItem.Accept(v: Ts0CollectionVisitor);
begin
  v.VisitItem(Self);
end;

procedure Ts0CollectionItem.Assign(Source: TPersistent);
begin
end;

function Ts0CollectionItem.Clone: Ts0CollectionItem;
begin
  Result := Self.GetClassType.Create(nil);
  Result.Assign(Self);
end;

constructor Ts0CollectionItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
end;

destructor Ts0CollectionItem.Destroy;
begin
  if GetCollectionAs0Level <> nil then
    GetCollectionAs0Level.NotifyItemDestroy(Self);
  if FOnDestroy <> nil then
    FOnDestroy.NotifyAll;
  FreeAndNil(FOnDestroy);
  inherited;
end;

function Ts0CollectionItem.Equals(AItem: Ts0CollectionItem): Boolean;
begin
  Result := False;
end;

function Ts0CollectionItem.GetCollectionAs0Level: Ts0Collection;
begin
  Result := nil;
  if Collection is Ts0Collection then
    Result := Ts0Collection(Collection);
end;

function Ts0CollectionItem.GetClassType: Ts0CollectionItemClass;
begin
  Result := Ts0CollectionItemClass(Self.ClassType);
end;

function Ts0CollectionItem.GetFullName: string;
begin
  Result := Self.GetIdentifier;
  if Result = '' then
    Result := GetNamePath;
  if not(OwnerItem is Ts0CollectionItem) then Exit;
  Result :=
    Ts0CollectionItem(OwnerItem).GetFullName +
    Self.GetClassType.GetFullNameDelimiter + Result;
end;

class function Ts0CollectionItem.GetFullNameDelimiter: Char;
begin
  Result := '.';
end;

function Ts0CollectionItem.GetIdentifier: string;
begin
  Result := '';
end;

function Ts0CollectionItem.GetOnDestroy: Ts0Event;
begin
  if FOnDestroy = nil then
    FOnDestroy := Ts0Event.Create(Self);
  Result := FOnDestroy;
end;

function Ts0CollectionItem.GetOwnerComponent: TComponent;
begin
  Result := nil;
  if Collection is Ts0Collection then
    Result := Ts0Collection(Collection).GetOwnerComponent;
end;

function Ts0CollectionItem.GetOwnerItem: Ts0CollectionItem;
begin
  Result := nil;
  if GetCollectionAs0Level = nil then Exit;
  Result := Ts0CollectionItem(GetCollectionAs0Level.OwnerObj);
end;

function Ts0CollectionItem.GetOwnerObj: TPersistent;
begin
  Result := nil;
  if Collection is Ts0Collection then
    Result := Ts0Collection(Collection).GetOwnerObj;
end;

function Ts0CollectionItem.GetSubCollection: Ts0Collection;
begin
  Result := nil;
end;

function Ts0CollectionItem.GetSubCollectionClass: Ts0CollectionClass;
begin
  Result := nil;
end;

function Ts0CollectionItem.NewSubCollection: Ts0Collection;
begin
  Result := nil;
  if GetSubCollectionClass = nil then Exit;
  Result := GetSubCollectionClass.Create(Self, Self.GetClassType);
end;

procedure Ts0CollectionItem.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
end;

{ Ts0CollectionItemEvent }

constructor Ts0CollectionItemEvent.Create(ASender: TObject);
begin
  inherited Create(ASender);
end;

{ Ts0CollectionItemEventListener }

constructor Ts0CollectionItemEventListener.Create(AHandler:
  K0CollectionItemEvent);
begin
  inherited Create;
  FOnEvent := AHandler;
end;

procedure Ts0CollectionItemEventListener.Update(ASubj: Ts0Subject);
var
  s: TObject;
  item: Ts0CollectionItem;
begin
  s := nil;
  item := nil;
  if ASubj is Ts0CollectionItemEvent then
  begin
    s := Ts0CollectionItemEvent(ASubj).Sender;
    item := Ts0CollectionItemEvent(ASubj).Item;
  end;
  if Assigned(FOnEvent) then
    FOnEvent(s, item);
end;

{ Ts0Collection }

constructor Ts0Collection.Create(AOwner: TPersistent; AItemClass:
  Ts0CollectionItemClass);
begin
  inherited Create(AOwner, AItemClass);
  FCloneAssign := True;
end;

function Ts0Collection.GetClassType: Ts0CollectionClass;
begin
  Result := Ts0CollectionClass(Self.ClassType);
end;

function Ts0Collection.GetOwnerComponent: TComponent;
var
  lOwner: TPersistent;
begin
  Result := nil;
  lOwner := GetOwner;
  if lOwner is TComponent then
    Result := TComponent(lOwner)
  else
  if lOwner is Ts0CollectionItem then
    Result := Ts0CollectionItem(lOwner).GetOwnerComponent
  else
  if lOwner is Ts0Persistent then
    Result := Ts0Persistent(lOwner).OwnerComponent;
end;

procedure Ts0Collection.Remove(AItem: Ts0CollectionItem);
var
  idx: Integer;
begin
  idx := IndexOf(AItem);
  if idx < 0 then
    Exit;
  inherited Delete(idx);
end;

function Ts0Collection.IndexOf(AItem: Ts0CollectionItem): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count - 1 do
    if Self.Items[i] = AItem then
    begin
      Result := i;
      Exit;
    end;
end;

procedure Ts0Collection.Notification(AComponent: TComponent; Operation:
  TOperation);
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
    if Self.Items[i] is Ts0CollectionItem then
      Ts0CollectionItem(Self.Items[i]).Notification(AComponent, Operation);
end;

procedure Ts0Collection.Accept(v: Ts0CollectionVisitor);
begin
  v.VisitCollection(Self);
end;

function Ts0Collection.GetItem(Index: Integer): Ts0CollectionItem;
begin
  Result := Ts0CollectionItem(inherited Items[Index]);
end;

procedure Ts0Collection.SetItem(Index: Integer; const Value: Ts0CollectionItem);
begin
  inherited Items[Index] := Value;
end;

procedure Ts0Collection.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if not(Source is Ts0Collection) then Exit;
  if FCloneAssign then
  begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to Ts0Collection(Source).Count - 1 do
        Ts0Collection(Source).Items[i].Clone.Collection := Self;
    finally
      EndUpdate;
    end;
  end
  else
  begin
    inherited Assign(Source);
  end;
end;

function Ts0Collection.Clone(AOwner: TPersistent): Ts0Collection;
begin
  Result := Self.GetClassType.Create(AOwner,
    Ts0CollectionItemClass(Self.ItemClass));
  Result.Assign(Self);
end;

procedure Ts0Collection.Update(Item: TCollectionItem);
begin
  if UpdateCount > 0 then Exit;
  inherited Update(Item);
  if Assigned(FOnUpdate) then
  begin
    if Item is Ts0CollectionItem then
      FOnUpdate.FItem := Ts0CollectionItem(Item)
    else
      FOnUpdate.FItem := nil;
    FOnUpdate.NotifyAll;
  end;
  if Item <> nil then Exit;
  if not(OwnerObj is TCollectionItem) then Exit;
  if not(TCollectionItem(OwnerObj).Collection is Ts0Collection) then Exit;
  Ts0Collection(TCollectionItem(OwnerObj).Collection).Update(nil);
end;

function Ts0Collection.GetOnUpdate: Ts0CollectionItemEvent;
begin
  if FOnUpdate = nil then
    FOnUpdate := Ts0CollectionItemEvent.Create(Self);
  Result := FOnUpdate;
end;

destructor Ts0Collection.Destroy;
begin
  FreeAndNil(FOnUpdate);
  inherited;
end;

function Ts0Collection.GetOwnerObj: TPersistent;
begin
  Result := inherited GetOwner;
end;

function Ts0Collection.Equals(ACollection: Ts0Collection): Boolean;
var
  i: Integer;
begin
  Result := False;
  if ACollection = nil then Exit;
  if Self.Count <> ACollection.Count then Exit;
  for i := 0 to Self.Count -1 do
    if not Self.Items[i].Equals( ACollection.Items[i] ) then
      Exit;
  Result := True;
end;

function Ts0Collection.Add: Ts0CollectionItem;
begin
  Result := GetItemClass.Create(Self);
end;

function Ts0Collection.Insert(Index: Integer): Ts0CollectionItem;
begin
  Result := Add;
  Result.Index := Index;
end;

function Ts0Collection.GetItemClass: Ts0CollectionItemClass;
begin
  Result := Ts0CollectionItemClass(inherited ItemClass);
end;

function Ts0Collection.FindByIdentifier(AIdentifier: string): Ts0CollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].Identifier = AIdentifier then
    begin
      Result := Items[i];
      Exit;
    end;
end;

procedure Ts0Collection.DoItemDestroy(AItem: Ts0CollectionItem);
begin
  if Assigned(FOnItemDestroy) then
    FOnItemDestroy(Self, AItem);
end;

procedure Ts0Collection.NotifyItemDestroy(AItem: Ts0CollectionItem);
begin
  DoItemDestroy(AItem);
end;

function Ts0Collection.Iterator: Is0ObjIterator;
begin
  Result := Ts0CollectionIterator.CreateAsIntf(Self);
end;

{ Ts0CollectionVisitor }

procedure Ts0CollectionVisitor.VisitCollection(ACollection: Ts0Collection);
var
  i: Integer;
begin
  for i := 0 to ACollection.Count - 1 do
    ACollection.Items[i].Accept(Self);
end;

procedure Ts0CollectionVisitor.VisitItem(AItem: Ts0CollectionItem);
begin
  if AItem.SubCollection <> nil then
    AItem.SubCollection.Accept(Self);
end;

{ Ts0CollectionItemList }

function Ts0CollectionItemList.Add(AItem: Ts0CollectionItem): Integer;
begin
  Result := inherited Add(AItem);
end;

function Ts0CollectionItemList.FindByIdentifier(
  AIdentifier: String): Ts0CollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].Identifier = AIdentifier then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0CollectionItemList.First: Ts0CollectionItem;
begin
  Result := Ts0CollectionItem( inherited First );
end;

function Ts0CollectionItemList.GetItems(Index: Integer): Ts0CollectionItem;
begin
  Result := Ts0CollectionItem( inherited Items[Index] );
end;

function Ts0CollectionItemList.IndexOf(AItem: Ts0CollectionItem): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure Ts0CollectionItemList.Insert(Index: Integer;
  AItem: Ts0CollectionItem);
begin
  inherited Insert(Index, AItem);
end;

function Ts0CollectionItemList.Last: Ts0CollectionItem;
begin
  Result := Ts0CollectionItem( inherited Last );
end;

function Ts0CollectionItemList.Remove(AItem: Ts0CollectionItem): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure Ts0CollectionItemList.SetItems(Index: Integer; AItem: Ts0CollectionItem);
begin
  inherited Items[Index] := AItem;
end;

procedure Ts0CollectionItemList.SortByIdentifier;
var
  bufOwnObj: Boolean;
  sl: TStringList;
  i: Integer;
begin
  bufOwnObj := OwnsObjects;
  if OwnsObjects then
    OwnsObjects := False;
  //
  sl := TStringList.Create;
  try
    for i := 0 to Self.Count -1 do
      sl.AddObject( Items[i].Identifier, Items[i] );
    //
    sl.Sort;
    Self.Clear;
    for i := 0 to sl.Count -1 do
      Self.Add( Ts0CollectionItem(sl.Objects[i]) );
  finally
    FreeAndNil(sl);
  end;
  //
  if bufOwnObj then
    OwnsObjects := True;
end;

{ Ts0CollectionItemFinder }

constructor Ts0CollectionItemFinder.Create;
begin
  inherited Create;
  FTimingOfSubFind := k0fsikAfterMatch;
  FResultList := Ts0CollectionItemList.Create(False);
end;

destructor Ts0CollectionItemFinder.Destroy;
begin
  FreeAndNil(FResultList);
  inherited;
end;

procedure Ts0CollectionItemFinder.Execute;
begin
  FResultList.Clear;
  if FTarget = nil then Exit;
  FTarget.Accept(Self);
end;

procedure Ts0CollectionItemFinder.VisitCollection(ACollection: Ts0Collection);
begin
  if FAnswerOnlyOne and (FResultList.Count > 0) then Exit;
  inherited;
end;

procedure Ts0CollectionItemFinder.VisitItem(AItem: Ts0CollectionItem);
  function ExitNow: Boolean;
  begin
    Result := (FAnswerOnlyOne and (FResultList.Count > 0));
  end;
begin
  if ExitNow then Exit;

  if TimingOfSubFind = k0fsikBeforeMatch then inherited VisitItem(AItem);
  if ExitNow then Exit;

  if Match(AItem) then
    FResultList.Add(AItem);
  if ExitNow then Exit;

  if TimingOfSubFind = k0fsikAfterMatch then inherited VisitItem(AItem);
end;

{ Ts0ItemFinderByName }

function Ts0ItemFinderByName.Match(AItem: Ts0CollectionItem): Boolean;
begin
  if FSearchByFullName then
    Result := (AItem.FullName = FName)
  else
    Result := (AItem.Identifier = FName);
end;

{ Ts0InterfacedCollectionItem }

function Ts0InterfacedCollectionItem._AddRef: Integer;
begin
  Result := -1;
end;

function Ts0InterfacedCollectionItem._Release: Integer;
begin
  Result := -1;
end;

function Ts0InterfacedCollectionItem.QueryInterface(const IID: TGUID;
  out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

{ Ts0InterfacedCollection }

function Ts0InterfacedCollection._AddRef: Integer;
begin
  Result := -1;
end;

function Ts0InterfacedCollection._Release: Integer;
begin
  Result := -1;
end;

function Ts0InterfacedCollection.QueryInterface(const IID: TGUID;
  out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

end.

