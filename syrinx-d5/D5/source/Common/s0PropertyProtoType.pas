unit s0PropertyProtoType;
{
$History: s0PropertyProtoType.pas $
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/03/13   Time: 3:07
 * Updated in $/D5/source/Common
 * 古いバージョンに対応できるように、ImeModeを読み込めるようにした。
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
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
 * User: Akima        Date: 02/02/13   Time: 21:08
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCaseを使用して文字列の比較を行っていた部分をSameTextを使用するよう
 * に修正
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/01/10   Time: 3:19
 * Updated in $/source/D5Integrated
 * FIsPersistent、FIsEnum、FIsSetを削除。
 * IsPersistent、IsEnum、IsSetはFDataTypeKindから設定、取得することにした
 * 。
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/12/15   Time: 2:05
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/12/13   Time: 16:37
 * Updated in $/source/D5Integrated
 * 要らないメソッドを削除
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/12/10   Time: 16:14
 * Updated in $/source/D5Integrated
 * EnumNameプロパティを追加。
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/11/28   Time: 2:01
 * Updated in $/source/D5Integrated
 * プロトタイプ間に、オリジナルとそのコピー(?)という関係を作った。
 * オリジナルが変更されると、それをOriginalとして参照しているプロトタイプ
 * に
 * 変更通知が届く。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/11/23   Time: 1:55
 * Updated in $/source/D5Integrated
 * SetPropertyNameメソッドをprotectedに
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/11/02   Time: 14:20
 * Updated in $/source/D5Integrated
 * GetDefaultCtrlを静的メソッドに変更。代わりにInitCtrlClassNameをvirtual
 * に。
 * AcceptCharTypesのデフォルト値を設定。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/11   Time: 17:26
 * Updated in $/source/D5Integrated
 * GetNamePathを変更。
 * 以前のままだと、このクラスのインスタンスのイベントにハンドラを関連付け
 * ようとすると、
 * 「名前が設定されていないコンポーネントにはデフォルトメソッドは関連付け
 * られません。」
 * というようなエラーが表示されてしまっていたっす。なぞ
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/11   Time: 1:21
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/09   Time: 9:07
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/05   Time: 14:18
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/05   Time: 13:04
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/04   Time: 12:22
 * Updated in $/source/D5Integrated
 * GetDisplayNameメソッドを実装。
 * Assignメソッドの不備を修正
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/03   Time: 23:42
 * Updated in $/source/D5Integrated
 * AcceptCharTypes、ImeMode、WithoutCtrlプロパティを追加
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/01   Time: 17:38
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/01   Time: 9:15
 * Updated in $/source/D5Integrated
 * IsPersistent、IsEnum、IsSet、Enummemberプロパティをs0EntityPropProtoか
 * ら移動
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/21   Time: 17:00
 * Updated in $/source/D5Integrated
 * Entityに関わりそうな部分をTs0EntityPropProtoに移した。
 * これでこのユニットはEntityとかかわりが無いようになった。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/19   Time: 20:46
 * Updated in $/source/D5Integrated
 * GetIdentifierメソッドをoverrideした
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/14   Time: 9:01
 * Created in $/source/D5Integrated
 * 新規追加
 * （EntityBuilder.dprで使用していた8レベルユニットだが0レベルに移行）
}

interface

uses
  SysUtils, Classes,  
{$IFDEF PLEIADES}
  Controls, //削除予定
{$ENDIF}
  s0CommonTypes,
  s0Collection,
  s0StringValidater,
  s0TypInfoWrapper;



type
  Ts0PropertyProtoType = class(Ts0InterfacedCollectionItem)
  private
    FPropertyName: string;
    FJPName: string;
    FTypeName: string;
    FSize: Integer;
    FEnumMember: TStrings;
{$IFDEF PLEIADES}
  //Controlユニットと共に削除予定
    FImeMode: TImeMode;
{$ENDIF}
    FWithoutCtrl: Boolean;
    FAcceptCharTypes: K1InpCharSet;
    FEnumName: string;
    FDataTypeKind: K0WrappedTypeKind;
    FImeModeSX: K0ImeMode;
    function GetOriginalItem: Ts0PropertyProtoType;
    procedure SetDataTypeKind(const Value: K0WrappedTypeKind);
    function GetIsEnum: Boolean;
    function GetIsPersistent: Boolean;
    function GetIsSet: Boolean;
  protected
    procedure SetEnumMember(const Value: TStrings); virtual;
    function GetEnumMember: TStrings; virtual;
    procedure SetIsEnum(const Value: Boolean); virtual;
    procedure SetIsPersistent(const Value: Boolean); virtual;
    procedure SetIsSet(const Value: Boolean); virtual;
    procedure SetJPName(const Value: string); virtual;
    procedure SetSize(const Value: Integer); virtual;
    procedure SetWithoutCtrl(const Value: Boolean); virtual;
    procedure SetEnumName(const Value: string); virtual;
  protected
    function GetIdentifier: string; override;
    function GetDisplayName: string; override;
  protected
    function GetRTTIPRop: Ts0RTTIProp; virtual;
    function GetWapper: Ts0RTTIPublishedAccessor; virtual;
    procedure SetAcceptCharTypes(const Value: K1InpCharSet); virtual;
{$IFDEF PLEIADES}
    //Controlユニットと共に削除予定
    procedure SetImeMode(const Value: TImeMode); virtual;
{$ENDIF}
    procedure SetImeModeSX(const Value: K0ImeMode); virtual;
    procedure SetPropertyName(const Value: string); virtual;
    procedure SetTypeName(const Value: string); virtual;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property OriginalItem: Ts0PropertyProtoType read GetOriginalItem;
    property RTTIProp: Ts0RTTIProp read GetRTTIProp;
    property DataTypeKind: K0WrappedTypeKind read FDataTypeKind write SetDataTypeKind;
  published
    property PropertyName: string read FPropertyName write SetPropertyName;
    property TypeName: string read FTypeName write SetTypeName;
    property JPName: string read FJPName write SetJPName;
    property Size: Integer read FSize write SetSize;
    property AcceptCharTypes: K1InpCharSet read FAcceptCharTypes write SetAcceptCharTypes
      default [k1ctAlpha,k1ctDigit, k1ctSign ,{$IFNDEF NOIMEPROP} k1ctKana ,k1ctKanji {$ENDIF}];
    property WithoutCtrl: Boolean read FWithoutCtrl write SetWithoutCtrl default False;

    property ImeModeSX: K0ImeMode read FImeModeSX write SetImeModeSX default k0imDontCare;
{$IFDEF PLEIADES}
    //Controlユニットと共に削除予定
    property ImeMode: TImeMode read FImeMode write SetImeMode default imDontCare;
{$ENDIF}
    property IsEnum: Boolean read GetIsEnum write SetIsEnum default False;
    property IsSet: Boolean read GetIsSet write SetIsSet default False;
    property IsPersistent: Boolean read GetIsPersistent write SetIsPersistent default False;
    property EnumMember: TStrings read GetEnumMember write SetEnumMember;
    property EnumName: string read FEnumName write SetEnumName;
  end;

type
  Ts0PropertyProtoTypes = class(Ts0InterfacedCollection)
  private
    function GetItems(const Index: Integer): Ts0PropertyProtoType;
    procedure SetItems(const Index: Integer; const Value: Ts0PropertyProtoType);
  protected
    function GetOriginal: Ts0PropertyProtoTypes; virtual;
    procedure NotifyOriginalUpdate(AItem: Ts0PropertyProtoType); virtual;
    procedure Update(Item: TCollectionItem); override;
    procedure SetOriginal(const Value: Ts0PropertyProtoTypes); virtual;
    class function GetRegisteredCount: Integer;
    class function GetRegistered(const Index: Integer): Ts0PropertyProtoTypes;
    class procedure RegisterToGlobalList(AProtoTypes: Ts0PropertyProtoTypes);
    class procedure UnRegisterToGlobalList(AProtoTypes: Ts0PropertyProtoTypes);
  public
    constructor Create(AOwner: TPersistent; AItemClass: Ts0CollectionItemClass); override;
    destructor Destroy; override;
    function AddProto(APropName, AType, AJPName: string; ASize: Integer): Ts0PropertyProtoType;
    function FindByName(APropName: string): Ts0PropertyProtoType;
    property Items[const Index: Integer]: Ts0PropertyProtoType read GetItems write SetItems;
    property Original: Ts0PropertyProtoTypes read GetOriginal write SetOriginal;
  end;

implementation

uses
  Contnrs;

{ Ts0PropertyProtoType }

procedure Ts0PropertyProtoType.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0PropertyProtoType) then Exit;
  Self.PropertyName    := Ts0PropertyProtoType(Source).FPropertyName   ;
  Self.TypeName        := Ts0PropertyProtoType(Source).FTypeName       ;
  Self.JPName          := Ts0PropertyProtoType(Source).FJPName         ;
  Self.WithoutCtrl     := Ts0PropertyProtoType(Source).FWithoutCtrl    ;

//Controlユニットと共に削除予定
//  Self.ImeMode         := Ts0PropertyProtoType(Source).FImeMode        ;
  Self.ImeModeSX        := Ts0PropertyProtoType(Source).FImeModeSX       ;
{
  Self.IsEnum          := Ts0PropertyProtoType(Source).IsEnum          ;
  Self.IsSet           := Ts0PropertyProtoType(Source).IsSet           ;
  Self.IsPersistent    := Ts0PropertyProtoType(Source).IsPersistent    ;
}
  Self.EnumName        := Ts0PropertyProtoType(Source).FEnumName       ;
  Self.EnumMember      := Ts0PropertyProtoType(Source).FEnumMember     ;
  Self.Size            := Ts0PropertyProtoType(Source).FSize           ;
  Self.AcceptCharTypes := Ts0PropertyProtoType(Source).FAcceptCharTypes;
  Self.DataTypeKind    := Ts0PropertyProtoType(Source).FDataTypeKind   ;
end;

constructor Ts0PropertyProtoType.Create(ACollection: TCollection);
begin
  inherited;
  FAcceptCharTypes := [k1ctAlpha,k1ctDigit, k1ctSign ,{$IFNDEF NOIMEPROP} k1ctKana ,k1ctKanji {$ENDIF}];
  FDataTypeKind := wtk0Unknown;
//Controlユニットと共に削除予定
  FImeModeSX := k0imDontCare;
  FWithoutCtrl := False;
end;

destructor Ts0PropertyProtoType.Destroy;
begin
  FreeAndNil(FEnumMember);
  inherited;
end;

function Ts0PropertyProtoType.GetDisplayName: string;
begin
  Result := PropertyName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function Ts0PropertyProtoType.GetEnumMember: TStrings;
begin
  if FEnumMember = nil then
    FEnumMember := TStringList.Create;
  Result := FEnumMember;
end;

function Ts0PropertyProtoType.GetIdentifier: string;
begin
  Result := FPropertyName;
end;

procedure Ts0PropertyProtoType.SetEnumMember(const Value: TStrings);
begin
  if Value = nil then
    FreeAndNil(FEnumMember)
  else
    EnumMember.Assign(Value);
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetIsEnum(const Value: Boolean);
begin
  if Value then
    FDataTypeKind := wtk0Enumeration
  else
    FDataTypeKind := wtk0Unknown;
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetIsPersistent(const Value: Boolean);
begin
  if Value then
  begin
    FDataTypeKind := wtk0Persistent;
    if FSize <> 0 then
      FSize := 0;
  end
  else
    FDataTypeKind := wtk0Unknown;
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetIsSet(const Value: Boolean);
begin
  if Value then
    FDataTypeKind := wtk0Set
  else
    FDataTypeKind := wtk0Unknown;
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetPropertyName(const Value: string);
begin
  FPropertyName := Trim(Value);
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetTypeName(const Value: string);
begin
  FTypeName := Value;
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetAcceptCharTypes(
  const Value: K1InpCharSet);
begin
  FAcceptCharTypes := Value;
  Changed(False);
end;

{$IFDEF PLEIADES}
//Controlユニットと共に削除予定
procedure Ts0PropertyProtoType.SetImeMode(const Value: TImeMode);
const
  c9IMEModes: array[TImeMode] of K0ImeMode = (
    k0imDisable, k0imClose, k0imOpen, k0imDontCare,
    k0imSAlpha, k0imAlpha, k0imHira, k0imSKata, k0imKata,
    k0imChinese, k0imSHanguel, k0imHanguel
  );
begin
  FImeMode := Value;
  ImeModeSX := c9IMEModes[FImeMode];
  //Changed(False);
end;
{$ENDIF}

procedure Ts0PropertyProtoType.SetJPName(const Value: string);
begin
  FJPName := Value;
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetSize(const Value: Integer);
begin
  FSize := Value;
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetWithoutCtrl(const Value: Boolean);
begin
  FWithoutCtrl := Value;
  Changed(False);
end;

procedure Ts0PropertyProtoType.SetEnumName(const Value: string);
begin
  FEnumName := Value;
  Changed(False);
end;

function Ts0PropertyProtoType.GetOriginalItem: Ts0PropertyProtoType;
var
  orig: Ts0PropertyProtoTypes;
begin
  Result := nil;
  if not(Collection is Ts0PropertyProtoTypes) then Exit;
  orig := Ts0PropertyProtoTypes(Collection).Original;
  if orig = nil then Exit;
  Result := orig.FindByName(Self.PropertyName);
end;

function Ts0PropertyProtoType.GetRTTIPRop: Ts0RTTIProp;
var
  w: Ts0RTTIPublishedAccessor;
begin
  Result := nil;
  w := GetWapper;
  if w = nil then Exit;
  Result := w.RTTINavigator.Props.PropByName( Self.PropertyName );
end;

function Ts0PropertyProtoType.GetWapper: Ts0RTTIPublishedAccessor;
begin
  Result := nil;
end;

procedure Ts0PropertyProtoType.SetDataTypeKind(
  const Value: K0WrappedTypeKind);
begin
  FDataTypeKind := Value;
  case FDataTypeKind of
    wtk0Enumeration: IsEnum := True;
    wtk0Set        : IsSet  := True;
    wtk0Persistent : IsPersistent := True;
  end;
end;

function Ts0PropertyProtoType.GetIsEnum: Boolean;
begin
  Result := (FDataTypeKind = wtk0Enumeration);
end;

function Ts0PropertyProtoType.GetIsPersistent: Boolean;
begin
  Result := (FDataTypeKind = wtk0Persistent);
end;

function Ts0PropertyProtoType.GetIsSet: Boolean;
begin
  Result := (FDataTypeKind = wtk0Set);
end;

procedure Ts0PropertyProtoType.SetImeModeSX(const Value: K0ImeMode);
begin
  FImeModeSX := Value;
  Changed(False);
end;

{ Ts0PropertyProtoTypes }

function Ts0PropertyProtoTypes.AddProto(APropName, AType,
  AJPName: string; ASize: Integer): Ts0PropertyProtoType;
begin
  Result := Ts0PropertyProtoType(inherited Add);
  Result.PropertyName := APropName;
  Result.TypeName := AType;
  Result.JPName := AJPName;
  Result.Size := ASize;
end;

constructor Ts0PropertyProtoTypes.Create(AOwner: TPersistent;
  AItemClass: Ts0CollectionItemClass);
begin
  inherited Create(AOwner, AItemClass);
  RegisterToGlobalList(Self);
end;

destructor Ts0PropertyProtoTypes.Destroy;
begin
  UnRegisterToGlobalList(Self);
  inherited Destroy;
end;

function Ts0PropertyProtoTypes.FindByName(
  APropName: string): Ts0PropertyProtoType;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if SameText(Items[i].PropertyName, APropName) then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0PropertyProtoTypes.GetItems(
  const Index: Integer): Ts0PropertyProtoType;
begin
  Result := Ts0PropertyProtoType(inherited Items[Index]);
end;

function Ts0PropertyProtoTypes.GetOriginal: Ts0PropertyProtoTypes;
begin
  Result := nil;
end;

var
  g9InstanceList: TObjectList = nil;

class function Ts0PropertyProtoTypes.GetRegistered(
  const Index: Integer): Ts0PropertyProtoTypes;
begin
  Result := nil;
  if g9InstanceList = nil then Exit;
  Result := Ts0PropertyProtoTypes(g9InstanceList.Items[Index]);
end;

class function Ts0PropertyProtoTypes.GetRegisteredCount: Integer;
begin
  Result := 0;
  if g9InstanceList = nil then Exit;
  Result := g9InstanceList.Count;
end;

procedure Ts0PropertyProtoTypes.NotifyOriginalUpdate(AItem: Ts0PropertyProtoType);
  function UpdateAItem(AOrigItem: Ts0PropertyProtoType): Ts0PropertyProtoType;
  begin
    Result := FindByName(AOrigItem.PropertyName);
    if Result = nil then
      Result :=
        Self.AddProto(
          AOrigItem.PropertyName, AOrigItem.TypeName,
          AOrigItem.JPName, AOrigItem.Size
        );
    Result.Assign(AOrigItem);
    Result.Index := AOrigItem.Index;
  end; 
var
  myItem: Ts0PropertyProtoType;
  i: Integer;
  delList: Ts0CollectionItemList;
begin
  if AItem <> nil then
  begin
    UpdateAItem(AItem);
  end
  else
  begin
    Self.BeginUpdate;
    try
      delList := Ts0CollectionItemList.Create(True);
      try
        for i := 0 to Self.Count -1 do
          delList.Add(Items[i]);
        for i := 0 to Original.Count -1 do
        begin
          myItem := UpdateAItem(Original.Items[i]);
          delList.Remove(myItem);
        end;
      finally
        FreeAndNil(delList);
      end;
    finally
      Self.EndUpdate;
    end;
  end;
end;

class procedure Ts0PropertyProtoTypes.RegisterToGlobalList(
  AProtoTypes: Ts0PropertyProtoTypes);
begin
  if g9InstanceList = nil then
    g9InstanceList := TObjectList.Create(False);
  if g9InstanceList.IndexOf(AProtoTypes) > -1 then Exit;
  g9InstanceList.Add(AProtoTypes);
end;

procedure Ts0PropertyProtoTypes.SetItems(const Index: Integer;
  const Value: Ts0PropertyProtoType);
begin
  inherited Items[Index] := Value;
end;

procedure Ts0PropertyProtoTypes.SetOriginal(
  const Value: Ts0PropertyProtoTypes);
begin

end;

class procedure Ts0PropertyProtoTypes.UnRegisterToGlobalList(
  AProtoTypes: Ts0PropertyProtoTypes);
begin
  if g9InstanceList = nil then Exit;
  while g9InstanceList.Remove(AProtoTypes) > -1 do ;
end;

procedure Ts0PropertyProtoTypes.Update(Item: TCollectionItem);
var
  i, cnt: Integer;
  obj: Ts0PropertyProtoTypes;
begin
  inherited Update(Item);
  if OwnerComponent = nil then Exit;
  if [csLoading, csReading] * OwnerComponent.ComponentState <> [] then Exit;
  cnt := GetRegisteredCount;
  for i := 0 to cnt -1 do
  begin
    obj := GetRegistered(i);
    if obj = nil then Continue;
    if obj.Original <> Self then Continue;
    if Item is Ts0PropertyProtoType then
      obj.NotifyOriginalUpdate( Ts0PropertyProtoType(Item) )
    else
      obj.NotifyOriginalUpdate( nil );
  end;
end;

end.
