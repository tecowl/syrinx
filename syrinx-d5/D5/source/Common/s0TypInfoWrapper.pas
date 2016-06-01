unit s0TypInfoWrapper;
{
$History: s0TypInfoWrapper.pas $
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/06   Time: 4:43
 * Updated in $/source/D5Integrated
 * GetPropNamesByClass、GetPropNamesByTypeNameメソッドを追加
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/01/25   Time: 4:45
 * Updated in $/source/D6VCLIntegrated
 * PropAsVariantプロパティを追加。
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/01/10   Time: 16:54
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/01/10   Time: 3:18
 * Updated in $/source/D5Integrated
 * Ts0TypeKindHelperクラスとK0WrappedTypeKind型の追加
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/01/06   Time: 0:23
 * Updated in $/source/D5Integrated
 * Ts0MethodEnumeratorクラスを追加。
 * Ts0RTTIPublishedAccessorクラスにExecuteMethodメソッドを追加。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/12/04   Time: 1:46
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/11/26   Time: 3:41
 * Updated in $/source/D5Integrated
 * EnabledAsStringメソッドを変更。TStrings、TStringListも文字列として扱え
 * るよね。
 * で、TStringsの値をTextではなく、CommaTextでやり取りするように変更
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/11/25   Time: 5:39
 * Updated in $/source/D5Integrated
 * SetPropAsStringメソッドでTStringsの値も設定できるようにした。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/11/21   Time: 20:55
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/17   Time: 12:27
 * Updated in $/source/D5Integrated
 * Ts0RTTIPublishedAccessor.ClearValuesメソッドを追加
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/11   Time: 1:20
 * Updated in $/source/D5Integrated
 * EnabledAsString、PropertyExists、PropTypeKindメソッドを追加
 * PropAsStringプロパティも追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/03   Time: 23:41
 * Updated in $/source/D5Integrated
 * GetIdentifierを追加
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/01   Time: 17:37
 * Updated in $/source/D5Integrated
 * CompEnumTypeプロパティを追加
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/27   Time: 9:18
 * Updated in $/source/D5Integrated
 * DefaultValueを取得できるように変更
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/23   Time: 1:12
 * Updated in $/source/D5Integrated
 * GetNameListで要素を取得する方法を変更。（以前の方法ではダメ）
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/19   Time: 20:46
 * Updated in $/source/D5Integrated
 * tkEnumerationのNameListを取得するための実装を行った
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/13   Time: 23:27
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/12   Time: 18:35
 * Updated in $/source/D5Integrated
 * Ts0RTTIPublishedBroker.GetTypeInfoでTypeInfoプロパティに値をセットする
 * ように変更
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/11   Time: 0:29
 * Created in $/source/D5Integrated
 * 新規作成
 * u0SXRTTIPropからTypInfoユニットに深く関係する部分を抽出した。
}

interface

uses
  SysUtils, Classes, TypInfo, Contnrs,
  s0Collection;

const
	c0_TypeKind_Names: array[TTypeKind] of String =
  	( 'tkUnknown', 'tkInteger', 'tkChar', 'tkEnumeration', 'tkFloat',
    	'tkString', 'tkSet', 'tkClass', 'tkMethod', 'tkWChar', 'tkLString',
      'tkWString', 'tkVariant', 'tkArray', 'tkRecord', 'tkInterface',
      'tkInt64', 'tkDynArray' );

type
  Ts0MethodEnumerator = class
  protected
    FMethodNameList: array of string;
    function GetNameOfMethod(Index: integer): string;
    function GetMethodCount: Integer;
  public
    constructor Create(AClass: TClass);
    function IndexOf(AMethodName: string): Integer;
    property MethodCount: integer read GetMethodCount;
    property NameOfMethod[index: Integer]: string read GetNameOfMethod;
  end;

type
  Ts0RTTITypeInfo = class;

  Ts0RTTIProp = class(Ts0CollectionItem)
  private
    FPropInfo: PPropInfo;
    FTypeInfo: Ts0RTTITypeInfo;
    function GetTypeInfo: Ts0RTTITypeInfo;
    function GetPropName: ShortString;
    function GetDefaultValue: LongInt;
  protected
    function GetIdentifier: string; override;
  public
    procedure Assign(Source: TPersistent); override;
    property TypeInfo: Ts0RTTITypeInfo read GetTypeInfo;
  published
    property DefaultValue: LongInt read GetDefaultValue;
    property PropName: ShortString read GetPropName;
  end;

  Ts0RTTIProps = class(Ts0Collection)
  private
    function GetProps(const Index: Integer): Ts0RTTIProp;
    procedure SetProps(const Index: Integer; const Value: Ts0RTTIProp);
  public
    function AddProp(AInfo: PPropInfo): Ts0RTTIProp;
    procedure CopyNamesTo(Dest: TStrings);
    function PropByName(APropName: string): Ts0RTTIProp;
    property Props[const Index: Integer]: Ts0RTTIProp read GetProps write SetProps; default;
  end;

  Ts0RTTIPublished = class(TPersistent)
  private
    FProps: Ts0RTTIProps;
    FSource: TClass;
    FOwnerTypeInfo: Ts0RTTITypeInfo;
    FMethodEnumerator: Ts0MethodEnumerator;
    function GetOwnerTypeInfo: Ts0RTTITypeInfo;
    procedure SetProps(const Value: Ts0RTTIProps);
    procedure SetSource(const Value: TClass);
    function GetMethodEnumerator: Ts0MethodEnumerator;
  public
    constructor Create(AOwner: Ts0RTTITypeInfo);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure GetPropNamesByTypeName(Dest: TStrings; ATypeName: string; AExactlly: Boolean = False);
    procedure GetPropNamesByClass(Dest: TStrings; AClass: TClass; AExactlly: Boolean = False);
    procedure Refresh;
    property Source: TClass read FSource write SetSource;
    property OwnerTypeInfo: Ts0RTTITypeInfo read GetOwnerTypeInfo;
    property MethodEnumerator: Ts0MethodEnumerator read GetMethodEnumerator;
  published
    property Props: Ts0RTTIProps read FProps write SetProps;
  end;

  Ts0RTTITypeInfo = class(Ts0CollectionItem)
  private
    FCompEnumType: Ts0RTTITypeInfo;
    FPublishedProps: Ts0RTTIPublished;
    FClassOfType: TClass;
    FTypeInfo: PTypeInfo;
    procedure SetFClassOfType(const Value: TClass);
    procedure SetFTypeInfo(const Value: PTypeInfo);
    function GetTypeKind: TTypeKind;
    function GetTypeName: ShortString;
    function GetTypeData: TTypeData;
    function GetCompEnumType: Ts0RTTITypeInfo;
  protected
    function GetIdentifier: string; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetEnumValue(AName: string): Integer;
    function GetName(AIndex: Integer): string;
    function GetNameList: string; //for tkEnumeration, tkSet
    property CompEnumType: Ts0RTTITypeInfo read GetCompEnumType;
    property ClassOfType: TClass read FClassOfType write SetFClassOfType;
    property PublishedProps: Ts0RTTIPublished read FPublishedProps;
    property TypeData: TTypeData read GetTypeData;
    property TypeInfo: PTypeInfo read FTypeInfo write SetFTypeInfo;
    property TypeKind: TTypeKind read GetTypeKind;
    property TypeName: ShortString read GetTypeName;
  end;

  Ts0RTTITypeInfos = class(Ts0Collection)
  private
    function GetTypes(const Index: Integer): Ts0RTTITypeInfo;
    procedure SetTypes(const Index: Integer; const Value: Ts0RTTITypeInfo);
  public
    function AddByClass(AClass: TClass): Ts0RTTITypeInfo;
    function AddByTypeInfo(ATypeInfo: PTypeInfo): Ts0RTTITypeInfo;
    function FindByClass(AClass: TClass): Ts0RTTITypeInfo;
    function FindByTypeInfo(ATypeInfo: PTypeInfo): Ts0RTTITypeInfo;
    property Types[const Index: Integer]: Ts0RTTITypeInfo read GetTypes write SetTypes; default;
  end;

type
  Ts0RTTIPublishedBroker = class(TComponent)
  private
    FInfos: Ts0RTTITypeInfos;
    procedure SetInfos(const Value: Ts0RTTITypeInfos);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindTypeInfo(ATypeName: string): Ts0RTTITypeInfo;
    function FindTypeInfoByClass(AClass: TClass): Ts0RTTITypeInfo;
    function GetTypeInfo(ATypeInfo: PTypeInfo): Ts0RTTITypeInfo;
    function GetTypeInfoByClass(AClass: TClass): Ts0RTTITypeInfo;
    class function Instance: Ts0RTTIPublishedBroker;
  published
    property Infos: Ts0RTTITypeInfos read FInfos write SetInfos;
  end;

type
  K0ExecMethodOfNoParam = procedure of object;

type
  Ts0RTTIPublishedAccessor = class
  private
    FBracketsOnGetSet: Boolean;
    FRTTINavigator: Ts0RTTIPublished;
    FInstance: TObject;
    FMinClassOnGetObject: TClass;
    FPreferStringsOnGetAsVariant: Boolean;
    procedure SetInstance(const Value: TObject);
    function GetPropAsString(const PropName: string): string;
    procedure SetPropAsString(const PropName, Value: string);
    function GetPropAsVariant(const PropName: string): Variant;
    procedure SetPropAsVariant(const PropName: string;
      const Value: Variant);
    procedure SetPreferStringsOnGetAsVariant(const Value: Boolean);
  private // accessor methods
    function GetOrdProp(const PropName: string): Longint;
    function GetEnumProp(const PropName: string): string;
    function GetSetProp(const PropName: string): string;
    function GetObjectProp(const PropName: string): TObject;
    function GetObjectPropClass(const PropName: string): TClass;
    function GetStrProp(const PropName: string): string;
    function GetFloatProp(const PropName: string): Extended;
    function GetVariantProp(const PropName: string): Variant;
    function GetMethodProp(const PropName: string): TMethod;
    function GetInt64Prop(const PropName: string): Int64;
    procedure SetOrdProp(const PropName: string; Value: Longint);
    procedure SetEnumProp(const PropName: string; const Value: string);
    procedure SetSetProp(const PropName: string; const Value: string);
    procedure SetObjectProp(const PropName: string; Value: TObject);
    procedure SetStrProp(const PropName: string; const Value: string);
    procedure SetFloatProp(const PropName: string; Value: Extended);
    procedure SetVariantProp(const PropName: string; const Value: Variant);
    procedure SetMethodProp(const PropName: string; const Value: TMethod);
    procedure SetInt64Prop(const PropName: string; const Value: Int64);
  protected
    class function CheckMethodIsNotEmpty(AMethodPointer: pointer): Boolean;
  public
    constructor Create(AInstance: TObject);
    procedure ClearValueOf(APropName: string);
    procedure ClearValues;
    function EnabledAsString(APropName: string): Boolean;
    procedure ExecuteMethod(AMethodName: string);
    function PropertyExists(APropName: string): Boolean;
    function PropTypeKind(APropName: string): TTypeKind;
    function PropTypeInfo(APropName: string): Ts0RTTITypeInfo;
    function PropTypeName(APropName: string): string;
    property PropAsString[const PropName: string]: string read GetPropAsString write SetPropAsString;
    property PropAsVariant[const PropName: string]: Variant read GetPropAsVariant write SetPropAsVariant;
    property PreferStringsOnGetAsVariant: Boolean read FPreferStringsOnGetAsVariant write SetPreferStringsOnGetAsVariant;
    property RTTINavigator: Ts0RTTIPublished read FRTTINavigator;
    property Instance: TObject read FInstance write SetInstance;
    property BracketsOnGetSet: Boolean read FBracketsOnGetSet write FBracketsOnGetSet default False;
    property MinClassOnGetObject: TClass read FMinClassOnGetObject write FMinClassOnGetObject;
    function IsStoredProp(const PropName: string): Boolean;
  public
    property OrdProp[const PropName: string]: Longint read GetOrdProp write SetOrdProp;
    property EnumProp[const PropName: string]: string read GetEnumProp write SetEnumProp;
    property SetProp[const PropName: string]: string read GetSetProp write SetSetProp;
    property ObjectProp[const PropName: string]: TObject read GetObjectProp write SetObjectProp;
    property ObjectPropClass[const PropName: string]: TClass read GetObjectPropClass;
    property StrProp[const PropName: string]: string read GetStrProp write SetStrProp;
    property FloatProp[const PropName: string]: Extended read GetFloatProp write SetFloatProp;
    property VariantProp[const PropName: string]: Variant read GetVariantProp write SetVariantProp;
    property MethodProp[const PropName: string]: TMethod read GetMethodProp write SetMethodProp;
    property Int64Prop[const PropName: string]: Int64 read GetInt64Prop write SetInt64Prop;
  end;

type
  K0WrappedTypeKind = (wtk0Unknown, wtk0Integer, wtk0Char, wtk0Enumeration,
    wtk0Boolean, wtk0Float, wtk0String, wtk0Set,
    wtk0Class, wtk0Persistent, wtk0Strings, wtk0Collection, wtk0Component, 
    wtk0Variant, wtk0Method, wtk0Array, wtk0Record, wtk0Interface, wtk0Int64,
    wtk0DynArray);

type
  Ts0TypeKindHelper = class
  public
    class function GetWrappedTypeKind(ATypeName: string; AKind: TTypeKind): K0WrappedTypeKind;
  end;

implementation

uses
  Graphics,
  s0TypeConvertor;

{ Ts0MethodEnumerator }

constructor Ts0MethodEnumerator.Create(AClass: TClass);
type
  TMethodTable = packed record
    count: SmallInt;
  //[...methods...]
  end;
var
  table: ^TMethodTable;
  name:  ^ShortString;
  i, j:  Integer;
begin
  inherited Create;
  while AClass <> nil do
  begin
    // *** HACK ALERT *** !!!
    // Review System.MethodName to grok how this method works
    asm
      mov  EAX, [AClass]
      mov  EAX,[EAX].vmtMethodTable { fetch pointer to method table }
      mov  [table], EAX
    end;
    if table <> nil then
    begin
      name := Pointer(PChar(table) + 8);
      for i := 1 to table.count do
      begin
        // check if we've seen the method name
        j := Low(FMethodNameList);
        while (j <= High(FMethodNameList)) and (name^ <> FMethodNameList[j]) do
          inc(j);
        // if we've seen the name, then the method has probably been overridden
        if j <= High(FMethodNameList) then
        begin
          name := Pointer(PChar(name) + length(name^) + 7);
          Continue;
        end;
        SetLength(FMethodNameList,length(FMethodNameList)+1);
        FMethodNameList[j] := name^;
        name := Pointer(PChar(name) + length(name^) + 7)
      end;
    end;
    AClass := AClass.ClassParent;
  end;
end;

function Ts0MethodEnumerator.GetMethodCount: Integer;
begin
  Result := Length(FMethodNameList);
end;

function Ts0MethodEnumerator.GetNameOfMethod(Index: integer): string;
begin
  Result := FMethodNameList[Index];
end;

function Ts0MethodEnumerator.IndexOf(AMethodName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := Low(FMethodNameList) to High(FMethodNameList) do
    if SameText(FMethodNameList[i], AMethodName) then
    begin
      Result := i;
      Exit;
    end;
end;

{ Ts0RTTIProp }

procedure Ts0RTTIProp.Assign(Source: TPersistent);
begin
  if Source is Ts0RTTIProp then ;
end;

function Ts0RTTIProp.GetDefaultValue: LongInt;
begin
  Result := FPropInfo^.Default;
  if Result < -100 then
    Result := 0;
end;

function Ts0RTTIProp.GetIdentifier: string;
begin
  Result := PropName;
end;

function Ts0RTTIProp.GetPropName: ShortString;
begin
  Result := FPropInfo^.Name;
end;

function Ts0RTTIProp.GetTypeInfo: Ts0RTTITypeInfo;
begin
  if FTypeInfo = nil then
    FTypeInfo := Ts0RTTIPublishedBroker.Instance.GetTypeInfo( FPropInfo^.PropType^ );
  Result := FTypeInfo;
end;

{ Ts0RTTIProps }

function Ts0RTTIProps.AddProp(AInfo: PPropInfo): Ts0RTTIProp;
begin
  Result := Ts0RTTIProp(inherited Add);
  Result.FPropInfo := AInfo;
end;

procedure Ts0RTTIProps.CopyNamesTo(Dest: TStrings);
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Dest.Add( Self.Props[i].PropName );
end;

function Ts0RTTIProps.GetProps(const Index: Integer): Ts0RTTIProp;
begin
  Result := Ts0RTTIProp(inherited Items[Index]);
end;

function Ts0RTTIProps.PropByName(APropName: string): Ts0RTTIProp;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if AnsiCompareText(APropName, Props[i].PropName) = 0 then
    begin
      Result := Props[i];
      Exit;
    end;
end;

procedure Ts0RTTIProps.SetProps(const Index: Integer;
  const Value: Ts0RTTIProp);
begin
  inherited Items[Index] := Value;
end;

{ Ts0RTTIPublished }

procedure Ts0RTTIPublished.Assign(Source: TPersistent);
begin
  inherited; 
end;

constructor Ts0RTTIPublished.Create(AOwner: Ts0RTTITypeInfo);
begin
  inherited Create;
  FOwnerTypeInfo := AOwner;
  FProps := Ts0RTTIProps.Create(Self, Ts0RTTIProp);
end;

destructor Ts0RTTIPublished.Destroy;
begin
  FreeAndNil(FMethodEnumerator);
  FreeAndNil(FProps);
  inherited Destroy;
end;

function Ts0RTTIPublished.GetMethodEnumerator: Ts0MethodEnumerator;
begin
  Result := nil;
  if FSource = nil then Exit;
  if FMethodEnumerator = nil then
    FMethodEnumerator := Ts0MethodEnumerator.Create(FSource);
  Result := FMethodEnumerator;
end;

function Ts0RTTIPublished.GetOwnerTypeInfo: Ts0RTTITypeInfo;
begin
  Result := FOwnerTypeInfo;
end;

procedure Ts0RTTIPublished.GetPropNamesByClass(Dest: TStrings;
  AClass: TClass; AExactlly: Boolean);
  function IsMatch(ATarget: TClass): Boolean;
  begin
    if AExactlly then
      Result := (ATarget = AClass)
    else
      Result := ATarget.InheritsFrom(AClass);
  end;
var
  i: Integer;
  p: Ts0RTTIProp;
begin
  Assert(Dest <> nil);
  Assert(AClass <> nil);
  for i := 0 to Props.Count -1 do
  begin
    p := Props.Props[i];
    if p.GetTypeInfo.GetTypeKind <> tkClass then Continue;
    if IsMatch(p.TypeInfo.TypeData.ClassType) then
      Dest.Add(p.PropName);
  end;
end;

procedure Ts0RTTIPublished.GetPropNamesByTypeName(Dest: TStrings;
  ATypeName: string; AExactlly: Boolean);
  function IsMatch(ATarget, AOrigin: Ts0RTTITypeInfo): Boolean;
  begin
    Result := ATarget = AOrigin;
    if Result then Exit;
    Result := False;
    if ATarget.TypeKind <> AOrigin.TypeKind then Exit;
    case ATarget.TypeKind of
      tkUnknown: Exit;
      //tkInteger: ;
      //tkChar: ;
      tkEnumeration:
      begin
        if not SameText(ATarget.TypeName, AOrigin.TypeName) then Exit;
      end;
      //tkFloat: ;
      tkSet:
      begin
        if not SameText(ATarget.TypeName, AOrigin.TypeName) then Exit;
      end;
      tkClass:
      begin
        if not ATarget.TypeData.ClassType.InheritsFrom(AOrigin.TypeData.ClassType) then Exit;
      end;
    end;
    Result := True;
  end;
var
  i: Integer;
  p: Ts0RTTIProp;
  typ: Ts0RTTITypeInfo;
begin
  Assert(Dest <> nil);
  Assert(ATypeName <> '');
  typ := nil;
  if not AExactlly then
    typ := Ts0RTTIPublishedBroker.Instance.FindTypeInfo(ATypeName);
  if typ = nil then
  begin
    for i := 0 to Props.Count -1 do
    begin
      p := Props.Props[i];
      if SameText(p.TypeInfo.TypeName, ATypeName) then
        Dest.Add(p.PropName);
    end;
  end
  else
  begin
    for i := 0 to Props.Count -1 do
    begin
      p := Props.Props[i];
      if IsMatch(p.TypeInfo, typ) then
        Dest.Add(p.PropName);
    end;
  end;
end;


procedure Ts0RTTIPublished.Refresh;
var
  i: Integer;
  Props: PPropList;
  TypeData: PTypeData;
  ti: PTypeInfo;
begin
  FProps.Clear;
  if FSource = nil then Exit;
  ti := FSource.ClassInfo;
  if ti = nil then Exit;
  TypeData := GetTypeData(ti);
  if (TypeData = nil) or (TypeData^.PropCount = 0) then Exit;
  GetMem(Props, TypeData^.PropCount * sizeof(PPropInfo));
  try
    GetPropInfos(FSource.ClassInfo, Props);
    for i := 0 to TypeData^.PropCount-1 do
    begin
      FProps.AddProp(Props^[i]);
    end;
  finally
    Freemem(Props);
  end;
end;

procedure Ts0RTTIPublished.SetProps(const Value: Ts0RTTIProps);
begin
  FProps.Assign(Value);
end;

procedure Ts0RTTIPublished.SetSource(const Value: TClass);
begin
  FSource := Value;
end;

{ Ts0RTTITypeInfo }

procedure Ts0RTTITypeInfo.Assign(Source: TPersistent);
begin
  inherited;
end;

constructor Ts0RTTITypeInfo.Create(ACollection: TCollection);
begin
  inherited;
  FPublishedProps := nil;
  FClassOfType := nil;
  FTypeInfo := nil;
end;

destructor Ts0RTTITypeInfo.Destroy;
begin
  FreeAndNil(FPublishedProps);
  inherited;
end;

function Ts0RTTITypeInfo.GetCompEnumType: Ts0RTTITypeInfo;
begin
  Result := nil;
  if Self.TypeKind <> tkSet then Exit;
  if TypeData.CompType = nil then Exit;
  if FCompEnumType = nil then
    FCompEnumType := Ts0RTTIPublishedBroker.Instance.Infos.AddByTypeInfo(TypeData.CompType^);
  Result := FCompEnumType;
end;

function Ts0RTTITypeInfo.GetEnumValue(AName: string): Integer;
begin
  Result := 0;
  case Self.TypeKind of
    tkEnumeration:
      Result := TypInfo.GetEnumValue(Self.TypeInfo, AName);
    tkSet:
      if CompEnumType <> nil then
        Result := CompEnumType.GetEnumValue(AName);
  end;
end;

function Ts0RTTITypeInfo.GetIdentifier: string;
begin
  Result := TypeName;
end;

function Ts0RTTITypeInfo.GetName(AIndex: Integer): string;
var
  maxV, minV: LongInt;
begin
  Result := '';
  if Self.TypeKind = tkSet then
  begin
    if TypeData.CompType = nil then Exit;
    if CompEnumType = nil then Exit;
    Result := CompEnumType.GetName(AIndex);
  end
  else
  if Self.TypeKind = tkEnumeration then
  begin
    maxV := TypeData.MaxValue;
    minV := TypeData.MinValue;
    if AIndex < minV then Exit;
    if AIndex > maxV then Exit;
      Result := TypInfo.GetEnumName(FTypeInfo, AIndex);
  end;
end;

function Ts0RTTITypeInfo.GetNameList: string;
var
  i: LongInt;
  maxV, minV: LongInt;
begin
  Result := '';
  if Self.TypeKind = tkSet then
  begin
    if TypeData.CompType = nil then Exit;
    if CompEnumType = nil then Exit;
    Result := CompEnumType.GetNameList;
  end
  else
  if Self.TypeKind = tkEnumeration then
  begin
    maxV := TypeData.MaxValue;
    minV := TypeData.MinValue;
    for i := minV to maxV do
      if Result = '' then
        Result := TypInfo.GetEnumName(FTypeInfo, i)
      else
        Result := Result +','+ TypInfo.GetEnumName(FTypeInfo, i);
  end;
end;

function Ts0RTTITypeInfo.GetTypeData: TTypeData;
var
  ptd: PTypeData;
begin
  ptd := TypInfo.GetTypeData(FTypeInfo);
  Result := ptd^;
end;

function Ts0RTTITypeInfo.GetTypeKind: TTypeKind;
begin
  Result := FTypeInfo^.Kind;
end;

function Ts0RTTITypeInfo.GetTypeName: ShortString;
begin
  Result := '';
  if FTypeInfo <> nil then
    Result := FTypeInfo^.Name
  else
  if FClassOfType <> nil then
    Result := FClassOfType.ClassName;
end;

procedure Ts0RTTITypeInfo.SetFClassOfType(const Value: TClass);
begin
  FClassOfType := Value;
  if FClassOfType <> nil then
  begin
    if FPublishedProps = nil then
      FPublishedProps := Ts0RTTIPublished.Create(Self);
    FPublishedProps.Source := FClassOfType;
    FPublishedProps.Refresh;
  end
  else
  begin
    FreeAndNil(FPublishedProps);
  end;
end;

procedure Ts0RTTITypeInfo.SetFTypeInfo(const Value: PTypeInfo);
var
  td: PTypeData;
begin
  FTypeInfo := Value;
  if FTypeInfo = nil then Exit;
  if FTypeInfo.Kind = tkClass then
  begin
    td := TypInfo.GetTypeData(FTypeInfo);
    ClassOfType := td^.ClassType;
  end
  else
  begin
    ClassOfType := nil;
  end;
end;

{ Ts0RTTITypeInfos }

function Ts0RTTITypeInfos.AddByClass(AClass: TClass): Ts0RTTITypeInfo;
begin
  Result := FindByClass(AClass);
  if Result <> nil then Exit;
  Result := Ts0RTTITypeInfo(inherited Add);
  Result.ClassOfType := AClass;
end;

function Ts0RTTITypeInfos.AddByTypeInfo(ATypeInfo: PTypeInfo): Ts0RTTITypeInfo;
begin
  Result := FindByTypeInfo(ATypeInfo);
  if Result <> nil then Exit;
  Result := Ts0RTTITypeInfo(inherited Add);
  Result.TypeInfo := ATypeInfo;
end;

function Ts0RTTITypeInfos.FindByClass(AClass: TClass): Ts0RTTITypeInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Types[i].ClassOfType = AClass then
    begin
      Result := Types[i];
      Exit;
    end;
end;

function Ts0RTTITypeInfos.FindByTypeInfo(
  ATypeInfo: PTypeInfo): Ts0RTTITypeInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Types[i].TypeInfo = ATypeInfo then
    begin
      Result := Types[i];
      Exit;
    end;
end;

function Ts0RTTITypeInfos.GetTypes(const Index: Integer): Ts0RTTITypeInfo;
begin
  Result := Ts0RTTITypeInfo(inherited Items[Index]);
end;

procedure Ts0RTTITypeInfos.SetTypes(const Index: Integer;
  const Value: Ts0RTTITypeInfo);
begin
  inherited Items[Index] := Value;
end;


{ Ts0RTTIPublishedBroker }

var
  g9RTTIBroker: Ts0RTTIPublishedBroker = nil;

constructor Ts0RTTIPublishedBroker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInfos := Ts0RTTITypeInfos.Create(Self, Ts0RTTITypeInfo);
end;

destructor Ts0RTTIPublishedBroker.Destroy;
begin
  if g9RTTIBroker = Self then
    g9RTTIBroker := nil;
  FreeAndNil(FInfos);
  inherited;            
end;

function Ts0RTTIPublishedBroker.FindTypeInfoByClass(AClass: TClass): Ts0RTTITypeInfo;
var
  i: Integer;
begin
  Result := nil;
  if AClass = nil then Exit;
  for i := 0 to FInfos.Count -1 do
  begin
    if Infos[i].ClassOfType = AClass then
    begin
      Result := Infos[i];
      Exit;
    end;
  end;
end;

function Ts0RTTIPublishedBroker.FindTypeInfo(
  ATypeName: string): Ts0RTTITypeInfo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FInfos.Count -1 do
  begin
    if Infos[i].TypeName = ATypeName then
    begin
      Result := Infos[i];
      Exit;
    end;
  end;
end;

function Ts0RTTIPublishedBroker.GetTypeInfoByClass(AClass: TClass): Ts0RTTITypeInfo;
begin
  Result := nil;
  if AClass = nil then Exit;
  Result := FindTypeInfoByClass(AClass);
  if Result <> nil then Exit;
  Result := Infos.AddByClass(AClass);
end;

function Ts0RTTIPublishedBroker.GetTypeInfo(ATypeInfo: PTypeInfo): Ts0RTTITypeInfo;
begin
  Result := FindTypeInfo(ATypeInfo^.Name);
  if Result <> nil then
  begin
    if Result.TypeInfo = nil then
      Result.TypeInfo := ATypeInfo;
    Exit;
  end;
  Result := Infos.AddByTypeInfo(ATypeInfo);
end;

class function Ts0RTTIPublishedBroker.Instance: Ts0RTTIPublishedBroker;
begin
  if g9RTTIBroker = nil then
    g9RTTIBroker := Ts0RTTIPublishedBroker.Create(nil);
  Result := g9RTTIBroker;
end;

procedure Ts0RTTIPublishedBroker.SetInfos(const Value: Ts0RTTITypeInfos);
begin
  FInfos.Assign(Value);
end;

type
  T9Writer = class(TWriter)
  end;

{ Ts0RTTIPublishedAccessor }

class function Ts0RTTIPublishedAccessor.CheckMethodIsNotEmpty(
  AMethodPointer: pointer): Boolean;
const
  c9AssemblerRet = $C3;
begin
  Result := byte(AMethodPointer^) <> c9AssemblerRet;
end;

procedure Ts0RTTIPublishedAccessor.ClearValueOf(APropName: string);
var
  p: Ts0RTTIProp;
begin
  if RTTINavigator.Props = nil then Exit;
  p := RTTINavigator.Props.PropByName(APropName);
  if p = nil then Exit;
  case p.TypeInfo.TypeKind of
    tkInteger    : OrdProp[p.PropName] := p.DefaultValue;
    tkChar       : OrdProp[p.PropName] := p.DefaultValue;
    tkEnumeration: OrdProp[p.PropName] := p.DefaultValue;
    tkFloat      : FloatProp[p.PropName] := 0;
    tkString     : StrProp[p.PropName] := '';
    tkSet        : OrdProp[p.PropName] := p.DefaultValue;
    tkWChar      : OrdProp[p.PropName] := 0;
    tkLString    : StrProp[p.PropName] := '';
    tkWString    : StrProp[p.PropName] := '';
    tkInt64      : OrdProp[p.PropName] := 0;
  end;
end;

procedure Ts0RTTIPublishedAccessor.ClearValues;
var
  i: Integer;
  props: Ts0RTTIProps;
begin
  props := RTTINavigator.Props;
  if props = nil then Exit;
  for i := 0 to props.Count -1 do
    ClearValueOf(props.Props[i].PropName);
end;

constructor Ts0RTTIPublishedAccessor.Create(AInstance: TObject);
begin
  inherited Create;
  FPreferStringsOnGetAsVariant := True;
  FBracketsOnGetSet := False;
  FMinClassOnGetObject := nil;
  FRTTINavigator :=
    Ts0RTTIPublishedBroker.Instance.GetTypeInfoByClass(AInstance.ClassType).PublishedProps;
  FInstance := AInstance;
end;

function Ts0RTTIPublishedAccessor.EnabledAsString(
  APropName: string): Boolean;
var
  k: TTypeKind;
begin
  k := PropTypeKind(APropName);

  Result :=
    (k in
      [ tkInteger    , tkChar       , tkEnumeration, tkFloat      ,
        tkString     , tkSet        , tkWChar      , tkLString    ,
        tkWString    , tkInt64 ]
    )
    or
    ( (k = tkClass) and
      ( CompareText(PropTypeName(APropName), 'TStrings') = 0) or
      ( CompareText(PropTypeName(APropName), 'TStringList') = 0)
    );
end;

procedure Ts0RTTIPublishedAccessor.ExecuteMethod(AMethodName: string);
var
  mthds: Ts0MethodEnumerator;
  runMethod: TMethod;
  execMethod: K0ExecMethodOfNoParam;
begin
  mthds := RTTINavigator.MethodEnumerator;
  if mthds = nil then Exit;
  if mthds.IndexOf(AMethodName) < 0 then Exit;
  if not Assigned(FInstance.MethodAddress(AMethodName)) then Exit;
  runMethod.Code := FInstance.MethodAddress(AMethodName);
  runMethod.Data := FInstance;
  if not CheckMethodIsNotEmpty(runMethod.Code) then Exit;
  execMethod := K0ExecMethodOfNoParam(runMethod);
  if not Assigned(execMethod) then Exit;
  execMethod;
end;

function Ts0RTTIPublishedAccessor.GetEnumProp(
  const PropName: string): string;
begin
  Result := TypInfo.GetEnumProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetFloatProp(
  const PropName: string): Extended;
begin
  Result := TypInfo.GetFloatProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetInt64Prop(
  const PropName: string): Int64;
begin
  Result := TypInfo.GetInt64Prop(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetMethodProp(
  const PropName: string): TMethod;
begin
  Result := TypInfo.GetMethodProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetObjectProp(const PropName: string): TObject;
begin
  Result := TypInfo.GetObjectProp(FInstance, PropName, FMinClassOnGetObject);
end;

function Ts0RTTIPublishedAccessor.GetObjectPropClass(
  const PropName: string): TClass;
begin
  Result := TypInfo.GetObjectPropClass(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetOrdProp(
  const PropName: string): Longint;
begin
  Result := TypInfo.GetOrdProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetPropAsString(const PropName: string): string;
  function CollectionToStr(ACollection: TCollection): string;
  var
    ms: TMemoryStream;
    ss: TStringStream;
    w: T9Writer;
    p: Ts0RTTIProp;
  begin
    Result := '';
    if not(FInstance is TComponent) then Exit;
    p := FRTTINavigator.Props.PropByName(PropName);
    ms := TMemoryStream.Create;
    try
      w := T9Writer.Create(ms, 4096);
      try
        w.WriteSignature;
        w.WritePrefix([], 0);
        w.WriteStr(''); //FInstance.ClassName);
        w.WriteStr(''); //TComponent(FInstance).Name);
        w.WriteProperty(TPersistent(FInstance), p.FPropInfo);
        w.WriteListEnd;
        w.WriteListEnd;
      finally
        FreeAndNil(w);
      end;
      ss := TStringStream.Create('');
      try
        ms.Seek(0, soFromBeginning);
        ObjectBinaryToText(ms, ss);
        Result := ss.DataString;
      finally
        FreeAndNil(ss);
      end;
    finally
      FreeAndNil(ms);
    end;
  end;

  function ObjToStr(AObj: TObject): String;
  begin
    if AObj is TComponent then
      Result := TComponent(AObj).Name
    else
    if AObj is TCollection then
      Result := CollectionToStr(TCollection(AObj))
    else
    if AObj is TStrings then
      Result := TStrings(AObj).CommaText
    else
    if AObj <> nil then
      Result := AObj.ClassName
    else
      Result := 'nil';
  end;

  function FloatToString(APropName: string; AValue: Extended): string;
  var
    typName: string;
  begin
    typName := PropTypeName(APropName);
    if CompareText(typName, 'TDateTime') = 0 then
      Result := Ts0TypeConv.DTToStr( AValue )
    else
    if CompareText(typName, 'TDate') = 0 then
      Result := DateTimeToStr( AValue )
    else
    if CompareText(typName, 'TTime') = 0 then
      Result := DateTimeToStr( AValue )
    else
      Result := FloatToStr( AValue );
  end;

begin
  Result := '';
  case PropTypeKind(PropName) of
    tkInteger    : Result := Ts0TypeConv.IntToStr( GetOrdProp(PropName) );
    tkChar       : Result := Char( GetOrdProp(PropName) );
    tkEnumeration: Result := GetEnumProp(PropName);
    tkFloat      : Result := FloatToString(PropName, GetFloatProp(PropName));
    tkString     : Result := GetStrProp( PropName );
    tkSet        : Result := GetSetProp( PropName );
    tkClass      : Result := ObjToStr(GetObjectProp(PropName));
    tkWChar      : Result := WideChar( GetOrdProp(PropName) );
    tkLString    : Result := GetStrProp( PropName );
    tkWString    : Result := GetStrProp( PropName );
    tkInt64      : Result := Ts0TypeConv.IntToStr( GetInt64Prop(PropName) );
  end;
end;

function Ts0RTTIPublishedAccessor.GetPropAsVariant(
  const PropName: string): Variant;
begin
  Result := typinfo.GetPropValue(FInstance, PropName, FPreferStringsOnGetAsVariant);
end;

function Ts0RTTIPublishedAccessor.GetSetProp(const PropName: string): string;
begin
  Result := TypInfo.GetSetProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetStrProp(
  const PropName: string): string;
begin
  Result := TypInfo.GetStrProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.GetVariantProp(
  const PropName: string): Variant;
begin
  Result := TypInfo.GetVariantProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.IsStoredProp(
  const PropName: string): Boolean;
begin
  Result := TypInfo.IsStoredProp(FInstance, PropName);
end;

function Ts0RTTIPublishedAccessor.PropertyExists(
  APropName: string): Boolean;
begin
  Result := False;
  if RTTINavigator = nil then Exit;
  Result := (RTTINavigator.Props.PropByName(APropName) <> nil);
end;

function Ts0RTTIPublishedAccessor.PropTypeInfo(
  APropName: string): Ts0RTTITypeInfo;
var
  prop: Ts0RTTIProp;
begin
  Result := nil;
  if RTTINavigator = nil then Exit;
  prop := RTTINavigator.Props.PropByName(APropName);
  if prop = nil then Exit;
  Result := prop.TypeInfo;
end;

function Ts0RTTIPublishedAccessor.PropTypeKind(
  APropName: string): TTypeKind;
var
  ti: Ts0RTTITypeInfo;
begin
  Result := tkUnknown;
  ti := PropTypeInfo(APropName);
  if ti = nil then Exit;
  Result := ti.TypeKind;
end;

function Ts0RTTIPublishedAccessor.PropTypeName(APropName: string): string;
var
  ti: Ts0RTTITypeInfo;
begin
  Result := '';
  ti := PropTypeInfo(APropName);
  if ti <> nil then
    Result := ti.TypeName;
end;

procedure Ts0RTTIPublishedAccessor.SetEnumProp(const PropName,
  Value: string);
begin
  TypInfo.SetEnumProp(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetFloatProp(const PropName: string;
  Value: Extended);
begin
  TypInfo.SetFloatProp(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetInstance(const Value: TObject);
begin
  FInstance := Value;
end;

procedure Ts0RTTIPublishedAccessor.SetInt64Prop(const PropName: string;
  const Value: Int64);
begin
  TypInfo.SetInt64Prop(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetMethodProp(const PropName: string;
  const Value: TMethod);
begin
  TypInfo.SetMethodProp(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetObjectProp(const PropName: string;
  Value: TObject);
begin
  TypInfo.SetObjectProp(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetOrdProp(const PropName: string;
  Value: Integer);
begin
  TypInfo.SetOrdProp(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetPreferStringsOnGetAsVariant(
  const Value: Boolean);
begin
  FPreferStringsOnGetAsVariant := Value;
end;

procedure Ts0RTTIPublishedAccessor.SetPropAsString(const PropName,
  Value: string);
  function StringToFloat(APropName: string; Value: string): Extended;
  var
    typName: string;
  begin
    typName := PropTypeName(APropName);
    try
      if CompareText(typName, 'TDateTime') = 0 then
        Result := Ts0TypeConv.StrToDT(Value)
      else
      if CompareText(typName, 'TDate') = 0 then
        Result := StrToDate(Value)
      else
      if CompareText(typName, 'TTime') = 0 then
        Result := StrToTime(Value)
      else
        Result := StrToFloat(Value);
    except
      on E: EConvertError do
        Result := 0;
    end;
  end;
  
  procedure SetObjPropValue(AObj: TObject; Value: string);
  begin
    if AObj is TStrings then
      TStrings(AObj).CommaText := Value;
  end;
var
	tk: TTypeKind;
  typeName: String;
begin
//  こういう手もあるけどね・・・・
//  TypInfo.SetPropValue(FInstance, PropName, Value);
//
	tk := PropTypeKind(PropName);
  case tk of
    tkInteger    :
    begin
    	typeName := PropTypeName(PropName);
      if typeName = 'TColor' then
				SetOrdProp(PropName  , StringToColor(Value))
      else
	    	SetOrdProp(PropName  , StrToIntDef(Value, 0));
    end;
    tkChar       :
    	if Value <> '' then
        SetOrdProp(PropName  , Ord( Value[1]) );
    tkEnumeration: SetEnumProp(PropName , Value);
    tkFloat      : SetFloatProp(PropName, StringToFloat(PropName, Value) );
    tkString     : SetStrProp(PropName  , Value);
    tkSet        : SetSetProp(PropName  , Value);
    tkClass      : SetObjPropValue( ObjectProp[PropName] , Value);
    tkWChar      :
      if Value <> '' then
        SetOrdProp(PropName  , Ord( Value[1]) );
    tkLString    : SetStrProp(PropName  , Value);
    tkWString    : SetStrProp(PropName  , Value);
    tkInt64      : SetInt64Prop(PropName, StrToInt64Def(Value, 0));
  else
    raise Exception.Create('型の種類"' + c0_TypeKind_Names[tk] +
    	'"はサポートされていません。');
  end;
end;

procedure Ts0RTTIPublishedAccessor.SetPropAsVariant(const PropName: string;
  const Value: Variant);
begin
  typinfo.SetPropValue(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetSetProp(const PropName,
  Value: string);
begin
  if Value = '' then
    TypInfo.SetSetProp(FInstance, PropName, '[]')
  else
    TypInfo.SetSetProp(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetStrProp(const PropName,
  Value: string);
begin
  TypInfo.SetStrProp(FInstance, PropName, Value);
end;

procedure Ts0RTTIPublishedAccessor.SetVariantProp(const PropName: string;
  const Value: Variant);
begin
  TypInfo.SetVariantProp(FInstance, PropName, Value);
end;

{ Ts0TypeKindHelper }

class function Ts0TypeKindHelper.GetWrappedTypeKind(ATypeName: string; 
  AKind: TTypeKind): K0WrappedTypeKind;
var
  cls: TClass;
begin
  Result := wtk0Unknown;
  case AKind of
    tkUnknown     : Result := wtk0Unknown;
    tkInteger     : Result := wtk0Integer;
    tkChar        : Result := wtk0Char;
    tkEnumeration :
    begin
      if SameText(ATypeName, 'Boolean') then
        Result := wtk0Boolean
      else
        Result := wtk0Enumeration;
    end;
    tkFloat       : Result := wtk0Float;
    tkString      : Result := wtk0String;
    tkSet         : Result := wtk0Set;
    tkClass       :
    begin
      Result := wtk0Class;
      cls := GetClass(ATypeName);
      if cls = nil then Exit;
      if cls.InheritsFrom(TPersistent) then Result := wtk0Persistent
      else if cls.InheritsFrom(TStrings) then Result := wtk0Strings
      else if cls.InheritsFrom(TCollection) then Result := wtk0Collection
      else if cls.InheritsFrom(TComponent) then Result := wtk0Component;
    end;
    tkMethod      : Result := wtk0Method;
    tkWChar       : Result := wtk0Char;
    tkLString     : Result := wtk0String;
    tkWString     : Result := wtk0String;
    tkVariant     : Result := wtk0Variant;
    tkArray       : Result := wtk0Array;
    tkRecord      : Result := wtk0Record;
    tkInterface   : Result := wtk0Interface;
    tkInt64       : Result := wtk0Int64;
    tkDynArray    : Result := wtk0DynArray;
  end;
end;

initialization

finalization
  FreeAndNil(g9RTTIBroker);
  
end.
