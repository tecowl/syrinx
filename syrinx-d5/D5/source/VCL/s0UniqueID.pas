unit s0UniqueID;

interface

uses
  SysUtils, Classes, 
  s0VCLClasses,
  DB, s0Query;

type
  Ts0UniqueID = class(Ts0VCLComponent)
  private
    FIDName: string;
    FQuery: Ts0Query;
    FSQL: string;
    FSQLFormat: string;
    FStepCount: Integer;
    FTableName: string;
    function GetDataBaseName: string;
    function GetSessionName: string;
    procedure SetDataBaseName(const Value: string);
    procedure SetIDName(const Value: string);
    procedure SetSessionName(const Value: string);
    procedure SetSQL(const Value: string);
    procedure SetSQLFormat(const Value: string);
    procedure SetStepCount(const Value: Integer);
    procedure SetTableName(const Value: string);
  protected
    procedure ReformSQL(AFormat, ATableName, AIDName: string; AStepCount: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function NewID: Integer;
  published
    property DataBaseName: string read GetDataBaseName write SetDataBaseName;
    property IDName: string read FIDName write SetIDName;
    property SessionName: string read GetSessionName write SetSessionName;
    property SQL: string read FSQL write SetSQL;
    property SQLFormat: string read FSQLFormat write SetSQLFormat;
    property StepCount: Integer read FStepCount write SetStepCount default 1;
    property TableName: string read FTableName write SetTableName;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P DM', [Ts0UniqueID]);
end;

{ Ts0UniqueID }

constructor Ts0UniqueID.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStepCount := 1;
  FQuery := Ts0Query.Create(nil);
  FSQLFormat := 'SELECT GEN_ID(<IDName>, <StepCount>) FROM <TableName>';
  FTableName := 'rdb$database';
end;

destructor Ts0UniqueID.Destroy;
begin
  FreeAndNil(FQuery);
  inherited Destroy;
end;

function Ts0UniqueID.GetDataBaseName: string;
begin
  Result := FQuery.DatabaseName;
end;

function Ts0UniqueID.GetSessionName: string;
begin
  Result := FQuery.SessionName;
end;

function Ts0UniqueID.NewID: Integer;
begin
  if FQuery.SQL.Text <> Self.SQL then
    FQuery.SQL.Text := Self.SQL;
  FQuery.Open;
  try
    Result :=  FQuery.Fields[0].AsInteger;
  finally
    FQuery.Close;
  end;
end;

procedure Ts0UniqueID.ReformSQL(AFormat, ATableName, AIDName: string; AStepCount: Integer);
var
  s: string;
begin
  s := AFormat;
  s := StringReplace(s, '<TableName>', ATableName, [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, '<IDName>'   , AIDName   , [rfReplaceAll, rfIgnoreCase]);
  s := StringReplace(s, '<StepCount>', IntToStr(AStepCount), [rfReplaceAll, rfIgnoreCase]);
  SQL := s;
end;

procedure Ts0UniqueID.SetDataBaseName(const Value: string);
begin
  FQuery.DatabaseName := Value;
end;

procedure Ts0UniqueID.SetIDName(const Value: string);
begin
  ReformSQL(SQLFormat, TableName, Value, StepCount);
  FIDName := Value;
end;

procedure Ts0UniqueID.SetSessionName(const Value: string);
begin
  FQuery.SessionName := Value;
end;

procedure Ts0UniqueID.SetSQL(const Value: string);
begin
  FSQL := Value;
end;

procedure Ts0UniqueID.SetSQLFormat(const Value: string);
begin
  ReformSQL(Value, TableName, IDName, StepCount);
  FSQLFormat := Value;
end;

procedure Ts0UniqueID.SetStepCount(const Value: Integer);
begin
  ReformSQL(SQLFormat, TableName, IDName, Value);
  FStepCount := Value;
end;

procedure Ts0UniqueID.SetTableName(const Value: string);
begin
  ReformSQL(SQLFormat, Value, IDName, StepCount);
  FTableName := Value;
end;

end.
 
