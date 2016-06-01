{-----------------------------------------------------------------------------
 Unit Name: s0Entity
 Author:    akima
 Purpose:
 TestCase: tc_s0Entity
$History: s0Entity.pas $
 * 
 * *****************  Version 42  *****************
 * User: Akima        Date: 02/05/15   Time: 17:12
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 41  *****************
 * User: Akima        Date: 02/03/19   Time: 0:33
 * Updated in $/D5/source/Common
 * UnRegisterEntityでFEntityListのnilチェックを追加
 * 
 * *****************  Version 40  *****************
 * User: Akima        Date: 02/03/18   Time: 13:55
 * Updated in $/D5/source/Common
 * g9EntityDisplayがFreeされていなかったので、finalization部で行うようにし
 * た。
 * 
 * *****************  Version 39  *****************
 * User: Akima        Date: 02/03/14   Time: 4:07
 * Updated in $/D5/source/Common
 * LocateEntityOnListを基底クラスでvirtualに宣言するように変更
 * 
 * *****************  Version 38  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 37  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 36  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 35  *****************
 * User: Akima        Date: 02/02/14   Time: 21:55
 * Updated in $/source/D5Integrated
 * Ts0EntityCollectionを追加
 * 
 * *****************  Version 34  *****************
 * User: Akima        Date: 02/02/08   Time: 18:14
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 33  *****************
 * User: Akima        Date: 02/01/25   Time: 4:45
 * Updated in $/source/D6VCLIntegrated
 * GetManagerByClassNameの修正
 * 
 * *****************  Version 32  *****************
 * User: Akima        Date: 02/01/21   Time: 22:42
 * Updated in $/source/D6VCLIntegrated
 * 各Entity用のDMには、Ts0EntityFormManagerを置かないように変更。
 * Ts0EntityFormManagerはコンポーネントとして廃止した。
 * Tc0EntityDispManagerはSingletonへ。
 * 
 * *****************  Version 31  *****************
 * User: Akima        Date: 02/01/17   Time: 23:57
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 01/12/13   Time: 15:38
 * Updated in $/source/D5Integrated
 * エンティティのインスタンスを生成するときに、Managerが見つからないと例外
 * を発生するように変更
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 01/12/06   Time: 13:34
 * Updated in $/source/D5Integrated
 * EnumValueToStr、StrToEnumValueをTs0EntityとTs0EntityManagerに追加。
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 01/12/06   Time: 12:12
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 24  *****************
 * User: Akima        Date: 01/11/28   Time: 1:59
 * Updated in $/source/D5Integrated
 * 参照からのコンストラクタ呼び出しで、エンティティのインスタンスの生成を
 * 行えるようにした。
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 01/11/19   Time: 9:14
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 01/11/16   Time: 14:00
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/11/13   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/11/13   Time: 2:28
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/11/12   Time: 14:54
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/10/17   Time: 23:39
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/10/17   Time: 12:27
 * Updated in $/source/D5Integrated
 * Clearメソッドを追加
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/10/11   Time: 17:24
 * Updated in $/source/D5Integrated
 * BeginUpdate、EndUpdateをvirtualに。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/10/10   Time: 21:01
 * Updated in $/source/D5Integrated
 *  Ts0EntityRegister.UnRegisterEntityとTs0EntityDisplay.DispModeToStrを追
 * 加
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/09   Time: 16:25
 * Updated in $/source/D5Integrated
 * Ts0EntityManager.Destroyでg9EtyManListのnilチェック
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/04   Time: 12:23
 * Updated in $/source/D5Integrated
 * GetManagerByClassNameメソッドをTs0EntityManagerに追加。
 * 設計時にマネージャを特定する場合に使用する。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/02   Time: 3:13
 * Updated in $/source/D5Integrated
 * GetClassCaptionメソッドを追加
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/23   Time: 1:11
 * Updated in $/source/D5Integrated
 * K0DetailDisplayModeを追加。
 * 表示系メソッドに引数AModeを追加。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/03   Time: 2:31
 * Updated in $/source/D5/p0entity
 * エンティティ生成関係とりあえずOKできました
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/30   Time: 12:52
 * Updated in $/source/D5/p0entity
 * Entity関係の作成を一時中断。
 * パッケージの再構築時にエラーが出ることが多いので、そっちを先に対応予定
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0entity
 * p0entityひとまずOK。
 * しかし、汎用的なフォームのためにリファクタリングを思案中・・・
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/28   Time: 8:22
 * Updated in $/source/D5/p0entity
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/27   Time: 20:04
 * Updated in $/source/D5/p0entity
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/26   Time: 13:04
 * Updated in $/source/D5/p0entity
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0entity
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:28
 * Created in $/Projects/SDRFrameWork/src/lib0
 * 新規追加
 * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
 * VSSでは共有してません。
-----------------------------------------------------------------------------}

unit s0Entity;

interface

uses
  SysUtils, Classes, {Forms, Controls,}
  Contnrs,
  s0Iterator,
  s0Persistent,
  s0Collection,
  s0Observer,
  s0EntityPropProto;

type
  K0EntityAccess = (k0eaProperties, k0eaNavigators);
  K0EntityAccessSet = set of K0EntityAccess;

type
  K0NotFoundOnListOption = (k0leoNone, k0leoFirst, k0leoLast);

type
  K0DetailDisplayMode = (k0ddmReadOnly, k0ddmEdit, k0ddmNewEntity);
  K0DetailDisplayModeSet = set of K0DetailDisplayMode;

type
  Ts0EntityClass = class of Ts0Entity;
  Ts0Entity = class;

  K0EntityNotifyEvent = procedure(Sender: Ts0Entity) of object;
  K0EntityEvent = procedure(Sender: TObject; AEntity: Ts0Entity) of object;

  Ts0EntityNavis = class;
  Ts0EntityManager = class;

  {
    永続化対象となるエンティティの基底クラスとなるべきクラス。
    通常、Manager(Ts0EntityManagerクラスの派生クラス)を保持するデータモジュール
    と一緒に作成し、使用する。
  }
  Ts0Entity = class(TComponent)
  private
    FManager: Ts0EntityManager;
    FNavigators: Ts0EntityNavis;
    FOnChange: Ts0Event;
    FOnChangeID: Ts0Event;
    FOnDestroy: Ts0Event;
    FLoading: Boolean;
    FRestored: Boolean;
    FModified: Boolean;
    FUpdateCount: Integer;
    FNotFound: Boolean;
    procedure SetNavigators(const Value: Ts0EntityNavis);
    function GetNavigators: Ts0EntityNavis;
    procedure SetManager(const Value: Ts0EntityManager);
    function GetOnChange: Ts0Event;
    function GetOnChangeID: Ts0Event;
    function GetOnDestroy: Ts0Event;
  protected
    procedure DoChange;
    procedure DoChangeID;
    function GetCaption: string; virtual;
    function GetID: Integer; virtual;
    function NewNavigators: Ts0EntityNavis; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure NotifyDestroy; virtual;
    procedure SetCaption(const Value: string); virtual;
    procedure SetID(const Value: Integer); virtual;
    property Loading: Boolean read FLoading;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    {
      プロパティの更新開始をおこなうメソッド。
      このメソッドを実行後、EndUpdateメソッドが実行されるまでは、
      OnChangeイベントは実行されない。
    }
    procedure BeginUpdate; virtual;
    {
      変更があったことを通知するメソッド。
      BeginUpdate呼出した後、EndUpdateが呼び出されるまでは、Changeメソッドを
      実行しても変更の通知は行われない。
    }
    procedure Change; virtual;
    {
      IDプロパティに変更があったことを通知するメソッド。
      BeginUpdate呼出した後、EndUpdateが呼び出されるまでは、ChangeIDメソッドを
      実行しても変更の通知は行われない。
    }
    procedure ChangeID;
    {
      プロパティを初期化するメソッド。
      実際には、各publishedプロパティの値をdefaultで指定された値に設定する。
    }
    procedure Clear; virtual;
    {
      プロパティの更新終了をおこなうメソッド。
      BeginUpdateメソッドが実行された後、このメソッドを実行するまでは
      OnChangeイベントは実行されない。
    }
    procedure EndUpdate; virtual;
    {
      インスタンスと同じクラスのインスタンスを生成し、
      生成されたインスタンスのAssignメソッドを呼び出すメソッド。
    }
    function Clone(AOwner: TComponent = nil): Ts0Entity;
    {
      インスタンスがどのクラスなのかをTs0EntityClass型として得るためのメソッド。
    }
    function EntityClass: Ts0EntityClass;
    {
      インスタンスが保持するデータがそれぞれ同じ値かどうかを判断するメソッド。
      通常Assignメソッドの内容と対を成すような実装が行われる。
    }
    function Equals(AEntity: Ts0Entity): Boolean; virtual;
  public
    {
      インスタンスのデータを新規に登録するメソッド。
      ただし、マネージャあるいはマネージャのデータモジュールにそれを
      行う実装を用意する必要があります。
    }
    procedure Insert;
    {
      マネージャが参照するリストの中からカレントな項目のデータを取得するメソッド。
      通常IDプロパティか、それに該当するプロパティの値を設定してからこのメソッド
      を使用する。
      ただし、マネージャあるいはマネージャのデータモジュールにそれを
      行う実装を用意する必要があります。
    }
    procedure Load;
    {
      マネージャが参照するリストのカレントな項目のIDの値を取得するメソッド。
      ただし、マネージャあるいはマネージャのデータモジュールにそれを
      行う実装を用意する必要があります。
    }
    procedure LoadKey;
    {
      各種ナビゲータの値を取得するメソッド。
      ただし、マネージャあるいはマネージャのデータモジュールにそれを
      行う実装を用意する必要があります。
    }
    procedure LoadNavigators;
    {
      エンティティのデータをマネージャが参照するリストから削除するメソッド。
      ただし、マネージャあるいはマネージャのデータモジュールにそれを
      行う実装を用意する必要があります。
    }
    procedure Remove;
    {
      エンティティのデータをマネージャが参照するリストに更新するメソッド。
      実際には、このメソッドは必要に応じてInsertメソッドあるいはUpdateメソッド
      のどちらかを実行するだけです。
    }
    procedure Save;
    {
      エンティティのデータをマネージャが参照するリストに更新するメソッド。
      ただし、マネージャあるいはマネージャのデータモジュールにそれを
      行う実装を用意する必要があります。
    }
    procedure Update;
  public
    {
      エンティティがGUIのアプリなどの場合、
    }
    function ShowDetail(const AModal: Boolean; AOrigin: TObject = nil;
      AMode: K0DetailDisplayMode = k0ddmReadOnly): Integer;
    property Caption: string read GetCaption write SetCaption;
    property ID: Integer read GetID write SetID;
    property Manager: Ts0EntityManager read FManager write SetManager;
    property Modified: Boolean read FModified write FModified default False;
    property NotFound: Boolean read FNotFound write FNotFound default False;
    property Restored: Boolean read FRestored write FRestored default False;
    property OnChange: Ts0Event read GetOnChange;
    property OnChangeID: Ts0Event read GetOnChangeID;
    property OnDestroy: Ts0Event read GetOnDestroy;
    class function GetClassCaption: string; virtual;
    class function GetClassID: Integer; virtual;
    class function GetManager(AClass: Ts0EntityClass): Ts0EntityManager; virtual;
    class function FindEntity(AClass: Ts0EntityClass; AID: Integer): Ts0Entity; virtual;
    class function FindEntityClass(AEntityClassID: Integer): Ts0EntityClass; virtual;
    class function NewEntity(AClass: Ts0EntityClass; AOwner: TComponent = nil): Ts0Entity; virtual;
    class function ShowList(AClass: Ts0EntityClass; const AModal: Boolean;
      AOrigin: TObject = nil): Integer;
  public
    class function EnumValueToStr(APropName: string; const Value: Integer): string;
    class function StrToEnumValue(APropName: string; const Value: string): Integer;
  published
    property Navigators: Ts0EntityNavis read GetNavigators write SetNavigators;
  end;

  Ts0EntityIterator = class(Ts0AbstractIterator)
  public
    procedure AssignCurrent(Dest: Ts0Entity); virtual; abstract;
  end;

  Ts0EntityList = class(TObjectList)
  private
  protected
    function GetItems(Index: Integer): Ts0Entity;
    procedure SetItems(Index: Integer; AItem: Ts0Entity);
  public
    function Add(AItem: Ts0Entity): Integer;
    function Remove(AItem: Ts0Entity): Integer;
    function IndexOf(AItem: Ts0Entity): Integer;
    procedure Insert(Index: Integer; AItem: Ts0Entity);
    property Items[Index: Integer]: Ts0Entity read GetItems write SetItems; default;
    function First: Ts0Entity;
    function Last: Ts0Entity;
  end;

  K0EntityListEvent = procedure(AList: Ts0EntityList) of object;


  {
    K0NaviRelationType
    TargetEtyは、Naviのオーナーから見てどのような関係にあるのか。
  }
  K0NaviRelationType = (
    k0entLink , //参照
    k0entPart , //部分 （ <--->k0entOwner ）
    k0entOwner, //オーナー （ <--->k0entPart ）
    k0entType , //型、あるいは分類 （ <--->k0entOneOfType ）
    k0entOneOfType //型の要素、あるいは分類に該当するもの（ <--->k0entType ）
  );
  K0NaviRelationTypeSet = set of K0NaviRelationType;

  Ts0EntityNaviClass = class of Ts0EntityNavi;
  Ts0EntityNavi = class(Ts0CollectionItem)
  private
    FCaption: string;
    FID: Integer;
    FTargetEty: Ts0Entity;
    FTargetCaption: string;
    FTargetClassID: Integer;
    FTargetID: Integer;
    FRelationType: K0NaviRelationType;
    function GetOwnerEntity: Ts0Entity;
    function GetTargetCaption: string;
    function GetTargetClassID: Integer;
    function GetTargetID: Integer;
    procedure SetCaption(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetTargetEty(const Value: Ts0Entity);
    procedure SetTargetCaption(const Value: string);
    procedure SetTargetClassID(const Value: Integer);
    procedure SetTargetID(const Value: Integer);
    function GetTargetClass: Ts0EntityClass;
    procedure SetRelationType(const Value: K0NaviRelationType);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CreateTarget(AOwner: TComponent = nil; ALoadKinds: K0EntityAccessSet =
      [k0eaProperties, k0eaNavigators]): Ts0Entity;
    function Equals(AItem: Ts0CollectionItem): Boolean; override;
    procedure RestoreTarget;
    function ShowTargetDetail(AModal: Boolean; AOrigin: TObject; AMode: K0DetailDisplayMode = k0ddmReadOnly): Integer;
    property OwnerEntity: Ts0Entity read GetOwnerEntity;
    property TargetEty: Ts0Entity read FTargetEty write SetTargetEty;
    property TargetClass: Ts0EntityClass read GetTargetClass;
  published
    property ID: Integer read FID write SetID;
    property Caption: string read FCaption write SetCaption;
    property TargetCaption: string read GetTargetCaption write SetTargetCaption;
    property TargetClassID: Integer read GetTargetClassID write
      SetTargetClassID;
    property TargetID: Integer read GetTargetID write SetTargetID;
    property RelationType: K0NaviRelationType read FRelationType write SetRelationType default k0entLink;
  end;

  Ts0EntityNavis = class(Ts0Collection)
  private
    FOwnerEntity: Ts0Entity;
    function GetItems(const Index: Integer): Ts0EntityNavi;
    procedure SetItems(const Index: Integer; const Value: Ts0EntityNavi);
  public
    constructor Create(AOwner: TPersistent; ItemClass: Ts0CollectionItemClass);
      override;
    function AddByID(AID, AClassID: Integer; AEntityCaption: string; ACaption: string = ''): Ts0EntityNavi;
    function AddByEntity(AEntity: Ts0Entity; ACaption: string = ''): Ts0EntityNavi;
    function FindByCaption(ACaption: string): Ts0EntityNavi;
    function FindByClass(AClass: Ts0EntityClass): Ts0EntityNavi;
    property OwnerEntity: Ts0Entity read FOwnerEntity;
    property Items[const Index: Integer]: Ts0EntityNavi read GetItems write
      SetItems; default;
  end;

  Ts0EntityDisplayClass = class of Ts0EntityDisplay;
  Ts0EntityDisplay = class(TComponent)
  private
  protected
  public
    class procedure RegisterEntityDisplayClass(AClass: Ts0EntityDisplayClass);
    class function Instance: Ts0EntityDisplay;
    procedure ShowDetail(AEntity: Ts0Entity; AOrigin: TObject = nil; AMode: K0DetailDisplayMode = k0ddmReadOnly);
      virtual; abstract;
    function ShowDetailModal(AEntity: Ts0Entity; AOrigin: TObject = nil; AMode: K0DetailDisplayMode = k0ddmReadOnly):
      Integer; virtual; abstract;
    procedure ShowList(AEntityClass: Ts0EntityClass; AOrigin: TObject = nil); virtual; abstract;
    function ShowListModal(AEntityClass: Ts0EntityClass; AOrigin: TObject = nil): Integer; virtual; abstract;
    class function DispModeToStr(AMode: K0DetailDisplayMode): string;
  end;

  Ts0EntityActions = class;

  Ts0EntityManager = class(TComponent)
  private
    FOnNewEntity: K0EntityEvent;
    FEntityClassName: string;
    FEntityList: Ts0EntityList;
    FOnFreeEntity: K0EntityEvent;
    FOnDestroy: Ts0Event;
    FProtoTypes: Ts0EntityPropProtos;
    FActions: Ts0EntityActions;
    procedure SetEntityClassName(const Value: string);
    function GetEntityClass: Ts0EntityClass;
    function GetOnDestroy: Ts0Event;
    procedure SetProtoTypes(const Value: Ts0EntityPropProtos);
    procedure SetActions(const Value: Ts0EntityActions);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  protected
    procedure DoFreeEntity(AEntity: Ts0Entity); virtual;
    procedure Insert(AEntity: Ts0Entity); virtual;
    procedure Load(AEntity: Ts0Entity); virtual;
    procedure Remove(AEntity: Ts0Entity); virtual;
    procedure Save(AEntity: Ts0Entity); virtual;
    procedure Update(AEntity: Ts0Entity); virtual;
  protected
    function NewActions: Ts0EntityActions; virtual;
  public
    procedure RefreshList; virtual;
    procedure LoadKeyFromList(AEntity: Ts0Entity); virtual;
    procedure LoadNaviKeyFromList(ANavi: Ts0EntityNavi); virtual;
    function LocateEntityOnList(AEntityID: Integer;
      AOption: K0NotFoundOnListOption{ = k0leoNone}): Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property EntityClass: Ts0EntityClass read GetEntityClass;
    property EntityList: Ts0EntityList read FEntityList;
    function FindEntity(AID: Integer): Ts0Entity; virtual;
    function NewEntity(AOwner: TComponent = nil): Ts0Entity; virtual;
    procedure RegisterNewEntity(AEntity: Ts0Entity);
    procedure UnRegisterEntity(AEntity: Ts0Entity);
    procedure PrepareList; virtual;
    procedure UnPrepareList; virtual;
    function EnumValueToStr(APropName: string; const Value: Integer): string;
    function StrToEnumValue(APropName: string; const Value: string): Integer;
    function NewIterator: Ts0EntityIterator; virtual;
    property OnDestroy: Ts0Event read GetOnDestroy;
  public
    {
      このメソッドは、クラス生成ツールのために公開されています。
      通常のアプリケーションを作成する場合には使用しないでください。
    }
    class procedure SetTestSwitch(Value: Boolean);
  published
    property Actions: Ts0EntityActions read FActions write SetActions;
    property EntityClassName: string read FEntityClassName write SetEntityClassName;
    property ProtoTypes: Ts0EntityPropProtos read FProtoTypes write SetProtoTypes;
    property OnFreeEntity: K0EntityEvent read FOnFreeEntity write FOnFreeEntity;
    property OnNewEntity: K0EntityEvent read FOnNewEntity write FOnNewEntity;
  end;

  Ts0EntityAction = class(Ts0CollectionItem)
  private
    FOnExecute: K0EntityEvent;
    FAfterExecute: K0EntityEvent;
    FBeforeExecute: K0EntityEvent;
    FLinkMethod: string;
    FActionName: string;
    FCaption: string;
    FHint: string;
    procedure SetLinkMethod(const Value: string);
    procedure SetActionName(const Value: string);
    procedure SetCaption(const Value: string);
    procedure SetHint(const Value: string);
  protected
    function CallMethodByName(AEntity: Ts0Entity): Boolean;
  public
    procedure Execute(AEntity: Ts0Entity);
  published
    property ActionName: string read FActionName write SetActionName;
    property Caption: string read FCaption write SetCaption;
    property Hint: string read FHint write SetHint;
    property LinkMethod: string read FLinkMethod write SetLinkMethod;
    property AfterExecute : K0EntityEvent read FAfterExecute  write FAfterExecute ;
    property BeforeExecute: K0EntityEvent read FBeforeExecute write FBeforeExecute;
    property OnExecute: K0EntityEvent read FOnExecute write FOnExecute;
  end;

  Ts0EntityActions = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0EntityAction;
    procedure SetItems(const Index: Integer; const Value: Ts0EntityAction);
  public
    function Add: Ts0EntityAction;
    procedure AddDefaultActions;
    function FindByName(AActionName: string): Ts0EntityAction;
    property Items[const Index: Integer]: Ts0EntityAction read GetItems write SetItems;
  end;

type
  Ts0EntityCollectionItem = class(Ts0CollectionItem)
  private
    FDeleted: Boolean;
    FRestored: Boolean;
    procedure SetDeleted(const Value: Boolean);
    function GetOwnerID: Integer;
  protected
    procedure AssignByRTTI(Source, Dest: TObject);
    function EntityClone: Ts0Entity; virtual;
    function TargetEntityClass: Ts0EntityClass; virtual;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignFromEntity(AEntity: Ts0Entity); virtual;
    procedure AssignToEntity(AEntity: Ts0Entity); virtual;
    procedure Save; virtual;
    property OwnerID: Integer read GetOwnerID;
    property Restored: Boolean read FRestored write FRestored; 
  published
    property Deleted: Boolean read FDeleted write SetDeleted default False;
  end;

  Ts0EntityCollection = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0EntityCollectionItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0EntityCollectionItem);
  public
    function Add: Ts0EntityCollectionItem;
    procedure AssignFromList(Source: Ts0EntityList); virtual;
    procedure AssignToList(Dest: Ts0EntityList); virtual;
    procedure SaveItems;
    property Items[const Index: Integer]: Ts0EntityCollectionItem read GetItems write SetItems;
  end;

type
  Ts0AbstractEntityManBrokerClass = class of Ts0AbstractEntityManBroker;
  Ts0AbstractEntityManBroker = class
  protected
  public
    constructor Create; virtual;
    class procedure RegisterBrokerClass(AClass: Ts0AbstractEntityManBrokerClass);
    class function Instance: Ts0AbstractEntityManBroker;
    function GetManagerByClass(AClass: Ts0EntityClass): Ts0EntityManager; virtual; abstract;
    function GetManagerByClassID(AEntityClassID: Integer): Ts0EntityManager; virtual; abstract;
    function GetManagerByClassName(AEntityClassName: String): Ts0EntityManager; virtual;
    function NeedManager(AClass: Ts0EntityClass): Ts0EntityManager; virtual; abstract;
    procedure RegisterManager(AEntityMan: Ts0EntityManager); virtual; abstract;
    procedure UnRegisterManager(AEntityMan: Ts0EntityManager); virtual; abstract;
  end;

type
  Ts0EntityManBroker = class(Ts0AbstractEntityManBroker)
  private
    FEtyManList: TObjectList;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetManagerByClass(AClass: Ts0EntityClass): Ts0EntityManager; override;
    function GetManagerByClassID(AEntityClassID: Integer): Ts0EntityManager; override;
    function GetManagerByClassName(AEntityClassName: String): Ts0EntityManager; override;
    function NeedManager(AClass: Ts0EntityClass): Ts0EntityManager; override;
    procedure RegisterManager(AEntityMan: Ts0EntityManager); override;
    procedure UnRegisterManager(AEntityMan: Ts0EntityManager); override;
  end;

type
  Es0EntityManBroker = class(Exception);

type
  Ts0EntityRegister = class(TComponent)
  private
  public
    class function GetEntityClass(AClassID: Integer): Ts0EntityClass;
    class function GetEntityClassByName(AClassName: string): Ts0EntityClass;
    class procedure GetEntityNameList(Dest: TStrings);
    class procedure RegisterEntity(AClass: Ts0EntityClass);
    class procedure UnRegisterEntity(AClass: Ts0EntityClass);
    class function IsRegistered(AClassName: string): Boolean;
  end;

type
  Es0EntityManagerException = class(Exception);

procedure RegisterEntity(AClass: Ts0EntityClass);

implementation

uses
  s0EnumCollection,
  s0TypInfoWrapper;

procedure RegisterEntity(AClass: Ts0EntityClass);
begin
  Ts0EntityRegister.RegisterEntity(AClass);
end;

{ Ts0Entity }

procedure Ts0Entity.Assign(Source: TPersistent);
begin
  //Assignメソッドでは自分のIDをコピーしちゃいけませんよ。
  if not (Source is Ts0Entity) then
    Exit;
  Navigators.Assign(Ts0Entity(Source).Navigators);
end;

procedure Ts0Entity.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure Ts0Entity.Change;
begin
  FModified := True;
  DoChange;
end;

procedure Ts0Entity.ChangeID;
begin
  FModified := True;
  DoChangeID;
end;

procedure Ts0Entity.Clear;
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  acsr := Ts0RTTIPublishedAccessor.Create(Self);
  try
    acsr.ClearValues;
  finally
    FreeAndNil(acsr);
  end;
end;

function Ts0Entity.Clone(AOwner: TComponent): Ts0Entity;
begin
  Result := (Self.EntityClass).Create(AOwner);
  Result.Assign(Self);
end;

resourcestring
  c9ErrMsg_FailToCreate_ManagerNotFound = 'Managerが見つからず、Entityの生成に失敗しました';

constructor Ts0Entity.Create(AOwner: TComponent);
var
  mgr: Ts0EntityManager;
begin
  inherited Create(AOwner);
  FNotFound := False;
  FRestored := False;
  FModified := False;
  mgr := Ts0EntityManBroker.Instance.NeedManager(Self.EntityClass);
  if mgr = nil then
    raise Es0EntityManagerException.Create(c9ErrMsg_FailToCreate_ManagerNotFound)
  else
  begin
    FManager := mgr;
    mgr.RegisterNewEntity(Self);
  end;
end;

destructor Ts0Entity.Destroy;
begin
  NotifyDestroy;
  if Manager <> nil then
    Manager.UnRegisterEntity(Self);
  FreeAndNil(FOnChange);
  FreeAndNil(FOnChangeID);
  FreeAndNil(FOnDestroy);
  FreeAndNil(FNavigators);
  inherited;
end;

procedure Ts0Entity.DoChange;
begin
  if FUpdateCount > 0 then Exit;
  if Assigned(FOnChange) then
    FOnChange.NotifyAll;
end;

procedure Ts0Entity.DoChangeID;
begin
  if FUpdateCount > 0 then Exit;
  if Assigned(FOnChangeID) then
    FOnChangeID.NotifyAll;
end;

procedure Ts0Entity.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount < 0 then
    FUpdateCount := 0;
  if Modified then
    Change;
end;

function Ts0Entity.EntityClass: Ts0EntityClass;
begin
  Result := Ts0EntityClass(Self.ClassType);
end;

class function Ts0Entity.EnumValueToStr(APropName: string;
  const Value: Integer): string;
var
  mgr: Ts0EntityManager;
begin
  Result := '';
  mgr := Ts0EntityManBroker.Instance.GetManagerByClass(Self);
  if mgr = nil then Exit;
  Result := mgr.EnumValueToStr(APropName, Value);
end;

function Ts0Entity.Equals(AEntity: Ts0Entity): Boolean;
begin
  Result := False;
  if AEntity = nil then
    Exit;
  Result := FNavigators.Equals(AEntity.Navigators);
end;

class function Ts0Entity.FindEntity(AClass: Ts0EntityClass; AID: Integer): Ts0Entity;
var
  mgr: Ts0EntityManager;
begin
  Result := nil;
  mgr := GetManager(AClass);
  if mgr = nil then Exit;
  Result := mgr.FindEntity(AID);
end;

class function Ts0Entity.FindEntityClass(
  AEntityClassID: Integer): Ts0EntityClass;
var
  mgr: Ts0EntityManager;
begin
  Result := nil;
  mgr := Ts0EntityManBroker.Instance.GetManagerByClassID(AEntityClassID);
  if mgr = nil then Exit;
  Result := mgr.EntityClass;
end;

function Ts0Entity.GetCaption: string;
begin
  Result := Format('%s-%-06.6d', [ClassName, ID]);
end;

class function Ts0Entity.GetClassCaption: string;
begin
  Result := '';
end;

class function Ts0Entity.GetClassID: Integer;
begin
  Result := -1;
end;

function Ts0Entity.GetID: Integer;
begin
  Result := -1;
end;

class function Ts0Entity.GetManager(
  AClass: Ts0EntityClass): Ts0EntityManager;
begin
  Result := Ts0EntityManBroker.Instance.GetManagerByClass(AClass);
end;

function Ts0Entity.GetNavigators: Ts0EntityNavis;
begin
  if FNavigators = nil then
    FNavigators := NewNavigators;
  Result := FNavigators;
end;

function Ts0Entity.GetOnChange: Ts0Event;
begin
  if FOnChange = nil then
    FOnChange := Ts0Event.Create(Self);
  Result := FOnChange;
end;

function Ts0Entity.GetOnChangeID: Ts0Event;
begin
  if FOnChangeID = nil then
    FOnChangeID := Ts0Event.Create(Self);
  Result := FOnChangeID;
end;

function Ts0Entity.GetOnDestroy: Ts0Event;
begin
  if FOnDestroy = nil then
    FOnDestroy := Ts0Event.Create(Self);
  Result := FOnDestroy;
end;

procedure Ts0Entity.Insert;
begin
  FManager.Insert(Self);
end;

procedure Ts0Entity.Load;
begin
  if FLoading then Exit;
  FLoading := True;
  try
    FManager.Load(Self);
    FRestored := True;
  finally
    FLoading := False;
  end;
end;

procedure Ts0Entity.LoadKey;
begin
  FManager.LoadKeyFromList(Self);
end;

procedure Ts0Entity.LoadNavigators;
begin
  //
end;

class function Ts0Entity.NewEntity(AClass: Ts0EntityClass; AOwner: TComponent): Ts0Entity;
var
  mgr: Ts0EntityManager;
begin
  Result := nil;
  mgr := GetManager(AClass);
  if mgr = nil then Exit;
  Result := mgr.NewEntity(AOwner);
end;

function Ts0Entity.NewNavigators: Ts0EntityNavis;
begin
  Result := Ts0EntityNavis.Create(Self, Ts0EntityNavi);
end;

procedure Ts0Entity.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FNavigators <> nil then
    FNavigators.Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if FManager = AComponent then
    FManager := nil;
end;

procedure Ts0Entity.NotifyDestroy;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy.NotifyAll;
end;

procedure Ts0Entity.Remove;
begin
  FManager.Remove(Self);
end;

procedure Ts0Entity.Save;
begin
  FManager.Save(Self);
end;

procedure Ts0Entity.SetCaption(const Value: string);
begin
end;

procedure Ts0Entity.SetID(const Value: Integer);
begin
  DoChangeID;
end;

procedure Ts0Entity.SetManager(const Value: Ts0EntityManager);
begin
  FManager := Value;
end;

procedure Ts0Entity.SetNavigators(const Value: Ts0EntityNavis);
begin
  FNavigators.Assign(Value);
end;

function Ts0Entity.ShowDetail(const AModal: Boolean; AOrigin: TObject;
  AMode: K0DetailDisplayMode): Integer;
begin
  Result := 0;
  if Ts0EntityDisplay.Instance = nil then Exit;
  if AModal then
    Result := Ts0EntityDisplay.Instance.ShowDetailModal(Self, AOrigin, AMode)
  else
    Ts0EntityDisplay.Instance.ShowDetail(Self, AOrigin, AMode);
end;

class function Ts0Entity.ShowList(AClass: Ts0EntityClass; const AModal: Boolean;
  AOrigin: TObject): Integer;
begin
  Result := 0;
  if Ts0EntityDisplay.Instance = nil then Exit;
  if AModal then
    Result := Ts0EntityDisplay.Instance.ShowListModal(AClass, AOrigin)
  else
    Ts0EntityDisplay.Instance.ShowList(AClass, AOrigin);
end;

class function Ts0Entity.StrToEnumValue(APropName: string;
  const Value: string): Integer;
var
  mgr: Ts0EntityManager;
begin
  Result := -1;
  mgr := Ts0EntityManBroker.Instance.GetManagerByClass(Self);
  if mgr = nil then Exit;
  Result := mgr.StrToEnumValue(APropName, Value);
end;

procedure Ts0Entity.Update;
begin
  FManager.Update(Self);
end;

{ Ts0EntityList }

function Ts0EntityList.Add(AItem: Ts0Entity): Integer;
begin
  Result := inherited Add(AItem);
end;

function Ts0EntityList.First: Ts0Entity;
begin
  Result := Ts0Entity( inherited First );
end;

function Ts0EntityList.GetItems(Index: Integer): Ts0Entity;
begin
  Result := Ts0Entity( inherited Items[Index] );
end;

function Ts0EntityList.IndexOf(AItem: Ts0Entity): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure Ts0EntityList.Insert(Index: Integer;
  AItem: Ts0Entity);
begin
  inherited Insert(Index, AItem);
end;

function Ts0EntityList.Last: Ts0Entity;
begin
  Result := Ts0Entity( inherited Last );
end;

function Ts0EntityList.Remove(AItem: Ts0Entity): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure Ts0EntityList.SetItems(Index: Integer; AItem: Ts0Entity);
begin
  inherited Items[Index] := AItem;
end;

{ Ts0EntityNavi }

procedure Ts0EntityNavi.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is Ts0EntityNavi) then
    Exit;
  Self.Caption := Ts0EntityNavi(Source).Caption;
  Self.TargetClassID := Ts0EntityNavi(Source).TargetClassID;
  Self.TargetID := Ts0EntityNavi(Source).TargetID;
end;

function Ts0EntityNavi.CreateTarget(AOwner: TComponent; ALoadKinds:
  K0EntityAccessSet): Ts0Entity;
var
  cls: Ts0EntityClass;
begin
  Result := nil;
  cls := Ts0EntityRegister.GetEntityClass(FTargetClassID);
  if cls = nil then
    Exit;
  Result := Ts0Entity.NewEntity(cls);
  Self.TargetEty := Result;
  Result.ID := FTargetID;
  Result.Load;
end;

function Ts0EntityNavi.Equals(AItem: Ts0CollectionItem): Boolean;
begin
  Result := False;
  if not (AItem is Ts0EntityNavi) then
    Exit;
  if Self.Caption <> Ts0EntityNavi(AItem).Caption then
    Exit;
  if Self.TargetEty <> Ts0EntityNavi(AItem).TargetEty then
    Exit;
  if Self.TargetClassID <> Ts0EntityNavi(AItem).TargetClassID then
    Exit;
  if Self.TargetID <> Ts0EntityNavi(AItem).TargetID then
    Exit;
  Result := True;
end;

function Ts0EntityNavi.GetOwnerEntity: Ts0Entity;
begin
  Result := nil;
  if OwnerComponent is Ts0Entity then
    Result := Ts0Entity(OwnerComponent);
end;

function Ts0EntityNavi.GetTargetCaption: string;
begin
  if FTargetEty = nil then
    Result := FTargetCaption
  else
    Result := FTargetEty.Caption;
end;

function Ts0EntityNavi.GetTargetClass: Ts0EntityClass;
begin
  if FTargetEty = nil then
    Result := Ts0EntityRegister.GetEntityClass(FTargetClassID)
  else
    Result := FTargetEty.EntityClass;
end;

function Ts0EntityNavi.GetTargetClassID: Integer;
begin
  if FTargetEty = nil then
    Result := FTargetClassID
  else
    Result := FTargetEty.GetClassID;
end;

function Ts0EntityNavi.GetTargetID: Integer;
begin
  if FTargetEty = nil then
    Result := FTargetID
  else
    Result := FTargetEty.ID;
end;

procedure Ts0EntityNavi.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then
    Exit;
  if FTargetEty = AComponent then
    FTargetEty := nil;
end;

procedure Ts0EntityNavi.RestoreTarget;
var
  bufID: Integer;
  mgr: Ts0EntityManager;
begin
  if FTargetEty = nil then
  begin
    bufID := TargetID;
    try
      mgr := Ts0EntityManBroker.Instance.GetManagerByClass(TargetClass);
      if mgr = nil then Exit;
      FTargetEty := mgr.NewEntity;
    finally
      TargetID := bufID;
    end;
  end;
  if not FTargetEty.Restored then
  begin
    FTargetEty.ID := TargetID;
    FTargetEty.Load;
  end;
end;

procedure Ts0EntityNavi.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure Ts0EntityNavi.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure Ts0EntityNavi.SetTargetEty(const Value: Ts0Entity);
begin
  FTargetEty := Value;
end;

procedure Ts0EntityNavi.SetTargetCaption(const Value: string);
begin
  if FTargetEty = nil then
    FTargetCaption := Value
  else
    FTargetEty.Caption := Value;
end;

procedure Ts0EntityNavi.SetTargetClassID(const Value: Integer);
begin
  if FTargetEty = nil then
    FTargetClassID := Value
end;

procedure Ts0EntityNavi.SetTargetID(const Value: Integer);
begin
  if FTargetEty = nil then
    FTargetID := Value
  else
    FTargetEty.ID := Value;
end;

destructor Ts0EntityNavi.Destroy;
begin
  FreeAndNil(FTargetEty);
  inherited Destroy;
end;

function Ts0EntityNavi.ShowTargetDetail(AModal: Boolean; AOrigin: TObject;
  AMode: K0DetailDisplayMode = k0ddmReadOnly): Integer;
begin
  if (FTargetEty = nil) or (not FTargetEty.Restored) then
    RestoreTarget;
  Result :=  FTargetEty.ShowDetail(AModal, AOrigin, AMode);
end;

procedure Ts0EntityNavi.SetRelationType(const Value: K0NaviRelationType);
begin
  FRelationType := Value;
end;

{ Ts0EntityNavis }

function Ts0EntityNavis.AddByEntity(AEntity: Ts0Entity; ACaption: string): Ts0EntityNavi;
begin
  Result := Ts0EntityNavi(inherited Add);
  Result.TargetEty := AEntity;
  Result.Caption := ACaption;
end;

function Ts0EntityNavis.AddByID(AID, AClassID: Integer; AEntityCaption: string;
  ACaption: string): Ts0EntityNavi;
begin
  Result := Ts0EntityNavi(inherited Add);
  Result.TargetCaption := AEntityCaption;
  Result.TargetClassID := AClassID;
  Result.TargetID := AID;
  Result.Caption := ACaption;
end;

constructor Ts0EntityNavis.Create(AOwner: TPersistent;
  ItemClass: Ts0CollectionItemClass);
begin
  inherited;
  FOwnerEntity := nil;
  if AOwner is Ts0Entity then
    FOwnerEntity := Ts0Entity(AOwner);
end;

function Ts0EntityNavis.FindByCaption(ACaption: string): Ts0EntityNavi;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].Caption = ACaption then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0EntityNavis.FindByClass(AClass: Ts0EntityClass): Ts0EntityNavi;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].TargetClass = AClass then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0EntityNavis.GetItems(const Index: Integer): Ts0EntityNavi;
begin
  Result := Ts0EntityNavi(inherited Items[Index]);
end;

procedure Ts0EntityNavis.SetItems(const Index: Integer;
  const Value: Ts0EntityNavi);
begin
  inherited Items[Index] := Value;
end;

{ Ts0EntityDisplay }

resourcestring
  c9Caption_ReadOnly  = '書込み禁止';
  c9Caption_Edit      = '編集';
  c9Caption_NewEntity = '新規作成';

class function Ts0EntityDisplay.DispModeToStr(
  AMode: K0DetailDisplayMode): string;
const
  c9ModeStrArray: array[K0DetailDisplayMode] of string = (
    c9Caption_ReadOnly,
    c9Caption_Edit,
    c9Caption_NewEntity
    );
begin
  Result := '';
  if AMode < Low(c9ModeStrArray) then Exit;
  if AMode > High(c9ModeStrArray) then Exit;
  Result := c9ModeStrArray[AMode];
end;

var
  g9EntityDisplay: Ts0EntityDisplay = nil;
  g9EntityDisplayClass: Ts0EntityDisplayClass = Ts0EntityDisplay;

class function Ts0EntityDisplay.Instance: Ts0EntityDisplay;
begin
  if g9EntityDisplay = nil then
    if g9EntityDisplayClass <> nil then
      g9EntityDisplay := g9EntityDisplayClass.Create(nil);
  Result := g9EntityDisplay;
end;

class procedure Ts0EntityDisplay.RegisterEntityDisplayClass(
  AClass: Ts0EntityDisplayClass);
begin
  g9EntityDisplayClass := AClass;
end;

{ Ts0EntityManager }

constructor Ts0EntityManager.Create(AOwner: TComponent);
begin
  inherited;
  FActions := NewActions;
  FEntityList := Ts0EntityList.Create(False);
  FProtoTypes := Ts0EntityPropProtos.Create(Self, Ts0EntityPropProto);
  Ts0EntityManBroker.Instance.RegisterManager(Self);
end;

destructor Ts0EntityManager.Destroy;
begin
  Ts0EntityManBroker.Instance.UnRegisterManager(Self);
  FreeAndNil(FProtoTypes);
  if Assigned(FOnDestroy) then
    FOnDestroy.NotifyAll;
  FreeAndNil(FOnDestroy);
  FreeAndNil(FEntityList);
  FreeAndNil(FActions);
  inherited;
end;

procedure Ts0EntityManager.DoFreeEntity(AEntity: Ts0Entity);
begin
  if Assigned(FOnFreeEntity) then
    FOnFreeEntity(Self, AEntity);
end;

function Ts0EntityManager.EnumValueToStr(APropName: string;
  const Value: Integer): string;
var
  enumCol: Ts0EnumCollection;
begin
  Result := '';
  enumCol := Ts0EnumCollectionBroker.Instance.FindByName(APropName);
  if enumCol = nil then Exit;
  Result := enumCol.Items.TextByItemID(Value);
end;

function Ts0EntityManager.FindEntity(AID: Integer): Ts0Entity;
begin
  Result := nil;
end;

function Ts0EntityManager.GetEntityClass: Ts0EntityClass;
begin
  Result := Ts0EntityRegister.GetEntityClassByName(FEntityClassName);
end;

function Ts0EntityManager.GetOnDestroy: Ts0Event;
begin
  if FOnDestroy = nil then
    FOnDestroy := Ts0Event.Create(Self);
  Result := FOnDestroy;
end;

procedure Ts0EntityManager.Insert(AEntity: Ts0Entity);
begin
end;

procedure Ts0EntityManager.Load(AEntity: Ts0Entity);
begin
end;

procedure Ts0EntityManager.LoadKeyFromList(AEntity: Ts0Entity);
begin
end;

procedure Ts0EntityManager.LoadNaviKeyFromList(ANavi: Ts0EntityNavi);
begin
end;

function Ts0EntityManager.LocateEntityOnList(AEntityID: Integer;
  AOption: K0NotFoundOnListOption): Boolean;
begin
  Result := False;
end;

function Ts0EntityManager.NewActions: Ts0EntityActions;
begin
  Result := Ts0EntityActions.Create(Self, Ts0EntityAction);
end;

function Ts0EntityManager.NewEntity(AOwner: TComponent): Ts0Entity;
begin
  Result := nil;
  //if AOwner = nil then
  //  AOwner := Self;
  if EntityClass <> nil then
    Result := EntityClass.Create(AOwner);
  //RegisterNewEntity(Result);
end;

function Ts0EntityManager.NewIterator: Ts0EntityIterator;
begin
  Result := nil;
end;

procedure Ts0EntityManager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if AComponent is Ts0Entity then
    if FEntityList <> nil then
      FEntityList.Remove( Ts0Entity(AComponent) );
end;

procedure Ts0EntityManager.PrepareList;
begin
end;

procedure Ts0EntityManager.RefreshList;
begin
end;

procedure Ts0EntityManager.RegisterNewEntity(AEntity: Ts0Entity);
begin
  if AEntity = nil then
    Exit;
  if FEntityList.IndexOf(AEntity) > - 1 then
    Exit;
  if Assigned(FOnNewEntity) then
    FOnNewEntity(Self, AEntity);
  if AEntity.Manager <> Self then
    AEntity.Manager := Self;
  FEntityList.Add(AEntity);
end;

procedure Ts0EntityManager.Remove(AEntity: Ts0Entity);
begin
end;

procedure Ts0EntityManager.Save(AEntity: Ts0Entity);
begin
end;

var
  g9TestMode: Boolean = False;

resourcestring
  c9ErrMsg_UnRegisteredEntity = 'このエンティティは登録されていません: %s' +#13#10+
    'initialization部でRegisterEntity関数を用いてエンティティを登録してください。';

procedure Ts0EntityManager.SetActions(const Value: Ts0EntityActions);
begin
  FActions.Assign(Value);
end;

procedure Ts0EntityManager.SetEntityClassName(const Value: string);
begin
  if not(csDesigning in Self.ComponentState) then
  begin
    if not g9TestMode then
      if not Ts0EntityRegister.IsRegistered(Value) then
        raise Es0EntityManagerException.CreateFmt(c9ErrMsg_UnRegisteredEntity, [Value]);
  end;
  FEntityClassName := Value;
end;

procedure Ts0EntityManager.SetProtoTypes(const Value: Ts0EntityPropProtos);
begin
  FProtoTypes.Assign(Value);
end;

class procedure Ts0EntityManager.SetTestSwitch(Value: Boolean);
begin
  g9TestMode := Value;
end;

function Ts0EntityManager.StrToEnumValue(APropName: string;
  const Value: string): Integer;
var
  enumCol: Ts0EnumCollection;
begin
  Result := -1;
  enumCol := Ts0EnumCollectionBroker.Instance.FindByName(APropName);
  if enumCol = nil then Exit;
  Result := enumCol.Items.ItemIDByText(Value);
end;

procedure Ts0EntityManager.UnPrepareList;
begin
end;

procedure Ts0EntityManager.UnRegisterEntity(AEntity: Ts0Entity);
begin
  if FEntityList = nil then Exit;
  while FEntityList.Remove(AEntity) > -1 do ;
  DoFreeEntity(AEntity);
end;

procedure Ts0EntityManager.Update(AEntity: Ts0Entity);
begin
end;

{ Ts0EntityAction }

type
  K9EntityDefaultActionKind = (
    k0edakRefresh  ,
    k0edakSave     ,
    k0edakUpdate   ,
    k0edakRemove   ,
    k0edakNewEntity
  );
  K9EntityDefaultActionKindSet = set of K9EntityDefaultActionKind;

const
  c9DefaultMethods: array[K9EntityDefaultActionKind] of string = (
    'Load', 'Save', 'Update', 'Remove', ''
  );
  
function Ts0EntityAction.CallMethodByName(AEntity: Ts0Entity): Boolean;
  function CallAsPublic: Boolean;
  var
    i: K9EntityDefaultActionKind;
  begin
    Result := True;
    for i := Low(K9EntityDefaultActionKind) to High(K9EntityDefaultActionKind) do
    begin
      if not SameText(c9DefaultMethods[i], LinkMethod) then Continue;
      case i of
        k0edakRefresh  : AEntity.Load;
        k0edakSave     : AEntity.Save;
        k0edakUpdate   : AEntity.Update;
        k0edakRemove   : AEntity.Remove;
        k0edakNewEntity: Continue;
      end;
      Exit;
    end;
    Result := False;
  end;
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  Result := False;
  if LinkMethod = '' then Exit;
  Result := True;
  if CallAsPublic then Exit;
  Result := False;
  acsr := Ts0RTTIPublishedAccessor.Create(AEntity);
  try
    if acsr.RTTINavigator.MethodEnumerator.IndexOf(FLinkMethod) < 0 then Exit;
    acsr.ExecuteMethod(FLinkMethod);
    Result := True;
  finally
    FreeAndNil(AEntity);
  end;
end;

procedure Ts0EntityAction.Execute(AEntity: Ts0Entity);
begin
  Assert(AEntity <> nil);
  if Assigned(FBeforeExecute) then
    FBeforeExecute(Self, AEntity);
  if not CallMethodByName(AEntity) then
    if Assigned(FOnExecute) then
      FOnExecute(Self, AEntity);
  if Assigned(FAfterExecute) then
    FAfterExecute(Self, AEntity);
end;

procedure Ts0EntityAction.SetActionName(const Value: string);
begin
  FActionName := Value;
  Changed(False);
end;

procedure Ts0EntityAction.SetCaption(const Value: string);
begin
  FCaption := Value;
  Changed(False);
end;

procedure Ts0EntityAction.SetHint(const Value: string);
begin
  FHint := Value;
  Changed(False);
end;

procedure Ts0EntityAction.SetLinkMethod(const Value: string);
begin
  FLinkMethod := Value;
  Changed(False);
end;

{ Ts0EntityActions }

function Ts0EntityActions.Add: Ts0EntityAction;
begin
  Result := Ts0EntityAction(inherited Add);
end;

type
  R9DefaultActionData = packed record
    Name: string;
    Caption: string;
  end;

resourcestring
  c9ActCptn_Refresh   = '再読込み';
  c9ActCptn_Save      = '保存';
  c9ActCptn_Update    = '更新';
  c9ActCptn_Remove    = '削除';
  c9ActCptn_NewEntity = '新規作成';

const
  c9DefaultActions: array[K9EntityDefaultActionKind] of R9DefaultActionData = (
    (Name: 'Refresh'   ; Caption: c9ActCptn_Refresh  ),
    (Name: 'Save'      ; Caption: c9ActCptn_Save     ),
    (Name: 'Update'    ; Caption: c9ActCptn_Update   ),
    (Name: 'Remove'    ; Caption: c9ActCptn_Remove   ),
    (Name: 'NewEntity' ; Caption: c9ActCptn_NewEntity)
  );                               

procedure Ts0EntityActions.AddDefaultActions;
var
  i: K9EntityDefaultActionKind;
  act: Ts0EntityAction;
begin
  for i := Low(K9EntityDefaultActionKind) to High(K9EntityDefaultActionKind) do
  begin
    act := Add;
    act.ActionName := c9DefaultActions[i].Name;
    act.Caption    := c9DefaultActions[i].Caption;
    act.LinkMethod := c9DefaultMethods[i];
  end;
end;

function Ts0EntityActions.FindByName(AActionName: string): Ts0EntityAction;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if SameText(Result.ActionName, AActionName) then Exit;
  end;
  Result := nil;
end;

function Ts0EntityActions.GetItems(const Index: Integer): Ts0EntityAction;
begin
  Result := Ts0EntityAction(inherited Items[Index]);
end;

procedure Ts0EntityActions.SetItems(const Index: Integer;
  const Value: Ts0EntityAction);
begin
  inherited Items[Index] := Value;
end;

{ Ts0EntityCollectionItem }

procedure Ts0EntityCollectionItem.Assign(Source: TPersistent);
begin
  if Source is Ts0Entity then
    AssignFromEntity(Ts0Entity(Source))
  else
    inherited Assign(Source);
end;

procedure Ts0EntityCollectionItem.AssignByRTTI(Source, Dest: TObject);
var
  acsrSrc: Ts0RTTIPublishedAccessor;
  acsrDest: Ts0RTTIPublishedAccessor;
  i: Integer;
  props: Ts0RTTIProps;
  pn: string;
begin
  if Source = nil then Exit;
  if Dest = nil then Exit;
  acsrSrc := Ts0RTTIPublishedAccessor.Create(Source);
  try
    acsrDest := Ts0RTTIPublishedAccessor.Create(Dest);
    try
      props := acsrDest.RTTINavigator.Props;
      for i := 0 to props.Count -1 do
      begin
        pn := props.Props[i].PropName;
        if not acsrSrc.PropertyExists(pn) then Continue;
        if not acsrSrc.EnabledAsString(pn) then Continue;
        if not acsrDest.EnabledAsString(pn) then Continue;
        if acsrDest.PropTypeName(pn) <> acsrSrc.PropTypeName(pn) then Continue;
        if acsrDest.PropTypeKind(pn) <> acsrSrc.PropTypeKind(pn) then Continue;
        acsrDest.PropAsString[ pn ] := acsrSrc.PropAsString[ pn ];
      end;
    finally
      FreeAndNil(acsrDest);
    end;
  finally
    FreeAndNil(acsrSrc);
  end;
end;

procedure Ts0EntityCollectionItem.AssignFromEntity(AEntity: Ts0Entity);
begin
  AssignByRTTI(AEntity, Self);
  Self.Restored := AEntity.Restored;
end;

procedure Ts0EntityCollectionItem.AssignToEntity(AEntity: Ts0Entity);
begin
  AssignByRTTI(Self, AEntity);
  AEntity.Restored := Self.Restored;
end;

constructor Ts0EntityCollectionItem.Create(ACollection: TCollection);
begin
  inherited;
  FDeleted := False;
end;

function Ts0EntityCollectionItem.EntityClone: Ts0Entity;
begin
  Result := nil;
  if TargetEntityClass = nil then Exit;
  Result := TargetEntityClass.Create(nil);
  Self.AssignToEntity(Result);
end;

function Ts0EntityCollectionItem.GetOwnerID: Integer;
begin
  Result := 0;
  if OwnerComponent is Ts0Entity then
    Result := Ts0Entity(OwnerComponent).ID;
end;

procedure Ts0EntityCollectionItem.Save;
var
  ety: Ts0Entity;
begin
  ety := EntityClone;
  try
    if ety = nil then Exit;
    if Self.Deleted then
      ety.Remove
    else
      ety.Save;
  finally
    FreeAndNil(ety);
  end;
end;

procedure Ts0EntityCollectionItem.SetDeleted(const Value: Boolean);
begin
  FDeleted := Value;
  Changed(False);
end;

function Ts0EntityCollectionItem.TargetEntityClass: Ts0EntityClass;
begin
  Result := nil;
end;

{ Ts0EntityCollection }

function Ts0EntityCollection.Add: Ts0EntityCollectionItem;
begin
  Result := Ts0EntityCollectionItem(inherited Add);
end;

procedure Ts0EntityCollection.AssignFromList(Source: Ts0EntityList);
var
  i: Integer;
  obj: Ts0EntityCollectionItem;
begin
  Self.Clear;
  if Source = nil then Exit;
  for i := 0 to Source.Count -1 do
  begin
    obj := Self.Add;
    obj.AssignFromEntity(Source.Items[i]);
  end;
end;

procedure Ts0EntityCollection.AssignToList(Dest: Ts0EntityList);
var
  i: Integer;
begin
  if Dest = nil then Exit;
  Dest.Clear;
  for i := 0 to Self.Count -1 do
    Dest.Add( Self.Items[i].EntityClone );
end;

function Ts0EntityCollection.GetItems(
  const Index: Integer): Ts0EntityCollectionItem;
begin
  Result := Ts0EntityCollectionItem(inherited Items[Index]);
end;

procedure Ts0EntityCollection.SaveItems;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].Save;
end;

procedure Ts0EntityCollection.SetItems(const Index: Integer;
  const Value: Ts0EntityCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0EntityRegister }

var
  g9EtyClassList: TClassList = nil;

class function Ts0EntityRegister.GetEntityClass(
  AClassID: Integer): Ts0EntityClass;
var
  i: Integer;
  cls: Ts0EntityClass;
begin
  Result := nil;
  if g9EtyClassList = nil then
    Exit;
  for i := 0 to g9EtyClassList.Count - 1 do
  begin
    cls := Ts0EntityClass(g9EtyClassList.Items[i]);
    if cls.GetClassID = AClassID then
    begin
      Result := cls;
      Exit;
    end;
  end;
end;

class function Ts0EntityRegister.GetEntityClassByName(
  AClassName: string): Ts0EntityClass;
var
  i: Integer;
begin
  Result := nil;
  if g9EtyClassList = nil then
    Exit;
  for i := 0 to g9EtyClassList.Count - 1 do
  begin
    if not g9EtyClassList.Items[i].InheritsFrom(Ts0Entity) then Exit;
    if SameText(g9EtyClassList.Items[i].ClassName, AClassName) then
    begin
      Result := Ts0EntityClass(g9EtyClassList.Items[i]);
      Exit;
    end;
  end;
end;

class procedure Ts0EntityRegister.GetEntityNameList(Dest: TStrings);
var
  i: Integer;
begin
  Dest.Clear;
  if g9EtyClassList = nil then Exit;
  for i := 0 to g9EtyClassList.Count -1 do
    Dest.AddObject(
      g9EtyClassList.Items[i].ClassName,
      TObject(g9EtyClassList.Items[i])
    );
end;

class function Ts0EntityRegister.IsRegistered(AClassName: string): Boolean;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    GetEntityNameList(sl);
    sl.Text := UpperCase( sl.Text );
    Result := (sl.IndexOf(UpperCase(AClassName)) > -1);
  finally
    FreeAndNil(sl);
  end;
end;

class procedure Ts0EntityRegister.RegisterEntity(AClass: Ts0EntityClass);
begin
  if g9EtyClassList = nil then
    g9EtyClassList := TClassList.Create;
  if g9EtyClassList.IndexOf(AClass) > -1 then
    Exit;
  RegisterClass(AClass);
  g9EtyClassList.Add(AClass);
end;

class procedure Ts0EntityRegister.UnRegisterEntity(AClass: Ts0EntityClass);
begin
  if g9EtyClassList = nil then Exit;
  while g9EtyClassList.Remove(AClass) > -1 do ;
end;

{ Ts0AbstractEntityManBroker }

constructor Ts0AbstractEntityManBroker.Create;
begin
  inherited Create;
end;

function Ts0AbstractEntityManBroker.GetManagerByClassName(
  AEntityClassName: String): Ts0EntityManager;
var
  cls: TPersistentClass;
begin
  Result := nil;
  cls := GetClass(AEntityClassName);
  if cls = nil then Exit;
  if not cls.InheritsFrom(Ts0Entity) then Exit;
  Result := GetManagerByClass(Ts0EntityClass(cls));
end;

var
  g9EntityManBrokerClass: Ts0AbstractEntityManBrokerClass = Ts0EntityManBroker;
  g9EntityManBroker: Ts0AbstractEntityManBroker = nil;

class function Ts0AbstractEntityManBroker.Instance: Ts0AbstractEntityManBroker;
begin
  if g9EntityManBroker = nil then
    g9EntityManBroker := g9EntityManBrokerClass.Create;
  Result := g9EntityManBroker;
end;

class procedure Ts0AbstractEntityManBroker.RegisterBrokerClass(
  AClass: Ts0AbstractEntityManBrokerClass);
begin
  Assert(AClass <> nil);
  g9EntityManBrokerClass := AClass;
end;

{ Ts0EntityManBroker }

constructor Ts0EntityManBroker.Create;
begin
  inherited Create;
  FEtyManList := TObjectList.Create(False);
end;

destructor Ts0EntityManBroker.Destroy;
begin
  FreeAndNil(FEtyManList);
  inherited;
end;

function Ts0EntityManBroker.GetManagerByClass(
  AClass: Ts0EntityClass): Ts0EntityManager;
var
  i: Integer;
begin
  Result := nil;
  if FEtyManList= nil then Exit;
  for i := 0 to FEtyManList.Count -1 do
    if Ts0EntityManager(FEtyManList.Items[i]).EntityClass = AClass then
    begin
      Result := Ts0EntityManager(FEtyManList.Items[i]);
      Exit;
    end;
end;

function Ts0EntityManBroker.GetManagerByClassID(
  AEntityClassID: Integer): Ts0EntityManager;
var
  i: Integer;
  etyClass: Ts0EntityClass;
begin
  Result := nil;
  if FEtyManList= nil then Exit;
  for i := 0 to FEtyManList.Count -1 do
  begin
    etyClass := Ts0EntityManager(FEtyManList.Items[i]).EntityClass;
    if etyClass = nil then Continue;
    if etyClass.GetClassID <> AEntityClassID then Continue;
    Result := Ts0EntityManager(FEtyManList.Items[i]);
    Exit;
  end;
end;

resourcestring
  c9ErrMsg_CouldNotResponseOfDemand = '要求に合うマネージャを取得できませんでした。[%s]';

function Ts0EntityManBroker.GetManagerByClassName(
  AEntityClassName: String): Ts0EntityManager;
var
  i: Integer;
begin
  Result := inherited GetManagerByClassName(AEntityClassName);
  if Result <> nil then Exit;
  if FEtyManList= nil then Exit;
  for i := 0 to FEtyManList.Count -1 do
  begin
    Result := Ts0EntityManager(FEtyManList.Items[i]);
    if not SameText(Result.EntityClassName, AEntityClassName) then Continue;
    Exit;
  end;
end;

function Ts0EntityManBroker.NeedManager(
  AClass: Ts0EntityClass): Ts0EntityManager;
begin
  Result := GetManagerByClass(AClass);
  if Result <> nil then Exit;
  raise Es0EntityManBroker.CreateFmt(c9ErrMsg_CouldNotResponseOfDemand, [AClass.ClassName]);
end;

procedure Ts0EntityManBroker.RegisterManager(AEntityMan: Ts0EntityManager);
begin
  if FEtyManList.IndexOf(AEntityMan) > -1 then Exit;
  FEtyManList.Add(AEntityMan);
end;

procedure Ts0EntityManBroker.UnRegisterManager(
  AEntityMan: Ts0EntityManager);
begin
  while FEtyManList.Remove(AEntityMan) > -1 do ;
end;

initialization

finalization
  FreeAndNil(g9EtyClassList);
  FreeAndNil(g9EntityManBroker);
  FreeAndNil(g9EntityDisplay);

end.

