{-----------------------------------------------------------------------------
 Unit Name: c0EntityAdapter
 Author:    akima
 Purpose:
 TestCase: tc_c0EntityAdapter
 See: DBAdapt.pas
 $History: s0EntityAdapter.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/22   Time: 0:48
 * Updated in $/source/D6VCLIntegrated
 * ImplCanAddFieldClassをちゃんと実装した
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/01/25   Time: 8:00
 * Updated in $/source/D6VCLIntegrated
 * 各種不具合を修正
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/01/25   Time: 4:46
 * Updated in $/source/D6VCLIntegrated
 * 必要だと思われるField、Actionはできた。
-----------------------------------------------------------------------------}

unit s0EntityAdapter;

interface

uses
  SysUtils, Classes,
  WebAdapt, WebComp, SiteComp, WebCntxt, AdaptReq,
  Contnrs,
  s0dEntity,
  s0EntityPropProto,
  s0TypInfoWrapper,
  s0Entity;      

type
  K0EntityAdapterMode = (k0eamInsert, k0eamEdit, k0eamBrowse, k0eamQuery);
  K0EntityAdapterModes = set of K0EntityAdapterMode;

const
  c0EntityAdapterModeNames: array[K0EntityAdapterMode] of string =
    ('Insert', 'Edit', 'Browse', 'Query');

type
  Ts0EtyAdptrLocation = class
  private
    FValueOfID: string;
  public
    property ValueOfID: string read FValueOfID write FValueOfID;
  end;

type
  Ts0CustomEntityAdapter = class(TDefaultFieldsPagedAdapter, IGetRecordKeys,
    IAdapterMode, IGetDesigntimeWarnings, IGetAdapterModeNames)
  private
    FCurrentEntity: Ts0Entity;
    FEntityClass: Ts0EntityClass;
    FEntityClassName: string;
    FEntityDM: TDataModule;
    FEntityDMClass: Ts0dmEntityClass;
    FEntityDMClassName: string;
    FEntityIterator: Ts0EntityIterator;
    FShareDM: Boolean;
    FEntityManager: Ts0EntityManager;
    FWrapper: Ts0RTTIPublishedAccessor;
    FMode: K0EntityAdapterMode;
    FInDefaultMode: Boolean;
    FLoacation: Ts0EtyAdptrLocation;
    function GetCurrentEntity: Ts0Entity;
    function GetEntityClass: Ts0EntityClass;
    function GetEntityDM: Tdm0Entity;
    function GetEntityDMClass: Ts0dmEntityClass;
    function GetEntityIterator: Ts0EntityIterator;
    procedure SetEntityClass(const Value: Ts0EntityClass);
    procedure SetEntityClassName(const Value: string);
    procedure SetEntityDMClass(const Value: Ts0dmEntityClass);
    procedure SetEntityDMClassName(const Value: string);
    procedure SetShareDM(const Value: Boolean);
    procedure SetEntityManager(const Value: Ts0EntityManager);
    function GetWrapper: Ts0RTTIPublishedAccessor;
    function GetEntityManager: Ts0EntityManager;
    function GetProtoTypes: Ts0EntityPropProtos;
    procedure SetMode(const Value: K0EntityAdapterMode);
    function GetMode: K0EntityAdapterMode;
    procedure SetInDefaultMode(const Value: Boolean);
  protected
    function FindSharedEntityDM: Tdm0Entity; virtual;
    function NewEntity: Ts0Entity; virtual;
    function NewEntityDM: Tdm0Entity; virtual;
    function NewIterator: Ts0EntityIterator; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function StringToMode(const AValue: string): K0EntityAdapterMode;
    procedure ApplyAdapterMode(AActionRequest: IActionRequest);
    procedure AddDefaultActions(AComponents: TWebComponentList); override;
  protected
    { called from Action }
    procedure EncodeActionParams(AParams: IAdapterItemRequestParams); override;
    procedure ExtractRequestParams(ARequest: IUnknown); override;
    function GetDefaultMode: K0EntityAdapterMode; virtual;
    function LocateAndApply(AActionRequest: IActionRequest): Boolean;
  protected
    { about location }
    function Locate: Boolean;
    procedure GetKeyParams(AParams: Ts0EtyAdptrLocation);
    function SilentLocate(AParams: Ts0EtyAdptrLocation): Boolean;
  protected
    procedure GetKeyParamStrings(AValues: TStrings);
    { IGetDesigntimeWarnings }
    procedure GetDesigntimeWarnings(AWarnings: TAbstractDesigntimeWarnings);
    { IIteratorSupport }
    procedure ImplEndIterator(OwnerData: Pointer); override;
    function ImplNextIteration(var OwnerData: Pointer): Boolean; override;
    function ImplStartIterator(var OwnerData: Pointer): Boolean; override;
    { IGetRecordKeys }
    procedure GetRecordKeys(AValues: TStrings; var AFullyQualify: Boolean);
    procedure ImplGetRecordKeys(AValues: TStrings; var AFullyQualify: Boolean); virtual;
    { IWebActionsList }
    procedure ImplGetActionsList(AList: TStrings); override;
    { IWebDataFields }
    procedure ImplGetFieldsList(AList: TStrings); override;
    { IAdapterMode }
    function GetAdapterMode: string;
    procedure SetAdapterMode(const AValue: string);
    procedure RestoreDefaultAdapterMode;
    function GetNeedAdapterMode: Boolean;
    { IGetAdapterModeNames }
    procedure GetAdapterModeNames(AStrings: TStrings);
    { IAdapterEditor }
    function ImplCanAddFieldClass(AParent: TComponent; AClass: TClass): Boolean; override;
    function ImplCanAddActionClass(AParent: TComponent; AClass: TClass): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RaiseFieldChangedByAnotherUser(const AFieldName: string);
    procedure RaiseRowNotFound;
  public
    property CurrentEntity: Ts0Entity read GetCurrentEntity;
    property EntityClass: Ts0EntityClass read GetEntityClass write SetEntityClass;
    property EntityDM: Tdm0Entity read GetEntityDM;
    property EntityDMClass: Ts0dmEntityClass read GetEntityDMClass write SetEntityDMClass;
    property EntityIterator: Ts0EntityIterator read GetEntityIterator;
    property ProtoTypes: Ts0EntityPropProtos read GetProtoTypes;
    property Wrapper: Ts0RTTIPublishedAccessor read GetWrapper;
    {
      通常のDM上のコンポーネントをpublishedで宣言すると、プロパティを
      読み込むときに名前解決時に問題が生じちゃう。
      原因はよくわかんない。だってソースが複雑なんだもん。
    }
    property EntityManager: Ts0EntityManager read GetEntityManager write SetEntityManager;
    property InDefaultMode: Boolean read FInDefaultMode write SetInDefaultMode;
    property Loacation: Ts0EtyAdptrLocation read FLoacation;
    property Mode: K0EntityAdapterMode read GetMode write SetMode;
  published
    property ShareDM: Boolean read FShareDM write SetShareDM default False;
    property EntityClassName: string read FEntityClassName write SetEntityClassName;
    property EntityDMClassName: string read FEntityDMClassName write SetEntityDMClassName;
  end;

type
  Ts0BaseEntityAdapterField = class(TAdapterNamedField, IGetHTMLStyle,
    IUpdateValue, ICheckValueChange)
  private
    FFieldModes: K0EntityAdapterModes;
    FPropertyName: string;
    FOnGetDisplayText: TAdapterFieldGetStringEvent;
    FOnGetValue: TAdapterFieldGetValueEvent;
    function GetPropProto: Ts0EntityPropProto;
    function GetWrapper: Ts0RTTIPublishedAccessor;
  protected
    procedure SetPropertyName(const Value: string);
    procedure GetKeyParams(Params: Ts0EtyAdptrLocation);
    function GetReadOnly: Boolean;
    property PropProto: Ts0EntityPropProto read GetPropProto;
    property Wrapper: Ts0RTTIPublishedAccessor read GetWrapper;
  protected
    { IAdapterFieldAttributes }
    function ImplGetVisible: Boolean; override;
    function ImplGetRequired: Boolean; override;
    { IUpdateValue }
    procedure UpdateValue(AActionRequest: IActionRequest; AFieldIndex: Integer);
    procedure ImplUpdateValue(AActionRequest: IActionRequest; AFieldIndex: Integer); virtual;
    { ICheckOrigValue }
    procedure CheckOrigValue(AActionRequest: IActionRequest; AFieldIndex: Integer);
    procedure ImplCheckOrigValue(AActionRequest: IActionRequest; AFieldIndex: Integer); virtual;
    { ICheckValueChange }
    function CheckValueChange(AActionRequest: IActionRequest; AFieldIndex: Integer): Boolean;
    function ImplCheckValueChange(AActionRequest: IActionRequest; AFieldIndex: Integer): Boolean; virtual;
    { IGetHTMLStyle }
    function GetViewMode(const AAdapterMode: string): string;
    function GetDisplayStyle(const AAdapterMode: string): string;
    function GetInputStyle(const AAdapterMode: string): string;
    function GetInputStyleType(const AAdapterMode: string): TAdapterInputHTMLElementType; virtual;
    function GetDisplayStyleType(const AAdapterMode: string): TAdapterDisplayHTMLElementType; virtual;
    function GetViewModeType(const AAdapterMode: string): TAdapterDisplayViewModeType; virtual;
    { IWebAsFormatted }
    function ImplAsFormatted: string; override;
    { IWebGetFieldValue }
    procedure ImplSetFieldName(const Value: string); override;
    function ImplGetValue: Variant; override;
    { IWebGetDisplayWidth }
    function ImplGetDisplayWidth: Integer; override;
    { IWebGetDisplayLabel }
    function ImplGetDisplayLabel: string; override;
    function GetAdapter: Ts0CustomEntityAdapter;
    property Adapter: Ts0CustomEntityAdapter read GetAdapter;
    property PropertyName: string read FPropertyName write SetPropertyName;
  public
    constructor Create(AOwner: TComponent); override;
    property FieldModes: K0EntityAdapterModes read FFieldModes write FFieldModes
      default [k0eamInsert, k0eamEdit, k0eamBrowse, k0eamQuery];
    property OnGetValue: TAdapterFieldGetValueEvent read FOnGetValue write FOnGetValue;
    property OnGetDisplayText: TAdapterFieldGetStringEvent read FOnGetDisplayText write FOnGetDisplayText;
  end;

type
  Ts0BaseEntityAdapterInputField = class(Ts0BaseEntityAdapterField, IValidateValue)
  private
    FEchoActionFieldValue: Boolean;
    FOnValidateValue: TAdapterFieldValidateValueEvent;
    FOnUpdateValue: TAdapterFieldValueEvent;
  protected
    { IValidateValue }
    procedure ValidateValue(AActionRequest: IActionRequest; AFieldIndex: Integer);
    procedure ImplValidateValue(AActionRequest: IActionRequest; AFieldIndex: Integer); virtual;
    { IEchoActionFieldValue }
    procedure ImplSetEchoActionFieldValue(AValue: Boolean); override;
    function ImplGetEchoActionFieldValue: Boolean; override;
    function TestValueChange(const ANewValue: string): Boolean;
  public
    property OnUpdateValue: TAdapterFieldValueEvent read FOnUpdateValue write FOnUpdateValue;
    property OnValidateValue: TAdapterFieldValidateValueEvent read FOnValidateValue write FOnValidateValue;
  end;
  
type
  Ts0CustomEntityAdapterField = class(Ts0BaseEntityAdapterInputField,
    IWebGetFieldPrevValue, IGetAdapterValuesList, ICheckOrigValue)
  private
    FValuesList: IValuesListAdapter;
    procedure SetValuesList(const Value: IValuesListAdapter);
  protected
    function ImplGetValue: Variant; override;
    { IUpdateValue }
    procedure ImplUpdateValue(AActionRequest: IActionRequest; AFieldIndex: Integer); override;
    { ICheckOrigValue }
    procedure ImplCheckOrigValue(AActionRequest: IActionRequest; AFieldIndex: Integer); override;
    { ICheckValueChange }
    function ImplCheckValueChange(AActionRequest: IActionRequest;
      AFieldIndex: Integer): Boolean; override;
    { IGetHTMLStyle }
    function GetInputStyleType(const AAdapterMode: string): TAdapterInputHTMLElementType; override;
    { IGetAdapterValuesList }
    function GetAdapterValuesList: IValuesListAdapter;
    { IWebGetFieldPrevValue }
    function GetPrevValue: Variant;
    function ImplGetPrevValue: Variant; virtual;
    function GetNeedPrevValue: Boolean;
    function ImplGetNeedPrevValue: Boolean; virtual;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property ValuesList: IValuesListAdapter read FValuesList write SetValuesList;
  end;

type
  Ts0EntityAdapterField = class(Ts0CustomEntityAdapterField)
  published
    property FieldName;
    property ValuesList;
    property ViewAccess;
    property ModifyAccess;
    property FieldModes;
//    property FieldFlags;
    property OnGetValue;
    property OnUpdateValue;
    property OnValidateValue;
    property OnGetDisplayText;
  end;

type
  Ts0CustomEntityAdapterMemoField = class(Ts0BaseEntityAdapterInputField)
  protected
    function CheckOrUpdateValue(AActionRequest: IActionRequest;
      AFieldIndex: Integer; AUpdate: Boolean): Boolean;
    { IUpdateValue }
    procedure ImplUpdateValue(AActionRequest: IActionRequest; AFieldIndex: Integer); override;
    function ImplAsFormatted: string; override;
    { IGetHTMLStyle }
    function GetInputStyleType(const AAdapterMode: string): TAdapterInputHTMLElementType; override;
    { ICheckValueChange }
    function ImplCheckValueChange(AActionRequest: IActionRequest;
      AFieldIndex: Integer): Boolean; override;
    { IWebGetFieldPrevValue }
    function ImplGetValue: Variant; override;
  end;

type
  Ts0EntityAdapterMemoField = class(Ts0CustomEntityAdapterMemoField)
  published
//    property DataSetField;
    property ViewAccess;
    property ModifyAccess;
    property FieldModes;
//    property FieldFlags;
    property OnGetValue;
    property OnUpdateValue;
    property OnValidateValue;
    property OnGetDisplayText;
  end;

type
  Ts0CustomEntityAdapterAction = class(TImplementedAdapterAction)
  private
    FActionModes: K0EntityAdapterModes;
    function GetAdapter: Ts0CustomEntityAdapter;
  protected
    property Adapter: Ts0CustomEntityAdapter read GetAdapter;
    { IAdapterActionAttributes }
    function ImplGetVisible: Boolean; override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    property ActionModes: K0EntityAdapterModes read FActionModes write FActionModes
      default [k0eamInsert, k0eamEdit, k0eamBrowse, k0eamQuery];
  published
    property OnGetEnabled;
  end;

type
  Ts0CustomEntityAdapterRowAction = class(Ts0CustomEntityAdapterAction)
  protected
    { IGetAdapterItemRequestParams }
    procedure ImplGetAdapterItemRequestParams(var AIdentifier: string; Params: IAdapterItemRequestParams); override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    property ActionModes default [k0eamInsert, k0eamEdit, k0eamBrowse {, k0eamQuery}];
  end;

type
  Ts0EntityAdapterRowAction = class(Ts0CustomEntityAdapterAction)
  protected
    procedure ImplExecuteActionRequest(
      AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IGetAdapterItemRequestParams }
    procedure ImplGetAdapterItemRequestParams(var AIdentifier: string; Params: IAdapterItemRequestParams); override;
  end;

type
  Ts0EntityAdapterDeleteRowAction  = class(Ts0CustomEntityAdapterRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(
      AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
  end;

type
  Ts0EntityAdapterMoveRowAction = class(Ts0CustomEntityAdapterRowAction)
  private
    function GetIterator: Ts0EntityIterator;
  protected
    property Iterator: Ts0EntityIterator read GetIterator;
    { IWebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
  end;

type
  Ts0EntityAdapterNextRowAction    = class(Ts0EntityAdapterMoveRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterPrevRowAction    = class(Ts0EntityAdapterMoveRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterFirstRowAction   = class(Ts0EntityAdapterMoveRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterLastRowAction    = class(Ts0EntityAdapterMoveRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterNewRowAction     = class(Ts0EntityAdapterRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterCancelRowAction  = class(Ts0CustomEntityAdapterRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterApplyRowAction   = class(Ts0CustomEntityAdapterRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterRefreshRowAction = class(Ts0CustomEntityAdapterRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { WebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterEditRowAction    = class(Ts0CustomEntityAdapterRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  end;

type
  Ts0EntityAdapterBrowseRowAction  = class(Ts0CustomEntityAdapterRowAction)
  protected
    function GetDefaultActionName: string; override;
    procedure ImplExecuteActionRequest(AActionRequest: IActionRequest; AActionResponse: IActionResponse); override;
    { IWebIsDefaultAction }
    function ImplIsDefaultAction(ADisplay: TObject): Boolean; override;
    { IWebEnabled }
    function ImplWebEnabled: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    property ActionModes default [k0eamInsert, k0eamEdit, k0eamBrowse, k0eamQuery];
  end;

type
  Ts0EntityAdapter = class(Ts0CustomEntityAdapter)
  end;
    
type
  Ts0SharedEntityDMBroker = class
  private
    FDMList: TThreadList;
  public
    constructor Create;
    destructor Destroy; override;
    function FindDMByClass(ADMClass: Ts0dmEntityClass): Tdm0Entity;
    procedure RegisterDM(ADM: Tdm0Entity);
    procedure UnRegisterDM(ADM: Tdm0Entity);
    class function Instance: Ts0SharedEntityDMBroker;
  end;

type
  Ts0EtyManContextMap = class
  private
    FRelations: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddRelation(AContext: TAbstractWebContext; AEntityMan: Ts0EntityManager);
    function FindManagerByClass(AContext: TAbstractWebContext; AClass: Ts0EntityClass): Ts0EntityManager;
    function FindManagerByClassID(AContext: TAbstractWebContext; AClassID: Integer): Ts0EntityManager;
    function FindManagerByClassName(AContext: TAbstractWebContext; AClassName: String): Ts0EntityManager;
    function GetContext(AManager: Ts0EntityManager): TAbstractWebContext;
    procedure RemoveRelation(AEntityMan: Ts0EntityManager);
  end;

type
  Ts0WebContextEntityManBroker = class(Ts0AbstractEntityManBroker)
  private
    FEtyManMap: Ts0EtyManContextMap;
  protected
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

function GetEntityAdapter(AComponent: TComponent): Ts0CustomEntityAdapter;
function GetManagerOf(ADM: Tdm0Entity): Ts0EntityManager;

procedure Register;

implementation

uses
  Variants,
  WebDisp,
  SiteConst, s0Iterator;

const
  c9EntityAdapterDeleteAction  = 'DeleteRow' ; // Do not localize
  c9EntityAdapterNextAction    = 'NextRow'   ; // Do not localize
  c9EntityAdapterPrevAction    = 'PrevRow'   ; // Do not localize
  c9EntityAdapterLastAction    = 'LastRow'   ; // Do not localize
  c9EntityAdapterFirstAction   = 'FirstRow'  ; // Do not localize
  c9EntityAdapterNewAction     = 'NewRow'    ; // Do not localize
  c9EntityAdapterCancelAction  = 'Cancel'    ; // Do not localize
  c9EntityAdapterApplyAction   = 'Apply'     ; // Do not localize
  c9EntityAdapterRefreshAction = 'RefreshRow'; // Do not localize
  c9EntityAdapterEditAction    = 'EditRow'   ; // Do not localize
  c9EntityAdapterBrowseAction  = 'BrowseRow' ; // Do not localize

procedure Register;
begin
  RegisterComponents('P Web', [Ts0EntityAdapter]);
  //RegisterNoIcon([Ts0EntityAdapterField]);
  RegisterWebComponents([Ts0EntityAdapterField]);
  { Actions }
{
  RegisterNoIcon([
    Ts0EntityAdapterDeleteRowAction,
    Ts0EntityAdapterNextRowAction,
    Ts0EntityAdapterPrevRowAction,
    Ts0EntityAdapterLastRowAction,
    Ts0EntityAdapterFirstRowAction,
    Ts0EntityAdapterNewRowAction,
    Ts0EntityAdapterCancelRowAction,
    Ts0EntityAdapterApplyRowAction,
    Ts0EntityAdapterRefreshRowAction,
    Ts0EntityAdapterEditRowAction,
    Ts0EntityAdapterBrowseRowAction
  ]);
}
  RegisterWebComponents([
    Ts0EntityAdapterDeleteRowAction,
    Ts0EntityAdapterNextRowAction,
    Ts0EntityAdapterPrevRowAction,
    Ts0EntityAdapterLastRowAction,
    Ts0EntityAdapterFirstRowAction,
    Ts0EntityAdapterNewRowAction,
    Ts0EntityAdapterCancelRowAction,
    Ts0EntityAdapterApplyRowAction,
    Ts0EntityAdapterRefreshRowAction,
    Ts0EntityAdapterEditRowAction,
    Ts0EntityAdapterBrowseRowAction
  ]);
end;

function GetEntityAdapter(AComponent: TComponent): Ts0CustomEntityAdapter;
begin
  Result := nil;
  if AComponent = nil then Exit;
  if AComponent.GetParentComponent is Ts0CustomEntityAdapter then
    Result := Ts0CustomEntityAdapter(AComponent.GetParentComponent)
  else
    Result := GetEntityAdapter(AComponent.GetParentComponent);
end;

function GetManagerOf(ADM: Tdm0Entity): Ts0EntityManager;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ADM.ComponentCount -1 do
  begin
    if ADM.Components[i] is Ts0EntityManager then
    begin
      Result := Ts0EntityManager(ADM.Components[i]);
      Exit;
    end;
  end;
end;

procedure ListEntityActions(AAdapter: Ts0CustomEntityAdapter; AList: TStrings);
begin
  Assert(AList.Count = 0);
  AList.AddObject(c9EntityAdapterDeleteAction , TObject(Ts0EntityAdapterDeleteRowAction));
  AList.AddObject(c9EntityAdapterFirstAction  , TObject(Ts0EntityAdapterFirstRowAction));
  AList.AddObject(c9EntityAdapterPrevAction   , TObject(Ts0EntityAdapterPrevRowAction));
  AList.AddObject(c9EntityAdapterNextAction   , TObject(Ts0EntityAdapterNextRowAction));
  AList.AddObject(c9EntityAdapterLastAction   , TObject(Ts0EntityAdapterLastRowAction));
  AList.AddObject(c9EntityAdapterEditAction   , TObject(Ts0EntityAdapterEditRowAction));
  AList.AddObject(c9EntityAdapterBrowseAction , TObject(Ts0EntityAdapterBrowseRowAction));
  AList.AddObject(c9EntityAdapterNewAction    , TObject(Ts0EntityAdapterNewRowAction));
  AList.AddObject(c9EntityAdapterCancelAction , TObject(Ts0EntityAdapterCancelRowAction));
  AList.AddObject(c9EntityAdapterApplyAction  , TObject(Ts0EntityAdapterApplyRowAction));
  AList.AddObject(c9EntityAdapterRefreshAction, TObject(Ts0EntityAdapterRefreshRowAction));
  if AAdapter.PageSize > 0 then
  begin
    AList.AddObject(sPrevPageAction, TObject(TAdapterPrevPageAction));
    AList.AddObject(sGotoPageAction, TObject(TAdapterGotoPageAction));
    AList.AddObject(sNextPageAction, TObject(TAdapterNextPageAction));
  end;
end;

procedure AddDefaultEntityActions(AAdapter: Ts0CustomEntityAdapter; AComponents: TWebComponentList);
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
    ListEntityActions(AAdapter, sl);
    AddDefaultActions(sl, AComponents);
  finally
    FreeAndNil(sl);
  end;
end;

{ Ts0CustomEntityAdapter }

procedure Ts0CustomEntityAdapter.AddDefaultActions(
  AComponents: TWebComponentList);
begin
  AddDefaultEntityActions(Self, AComponents);
end;

procedure Ts0CustomEntityAdapter.ApplyAdapterMode(
  AActionRequest: IActionRequest);
var
  Mode: string;
  Intf: IAdapterModes;
begin
  Assert( Supports(AActionRequest, IAdapterModes, Intf) );
  if Intf.FindAdapterMode(Self, Mode) then
    SetAdapterMode(Mode)
  else
    RestoreDefaultAdapterMode;
end;

constructor Ts0CustomEntityAdapter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShareDM := False;
  FInDefaultMode := False;
  FLoacation := Ts0EtyAdptrLocation.Create;
end;

destructor Ts0CustomEntityAdapter.Destroy;
begin
  FreeAndNil(FLoacation);
  FreeAndNil(FWrapper);
  FreeAndNil(FEntityIterator);
  FreeAndNil(FCurrentEntity);
  FreeAndNil(FEntityDM);
  inherited;
end;

const
  c9EtyLocateParam = '_el';

procedure Ts0CustomEntityAdapter.EncodeActionParams(
  AParams: IAdapterItemRequestParams);
begin
  inherited EncodeActionParams(AParams);
  Assert(ProtoTypes <> nil);
  if ProtoTypes.IDProp = nil then Exit;
  AParams.ParamValues.Add(
    Format('%s=%s', [
      c9EtyLocateParam,
      Wrapper.PropAsString[ ProtoTypes.IDProp.PropertyName ]
    ])
  );
end;

procedure Ts0CustomEntityAdapter.ExtractRequestParams(
  ARequest: IInterface);
var
  prm: IAdapterRequestParams;
begin
  Assert( Supports(ARequest, IAdapterRequestParams, prm) );
  if prm <> nil then
    if ProtoTypes.IDProp <> nil then
    begin
      Wrapper.PropAsString[ ProtoTypes.IDProp.PropertyName ] :=
        prm.ValueOfParam(c9EtyLocateParam);
      //
      Self.Loacation.ValueOfID := prm.ValueOfParam(c9EtyLocateParam);
    end;
  inherited ExtractRequestParams(ARequest);
end;

function Ts0CustomEntityAdapter.FindSharedEntityDM: Tdm0Entity;
begin
  Result := Ts0SharedEntityDMBroker.Instance.FindDMByClass(FEntityDMClass);
end;

function Ts0CustomEntityAdapter.GetAdapterMode: string;
begin
  if InDefaultMode then
    Result := ''
  else                                
    Result := c0EntityAdapterModeNames[GetMode];
end;

procedure Ts0CustomEntityAdapter.GetAdapterModeNames(AStrings: TStrings);
var
  i: K0EntityAdapterMode;
begin
  for i := Low(K0EntityAdapterMode) to High(K0EntityAdapterMode) do
    AStrings.Add(c0EntityAdapterModeNames[i]);
end;

function Ts0CustomEntityAdapter.GetCurrentEntity: Ts0Entity;
begin
  if FCurrentEntity = nil then
  begin
    FCurrentEntity := NewEntity;
    FCurrentEntity.FreeNotification(Self);
  end;
  Result := FCurrentEntity;
end;

function Ts0CustomEntityAdapter.GetDefaultMode: K0EntityAdapterMode;
begin
  Result := k0eamBrowse;
end;

procedure Ts0CustomEntityAdapter.GetDesigntimeWarnings(
  AWarnings: TAbstractDesigntimeWarnings);
begin
{
  if DataSet = nil then
    AWarnings.AddString(Format(sDataSetPropertyIsNil, [Self.Name]));
  if (DataSet <> nil) and (DataSet.Active = True) then
    if GetKeyFields = '' then
      AWarnings.AddString(Format(sDataSetUnknownKeyFields, [Self.Name, DataSet.Name]));
  if (DataSet <> nil) and (not DataSet.Active) then
    AWarnings.AddString(Format(sDataSetNotActive, [Self.Name, DataSet.Name]));
}
end;

function Ts0CustomEntityAdapter.GetEntityClass: Ts0EntityClass;
begin
  if FEntityClass = nil then
    FEntityClass := Ts0EntityRegister.GetEntityClassByName(FEntityClassName);
  Result := FEntityClass;
end;

function Ts0CustomEntityAdapter.GetEntityDM: Tdm0Entity;
begin
  if FEntityDM = nil then
  begin
    if FShareDM then
    begin
      FEntityDM := FindSharedEntityDM;
      if FEntityDM = nil then
      begin
        FEntityDM := NewEntityDM;
        Ts0SharedEntityDMBroker.Instance.RegisterDM(FEntityDM);
      end;
    end
    else
    begin
      FEntityDM := NewEntityDM;
    end;
    if FEntityDM <> nil then
      FEntityDM.FreeNotification(Self);
  end;
  Result := FEntityDM;
end;

function Ts0CustomEntityAdapter.GetEntityDMClass: Ts0dmEntityClass;
  function GetEntityDMClass(AName: string): Ts0dmEntityClass;
  var
    cls: TPersistentClass;
  begin
    Result := nil;
    //cls := GetClass(AName);
    cls := Ts0EntityDMClassBroker.Instance.FindEntityDMClassByName(AName);
    if cls = nil then Exit;
    if not cls.InheritsFrom(Tdm0Entity) then Exit;
    Result := Ts0dmEntityClass(cls);
  end;
begin
  if FEntityDMClass = nil then
    FEntityDMClass := GetEntityDMClass(FEntityDMClassName);
  Result := FEntityDMClass;
end;

function Ts0CustomEntityAdapter.GetEntityIterator: Ts0EntityIterator;
begin
  if FEntityIterator = nil then
    FEntityIterator := NewIterator;
  Result := FEntityIterator;
end;

function Ts0CustomEntityAdapter.GetEntityManager: Ts0EntityManager;
begin
  Result := nil;
  if csDesigning in Self.ComponentState then
  begin
    //Result := FEntityManager;
    Result := Ts0EntityManBroker.Instance.GetManagerByClassName(FEntityClassName);
  end
  else
  begin         
    if [csLoading] * Self.ComponentState <> [] then Exit;
    if FEntityManager = nil then
      FEntityManager := GetManagerOf(EntityDM);
    Result := FEntityManager;
  end;
end;

procedure Ts0CustomEntityAdapter.GetKeyParams(AParams: Ts0EtyAdptrLocation);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    GetKeyParamStrings(sl);
    if sl.Count > 0 then
      AParams.ValueOfID := sl.Values[ sl.Names[0] ];
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0CustomEntityAdapter.GetKeyParamStrings(AValues: TStrings);
var
  pn: string;
begin
  AValues.Clear;
  if ProtoTypes = nil then Exit;
  if ProtoTypes.IDProp = nil then Exit;
  pn := ProtoTypes.IDProp.PropertyName;
  AValues.Values[ pn ] := Wrapper.PropAsString[ pn ];
end;

function Ts0CustomEntityAdapter.GetMode: K0EntityAdapterMode;
var
  Mode: string;
  AdapterModes: IAdapterModes;
begin
  if GetEchoActionFieldValues then
  begin
    if Supports(WebContext.AdapterRequest, IAdapterModes, AdapterModes) and
      AdapterModes.FindAdapterMode(Self, Mode) then
      Result := StringToMode(Mode)
    else
      Result := GetDefaultMode
  end
  else
  begin
    if InDefaultMode then
      Result := GetDefaultMode
    else
      Result := FMode;
  end;
end;

function Ts0CustomEntityAdapter.GetNeedAdapterMode: Boolean;
begin
  Result := True;
end;

function Ts0CustomEntityAdapter.GetProtoTypes: Ts0EntityPropProtos;
begin
  Result := nil;
  if EntityManager = nil then Exit;
  Result := EntityManager.ProtoTypes;
end;

procedure Ts0CustomEntityAdapter.GetRecordKeys(AValues: TStrings;
  var AFullyQualify: Boolean);
begin
  ImplGetRecordKeys(AValues, AFullyQualify);
end;

function Ts0CustomEntityAdapter.GetWrapper: Ts0RTTIPublishedAccessor;
begin
  if FWrapper = nil then
    FWrapper := Ts0RTTIPublishedAccessor.Create(CurrentEntity);
  Result := FWrapper;
end;

function Ts0CustomEntityAdapter.ImplCanAddActionClass(AParent: TComponent;
  AClass: TClass): Boolean;
begin
  Result := inherited ImplCanAddActionClass(AParent, AClass);
  if Result then Exit;
  Result := AClass.InheritsFrom(Ts0CustomEntityAdapterAction);
end;

function Ts0CustomEntityAdapter.ImplCanAddFieldClass(AParent: TComponent;
  AClass: TClass): Boolean;
begin
  Result := inherited ImplCanAddFieldClass(AParent, AClass);
  if Result then Exit;
  Result := AClass.InheritsFrom(Ts0BaseEntityAdapterField);
end;

procedure Ts0CustomEntityAdapter.ImplEndIterator(OwnerData: Pointer);
begin
  inherited ImplEndIterator(OwnerData);
  if EntityManager <> nil then
    EntityManager.UnPrepareList;
end;

procedure Ts0CustomEntityAdapter.ImplGetActionsList(AList: TStrings);
begin
  ListEntityActions(Self, AList);
end;

procedure Ts0CustomEntityAdapter.ImplGetFieldsList(AList: TStrings);
var
  i: Integer;
  p: Ts0EntityPropProto;
begin
  //inherited ImplGetFieldsList(AList);
  AList.Clear;
  if ProtoTypes = nil then Exit;
  Assert(ProtoTypes <> nil);
  for i := 0 to ProtoTypes.Count -1 do
  begin
    p := ProtoTypes.Items[i];
    case p.DataTypeKind of
      wtk0Strings:
        AList.AddObject(p.PropertyName, TObject(Ts0EntityAdapterMemoField));
    else
      AList.AddObject(p.PropertyName, TObject(Ts0EntityAdapterField));
    end;
  end;
end;

procedure Ts0CustomEntityAdapter.ImplGetRecordKeys(AValues: TStrings;
  var AFullyQualify: Boolean);
begin
  GetKeyParamStrings(AValues);
end;

function Ts0CustomEntityAdapter.ImplNextIteration(
  var OwnerData: Pointer): Boolean;
begin
  if EntityIterator = nil then
    Result := inherited ImplNextIteration(OwnerData)
  else
  begin
    EntityIterator.Next;
    EntityIterator.AssignCurrent(FCurrentEntity);
    Result := EntityIterator.HasNext;
  end;
end;

function Ts0CustomEntityAdapter.ImplStartIterator(
  var OwnerData: Pointer): Boolean;
begin
  if EntityManager <> nil then
    EntityManager.PrepareList;
  if EntityIterator = nil then
    Result := inherited ImplStartIterator(OwnerData)
  else
  begin
    EntityIterator.First;
    EntityIterator.AssignCurrent(CurrentEntity);
    Result := EntityIterator.HasNext;
  end; 
end;

function Ts0CustomEntityAdapter.Locate: Boolean;
begin
  try
    if not SilentLocate(Loacation) then
      RaiseRowNotFound;
  except
    // Add to error list
    on E: Exception do
    begin
      Errors.AddError(E);
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function Ts0CustomEntityAdapter.LocateAndApply(
  AActionRequest: IActionRequest): Boolean;
  function ExecInsertAndUpdate: Boolean;
  begin
    SilentLocate(Loacation);
{
    if DataSet = nil then
      Self.RaiseNilDataSet;
    DataSet.Open;
    DataSet.Insert;
    // Update even if locate fails
}
    Result := UpdateRecords(AActionRequest);
  end;
  procedure ExecEdit;
  var
    ActionFieldValuesOfAdapter: IActionFieldValuesOfAdapter;
  begin
    if SilentLocate(Loacation) then
    begin
      if Supports(AActionRequest, IActionFieldValuesOfAdapter, ActionFieldValuesOfAdapter) then
      begin
        Result := UpdateRecords(AActionRequest)
      end
      else
        Result := UpdateRecords(AActionRequest);
      // Relocate in case we updated repositioned during update
      //SilentLocate(Loacation);
    end
    else
      Self.RaiseRowNotFound
  end;
  procedure ExecBrowse;
  begin
    CurrentEntity.Load;
    Result := Locate;
  end;
var
  lMode: K0EntityAdapterMode;
begin
  ExtractRequestParams(AActionRequest);
  Result := True;
  try
    ApplyAdapterMode(AActionRequest);
    lMode := Mode;
    case lMode of
      k0eamInsert: ExecInsertAndUpdate;
      k0eamEdit  : ExecEdit;
    else
      ExecBrowse;
    end;
  except
    on E: Exception do
    begin
      Self.Errors.AddError(E);
      Result := False;
      Exit;
    end;
  end;
  if Result and (lMode = k0eamInsert) then
    Mode := k0eamEdit;
end;

function Ts0CustomEntityAdapter.NewEntity: Ts0Entity;
begin
  Result := nil;
  if EntityClass = nil then Exit;
  Result := EntityClass.Create(Self);
  if EntityDM = nil then Exit;
  Result.Manager := GetManagerOf(EntityDM);
  if Result.Manager = nil then Exit;
  Result.Manager.RegisterNewEntity(Result);
end;

function Ts0CustomEntityAdapter.NewEntityDM: Tdm0Entity;
begin
  Result := nil;
  if EntityDMClass = nil then Exit;
  Result := EntityDMClass.Create(nil);
end;

function Ts0CustomEntityAdapter.NewIterator: Ts0EntityIterator;
var
  em: Ts0EntityManager;
begin
  Result := nil;
  if EntityDM = nil then Exit;
  em := GetManagerOf(EntityDM);
  if em = nil then Exit;
  Result := em.NewIterator;
end;

procedure Ts0CustomEntityAdapter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if FCurrentEntity = AComponent then
  begin
    FCurrentEntity := nil;
    FreeAndNil(FWrapper);
  end;
  if FEntityDM = AComponent then
    FEntityDM := nil;
  if FEntityManager = AComponent then
    FEntityManager := nil;
end;

procedure Ts0CustomEntityAdapter.RaiseFieldChangedByAnotherUser(
  const AFieldName: string);
begin
  raise EAdapterFieldException.Create(sFieldChangedByAnotherUser,
    AFieldName);
end;

resourcestring
  c9ErrMsg_RowNotFound = '指定されたEntityは見つかりませんでした';

procedure Ts0CustomEntityAdapter.RaiseRowNotFound;
begin
  raise EAdapterException.Create(c9ErrMsg_RowNotFound);
end;

procedure Ts0CustomEntityAdapter.RestoreDefaultAdapterMode;
begin
  InDefaultMode := True;
end;

procedure Ts0CustomEntityAdapter.SetAdapterMode(const AValue: string);
begin
  if AValue = '' then
    InDefaultMode := True
  else
    Mode := StringToMode(AValue);
end;

procedure Ts0CustomEntityAdapter.SetEntityClass(const Value: Ts0EntityClass);
begin
  FEntityClass := Value;
  if FEntityClass <> nil then
    FEntityClassName := FEntityClass.ClassName;
end;

procedure Ts0CustomEntityAdapter.SetEntityClassName(const Value: string);
begin
  FEntityClassName := Value;
end;

procedure Ts0CustomEntityAdapter.SetEntityDMClass(const Value: Ts0dmEntityClass);
begin
  FEntityDMClass := Value;
  if FEntityDMClass <> nil then
    FEntityDMClassName := FEntityDMClass.ClassName;
end;

procedure Ts0CustomEntityAdapter.SetEntityDMClassName(const Value: string);
begin
  FEntityDMClassName := Value;
end;

procedure Ts0CustomEntityAdapter.SetEntityManager(const Value: Ts0EntityManager);
begin
  if csDesigning in Self.ComponentState then
  begin
    FEntityManager := Value;
    if FEntityManager = nil then Exit;
      EntityClassName := FEntityManager.EntityClassName;
    if FEntityManager.Owner is TDataModule then
      EntityDMClassName := FEntityManager.Owner.ClassName
  end;
end;

procedure Ts0CustomEntityAdapter.SetInDefaultMode(const Value: Boolean);
begin
  FInDefaultMode := Value;
  FMode := GetDefaultMode;
end;

procedure Ts0CustomEntityAdapter.SetMode(const Value: K0EntityAdapterMode);
begin
  FInDefaultMode := False;
  if FMode <> Value then
    FMode := Value;
end;

procedure Ts0CustomEntityAdapter.SetShareDM(const Value: Boolean);
begin
  FShareDM := Value;
end;

function Ts0CustomEntityAdapter.SilentLocate(
  AParams: Ts0EtyAdptrLocation): Boolean;
begin
  CurrentEntity.ID := StrToIntDef(Loacation.ValueOfID, 0);
  CurrentEntity.NotFound := False;
  CurrentEntity.Restored := False;
  CurrentEntity.Load;
  Result := not CurrentEntity.NotFound;
end;

function Ts0CustomEntityAdapter.StringToMode(
  const AValue: string): K0EntityAdapterMode;
var
  i: K0EntityAdapterMode;
begin
  if AValue = '' then
    Result := GetDefaultMode
  else
  begin
    for i := Low(K0EntityAdapterMode) to High(K0EntityAdapterMode) do
    begin
      if SameText(c0EntityAdapterModeNames[i], AValue) then
      begin
        Result := i;
        Exit;
      end;
    end;
    raise EAdapterException.CreateFmt(sUnknownAdapterMode, [AValue]);
  end;
end;

{ Ts0BaseEntityAdapterField }

procedure Ts0BaseEntityAdapterField.CheckOrigValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
begin
  ImplCheckOrigValue(AActionRequest, AFieldIndex);
end;

function Ts0BaseEntityAdapterField.CheckValueChange(
  AActionRequest: IActionRequest; AFieldIndex: Integer): Boolean;
begin
  Result := ImplCheckValueChange(AActionRequest, AFieldIndex);
end;

constructor Ts0BaseEntityAdapterField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FieldModes := [k0eamInsert, k0eamEdit, k0eamBrowse, k0eamQuery];
end;

function Ts0BaseEntityAdapterField.GetAdapter: Ts0CustomEntityAdapter;
begin
  Result := GetEntityAdapter(Self);
end;

function Ts0BaseEntityAdapterField.GetDisplayStyle(
  const AAdapterMode: string): string;
begin
  Result := AdapterDisplayHTMLElementTypeNames[GetDisplayStyleType(AAdapterMode)]
end;

function Ts0BaseEntityAdapterField.GetDisplayStyleType(
  const AAdapterMode: string): TAdapterDisplayHTMLElementType;
begin
  Result := htmldText;
end;

function Ts0BaseEntityAdapterField.GetInputStyle(
  const AAdapterMode: string): string;
begin
  Result := AdapterInputHTMLElementTypeNames[GetInputStyleType(AAdapterMode)];
end;

function Ts0BaseEntityAdapterField.GetInputStyleType(
  const AAdapterMode: string): TAdapterInputHTMLElementType;
begin
  Result := htmliTextInput;
end;

procedure Ts0BaseEntityAdapterField.GetKeyParams(Params: Ts0EtyAdptrLocation);
begin
  if Adapter = nil then Exit;
  Adapter.GetKeyParams(Params);
end;

function Ts0BaseEntityAdapterField.GetPropProto: Ts0EntityPropProto;
begin
  Result := nil;
  if Adapter = nil then Exit;
  if Adapter.ProtoTypes = nil then Exit;
  Result := Adapter.ProtoTypes.FindByName(PropertyName);
end;

function Ts0BaseEntityAdapterField.GetReadOnly: Boolean;
begin
  Result := (Adapter.Mode = k0eamBrowse);
end;

function Ts0BaseEntityAdapterField.GetViewMode(
  const AAdapterMode: string): string;
begin
  Result := AdapterDisplayViewModeTypeNames[GetViewModeType(AAdapterMode)];
end;

function Ts0BaseEntityAdapterField.GetViewModeType(
  const AAdapterMode: string): TAdapterDisplayViewModeType;
const
  c9DispViewArray: array[K0EntityAdapterMode] of TAdapterDisplayViewModeType =(
    htmlvmInput, htmlvmInput, htmlvmDisplay, htmlvmInput
  );
var
  m: K0EntityAdapterMode;
begin
  if GetReadOnly then
    Result := htmlvmDisplay
  else
  begin
    if Adapter <> nil then
      m := Adapter.StringToMode(AAdapterMode)
    else
      m := k0eamBrowse;
    Result := c9DispViewArray[m];
  end;
end;

function Ts0BaseEntityAdapterField.GetWrapper: Ts0RTTIPublishedAccessor;
begin
  if Adapter = nil then
    Result := nil
  else
    Result := Adapter.Wrapper;
end;

function Ts0BaseEntityAdapterField.ImplAsFormatted: string;
begin
  Result := '';
  if FPropertyName = '' then Exit;
  if Wrapper = nil then Exit;
  if not Wrapper.PropertyExists(FPropertyName) then Exit;
  Result := Wrapper.PropAsString[FPropertyName];
  if Assigned(OnGetDisplayText) then
    OnGetDisplayText(Self, Result)
end;

procedure Ts0BaseEntityAdapterField.ImplCheckOrigValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
begin
  // Do nothing
end;

function Ts0BaseEntityAdapterField.ImplCheckValueChange(
  AActionRequest: IActionRequest; AFieldIndex: Integer): Boolean;
begin
  Result := False;
end;

function Ts0BaseEntityAdapterField.ImplGetDisplayLabel: string;
begin
  if PropProto = nil then
    Result := FPropertyName
  else
    Result := PropProto.JPName;
end;

function Ts0BaseEntityAdapterField.ImplGetDisplayWidth: Integer;
begin
  Result := -1;
end;

function Ts0BaseEntityAdapterField.ImplGetRequired: Boolean;
begin
  if PropProto = nil then
    Result := False
  else
    Result := PropProto.IsRequired;
end;

function Ts0BaseEntityAdapterField.ImplGetValue: Variant;
begin
  Result := Unassigned;
  if Wrapper = nil then Exit;
  CheckViewAccess;
  Result := Wrapper.PropAsVariant[FPropertyName];
  if Assigned(OnGetValue) then
    OnGetValue(Self, Result);
end;

function Ts0BaseEntityAdapterField.ImplGetVisible: Boolean;
begin
  Result := Adapter.Mode in FieldModes;
end;

procedure Ts0BaseEntityAdapterField.ImplSetFieldName(const Value: string);
begin
  FPropertyName := Value;
  inherited ImplSetFieldName(MakeValidAdapterFieldName(FPropertyName));
end;

procedure Ts0BaseEntityAdapterField.ImplUpdateValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
begin
  // Do nothing
end;

procedure Ts0BaseEntityAdapterField.SetPropertyName(const Value: string);
begin
  if FPropertyName = Value then Exit;
  FieldName := Value;
end;

procedure Ts0BaseEntityAdapterField.UpdateValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
begin
  ImplUpdateValue(AActionRequest, AFieldIndex);
end;

{ Ts0BaseEntityAdapterInputField }

function GetActionFieldValues(AActionRequest: IActionRequest): IActionFieldValues;
begin
  if not Supports(AActionRequest, IActionFieldValues, Result) then
    Assert(False);
end;

function Ts0BaseEntityAdapterInputField.ImplGetEchoActionFieldValue: Boolean;
begin
  Result := FEchoActionFieldValue;
end;

procedure Ts0BaseEntityAdapterInputField.ImplSetEchoActionFieldValue(
  AValue: Boolean);
begin
  FEchoActionFieldValue := AValue;
end;

procedure Ts0BaseEntityAdapterInputField.ImplValidateValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
var
  Handled: Boolean;
begin
  if Assigned(OnValidateValue) then
  begin
    with GetActionFieldValues(AActionRequest) do
      OnValidateValue(Self, Values[AFieldIndex], Handled)
  end;
end;

function Ts0BaseEntityAdapterInputField.TestValueChange(
  const ANewValue: string): Boolean;
var
  OrigValue: Variant;
begin
  OrigValue := Wrapper.PropAsVariant[PropertyName];
  if (VarIsEmpty(OrigValue)) or (VarIsNull(OrigValue)) then
    Result := Length(ANewValue) <> 0
  else
    try
      Result := ANewValue <> OrigValue;
    except
      Result := True;
    end;
end;

procedure Ts0BaseEntityAdapterInputField.ValidateValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
begin
  ImplValidateValue(AActionRequest, AFieldIndex);
end;

{ Ts0CustomEntityAdapterField }

function Ts0CustomEntityAdapterField.GetAdapterValuesList: IValuesListAdapter;
begin
  Result := FValuesList;
end;

function Ts0CustomEntityAdapterField.GetInputStyleType(
  const AAdapterMode: string): TAdapterInputHTMLElementType;
begin
  if ValuesList <> nil then
    Result := htmliSelect
  else
    Result := inherited GetInputStyleType(AAdapterMode);
end;

function Ts0CustomEntityAdapterField.GetNeedPrevValue: Boolean;
begin
  Result := ImplGetNeedPrevValue;
end;

function Ts0CustomEntityAdapterField.GetPrevValue: Variant;
begin
  Result := ImplGetPrevValue;
end;

procedure Ts0CustomEntityAdapterField.ImplCheckOrigValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
var
  OrigValue: OleVariant;
  FieldValue: WideString;
  OrigFieldValue: IActionFieldValue;
begin
//  if not (ffInOrigValues in FieldFlags) then Exit;
  Assert(Adapter <> nil);
  with GetActionFieldValues(AActionRequest) do
    OrigFieldValue := OrigValues[AFieldIndex];
  if OrigFieldValue.ValueCount < 1 then Exit;
{
  Field := Adapter.DataSet.FindField(DataSetField);
  if Field = nil then
    Adapter.RaiseFieldNotFound(DataSetField);
}
  if OrigFieldValue.ValueCount <> 1 then Exit;
  OrigValue := OrigFieldValue.Values[0];
  if VarIsEmpty(OrigValue) then Exit;
  if VarIsNull(Wrapper.PropAsVariant[PropertyName]) then
    FieldValue := ''
  else
    FieldValue := Wrapper.PropAsVariant[PropertyName];
  if (OrigValue <> FieldValue) then
    Adapter.RaiseFieldChangedByAnotherUser(FieldName);
end;

function Ts0CustomEntityAdapterField.ImplCheckValueChange(
  AActionRequest: IActionRequest; AFieldIndex: Integer): Boolean;
var
  OrigFieldValue, FieldValue: IActionFieldValue;
  I: Integer;
begin
  //Result := True;
  //if not(ffInOrigValues in FieldFlags) then Exit;
  with GetActionFieldValues(AActionRequest) do
  begin
    OrigFieldValue := OrigValues[AFieldIndex];
    FieldValue := Values[AFieldIndex];
  end;          
  if FieldValue.ValueCount = OrigFieldValue.ValueCount then
  begin
    Result := False;
    for I := 0 to FieldValue.ValueCount - 1 do
      if FieldValue.Values[I] <> OrigFieldValue.Values[I] then
      begin
        Result := True;
        break;
      end
  end
  else
    Result := False;
end;

function Ts0CustomEntityAdapterField.ImplGetNeedPrevValue: Boolean;
begin
  case Adapter.Mode of
    k0eamQuery, k0eamInsert, k0eamBrowse: Result := False;
    k0eamEdit: Result := True; //ffInOrigValues in FieldFlags;
  else
    Result := False;
    Assert(False);
  end;
end;

function Ts0CustomEntityAdapterField.ImplGetPrevValue: Variant;
var
  Value: IActionFieldValue;
begin
  Result := Unassigned;
  if EchoActionFieldValue then
  begin
    Value := ActionOrigValue;
    if (Value <> nil) and (Value.ValueCount > 0) then
      Result := Value.Values[0]
    else
      Result := Unassigned;
  end
  else
  if FPropertyName <> '' then
    Result := Wrapper.PropAsVariant[FPropertyName];
end;

function Ts0CustomEntityAdapterField.ImplGetValue: Variant;
var
  Value: IActionFieldValue;
begin
  CheckViewAccess;
  if EchoActionFieldValue then
  begin
    Value := ActionValue;
    if Value <> nil then
      if Value.ValueCount > 0 then
        Result := Value.Values[0]
      else
        // No values passed.  Get data value
        Result := inherited ImplGetValue
    else
      Result := Unassigned;
  end
  else
  if Adapter.Mode <> k0eamQuery then
    Result := inherited ImplGetValue;
end;

procedure Ts0CustomEntityAdapterField.ImplUpdateValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
var
  FieldValue: IActionFieldValue;
begin
  Assert(Adapter <> nil);
  CheckModifyAccess;
  with GetActionFieldValues(AActionRequest) do
    FieldValue := Values[AFieldIndex];
  if Adapter.Mode = k0eamQuery then Exit;
  if FieldValue.ValueCount > 0 then
  begin
    if FieldValue.ValueCount = 1 then
    begin
      if TestValueChange(FieldValue.Values[0]) then
        Wrapper.PropAsVariant[PropertyName] := FieldValue.Values[0];
      if Assigned(OnUpdateValue) then
        OnUpdateValue(Self, FieldValue.Values[0])
      else
    end
    else
      RaiseMultipleValuesException(FieldName)
  end
  else if FieldValue.FileCount > 0 then
    RaiseFileUploadNotSupported(FieldName);
end;

procedure Ts0CustomEntityAdapterField.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and AComponent.IsImplementorOf(FValuesList) then
    FValuesList := nil;
end;

procedure Ts0CustomEntityAdapterField.SetValuesList(
  const Value: IValuesListAdapter);
begin
  ReferenceInterface(FValuesList, opRemove);
  FValuesList := Value;
  ReferenceInterface(FValuesList, opInsert);
end;

{ Ts0CustomEntityAdapterMemoField }

function Ts0CustomEntityAdapterMemoField.CheckOrUpdateValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer;
  AUpdate: Boolean): Boolean;
var
  FieldValue: IActionFieldValue;
begin
  Result := False;
  Assert(Adapter <> nil);
  with GetActionFieldValues(AActionRequest) do
    FieldValue := Values[AFieldIndex];
  if FieldValue.ValueCount > 0 then
  begin
    if FieldValue.ValueCount = 1 then
    begin
      if AUpdate and Assigned(OnUpdateValue) then
        OnUpdateValue(Self, FieldValue.Values[0])
      else
      begin
        Result := TestValueChange(FieldValue.Values[0]);
        if Result and AUpdate then
          Wrapper.PropAsVariant[PropertyName] := FieldValue.Values[0];
      end;
    end
    else
      RaiseMultipleValuesException(FieldName)
  end
  else if FieldValue.FileCount > 0 then
    RaiseFileUploadNotSupported(FieldName);
end;

function Ts0CustomEntityAdapterMemoField.GetInputStyleType(
  const AAdapterMode: string): TAdapterInputHTMLElementType;
begin
  Result := htmliTextArea;
end;

function Ts0CustomEntityAdapterMemoField.ImplAsFormatted: string;
begin
  Result := inherited ImplAsFormatted;
end;

function Ts0CustomEntityAdapterMemoField.ImplCheckValueChange(
  AActionRequest: IActionRequest; AFieldIndex: Integer): Boolean;
begin
  Result := CheckOrUpdateValue(AActionRequest, AFieldIndex, False);
end;

function Ts0CustomEntityAdapterMemoField.ImplGetValue: Variant;
var
  Value: IActionFieldValue;
begin
  CheckViewAccess;
  if EchoActionFieldValue then
  begin
    Value := ActionValue;
    if Value <> nil then
      Result := Value.Values[0]
    else
      Result := Unassigned;
  end
  else if Adapter.Mode <> k0eamQuery then
    Result := inherited ImplGetValue;
end;

procedure Ts0CustomEntityAdapterMemoField.ImplUpdateValue(
  AActionRequest: IActionRequest; AFieldIndex: Integer);
begin
  CheckModifyAccess;
  CheckOrUpdateValue(AActionRequest, AFieldIndex, True);
end;

{ Ts0SharedEntityDMBroker }

var
  g9SharedDMManager: Ts0SharedEntityDMBroker = nil;

constructor Ts0SharedEntityDMBroker.Create;
begin
  inherited Create;
  FDMList := TThreadList.Create;
  FDMList.Duplicates := dupError;
end;

destructor Ts0SharedEntityDMBroker.Destroy;
begin
  FreeAndNil(FDMList);
  inherited;
end;

function Ts0SharedEntityDMBroker.FindDMByClass(
  ADMClass: Ts0dmEntityClass): Tdm0Entity;
var
  i: Integer;
  l: TList;
begin
  Result := nil;
  l := FDMList.LockList;
  try
    for i := 0 to l.Count -1 do
      if TObject(l.Items[i]).InheritsFrom(ADMClass) then
      begin
        Result := Tdm0Entity(l.Items[i]);
        Exit;
      end;
  finally
    FDMList.UnlockList;
  end;
end;

class function Ts0SharedEntityDMBroker.Instance: Ts0SharedEntityDMBroker;
begin
  { Threadを気にしないとまずいと思う }
  if g9SharedDMManager = nil then
    g9SharedDMManager := Ts0SharedEntityDMBroker.Create;
  Result := g9SharedDMManager;
end;

procedure Ts0SharedEntityDMBroker.RegisterDM(ADM: Tdm0Entity);
begin
  FDMList.Add(ADM);
end;

procedure Ts0SharedEntityDMBroker.UnRegisterDM(ADM: Tdm0Entity);
begin
  FDMList.Remove(ADM);
end;

type
  T9EtyManContextRelation = class
  protected
    FContext: TAbstractWebContext;
    FEntityMan: Ts0EntityManager;
  public
    constructor Create(AContext: TAbstractWebContext; AEntityMan: Ts0EntityManager); 
  end;

{ T9EtyManContextRelation }

constructor T9EtyManContextRelation.Create(AContext: TAbstractWebContext;
  AEntityMan: Ts0EntityManager);
begin
  inherited Create;
  FContext := AContext;
  FEntityMan := AEntityMan;
end;

{ Ts0EtyManContextMap }

procedure Ts0EtyManContextMap.AddRelation(
  AContext: TAbstractWebContext; AEntityMan: Ts0EntityManager);
var
  rel: T9EtyManContextRelation;
begin
  Assert(AEntityMan <> nil);
  rel := T9EtyManContextRelation.Create(AContext, AEntityMan);
  FRelations.Add(rel);
end;

constructor Ts0EtyManContextMap.Create;
begin
  inherited Create;
  FRelations := TObjectList.Create(False);
end;

destructor Ts0EtyManContextMap.Destroy;
begin
  FreeAndNil(FRelations);
  inherited;
end;

function Ts0EtyManContextMap.FindManagerByClass(
  AContext: TAbstractWebContext; AClass: Ts0EntityClass): Ts0EntityManager;
var
  i: Integer;
  rel: T9EtyManContextRelation;
begin
  Result := nil;
  for i := 0 to FRelations.Count -1 do
  begin
    Assert(FRelations.Items[i] <> nil);
    Assert(FRelations.Items[i] is T9EtyManContextRelation);
    rel := T9EtyManContextRelation(FRelations.Items[i]);
    if rel.FContext <> AContext then Continue;
    if not rel.FEntityMan.EntityClass.InheritsFrom(AClass) then Continue;
    Result := rel.FEntityMan;
    Exit;
  end;
end;

function Ts0EtyManContextMap.FindManagerByClassID(
  AContext: TAbstractWebContext; AClassID: Integer): Ts0EntityManager;
var
  i: Integer;
  rel: T9EtyManContextRelation;
begin
  for i := 0 to FRelations.Count -1 do
  begin
    Assert(FRelations.Items[i] <> nil);
    Assert(FRelations.Items[i] is T9EtyManContextRelation);
    rel := T9EtyManContextRelation(FRelations.Items[i]);
    if rel.FContext <> AContext then Continue;
    if rel.FEntityMan.EntityClass.GetClassID <> AClassID then Continue;
    Result := rel.FEntityMan;
    Exit;
  end;
  Result := nil;
end;

function Ts0EtyManContextMap.FindManagerByClassName(
  AContext: TAbstractWebContext; AClassName: String): Ts0EntityManager;
var
  i: Integer;
  rel: T9EtyManContextRelation;
begin
  for i := 0 to FRelations.Count -1 do
  begin
    Assert(FRelations.Items[i] <> nil);
    Assert(FRelations.Items[i] is T9EtyManContextRelation);
    rel := T9EtyManContextRelation(FRelations.Items[i]);
    if rel.FContext <> AContext then Continue;
    Result := rel.FEntityMan;
    if not SameText(Result.EntityClassName, AClassName) then Continue;
    Exit;
  end;
  Result := nil;
end;

function Ts0EtyManContextMap.GetContext(
  AManager: Ts0EntityManager): TAbstractWebContext;
var
  i: Integer;
  rel: T9EtyManContextRelation;
begin
  Result := nil;
  for i := 0 to FRelations.Count -1 do
  begin
    Assert(FRelations.Items[i] <> nil);
    Assert(FRelations.Items[i] is T9EtyManContextRelation);
    rel := T9EtyManContextRelation(FRelations.Items[i]);
    if rel.FEntityMan <> AManager then Continue;
    Result := rel.FContext;
    Exit;
  end;
end;

procedure Ts0EtyManContextMap.RemoveRelation(
  AEntityMan: Ts0EntityManager);
var
  i: Integer;
  rel: T9EtyManContextRelation;
begin
  for i := FRelations.Count -1 downto 0 do
  begin
    Assert(FRelations.Items[i] <> nil);
    Assert(FRelations.Items[i] is T9EtyManContextRelation);
    rel := T9EtyManContextRelation(FRelations.Items[i]);
    if rel.FEntityMan <> AEntityMan then Continue;
    FRelations.Delete(i);
  end;
end;

{ Ts0WebContextEntityManBroker }

constructor Ts0WebContextEntityManBroker.Create;
begin
  inherited Create;
  FEtyManMap := Ts0EtyManContextMap.Create;
end;

destructor Ts0WebContextEntityManBroker.Destroy;
begin
  FreeAndNil(FEtyManMap);
  inherited Destroy;
end;

function Ts0WebContextEntityManBroker.GetManagerByClass(
  AClass: Ts0EntityClass): Ts0EntityManager;
begin
  Result := FEtyManMap.FindManagerByClass(WebContext, AClass);
end;

function Ts0WebContextEntityManBroker.GetManagerByClassID(
  AEntityClassID: Integer): Ts0EntityManager;
begin
  Result := FEtyManMap.FindManagerByClassID(WebContext, AEntityClassID);
end;

function Ts0WebContextEntityManBroker.GetManagerByClassName(
  AEntityClassName: String): Ts0EntityManager;
begin
  Result := inherited GetManagerByClassName(AEntityClassName);
  if Result <> nil then Exit;
  Result := FEtyManMap.FindManagerByClassName(WebContext, AEntityClassName);
end;

function Ts0WebContextEntityManBroker.NeedManager(
  AClass: Ts0EntityClass): Ts0EntityManager;
var
  dmClass: Ts0dmEntityClass;
  manDM: Tdm0Entity;
begin
  Result := GetManagerByClass(AClass);
  if Result <> nil then Exit;
  dmClass := Ts0EntityDMClassBroker.Instance.GetRegisteredDMClass(AClass);
  if dmClass = nil then Exit;
  manDM := dmClass.Create(nil);
  Result := GetManagerOf(manDM);
end;

procedure Ts0WebContextEntityManBroker.RegisterManager(
  AEntityMan: Ts0EntityManager);
var
  man: Ts0EntityManager;
begin
  man := GetManagerByClassName(AEntityMan.EntityClassName);
  if man <> nil then Exit;
  FEtyManMap.AddRelation(WebContext, AEntityMan);
end;

procedure Ts0WebContextEntityManBroker.UnRegisterManager(
  AEntityMan: Ts0EntityManager);
begin
  FEtyManMap.RemoveRelation(AEntityMan);
end;

{ Ts0CustomEntityAdapterAction }

constructor Ts0CustomEntityAdapterAction.Create(AOwner: TComponent);
begin
  inherited;
  FActionModes := [k0eamInsert, k0eamEdit, k0eamBrowse, k0eamQuery];
end;

function Ts0CustomEntityAdapterAction.GetAdapter: Ts0CustomEntityAdapter;
begin
  if inherited Adapter is Ts0CustomEntityAdapter then
    Result := Ts0CustomEntityAdapter(inherited Adapter)
  else
    Result := nil;
end;

function Ts0CustomEntityAdapterAction.ImplGetVisible: Boolean;
begin
  Result := Adapter.Mode in FActionModes;
end;

function Ts0CustomEntityAdapterAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled;
end;

{ Ts0CustomEntityAdapterRowAction }

constructor Ts0CustomEntityAdapterRowAction.Create(AOwner: TComponent);
begin
  inherited;
  FActionModes := [k0eamInsert, k0eamEdit, k0eamBrowse {, k0eamQuery}];
end;

procedure Ts0CustomEntityAdapterRowAction.ImplGetAdapterItemRequestParams(
  var AIdentifier: string; Params: IAdapterItemRequestParams);
begin
  Adapter.EncodeActionParams(Params);
  inherited ImplGetAdapterItemRequestParams(AIdentifier, Params);
end;

function Ts0CustomEntityAdapterRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled; // and (Adapter.GetKeyFields <> '');
end;

{ Ts0EntityAdapterRowAction }
                                    
procedure Ts0EntityAdapterRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
var
  sl: TStrings;
begin
  if Assigned(OnExecute) then
  begin
    sl := AdapterRequestParamsAsStrings(AActionRequest);
    try
      Adapter.ExtractRequestParams(AActionRequest);
      Adapter.ApplyAdapterMode(AActionRequest);
      OnExecute(Self, sl);
    finally
      FreeAndNil(sl);
    end;
  end
  else
  begin
    if not Adapter.LocateAndApply(AActionRequest) then
      Adapter.EchoActionFieldValues := True;
  end;        
end;

procedure Ts0EntityAdapterRowAction.ImplGetAdapterItemRequestParams(
  var AIdentifier: string; Params: IAdapterItemRequestParams);
begin
  //Assert(Params.ParamValues.Count = 0);
  inherited ImplGetAdapterItemRequestParams(AIdentifier, Params);
end;

{ Ts0EntityAdapterDeleteRowAction }

function Ts0EntityAdapterDeleteRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterDeleteAction;
end;

procedure Ts0EntityAdapterDeleteRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
  function DeleteRow: Boolean;
  begin
    Result := True;
    try
      Adapter.CurrentEntity.Remove;
    except
      // Add to error list
      on E: Exception do
      begin
        Errors.AddError(E);
        Result := False;
      end;
    end;
  end;
begin
  Adapter.ExtractRequestParams(AActionRequest);
  // Extract mode and preserve for response
  Adapter.ApplyAdapterMode(AActionRequest);
  if Adapter.Mode in [k0eamInsert] then
  begin
    Adapter.Locate;
    Adapter.Mode := k0eamEdit;
  end
  else
    if Adapter.Locate and DeleteRow then
    else
      Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterDeleteRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
var
  Intf: IGetAdapterDisplayCharacteristics;
begin
  Result := Adapter.Mode <> k0eamQuery;
  if Result then
    if Supports(ADisplay, IGetAdapterDisplayCharacteristics, Intf) then
      Result := dcCurrentRecordView in Intf.GetAdapterDisplayCharacteristics
    else
      Result := True;
end;

{ Ts0EntityAdapterMoveRowAction }

function Ts0EntityAdapterMoveRowAction.GetIterator: Ts0EntityIterator;
begin
  Result := nil;
  if Adapter = nil then Exit;
  Result := Adapter.EntityIterator;
end;

function Ts0EntityAdapterMoveRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
var
  Intf: IGetAdapterDisplayCharacteristics;
begin
  Result := Adapter.Mode <> k0eamQuery;
  if not Result then Exit;
  if Supports(ADisplay, IGetAdapterDisplayCharacteristics, Intf) then
    Result := dcChangeCurrentRecordView in Intf.GetAdapterDisplayCharacteristics
  else
    Result := True;
end;

{ Ts0EntityAdapterNextRowAction }

function Ts0EntityAdapterNextRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterNextAction;
end;

procedure Ts0EntityAdapterNextRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
    Iterator.Next
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterNextRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled and Iterator.HasNext;
end;

{ Ts0EntityAdapterPrevRowAction }

function Ts0EntityAdapterPrevRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterPrevAction;
end;

procedure Ts0EntityAdapterPrevRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
    Iterator.Prior
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterPrevRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled and Iterator.HasPrior;
end;

{ Ts0EntityAdapterFirstRowAction }

function Ts0EntityAdapterFirstRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterFirstAction;
end;

procedure Ts0EntityAdapterFirstRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
    Iterator.First
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterFirstRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled and Iterator.IsFirst; 
end;

{ Ts0EntityAdapterLastRowAction }

function Ts0EntityAdapterLastRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterLastAction;
end;

procedure Ts0EntityAdapterLastRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
    Iterator.Last
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterLastRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled and Iterator.HasNext;   //?????? IsLast?
end;

{ Ts0EntityAdapterNewRowAction }

function Ts0EntityAdapterNewRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterNewAction;
end;

procedure Ts0EntityAdapterNewRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
  begin
    Adapter.Mode := k0eamInsert;
    Adapter.CurrentEntity.Clear;
//    DataSet.Open;
//    DataSet.Insert;
  end
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterNewRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
begin
  Result := True;
end;

function Ts0EntityAdapterNewRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled
end;

{ Ts0EntityAdapterCancelRowAction }

function Ts0EntityAdapterCancelRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterCancelAction;
end;

procedure Ts0EntityAdapterCancelRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  Adapter.ExtractRequestParams(AActionRequest);
  Adapter.InDefaultMode := True;
{
  if DataSet = nil then
    Adapter.RaiseNilDataSet;
  DataSet.Open;
  if DataSet.RecordCount <> 0 then
    Adapter.Locate;
}
  Adapter.Locate;
end;

function Ts0EntityAdapterCancelRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
var
  Intf: IGetAdapterDisplayCharacteristics;
  C: TAdapterDisplayCharacteristics;
begin
  Result := Adapter.Mode <> k0eamQuery;
  if Result then
    if Supports(ADisplay, IGetAdapterDisplayCharacteristics, Intf) then
    begin
      C := Intf.GetAdapterDisplayCharacteristics;
      Result := (dcCurrentRecordView in C) and
        not (dcMultipleRecordView in C);
    end
    else
      Result := True;
end;

function Ts0EntityAdapterCancelRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled and (Adapter.Mode <> k0eamBrowse);
end;

{ Ts0EntityAdapterApplyRowAction }

function Ts0EntityAdapterApplyRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterApplyAction;
end;

procedure Ts0EntityAdapterApplyRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
    Adapter.CurrentEntity.Save
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterApplyRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
var
  Intf: IGetAdapterDisplayCharacteristics;
  C: TAdapterDisplayCharacteristics;
begin
  Result := Adapter.Mode <> k0eamQuery;
  if Result then
    if Supports(ADisplay, IGetAdapterDisplayCharacteristics, Intf) then
    begin
      C := Intf.GetAdapterDisplayCharacteristics;
      Result := (dcCurrentRecordView in C) and
        not (dcMultipleRecordView in C);
    end
    else
      Result := True;
end;

function Ts0EntityAdapterApplyRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled and (Adapter.Mode <> k0eamBrowse);
end;

{ Ts0EntityAdapterRefreshRowAction }

function Ts0EntityAdapterRefreshRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterRefreshAction;
end;

procedure Ts0EntityAdapterRefreshRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  Adapter.ExtractRequestParams(AActionRequest);
  Adapter.ApplyAdapterMode(AActionRequest);
  case Adapter.Mode of
    k0eamInsert:
    begin
{
      if DataSet = nil then
        Adapter.RaiseNilDataSet;
      Adapter.Locate;
      DataSet.Open;
      DataSet.Insert
}
    end;
    k0eamEdit, k0eamBrowse:
      Adapter.Locate;  // May raise exception
  else
    Assert(False);
  end;
  Adapter.CurrentEntity.Load;
end;

function Ts0EntityAdapterRefreshRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
var
  Intf: IGetAdapterDisplayCharacteristics;
  C: TAdapterDisplayCharacteristics;
begin
  Result := Adapter.Mode <> k0eamQuery;
  if Result then
    if Supports(ADisplay, IGetAdapterDisplayCharacteristics, Intf) then
    begin
      C := Intf.GetAdapterDisplayCharacteristics;
      Result := (dcCurrentRecordView in C) and
        not (dcMultipleRecordView in C);
    end
    else
      Result := True;
end;

function Ts0EntityAdapterRefreshRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled
end;

{ Ts0EntityAdapterEditRowAction }

function Ts0EntityAdapterEditRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterEditAction;
end;

procedure Ts0EntityAdapterEditRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
    Adapter.Mode := k0eamEdit
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterEditRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
var
  Intf: IGetAdapterDisplayCharacteristics;
  C: TAdapterDisplayCharacteristics;
begin
  if Supports(ADisplay, IGetAdapterDisplayCharacteristics, Intf) then
  begin
    C := Intf.GetAdapterDisplayCharacteristics;
    Result := (dcCurrentRecordView in C) and
      (dcMultipleRecordView in C);
  end
  else
    Result := True;
end;

function Ts0EntityAdapterEditRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled
end;

{ Ts0EntityAdapterBrowseRowAction }

constructor Ts0EntityAdapterBrowseRowAction.Create(AOwner: TComponent);
begin
  inherited;
  FActionModes := [k0eamInsert, k0eamEdit, k0eamBrowse, k0eamQuery];
end;

function Ts0EntityAdapterBrowseRowAction.GetDefaultActionName: string;
begin
  Result := c9EntityAdapterBrowseAction;
end;

procedure Ts0EntityAdapterBrowseRowAction.ImplExecuteActionRequest(
  AActionRequest: IActionRequest; AActionResponse: IActionResponse);
begin
  if Adapter.LocateAndApply(AActionRequest) then
    Adapter.Mode := k0eamBrowse
  else
    Adapter.EchoActionFieldValues := True;
end;

function Ts0EntityAdapterBrowseRowAction.ImplIsDefaultAction(
  ADisplay: TObject): Boolean;
var
  Intf: IGetAdapterDisplayCharacteristics;
  C: TAdapterDisplayCharacteristics;
begin
  if Supports(ADisplay, IGetAdapterDisplayCharacteristics, Intf) then
  begin
    C := Intf.GetAdapterDisplayCharacteristics;
    Result := (dcCurrentRecordView in C) and
      (dcMultipleRecordView in C);
  end
  else
    Result := True;
end;

function Ts0EntityAdapterBrowseRowAction.ImplWebEnabled: Boolean;
begin
  Result := inherited ImplWebEnabled;
end;

initialization
  Ts0EntityManBroker.RegisterBrokerClass(Ts0WebContextEntityManBroker);

end.
