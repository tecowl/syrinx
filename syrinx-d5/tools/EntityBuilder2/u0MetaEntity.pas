unit u0MetaEntity;

interface

uses
  SysUtils, Classes,
  s0Collection;

type
  T0MetaEntity = class(Ts0CollectionItem)
  private
    FEntityClassCaption: string;
    FEntityClassName: string;
    FTableName: string;
    FBaseName: string;
    FDataModuleUnitName: string;
    FEntityUnitName: string;
    FDataModuleName: string;
    FExists: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    property BaseName: string read FBaseName write FBaseName;
    property DataModuleName: string read FDataModuleName write FDataModuleName; //not class name
    property DataModuleUnitName: string read FDataModuleUnitName write FDataModuleUnitName;
    property EntityClassCaption: string read FEntityClassCaption write FEntityClassCaption;
    property EntityClassName: string read FEntityClassName write FEntityClassName;
    property EntityUnitName: string read FEntityUnitName write FEntityUnitName;
    property TableName: string read FTableName write FTableName;
    property Exists: Boolean read FExists write FExists;
  end;

type
  T0MetaEntities = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): T0MetaEntity;
    procedure SetItems(const Index: Integer; const Value: T0MetaEntity);
  public
    property Items[const Index: Integer]: T0MetaEntity read GetItems write SetItems;
  end;

implementation


{ T0MetaEntity }

procedure T0MetaEntity.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is T0MetaEntity) then Exit;
  FEntityClassCaption := T0MetaEntity(Source).FEntityClassCaption;
  FEntityClassName    := T0MetaEntity(Source).FEntityClassName   ;
  FTableName          := T0MetaEntity(Source).FTableName         ;
  FBaseName           := T0MetaEntity(Source).FBaseName          ;
  FDataModuleUnitName := T0MetaEntity(Source).FDataModuleUnitName;
  FEntityUnitName     := T0MetaEntity(Source).FEntityUnitName    ;
  FDataModuleName     := T0MetaEntity(Source).FDataModuleName    ;
  FExists             := T0MetaEntity(Source).FExists            ;
end;

{ T0MetaEntities }

function T0MetaEntities.GetItems(const Index: Integer): T0MetaEntity;
begin
  Result := T0MetaEntity(inherited Items[Index]);
end;

procedure T0MetaEntities.SetItems(const Index: Integer;
  const Value: T0MetaEntity);
begin
  inherited Items[Index] := Value;
end;

end.
