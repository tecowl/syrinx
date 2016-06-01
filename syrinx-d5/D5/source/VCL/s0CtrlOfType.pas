{-----------------------------------------------------------------------------
 Unit Name: s0CtrlOfType
 Author:    Akima
 Purpose:
 TestCase: tc_s0CtrlOfType
$History: s0CtrlOfType.pas $
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/03/10   Time: 2:07
 * Updated in $/D5/source/VCL
 * Ts0CtrlOfType.SetDefaultClassで余計なことしないように変更
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/21   Time: 23:27
 * Updated in $/source/D5Integrated
 * コントロールのObjectsに正しい値が設定されていなかった不具合の修正
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/13   Time: 21:11
 * Updated in $/source/D5Integrated
 * COTの各クラスを登録制できるようにした。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/01/10   Time: 3:18
 * Updated in $/source/D5Integrated
 * Ts0PropertyProtoTypeに依存しないで、コントロールの決定、初期化を行えるよ
 * うにした。
 *
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/01/06   Time: 0:22
 * Updated in $/source/D5Integrated
 * （めちゃ重要）Ts0CtrlOfType.Itemsをpublicに
 *
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/01/05   Time: 13:51
 * Updated in $/source/D5Integrated
 * CannAddItemで破棄時も追加削除ができるように修正
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/15   Time: 23:30
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/12/15   Time: 2:05
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/12/14   Time: 16:33
 * Updated in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0CtrlOfType;

interface

uses
  SysUtils, Classes,
  Controls,
  Contnrs,
  TypInfo,
  s0VCLClasses,
  s0Persistent,
  s0DataAccessor,
  s0PropertyProtoType,
  s0TypInfoWrapper,
  s0Collection;

type
  Ts0CtrlOfTypeItemClass = class of Ts0CtrlOfTypeItem;
  Ts0CtrlOfTypeItem = class(Ts0VCLCollectionItem)
  private
    FIsObject: Boolean;
    FCtrlClassName: string;
    FEnabled: Boolean;
    FTypeNames: TStrings;
    procedure SetIsObject(const Value: Boolean);
    procedure SetCtrlClassName(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    procedure SetTypeNames(const Value: TStrings);
    function GetTypeName: string;
    procedure SetTypeName(const Value: string);
    procedure ValidateCreation;
  protected
    procedure InitByAccessor(AProp: Ts0RTTIProp; AControl: TControl; AEnumMember: TStrings); virtual;
    procedure SetEnumMembers(AEnumNameSet: TStrings; Acsr: Ts0StringsAccessor;
      AItems: TStrings; AOrigin: LongInt = 0); virtual;
  public
    constructor Create(ACollection: TCollection); override;
    constructor CreateItem(ACollection: TCollection; ACtrlClassName: string;
      ATypeNames: array of string; AIsObject: Boolean = False); virtual;
    destructor Destroy; override;
    procedure InitCtrl(AProp: Ts0RTTIProp; AControl: TControl); virtual;
    procedure InitCtrlByProto(AProto: Ts0PropertyProtoType; AControl: TControl); virtual;
    function IsTarget(ATypeName: string): Boolean; virtual;
    function IsTargetCtrl(ACtrl: TControl): Boolean; virtual;
  published
    property CtrlClassName: string read FCtrlClassName write SetCtrlClassName;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property IsObject: Boolean read FIsObject write SetIsObject  default False;
    property TypeName: string read GetTypeName write SetTypeName;
    property TypeNames: TStrings read FTypeNames write SetTypeNames;
  end;

type
  Ts0CtrlOfTypeItems = class(Ts0VCLCollection)
  private
    function GetItems(const Index: Integer): Ts0CtrlOfTypeItem;
    procedure SetItems(const Index: Integer; const Value: Ts0CtrlOfTypeItem);
  public
    function FindByProto(ATypeName: string): Ts0CtrlOfTypeItem;
    function FindWithCtrl(ACtrl: TControl): Ts0CtrlOfTypeItem; 
    property Items[const Index: Integer]: Ts0CtrlOfTypeItem read GetItems write SetItems; default;
  end;

type
  Ts0CtrlOfTypeClass = class of Ts0CtrlOfType;
  Ts0CtrlOfType = class(Ts0VCLPersistent)
  private
    FItems: Ts0CtrlOfTypeItems;
    FCtrlClassNameOfSet: string;
    FCtrlClassNameOfEnum: string;
    FItemInitializing: Boolean;
    procedure SetItems(const Value: Ts0CtrlOfTypeItems);
    procedure SetCtrlClassNameOfEnum(const Value: string);
    procedure SetCtrlClassNameOfSet(const Value: string);
  protected
    FAllowAddItem: Boolean;
    procedure DoInitItems; virtual;
    function NewItems: Ts0CtrlOfTypeItems; virtual;
    function DataTypeKindToCtrlClassName(ADataTypeKind: K0WrappedTypeKind): string; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    function CanAddItem: Boolean;
    function GetCtrlClassName(ATypeName: string; ADataTypeKind: K0WrappedTypeKind): string; virtual;
    function GetCtrlClassNameByProto(AProto: Ts0PropertyProtoType): string; virtual;
    procedure InitCtrl(AProp: Ts0RTTIProp; AControl: TControl);
    procedure InitCtrlByProto(AProto: Ts0PropertyProtoType; AControl: TControl);
    procedure InitItems;
    property AllowAddItem: Boolean read FAllowAddItem write FAllowAddItem;
    property Items: Ts0CtrlOfTypeItems read FItems write SetItems;
    class function GetDefaultClass: Ts0CtrlOfTypeClass;
    class procedure SetDefaultClass(AClass: Ts0CtrlOfTypeClass);
    class procedure RegisterCOT(ACOT: Ts0CtrlOfTypeClass);
    class procedure UnRegisterCOT(ACOT: Ts0CtrlOfTypeClass);
    class procedure GetRegisteredCOTs(Dest: TClassList);
  published
    property CtrlClassNameOfEnum: string read FCtrlClassNameOfEnum write SetCtrlClassNameOfEnum;
    property CtrlClassNameOfSet: string read FCtrlClassNameOfSet write SetCtrlClassNameOfSet;
  end;

type
  Es0CtrlOfTypeItemException = class(Exception);

implementation

uses
  s0ObjectHelper,
  s0CtrlDistiller;

{ Ts0CtrlOfTypeItem }

resourcestring
  c9ErrMsg_CannotCreateItem = '項目を追加することは出来ません。';

constructor Ts0CtrlOfTypeItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  ValidateCreation;
  FIsObject := False;
  FEnabled := True;
  FTypeNames := TStringList.Create;
end;

constructor Ts0CtrlOfTypeItem.CreateItem(ACollection: TCollection;
  ACtrlClassName: string; ATypeNames: array of string; AIsObject: Boolean);
var
  i: Integer;
begin
  Create(ACollection);
  FIsObject := AIsObject;
  FCtrlClassName := ACtrlClassName;
  for i := Low(ATypeNames) to High(ATypeNames) do
    FTypeNames.Add(ATypeNames[i]);
end;

destructor Ts0CtrlOfTypeItem.Destroy;
begin
  ValidateCreation;
  FreeAndNil(FTypeNames);
  inherited;
end;

function Ts0CtrlOfTypeItem.GetTypeName: string;
begin
  Result := '';
  if FTypeNames.Count > 0 then
    Result := FTypeNames.Strings[0];
end;

procedure Ts0CtrlOfTypeItem.InitByAccessor(AProp: Ts0RTTIProp; AControl: TControl; AEnumMember: TStrings);
var
  sl: TStringList;
  acsr: Ts0DataAccessor;
  typKind: TTypeKind;
begin
  if AProp = nil then Exit;
  typKind := AProp.TypeInfo.TypeKind;
  sl := TStringList.Create;
  try
    sl.CommaText := AProp.TypeInfo.GetNameList;
    case typKind of
      tkEnumeration, tkSet:
        begin
          acsr := Ts0CtrlDistillBroker.GetAccessor(AControl);
          if acsr is Ts0StringsAccessor then
          begin
            SetEnumMembers(AEnumMember, Ts0StringsAccessor(acsr), sl,
              AProp.TypeInfo.TypeData.MinValue);
            if Ts0StringsAccessor(acsr).Source.Count > 0 then
              Ts0StringsAccessor(acsr).ItemIndex := 0;
          end;
        end;
    end;
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0CtrlOfTypeItem.InitCtrl(AProp: Ts0RTTIProp; AControl: TControl);
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create;
  try
    sl.CommaText := AProp.TypeInfo.GetNameList;
    for i := 0 to sl.Count -1 do
      sl.Objects[i] := TObject( AProp.TypeInfo.GetEnumValue(sl.Strings[i]) );
    InitByAccessor(AProp, AControl, sl);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0CtrlOfTypeItem.InitCtrlByProto(AProto: Ts0PropertyProtoType;
  AControl: TControl);
var
  acsr: Ts0DataAccessor;
begin
  InitByAccessor(AProto.RTTIProp, AControl, AProto.EnumMember);
  acsr := Ts0CtrlDistillBroker.GetAccessor(AControl);
  if acsr is Ts0StringsAccessor then
  begin
    Ts0StringsAccessor(acsr).AsIntegerKind := k0saikFromObjects;
    Ts0StringsAccessor(acsr).EnumName := AProto.EnumName;
  end;
end;

function Ts0CtrlOfTypeItem.IsTarget(ATypeName: string): Boolean;
begin
  Result := (FTypeNames.IndexOf(ATypeName) > -1);
end;

function Ts0CtrlOfTypeItem.IsTargetCtrl(ACtrl: TControl): Boolean;
begin
  Result := SameText(FCtrlClassName, ACtrl.ClassName);
end;

procedure Ts0CtrlOfTypeItem.SetCtrlClassName(const Value: string);
begin
  FCtrlClassName := Value;
end;

procedure Ts0CtrlOfTypeItem.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure Ts0CtrlOfTypeItem.SetEnumMembers(AEnumNameSet: TStrings;
  Acsr: Ts0StringsAccessor; AItems: TStrings; AOrigin: Integer);
var
  i: Integer;
  s: string;
begin
  Acsr.AsIntegerKind := k0saikFromObjects;
  Acsr.Source.Clear;
  for i := 0 to AItems.Count -1 do
  begin
    s := AEnumNameSet.Values[ AItems.Strings[i] ];
    if s = '' then
      s := AItems.Strings[i];
    Acsr.Source.AddObject( s, TObject(i + AOrigin) );
  end;
  if Acsr.Source.Count < 1 then Exit;
  Acsr.ItemIndex := 0;
end;

procedure Ts0CtrlOfTypeItem.SetIsObject(const Value: Boolean);
begin
  FIsObject := Value;
  Changed(False);
end;

procedure Ts0CtrlOfTypeItem.SetTypeName(const Value: string);
begin
  if FTypeNames.Count > 0 then
    FTypeNames.Strings[0] := Value
  else
    FTypeNames.Add(Value);
end;

procedure Ts0CtrlOfTypeItem.SetTypeNames(const Value: TStrings);
begin
  FTypeNames.Assign(Value);
end;

procedure Ts0CtrlOfTypeItem.ValidateCreation;
begin
  if OwnerObj is Ts0CtrlOfType then
    if not Ts0CtrlOfType(OwnerObj).CanAddItem then
      raise Es0CtrlOfTypeItemException.Create(c9ErrMsg_CannotCreateItem);
end;

{ Ts0CtrlOfTypeItems }

function Ts0CtrlOfTypeItems.FindByProto(ATypeName: string): Ts0CtrlOfTypeItem;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if not Result.Enabled then Continue;
    if Result.IsTarget(ATypeName) then Exit;
  end;
  Result := nil;
end;

function Ts0CtrlOfTypeItems.FindWithCtrl(ACtrl: TControl): Ts0CtrlOfTypeItem;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if not Result.Enabled then Continue;
    if Result.IsTargetCtrl(ACtrl) then Exit;
  end;
  Result := nil;
end;

function Ts0CtrlOfTypeItems.GetItems(const Index: Integer): Ts0CtrlOfTypeItem;
begin
  Result := Ts0CtrlOfTypeItem(inherited Items[Index]);
end;

procedure Ts0CtrlOfTypeItems.SetItems(const Index: Integer;
  const Value: Ts0CtrlOfTypeItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CtrlOfType }

function Ts0CtrlOfType.CanAddItem: Boolean;
begin
  Result := True;
  if OwnerComponent = nil then Exit;
  if not(csDesigning in OwnerComponent.ComponentState) then Exit;
  if [csReading, csLoading, csDestroying, csFreeNotification] * OwnerComponent.ComponentState <> [] then Exit;
  Result := FAllowAddItem or FItemInitializing;
end;

constructor Ts0CtrlOfType.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FAllowAddItem := True;
  FItems := NewItems;
  InitItems;
end;

function Ts0CtrlOfType.DataTypeKindToCtrlClassName(
  ADataTypeKind: K0WrappedTypeKind): string;
begin
  Result := '';
  case ADataTypeKind of
    wtk0Enumeration: Result := FCtrlClassNameOfEnum;
    wtk0Set        : Result := FCtrlClassNameOfSet;
  end;
end;

destructor Ts0CtrlOfType.Destroy;
begin
  FAllowAddItem := True;
  FreeAndNil(FItems);
  inherited;
end;

procedure Ts0CtrlOfType.DoInitItems;
begin
end;

function Ts0CtrlOfType.GetCtrlClassName(ATypeName: string; ADataTypeKind: K0WrappedTypeKind): string;
var
  cotItem: Ts0CtrlOfTypeItem;
begin
  Result := '';
  cotItem := Items.FindByProto(ATypeName);
  if cotItem <> nil then
    Result := cotItem.CtrlClassName
  else
  if Ts0ObjectHelper.ClassInherites(TStrings, ATypeName) then
    Result := GetCtrlClassName(TStrings.ClassName, wtk0Class)
  else
    Result := DataTypeKindToCtrlClassName(ADataTypeKind);
end;

function Ts0CtrlOfType.GetCtrlClassNameByProto(
  AProto: Ts0PropertyProtoType): string;
begin
  Result := GetCtrlClassName(AProto.TypeName, AProto.DataTypeKind);
end;

var
  g9DefaultClass: Ts0CtrlOfTypeClass = Ts0CtrlOfType;

class function Ts0CtrlOfType.GetDefaultClass: Ts0CtrlOfTypeClass;
begin
  Result := g9DefaultClass;
end;

var
  g9RegisteredCOTs: TClassList = nil;

class procedure Ts0CtrlOfType.GetRegisteredCOTs(Dest: TClassList);
var
  i: Integer;
begin
  if g9RegisteredCOTs = nil then Exit;
  for i := 0 to g9RegisteredCOTs.Count -1 do
    Dest.Add( g9RegisteredCOTs.Items[i] );
end;

procedure Ts0CtrlOfType.InitCtrl(AProp: Ts0RTTIProp; AControl: TControl);
var
  cotItem: Ts0CtrlOfTypeItem;
begin
  cotItem := Items.FindWithCtrl(AControl);
  if cotItem = nil then Exit;
  cotItem.InitCtrl(AProp, AControl);
end;

procedure Ts0CtrlOfType.InitCtrlByProto(AProto: Ts0PropertyProtoType;
  AControl: TControl);
var
  cotItem: Ts0CtrlOfTypeItem;
begin
  cotItem := Items.FindWithCtrl(AControl);
  if cotItem = nil then Exit;
  cotItem.InitCtrlByProto(AProto, AControl);
end;

procedure Ts0CtrlOfType.InitItems;
begin
  FItemInitializing := True;
  try
    DoInitItems;
  finally
    FItemInitializing := False;
  end;
end;

function Ts0CtrlOfType.NewItems: Ts0CtrlOfTypeItems;
begin
  Result := Ts0CtrlOfTypeItems.Create(Self, Ts0CtrlOfTypeItem);
end;

class procedure Ts0CtrlOfType.RegisterCOT(ACOT: Ts0CtrlOfTypeClass);
begin
  if g9RegisteredCOTs = nil then
    g9RegisteredCOTs := TClassList.Create;
  if g9RegisteredCOTs.IndexOf(ACOT) > -1 then Exit;
  g9RegisteredCOTs.Add(ACOT);
  RegisterClass(ACOT);
end;

procedure Ts0CtrlOfType.SetCtrlClassNameOfEnum(const Value: string);
begin
  FCtrlClassNameOfEnum := Value;
end;

procedure Ts0CtrlOfType.SetCtrlClassNameOfSet(const Value: string);
begin
  FCtrlClassNameOfSet := Value;
end;

class procedure Ts0CtrlOfType.SetDefaultClass(AClass: Ts0CtrlOfTypeClass);
begin
  g9DefaultClass := AClass;
end;

procedure Ts0CtrlOfType.SetItems(const Value: Ts0CtrlOfTypeItems);
begin
  FItems.Assign(Value);
end;

class procedure Ts0CtrlOfType.UnRegisterCOT(ACOT: Ts0CtrlOfTypeClass);
begin
  if g9RegisteredCOTs = nil then Exit;
  while g9RegisteredCOTs.Remove(ACOT) > -1 do ;
end;

initialization

finalization
  FreeAndNil(g9RegisteredCOTs);

end.
