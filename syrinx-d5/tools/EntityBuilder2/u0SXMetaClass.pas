unit u0SXMetaClass;
{
$History: u0SXMetaClass.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/15   Time: 10:26
 * Created in $/tools/EntityBuilder2
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCaseを使用して文字列の比較を行っていた部分をSameTextを使用するよう
 * に修正
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/30   Time: 1:47
 * Updated in $/source/D5Integrated
 * T0SXMetaFunctionImpl.WithoutBeginEndプロパティを追加。
 * コメント追加用のメソッドも追加。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/13   Time: 23:27
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/03   Time: 2:31
 * Updated in $/source/D5/p0additional
 * エンティティ生成関係とりあえずOKできました
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/02   Time: 1:33
 * Created in $/source/D5/p0additional
 * 新規作成
}

interface

uses
  SysUtils, Classes, Contnrs,
  s0Collection;

type
  T0SXMetaUnit = class;

  T0SXCommentItem = class;

  T0SXAbsrtactItem = class(Ts0CollectionItem)
  private
    FName: string;
    FOwnerUnit: T0SXMetaUnit;
    FComment: T0SXCommentItem;
    procedure SetName(const Value: string);
    function GetOwnerUnit: T0SXMetaUnit;
    procedure SetComment(const Value: T0SXCommentItem);
  protected
    function GetIdentifier: string; override;
  public
    procedure Assign(Source: TPersistent); override;
    property OwnerUnit: T0SXMetaUnit read GetOwnerUnit;
    property Comment: T0SXCommentItem read FComment write SetComment;
  published
    property Name: string read FName write SetName;
  end;

  T0SXAbsrtactItems = class(Ts0Collection)
  private
    FOwnerUnit: T0SXMetaUnit;
    function GetOwnerUnit: T0SXMetaUnit;
  public
    destructor Destroy; override;
    function FindByName(AName: string): T0SXAbsrtactItem;
    property OwnerUnit: T0SXMetaUnit read GetOwnerUnit;
  end;

  K0CommentKind = (k0ckDoubleSlash, k0ckBracket, k0ckBracketWithAsterisk, k0ckCustom);

  T0SXCommentItem = class(T0SXAbsrtactItem)
  private
    FDescription: TStrings;
    FCommentKind: K0CommentKind;
    procedure SetDescription(const Value: TStrings);
    function GetDescription: TStrings;
    procedure SetCommentKind(const Value: K0CommentKind);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AddStrs(ADesc: array of String);
  published
    property CommentKind: K0CommentKind read FCommentKind write SetCommentKind default k0ckBracket;
    property Description: TStrings read GetDescription write SetDescription;
  end;

  T0SXCommentItems = class(T0SXAbsrtactItems)
  private
    function GetItems(const Index: Integer): T0SXCommentItem;
    procedure SetItems(const Index: Integer; const Value: T0SXCommentItem);
  public
    function Add(ADesc: String): T0SXCommentItem;
    function AddWithStrs(ADesc: array of String): T0SXCommentItem;
    property Items[const Index: Integer]: T0SXCommentItem read GetItems write SetItems;
  end;


  K0UnitBlockType = (
    k0ubtInterface,
    k0ubtImplementation,
    k0ubtInitialization,
    k0ubtFinalization
  );

  T0SXDeclareItem = class(T0SXAbsrtactItem)
  private
    FDeclareBlock: K0UnitBlockType;
    procedure SetDeclareBlock(const Value: K0UnitBlockType);
  public
    destructor Destroy; override;
  published
    property DeclareBlock: K0UnitBlockType read FDeclareBlock write SetDeclareBlock;
  end;

  T0SXDeclareItems = class(T0SXAbsrtactItems)
  public
    destructor Destroy; override;
  end;



  T0SXMetaVariable = class(T0SXDeclareItem)
  private
    FTypeName: string;
    procedure SetTypeName(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property TypeName: string read FTypeName write SetTypeName;
  end;

  T0SXMetaVariables = class(T0SXDeclareItems)
  private
  public
    destructor Destroy; override;
  end;


  T0SXMetaConstant = class(T0SXDeclareItem)
  private
    FValue: string;
    procedure SetValue(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Value: string read FValue write SetValue;
  end;

  T0SXMetaConstants = class(T0SXDeclareItems)
  private
  public
    destructor Destroy; override;
  end;


  T0SXMetaType = class(T0SXDeclareItem)
  public
    destructor Destroy; override;
  end;

  T0SXMetaTypes = class(T0SXDeclareItems)
  public
    destructor Destroy; override;
  end;


  T0SXMetaOrdinaryType = class(T0SXMetaType)
  private
    FElements: T0SXAbsrtactItems;
    procedure SetElements(const Value: T0SXAbsrtactItems);
    function GetElements: T0SXAbsrtactItems;
  protected
    function GetSubCollection: Ts0Collection; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Elements: T0SXAbsrtactItems read GetElements write SetElements;
  end;

  T0SXMetaOrdinaryTypes = class(T0SXMetaTypes)
  public
    destructor Destroy; override;
  end;


  T0SXMetaSetType = class(T0SXMetaOrdinaryType)
  private
    FOrdinaryType: T0SXMetaOrdinaryType;
  public
    destructor Destroy; override;
  public
    property OrdinaryType: T0SXMetaOrdinaryType read FOrdinaryType write FOrdinaryType;
    procedure RestoreOrdinary;
  end;

  T0SXMetaSetTypes = class(T0SXMetaOrdinaryTypes)
  public
    destructor Destroy; override;
  end;


  T0SXMetaRecoedType = class(T0SXMetaType)
  private
    FFields: T0SXMetaVariables;
    procedure SetFields(const Value: T0SXMetaVariables);
    function GetFields: T0SXMetaVariables;
  protected
    function GetSubCollection: Ts0Collection; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Fields: T0SXMetaVariables read GetFields write SetFields;
  end;

  T0SXMetaRecoedTypes = class(T0SXMetaTypes)
  public
    destructor Destroy; override;
  end;


  K0ParamKind = (k0pkNone, k0pkVar, k0pkConst, k0pkOut);

  T0SXMethodParam = class(T0SXMetaVariable)
  private
    FParamKind: K0ParamKind;
    FDefaultValue: string;
    procedure SetParamKind(const Value: K0ParamKind);
    procedure SetDefaultValue(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ParamKind: K0ParamKind read FParamKind write SetParamKind;
    property DefaultValue: string read FDefaultValue write SetDefaultValue;
  end;

  T0SXMethodParams = class(T0SXMetaVariables)
  private
    function GetItems(const Index: Integer): T0SXMethodParam;
    procedure SetItems(const Index: Integer; const Value: T0SXMethodParam);
  public
    function AddParam(AName, AType: string; AKind: K0ParamKind = k0pkNone; ADefault: string = ''): T0SXMethodParam;
    property Items[const Index: Integer]: T0SXMethodParam read GetItems write SetItems; default;
  end;



  T0SXMetaFunctionImpl = class;

  T0SXMetaFunctionIntf = class(T0SXAbsrtactItem)
  private
    FReturnTypeName: string;
    FParams: T0SXMethodParams;
    FImplMethod: T0SXMetaFunctionImpl;
    procedure SetParams(const Value: T0SXMethodParams);
    procedure SetReturnTypeName(const Value: string);
    function GetParams: T0SXMethodParams;
    procedure SetImplMethod(const Value: T0SXMetaFunctionImpl);
  protected
    function GetSubCollection: Ts0Collection; override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property ImplMethod: T0SXMetaFunctionImpl read FImplMethod write SetImplMethod;
  published
    property Params: T0SXMethodParams read GetParams write SetParams;
    property ReturnTypeName: string read FReturnTypeName write SetReturnTypeName;
  end;

  T0SXMetaFunctionIntfs = class(T0SXAbsrtactItems)
  public
    destructor Destroy; override;
  end;

  T0SXMetaFunctionImpl = class(T0SXAbsrtactItem)
  private
    FImplementCode: TStrings;
    FIntfMethod: T0SXMetaFunctionIntf;
    FWithoutBeginEnd: Boolean;
    function GetImplementCode: TStrings;
    procedure SetImplementCode(const Value: TStrings);
    procedure SetIntfMethod(const Value: T0SXMetaFunctionIntf);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property IntfMethod: T0SXMetaFunctionIntf read FIntfMethod write SetIntfMethod;
  published
    property ImplementCode: TStrings read GetImplementCode write SetImplementCode;
    property WithoutBeginEnd: Boolean read FWithoutBeginEnd write FWithoutBeginEnd default False;
  end;

  T0SXMetaFunctionImpls = class(T0SXAbsrtactItems)
  public
    destructor Destroy; override;
    function Add(AName: string): T0SXMetaFunctionImpl;
    function AddWithIntf(AIntf: T0SXMetaFunctionIntf): T0SXMetaFunctionImpl;
    function FindByIntf(AIntf: T0SXMetaFunctionIntf): T0SXMetaFunctionImpl;
  end;



  T0SXItemSequence = class(Ts0CollectionItem)
  private
    FItem: T0SXAbsrtactItem;
    procedure SetItem(const Value: T0SXAbsrtactItem);
  public
    property Item: T0SXAbsrtactItem read FItem write SetItem;
  end;

  T0SXItemSequences = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): T0SXItemSequence;
    procedure SetItems(const Index: Integer; const Value: T0SXItemSequence);
  public
    function Add(AItem: T0SXAbsrtactItem): T0SXItemSequence;
    destructor Destroy; override;
    property Items[const Index: Integer]: T0SXItemSequence read GetItems write SetItems;
  end;


  T0SXMetaUnit = class(T0SXAbsrtactItem)
  private
    FUsesIntf: TStrings;
    FUsesImpl: TStrings;
    FSeqIntf: T0SXItemSequences;
    FSeqImpl: T0SXItemSequences;
    FConstants: T0SXMetaConstants;
    FTypes: T0SXMetaTypes;
    FMethodImpls: T0SXMetaFunctionImpls;
    FComments: T0SXCommentItems;
    FMethodIntfs: T0SXMetaFunctionIntfs;
    FVariables: T0SXMetaVariables;
    FInitializationCode: TStrings;
    FFinalizationCode: TStrings;
    FImplComment: T0SXCommentItem;
    procedure SetUsesIntf(const Value: TStrings);
    procedure SetUsesImpl(const Value: TStrings);
    function GetUsesImpl: TStrings;
    function GetUsesIntf: TStrings;
    procedure SetSeqImpl(const Value: T0SXItemSequences);
    procedure SetSeqIntf(const Value: T0SXItemSequences);
    procedure SetConstants(const Value: T0SXMetaConstants);
    procedure SetTypes(const Value: T0SXMetaTypes);
    procedure SetMethodImpls(const Value: T0SXMetaFunctionImpls);
    function GetConstants: T0SXMetaConstants;
    function GetMethodImpls: T0SXMetaFunctionImpls;
    function GetSeqImpl: T0SXItemSequences;
    function GetSeqIntf: T0SXItemSequences;
    function GetTypes: T0SXMetaTypes;
    procedure SetComments(const Value: T0SXCommentItems);
    function GetComments: T0SXCommentItems;
    procedure SetMethodIntfs(const Value: T0SXMetaFunctionIntfs);
    function GetMethodIntfs: T0SXMetaFunctionIntfs;
    procedure SetVariables(const Value: T0SXMetaVariables);
    function GetVariables: T0SXMetaVariables;
    procedure SetInitializationCode(const Value: TStrings);
    procedure SetFinalizationCode(const Value: TStrings);
    function GetFinalizationCode: TStrings;
    function GetInitializationCode: TStrings;
    procedure SetImplComment(const Value: T0SXCommentItem);
  protected
    procedure FindItems(Source: T0SXDeclareItems; Dest: Ts0CollectionItemList;
      ABlock: K0UnitBlockType; AOnlyClasses: Boolean);
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RefreshSequence;
    property ImplComment: T0SXCommentItem read FImplComment write SetImplComment;
  published
    property Comments: T0SXCommentItems read GetComments write SetComments;
    property Constants: T0SXMetaConstants read GetConstants write SetConstants;
    property FinalizationCode: TStrings read GetFinalizationCode write SetFinalizationCode;
    property InitializationCode: TStrings read GetInitializationCode write SetInitializationCode;
    property MethodIntfs: T0SXMetaFunctionIntfs read GetMethodIntfs write SetMethodIntfs;
    property MethodImpls: T0SXMetaFunctionImpls read GetMethodImpls write SetMethodImpls;
    property SeqIntf: T0SXItemSequences read GetSeqIntf write SetSeqIntf;
    property SeqImpl: T0SXItemSequences read GetSeqImpl write SetSeqImpl;
    property Types: T0SXMetaTypes read GetTypes write SetTypes;
    property UsesIntf: TStrings read GetUsesIntf write SetUsesIntf;
    property UsesImpl: TStrings read GetUsesImpl write SetUsesImpl;
    property Variables: T0SXMetaVariables read GetVariables write SetVariables;
  end;

  T0SXMetaUnits = class(T0SXAbsrtactItems)
  private
    function GetUnits(const Index: Integer): T0SXMetaUnit;
    procedure SetUnits(const Index: Integer; const Value: T0SXMetaUnit);
  public
    function AddUnit(AUnitName: string): T0SXMetaUnit;
    property Units[const Index: Integer]: T0SXMetaUnit read GetUnits write SetUnits; default;
  end;
  
type
  Tc0SXProject = class(TComponent)
  private
    FUnits: T0SXMetaUnits;
    procedure SetUnits(const Value: T0SXMetaUnits);
    function GetUnits: T0SXMetaUnits;
  public
    destructor Destroy; override;
  published
    property Units: T0SXMetaUnits read GetUnits write SetUnits;
  end;

type
  K0ClassPartVisibility = (
    k0cpvNone,
    k0cpvPrivate,
    k0cpvProtected,
    k0cpvPublic,
    k0cpvPublished,
    k0cpvAutomated
  );

type
  T0SXMetaClass = class;

  T0SXMetaField = class(T0SXMetaVariable)
  private
    FTypeName: string;
    FVisibility: K0ClassPartVisibility;
    procedure SetTypeName(const Value: string);
    function GetOwnerClass: T0SXMetaClass;
    procedure SetVisibility(const Value: K0ClassPartVisibility);
  protected
  public
    procedure Assign(Source: TPersistent); override;
    property OwnerClass: T0SXMetaClass read GetOwnerClass;
  published
    property TypeName: string read FTypeName write SetTypeName;
    property Visibility: K0ClassPartVisibility read FVisibility write SetVisibility;
  end;

  T0SXMetaFields = class(T0SXMetaVariables)
  private
    function GetItems(const Index: Integer): T0SXMetaField;
    procedure SetItems(const Index: Integer; const Value: T0SXMetaField);
  public
    function Add(AName, AType: string): T0SXMetaField;
    property Items[const Index: Integer]: T0SXMetaField read GetItems write SetItems; default;
  end;


  {
    K0MethodKind.k0mkFinal
      Delphiで言う静的メソッドのこと。Staticって訳したくなかったから
      「overrideできない」という意味でJavaのfinalを頂戴した。
  }
  K0MethodKind = (
    k0mkFinal,
    k0mkDynamic,
    k0mkvirtual,
    k0mkOverride
  );

  K0MethodType = (
    k0mtNormal,
    k0mtConstructor,
    k0mtDestructor
  );

  T0SXMetaMethod = class(T0SXMetaFunctionIntf)
  private
    FIsStatic: Boolean;
    FIsAbstract: Boolean;
    FMethodKind: K0MethodKind;
    FVisibility: K0ClassPartVisibility;
    FMethodType: K0MethodType;
    procedure SetIsStatic(const Value: Boolean);
    procedure SetIsAbstract(const Value: Boolean);
    procedure SetMethodKind(const Value: K0MethodKind);
    function GetOwnerClass: T0SXMetaClass;
    procedure SetVisibility(const Value: K0ClassPartVisibility);
    procedure SetMethodType(const Value: K0MethodType);
  protected
  public
    procedure Assign(Source: TPersistent); override;
    property OwnerClass: T0SXMetaClass read GetOwnerClass;
  published
    property IsAbstract: Boolean read FIsAbstract write SetIsAbstract;
    property IsStatic: Boolean read FIsStatic write SetIsStatic;
    property MethodKind: K0MethodKind read FMethodKind write SetMethodKind;
    property MethodType: K0MethodType read FMethodType write SetMethodType;
    property Visibility: K0ClassPartVisibility read FVisibility write SetVisibility;
  end;

  T0SXMetaMethods = class(T0SXMetaFunctionIntfs)
  private
    function GetItems(const Index: Integer): T0SXMetaMethod;
    procedure SetItems(const Index: Integer; const Value: T0SXMetaMethod);
  public
    function Add(AName, AReturn: string; AWithImpl: Boolean = True): T0SXMetaMethod;
    property Items[const Index: Integer]: T0SXMetaMethod read GetItems write SetItems; default;
  end;


  T0SXMetaProperty = class(T0SXMetaFunctionIntf)
  private
    FReadAccessor: T0SXAbsrtactItem;
    FWriteAccessor: T0SXAbsrtactItem;
    FDefaultValue: string;
    FStoredValue: string;
    FWriteAccessorName: string;
    FReadAccessorName: string;
    FVisibility: K0ClassPartVisibility;
    FDefaultAccess: Boolean;
    procedure SetDefaultValue(const Value: string);
    procedure SetStoredValue(const Value: string);
    procedure SetReadAccessorName(const Value: string);
    procedure SetWriteAccessorName(const Value: string);
    function GetReadAccessor: T0SXAbsrtactItem;
    function GetWriteAccessor: T0SXAbsrtactItem;
    procedure SetVisibility(const Value: K0ClassPartVisibility);
    function GetOwnerClass: T0SXMetaClass;
    procedure SetDefaultAccess(const Value: Boolean);
  protected
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property OwnerClass: T0SXMetaClass read GetOwnerClass;
    property ReadAccessor: T0SXAbsrtactItem read GetReadAccessor;
    property WriteAccessor: T0SXAbsrtactItem read GetWriteAccessor;
  published
    property DefaultAccess: Boolean read FDefaultAccess write SetDefaultAccess;
    property DefaultValue: string read FDefaultValue write SetDefaultValue;
    property ReadAccessorName: string read FReadAccessorName write SetReadAccessorName;
    property WriteAccessorName: string read FWriteAccessorName write SetWriteAccessorName;
    property StoredValue: string read FStoredValue write SetStoredValue;
    property Visibility: K0ClassPartVisibility read FVisibility write SetVisibility;
  end;

  T0SXMetaProperties = class(T0SXMetaFunctionIntfs)
  private
    function GetItems(const Index: Integer): T0SXMetaProperty;
    procedure SetItems(const Index: Integer; const Value: T0SXMetaProperty);
  public
    function Add(AName, AType: string; AGetter: string = ''; ASetter: string = '';
      AWithAccessor: Boolean = True): T0SXMetaProperty;
    property Items[const Index: Integer]: T0SXMetaProperty read GetItems write SetItems; default;
  end;

  T0SXMetaClass = class(T0SXMetaType)
  private
    FFields: T0SXMetaFields;
    FMethods: T0SXMetaMethods;
    FProperties: T0SXMetaProperties;
    FSuperClassName: string;
    FSeqMembers: array[K0ClassPartVisibility] of T0SXItemSequences;
    procedure SetFields(const Value: T0SXMetaFields);
    procedure SetMethods(const Value: T0SXMetaMethods);
    procedure SetProperties(const Value: T0SXMetaProperties);
    function GetFields: T0SXMetaFields;
    function GetMethods: T0SXMetaMethods;
    function GetProperties: T0SXMetaProperties;
    procedure SetSuperClassName(const Value: string);
    function GetSuperClass: T0SXMetaClass;
    function GetSeqMembers(
      const Index: K0ClassPartVisibility): T0SXItemSequences;
    procedure SetSeqMembers(const Index: K0ClassPartVisibility;
      const Value: T0SXItemSequences);
  protected
    procedure FindItems(Source: T0SXAbsrtactItems; Dest: Ts0CollectionItemList;
      AVisibility: K0ClassPartVisibility);
  public
    destructor Destroy; override;
    procedure RefreshSequence;
    procedure Assign(Source: TPersistent); override;
    property SuperClass: T0SXMetaClass read GetSuperClass;
    property SeqMembers[const Index: K0ClassPartVisibility]: T0SXItemSequences read GetSeqMembers write SetSeqMembers;
  published
    property Fields: T0SXMetaFields read GetFields write SetFields;
    property Methods: T0SXMetaMethods read GetMethods write SetMethods;
    property Properties: T0SXMetaProperties read GetProperties write SetProperties;
    property SuperClassName: string read FSuperClassName write SetSuperClassName;
  end;

type
  T0SXMetaClasses = class(T0SXMetaTypes)
  private
    function GetItems(const Index: Integer): T0SXMetaClass;
    procedure SetItems(const Index: Integer; const Value: T0SXMetaClass);
  public
    property Items[const Index: Integer]: T0SXMetaClass read GetItems write SetItems; default;
  end;

implementation

{ T0SXAbsrtactItem }

procedure T0SXAbsrtactItem.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXAbsrtactItem) then Exit;
  Self.Name := T0SXAbsrtactItem(Source).Name;
end;

function T0SXAbsrtactItem.GetIdentifier: string;
begin
  Result := Name;
end;

function T0SXAbsrtactItem.GetOwnerUnit: T0SXMetaUnit;
begin
  if FOwnerUnit = nil then
  begin
    if Collection is T0SXAbsrtactItems then
      FOwnerUnit := T0SXAbsrtactItems(Collection).OwnerUnit;
  end;
  Result := FOwnerUnit;
end;

procedure T0SXAbsrtactItem.SetComment(const Value: T0SXCommentItem);
begin
  FComment := Value;
end;

procedure T0SXAbsrtactItem.SetName(const Value: string);
begin
  FName := Value;
end;

{ T0SXAbsrtactItems }

destructor T0SXAbsrtactItems.Destroy;
begin
  inherited;
end;


function T0SXAbsrtactItems.FindByName(AName: string): T0SXAbsrtactItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if T0SXAbsrtactItem(Items[i]).Name = AName then
    begin
      Result := T0SXAbsrtactItem(Items[i]);
      Exit;
    end;
end;

function T0SXAbsrtactItems.GetOwnerUnit: T0SXMetaUnit;
begin
  if FOwnerUnit = nil then
  begin
    if Self.OwnerObj is T0SXMetaUnit then
      FOwnerUnit := T0SXMetaUnit(Self.OwnerObj)
    else
    if Self.OwnerObj is T0SXAbsrtactItem then
      FOwnerUnit := T0SXAbsrtactItem(Self.OwnerObj).OwnerUnit
    else
      FOwnerUnit := nil;
  end;
  Result := FOwnerUnit;
end;

{ T0SXCommentItem }

procedure T0SXCommentItem.AddStrs(ADesc: array of String);
var
  i: Integer;
begin
  for i := Low(ADesc) to High(ADesc) do
    Description.Add( ADesc[i] );
end;

procedure T0SXCommentItem.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXCommentItem) then Exit;
  Self.CommentKind := T0SXCommentItem(Source).FCommentKind;
  Self.Description := T0SXCommentItem(Source).FDescription;
end;

constructor T0SXCommentItem.Create(ACollection: TCollection);
begin
  inherited;
  FCommentKind := k0ckBracket;
end;

destructor T0SXCommentItem.Destroy;
begin
  FreeAndNil(FDescription);
  inherited;
end;

function T0SXCommentItem.GetDescription: TStrings;
begin
  if FDescription = nil then
    FDescription := TStringList.Create;
  Result := FDescription;
end;

procedure T0SXCommentItem.SetCommentKind(const Value: K0CommentKind);
begin
  FCommentKind := Value;
end;

procedure T0SXCommentItem.SetDescription(const Value: TStrings);
begin
  if Value = nil then
    FreeAndNil(FDescription)
  else
    Description.Assign(Value);
end;

{ T0SXCommentItems }

function T0SXCommentItems.Add(ADesc: String): T0SXCommentItem;
begin
  Result := T0SXCommentItem(inherited Add);
  Result.Description.Add(ADesc);
end;

function T0SXCommentItems.AddWithStrs(ADesc: array of String): T0SXCommentItem;
var
  i: Integer;
begin
  Result := T0SXCommentItem(inherited Add);
  for i := Low(ADesc) to High(ADesc) do
    Result.Description.Add( ADesc[i] );
end;

function T0SXCommentItems.GetItems(const Index: Integer): T0SXCommentItem;
begin
  Result := T0SXCommentItem(inherited Items[Index]);
end;

procedure T0SXCommentItems.SetItems(const Index: Integer;
  const Value: T0SXCommentItem);
begin
  inherited Items[Index] := Value;
end;



{ T0SXMetaVariable }

procedure T0SXMetaVariable.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaVariable) then Exit;
  Self.TypeName := T0SXMetaVariable(Source).TypeName;
end;

procedure T0SXMetaVariable.SetTypeName(const Value: string);
begin
  FTypeName := Value;
end;

{ T0SXMetaVariables }

destructor T0SXMetaVariables.Destroy;
begin
  inherited;
end;

{ T0SXMetaConstant }

procedure T0SXMetaConstant.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaConstant) then Exit;
  Self.Value := T0SXMetaConstant(Source).Value;
end;

procedure T0SXMetaConstant.SetValue(const Value: string);
begin
  FValue := Value;
end;

{ T0SXMetaConstants }

destructor T0SXMetaConstants.Destroy;
begin
  inherited;
end;

{ T0SXMetaType }

destructor T0SXMetaType.Destroy;
begin
  inherited;
end;

{ T0SXMetaTypes }

destructor T0SXMetaTypes.Destroy;
begin
  inherited;
end;

{ T0SXMetaOrdinaryType }

procedure T0SXMetaOrdinaryType.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaOrdinaryType) then Exit;
  Self.Elements :=T0SXMetaOrdinaryType(Source).FElements;
end;

function T0SXMetaOrdinaryType.GetElements: T0SXAbsrtactItems;
begin
  if FElements = nil then
    FElements := T0SXAbsrtactItems.Create(Self, T0SXAbsrtactItem);
  Result := FElements;
end;

function T0SXMetaOrdinaryType.GetSubCollection: Ts0Collection;
begin
  Result := FElements;
end;

procedure T0SXMetaOrdinaryType.SetElements(const Value: T0SXAbsrtactItems);
begin
  if Value = nil then
    FreeAndNil(FElements)
  else
    Elements.Assign(Value);
end;

{ T0SXMetaOrdinaryTypes }

destructor T0SXMetaOrdinaryTypes.Destroy;
begin
  inherited;
end;

{ T0SXMetaSetType }

destructor T0SXMetaSetType.Destroy;
begin
  inherited;
end;

procedure T0SXMetaSetType.RestoreOrdinary;
  function GetOrdTypeName: string;
  var
    s: string;
  begin
    Result := Self.Name;
    if Length(Result) < 5 then Exit;
    s := Copy(Self.Name, Length(Self.Name) - 3, 3);
    if SameText(s, 'SET') then
    begin
      Result := Copy(Self.Name, 1, Length(Self.Name) - 3);
      Exit;
    end;
    s := Copy(Self.Name, Length(Self.Name) - 3, 3);
    if SameText(S, 'ies') then
    begin
      Result := Copy(Self.Name, 1, Length(Self.Name) - 3) + 'y';
      Exit;
    end;
    s := Copy(Self.Name, Length(Self.Name) - 1, 1);
    if SameText(s, 's') then
    begin
      Result := Copy(Self.Name, 1, Length(Self.Name) - 1);
    end;
  end;
begin
  if OrdinaryType <> nil then Exit;
  FOrdinaryType := T0SXMetaOrdinaryType.Create(OwnerUnit.Types);
  FOrdinaryType.Name := GetOrdTypeName;
  FOrdinaryType.Elements.Assign(Self.Elements);
end;

{ T0SXMetaSetTypes }

destructor T0SXMetaSetTypes.Destroy;
begin
  inherited;
end;

{ T0SXMetaRecoedType }

procedure T0SXMetaRecoedType.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaRecoedType) then Exit;
  Self.Fields := T0SXMetaRecoedType(Source).FFields;
end;

function T0SXMetaRecoedType.GetFields: T0SXMetaVariables;
begin
  if FFields = nil then
    FFields := T0SXMetaVariables.Create(Self, T0SXMetaVariable);
  Result := FFields;
end;

function T0SXMetaRecoedType.GetSubCollection: Ts0Collection;
begin
  Result := FFields;
end;

procedure T0SXMetaRecoedType.SetFields(const Value: T0SXMetaVariables);
begin
  if Value = nil then
    FreeAndNil(FFields)
  else
    Fields.Assign(Value);
end;

{ T0SXMetaRecoedTypes }

destructor T0SXMetaRecoedTypes.Destroy;
begin
  inherited;
end;

{ T0SXMethodParam }

procedure T0SXMethodParam.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMethodParam) then Exit;

end;

procedure T0SXMethodParam.SetDefaultValue(const Value: string);
begin
  FDefaultValue := Value;
end;

procedure T0SXMethodParam.SetParamKind(const Value: K0ParamKind);
begin
  FParamKind := Value;
end;

{ T0SXMethodParams }

function T0SXMethodParams.AddParam(AName, AType: string; AKind: K0ParamKind;
  ADefault: string): T0SXMethodParam;
begin
  Result := T0SXMethodParam(inherited Add);
  Result.Name := AName;
  Result.TypeName := AType;
  Result.ParamKind := AKind;
  Result.DefaultValue := ADefault;
end;

function T0SXMethodParams.GetItems(const Index: Integer): T0SXMethodParam;
begin
  Result := T0SXMethodParam(inherited Items[Index]);
end;

procedure T0SXMethodParams.SetItems(const Index: Integer;
  const Value: T0SXMethodParam);
begin
  inherited Items[Index] := Value;
end;

{ T0SXMetaFunctionIntf }

procedure T0SXMetaFunctionIntf.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaFunctionIntf) then Exit;
  Self.Params := T0SXMetaFunctionIntf(Source).FParams;
  Self.ReturnTypeName := T0SXMetaFunctionIntf(Source).ReturnTypeName;
end;

destructor T0SXMetaFunctionIntf.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

function T0SXMetaFunctionIntf.GetParams: T0SXMethodParams;
begin
  if FParams = nil then
    FParams := T0SXMethodParams.Create(Self, T0SXMethodParam);
  Result := FParams;
end;

function T0SXMetaFunctionIntf.GetSubCollection: Ts0Collection;
begin
  Result := FParams;
end;

procedure T0SXMetaFunctionIntf.SetImplMethod(
  const Value: T0SXMetaFunctionImpl);
begin
  FImplMethod := Value;
end;

procedure T0SXMetaFunctionIntf.SetParams(const Value: T0SXMethodParams);
begin
  if Value = nil then
    FreeAndNil(FParams)
  else
    Params.Assign(Value);
end;

procedure T0SXMetaFunctionIntf.SetReturnTypeName(const Value: string);
begin
  FReturnTypeName := Value;
end;

{ T0SXMetaFunctionIntfs }

destructor T0SXMetaFunctionIntfs.Destroy;
begin
  inherited;
end;

{ T0SXMetaFunctionImpl }

procedure T0SXMetaFunctionImpl.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is T0SXMetaFunctionImpl) then Exit;
  Self.ImplementCode := T0SXMetaFunctionImpl(Source).FImplementCode;
end;

constructor T0SXMetaFunctionImpl.Create(ACollection: TCollection);
begin
  inherited;
  FWithoutBeginEnd := False;
end;

destructor T0SXMetaFunctionImpl.Destroy;
begin
  FreeAndNil(FImplementCode);
  inherited;
end;

function T0SXMetaFunctionImpl.GetImplementCode: TStrings;
begin
  if FImplementCode = nil then
    FImplementCode := TStringList.Create;
  Result := FImplementCode;
end;

procedure T0SXMetaFunctionImpl.SetImplementCode(const Value: TStrings);
begin
  if Value = nil then
    FreeAndNil(FImplementCode)
  else
    ImplementCode.Assign(Value);
end;

procedure T0SXMetaFunctionImpl.SetIntfMethod(
  const Value: T0SXMetaFunctionIntf);
begin
  FIntfMethod := Value;
end;

{ T0SXMetaFunctionImpls }

function T0SXMetaFunctionImpls.Add(AName: string): T0SXMetaFunctionImpl;
begin
  Result := T0SXMetaFunctionImpl(inherited Add);
  Result.Name := AName;
end;

function T0SXMetaFunctionImpls.AddWithIntf(
  AIntf: T0SXMetaFunctionIntf): T0SXMetaFunctionImpl;
var
  nm: string;
begin
  Result := T0SXMetaFunctionImpl(inherited Add);
  if AIntf = nil then Exit;
  if AIntf is T0SXMetaMethod then
    nm := T0SXMetaMethod(AIntf).OwnerClass.Name +'.'+ AIntf.Name
  else
    nm := AIntf.Name;
  Result.Name := nm;
  Result.IntfMethod := AIntf;
  AIntf.ImplMethod := Result;
end;

destructor T0SXMetaFunctionImpls.Destroy;
begin
  inherited;
end;

function T0SXMetaFunctionImpls.FindByIntf(
  AIntf: T0SXMetaFunctionIntf): T0SXMetaFunctionImpl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if T0SXMetaFunctionImpl(Items[i]).IntfMethod = AIntf then
    begin
      Result := T0SXMetaFunctionImpl(Items[i]);
      Exit;
    end;
end;

{ T0SXMetaField }

procedure T0SXMetaField.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaField) then Exit;
  Self.TypeName := T0SXMetaField(Source).TypeName;
  Self.Visibility := T0SXMetaField(Source).Visibility;
end;

function T0SXMetaField.GetOwnerClass: T0SXMetaClass;
begin
  Assert(CollectionAs0Level <> nil, 'Illegal Collection Class');
  Result := T0SXMetaClass(CollectionAs0Level.OwnerObj);
end;

procedure T0SXMetaField.SetTypeName(const Value: string);
begin
  FTypeName := Value;
end;

procedure T0SXMetaField.SetVisibility(const Value: K0ClassPartVisibility);
begin
  FVisibility := Value;
end;

{ T0SXMetaFields }

function T0SXMetaFields.Add(AName, AType: string): T0SXMetaField;
begin
  Result := T0SXMetaField(inherited Add);
  Result.Name := AName;
  Result.TypeName := AType;
end;

function T0SXMetaFields.GetItems(const Index: Integer): T0SXMetaField;
begin
  Result := T0SXMetaField(inherited Items[Index]);
end;

procedure T0SXMetaFields.SetItems(const Index: Integer;
  const Value: T0SXMetaField);
begin
  inherited Items[Index] := Value;
end;

{ T0SXMetaMethod }

procedure T0SXMetaMethod.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaMethod) then Exit;
  Self.IsAbstract := T0SXMetaMethod(Source).IsAbstract;
  Self.IsStatic := T0SXMetaMethod(Source).IsStatic;
  Self.MethodKind := T0SXMetaMethod(Source).MethodKind;
  Self.Visibility := T0SXMetaMethod(Source).Visibility;
end;

function T0SXMetaMethod.GetOwnerClass: T0SXMetaClass;
begin
  Assert(CollectionAs0Level <> nil, 'Illegal Collection Class');
  Result := T0SXMetaClass(CollectionAs0Level.OwnerObj);
end;

procedure T0SXMetaMethod.SetIsAbstract(const Value: Boolean);
begin
  FIsAbstract := Value;
end;

procedure T0SXMetaMethod.SetIsStatic(const Value: Boolean);
begin
  FIsStatic := Value;
end;

procedure T0SXMetaMethod.SetMethodKind(const Value: K0MethodKind);
begin
  FMethodKind := Value;
end;

procedure T0SXMetaMethod.SetMethodType(const Value: K0MethodType);
begin
  FMethodType := Value;
end;

procedure T0SXMetaMethod.SetVisibility(const Value: K0ClassPartVisibility);
begin
  FVisibility := Value;
end;

{ T0SXMetaMethods }

function T0SXMetaMethods.Add(AName, AReturn: string; AWithImpl: Boolean): T0SXMetaMethod;
begin
  Result := T0SXMetaMethod(inherited Add);
  Result.Name := AName;
  Result.ReturnTypeName := AReturn;
  if AWithImpl then
  begin
    if OwnerUnit = nil then Exit;
    OwnerUnit.MethodImpls.AddWithIntf(Result);
  end;
end;

function T0SXMetaMethods.GetItems(const Index: Integer): T0SXMetaMethod;
begin
  Result := T0SXMetaMethod(inherited Items[Index]);
end;

procedure T0SXMetaMethods.SetItems(const Index: Integer;
  const Value: T0SXMetaMethod);
begin
  inherited Items[Index] := Value;
end;

{ T0SXMetaProperty }

procedure T0SXMetaProperty.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaProperty) then Exit;
  Self.DefaultAccess := T0SXMetaProperty(Source).FDefaultAccess;
  Self.DefaultValue := T0SXMetaProperty(Source).FDefaultValue;
  Self.ReadAccessorName := T0SXMetaProperty(Source).FReadAccessorName;
  Self.WriteAccessorName := T0SXMetaProperty(Source).FWriteAccessorName;
  Self.StoredValue := T0SXMetaProperty(Source).FStoredValue;
  Self.Visibility := T0SXMetaProperty(Source).FVisibility;
end;

destructor T0SXMetaProperty.Destroy;
begin
  inherited;
end;

function T0SXMetaProperty.GetOwnerClass: T0SXMetaClass;
begin
  Assert(CollectionAs0Level <> nil, 'Illegal Collection Class');
  Result := T0SXMetaClass(CollectionAs0Level.OwnerObj);
end;

function T0SXMetaProperty.GetReadAccessor: T0SXAbsrtactItem;
begin
  Result := FReadAccessor;
end;

function T0SXMetaProperty.GetWriteAccessor: T0SXAbsrtactItem;
begin
  Result := FWriteAccessor;
end;

procedure T0SXMetaProperty.SetDefaultAccess(const Value: Boolean);
begin
  FDefaultAccess := Value;
end;

procedure T0SXMetaProperty.SetDefaultValue(const Value: string);
begin
  FDefaultValue := Value;
end;

procedure T0SXMetaProperty.SetReadAccessorName(const Value: string);
begin
  FReadAccessorName := Value;
end;

procedure T0SXMetaProperty.SetStoredValue(const Value: string);
begin
  FStoredValue := Value;
end;

procedure T0SXMetaProperty.SetVisibility(const Value: K0ClassPartVisibility);
begin
  FVisibility := Value;
end;

procedure T0SXMetaProperty.SetWriteAccessorName(const Value: string);
begin
  FWriteAccessorName := Value;
end;

{ T0SXMetaProperties }

function T0SXMetaProperties.Add(AName, AType, AGetter,
  ASetter: string; AWithAccessor: Boolean): T0SXMetaProperty;
  procedure RestoreAccessor(AcsrName: string; var Acsr: T0SXAbsrtactItem; ARead: Boolean);
  var
    cls: T0SXMetaClass;
  begin
    if Acsr <> nil then Exit;
    if AcsrName = '' then Exit;
    if not(Self.OwnerObj is T0SXMetaClass) then Exit;
    cls := T0SXMetaClass(Self.OwnerObj);
    Acsr := cls.Fields.FindByName(AcsrName);
    if Acsr <> nil then Exit;
    Acsr := cls.Methods.FindByName(AcsrName);
    if Acsr <> nil then Exit;
    //
    if AcsrName[1] = 'F' then
    begin
      Acsr := cls.Fields.Add(AcsrName, AType);
      T0SXMetaField(Acsr).Visibility := k0cpvPrivate;
    end
    else
    if ARead then
    begin
      Acsr := cls.Methods.Add(AcsrName, AType);
      T0SXMetaMethod(Acsr).Visibility := k0cpvPrivate;
    end
    else
    begin
      Acsr := cls.Methods.Add(AcsrName, '', );
      T0SXMetaMethod(Acsr).Params.AddParam('Value', AType, k0pkConst);
      T0SXMetaMethod(Acsr).Visibility := k0cpvPrivate;
    end;
  end;
begin
  Result := T0SXMetaProperty(inherited Add);
  Result.Name := AName;
  Result.ReturnTypeName := AType;
  if AGetter = '' then AGetter := 'F' + AName;
  if ASetter = '' then ASetter := 'Set' + AName;
  Result.ReadAccessorName := AGetter;
  Result.WriteAccessorName := ASetter;
  //
  if not AWithAccessor then Exit;
  RestoreAccessor(
    Result.ReadAccessorName,
    Result.FReadAccessor,
    True
  );
  RestoreAccessor(
    Result.WriteAccessorName,
    Result.FWriteAccessor,
    False
  );       
end;

function T0SXMetaProperties.GetItems(const Index: Integer): T0SXMetaProperty;
begin
  Result := T0SXMetaProperty(inherited Items[Index]);
end;

procedure T0SXMetaProperties.SetItems(const Index: Integer;
  const Value: T0SXMetaProperty);
begin
  inherited Items[Index] := Value;
end;

{ T0SXMetaClass }

procedure T0SXMetaClass.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaClass) then Exit;
  Self.Fields := T0SXMetaClass(Source).FFields;
  Self.Methods := T0SXMetaClass(Source).FMethods;
  Self.Properties := T0SXMetaClass(Source).FProperties;
  Self.SuperClassName := T0SXMetaClass(Source).FSuperClassName;
end;

destructor T0SXMetaClass.Destroy;
var
  i: K0ClassPartVisibility;
begin
  for i := Low(K0ClassPartVisibility) to High(K0ClassPartVisibility) do
    FreeAndNil( FSeqMembers[i] );
  FreeAndNil(FFields);
  FreeAndNil(FMethods);
  FreeAndNil(FProperties);
  inherited;       
end;

procedure T0SXMetaClass.FindItems(Source: T0SXAbsrtactItems;
  Dest: Ts0CollectionItemList; AVisibility: K0ClassPartVisibility);
var
  i: Integer;
  item: T0SXAbsrtactItem;
begin
  Dest.Clear;
  if not( (Source is T0SXMetaFields) or
          (Source is T0SXMetaMethods) or
          (Source is T0SXMetaProperties) ) then Exit;
  for i := 0 to Source.Count -1 do
  begin
    item := T0SXAbsrtactItem(Source.Items[i]);
    if (item is T0SXMetaField) and (T0SXMetaField(item).Visibility = AVisibility) then Dest.Add(item);
    if (item is T0SXMetaMethod) and (T0SXMetaMethod(item).Visibility = AVisibility) then Dest.Add(item);
    if (item is T0SXMetaProperty) and (T0SXMetaProperty(item).Visibility = AVisibility) then Dest.Add(item);
  end;
end;

function T0SXMetaClass.GetFields: T0SXMetaFields;
begin
  if FFields = nil then
    FFields := T0SXMetaFields.Create(Self, T0SXMetaField);
  Result := FFields;
end;

function T0SXMetaClass.GetMethods: T0SXMetaMethods;
begin
  if FMethods = nil then
    FMethods := T0SXMetaMethods.Create(Self, T0SXMetaMethod);
  Result := FMethods;
end;

function T0SXMetaClass.GetProperties: T0SXMetaProperties;
begin
  if FProperties = nil then
    FProperties := T0SXMetaProperties.Create(Self, T0SXMetaProperty);
  Result := FProperties;
end;

function T0SXMetaClass.GetSeqMembers(
  const Index: K0ClassPartVisibility): T0SXItemSequences;
begin
  if FSeqMembers[Index] = nil then
    FSeqMembers[Index] := T0SXItemSequences.Create(Self, T0SXItemSequence);
  Result := FSeqMembers[Index];
end;

function T0SXMetaClass.GetSuperClass: T0SXMetaClass;
begin
  Result := nil;
end;

procedure T0SXMetaClass.RefreshSequence;
  procedure AddToSeq(AItems: T0SXAbsrtactItems; ASeqs: T0SXItemSequences; Index: K0ClassPartVisibility;
    AList: Ts0CollectionItemList);
  var
    i: Integer;
  begin
    FindItems(AItems, AList, Index);
    AList.SortByIdentifier;
    for i := 0 to AList.Count -1 do
      ASeqs.Add( T0SXAbsrtactItem(AList.Items[i]) );
  end;
var
  i: K0ClassPartVisibility;
  lst: Ts0CollectionItemList;
begin
  lst := Ts0CollectionItemList.Create(False);
  try
    for i := Low(K0ClassPartVisibility) to High(K0ClassPartVisibility) do
    begin
      AddToSeq(Fields, SeqMembers[i], i, lst);
      AddToSeq(Methods, SeqMembers[i], i, lst);
      AddToSeq(Properties, SeqMembers[i], i, lst);
    end;
  finally
    FreeAndNil(lst);
  end;
end;

procedure T0SXMetaClass.SetFields(const Value: T0SXMetaFields);
begin
  if Value = nil then
    FreeAndNil(FFields)
  else
    Fields.Assign(Value);
end;

procedure T0SXMetaClass.SetMethods(const Value: T0SXMetaMethods);
begin
  if Value = nil then
    FreeAndNil(FMethods)
  else
    Methods.Assign(Value);
end;

procedure T0SXMetaClass.SetProperties(const Value: T0SXMetaProperties);
begin
  if Value = nil then
    FreeAndNil(FProperties)
  else
    Properties.Assign(Value);
end;

procedure T0SXMetaClass.SetSeqMembers(const Index: K0ClassPartVisibility;
  const Value: T0SXItemSequences);
begin
  if Value = nil then
    FreeAndNil(FSeqMembers[Index])
  else
    SeqMembers[Index].Assign(Value);
end;

procedure T0SXMetaClass.SetSuperClassName(const Value: string);
begin
  FSuperClassName := Value;
end;

{ T0SXMetaClasses }

function T0SXMetaClasses.GetItems(const Index: Integer): T0SXMetaClass;
begin
  Result := T0SXMetaClass(inherited Items[Index]);
end;

procedure T0SXMetaClasses.SetItems(const Index: Integer;
  const Value: T0SXMetaClass);
begin
  inherited Items[Index] := Value;
end;

{ T0SXItemSequence }

procedure T0SXItemSequence.SetItem(const Value: T0SXAbsrtactItem);
begin
  FItem := Value;
end;

{ T0SXItemSequences }

function T0SXItemSequences.Add(AItem: T0SXAbsrtactItem): T0SXItemSequence;
begin
  Result := T0SXItemSequence(inherited Add);
  Result.Item := AItem;
end;

destructor T0SXItemSequences.Destroy;
begin
  inherited;
end;

function T0SXItemSequences.GetItems(const Index: Integer): T0SXItemSequence;
begin
  Result := T0SXItemSequence(inherited Items[Index]);
end;

procedure T0SXItemSequences.SetItems(const Index: Integer;
  const Value: T0SXItemSequence);
begin
  inherited Items[Index] := Value;
end;

{ T0SXMetaUnit }

procedure T0SXMetaUnit.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is T0SXMetaUnit) then Exit;
  Self.Comments := T0SXMetaUnit(Source).FComments;
  Self.Constants := T0SXMetaUnit(Source).FConstants;
  Self.MethodImpls := T0SXMetaUnit(Source).FMethodImpls;
  Self.SeqIntf := T0SXMetaUnit(Source).FSeqIntf;
  Self.SeqImpl := T0SXMetaUnit(Source).FSeqImpl;
  Self.Types := T0SXMetaUnit(Source).FTypes;
  Self.UsesIntf := T0SXMetaUnit(Source).FUsesIntf;
  Self.UsesImpl := T0SXMetaUnit(Source).FUsesImpl;
end;

destructor T0SXMetaUnit.Destroy;
begin
  FreeAndNil(FComments);
  FreeAndNil(FConstants);
  FreeAndNil(FFinalizationCode);
  FreeAndNil(FInitializationCode);
  FreeAndNil(FMethodImpls);
  FreeAndNil(FTypes);
  FreeAndNil(FSeqImpl);
  FreeAndNil(FSeqIntf);
  FreeAndNil(FUsesImpl);
  FreeAndNil(FUsesIntf);
  FreeAndNil(FVariables);
  inherited;
end;

procedure T0SXMetaUnit.FindItems(Source: T0SXDeclareItems;
  Dest: Ts0CollectionItemList; ABlock: K0UnitBlockType; AOnlyClasses: Boolean);
var
  i: Integer;
begin
  Dest.Clear;
  for i := 0 to Source.Count -1 do
    if Source.Items[i] is T0SXDeclareItem then
      if T0SXDeclareItem(Source.Items[i]).DeclareBlock = ABlock then
        if AOnlyClasses then
        begin
          if Source.Items[i] is T0SXMetaClass then
            Dest.Add(Source.Items[i]);
        end
        else
        begin
          if not(Source.Items[i] is T0SXMetaClass) then
            Dest.Add(Source.Items[i]);
        end;
end;

function T0SXMetaUnit.GetComments: T0SXCommentItems;
begin
  if FComments = nil then
    FComments := T0SXCommentItems.Create(Self, T0SXCommentItem);
  Result := FComments;
end;

function T0SXMetaUnit.GetConstants: T0SXMetaConstants;
begin
  if FConstants = nil then
    FConstants := T0SXMetaConstants.Create(Self, T0SXMetaConstant);
  Result := FConstants;
end;

function T0SXMetaUnit.GetFinalizationCode: TStrings;
begin
  if FFinalizationCode = nil then
    FFinalizationCode := TStringList.Create;
  Result := FFinalizationCode;
end;

function T0SXMetaUnit.GetInitializationCode: TStrings;
begin
  if FInitializationCode = nil then
    FInitializationCode := TStringList.Create;
  Result := FInitializationCode;
end;

function T0SXMetaUnit.GetMethodImpls: T0SXMetaFunctionImpls;
begin
  if FMethodImpls = nil then
    FMethodImpls := T0SXMetaFunctionImpls.Create(Self, T0SXMetaFunctionImpl);
  Result := FMethodImpls;
end;

function T0SXMetaUnit.GetMethodIntfs: T0SXMetaFunctionIntfs;
begin
  if FMethodIntfs = nil then
    FMethodIntfs := T0SXMetaFunctionIntfs.Create(Self, T0SXMetaFunctionIntf);
  Result := FMethodIntfs;
end;

function T0SXMetaUnit.GetSeqImpl: T0SXItemSequences;
begin
  if FSeqImpl = nil then
    FSeqImpl := T0SXItemSequences.Create(Self, T0SXItemSequence);
  Result := FSeqImpl;
end;

function T0SXMetaUnit.GetSeqIntf: T0SXItemSequences;
begin
  if FSeqIntf = nil then
    FSeqIntf := T0SXItemSequences.Create(Self, T0SXItemSequence);
  Result := FSeqIntf;
end;

function T0SXMetaUnit.GetTypes: T0SXMetaTypes;
begin
  if FTypes = nil then
    FTypes := T0SXMetaTypes.Create(Self, T0SXMetaType);
  Result := FTypes;
end;

function T0SXMetaUnit.GetUsesImpl: TStrings;
begin
  if FUsesImpl = nil then
    FUsesImpl := TStringList.Create;
  Result := FUsesImpl;
end;

function T0SXMetaUnit.GetUsesIntf: TStrings;
begin
  if FUsesIntf = nil then
    FUsesIntf := TStringList.Create;
  Result := FUsesIntf;
end;

function T0SXMetaUnit.GetVariables: T0SXMetaVariables;
begin
  if FVariables = nil then
    FVariables := T0SXMetaVariables.Create(Self, T0SXMetaVariable);
  Result := FVariables;
end;

procedure T0SXMetaUnit.RefreshSequence;
  procedure SortImplFunctions;
  var
    sortListMethods, sortListFunctions: Ts0CollectionItemList;
    i: Integer;
    idx: Integer;
    mthd: T0SXMetaFunctionImpl;
  begin
    sortListMethods := Ts0CollectionItemList.Create(False);
    try
      sortListFunctions := Ts0CollectionItemList.Create(False);
      try
        for i := 0 to MethodImpls.Count -1 do
        begin
          mthd := T0SXMetaFunctionImpl(MethodImpls.Items[i]);
          if mthd.IntfMethod is T0SXMetaMethod then
            sortListMethods.Add( mthd )
          else
            sortListFunctions.Add( mthd )
        end;
        sortListFunctions.SortByIdentifier;
        sortListMethods.SortByIdentifier;
        //
        for i := 0 to sortListFunctions.Count -1 do
        begin
          idx := MethodImpls.IndexOf(sortListFunctions.Items[i]);
          if idx < 0 then Continue;
          MethodImpls.Items[idx].Index := i;
        end;
        for i := 0 to sortListMethods.Count -1 do
        begin
          idx := MethodImpls.IndexOf(sortListMethods.Items[i]);
          if idx < 0 then Continue;
          MethodImpls.Items[idx].Index := i;
        end;
      finally
        FreeAndNil(sortListFunctions);
      end;
    finally
      FreeAndNil(sortListMethods);
    end;
  end;
  procedure AddToSeq(Source: T0SXDeclareItems; ASeqs: T0SXItemSequences;
    AList: Ts0CollectionItemList; ABlock: K0UnitBlockType;
    AOnlyClasses: Boolean);
  var
    i: Integer;
  begin
    FindItems(Source, AList, ABlock, AOnlyClasses);
    for i := 0 to AList.Count -1 do
      if AList.Items[i] is T0SXAbsrtactItem then
        ASeqs.Add( T0SXAbsrtactItem(AList.Items[i]) );
  end;
var
  itemList: Ts0CollectionItemList;
  i: Integer;
begin
  itemList := Ts0CollectionItemList.Create(False);
  try
    // interface
    SeqIntf.Clear;
    AddToSeq(Types    , SeqIntf, itemList, k0ubtInterface, False);
    AddToSeq(Constants, SeqIntf, itemList, k0ubtInterface, False);
    AddToSeq(Types    , SeqIntf, itemList, k0ubtInterface, True );
    AddToSeq(Variables, SeqIntf, itemList, k0ubtInterface, False);
    for i := 0 to MethodIntfs.Count -1 do
      FSeqIntf.Add( T0SXMetaFunctionIntf(MethodIntfs.Items[i]) );

    // implementation
    SeqImpl.Clear;
    AddToSeq(Types    , SeqImpl, itemList, k0ubtImplementation, False);
    AddToSeq(Constants, SeqImpl, itemList, k0ubtImplementation, False);
    AddToSeq(Types    , SeqImpl, itemList, k0ubtImplementation, True );
    AddToSeq(Variables, SeqImpl, itemList, k0ubtImplementation, False);
    SortImplFunctions;
    for i := 0 to MethodImpls.Count -1 do
      FSeqImpl.Add( T0SXMetaFunctionImpl(MethodImpls.Items[i]) );
  finally
    FreeAndNil(itemList);
  end;
  //
  for i := 0 to Types.Count -1 do
    if Types.Items[i] is T0SXMetaClass then
      T0SXMetaClass(Types.Items[i]).RefreshSequence;
end;

procedure T0SXMetaUnit.SetComments(const Value: T0SXCommentItems);
begin
  if Value = nil then
    FreeAndNil(FComments)
  else
    Comments.Assign(Value);
end;

procedure T0SXMetaUnit.SetConstants(const Value: T0SXMetaConstants);
begin
  if Value = nil then
    FreeAndNil(FConstants)
  else
    Constants.Assign(Value);
end;

procedure T0SXMetaUnit.SetFinalizationCode(const Value: TStrings);
begin
  if Value = nil then
    FreeAndNil(FFinalizationCode)
  else
    FinalizationCode.Assign(Value);
end;

procedure T0SXMetaUnit.SetImplComment(const Value: T0SXCommentItem);
begin
  FImplComment := Value;
end;

procedure T0SXMetaUnit.SetInitializationCode(const Value: TStrings);
begin
  if Value = nil then
    FreeAndNil(FInitializationCode)
  else
    InitializationCode.Assign(Value);
end;

procedure T0SXMetaUnit.SetMethodImpls(const Value: T0SXMetaFunctionImpls);
begin
  if Value = nil then
    FreeAndNil(FMethodImpls)
  else
    MethodImpls.Assign(Value);
end;

procedure T0SXMetaUnit.SetMethodIntfs(const Value: T0SXMetaFunctionIntfs);
begin
  if Value = nil then
    FreeAndNil(FMethodIntfs)
  else
    MethodIntfs.Assign(Value);
end;

procedure T0SXMetaUnit.SetSeqImpl(const Value: T0SXItemSequences);
begin
  if Value = nil then
    FreeAndNil(FSeqImpl)
  else
    SeqImpl.Assign(Value);
end;

procedure T0SXMetaUnit.SetSeqIntf(const Value: T0SXItemSequences);
begin
  if Value = nil then
    FreeAndNil(FSeqIntf)
  else
    SeqIntf.Assign(Value);
end;

procedure T0SXMetaUnit.SetTypes(const Value: T0SXMetaTypes);
begin
  if Value = nil then
    FreeAndNil(FTypes)
  else
    Types.Assign(Value);
end;

procedure T0SXMetaUnit.SetUsesImpl(const Value: TStrings);
begin
  if Value = nil then
    FreeAndNil(FUsesImpl)
  else
    UsesImpl.Assign(Value);
end;

procedure T0SXMetaUnit.SetUsesIntf(const Value: TStrings);
begin
  if Value = nil then
    FreeAndNil(FUsesIntf)
  else
    UsesIntf.Assign(Value);
end;

procedure T0SXMetaUnit.SetVariables(const Value: T0SXMetaVariables);
begin
  if Value = nil then
    FreeAndNil(FVariables)
  else
    Variables.Assign(Value);
end;

{ T0SXMetaUnits }

function T0SXMetaUnits.AddUnit(AUnitName: string): T0SXMetaUnit;
begin
  Result := T0SXMetaUnit(inherited Add);
  Result.Name := AUnitName;
end;

function T0SXMetaUnits.GetUnits(const Index: Integer): T0SXMetaUnit;
begin
  Result := T0SXMetaUnit(inherited Items[Index]);
end;

procedure T0SXMetaUnits.SetUnits(const Index: Integer;
  const Value: T0SXMetaUnit);
begin
  inherited Items[Index] := Value;
end;

{ Tc0SXProject }

destructor Tc0SXProject.Destroy;
begin
  FreeAndNil(FUnits);
  inherited;       
end;

function Tc0SXProject.GetUnits: T0SXMetaUnits;
begin
  if FUnits = nil then
    FUnits := T0SXMetaUnits.Create(Self, T0SXMetaUnit);
  Result := FUnits;
end;

procedure Tc0SXProject.SetUnits(const Value: T0SXMetaUnits);
begin
  FUnits.Assign(Value);
end;

{ T0SXDeclareItem }

destructor T0SXDeclareItem.Destroy;
begin
  inherited;

end;

procedure T0SXDeclareItem.SetDeclareBlock(const Value: K0UnitBlockType);
begin
  FDeclareBlock := Value;
end;

{ T0SXDeclareItems }

destructor T0SXDeclareItems.Destroy;
begin
  inherited;

end;

end.
