unit s0FieldHelper;
{
$History: s0FieldHelper.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/15   Time: 11:38
 * Updated in $/D5/source/Common
 * FieldTypeFromNative、FieldTypeToNativeメソッドを追加
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/06   Time: 21:28
 * Updated in $/source/D5Integrated
 * VER130,VER140共用にした
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/03   Time: 2:31
 * Updated in $/source/D5/p0db
 * エンティティ生成関係とりあえずOKできました
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/01   Time: 2:53
 * Created in $/source/D5/p0db
 * 新規作成
}

interface

uses
  SysUtils, Classes, DB,
  s0CommonTypes;

type
  Ts0FieldHelper = class
  public
    class function TypeToStr(AType: TFieldType): string;
    class function StrToType(AName: string): TFieldType;
    class procedure CreateFields(DataSet: TDataSet; AOwner: TComponent);
    class function FieldTypeFromNative(AType: TFieldType): K0FieldType;
    class function FieldTypeToNative(AType: K0FieldType): TFieldType;
  end;

const
  c0FieldTypeStrs: array[TFieldType] of string = (
    'Unknown' , 'String'     , 'Smallint', 'Integer'  , 'Word'      ,
    'Boolean' , 'Float'      , 'Currency', 'BCD'      , 'Date'      ,
    'Time'    , 'DateTime'   , 'Bytes'   , 'VarBytes' , 'AutoInc'   ,
    'Blob'    , 'Memo'       , 'Graphic' , 'FmtMemo'  , 'ParadoxOle',
    'DBaseOle', 'TypedBinary', 'Cursor'  , 'FixedChar', 'WideString',
    'Largeint', 'ADT'        , 'Array'   , 'Reference', 'DataSet'   ,
    'OraBlob' , 'OraClob'    , 'Variant' , 'Interface', 'IDispatch'  ,
    'Guid'
{$IFNDEF VER130}
    , 'TimeStamp', 'FMTBcd'
{$ENDIF}
  );

implementation

{ Ts0FieldHelper }

class procedure Ts0FieldHelper.CreateFields(DataSet: TDataSet;
  AOwner: TComponent);
var
  i: Integer;
  fld: TField;
begin
  if DataSet.FieldDefs.Count < 1 then
  begin
    DataSet.Open;
    DataSet.Close;
  end;
  for i := 0 to DataSet.FieldDefs.Count -1 do
  begin
    fld := DataSet.FieldDefs.Items[i].CreateField(AOwner);
    fld.Name := DataSet.Name + fld.FieldName;
  end;
end;

class function Ts0FieldHelper.FieldTypeFromNative(
  AType: TFieldType): K0FieldType;
const
  c9NtoK: array[TFieldType] of K0FieldType = (
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
  Result := c9NtoK[AType];
end;

class function Ts0FieldHelper.FieldTypeToNative(
  AType: K0FieldType): TFieldType;
const
  c9KtoN: array[K0FieldType] of TFieldType = (
    ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
    ftBytes, ftVarBytes, ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo,
    ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftFixedChar, ftWideString,
    ftLargeint, ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,
    ftVariant, ftInterface, ftIDispatch, ftGuid
{$IFNDEF VER130}
    , ftTimeStamp, ftFMTBcd
{$ENDIF}
  );
begin
  Result := c9KtoN[AType];
end;

class function Ts0FieldHelper.StrToType(AName: string): TFieldType;
var
  i: TFieldType;
begin
  Result := ftUnknown;
  for i := Low(TFieldType) to High(TFieldType) do
    if AName = TypeToStr(i) then
    begin
      Result := i;
      Exit;
    end;
end;

class function Ts0FieldHelper.TypeToStr(AType: TFieldType): string;
begin
  Result := c0FieldTypeStrs[ AType ];
end;

end.















































































