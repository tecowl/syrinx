unit s8EntitySQL;

interface

uses
  SysUtils, Classes,
  s0Persistent,
  s0DBEntity,
  s0EntityPropProto;

type
  Ts8EntitySQLs = class;
  
  Ts8EntitySQL = class(TStringList)
  private
    FOwner: Ts8EntitySQLs;
    FSQLKind: K0EntityDataSetType;
    procedure SetSQLKind(const Value: K0EntityDataSetType);
  protected
    procedure Changed; override;
  public
    constructor Create(AOwner: Ts8EntitySQLs);
    property SQLKind: K0EntityDataSetType read FSQLKind write SetSQLKind;
  published
    procedure GenerateSQL;
  end;

  Ts8EntitySQLs = class(Ts0Persistent)
  private
    FSQLs: array[K0EntityDataSetType] of Ts8EntitySQL;
    FProtoTypes: Ts0EntityPropProtos;
    function GetSQLs(const Index: K0EntityDataSetType): Ts8EntitySQL;
    procedure SetSQLs(const Index: K0EntityDataSetType; Value: Ts8EntitySQL);
    function GetPublishedSQL(const Index: Integer): Ts8EntitySQL;
    procedure SetPublishedSQL(const Index: Integer; Value: Ts8EntitySQL);
  protected
    function GetEntityName: string; virtual;
    function GetTableName: string; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property SQLs[const Index: K0EntityDataSetType]: Ts8EntitySQL read GetSQLs write SetSQLs; default;
    property ProtoTypes: Ts0EntityPropProtos read FProtoTypes write FProtoTypes;
  published
    property Select    : Ts8EntitySQL index 0 read GetPublishedSQL write SetPublishedSQL;
    property SelectList: Ts8EntitySQL index 1 read GetPublishedSQL write SetPublishedSQL;
    property Insert    : Ts8EntitySQL index 2 read GetPublishedSQL write SetPublishedSQL;
    property Update    : Ts8EntitySQL index 3 read GetPublishedSQL write SetPublishedSQL;
    property Delete    : Ts8EntitySQL index 4 read GetPublishedSQL write SetPublishedSQL;
  published
    procedure GenerateSQLs;
  end;          

implementation

uses
  u8SQLGenerator;

{ Ts8EntitySQL }

procedure Ts8EntitySQL.Changed;
begin
  inherited Changed;
  FOwner.Change;
end;

constructor Ts8EntitySQL.Create(AOwner: Ts8EntitySQLs);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure Ts8EntitySQL.GenerateSQL;
var
  gene: T8SQLGenerator;
begin
  gene := T8SQLGenerator.Create;
  try
    gene.TableName := FOwner.GetTableName;
    gene.EntityName := FOwner.GetEntityName;
    gene.Source := FOwner.ProtoTypes;
    case FSQLKind of
      k0edsDetail : gene.MakeSelect(Self);
      k0edsLoadKey: gene.MakeSelectList(Self);
      k0edsInsert : gene.MakeInsert(Self);
      k0edsUpdate : gene.MakeUpdate(Self);
      k0edsRemove : gene.MakeDelete(Self);
    end;
  finally
    FreeAndNil(gene);
  end;
end;

procedure Ts8EntitySQL.SetSQLKind(const Value: K0EntityDataSetType);
begin
  FSQLKind := Value;
end;

{ Ts8EntitySQLs }

procedure Ts8EntitySQLs.Assign(Source: TPersistent);
var
  i: K0EntityDataSetType;
begin
  inherited;
  if not(Source is Ts8EntitySQLs) then Exit;
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    FSQLs[i].Assign( Ts8EntitySQLs(Source).SQLs[i] );
end;

constructor Ts8EntitySQLs.Create(AOwner: TPersistent);
var
  i: K0EntityDataSetType;
begin
  inherited;
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
  begin
    FSQLs[i] := Ts8EntitySQL.Create(Self);
    FSQLs[i].SQLKind := i;
  end;
end;

destructor Ts8EntitySQLs.Destroy;
var
  i: K0EntityDataSetType;
begin
  inherited;
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    FreeAndNil(FSQLs[i]);
end;

procedure Ts8EntitySQLs.GenerateSQLs;
var
  i: K0EntityDataSetType;
begin
  for i := Low(K0EntityDataSetType) to High(K0EntityDataSetType) do
    SQLs[i].GenerateSQL;
end;

function Ts8EntitySQLs.GetEntityName: string;
begin
  Result := '';
end;

function Ts8EntitySQLs.GetPublishedSQL(const Index: Integer): Ts8EntitySQL;
begin
  Result := GetSQLs( K0EntityDataSetType(Index) );
end;

function Ts8EntitySQLs.GetSQLs(const Index: K0EntityDataSetType): Ts8EntitySQL;
begin
  Result := FSQLs[Index];
end;

function Ts8EntitySQLs.GetTableName: string;
begin
  Result := '';
end;

procedure Ts8EntitySQLs.SetPublishedSQL(const Index: Integer;
  Value: Ts8EntitySQL);
begin
  GetPublishedSQL(Index).Assign(Value);
end;

procedure Ts8EntitySQLs.SetSQLs(const Index: K0EntityDataSetType; Value: Ts8EntitySQL);
begin
  FSQLs[Index].Assign(Value);
end;

initialization
  RegisterClass(Ts8EntitySQL);
  RegisterClass(Ts8EntitySQLs);

finalization
  UnRegisterClass(Ts8EntitySQL);
  UnRegisterClass(Ts8EntitySQLs);
  
end.
