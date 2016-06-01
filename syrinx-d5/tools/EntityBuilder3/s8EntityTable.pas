unit s8EntityTable;

interface

uses
  SysUtils, Classes,
  DB, DBTables,
  s0Persistent,
  s0EntityPropProto,
  s8EntityBDE;

type
  Ts8EntityTableClass = class of Ts8EntityTable;
  Ts8EntityTable = class(Ts0InterfacedPersistent)
  private
    FBDEConnection: Ts8DBDataSetAlias;
    FTable: TTable;
    FProtoTypes: Ts0EntityPropProtos;
    procedure SetTableName(const Value: string);
    procedure SetBDEConnection(const Value: Ts8DBDataSetAlias);
    function GetTableName: string;
    function GetFieldDefs: TFieldDefs;
    function GetIndexDefs: TIndexDefs;
    function GetTableType: TTableType;
    procedure SetFieldDefs(Value: TFieldDefs);
    procedure SetIndexDefs(Value: TIndexDefs);
    procedure SetTableType(const Value: TTableType);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Table: TTable read FTable;
    property ProtoTypes: Ts0EntityPropProtos read FProtoTypes write FProtoTypes;
    procedure LoadProtoFromTable;
  published
    property BDEConnection: Ts8DBDataSetAlias read FBDEConnection write SetBDEConnection;
    property TableName: string read GetTableName write SetTableName;
    property FieldDefs: TFieldDefs read GetFieldDefs write SetFieldDefs;
    property IndexDefs: TIndexDefs read GetIndexDefs write SetIndexDefs;
    property TableType: TTableType read GetTableType write SetTableType;
  published
    procedure ExportToTable;
    procedure CreateTable;
    procedure DeleteTable;
  end;

implementation

uses
  s0ValidationMsg,
  s0FieldHelper;

{ Ts8EntityTable }

procedure Ts8EntityTable.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts8EntityTable) then Exit;
  FTable.TableName := Ts8EntityTable(Source).Table.TableName;
  FBDEConnection.Assign( Ts8EntityTable(Source).FBDEConnection );
end;

constructor Ts8EntityTable.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FTable := TTable.Create(nil);
  FBDEConnection := Ts8DBDataSetAlias.Create(Self);
  FBDEConnection.DataSet := FTable;
end;

resourcestring
  c9ErrMsg_NoTableName = 'TableNameプロパティが設定されていません';
  c9Msg_TableCreated = '"%s"テーブルが作成されました';
  c9Msg_TableDeleted = '"%s"テーブルが削除されました';
  c9Msg_TableNotExists = '"%s"テーブルは存在しません';

procedure Ts8EntityTable.CreateTable;
begin
  if TableName = '' then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg(
      c9ErrMsg_NoTableName,
      k0vrFatalError
    );
    Exit;
  end;
  //
  try
    FTable.CreateTable;
    Ts0GlobalValidationManager.Instance.NewMsg(
      Format(c9Msg_TableCreated, [TableName]),
      k0vrInfomation
    );
  except
    raise;
  end;
end;

procedure Ts8EntityTable.DeleteTable;
begin
  if not FTable.Exists then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg(
      Format(c9Msg_TableNotExists, [TableName]),
      k0vrFatalError
    );
    Exit;
  end;
  //
  try
    FTable.DeleteTable;
    Ts0GlobalValidationManager.Instance.NewMsg(
      Format(c9Msg_TableDeleted, [TableName]),
      k0vrInfomation
    );
  except
    raise;
  end;
end;

destructor Ts8EntityTable.Destroy;
begin
  FreeAndNil(FTable);
  FreeAndNil(FBDEConnection);
  inherited;
end;

function Ts8EntityTable.GetFieldDefs: TFieldDefs;
begin
  Result := FTable.FieldDefs;
end;

function Ts8EntityTable.GetIndexDefs: TIndexDefs;
begin
  Result := FTable.IndexDefs;
end;

function Ts8EntityTable.GetTableName: string;
begin
  Result := FTable.TableName;
end;

function Ts8EntityTable.GetTableType: TTableType;
begin
  Result := FTable.TableType;
end;

resourcestring
  c9ErrMsg_NoFieldName = '"%s"はFieldNameプロパティが設定されていません';
  c9ErrMsg_NoPrimary =
    'Primaryとして指定されたフィールドがありません。' +
    '適切なプロパティのIsIDをチェックしてください';

procedure Ts8EntityTable.ExportToTable;
  procedure PrepareTableFields(ATargetDefs: TFieldDefs; AProtos: Ts0EntityPropProtos);
  var
    i: Integer;
    p: Ts0EntityPropProto;
  begin
    ATargetDefs.Clear;
    for i := 0 to AProtos.Count -1 do
    begin
      p := AProtos.Items[i];
      if p.FieldName = '' then
      begin
        Ts0GlobalValidationManager.Instance.NewMsg(
          Format(c9ErrMsg_NoFieldName, [p.PropertyName]),
          k0vrWarning
        );
      end
      else
        ATargetDefs.Add(p.FieldName, p.FieldType, p.FieldSize, p.IsRequired);
    end;
  end;
  procedure PrepareTableIndexes(ATargetDefs: TIndexDefs; AProtos: Ts0EntityPropProtos);
  var
    idProp: Ts0EntityPropProto;
  begin
    ATargetDefs.Clear;
    idProp := AProtos.IDProp;
    if idProp = nil then
    begin
      Ts0GlobalValidationManager.Instance.NewMsg(
        c9ErrMsg_NoPrimary,
        k0vrWarning
      );
      Exit;
    end;
    ATargetDefs.Add(idProp.FieldName, idProp.FieldName, [ixPrimary]);
  end;
begin
  PrepareTableFields(FieldDefs, FProtoTypes);
  PrepareTableIndexes(IndexDefs,  FProtoTypes);
end;

resourcestring
  c9ErrMsg_CannotOpen_NotExists = '"%s"テーブルが存在しないので、開けませんでした';

procedure Ts8EntityTable.LoadProtoFromTable;
var
  fld: TField;
  p: Ts0EntityPropProto;
  i: Integer;
begin
  if not FTable.Exists then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg(
      Format(c9ErrMsg_CannotOpen_NotExists, [FTable.TableName]),
      k0vrFatalError
    );
    Exit;
  end;
  FTable.Open;
  try
    ProtoTypes.BeginUpdate;
    try
      ProtoTypes.Clear;
      for i := 0 to FTable.Fields.Count -1 do
      begin
        fld := FTable.Fields[i];
        p := ProtoTypes.AddProto;
        p.FieldName := fld.FieldName;
        p.FieldType := fld.DataType;
        p.FieldSize := fld.Size;
        p.Size := p.FieldSize;
        p.PropertyName := p.FieldName;
        p.TypeName :=
          Ts0EntityPropProto.FieldTypeToPropTypeStr(
            Ts0FieldHelper.FieldTypeFromNative(fld.DataType)
          );
        p.JPName := '';
        p.IsRequired := fld.Required;
      end;
    finally
      ProtoTypes.EndUpdate;
    end;
  finally
    FTable.Close;
  end;
end;

procedure Ts8EntityTable.SetBDEConnection(const Value: Ts8DBDataSetAlias);
begin
  FBDEConnection.Assign(Value);
end;

procedure Ts8EntityTable.SetFieldDefs(Value: TFieldDefs);
begin
  FTable.FieldDefs.Assign(Value);
end;

procedure Ts8EntityTable.SetIndexDefs(Value: TIndexDefs);
begin
  FTable.IndexDefs.Assign(Value);
end;

procedure Ts8EntityTable.SetTableName(const Value: string);
begin
  FTable.TableName := Value;
end;

procedure Ts8EntityTable.SetTableType(const Value: TTableType);
begin
  FTable.TableType := Value;
end;

initialization
  RegisterClass(Ts8EntityTable);

finalization
  UnRegisterClass(Ts8EntityTable);

end.
