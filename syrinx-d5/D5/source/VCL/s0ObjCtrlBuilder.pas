unit s0ObjCtrlBuilder;
{
$History: s0ObjCtrlBuilder.pas $
 * 
 * *****************  Version 47  *****************
 * User: Akima        Date: 02/05/15   Time: 17:12
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 46  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 45  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 44  *****************
 * User: Akima        Date: 02/03/15   Time: 11:39
 * Updated in $/D5/source/VCL
 * ラベルのCaptionが正しく設定されていなかった。
 * 
 * *****************  Version 43  *****************
 * User: Akima        Date: 02/03/11   Time: 20:30
 * Updated in $/D6/source/VCL
 * BuildCtrls、ClearCtrlsをvirtualに
 * 
 * *****************  Version 42  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 41  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 40  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 39  *****************
 * User: Akima        Date: 02/02/22   Time: 0:49
 * Updated in $/source/D5Integrated
 * CtrlOfTypeをpublicに変更
 * 
 * *****************  Version 38  *****************
 * User: Akima        Date: 02/02/21   Time: 23:23
 * Updated in $/source/D5Integrated
 * LoadedでLoadFromTargetをするように変更。
 * Ts0ObjCtrlBridge.MakeDefualtProtoTypesでの余計な処理を削除。
 * 
 * *****************  Version 37  *****************
 * User: Akima        Date: 02/02/13   Time: 21:09
 * Updated in $/source/D5Integrated
 * Ts0ProtoTypeCtrl.Assignを修正。
 * Ts0ProtoTypeCtrls.Assigで、ProtoSourceを設定するように変更。
 * GetCtrlOfTypeClassNameを変更。
 * 
 * *****************  Version 36  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCaseを使用して文字列の比較を行っていた部分をSameTextを使用するよう
 * に修正
 * 
 * *****************  Version 35  *****************
 * User: Akima        Date: 02/02/06   Time: 4:42
 * Updated in $/source/D5Integrated
 * DisabledPropsプロパティを追加。このプロパティには、ProtoTypesの生成の対
 * 象外となるプロパティの名前を指定することができる。
 * 
 * *****************  Version 34  *****************
 * User: Akima        Date: 02/02/06   Time: 1:04
 * Updated in $/source/D5Integrated
 * AutoUpdateプロパティのデフォルト値をTrueに。
 * Ts0ProtoTypeCtrl.SetCtrlメソッドでの不要で間違っている処理を修正。
 * 
 * *****************  Version 33  *****************
 * User: Akima        Date: 02/01/10   Time: 3:15
 * Updated in $/source/D5Integrated
 * publishedなTargetComponentプロパティを追加。
 * BuilderにActiveプロパティを追加。これをTrueにするとBuilder.Executeされ
 * る。
 * GetCtrlOfTypeClass、RegisterCtrlOfTypeはTs0CtrlOfTypeに移動。
 * 
 * *****************  Version 32  *****************
 * User: Akima        Date: 02/01/06   Time: 0:21
 * Updated in $/source/D5Integrated
 * CtrlOfTypeClassNameプロパティを追加
 * 
 * *****************  Version 31  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 29  *****************
 * User: Akima        Date: 01/12/15   Time: 23:30
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 01/12/15   Time: 2:05
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 27  *****************
 * User: Akima        Date: 01/12/13   Time: 18:01
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessorを作成。
 * Ts0StringsAccessorはTs0EnumCollectionを使用する。
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 01/11/28   Time: 1:57
 * Updated in $/source/D5Integrated
 * s0PropertyProtoTypeの変更に伴い修正。
 * これでEntityManagerでデータが修正されても自動的にフォームに反映されるっ
 * す。
 * 
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 01/11/23   Time: 1:59
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridgeにAutoUpdateプロパティを追加した。これをTrueにすると
 * SaveToTargetメソッドを呼ばなくても自動的に入力された内容が反映される。
 * それに伴い、Ts0ProtoTypeCtrlが不要なデータの書き換えを起こさないように
 * LoadFromTarget、SaveToTargetメソッドで新たに追加したModifiedをチェック
 * する
 * ようにした。
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/10/11   Time: 17:23
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridge.OnSaveToCtrlとOnLoadFromCtrlを
 * OnSaveObjToCtrlとOnLoadObjFromCtrlに名称変更。
 * Ts0ProtoTypeCtrlにOnLoadFromTarget、OnSaveToTargetイベントを追加。
 *
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/10/09   Time: 9:09
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/10/05   Time: 16:54
 * Updated in $/source/D5Integrated
 * 対応するコントロールをRegisterClassするように修正
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/10/05   Time: 14:19
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/10/05   Time: 13:05
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/10/04   Time: 21:08
 * Updated in $/source/D5Integrated
 * 生成したコントロールにPrefixとプロパティ名からなるNameプロパティを設定
 * する。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/10/04   Time: 12:25
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/10/03   Time: 23:49
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/03   Time: 0:25
 * Updated in $/source/D5Integrated
 * ClearCtrlsメソッドなどを追加。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/02   Time: 3:17
 * Updated in $/source/D5Integrated
 * MakeDefualtProtoTypesメソッドで、IsEnum、IsSet、IsPersistent、
 * EnumMemberプロパティを設定するようにした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/01   Time: 17:37
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/01   Time: 9:12
 * Updated in $/source/D5Integrated
 * BuilderとBridgeの役割を明確化している最中。リファクタリング中。
 *
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/25   Time: 10:08
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridgeを使用時にクライアント側で細かい制御ができるように
 * イベントを追加
 *
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/23   Time: 1:09
 * Updated in $/source/D5Integrated
 * ProtoTypesプロパティに項目が無いときに、Targetが指定されたら
 * デフォルトの項目を作成するMakeDefualtProtoTypesを作成。
 *
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/21   Time: 17:02
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBuilderにクラス名を変更
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/21   Time: 16:25
 * Updated in $/source/D5Integrated
 * ユニット名を変更した。
 * Entityに依存しないクラスです。
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/21   Time: 16:22
 * Updated in $/source/D5Integrated
 * LoadFromTarget、SaveToTargetメソッドをTs0ProtoTypeCtrlに実装した。
}

interface

uses
  SysUtils, Classes,
  Controls,
  StdCtrls,
  Contnrs,
  TypInfo,
  s0VCLClasses,
  s0Persistent,
  s0TypInfoWrapper,
  s0CommonTypes,
  s0Collection,
  s0CtrlDistiller,
  s0CtrlEventSnatcher,
  s0PropertyProtoType,
  s0CtrlOfType,
  s0InputStyle,
  s0DataAccessor,

  s0Bounds,
  s0Classes,
  s0Iterator,

  s0BoundsLayout,
  s0StringValidater;

type
  {
    Ts0ProtoTypeCtrlクラスのCtrlBoundsプロパティのためのクラス。
  }
  Ts0PTCBounds = class(Ts0Bounds)
  private
    FLinking: Boolean;
    procedure SetLinking(const Value: Boolean);
    function GetRealCtrl: TControl;
    function GetRealLabel: TCustomLabel;
  protected
    procedure SetBoundsOfCtrl;
    property RealCtrl: TControl read GetRealCtrl;
    property RealLabel: TCustomLabel read GetRealLabel;
  public
    constructor Create(AOwner: TPersistent); override;
  published
    function GetValue(const AKind: Ks0BoundsItemKind): Integer; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Linking: Boolean read FLinking write SetLinking default True;
  end;

type
  Ts0ProtoTypeCtrl = class;

  K0ProtoTypeCtrlEvent = procedure(Sender: Ts0ProtoTypeCtrl) of object;
  K0PTCOption = (k0ptcoAutoChangeCtrlClassName);
  K0PTCOptions = set of K0PTCOption;

  {
    Ts0ObjCtrlBridgeコンポーネントが動作する際の、Targetプロパティが参照する
    各プロパティと、各コントロールの橋渡しをするためのクラス。
  }
  Ts0ProtoTypeCtrl = class(Ts0PropertyProtoType, Is0Bounds, Is0Identified)
  private
    FAccessor: Ts0DataAccessor;
    FCtrl: TControl;
    FCtrlLabel: TCustomLabel;
    FEnumAsString: Boolean;
    FCtrlParent: TWinControl;
    FOnLoadFromTarget: K0ProtoTypeCtrlEvent;
    FOnSaveToTarget: K0ProtoTypeCtrlEvent;
    FCtrlListener: Ts0CtrlEventListener;
    FAutoUpdateKinds: K0CtrlEventTypeSet;
    FRTTIProp: Ts0RTTIProp;
    FCtrlClassName: string;
    FOptions: K0PTCOptions;
    FCtrlBounds: Ts0PTCBounds;
    FIntfBounds: Is0Bounds;
    procedure SetCtrl(const Value: TControl);
    function GetAccessor: Ts0DataAccessor;
    procedure SetCtrlLabel(const Value: TCustomLabel);
    procedure SetCtrlParent(const Value: TWinControl);
    procedure SetAutoUpdateKinds(const Value: K0CtrlEventTypeSet);
    function GetSnatched: Boolean;
    function GetModified: Boolean;
    procedure SetCtrlClassName(const Value: string);
    procedure SetOptions(const Value: K0PTCOptions);
    procedure SetCtrlBounds(Value: Ts0PTCBounds);
  protected
    procedure DoLoadFromTarget;
    procedure DoSaveToTarget;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetWapper: Ts0RTTIPublishedAccessor; override;
    procedure SetAcceptCharTypes(const Value: K1InpCharSet); override;
    procedure SetImeModeSX(const Value: K0ImeMode); override;
    procedure SetPropertyName(const Value: string); override;
    procedure ResetCtrlProp;
  protected
    procedure SetEnumName(const Value: string); override;
    procedure SetIsEnum(const Value: Boolean); override;
    procedure SetIsPersistent(const Value: Boolean); override;
    procedure SetIsSet(const Value: Boolean); override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    {
      Ctrlプロパティで表される関連するコントロールを破棄するメソッド。
    }
    procedure FreeCtrl;
    {
      生成したコントロールを初期化する。
      実際には、関連するLabelのCaptionやIMEModeやMaxLengthプロパティなどを
      設定する。
    }
    procedure InitCtrl; virtual;
    {
      対応するプロパティの値を取得し、コントロールに反映するメソッド。
    }
    procedure LoadFromTarget; virtual;
    {
      コントロールから値を取得し、対応するプロパティの値に設定するメソッド。
    }
    procedure SaveToTarget; virtual;
    property Accessor: Ts0DataAccessor read GetAccessor;
    {
      コントロールに入力されている値と、対応するプロパティの値が違っているか
      どうかを示すプロパティ。
    }
    property Modified: Boolean read GetModified;
  protected
    procedure SetUpdating(const Value: Boolean);
    procedure ValidateCtrlClassName; virtual;
  public
    {
      ImeModeSXプロパティ(K0ImeMode型)の値をTImeMode型に変換するメソッド。
    }
    function GetImeMode: TImeMode;
    {
      コントロールを生成する際に呼び出される、コントロールを生成する必要が
      あるかどうかを示すメソッド。
    }
    function NeedCtrl: Boolean;
    {
      コントロールのイベントをフックするメソッド。
      フックすることでコントロールのイベントによってこのクラスは動作を行います。
      このメソッドによってSnatchedプロパティはTrueに設定されます。
    }
    procedure SnatchEvents;
    {
      コントロールのイベントのフックを解除するメソッド。
      このメソッドによってSnatchedプロパティはFalseに設定されます。
    }
    procedure PutBackEvents;
    {
      コントロールのイベントをフックしているかどうかを示すプロパティ。
      SnatchEvents、PutBackEventsによって値は変更されます。
    }
    property Snatched: Boolean read GetSnatched;
    { Is0Bounds }
    {
      CtrlBoundsプロパティをIs0Boundsとして取得するためのプロパティ。
    }
    property IntfBounds: Is0Bounds read FIntfBounds implements Is0Bounds;
  published
    {
      K0CtrlEventType = (k0cetOnExit, k0cetOnClick, k0cetOnPressEnter, k0cetOnKeyUp, k0cetOnChange);
      K0CtrlEventTypeSet = set of K0CtrlEventType;
      
      フックしたコントロールのどのイベントによって変更されたと見なすかを
      しめすプロパティ。
    }
    property AutoUpdateKinds: K0CtrlEventTypeSet read FAutoUpdateKinds write SetAutoUpdateKinds default [];
    {
      関連付けられているコントロールを示すプロパティ。
      設計時に設定することも可能。
    }
    property Ctrl: TControl read FCtrl write SetCtrl;
    {
      コントロールを生成するときに、コントロールのLeft, Top, Width, Height
      プロパティを設定するためのプロパティ。
      Ts0PTCBoundsクラスを参照。
    }
    property CtrlBounds: Ts0PTCBounds read FCtrlBounds write SetCtrlBounds;
    {
      コントロールを生成する際に、どのクラスのコントロールを生成するのかを
      指定するプロパティ。設計時にCtrlプロパティを設定した場合には、設定する
      必要はありません。
    }
    property CtrlClassName: string read FCtrlClassName write SetCtrlClassName;
    {
      関連付けられたコントロールに対応するラベルを指定できるプロパティ。
    }
    property CtrlLabel: TCustomLabel read FCtrlLabel write SetCtrlLabel;
    {
      コントロールが生成される際に、どのコントロールをParentとして生成するのかを
      指定するプロパティ。デフォルトでは、Ts0ObjCtrlBridge.Builder.CtrlParent
      プロパティで指定されたコントロールが設定される。
    }
    property CtrlParent: TWinControl read FCtrlParent write SetCtrlParent;
    {
      対応するプロパティの型が列挙型であった場合に、プロパティに対して
      値を設定するときに、文字列として設定するのか、本来の列挙型として設定する
      のかを指定するプロパティ。
      基本的に変更する必要はありません。
    }
    property EnumAsString: Boolean read FEnumAsString write FEnumAsString;
    {
      Ts0ObjCtrlBridge.LoadFromTargetメソッドが実行されたときに、
      各ProtoTypesの各項目ごとに呼び出されるイベント。
    }
    property OnLoadFromTarget: K0ProtoTypeCtrlEvent read FOnLoadFromTarget write FOnLoadFromTarget;
    {
      Ts0ObjCtrlBridge.SaveToTargetメソッドが実行されたときに、
      各ProtoTypesの各項目ごとに呼び出されるイベント。
    }
    property OnSaveToTarget: K0ProtoTypeCtrlEvent read FOnSaveToTarget write FOnSaveToTarget;
    {
      K0PTCOption = (k0ptcoAutoChangeCtrlClassName);
      K0PTCOptions = set of K0PTCOption;

      Ts0ProtoTypeCtrlの振る舞いを指定するオプションを表すプロパティ。

      k0ptcoAutoChangeCtrlClassName
        IsEnumプロパティなどによって、生成されるべきコントロールのクラスが
        変更されるべき場合に、自動的に変更するかどうかを示します。
    }
    property Options: K0PTCOptions read FOptions write SetOptions default [k0ptcoAutoChangeCtrlClassName];
  end;

type
  Ts0ProtoTypeCtrls = class(Ts0PropertyProtoTypes)
  private
    function GetPropCtrls(const Index: Integer): Ts0ProtoTypeCtrl;
    procedure SetPropCtrls(const Index: Integer;
      const Value: Ts0ProtoTypeCtrl);
  protected
    function GetOriginal: Ts0PropertyProtoTypes; override;
    procedure SetOriginal(const Value: Ts0PropertyProtoTypes); override;
    procedure NotifyOriginalUpdate(AItem: Ts0PropertyProtoType); override;
  public
    constructor Create(AOwner: TPersistent; AItemClass: Ts0CollectionItemClass); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IndexOfProp(APropName: string): Integer;
    function FindPropCtrls(const APropName: string): Ts0ProtoTypeCtrl;
    property PropCtrls[const Index: Integer]: Ts0ProtoTypeCtrl read GetPropCtrls write SetPropCtrls;
  end;

type
  K0ECBFindCtrlClassEvent = procedure(Sender: TObject; AProp: Ts0ProtoTypeCtrl;
    var ACtrlClass: TControlClass) of object;

  K0ECBCreateCtrlEvent = procedure(Sender: TObject; AProp: Ts0ProtoTypeCtrl;
    AControl: TControl) of object;

type
  {
    コントロールを生成する際に、コントロールのNameプロパティにどのような
    接頭辞をつけるのかを指定するためのクラス。
    接頭辞を指定する単位はクラス毎。
    PartOfCtrlClassNameプロパティが対象となるコントロールのクラス、
    Prefixプロパティが設定される接頭辞を示します。
  }
  Ts0CtrlNamePrefix = class(Ts0VCLCollectionItem)
  private
    FPrefix: string;
    FPartOfCtrlClassName: string;
    procedure SetPartOfCtrlClassName(const Value: string);
    procedure SetPrefix(const Value: string);
  published
    property PartOfCtrlClassName: string read FPartOfCtrlClassName write SetPartOfCtrlClassName;
    property Prefix: string read FPrefix write SetPrefix;
  end;

type
  Ts0CtrlNamePrefixes = class(Ts0VCLCollection)
  private
    function GetPrefixes(const Index: Integer): Ts0CtrlNamePrefix;
    procedure SetPrefixes(const Index: Integer;
      const Value: Ts0CtrlNamePrefix);
  public
    function Add(APartOfCtrl: string; APrefix: string): Ts0CtrlNamePrefix;
    property Prefixes[const Index: Integer]: Ts0CtrlNamePrefix read GetPrefixes write SetPrefixes; default;
  end;

type
  Ts0ObjCtrlBridge = class;

  Ts0ObjCtrlBuilder = class(Ts0VCLPersistent)
  private
    FCtrlParent: TWinControl;
    FCtrlOwner: TComponent;
    FCtrlMargin: Integer;
    FCtrlPrefixes: Ts0CtrlNamePrefixes;
    FCtrlOfType: Ts0CtrlOfType;
    FActive: Boolean;
    FLabelBreath: Integer;
    FDefaultCtrlWidth: Integer;
    FDefaultCtrlHeight: Integer;
    procedure SetCtrlParent(const Value: TWinControl);
    procedure SetCtrlOwner(const Value: TComponent);
    procedure SetCtrlPrefixes(const Value: Ts0CtrlNamePrefixes);
    function GetProtoTypes: Ts0ProtoTypeCtrls;
    function GetWrapper: Ts0RTTIPublishedAccessor;
    procedure SetCtrlOfType(const Value: Ts0CtrlOfType);
    function GetCtrlOfTypeClassName: string;
    procedure SetCtrlOfTypeClassName(const Value: string);
    procedure SetActive(const Value: Boolean);
    function GetCtrlOfType: Ts0CtrlOfType;
    procedure SetLabelBreath(const Value: Integer);
  protected
    function CreateCtrlOf(AProp: Ts0ProtoTypeCtrl): TControl; virtual;
    function CreateCtrlImpl(ACtrlClass: TControlClass; AProp: Ts0ProtoTypeCtrl): TControl;
    procedure DoBeforeBuild;
    procedure DoAfterBuild;
    procedure DoCreateCtrl(AProp: Ts0ProtoTypeCtrl; AControl: TControl);
    procedure DoInitCtrl(AProp: Ts0ProtoTypeCtrl; AControl: TControl);
    procedure DoFindCtrlClass(AProp: Ts0ProtoTypeCtrl; var ACtrlClass: TControlClass); virtual;
    function GetOwnerBridge: Ts0ObjCtrlBridge;
    function GetPrefixByClassName(AClassName: string): string;
    procedure InitCtrlPrefixes;
    function NewCtrlOfType: Ts0CtrlOfType; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    {
      Ts0ObjCtrlBridge.ProtoTypesプロパティを元に、コントロールの生成を
      実行するメソッド。通常、このメソッドを使用せずに、
      Ts0ObjCtrlBridge.BuildCtrlsメソッドを使用してください。
    }
    procedure Execute;
    {
      コンポーネントの破棄の通知を受けるメソッド。
      通常このメソッドを、呼び出すことはありません。
    }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {
      Ts0ObjCtrlBridge.Wrapperプロパティで示されるTs0RTTIPublishedAccessor
      を参照するプロパティ。
    }
    property Wrapper: Ts0RTTIPublishedAccessor read GetWrapper;
    {
      Ts0ObjCtrlBridge.ProtoTypesプロパティを参照するプロパティ。
    }
    property ProtoTypes: Ts0ProtoTypeCtrls read GetProtoTypes;
    {
      コントロールを生成する際に、プロパティの型などに対してどのクラスの
      コントロールを設定するのかを判断するためのオブジェクト。
      CtrlOfTypeClassNameプロパティによって、どのTs0CtrlOfTypeクラスを使用する
      のかが指定できます。
    }
    property CtrlOfType: Ts0CtrlOfType read GetCtrlOfType write SetCtrlOfType;
  published
    {
      設計時にExecuteメソッドを呼び出すためのプロパティ。
      Trueを設定するとExecuteメソッドが実行されます。
    }
    property Active: Boolean read FActive write SetActive stored False;
    {
      コントロールの整列を行う際に、コントロール間の間隔を何ピクセルに
      するのかを指定するプロパティ
    }
    property CtrlMargin: Integer read FCtrlMargin write FCtrlMargin default 4;
    {
      コントロールの生成を行う際に、コントロールのOwnerをどのコンポーネント
      にするのかを指定できるプロパティ。
      通常指定する必要はありません。
    }
    property CtrlOwner: TComponent read FCtrlOwner write SetCtrlOwner;
    {
      コントロールの生成を行う際に、コントロールのParentをどのコンポーネント
      にするのかを指定するプロパティ。
      コントロールごとにParentを指定する場合にはTs0ObjCtrlBridge.ProtoTypesの
      各項目のCtrlParentプロパティで指定することができます。
    }
    property CtrlParent: TWinControl read FCtrlParent write SetCtrlParent;
    {
      コントロールを生成する際に、コントロールのNameプロパティにどのような
      接頭辞をつけるのかを指定するためのオブジェクト。
      Ts0CtrlNamePrefixesクラスを参照。
    }
    property CtrlPrefixes: Ts0CtrlNamePrefixes read FCtrlPrefixes write SetCtrlPrefixes;
    {
      CtrlOfTypeプロパティが示すオブジェクトとして、どのクラスを使用するのかを
      示すプロパティ。Ts0CtrlOfTypeの派生クラスの名前を指定する。
    }
    property CtrlOfTypeClassName: string read GetCtrlOfTypeClassName write SetCtrlOfTypeClassName;
    {
      生成するコントロールのデフォルトのWidthを指定できるプロパティ。
      各コントロールのWidthは生成される際のデフォルトの値が使用されるが、
      それを設定できない場合、あるいは生成コントロールのクラスが未指定
      の場合には、このプロパティが示す値が使用される。
    }
    property DefaultCtrlWidth: Integer read FDefaultCtrlWidth write FDefaultCtrlWidth default 300;
    {
      生成するコントロールのデフォルトのHeightを指定できるプロパティ。
      各コントロールのHeightは生成される際のデフォルトの値が使用されるが、
      それを設定できない場合、あるいは生成コントロールのクラスが未指定
      の場合には、このプロパティが示す値が使用される。
    }
    property DefaultCtrlHeight: Integer read FDefaultCtrlHeight write FDefaultCtrlHeight default 24;
    {
      コントロールを生成する際に、ラベルの幅あるいは高さを何ピクセル確保
      するのかを指定する。
    }
    property LabelBreath: Integer read FLabelBreath write SetLabelBreath default 100;
  end;

  K0ObjAccessEvent = procedure(Sender: TObject; AObj: TObject; ACtrl: TControl) of object;

  {
    Targetプロパティで指定されたオブジェクトのpublishedプロパティの値を
    フォーム上などのコントロールに設定し、入六された値をオブジェクトに設定
    させるためのコンポーネントです。

    Targetプロパティを設定すると、そのオブジェクトの各publishedプロパティに
    対応するデータがProtoTypesプロパティの項目として生成されます。
    ProtoTypesプロパティの各項目は、コントロールとの関連を保持します。

    コントロールは、ProtoTypesプロパティの各項目を元に、BuildCtrlsメソッドなど
    により生成されます。
    BuilderプロパティのCtrlParentプロパティを設定しておく必要もあります。

    Targetプロパティで指定されるオブジェクトの各プロパティと、それに対応する
    (ProtoTypesプロパティの各項目)のコントロールとのデータのやり取りは、
    LoadFromTarget、SaveToTargetメソッドなどで行われますが、AutoUpdateプロパティ
    がTrueならば自動的にそれらが行われます。
  }
  Ts0ObjCtrlBridge = class(Ts0VCLComponent)
  private
    FBuilder: Ts0ObjCtrlBuilder;
    FTarget: TObject;
    FProtoTypes: Ts0ProtoTypeCtrls;
    FWrapper: Ts0RTTIPublishedAccessor;
    FOnLoadObjFromCtrl: K0ObjAccessEvent;
    FOnSaveObjToCtrl: K0ObjAccessEvent;
    FAutoUpdate: Boolean;
    FProtoSourcePropName: string;
    FProtoSourceCompo: TComponent;
    FOnInitCtrl: K0ECBCreateCtrlEvent;
    FOnStandInCtrls: TNotifyEvent;
    FDisabledProps: TStrings;
    FLayoutSet: Ts0LayoutSet;
    FAfterBuild: TNotifyEvent;
    FBeforeBuild: TNotifyEvent;
    procedure SetProtoTypes(const Value: Ts0ProtoTypeCtrls);
    procedure SetBuilder(const Value: Ts0ObjCtrlBuilder);
    procedure SetAutoUpdate(const Value: Boolean);
    function GetProtoSource: Ts0PropertyProtoTypes;
    procedure SetProtoSource(const Value: Ts0PropertyProtoTypes);
    procedure SetTargetComponent(const Value: TComponent);
    function GetTargetComponent: TComponent;
    procedure SetDisabledProps(const Value: TStrings);
    procedure SetLayoutSet(const Value: Ts0LayoutSet);
  private
    { Is0Aggregate }
    //FAggregate: Is0Aggregate;
  private
    { Builder Event }
    FOnCreateCtrl: K0ECBCreateCtrlEvent;
    FOnFindCtrlClass: K0ECBFindCtrlClassEvent;
  protected
    procedure DoLoadObjFromCtrl(AObj: TObject; ACtrl: TControl);
    procedure DoSaveObjToCtrl(AObj: TObject; ACtrl: TControl);
    function GetCtrlClassNameByProp(AProto: Ts0ProtoTypeCtrl): String; virtual;
    procedure InitProtoCtrl(AProto: Ts0ProtoTypeCtrl);
    procedure MakeDefualtProtoTypes;
    function NewBuilder: Ts0ObjCtrlBuilder; virtual;
    function NewProtoTypes: Ts0ProtoTypeCtrls; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetTarget(const Value: TObject); virtual;
    procedure Loaded; override;
  protected
    procedure BeginUpdate;
    procedure EndUpdate;
    property ProtoSource: Ts0PropertyProtoTypes read GetProtoSource write SetProtoSource;
    //
    procedure DoStandInCtrls;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {
      ProtoTypesプロパティの各項目を元に、コントロールを生成する。
    }
    procedure BuildCtrls; virtual;
    {
      ProtoTypesプロパティの各項目に関連付けられたコントロールを破棄する。
    }
    procedure ClearCtrls; virtual;
    {
      Targetプロパティで指定されたオブジェクトの各プロパティのうち、
      ProtoTypesプロパティに登録されているものについて、プロパティの
      値を関連連れられているコントロールに設定する。
      実際には、ProtoTypesの各項目のLoadFromTargetメソッドが実行される。
    }
    procedure LoadFromTarget; virtual;
    {
      Targetプロパティで指定されたオブジェクトの各プロパティのうち、
      ProtoTypesプロパティに登録されているものについて、そのプロパティに
      大して関連連れられているコントロールの値を設定する。
      実際には、ProtoTypesの各項目のSaveToTargetメソッドが実行される。
    }
    procedure SaveToTarget; virtual;
    {
      ProtoTypesの各項目の表示上の位置を整える。
      実際にはProtoTypesの各項目のBoundsプロパティに値を設定する。
      Builder.LabelBreathプロパティ、Builder.CtrlMarginプロパティも参照。
    }
    procedure StandInCtrls; virtual;
    {

    }
    procedure ApplyCtrlClassNames; virtual;
    {
      データを表示/設定する対象となるオブジェクトを設定する。
      このコンポーネントを使用する際には必ずこのプロパティを設定しなければ
      なりません。
      このプロパティに対してnil以外の値を設定したとき、ProtoTypesに項目が一つも
      設定されていないのであれば、Targetで指定されたオブジェクトのpublished
      プロパティから、対応するProtoTypesの各項目が生成されます。
      またProtoTypesの各項目が生成された時点でStandInCtrlsメソッドが実行
      されます。
    }
    property Target: TObject read FTarget write SetTarget;
    {
      Targetプロパティのpublishedプロパティなどにアクセスするためのプロパティ。
      Ts0RTTIPublishedAccessorクラスを参照。
    }
    property Wrapper: Ts0RTTIPublishedAccessor read FWrapper;
  public
    { Is0Aggregate }
    //インターフェース型プロパティへの委任
    //property Aggregate: Is0Aggregate read FAggregate implements Is0Aggregate;
  published
    {
      ProtoTypesプロパティの各項目に関連付けられたコントロールに何らかの変更
      があった場合に、Targetプロパティで示されるオブジェクトの対応するプロパティ
      に対して、自動的に値を設定するかどうかを指定します。
      デフォルトではTrue。
      Falseを設定した場合、手動でLoadFromTarget,SaveToTargetメソッドを
      呼び出す必要があります。
    }
    property AutoUpdate: Boolean read FAutoUpdate write SetAutoUpdate default True;
    {
      BuildCtrlsメソッドなどによりコントロールの生成を行う際に、実際に
      その処理を行うためのオブジェクトへの参照。
      CtrlParentなどの生成に必要なデータを保持します。
    }
    property Builder: Ts0ObjCtrlBuilder read FBuilder write SetBuilder;
    {
      Targetプロパティに何らかのオブジェクトを設定した場合に、ProtoTypes
      プロパティに項目が一つもなければ、Targetプロパティが参照するオブジェクトの
      publishedプロパティを元にこのクラスは自動的に対応する項目を生成しますが、
      その際に項目の生成の対象とならないプロパティを指定できます。
      デフォルトでは'Name'と'Tag'が追加されています。
    }
    property DisabledProps: TStrings read FDisabledProps write SetDisabledProps;
    {
      このコンポーネントが動作する際の各プロパティ毎のデータを保持/処理を行う
      プロパティ。詳しくはTs0ProtoTypeCtrlsを参照してください。
    }
    property ProtoTypes: Ts0ProtoTypeCtrls read FProtoTypes write SetProtoTypes;
    {
      StandInCtrlsメソッドを実行して、各項目の位置を整える際に、その項目毎の
      位置を設定するためのコンポーネントを指定します。
    }
    property LayoutSet: Ts0LayoutSet read FLayoutSet write SetLayoutSet;
    {
      設計時にTargetプロパティを指定するためのプロパティです。
      このプロパティに何らかのコンポーネントを設定すると、自動的にTarget
      プロパティにそれが設定されます。
    }
    property TargetComponent: TComponent read GetTargetComponent write SetTargetComponent;
    property OnLoadObjFromCtrl: K0ObjAccessEvent read FOnLoadObjFromCtrl write FOnLoadObjFromCtrl;
    property OnSaveObjToCtrl: K0ObjAccessEvent read FOnSaveObjToCtrl write FOnSaveObjToCtrl;
  published
    {
      設計時にTargetプロパティを設定するためのプロパティです。
      TargetComponentプロパティとの併用はできません。
      ProtoSourcePropNameプロパティと一緒に使用します。
      TargetComponentとは違ってコンポーネントを直接指定するのではなく、
      あるコンポーネントのあるプロパティが参照するオブジェクトをTargetプロパティ
      に設定します。
      ProtoSourceCompoプロパティで上記の「あるコンポーネント」を設定し、
      ProtoSourcePropNameプロパティで上記の「あるプロパティ」を設定します。
    }
    property ProtoSourceCompo: TComponent read FProtoSourceCompo write FProtoSourceCompo;
    {
      ProtoSourceCompoプロパティを参照してください。
    }
    property ProtoSourcePropName: string read FProtoSourcePropName write FProtoSourcePropName;
  published
    { Builder Event }
    {
      BuildCtrlsなどで、コントロールを生成する直前に呼び出されるイベントです。
    }
    property BeforeBuild: TNotifyEvent read FBeforeBuild write FBeforeBuild;
    {
      BuildCtrlsなどで、コントロールを生成した直後に呼び出されるイベントです。
    }
    property AfterBuild: TNotifyEvent read FAfterBuild write FAfterBuild;
    {
      BuildCtrlsなどで、一つ一つのコントロールを生成する際に呼び出される
      イベントです。
    }
    property OnCreateCtrl: K0ECBCreateCtrlEvent read FOnCreateCtrl write FOnCreateCtrl;
    {
      BuildCtrlsなどで、一つ一つのコントロールを生成し、初期化する際に
      呼び出されるイベントです。
    }
    property OnInitCtrl: K0ECBCreateCtrlEvent read FOnInitCtrl write FOnInitCtrl;
    {
      BuildCtrlsなどで、一つ一つのコントロールを生成する前に、生成される
      コントロールのクラスを問い合わせるイベントです。
      引数のACtrlClassに適当なコントロールのクラスを設定することで、
      生成されるコントロールのクラスを変更することができます。
    }
    property OnFindCtrlClass: K0ECBFindCtrlClassEvent read FOnFindCtrlClass write FOnFindCtrlClass;
    {
      StandInCtrlsメソッドを実行する際に呼び出されるイベントです。
    }
    property OnStandInCtrls: TNotifyEvent read FOnStandInCtrls write FOnStandInCtrls;
  end;

implementation

uses
  s0ComponentHelper;

{ Ts0PTCBounds }

constructor Ts0PTCBounds.Create(AOwner: TPersistent);
begin
  inherited;
  FLinking := True;
end;

function Ts0PTCBounds.GetRealCtrl: TControl;
begin
  Result := nil;
  if not(OwnerObj is Ts0ProtoTypeCtrl) then Exit;
  Result := Ts0ProtoTypeCtrl(OwnerObj).Ctrl;
end;

function Ts0PTCBounds.GetRealLabel: TCustomLabel;
begin
  Result := nil;
  if not(OwnerObj is Ts0ProtoTypeCtrl) then Exit;
  Result := Ts0ProtoTypeCtrl(OwnerObj).CtrlLabel;
end;

function Ts0PTCBounds.GetValue(const AKind: Ks0BoundsItemKind): Integer;
  function GetBoundsOfCtrls(const AKind: Ks0BoundsItemKind): Integer;
  var
    d: Integer;
  begin
    Result := 0;
    if RealCtrl = nil then Exit;
    if OwnerComponent is Ts0ObjCtrlBridge then
      d := Ts0ObjCtrlBridge(OwnerComponent).Builder.LabelBreath
    else
      d := 0;
    //
    case AKind of
      ks0bkLeft  :
        if RealLabel = nil then
          Result := RealCtrl.Left
        else
          Result := RealLabel.Left;
      ks0bkTop   : Result := RealCtrl.Top;
      ks0bkWidth :
        if RealLabel = nil then
          Result := RealCtrl.Width
        else
          Result := RealCtrl.Width + RealLabel.Width + d;
      ks0bkHeight: Result := RealCtrl.Height;
    end;
  end;
begin
  if FLinking and (RealCtrl <> nil) then
    Result := GetBoundsOfCtrls(AKind)
  else
    Result := inherited GetValue(AKind);
end;

procedure Ts0PTCBounds.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if FLinking and (RealCtrl <> nil) then
    SetBoundsOfCtrl;
end;

procedure Ts0PTCBounds.SetBoundsOfCtrl;
var
  d: Integer;
  bufLinking: Boolean;
begin
  //if not Linking then Exit;
  bufLinking := FLinking;
  FLinking := False;
  try
    if not(OwnerObj is Ts0ProtoTypeCtrl) then Exit;
    if RealCtrl = nil then Exit;
    if OwnerComponent is Ts0ObjCtrlBridge then
      d := Ts0ObjCtrlBridge(OwnerComponent).Builder.LabelBreath
    else
      d := 0;
    //
    if RealLabel = nil then
    begin
      RealCtrl.SetBounds(Left + d, Top, Width -d, Height);
    end
    else
    begin
      RealLabel.SetBounds(Left, Top,         d, Height);
      RealCtrl.SetBounds(Left + d , Top, Width - d, Height);
    end;
  finally
    FLinking := bufLinking;
  end;
end;

procedure Ts0PTCBounds.SetLinking(const Value: Boolean);
begin
  FLinking := Value;
  if FLinking and (RealCtrl <> nil) then
    SetBoundsOfCtrl;
end;

type
  T9ProtoTypeCtrlListener = class(Ts0CtrlEventListener)
  private
    FOwner: Ts0ProtoTypeCtrl;
    FUpdating: Boolean;
    procedure UpdateTarget;
  public
    constructor Create(AOwner: Ts0ProtoTypeCtrl);
    procedure CtrlOnChange(Sender: TObject); override;
    procedure CtrlOnClick(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); override;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnResize(Sender: TObject); override;
  end;

{ T9ProtoTypeCtrlListener }

constructor T9ProtoTypeCtrlListener.Create(AOwner: Ts0ProtoTypeCtrl);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnChange(Sender: TObject);
begin
  if k0cetOnChange in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnClick(Sender: TObject);
begin
  if k0cetOnClick in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnExit(Sender: TObject);
begin
  if k0cetOnExit in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if k0cetOnPressEnter in FOwner.AutoUpdateKinds then
    if Key = Char(#13) then
      UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if k0cetOnKeyUp in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnResize(Sender: TObject);
begin
  if Sender is TControl then
    if TControl(Sender).BoundsRect.Left = 0 then ;
end;

procedure T9ProtoTypeCtrlListener.UpdateTarget;
begin
  if FUpdating then Exit;
  if [csLoading, csReading, csDesigning] * FOwner.OwnerComponent.ComponentState <> [] then Exit;
  if FOwner.Ctrl <> nil then
    if [csLoading, csReading, csDesigning] * FOwner.Ctrl.ComponentState <> [] then Exit;
  FOwner.SaveToTarget;
  if not(FOwner.OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Ts0ObjCtrlBridge(FOwner.OwnerComponent).LoadFromTarget;;
end;

{ Ts0ProtoTypeCtrl }

procedure Ts0ProtoTypeCtrl.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if not(Source is Ts0ProtoTypeCtrl) then Exit;
  Self.FAccessor := nil;
  Self.AutoUpdateKinds := Ts0ProtoTypeCtrl(Source).AutoUpdateKinds;
  Self.CtrlClassName   := Ts0ProtoTypeCtrl(Source).CtrlClassName;
  Self.EnumAsString    := Ts0ProtoTypeCtrl(Source).EnumAsString;
  Self.Options         := Ts0ProtoTypeCtrl(Source).Options;
  FCtrlBounds.Assign( Ts0ProtoTypeCtrl(Source).CtrlBounds );
end;

constructor Ts0ProtoTypeCtrl.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FOptions := [k0ptcoAutoChangeCtrlClassName];
  FCtrlBounds := Ts0PTCBounds.Create(Self);
  FIntfBounds := FCtrlBounds; //プロパティへのインタフェースの委任
  IF OwnerComponent is Ts0ObjCtrlBridge then
    FCtrlParent := Ts0ObjCtrlBridge(OwnerComponent).Builder.CtrlParent;
end;

destructor Ts0ProtoTypeCtrl.Destroy;
begin
  PutBackEvents;
  FIntfBounds := nil; //Don't forget to clear interface reference!
  FreeAndNil(FCtrlBounds);
  inherited;
end;

procedure Ts0ProtoTypeCtrl.DoLoadFromTarget;
begin
  if Assigned(FOnLoadFromTarget) then
    FOnLoadFromTarget(Self);
end;

procedure Ts0ProtoTypeCtrl.DoSaveToTarget;
begin
  if Assigned(FOnLoadFromTarget) then
    FOnSaveToTarget(Self);
end;

procedure Ts0ProtoTypeCtrl.FreeCtrl;
  procedure ClearAndFree(ACtrl: TControl);
  var
    buf: TControl;
  begin
    if ACtrl = nil then Exit;
    buf := ACtrl;
    if ACtrl.Owner <> nil then
      ACtrl.Owner.RemoveComponent( ACtrl );
    FreeAndNil( buf );
  end;
begin
  ClearAndFree( FCtrl );
  ClearAndFree( FCtrlLabel );
  FAccessor := nil;
end;

function Ts0ProtoTypeCtrl.GetAccessor: Ts0DataAccessor;
begin
  if FCtrl <> nil then
    if FAccessor = nil then
      FAccessor := Ts0CtrlDistillBroker.GetAccessor( FCtrl );
  Result := FAccessor;
  if Result = nil then
    Result := Ts0NullDataAccessor.Instance;
end;

function Ts0ProtoTypeCtrl.GetImeMode: TImeMode;
const
  c9ImeModes: array[K0ImeMode] of TImeMode = (
    imDisable, imClose, imOpen, imDontCare,
    imSAlpha, imAlpha, imHira, imSKata, imKata,
    imChinese, imSHanguel, imHanguel);
begin
  Result := c9ImeModes[ImeModeSX];
end;

function Ts0ProtoTypeCtrl.GetModified: Boolean;
var
  w: Ts0RTTIPublishedAccessor;
  s: string;
  obj: TObject;
begin
  Result := False;
  w := GetWapper;
  if w = nil then Exit;
  if RTTIProp = nil then Exit;
  if Ctrl = nil then Exit;
  case RTTIProp.TypeInfo.TypeKind of
    tkUnknown    : ;
    tkInteger    : Result := w.OrdProp[ PropertyName ]   <> Accessor.AsInteger;
    tkChar       : Result := w.OrdProp[ PropertyName ]   <> Accessor.AsInteger;
    tkEnumeration:
    begin
      if EnumAsString then
        s := Accessor.AsString
      else
        s := RTTIProp.TypeInfo.GetName( Accessor.AsInteger );
      Result := w.EnumProp[ PropertyName ] <> s;
    end;
    tkFloat      : Result := w.FloatProp[ PropertyName ] <> Accessor.AsFloat  ;
    tkString     : Result := w.StrProp[ PropertyName ]   <> Accessor.AsString ;
    tkSet        : Result := w.SetProp[ PropertyName ]   <> Accessor.AsString ;
    tkClass      :
    begin
      obj := w.ObjectProp[ PropertyName ];
      if obj = nil then Exit;
      if obj is TStrings then
        Result := TStrings(obj).Text <> Accessor.AsString;
    end;
    tkMethod     : ;
    tkWChar      : ;
    tkLString    : Result := w.StrProp[ PropertyName ]   <> Accessor.AsString ;
    tkWString    : Result := w.StrProp[ PropertyName ]   <> Accessor.AsString ;
    tkVariant    : ;
    tkArray      : ;
    tkRecord     : ;
    tkInterface  : ;
    tkInt64      : ;
    tkDynArray   : ;
  end;
end;

function Ts0ProtoTypeCtrl.GetSnatched: Boolean;
begin
  Result := FCtrlListener <> nil;
end;

function Ts0ProtoTypeCtrl.GetWapper: Ts0RTTIPublishedAccessor;
begin
  Result := nil;
  if OwnerComponent is Ts0ObjCtrlBridge then
    Result := Ts0ObjCtrlBridge(OwnerComponent).Wrapper
end;

procedure Ts0ProtoTypeCtrl.InitCtrl;
  procedure InitByInputStyle;
  var
    ip: Ts0InputStyle;
  begin
    if not Ts0CtrlDistillBroker.IsTarget(Ctrl) then Exit;
    ip := Ts0CtrlDistillBroker.GetInputControl(Ctrl);
    if ip = nil then
    begin
      Ts0CtrlDistillBroker.SetTitle(JPName, FCtrl);
    end
    else
    begin
      ip.ResizingCtrl := True;
      try
        ip.MaxLength := Self.Size;
        ip.AutoWidth := True;
        ip.ImeMode := Self.GetImeMode;
        ip.AcceptCharType := Self.AcceptCharTypes;
        ip.Title := Self.JPName;
      finally
        ip.ResizingCtrl := False;
      end;
    end;
  end;
begin
  if FCtrl = nil then Exit;
  InitByInputStyle;
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Ts0ObjCtrlBridge(OwnerComponent).InitProtoCtrl(Self);
end;

procedure Ts0ProtoTypeCtrl.LoadFromTarget;
var
  w: Ts0RTTIPublishedAccessor;
  s: string;
  obj: TObject;
begin
  w := GetWapper;
  if w = nil then Exit;
  if RTTIProp = nil then Exit;
  if RTTIProp.TypeInfo.TypeKind = tkClass then
  begin
    if OwnerComponent is Ts0ObjCtrlBridge then
      Ts0ObjCtrlBridge(OwnerComponent).DoLoadObjFromCtrl(
        w.ObjectProp[PropertyName], Ctrl
      );
  end;
  if Ctrl = nil then Exit;
  if not Self.Modified then Exit;
  case RTTIProp.TypeInfo.TypeKind of
    tkUnknown    : ;
    tkInteger    : Accessor.AsInteger := w.OrdProp[ PropertyName ];
    tkChar       : Accessor.AsInteger := w.OrdProp[ PropertyName ];
    tkEnumeration:
    begin
      s := w.EnumProp[ PropertyName ];
      if EnumAsString then
        Accessor.AsString  := s
      else
        Accessor.AsInteger := RTTIProp.TypeInfo.GetEnumValue(s);
    end;
    tkFloat      : Accessor.AsFloat   := w.FloatProp[ PropertyName ];
    tkString     : Accessor.AsString  := w.StrProp[ PropertyName ];
    tkSet        : Accessor.AsString  := w.SetProp[ PropertyName ];
    tkClass      :
    begin
      obj := w.ObjectProp[ PropertyName ];
      if obj = nil then Exit;
      if obj is TStrings then
        Accessor.AsString := TStrings(obj).Text;
    end;
    tkMethod     : ;
    tkWChar      : ;
    tkLString    : Accessor.AsString  := w.StrProp[ PropertyName ];
    tkWString    : Accessor.AsString  := w.StrProp[ PropertyName ];
    tkVariant    : ;
    tkArray      : ;
    tkRecord     : ;
    tkInterface  : ;
    tkInt64      : ;
    tkDynArray   : ;
  end;
end;

function Ts0ProtoTypeCtrl.NeedCtrl: Boolean;
begin
  Result := False;
  if WithoutCtrl then Exit;
  if Ctrl <> nil then Exit;
  Result := True;
end;

procedure Ts0ProtoTypeCtrl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FCtrl = AComponent then
  begin
    FCtrl := nil;
    FAccessor := nil;
  end;
  if FCtrlLabel = AComponent then FCtrlLabel := nil;
end;

procedure Ts0ProtoTypeCtrl.PutBackEvents;
begin
  if FCtrlListener = nil then Exit;
  Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FCtrlListener);
  FreeAndNil(FCtrlListener);
end;

procedure Ts0ProtoTypeCtrl.ResetCtrlProp;
var
  ip: Ts0InputStyle;
begin
  if Ctrl = nil then Exit;
  ip := Ts0CtrlDistillBroker.GetInputControl(Ctrl);
  if ip = nil then Exit;
  ip.AcceptCharType := Self.AcceptCharTypes;
  ip.ImeMode := Self.GetImeMode;
end;

procedure Ts0ProtoTypeCtrl.SaveToTarget;
var
  w: Ts0RTTIPublishedAccessor;
  s: string;
  obj: TObject;
begin
  w := GetWapper;
  if w = nil then Exit;
  if RTTIProp = nil then Exit;
  if RTTIProp.TypeInfo.TypeKind = tkClass then
  begin
    if OwnerComponent is Ts0ObjCtrlBridge then
      Ts0ObjCtrlBridge(OwnerComponent).DoSaveObjToCtrl(
        w.ObjectProp[PropertyName], Ctrl);
  end;
  if Ctrl = nil then Exit;
  if not Self.Modified then Exit;
  case RTTIProp.TypeInfo.TypeKind of
    tkUnknown    : ;
    tkInteger    : w.OrdProp[ PropertyName ]   := Accessor.AsInteger;
    tkChar       : w.OrdProp[ PropertyName ]   := Accessor.AsInteger;
    tkEnumeration:
    begin
      if EnumAsString then
        s := Accessor.AsString
      else
        s := RTTIProp.TypeInfo.GetName( Accessor.AsInteger );
      w.EnumProp[ PropertyName ] := s;
    end;
    tkFloat      : w.FloatProp[ PropertyName ] := Accessor.AsFloat  ;
    tkString     : w.StrProp[ PropertyName ]   := Accessor.AsString ;
    tkSet        : w.SetProp[ PropertyName ]   := Accessor.AsString ;
    tkClass      :
    begin
      obj := w.ObjectProp[ PropertyName ];
      if obj = nil then Exit;
      if obj is TStrings then
        TStrings(obj).Text := Accessor.AsString;
    end;
    tkMethod     : ;
    tkWChar      : ;
    tkLString    : w.StrProp[ PropertyName ]   := Accessor.AsString ;
    tkWString    : w.StrProp[ PropertyName ]   := Accessor.AsString ;
    tkVariant    : ;
    tkArray      : ;
    tkRecord     : ;
    tkInterface  : ;
    tkInt64      : ;
    tkDynArray   : ;
  end;
end;

procedure Ts0ProtoTypeCtrl.SetAcceptCharTypes(const Value: K1InpCharSet);
begin
  inherited SetAcceptCharTypes(Value);
  ResetCtrlProp;
end;

procedure Ts0ProtoTypeCtrl.SetAutoUpdateKinds(
  const Value: K0CtrlEventTypeSet);
begin
  FAutoUpdateKinds := Value;
end;

procedure Ts0ProtoTypeCtrl.SetCtrl(const Value: TControl);
begin
  if FCtrl = Value then Exit;
  PutBackEvents;
  FAccessor := nil;
  FCtrl := Value;
  try
    if FCtrl = nil then Exit;
    CtrlBounds.SetBoundsOfCtrl;
    if not Ts0CtrlDistillBroker.IsTarget(FCtrl) then Exit; 
    if not(csLoading in OwnerComponent.ComponentState) then
      FAutoUpdateKinds := Ts0CtrlDistillBroker.GetUpdateEvents(FCtrl);
    if OwnerComponent is Ts0ObjCtrlBridge then
    begin
      if Ts0ObjCtrlBridge(OwnerComponent).AutoUpdate then
        SnatchEvents;
    end;
  finally
    Changed(False);
  end;
end;

procedure Ts0ProtoTypeCtrl.SetCtrlBounds(Value: Ts0PTCBounds);
begin
  FCtrlBounds.Assign( Value );
end;

procedure Ts0ProtoTypeCtrl.SetCtrlClassName(const Value: string);
begin
  FCtrlClassName := Value;
end;

procedure Ts0ProtoTypeCtrl.SetCtrlLabel(const Value: TCustomLabel);
begin
  FCtrlLabel := Value;
  Changed(False);
end;

procedure Ts0ProtoTypeCtrl.SetCtrlParent(const Value: TWinControl);
begin
  FCtrlParent := Value;
  if FCtrlParent = nil then Exit;
  if not(csAcceptsControls in FCtrlParent.ControlStyle) then
    FCtrlParent := nil;
end;

procedure Ts0ProtoTypeCtrl.SetEnumName(const Value: string);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetImeModeSX(const Value: K0ImeMode);
begin
  inherited;
  ResetCtrlProp;
end;

procedure Ts0ProtoTypeCtrl.SetIsEnum(const Value: Boolean);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetIsPersistent(const Value: Boolean);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetIsSet(const Value: Boolean);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetOptions(const Value: K0PTCOptions);
begin
  FOptions := Value;
end;

procedure Ts0ProtoTypeCtrl.SetPropertyName(const Value: string);
begin
  FreeAndNil(FRTTIProp);
  inherited SetPropertyName(Value);
end;

procedure Ts0ProtoTypeCtrl.SetUpdating(const Value: Boolean);
begin
  if FCtrlListener is T9ProtoTypeCtrlListener then
    T9ProtoTypeCtrlListener(FCtrlListener).FUpdating := Value;
end;

procedure Ts0ProtoTypeCtrl.SnatchEvents;
begin
  if FCtrlListener <> nil then Exit;
  if csDesigning in OwnerComponent.ComponentState then Exit;
  if FCtrl = nil then Exit;
  FCtrlListener := T9ProtoTypeCtrlListener.Create(Self);
  Ts0CtrlEventSnatcher.Instance.RegisterListener(FCtrl, FCtrlListener);
end;

procedure Ts0ProtoTypeCtrl.ValidateCtrlClassName;
var
  newCtrlName: string;
begin
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  newCtrlName := Ts0ObjCtrlBridge(OwnerComponent).GetCtrlClassNameByProp(Self);
  if newCtrlName = '' then Exit;
  CtrlClassName := newCtrlName;
end;

{ Ts0ProtoTypeCtrls }

procedure Ts0ProtoTypeCtrls.Assign(Source: TPersistent);
begin
  if Source is Ts0PropertyProtoTypes then
  begin
    if Self.OwnerComponent is Ts0ObjCtrlBridge then
      Ts0ObjCtrlBridge(Self.OwnerComponent).ProtoSource := Ts0PropertyProtoTypes(Source);
  end;
  inherited Assign(Source);
end;

constructor Ts0ProtoTypeCtrls.Create(AOwner: TPersistent;
  AItemClass: Ts0CollectionItemClass);
begin
  inherited;
  CloneAssign := False;
end;

destructor Ts0ProtoTypeCtrls.Destroy;
begin
  inherited Destroy;
end;

function Ts0ProtoTypeCtrls.FindPropCtrls(
  const APropName: string): Ts0ProtoTypeCtrl;
var
  p: Ts0PropertyProtoType;
begin
  Result := nil;
  p := FindByName(APropName);
  if p is Ts0ProtoTypeCtrl then
    Result := Ts0ProtoTypeCtrl(p);
end;

function Ts0ProtoTypeCtrls.GetOriginal: Ts0PropertyProtoTypes;
begin
  Result := nil;
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Result := Ts0ObjCtrlBridge(OwnerComponent).ProtoSource;
end;

function Ts0ProtoTypeCtrls.GetPropCtrls(
  const Index: Integer): Ts0ProtoTypeCtrl;
begin
  Result := Ts0ProtoTypeCtrl(inherited Items[Index]);
end;

function Ts0ProtoTypeCtrls.IndexOfProp(APropName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count -1 do
  begin
    if SameText((inherited Items[i]).PropertyName, APropName) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure Ts0ProtoTypeCtrls.NotifyOriginalUpdate(
  AItem: Ts0PropertyProtoType);
var
  i: Integer;
  myItem: Ts0ProtoTypeCtrl;
begin
  inherited NotifyOriginalUpdate(AItem);
  if AItem <> nil then
  begin
    myItem := FindPropCtrls(AItem.PropertyName);
    if myItem <> nil then
      myItem.InitCtrl;
  end
  else
  begin
    for i := 0 to Self.Count -1 do
      Self.PropCtrls[i].InitCtrl;
  end;
end;

procedure Ts0ProtoTypeCtrls.SetOriginal(const Value: Ts0PropertyProtoTypes);
begin
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Ts0ObjCtrlBridge(OwnerComponent).ProtoSource := Value;
end;

procedure Ts0ProtoTypeCtrls.SetPropCtrls(const Index: Integer;
  const Value: Ts0ProtoTypeCtrl);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CtrlNamePrefix }

procedure Ts0CtrlNamePrefix.SetPartOfCtrlClassName(const Value: string);
begin
  FPartOfCtrlClassName := Value;
end;

procedure Ts0CtrlNamePrefix.SetPrefix(const Value: string);
begin
  FPrefix := Value;
end;

{ Ts0CtrlNamePrefixes }

function Ts0CtrlNamePrefixes.Add(APartOfCtrl,
  APrefix: string): Ts0CtrlNamePrefix;
begin
  Result := Ts0CtrlNamePrefix(inherited Add);
  Result.FPartOfCtrlClassName := APartOfCtrl;
  Result.FPrefix := APrefix;
end;

function Ts0CtrlNamePrefixes.GetPrefixes(
  const Index: Integer): Ts0CtrlNamePrefix;
begin
  Result := Ts0CtrlNamePrefix(inherited Items[Index]);
end;

procedure Ts0CtrlNamePrefixes.SetPrefixes(const Index: Integer;
  const Value: Ts0CtrlNamePrefix);
begin
  inherited Items[Index] := Value;
end;

{ Ts0ObjCtrlBuilder }

procedure Ts0ObjCtrlBuilder.Assign(Source: TPersistent);
begin
  inherited;
end;

constructor Ts0ObjCtrlBuilder.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FDefaultCtrlWidth := 300;
  FDefaultCtrlHeight := 24;
  FLabelBreath := 100;
  FCtrlMargin := 4;
  FCtrlPrefixes := Ts0CtrlNamePrefixes.Create(Self, Ts0CtrlNamePrefix);
  InitCtrlPrefixes;
  FCtrlOfType := NewCtrlOfType;
end;

function Ts0ObjCtrlBuilder.CreateCtrlOf(AProp: Ts0ProtoTypeCtrl): TControl;
  function FincCtrlClass(AClassName: string): TControlClass;
  var
    cls: TClass;
  begin
    Result := nil;
    cls := GetClass(AClassName);
    if cls = nil then Exit;
    if not cls.InheritsFrom(TControl) then Exit;
    Result := TControlClass(cls);
  end;
var
  ctrlClass: TControlClass;
begin
  Result := nil;
  ctrlClass := FincCtrlClass( AProp.CtrlClassName );
  DoFindCtrlClass(AProp, ctrlClass);
  if ctrlClass = nil then Exit;
  Result := CreateCtrlImpl(ctrlClass, AProp);
end;

function Ts0ObjCtrlBuilder.CreateCtrlImpl(ACtrlClass: TControlClass;
  AProp: Ts0ProtoTypeCtrl): TControl;
var
  lOwner: TComponent;
begin
  lOwner := CtrlOwner;
  if lOwner = nil then
    lOwner := Self.OwnerComponent;
  Result := ACtrlClass.Create(lOwner);
  Result.Name :=
    Ts0ComponentHelper.GetNewComponentNameOf(
      Result,
      GetPrefixByClassName(ACtrlClass.ClassName) + AProp.PropertyName
    );
  Result.Parent := AProp.CtrlParent;
end;

destructor Ts0ObjCtrlBuilder.Destroy;
begin
  FreeAndNil(FCtrlOfType);
  FreeAndNil(FCtrlPrefixes);
  inherited Destroy;
end;

procedure Ts0ObjCtrlBuilder.DoAfterBuild;
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FAfterBuild) then
    ownerB.FAfterBuild(ownerB);
end;

procedure Ts0ObjCtrlBuilder.DoBeforeBuild;
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FBeforeBuild) then
    ownerB.FBeforeBuild(ownerB);
end;

procedure Ts0ObjCtrlBuilder.DoCreateCtrl(AProp: Ts0ProtoTypeCtrl;
  AControl: TControl);
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FOnCreateCtrl) then
    ownerB.FOnCreateCtrl(ownerB, AProp, AControl);
end;

procedure Ts0ObjCtrlBuilder.DoFindCtrlClass(AProp: Ts0ProtoTypeCtrl;
  var ACtrlClass: TControlClass);
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FOnFindCtrlClass) then
    ownerB.FOnFindCtrlClass(ownerB, AProp, ACtrlClass);
end;

procedure Ts0ObjCtrlBuilder.DoInitCtrl(AProp: Ts0ProtoTypeCtrl;
  AControl: TControl);
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FOnInitCtrl) then
    ownerB.FOnInitCtrl(ownerB, AProp, AControl);
end;

procedure Ts0ObjCtrlBuilder.Execute;
  function CreateLabel(AProto: Ts0ProtoTypeCtrl; ACtrl: TControl): TCustomLabel;
    procedure SetFocusControl(ALabel: TCustomLabel);
    const
      c9FocusCtrl = 'FocusControl';
    var
      acsr: Ts0RTTIPublishedAccessor;
    begin
      acsr := Ts0RTTIPublishedAccessor.Create(Result);
      try
        if not acsr.PropertyExists(c9FocusCtrl) then Exit;
        if not SameText(acsr.PropTypeName(c9FocusCtrl), 'TWinControl') then Exit;
        acsr.ObjectProp[c9FocusCtrl] := TWinControl(ACtrl);
      finally
        FreeAndNil(acsr);
      end;
    end;
    procedure SetInpCtrlTitleDisp(inpCtrl: Ts0InputStyle; ALabel: TCustomLabel);
    const
      c9TitleDisp = 'TitleDisplay';
    var
      acsr: Ts0RTTIPublishedAccessor;
    begin
      if inpCtrl = nil then Exit;
      if ALabel = nil then Exit;
      acsr := Ts0RTTIPublishedAccessor.Create(inpCtrl);
      try
        if not acsr.PropertyExists(c9TitleDisp) then Exit;
        if not ALabel.InheritsFrom(acsr.ObjectPropClass[c9TitleDisp]) then Exit;
        acsr.ObjectProp[c9TitleDisp] := ALabel;
      finally
        FreeAndNil(acsr);
      end;
    end;
    function GetLabelClass: TControlClass;
    var
      cls: TClass;
    begin
      Result := nil;
      cls := GetClass('Ts0Label');    /////// !!! 大注意 !!!  ///////
      if (cls <> nil) and cls.InheritsFrom(TControl) then
      begin
        Result := TControlClass(cls);
        Exit;
      end;
      cls := GetClass('TLabel');    /////// !!! 大注意 !!!  ///////
      if (cls <> nil) and cls.InheritsFrom(TControl) then
        Result := TControlClass(cls);
    end;
  var
    labelClass: TControlClass;
  begin
    Result := nil;
    if ACtrl = nil then Exit;
    //チェックボックスならラベルは要らない。
    if ACtrl is TCustomCheckBox then Exit;
    labelClass := GetLabelClass;
    if labelClass = nil then Exit;
    Result := TCustomLabel(CreateCtrlImpl(labelClass, AProto));
    Result.Width := FLabelBreath;
{$IFDEF VER130}
      Ts0CtrlDistillBroker.SetTitle(AProto.JPName, Result);
{$ELSE}
      Result.Caption := AProto.JPName;
{$ENDIF}
    if not(ACtrl is TWinControl) then Exit;
    SetFocusControl(Result);
    if not Ts0CtrlDistillBroker.IsTarget(ACtrl) then Exit;
    SetInpCtrlTitleDisp(Ts0CtrlDistillBroker.GetInputControl(ACtrl), Result);
  end;
var
  proto: Ts0ProtoTypeCtrl;
  i: Integer;
  bufLinking: Boolean;
begin
  if CtrlOwner = nil then Exit;
  if CtrlParent = nil then Exit;
  if ProtoTypes = nil then Exit;
  DoBeforeBuild;
  ProtoTypes.BeginUpdate;
  try
    for i := 0 to ProtoTypes.Count -1 do
    begin
      proto := ProtoTypes.PropCtrls[i];
      if not proto.NeedCtrl then Continue;
      //
      if proto.CtrlParent = nil then
        proto.CtrlParent := Self.CtrlParent;
      //
      bufLinking := proto.CtrlBounds.Linking;
      proto.CtrlBounds.Linking := False;
      try
        proto.Ctrl := CreateCtrlOf(proto);
        proto.CtrlLabel := CreateLabel(proto, proto.Ctrl);
      finally
        proto.CtrlBounds.Linking := bufLinking;
      end;
      //
      DoCreateCtrl(proto, proto.Ctrl);
      proto.InitCtrl;
      DoInitCtrl(proto, proto.Ctrl);
    end;
  finally
    ProtoTypes.EndUpdate;
  end;
  DoAfterBuild;
end;

function Ts0ObjCtrlBuilder.GetCtrlOfType: Ts0CtrlOfType;
begin
  Result := FCtrlOfType;
end;

function Ts0ObjCtrlBuilder.GetCtrlOfTypeClassName: string;
begin
  if FCtrlOfType <> nil then
    Result := FCtrlOfType.ClassName
  else
    Result := '';
end;

function Ts0ObjCtrlBuilder.GetOwnerBridge: Ts0ObjCtrlBridge;
begin
  Result := nil;
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Result := Ts0ObjCtrlBridge(OwnerComponent);
end;

function Ts0ObjCtrlBuilder.GetPrefixByClassName(
  AClassName: string): string;
var
  i: Integer;
  n: String;
begin
  Result := '';
  for i := 0 to FCtrlPrefixes.Count -1 do
  begin
    n := CtrlPrefixes[i].PartOfCtrlClassName;
    if Pos(n, AClassName) > 0 then
    begin
      Result := CtrlPrefixes[i].Prefix;
      Exit;
    end;
  end;
end;

function Ts0ObjCtrlBuilder.GetProtoTypes: Ts0ProtoTypeCtrls;
begin
  Result := nil;
  if GetOwnerBridge = nil then Exit;
  Result := GetOwnerBridge.ProtoTypes;
end;

function Ts0ObjCtrlBuilder.GetWrapper: Ts0RTTIPublishedAccessor;
begin
  Result := nil;
  if GetOwnerBridge = nil then Exit;
  Result := GetOwnerBridge.Wrapper;
end;

procedure Ts0ObjCtrlBuilder.InitCtrlPrefixes;
begin
  FCtrlPrefixes.Add('CheckBox'    , 'chk' );
  FCtrlPrefixes.Add('DigitEdit'   , 'dged');
  FCtrlPrefixes.Add('DateEdit'    , 'dted');
  FCtrlPrefixes.Add('Edit'        , 'edt' );
  FCtrlPrefixes.Add('Memo'        , 'mmo' );
  FCtrlPrefixes.Add('ComboBox'    , 'cmb' );
  FCtrlPrefixes.Add('RadioGroup'  , 'rgp' );
  FCtrlPrefixes.Add('CheckListBox', 'clb' );
  FCtrlPrefixes.Add('Label'       , 'lbl' );
  FCtrlPrefixes.Add('Button'      , 'btn' );
  FCtrlPrefixes.Add('ListBox'     , 'lst' );
  FCtrlPrefixes.Add('Grid'        , 'grd' );
end;

function Ts0ObjCtrlBuilder.NewCtrlOfType: Ts0CtrlOfType;
begin
  Result := Ts0CtrlOfType.GetDefaultClass.Create(Self);
end;

procedure Ts0ObjCtrlBuilder.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation <> opRemove then Exit;
  if FCtrlParent = AComponent then
    FCtrlParent := nil;
end;

procedure Ts0ObjCtrlBuilder.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if FActive then
    Execute;
end;

procedure Ts0ObjCtrlBuilder.SetCtrlOfType(const Value: Ts0CtrlOfType);
begin
  FCtrlOfType.Assign(Value);
end;

procedure Ts0ObjCtrlBuilder.SetCtrlOfTypeClassName(const Value: string);
var
  cls: TPersistentClass;
begin
  if SameText(CtrlOfTypeClassName, Value) then Exit;
  cls := GetClass(Value);
  if cls = nil then Exit;
  if not cls.InheritsFrom(Ts0CtrlOfType) then Exit;
  FreeAndNil(FCtrlOfType);
  FCtrlOfType := Ts0CtrlOfTypeClass(cls).Create(Self);
end;

procedure Ts0ObjCtrlBuilder.SetCtrlOwner(const Value: TComponent);
begin
  FCtrlOwner := Value;
end;

procedure Ts0ObjCtrlBuilder.SetCtrlParent(const Value: TWinControl);
begin
  FCtrlParent := Value;
  if FCtrlParent = nil then Exit;
  if not(csAcceptsControls in FCtrlParent.ControlStyle) then
    FCtrlParent := nil;
end;

procedure Ts0ObjCtrlBuilder.SetCtrlPrefixes(const Value: Ts0CtrlNamePrefixes);
begin
  FCtrlPrefixes.Assign(Value)
end;

procedure Ts0ObjCtrlBuilder.SetLabelBreath(const Value: Integer);
begin
  FLabelBreath := Value;
  GetOwnerBridge.StandInCtrls;
end;

type
  Ts9ControlDefaults = class(TComponentList)
  private
    FDefaultWidth: Integer;
    FDefaultHeight: Integer;
    FLabelBreath: Integer;
    function FindCtrlByClassName(AClassName: string): TControl;
    function RegisterCtrl(AClassName: string): TControl;
  public
    procedure SetDefaultSize(AProto: Ts0ProtoTypeCtrl);
    property DefaultWidth: Integer read FDefaultWidth write FDefaultWidth;
    property DefaultHeight: Integer read FDefaultHeight write FDefaultHeight;
    property LabelBreath: Integer read FLabelBreath write FLabelBreath;
  end;

{ Ts9ControlDefaults }

function Ts9ControlDefaults.FindCtrlByClassName(
  AClassName: string): TControl;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := TControl(Self.Items[i]);
    if SameText(Result.ClassName, AClassName) then Exit;
  end;
  Result := nil;
end;

function Ts9ControlDefaults.RegisterCtrl(AClassName: string): TControl;
var
  cls: TPersistentClass;
begin
  Result := nil;
  cls := GetClass(AClassName);
  if cls = nil then Exit;
  if not cls.InheritsFrom(TControl) then Exit;
  Result := TControlClass(cls).Create(nil);
end;

procedure Ts9ControlDefaults.SetDefaultSize(AProto: Ts0ProtoTypeCtrl);
  procedure IncLabelBreath(var w, h: Integer);
  begin
    Inc(w, LabelBreath);
  end;
var
  ctrl: TControl;
  w, h: Integer;
begin
  ctrl := FindCtrlByClassName(AProto.CtrlClassName);
  if ctrl = nil then
    ctrl := RegisterCtrl(AProto.CtrlClassName);
  if ctrl = nil then
  begin
    w := DefaultWidth;
    h := DefaultHeight;
  end
  else
  begin
    w := ctrl.Width;
    h := ctrl.Height;
  end;
  IncLabelBreath(w, h);
  AProto.CtrlBounds.SetBounds(0, 0, w, h);
end;

{ Ts0ObjCtrlBridge }

procedure Ts0ObjCtrlBridge.ApplyCtrlClassNames;
var
  i: Integer;
  p: Ts0ProtoTypeCtrl;
  dummyCtrls: Ts9ControlDefaults;
begin
  dummyCtrls := Ts9ControlDefaults.Create(True);
  try
    dummyCtrls.DefaultWidth  := Builder.DefaultCtrlWidth ;
    dummyCtrls.DefaultHeight := Builder.DefaultCtrlHeight;
    dummyCtrls.LabelBreath := Builder.LabelBreath;
    for i := 0 to ProtoTypes.Count -1 do
    begin
      p := FProtoTypes.PropCtrls[i];
      p.ValidateCtrlClassName;
      dummyCtrls.SetDefaultSize( p );
    end;
  finally
    FreeAndNil(dummyCtrls);
  end;
end;

procedure Ts0ObjCtrlBridge.BeginUpdate;
var
  i: Integer;
begin
  for i := 0 to ProtoTypes.Count -1 do
    ProtoTypes.PropCtrls[i].SetUpdating(True);
end;

procedure Ts0ObjCtrlBridge.BuildCtrls;
begin
  Builder.Execute;
  LoadFromTarget;
end;

procedure Ts0ObjCtrlBridge.ClearCtrls;
var
  i: Integer;
begin
  for i := 0 to FProtoTypes.Count -1 do
    FProtoTypes.PropCtrls[i].FreeCtrl;
end;

constructor Ts0ObjCtrlBridge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProtoSourcePropName := 'ProtoTypes';
  FAutoUpdate := True;
  FBuilder := NewBuilder;
  FBuilder.CtrlOwner := AOwner;
  FProtoTypes := NewProtoTypes;
  FDisabledProps := TStringList.Create;
  FDisabledProps.Add('Name');
  FDisabledProps.Add('Tag');
end;

destructor Ts0ObjCtrlBridge.Destroy;
begin
  FreeAndNil(FDisabledProps);
  FreeAndNil(FProtoTypes);
  FreeAndNil(FWrapper);
  FreeAndNil(FBuilder);
  inherited Destroy;
end;

procedure Ts0ObjCtrlBridge.DoLoadObjFromCtrl(AObj: TObject;
  ACtrl: TControl);
begin
  if Assigned(FOnLoadObjFromCtrl) then
    FOnLoadObjFromCtrl(Self, AObj, ACtrl);
end;

procedure Ts0ObjCtrlBridge.DoSaveObjToCtrl(AObj: TObject;
  ACtrl: TControl);
begin
  if Assigned(FOnSaveObjToCtrl) then
    FOnSaveObjToCtrl(Self, AObj, ACtrl);
end;

procedure Ts0ObjCtrlBridge.DoStandInCtrls;
begin
  if Assigned(FOnStandInCtrls) then
    FOnStandInCtrls(Self);
end;

procedure Ts0ObjCtrlBridge.EndUpdate;
var
  i: Integer;
begin
  for i := 0 to ProtoTypes.Count -1 do
    ProtoTypes.PropCtrls[i].SetUpdating(False);
end;

function Ts0ObjCtrlBridge.GetCtrlClassNameByProp(AProto: Ts0ProtoTypeCtrl): String;
begin
  Result := Builder.CtrlOfType.GetCtrlClassNameByProto(AProto);
end;

function Ts0ObjCtrlBridge.GetProtoSource: Ts0PropertyProtoTypes;
var
  acsr: Ts0RTTIPublishedAccessor;
  cls: TClass;
begin
  Result := nil;
  if FProtoSourceCompo = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(FProtoSourceCompo);
  try
    if acsr.RTTINavigator.Props.PropByName(FProtoSourcePropName) = nil then Exit;
    cls := acsr.ObjectPropClass[FProtoSourcePropName];
    if cls = nil then Exit;
    if not cls.InheritsFrom(Ts0PropertyProtoTypes) then Exit;
    Result := Ts0PropertyProtoTypes( acsr.ObjectProp[FProtoSourcePropName] );
  finally
    FreeAndNil(acsr);
  end;
end;

function Ts0ObjCtrlBridge.GetTargetComponent: TComponent;
begin
  Result := nil;
  if Target is TComponent then
    Result := TComponent(Target);
end;

procedure Ts0ObjCtrlBridge.InitProtoCtrl(AProto: Ts0ProtoTypeCtrl);
begin
  Builder.CtrlOfType.InitCtrlByProto(AProto, AProto.Ctrl);
end;

procedure Ts0ObjCtrlBridge.Loaded;
begin
  inherited;
  LoadFromTarget;
end;

procedure Ts0ObjCtrlBridge.LoadFromTarget;
var
  i: Integer;
  p: Ts0ProtoTypeCtrl;
begin
  BeginUpdate;
  try
    for i := 0 to FProtoTypes.Count -1 do
    begin
      p := FProtoTypes.PropCtrls[i];
      p.LoadFromTarget;
      {
        p.DoLoadFromTargetはイベントの呼び出し。
        p.LoadFromTarget で呼び出したいところだけど、LoadFromTargetはoverrideされるので、
        イベントの呼び出しが面倒になっちゃう。
      }
      p.DoLoadFromTarget;
    end;
  finally
    EndUpdate;
  end;
end;

procedure Ts0ObjCtrlBridge.MakeDefualtProtoTypes;
  function IsDisabled(APropName: string): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    for i := 0 to FDisabledProps.Count -1 do
      if SameText(FDisabledProps.Strings[i], APropName) then
        Exit;
    Result := False;
  end;
  function LoadFromLayoutSet: Boolean;
  var
    layout: Ts0LayoutSetItem;
  begin
    Result := False;
    if FTarget = nil then Exit;
    if FLayoutSet = nil then Exit;
    layout := FLayoutSet.Items.ItemByName(FTarget.ClassName);
    if layout = nil then Exit;
    layout.Target := Self.ProtoTypes;
    layout.LayoutTargets;
    Result := True;
  end;
var
  i: Integer;
  props: Ts0RTTIProps;
  prop: Ts0RTTIProp;
  p: Ts0PropertyProtoType;
begin
  if FWrapper = nil then Exit;
  props := FWrapper.RTTINavigator.Props;
  for i := 0 to props.Count -1 do
  begin
    prop := props[i];
    if IsDisabled(prop.PropName) then Continue;
    p := FProtoTypes.AddProto(prop.PropName, prop.TypeInfo.TypeName, prop.PropName, 0);
    p.DataTypeKind := Ts0TypeKindHelper.GetWrappedTypeKind(p.TypeName, prop.TypeInfo.TypeKind);
    case p.DataTypeKind of
      wtk0Enumeration,
      wtk0Set:
        p.EnumMember.CommaText := prop.TypeInfo.GetNameList;
    end;
  end;
  ApplyCtrlClassNames;
  StandInCtrls;
  LoadFromLayoutSet;
end;

function Ts0ObjCtrlBridge.NewBuilder: Ts0ObjCtrlBuilder;
begin
  Result := Ts0ObjCtrlBuilder.Create(Self);
end;

function Ts0ObjCtrlBridge.NewProtoTypes: Ts0ProtoTypeCtrls;
begin
  Result := Ts0ProtoTypeCtrls.Create(Self, Ts0ProtoTypeCtrl);
end;

procedure Ts0ObjCtrlBridge.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FProtoTypes <> nil then
    FProtoTypes.Notification(AComponent, Operation);
  if Builder <> nil then
    Builder.Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if FLayoutSet = AComponent then
    FLayoutSet := nil;
end;

procedure Ts0ObjCtrlBridge.SaveToTarget;
var
  i: Integer;
  p: Ts0ProtoTypeCtrl;
begin
  for i := 0 to FProtoTypes.Count -1 do
  begin
    p := FProtoTypes.PropCtrls[i];
    p.SaveToTarget;
    {
      p.DoSaveToTargetはイベントの呼び出し。
      p.SaveToTarget で呼び出したいところだけど、SaveToTargetはoverrideされるので、
      イベントの呼び出しが面倒になっちゃう。
    }
    p.DoSaveToTarget;
  end;
end;

procedure Ts0ObjCtrlBridge.SetAutoUpdate(const Value: Boolean);
var
  i: Integer;
begin
  FAutoUpdate := Value;
  if [csLoading, csReading, csDesigning] * Self.ComponentState <> [] then Exit;
  for i := 0 to ProtoTypes.Count -1 do
    if FAutoUpdate then
      ProtoTypes.PropCtrls[i].SnatchEvents
    else
      ProtoTypes.PropCtrls[i].PutBackEvents;
end;

procedure Ts0ObjCtrlBridge.SetBuilder(const Value: Ts0ObjCtrlBuilder);
begin
  FBuilder.Assign(Value);
end;

procedure Ts0ObjCtrlBridge.SetDisabledProps(const Value: TStrings);
begin
  FDisabledProps.Assign(Value);
end;

procedure Ts0ObjCtrlBridge.SetLayoutSet(const Value: Ts0LayoutSet);
begin
  FLayoutSet := Value;
end;

procedure Ts0ObjCtrlBridge.SetProtoSource(
  const Value: Ts0PropertyProtoTypes);
begin
  if Value = nil then
  begin
    FProtoSourceCompo := nil;
    FProtoSourcePropName := '';
  end
  else
  begin
    FProtoSourceCompo := Value.OwnerComponent;
    FProtoSourcePropName := Value.PropName;
  end;
end;

procedure Ts0ObjCtrlBridge.SetProtoTypes(const Value: Ts0ProtoTypeCtrls);
begin
  FProtoTypes.Assign(Value);
end;

procedure Ts0ObjCtrlBridge.SetTarget(const Value: TObject);
begin
  FreeAndNil(FWrapper);
  FTarget := Value;
  if FTarget = nil then Exit;
  FWrapper := Ts0RTTIPublishedAccessor.Create(FTarget);
  if ProtoTypes.Count < 1 then
    MakeDefualtProtoTypes;
end;

procedure Ts0ObjCtrlBridge.SetTargetComponent(const Value: TComponent);
begin
  Target := Value;
end;

procedure Ts0ObjCtrlBridge.StandInCtrls;
  procedure GetCtrlParents(Dest: TObjectList);
  var
    i: Integer;
    p: Ts0ProtoTypeCtrl;
    prnt: TWinControl;
  begin
    Dest.Clear;
    Dest.OwnsObjects := False;
    for i := 0 to ProtoTypes.Count -1 do
    begin
      p := ProtoTypes.PropCtrls[i];
      prnt := p.CtrlParent;
      if Dest.IndexOf(prnt) > -1 then Continue;
      Dest.Add(prnt); //Destにはnilが入る可能性もある。
    end;
  end;
  procedure SortCtrlPosition(AParent: TObject);
  var
    proto: Ts0ProtoTypeCtrl;
    i: Integer;
    y: Integer;
    lastCtrl: Ts0PTCBounds;
  begin
    lastCtrl := nil;
    y := Builder.CtrlMargin;
    for i := 0 to ProtoTypes.Count -1 do
    begin
      if not(ProtoTypes.Items[i] is Ts0ProtoTypeCtrl) then Continue;
      proto := Ts0ProtoTypeCtrl(ProtoTypes.Items[i]);
      if proto.CtrlParent <> AParent then Continue;
      if proto.WithoutCtrl then Continue;
      if lastCtrl <> nil then
        y := lastCtrl.Top + lastCtrl.Height + Builder.CtrlMargin;
      proto.CtrlBounds.Top := y;
      proto.CtrlBounds.Left := Builder.CtrlMargin;
      if (proto.Ctrl <> nil) or (proto.CtrlClassName <> '') then
        lastCtrl := proto.CtrlBounds;
    end;
  end;
var
  parentList: TObjectList;
  i: Integer;
begin
  parentList := TObjectList.Create(False);
  try
    GetCtrlParents(parentList);
    for i := 0 to parentList.Count -1 do
      SortCtrlPosition( parentList.Items[i] );
  finally
    FreeAndNil(parentList);
  end;
  DoStandInCtrls;
end;

end.
