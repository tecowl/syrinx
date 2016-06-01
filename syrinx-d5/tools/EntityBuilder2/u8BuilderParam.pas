unit u8BuilderParam;

interface

uses
  SysUtils, Classes, DB,
  s0EntityPropProto,
  u8MetaEntities;

type
  T8BuilderParam = class(TPersistent)
  private
    FTargetMetaEntity: T8MetaEntity;
    FIDDefineUnitName: string;
    FDataBaseName: string;
    FSessionName: string;
    FProtoTypes: Ts0EntityPropProtos;
    function GetProtoTypes: Ts0EntityPropProtos;
  public
    property ProtoTypes: Ts0EntityPropProtos read GetProtoTypes write FProtoTypes;
  published
    property SessionName: string read FSessionName write FSessionName;
    property DataBaseName: string read FDataBaseName write FDataBaseName;
    property TargetMetaEntity: T8MetaEntity read FTargetMetaEntity write FTargetMetaEntity;
    property IDDefineUnitName: string read FIDDefineUnitName write FIDDefineUnitName;
  end;

implementation

{ T8BuilderParam }

function T8BuilderParam.GetProtoTypes: Ts0EntityPropProtos;
begin
  if FProtoTypes = nil then
    Result := FTargetMetaEntity.ProtoTypes
  else
    Result := FProtoTypes;
end;

end.
