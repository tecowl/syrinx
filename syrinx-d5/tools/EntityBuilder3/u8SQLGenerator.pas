unit u8SQLGenerator;
{
$History: u8SQLGenerator.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/04/24   Time: 2:45
 * Updated in $/tools/EntityBuilder3
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:23
 * Created in $/tools/EntityBuilder3
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/13   Time: 14:32
 * Created in $/tools/EntityBuilder2
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/11/22   Time: 22:00
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/21   Time: 20:55
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/02   Time: 14:12
 * Created in $/source/D5Integrated/tools/EntityBuilder2
 * 新規作成
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/10/24   Time: 5:19
 * Created in $/source/D5Integrated/tools/EntityBuilder
 * 新規作成
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/04   Time: 12:25
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/02   Time: 3:19
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/21   Time: 17:03
 * Updated in $/source/D5/tools/EntityBuilder
 * Ts0PropertyProtoTypesからTs0EntityPropProtoを使用するように変更
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/16   Time: 23:33
 * Updated in $/source/D5/tools/EntityBuilder
}

interface

uses
  SysUtils, Classes,
  s0Collection,
  s0PropertyProtoType,
  s0EntityPropProto;

type
  T8SQLGenerator = class
  private
    FSource: Ts0EntityPropProtos;
    FTableName: string;
    FPropsNotID: Ts0CollectionItemList;
    FEntityName: string;
    procedure SetSource(const Value: Ts0EntityPropProtos);
    procedure SetTableName(const Value: string);
    procedure AddWhereBlock(Dest: TStrings);
    function GetPropsNotID: Ts0CollectionItemList;
    function GetItemsNotID(const Index: Integer): Ts0EntityPropProto;
    procedure SetEntityName(const Value: string);
  protected
    procedure AddParams(Dest: TStrings; AParams: TStrings);
    property PropsNotID: Ts0CollectionItemList read GetPropsNotID;
    property ItemsNotID[const Index: Integer]: Ts0EntityPropProto read GetItemsNotID;
  public
    destructor Destroy; override;
    class function GetParamName(AItem: Ts0EntityPropProto): string;
    procedure MakeDelete(Dest: TStrings);
    procedure MakeInsert(Dest: TStrings);
    procedure MakeUpdate(Dest: TStrings);
    procedure MakeSelect(Dest: TStrings);
    procedure MakeSelectList(Dest: TStrings);
    property TableName: string read FTableName write SetTableName;
    property EntityName: string read FEntityName write SetEntityName;
    property Source: Ts0EntityPropProtos read FSource write SetSource;
  end;

implementation

uses
  s0ValidationMsg;

{ T8SQLGenerator }

procedure T8SQLGenerator.AddParams(Dest, AParams: TStrings);
var
  i: Integer;
begin
  for i := 0 to AParams.Count -2 do
    Dest.Add( AParams.Strings[i] + ',');
  if AParams.Count > 0 then
    Dest.Add( AParams.Strings[AParams.Count -1] );
end;

procedure T8SQLGenerator.AddWhereBlock(Dest: TStrings);
begin
  Dest.Add(
    Format('WHERE %s = :%s', [
        Source.IDProp.FieldName,
        GetParamName(Source.IDProp)
    ]) );
end;

destructor T8SQLGenerator.Destroy;
begin
  FreeAndNil(FPropsNotID);
  inherited;
end;

function T8SQLGenerator.GetItemsNotID(
  const Index: Integer): Ts0EntityPropProto;
begin
  Result := Ts0EntityPropProto(PropsNotID.Items[Index]);
end;

class function T8SQLGenerator.GetParamName(AItem: Ts0EntityPropProto): string;
begin
  Result := 'P_' + AItem.PropertyName;
end;

function T8SQLGenerator.GetPropsNotID: Ts0CollectionItemList;
var
  i: Integer;
  item: Ts0EntityPropProto;
begin
  if FPropsNotID = nil then
  begin
    FPropsNotID := Ts0CollectionItemList.Create(False);
    for i := 0 to Source.Count -1 do
    begin
      item := Source.Items[i];
      if not item.IsID then
        FPropsNotID.Add(item);
    end;
  end;
  Result := FPropsNotID;
end;

resourcestring
  c9ErrMsg_NoIDProp =
    '"%s"にはIDとして指定されたプロパティがありませんので、%sを生成されません。';

procedure T8SQLGenerator.MakeDelete(Dest: TStrings);
begin
  Dest.Clear;
  if Source.IDProp = nil then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg(         
      Format(c9ErrMsg_NoIDProp, [FEntityName, 'Delete文']),
      k0vrFatalError
    );
    Exit;
  end;
  Dest.Add('DELETE FROM '+ TableName );
  AddWhereBlock(Dest);
end;

procedure T8SQLGenerator.MakeInsert(Dest: TStrings);
var
  i: Integer;
  tmp: TStringList;
begin
  tmp := TStringList.Create;
  try
    Dest.Clear;
    Dest.Add('INSERT INTO '+ TableName );
    Dest.Add('(');
    for i := 0 to Source.Count -1 do
      tmp.Add( '  '+ Source.Items[i].FieldName );
    AddParams(Dest, tmp);
    Dest.Add(')');
    Dest.Add('VALUES');
    Dest.Add('(');
    tmp.Clear;
    for i := 0 to Source.Count -1 do
      tmp.Add( '  :'+ GetParamName(Source.Items[i]) );
    AddParams(Dest, tmp);
    Dest.Add(')');
    //AddWhereBlock(Dest);
  finally
    FreeAndNil(tmp);
  end;
end;

procedure T8SQLGenerator.MakeSelect(Dest: TStrings);
begin
  MakeSelectList(Dest);
  if Source.IDProp = nil then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg(
      Format(c9ErrMsg_NoIDProp, [FEntityName, '単一行を選択するSelect文のWhere節']),
      k0vrWarning
    );
    Exit;
  end;
  AddWhereBlock(Dest);
end;

procedure T8SQLGenerator.MakeSelectList(Dest: TStrings);
var
  i: Integer;
  tmp: TStringList;
begin
  tmp := TStringList.Create;
  try
    Dest.Clear;
    Dest.Add('SELECT ');
    for i := 0 to Source.Count -1 do
      tmp.Add( Format('  %s %s', [
        Source.Items[i].FieldName,
        Source.Items[i].PropertyName
      ]) );
    AddParams(Dest, tmp);
    Dest.Add('FROM '+ TableName);
  finally
    FreeAndNil(tmp);
  end;
end;

procedure T8SQLGenerator.MakeUpdate(Dest: TStrings);
var
  i: Integer;
  tmp: TStringList;
begin
  if Source.IDProp = nil then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg(
      Format(c9ErrMsg_NoIDProp, [FEntityName, 'Update文']),
      k0vrFatalError
    );
    Exit;
  end;
  tmp := TStringList.Create;
  try
    Dest.Clear;
    Dest.Add('UPDATE '+ TableName);
    Dest.Add('SET');
    for i := 0 to PropsNotID.Count -1 do
      tmp.Add( Format('  %s = :%s', [
        ItemsNotID[i].FieldName,
        GetParamName( ItemsNotID[i] )
      ]) );
    AddParams(Dest, tmp);
    AddWhereBlock(Dest);
  finally
    FreeAndNil(tmp);
  end;
end;

procedure T8SQLGenerator.SetEntityName(const Value: string);
begin
  FEntityName := Value;
end;

procedure T8SQLGenerator.SetSource(const Value: Ts0EntityPropProtos);
begin
  FSource := Value;
end;

procedure T8SQLGenerator.SetTableName(const Value: string);
begin
  FTableName := Value;
end;

end.
