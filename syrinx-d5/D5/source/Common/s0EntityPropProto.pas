unit s0EntityPropProto;
{
$History: s0EntityPropProto.pas $
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/02/13   Time: 21:08
 * Updated in $/source/D5Integrated
 * FieldTypeToPropTypeStrメソッドを追加
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCaseを使用して文字列の比較を行っていた部分をSameTextを使用するよう
 * に修正
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/02/06   Time: 21:25
 * Updated in $/source/D6VCLIntegrated
 * s0Entityユニットをuses節から削除した
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/02/06   Time: 1:08
 * Updated in $/source/D5Integrated
 * FieldName、FieldTypeプロパティの値が変更されたときに、PropertyName、Typ
 * eNameプロパティにそれを伝達するように変更
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/12/13   Time: 16:39
 * Updated in $/source/D5Integrated
 * 余計なメソッドを削除
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/12/08   Time: 2:05
 * Updated in $/source/D5Integrated
 * IsEnumValueを削除
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/06   Time: 20:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/02   Time: 14:19
 * Updated in $/source/D5Integrated
 * NaviClassIDプロパティを削除。
 * GetDefaultCtrlを静的メソッドしてInitCtrlClassNameをoverrideするようにし
 * た。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/21   Time: 14:16
 * Updated in $/source/D5Integrated
 * IDProp,CaptionPropが破棄されたときに、参照をnilクリアするように修正
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/05   Time: 13:04
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/04   Time: 12:23
 * Updated in $/source/D5Integrated
 * AssignでFFieldSizeをコピーする。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/03   Time: 23:43
 * Updated in $/source/D5Integrated
 * FieldSizeプロパティ、IsNavigator、NaviClassIDプロパティを追加。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/01   Time: 9:15
 * Updated in $/source/D5Integrated
 * IsPersistent、IsEnum、IsSet、Enummemberプロパティをs0PropertyProtoType
 * に移動
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/28   Time: 15:57
 * Updated in $/source/D5Integrated
 * IsReadOnlyを削除。
 * IsRequired:、IsEnum、IsSet、EnumMemberプロパティを追加
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/21   Time: 16:19
 * Created in $/source/D5Integrated
 * 新規作成
}

interface

uses
  SysUtils, Classes,
  DB, //削除予定
  s0CommonTypes,
  s0Collection,
  s0PropertyProtoType;

type
  Ts0EntityPropProto = class(Ts0PropertyProtoType)
  private
    FIsID: Boolean;
    FIsCaption: Boolean;
    FFieldName: string;
//DBユニットと共に削除予定
    FFieldType: TFieldType;
    FIsRequired: Boolean;
    FFieldSize: Integer;
    FIsNavigator: Boolean;
    FNaviClassName: string;
    FFieldTypeSX: K0FieldType;
    procedure SetIsNavigator(const Value: Boolean);
    procedure SetFieldName(const Value: string);
//DBユニットと共に削除予定
    procedure SetFieldType(const Value: TFieldType);
    procedure SetFieldTypeSX(const Value: K0FieldType);
    procedure SetFieldSize(const Value: Integer);
    procedure SetIsCaption(const Value: Boolean);
    procedure SetIsID(const Value: Boolean);
    procedure SetIsRequired(const Value: Boolean);
    procedure SetNaviClassName(const Value: string);
  protected
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    class function FieldTypeToPropTypeStr(AType: K0FieldType): string;
  published
    property FieldName: string read FFieldName write SetFieldName;
    property FieldTypeSX: K0FieldType read FFieldTypeSX write SetFieldTypeSX default k0ftUnknown;
//DBユニットと共に削除予定
    property FieldType: TFieldType read FFieldType write SetFieldType default ftUnknown;
    property FieldSize: Integer read FFieldSize write SetFieldSize default 0;
    property IsID: Boolean read FIsID write SetIsID default False;
    property IsCaption: Boolean read FIsCaption write SetIsCaption default False;
    property IsRequired: Boolean read FIsRequired write SetIsRequired default False;
    property IsNavigator: Boolean read FIsNavigator write SetIsNavigator default False;
    property NaviClassName: string read FNaviClassName write SetNaviClassName;
  end;

type
  Ts0EntityPropProtos = class(Ts0PropertyProtoTypes)
  private
    FIDProp: Ts0EntityPropProto;
    FCaptionProp: Ts0EntityPropProto;
    function GetItems(const Index: Integer): Ts0EntityPropProto;
    procedure SetItems(const Index: Integer; const Value: Ts0EntityPropProto);
    function GetIDProp: Ts0EntityPropProto;
    function GetCaptionProp: Ts0EntityPropProto;
  protected
    function FindIDProp: Ts0EntityPropProto;
    function FindCaptionProp: Ts0EntityPropProto;
    procedure NotifyItemDestroy(AItem: Ts0CollectionItem); override;
    procedure Update(Item: TCollectionItem); override;
  public
    property IDProp: Ts0EntityPropProto read GetIDProp;
    property CaptionProp: Ts0EntityPropProto read GetCaptionProp;
    function AddProto: Ts0EntityPropProto;
    function FindByName(APropName: string): Ts0EntityPropProto;
    property Items[const Index: Integer]: Ts0EntityPropProto read GetItems write SetItems;
  end;

implementation

{ Ts0EntityPropProto }

procedure Ts0EntityPropProto.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0EntityPropProto) then Exit;
  Self.FieldName     := Ts0EntityPropProto(Source).FFieldName    ;
  Self.FieldTypeSX   := Ts0EntityPropProto(Source).FFieldTypeSX  ;
  Self.FieldSize     := Ts0EntityPropProto(Source).FFieldSize    ;
  Self.IsID          := Ts0EntityPropProto(Source).FIsID         ;
  Self.IsCaption     := Ts0EntityPropProto(Source).FIsCaption    ;
  Self.IsRequired    := Ts0EntityPropProto(Source).FIsRequired   ;
  Self.IsNavigator   := Ts0EntityPropProto(Source).FIsNavigator  ;
  Self.NaviClassName := Ts0EntityPropProto(Source).FNaviClassName;
end;

constructor Ts0EntityPropProto.Create(ACollection: TCollection);
begin
  inherited;
  FFieldTypeSX := k0ftUnknown;
  FFieldSize := 0;
  FIsID := False;
  FIsCaption := False;
  FIsRequired := False;
  FIsNavigator := False;
end;

destructor Ts0EntityPropProto.Destroy;
begin
  inherited;
end;

class function Ts0EntityPropProto.FieldTypeToPropTypeStr(
  AType: K0FieldType): string;
begin
  Result := '';
  case AType of
    k0ftUnknown    : ;
    k0ftString     : Result := 'String';
    k0ftSmallint   : Result := 'Integer';
    k0ftInteger    : Result := 'Integer';
    k0ftWord       : Result := 'Integer';
    k0ftBoolean    : Result := 'Boolean';
    k0ftFloat      : Result := 'Double';
    k0ftCurrency   : Result := 'Currency';
    k0ftBCD        : ;
    k0ftDate       : Result := 'TDate';
    k0ftTime       : Result := 'TTime';
    k0ftDateTime   : Result := 'TDateTime';
    k0ftBytes      : ;
    k0ftVarBytes   : ;
    k0ftAutoInc    : ;
    k0ftBlob       : ;
    k0ftMemo       : Result := 'TStrings';
    k0ftGraphic    : ;
    k0ftFmtMemo    : Result := 'TStrings';
    k0ftParadoxOle : ;
    k0ftDBaseOle   : ;
    k0ftTypedBinary: ;
    k0ftCursor     : ;
    k0ftFixedChar  : Result := 'String';
    k0ftWideString : Result := 'WideString';
    k0ftLargeint   : Result := 'Int64';
    k0ftADT        : ;
    k0ftArray      : ;
    k0ftReference  : ;
    k0ftDataSet    : ;
    k0ftOraBlob    : ;
    k0ftOraClob    : ;
    k0ftVariant    : ;
    k0ftInterface  : ;
    k0ftIDispatch  : ;
    k0ftGuid       : ;
  end;
end;

procedure Ts0EntityPropProto.SetFieldName(const Value: string);
begin
  if (PropertyName = '') or (FFieldName  = PropertyName) then
  begin
    FFieldName := Value;
    PropertyName := FFieldName;
  end
  else
  begin
    FFieldName := Value;
  end;
  Changed(False);
end;

procedure Ts0EntityPropProto.SetFieldSize(const Value: Integer);
begin
  FFieldSize := Value;
  Changed(False);
end;

procedure Ts0EntityPropProto.SetFieldType(const Value: TFieldType);
const
  c9FTs: array[TFieldType] of K0FieldType = (
    k0ftUnknown, k0ftString, k0ftSmallint, k0ftInteger, k0ftWord,
    k0ftBoolean, k0ftFloat, k0ftCurrency, k0ftBCD, k0ftDate, k0ftTime, k0ftDateTime,
    k0ftBytes, k0ftVarBytes, k0ftAutoInc, k0ftBlob, k0ftMemo, k0ftGraphic, k0ftFmtMemo,
    k0ftParadoxOle, k0ftDBaseOle, k0ftTypedBinary, k0ftCursor, k0ftFixedChar, k0ftWideString,
    k0ftLargeint, k0ftADT, k0ftArray, k0ftReference, k0ftDataSet, k0ftOraBlob, k0ftOraClob,
    k0ftVariant, k0ftInterface, k0ftIDispatch, k0ftGuid
{$IFNDEF VER130}
    , k0ftTimeStamp, k0ftFMTBcd
{$ENDIF}
  );
begin
  FFieldType := Value;
  FieldTypeSX := c9FTs[FFieldType];
  Changed(False);
end;

procedure Ts0EntityPropProto.SetFieldTypeSX(const Value: K0FieldType);
begin
  FFieldTypeSX := Value;
  if (TypeName = '') or
     (TypeName = FieldTypeToPropTypeStr(FFieldTypeSX)) then
  begin
    FFieldTypeSX := Value;
    TypeName := FieldTypeToPropTypeStr(FFieldTypeSX);
  end
  else
  begin
    FFieldTypeSX := Value;
  end;
  Changed(False);
end;

procedure Ts0EntityPropProto.SetIsCaption(const Value: Boolean);
begin
  FIsCaption := Value;
  Changed(False);
end;

procedure Ts0EntityPropProto.SetIsID(const Value: Boolean);
begin
  FIsID := Value;
  Changed(False);
end;

procedure Ts0EntityPropProto.SetIsNavigator(const Value: Boolean);
begin
  FIsNavigator := Value;
  Changed(False);
end;

procedure Ts0EntityPropProto.SetIsRequired(const Value: Boolean);
begin
  FIsRequired := Value;
  Changed(False);
end;

procedure Ts0EntityPropProto.SetNaviClassName(const Value: string);
begin
  FNaviClassName := Value;
  Changed(False);
end;

{ Ts0EntityPropProtos }

function Ts0EntityPropProtos.AddProto: Ts0EntityPropProto;
begin
  Result := Ts0EntityPropProto(inherited Add);
end;

function Ts0EntityPropProtos.FindByName(
  APropName: string): Ts0EntityPropProto;
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

function Ts0EntityPropProtos.FindCaptionProp: Ts0EntityPropProto;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].IsCaption then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0EntityPropProtos.FindIDProp: Ts0EntityPropProto;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].IsID then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0EntityPropProtos.GetCaptionProp: Ts0EntityPropProto;
begin
  if FCaptionProp = nil then
    FCaptionProp := FindCaptionProp;
  Result := FCaptionProp;
end;

function Ts0EntityPropProtos.GetIDProp: Ts0EntityPropProto;
begin
  if FIDProp = nil then
    FIDProp := FindIDProp;
  Result := FIDProp;
end;

function Ts0EntityPropProtos.GetItems(
  const Index: Integer): Ts0EntityPropProto;
begin
  Result := Ts0EntityPropProto(inherited Items[Index]);
end;

procedure Ts0EntityPropProtos.NotifyItemDestroy(AItem: Ts0CollectionItem);
begin
  if FIDProp = AItem then FIDProp := nil;
  if FCaptionProp = AItem then FCaptionProp := nil;
  inherited NotifyItemDestroy(AItem);
end;

procedure Ts0EntityPropProtos.SetItems(const Index: Integer;
  const Value: Ts0EntityPropProto);
begin
  inherited Items[Index] := Value;
end;

procedure Ts0EntityPropProtos.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if not(Item is Ts0EntityPropProto) then Exit;
  if Ts0EntityPropProto(Item).IsID then
    FIDProp := Ts0EntityPropProto(Item)
  else
  if FIDProp = Item then
    FIDProp := nil;
end;

end.

