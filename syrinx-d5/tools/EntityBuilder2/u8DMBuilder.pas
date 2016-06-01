unit u8DMBuilder;
{
$History: u8DMBuilder.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/13   Time: 14:32
 * Created in $/tools/EntityBuilder2
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/14   Time: 23:47
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/12/11   Time: 3:40
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/22   Time: 22:00
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/02   Time: 14:12
 * Created in $/source/D5Integrated/tools/EntityBuilder2
 * �V�K�쐬
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/10/24   Time: 5:19
 * Created in $/source/D5Integrated/tools/EntityBuilder
 * �V�K�쐬
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/09   Time: 13:45
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/04   Time: 12:25
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/02   Time: 13:38
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/02   Time: 3:19
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/01   Time: 9:17
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/28   Time: 1:54
 * Updated in $/source/D5/tools/EntityBuilder
 * ���������Select����Field���̓v���p�e�B����ݒ肷��悤�ɂ��Ă���̂ŁA
 * FindField�Ƀv���p�e�B����n���悤�ɏC���B
 * �܂��AFieldByName���g�p���Ă���ƌ�����Ȃ������Ƃ��ɗ�O�����������
 * ��FindField���g�p����悤�ɏC���B
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/27   Time: 22:41
 * Created in $/source/D5/tools/EntityBuilder
 * �V�K�쐬
}

interface

uses
  SysUtils, Classes,
  DB, DBTables,
  s0Collection,
  s0EnumCollection,
  s0Query,
  u0SXMetaClass,
  s0PropertyProtoType,
  d8EntityTemplate,
  s0DBEntity,
  s0EntityPropProto,
  u8BuilderParam,
  u8SQLGenerator;

type
  T8EnumProto = class(Ts0CollectionItem)
  private
    FEnumName: string;
    FTextField: string;
    FTanbleName: string;
    FItemIDField: string;
    procedure SetEnumName(const Value: string);
    procedure SetItemIDField(const Value: string);
    procedure SetTanbleName(const Value: string);
    procedure SetTextField(const Value: string);
  published
    property EnumName: string read FEnumName write SetEnumName;
    property TanbleName: string read FTanbleName write SetTanbleName;
    property ItemIDField: string read FItemIDField write SetItemIDField;
    property TextField: string read FTextField write SetTextField;
  end;

type
  T8EnumProtos = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): T8EnumProto;
    procedure SetItems(const Index: Integer; const Value: T8EnumProto);
  public
    function Add(AEnumName: string): T8EnumProto;
    property Items[const Index: Integer]: T8EnumProto read GetItems write SetItems;
  end;

type
  T8EntityIDConstNameEvent = procedure(Sender: TObject; AEtyClassName: string;
    var AIDConstName: string) of object;

type
  T8DMBuilder = class(TComponent)
  private
    FMetaUnit: T0SXMetaUnit;
    FDestDFM: TStrings;
    FOnGetIDConstName: T8EntityIDConstNameEvent;
    FEnumProtos: T8EnumProtos;
    FSQLGenerator: T8SQLGenerator;
    FSQL: array[K0EntityDataSetType] of TStrings;
    FSQLGenerated: Boolean;
    FParams: T8BuilderParam;
    FTemplate: Tdm8EntityTemplate;
    procedure CreateEnumCollections(AMeta: T0SXMetaClass; ADM: Tdm8EntityTemplate);
    procedure CreateQueryFields(ADM: Tdm8EntityTemplate);
    procedure GenerateMetaClass(AMeta: T0SXMetaClass; ADM: Tdm8EntityTemplate);
    procedure SaveDFMToList(Dest: TStrings; ADM: Tdm8EntityTemplate);
    function GetFieldProp(AProp: Ts0EntityPropProto): string;
    function GetIDConstName(AEtyClassName: string): string;
    procedure GetQuerySQL(Dest: TStrings; AType: K0EntityDataSetType);
    procedure WriteExecDetail(Dest: TStrings; AQry: Ts0Query);
    procedure WriteExecInsert(Dest: TStrings; AQry: Ts0Query);
    procedure WriteExecLoadKey(Dest: TStrings; AQry: Ts0Query);
    procedure WriteExecRemove(Dest: TStrings; AQry: Ts0Query);
    procedure WriteExecUpdate(Dest: TStrings; AQry: Ts0Query);
    procedure WriteUpdInsCommon(Dest: TStrings; AQry: Ts0Query);
    procedure WriteSelEntitiesCalcFields(Dest: TStrings; AQry: Ts0Query);
    procedure SetEnumProtos(const Value: T8EnumProtos);
    function GetSQLs(const AKind: K0EntityDataSetType): TStrings;
    procedure SetSQLs(const AKind: K0EntityDataSetType;
      const Value: TStrings);
    function GetEntityClassName: string;
    function GetDMName: string;
    procedure SetTemplate(const Value: Tdm8EntityTemplate);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Params: T8BuilderParam read FParams write FParams;
    property EntityClassName: string read GetEntityClassName;
    property MetaUnit: T0SXMetaUnit read FMetaUnit write FMetaUnit;
    property DMName: string read GetDMName;
    property DestDFM: TStrings read FDestDFM write FDestDFM;
    property OnGetIDConstName: T8EntityIDConstNameEvent read FOnGetIDConstName write FOnGetIDConstName;
    procedure Execute;
    procedure GenerateSQLs;
    property SQLGenerated: Boolean read FSQLGenerated write FSQLGenerated;
    //
    property EnumProtos: T8EnumProtos read FEnumProtos write SetEnumProtos;
    property SQLGenerator: T8SQLGenerator read FSQLGenerator;
    property SQLs[const AKind: K0EntityDataSetType]: TStrings read GetSQLs write SetSQLs;
    //
    property Template: Tdm8EntityTemplate read FTemplate write SetTemplate;
  end;

implementation

uses
  s0ComponentHelper,
  s0ObjectHelper,
  s0FieldHelper;


{ T8EnumProto }

procedure T8EnumProto.SetEnumName(const Value: string);
begin
  FEnumName := Value;
  Changed(False);
end;

procedure T8EnumProto.SetItemIDField(const Value: string);
begin
  FItemIDField := Value;
  Changed(False);
end;

procedure T8EnumProto.SetTanbleName(const Value: string);
begin
  FTanbleName := Value;
  Changed(False);
end;

procedure T8EnumProto.SetTextField(const Value: string);
begin
  FTextField := Value;
  Changed(False);
end;

{ T8EnumProtos }

function T8EnumProtos.Add(AEnumName: string): T8EnumProto;
begin
  Result := T8EnumProto(inherited Add);
  Result.FEnumName := AEnumName;
end;

function T8EnumProtos.GetItems(const Index: Integer): T8EnumProto;
begin
  Result := T8EnumProto(inherited Items[Index]);
end;

procedure T8EnumProtos.SetItems(const Index: Integer;
  const Value: T8EnumProto);
begin
  inherited Items[Index] := Value;
end;


const
  c9QueryNames: array[K0EntityDataSetType] of string = (
    'selEntity', 'selEntities', 'insEntity', 'updEntity', 'delEntity'
  );
  
procedure T8DMBuilder.GetQuerySQL(Dest: TStrings; AType: K0EntityDataSetType);
begin
  case AType of
    k0edsDetail : FSQLGenerator.MakeSelect(Dest);
    k0edsLoadKey: FSQLGenerator.MakeSelectList(Dest);
    k0edsInsert : FSQLGenerator.MakeInsert(Dest);
    k0edsUpdate : FSQLGenerator.MakeUpdate(Dest);
    k0edsRemove : FSQLGenerator.MakeDelete(Dest);
  end;
end;

procedure T8DMBuilder.CreateEnumCollections(AMeta: T0SXMetaClass; ADM: Tdm8EntityTemplate);
var
  i: Integer;
  ei: T8EnumProto;
  ec: Ts0EnumCollection;
  enumSQL: string;
  rm: T0SXMetaMethod;
  sl: TStrings;
  frmCreate, frmDestroy: T0SXMetaMethod;
  ecFiled: T0SXMetaField;
begin
  frmCreate := AMeta.Methods.Add('DataModuleCreate', '', True);
  frmCreate.Params.AddParam('Sender', 'TObject');
  frmCreate.Visibility := k0cpvNone;
  //
  frmDestroy := AMeta.Methods.Add('DataModuleDestroy', '', True);
  frmDestroy.Params.AddParam('Sender', 'TObject');
  frmDestroy.Visibility := k0cpvNone;
  //
  if FEnumProtos.Count < 1 then Exit;
  //
  for i := 0 to FEnumProtos.Count -1 do
  begin
    ei := FEnumProtos.Items[i];
    if ei.EnumName = '' then Continue;
    ec := Ts0EnumCollection.Create(ADM);
    ec.Name := Ts0ComponentHelper.GetNewComponentNameOf(ec, 'enum' + ei.EnumName);
    ec.EnumName := ei.EnumName;
    ecFiled := AMeta.Fields.Add(ec.Name, ec.ClassName);
    ecFiled.Visibility := k0cpvNone;
    if ei.TanbleName = '' then Continue;
    if ei.ItemIDField = '' then Continue;
    if ei.TextField = '' then Continue;
    //
    enumSQL :=
      Format('SELECT %s EnumID, %s EnumText FROM %s', [
        ei.ItemIDField, ei.TextField, ei.TanbleName
      ]);
    //
    rm := AMeta.Methods.Add('Restore' + ei.EnumName, '', True);
    rm.Visibility := k0cpvPrivate;
    rm.ImplMethod.WithoutBeginEnd := True;
    sl := rm.ImplMethod.ImplementCode;
    sl.Add( 'var');
    sl.Add( '  qry: Ts0Query;' );
    sl.Add( '  fldID: TField;' );
    sl.Add( '  fldText: TField;' );
    sl.Add( 'begin' );
    sl.Add( '  ' + ec.Name +'.Items.Clear;' );
    sl.Add( '  qry := Ts0Query.Create(nil);' );
    sl.Add( '  try' );
    sl.Add( '    qry.DatabaseName := ' + AnsiQuotedStr(Params.DataBaseName, '''') +';' );
    sl.Add( '    qry.SQL.Text := ' + AnsiQuotedStr(enumSQL, '''') +';' );
    sl.Add( '    qry.Open;' );
    sl.Add( '    fldID := qry.FieldByName(''EnumID''); ' );
    sl.Add( '    fldText := qry.FieldByName(''EnumText''); ' );
    sl.Add( '    qry.First;' );
    sl.Add( '    while not qry.Eof do' );
    sl.Add( '    begin' );
    sl.Add( '      ' + ec.Name + '.Items.AddItem(fldText.AsString, fldID.AsInteger); ');
    sl.Add( '      qry.Next;' );
    sl.Add( '    end;' );
    sl.Add( '    qry.Close;' );
    sl.Add( '  finally' );
    sl.Add( '    FreeAndNil(qry);' );
    sl.Add( '  end;' );
    sl.Add( 'end;' );
    //
    frmCreate.ImplMethod.ImplementCode.Add('  '+ rm.Name +';' ); 
  end;
end;

procedure T8DMBuilder.CreateQueryFields(ADM: Tdm8EntityTemplate);
var
  qry: Ts0Query;
  i: K0EntityDataSetType;
  j: Integer;
  fld: TField;
  strField: TStringField;
  prop: Ts0EntityPropProto;
begin
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
  begin
    qry := nil;
    case i of
      k0edsDetail : qry := ADM.selEntity;
      k0edsLoadKey: qry := ADM.selEntities;
      k0edsInsert : qry := ADM.insEntity;
      k0edsUpdate : qry := ADM.updEntity;
      k0edsRemove : qry := ADM.delEntity;
    end;
    qry.SessionName := Params.SessionName;
    qry.DatabaseName := Params.DataBaseName;
    qry.SQL.Assign(SQLs[i]);
    if not(i in [k0edsDetail, k0edsLoadKey]) then Continue;
    for j := 0 to qry.ParamCount -1 do
      qry.Params.Items[j].AsInteger := 0;
    Ts0FieldHelper.CreateFields(qry, ADM);
    for j := 0 to Params.ProtoTypes.Count -1 do
    begin
      prop := Params.ProtoTypes.Items[j];
      fld := qry.FindField( prop.PropertyName );
      if fld = nil then Continue;
      fld.DisplayLabel := prop.JPName;
      if prop.IsEnum or (Trim(prop.EnumName) <> '') then
      begin
        fld.Visible := False;
        strField := TStringField.Create(ADM);
        strField.FieldName := fld.FieldName + 'Str';
        strField.Name := qry.Name + strField.FieldName;
        strField.FieldKind := fkCalculated;
        strField.DisplayLabel := prop.JPName;
        strField.DataSet := qry;
        strField.Index := fld.Index;
      end;
    end;
  end;
end;

procedure T8DMBuilder.SaveDFMToList(Dest: TStrings; ADM: Tdm8EntityTemplate);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    Ts0ObjectHelper.GetComponentData(ADM, ms);
    ms.Position := 0;
    Dest.BeginUpdate;
    try
      Dest.LoadFromStream(ms);
      { �C���X�^���X���A�N���X����ύX }
      Dest.Text := StringReplace(DestDFM.Text, 'dm8EntityTemplate', ADM.Name, [rfReplaceAll]);
    finally
      Dest.EndUpdate;
    end;
  finally
    FreeAndNil(ms);
  end;
end;

function T8DMBuilder.GetFieldProp(AProp: Ts0EntityPropProto): string;
type
  R9FieldPropSet = packed record
    FType: string;
    FProp: string;
  end;
const
  c9PropSetArrat: array[0..9] of R9FieldPropSet = (
    (FType: 'String'   ; FProp: 'AsString'   ),
    (FType: 'Integer'  ; FProp: 'AsInteger'  ),
    (FType: 'Boolean'  ; FProp: 'AsBoolean'  ),
    (FType: 'Double'   ; FProp: 'AsFloat'    ),
    (FType: 'Single'   ; FProp: 'AsFloat'    ),
    (FType: 'Extended' ; FProp: 'AsFloat'    ),
    (FType: 'Currency' ; FProp: 'AsCurrency' ),
    (FType: 'TDate'    ; FProp: 'AsDateTime' ),
    (FType: 'TTime'    ; FProp: 'AsDateTime' ),
    (FType: 'TDateTime'; FProp: 'AsDateTime' )
  );
var
  i: Integer;
begin
  Result := 'AsString';
  if AProp.IsEnum then
  begin
    Result := c9PropSetArrat[1].FProp;
  end
  else
  begin
    for i := Low(c9PropSetArrat) to High(c9PropSetArrat) do
      if SameText(AProp.TypeName, c9PropSetArrat[i].FType) then
      begin
        Result := c9PropSetArrat[i].FProp;
        Exit;
      end;
  end;
  if AProp.FieldType in [ftBlob, ftMemo, ftFmtMemo, ftOraBlob] then
    Result := 'AsBlob';
end;

procedure T8DMBuilder.WriteExecDetail(Dest: TStrings; AQry: Ts0Query);
var
  i: Integer;
  fld: TField;
  v, acsProp: string;
  proto: Ts0EntityPropProto;
  propAcsr: string;
begin
  Dest.Add('  AEntity.Navigators.Clear;');
  Dest.Add('  AEntity.BeginUpdate;');
  Dest.Add('  try');
  if Params.ProtoTypes.IDProp <> nil then
  begin
    Dest.Add('    '+ AQry.Name +'.ParamByName(''' +
      T8SQLGenerator.GetParamName( Params.ProtoTypes.IDProp ) + ''').AsInteger := AEntity.ID;');
  end;
  Dest.Add('    '+ AQry.Name +'.Open;');
  Dest.Add('    try');
  Dest.Add('      '+ AQry.Name +'.First;');
  Dest.Add('      if '+ AQry.Name +'.Eof then Exit;');
  for i := 0 to Params.ProtoTypes.Count -1 do
  begin
    proto := Params.ProtoTypes.Items[i];
    if proto.IsID then Continue;
    fld := AQry.FindField(proto.PropertyName);
    if fld = nil then Continue;
    //
    acsProp := GetFieldProp(proto);
    v := acsProp;
    if SameText(acsProp, 'asblob') then
      v := 'AsString'
    else
    if SameText(acsProp, 'asboolean') then
      v := 'AsInteger';
    //
    v := fld.Name + '.' + v;
    if proto.IsEnum then
      v := proto.TypeName + '( ' + v + ' )'
    else
    if SameText(acsProp, 'asboolean') then
      v := 'Boolean(' + v + ')';
    //
    propAcsr := '';
    if SameText(proto.TypeName, 'TStrings') or
       SameText(proto.TypeName, 'TStringList') then
      propAcsr := '.Text';
    Dest.Add(
      Format(
        '      %s(AEntity).%s%s := %s;',
        [ EntityClassName, proto.PropertyName, propAcsr, v ]
      )
    );
  end;
  for i := 0 to Params.ProtoTypes.Count -1 do
  begin
    proto := Params.ProtoTypes.Items[i];
    if not proto.IsNavigator then Continue;
    Dest.Add('      AEntity.Navigators.AddByID(');
    Dest.Add('        '+ EntityClassName +'(AEntity).'+ proto.PropertyName + ',' );
    Dest.Add('        '+ GetIDConstName(proto.NaviClassName) + ',' );
    Dest.Add('        '''',' );
    Dest.Add('        '''+ proto.PropertyName + ''');' );
  end;
  Dest.Add('    finally');
  Dest.Add('      '+ AQry.Name +'.Close;');
  Dest.Add('    end;');
  Dest.Add('  finally');
  Dest.Add('    AEntity.EndUpdate;');
  Dest.Add('  end;');
end;

procedure T8DMBuilder.WriteUpdInsCommon(Dest: TStrings; AQry: Ts0Query);
var
  i: Integer;
  v: string;
  proto: Ts0EntityPropProto;
begin
  Dest.Add('  ' + AQry.Name +'.Close;');
  for i := 0 to Params.ProtoTypes.Count -1 do
  begin
    proto := Params.ProtoTypes.Items[i];
    v := Format('%s(AEntity).%s', [EntityClassName, proto.PropertyName]);
    if proto.IsEnum then
      v := 'Ord( ' + v + ' )'
    else
    if SameText(proto.TypeName, 'TStrings') or
       SameText(proto.TypeName, 'TStringList') then
      v := v + '.Text';
    Dest.Add(
      Format( '  %s.ParamByName(''%s'').%s := %s;', [
        AQry.Name, T8SQLGenerator.GetParamName( proto ) ,
        GetFieldProp( proto ), v
      ])
    );
  end;
  Dest.Add('  ' + AQry.Name +'.ExecSQL;');
end;

procedure T8DMBuilder.WriteExecInsert(Dest: TStrings; AQry: Ts0Query);
begin
  WriteUpdInsCommon(Dest, AQry);
end;

procedure T8DMBuilder.WriteExecRemove(Dest: TStrings; AQry: Ts0Query);
begin
  if Params.ProtoTypes.IDProp = nil then Exit;
  Dest.Add('  ' + AQry.Name +'.Close;');
  Dest.Add('  ' + AQry.Name +'.ParamByName(''' +
    T8SQLGenerator.GetParamName( Params.ProtoTypes.IDProp ) + ''').AsInteger := AEntity.ID;');
  Dest.Add('  ' + AQry.Name +'.ExecSQL;');
end;

procedure T8DMBuilder.WriteExecUpdate(Dest: TStrings; AQry: Ts0Query);
begin
  if Params.ProtoTypes.IDProp = nil then Exit; 
  WriteUpdInsCommon(Dest, AQry);
end;

procedure T8DMBuilder.WriteExecLoadKey(Dest: TStrings; AQry: Ts0Query);
var
  fld: TField;
begin
  //ID
  if Params.ProtoTypes.IDProp <> nil then
  begin
    fld := AQry.FindField(Params.ProtoTypes.IDProp.PropertyName);
    if fld = nil then Exit;
    Dest.Add( Format('  AEntity.ID := %s.AsInteger;', [fld.Name]) );
  end;
  //Caption
  if Params.ProtoTypes.CaptionProp <> nil then
  begin
    fld := AQry.FieldByName(Params.ProtoTypes.CaptionProp.PropertyName);
    if fld = nil then Exit;
    Dest.Add( Format('  AEntity.Caption := %s.AsString;', [fld.Name]) );
  end;
end;

procedure T8DMBuilder.GenerateMetaClass(AMeta: T0SXMetaClass; ADM: Tdm8EntityTemplate);
const
  c9MethodNames: array[K0EntityDataSetType] of string = (
    'EntityManagerExecDetail',
    'EntityManagerLoadKey'   ,
    'EntityManagerExecInsert',
    'EntityManagerExecUpdate',
    'EntityManagerExecRemove'
  );
var
  i: Integer;
  j: K0EntityDataSetType;
  fld: T0SXMetaField;
  mthd: T0SXMetaMethod;
begin
  for i := 0 to ADM.ComponentCount -1 do
  begin
    fld := AMeta.Fields.Add(ADM.Components[i].Name, ADM.Components[i].ClassName);
    fld.Visibility := k0cpvNone;
  end;
  for j := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
  begin
    mthd := AMeta.Methods.Add( c9MethodNames[j], '', True);
    mthd.Params.AddParam('Sender', 'TObject', k0pkNone);
    mthd.Params.AddParam('ADataSet', 'TDataSet', k0pkNone);
    mthd.Params.AddParam('AEntity', 'Ts0Entity', k0pkNone);
    case j of
      k0edsDetail : WriteExecDetail( mthd.ImplMethod.ImplementCode , ADM.selEntity   );
      k0edsLoadKey: WriteExecLoadKey( mthd.ImplMethod.ImplementCode, ADM.selEntities );
      k0edsInsert : WriteExecInsert( mthd.ImplMethod.ImplementCode , ADM.insEntity   );
      k0edsUpdate : WriteExecUpdate( mthd.ImplMethod.ImplementCode , ADM.updEntity   );
      k0edsRemove : WriteExecRemove( mthd.ImplMethod.ImplementCode , ADM.delEntity   );
    end;
  end;
  //
  mthd := AMeta.Methods.Add( 'selEntitiesCalcFields', '', True);
  mthd.Params.AddParam('DataSet', 'TDataSet', k0pkNone);
  WriteSelEntitiesCalcFields(mthd.ImplMethod.ImplementCode, ADM.selEntities);
end;

procedure T8DMBuilder.Execute;
  procedure InitQueryProps(ADM: TComponent);
  var
    i: Integer;
    qry: TQuery;
  begin
    if ADM = nil then Exit;
    for i := 0 to ADM.ComponentCount -1 do
    begin
      if not(ADM.Components[i] is TQuery) then Continue;
      qry := TQuery(ADM.Components[i]);
      qry.Close;
      qry.SessionName := 'Default';
      qry.DatabaseName := Params.DataBaseName;
    end;
  end;
var
  dm: T0SXMetaClass;
begin
  Template.Name := DMName;
  Template.EntityManager.SetTestSwitch(True);
  Template.EntityManager.EntityClassName := EntityClassName;
  Template.EntityManager.ProtoTypes.Assign( Params.ProtoTypes );
  CreateQueryFields(Template);
  InitQueryProps(Template);

  dm := T0SXMetaClass.Create(nil);
  dm.Name := 'T' + DMName;
  dm.SuperClassName := 'TDataModule';
  dm.Collection := MetaUnit.Types;
  GenerateMetaClass(dm, Template);

  CreateEnumCollections(dm, Template);
  SaveDFMToList(DestDFM, Template);
end;

procedure T8DMBuilder.WriteSelEntitiesCalcFields(Dest: TStrings; AQry: Ts0Query);
var
  i: Integer;
  origFld, calcFld: TField;
  proto: Ts0EntityPropProto;
begin
  for i := 0 to Params.ProtoTypes.Count -1 do
  begin
    proto := Params.ProtoTypes.Items[i];
    origFld := AQry.FindField(proto.PropertyName);
    if origFld = nil then Continue;
    calcFld := AQry.FindField( origFld.FieldName +'Str' );
    if calcFld = nil then Continue;
    if proto.IsEnum then
    begin
      Dest.Add(
        Format(
          '  %s.AsString := %s.%sToStr( %s(%s.AsInteger) );' ,
          [ calcFld.Name, EntityClassName, proto.PropertyName, proto.TypeName, origFld.Name ]
        )
      );
    end
    else
    begin
      Dest.Add(
        Format(
          '  %s.AsString := %s.%sToStr( %s.AsInteger );' ,
          [ calcFld.Name, EntityClassName, proto.PropertyName, origFld.Name ]
        )
      );
    end;
  end;
end;

function T8DMBuilder.GetIDConstName(AEtyClassName: string): string;
begin
  Result := '';
  if Assigned(FOnGetIDConstName) then
    FOnGetIDConstName(Self, AEtyClassName, Result);
end;

procedure T8DMBuilder.SetEnumProtos(const Value: T8EnumProtos);
begin
  FEnumProtos := Value;
end;

constructor T8DMBuilder.Create(AOwner: TComponent);
var
  i: K0EntityDataSetType;
begin
  inherited;
  FEnumProtos := T8EnumProtos.Create(Self, T8EnumProto);
  FSQLGenerator := T8SQLGenerator.Create;
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    FSQL[i] := TStringList.Create;
end;

destructor T8DMBuilder.Destroy;
var
  i: K0EntityDataSetType;
begin
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    FreeAndNil(FSQL[i]);
  FreeAndNil(FSQLGenerator);
  FreeAndNil(FEnumProtos);
  inherited;
end;

function T8DMBuilder.GetSQLs(const AKind: K0EntityDataSetType): TStrings;
begin
  Result := FSQL[AKind];
end;

procedure T8DMBuilder.SetSQLs(const AKind: K0EntityDataSetType;
  const Value: TStrings);
begin
  FSQL[AKind].Assign(Value);
end;

procedure T8DMBuilder.GenerateSQLs;
var
  i: K0EntityDataSetType;
begin
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    GetQuerySQL(SQLs[i], i);
end;

function T8DMBuilder.GetEntityClassName: string;
begin
  Result := Params.TargetMetaEntity.EtyClassName
end;

function T8DMBuilder.GetDMName: string;
begin
  Result := Params.TargetMetaEntity.DMName;
end;

procedure T8DMBuilder.SetTemplate(const Value: Tdm8EntityTemplate);
begin
  FTemplate := Value;
end;

initialization
  RegisterClass(T8DMBuilder);
  RegisterClass(T8EnumProto);
  RegisterClass(T8EnumProtos);

end.