unit s8EntityUnitWriter;

interface

uses
  SysUtils, Classes,
  u8MetaEntities,
  u0SXMetaClass,
  s0EntityPropProto;

type
  Ts8EntityUnitWriterClass = class of Ts8EntityUnitWriter;
  Ts8EntityUnitWriter = class
  private
    FProj: Tc0SXProject;
    FMetaUnit: T0SXMetaUnit;
    FProtoTypes: Ts0EntityPropProtos;
  protected
    FDestPas: TStrings;
    procedure InitWriter; virtual;
    procedure InitUnit; virtual;
    procedure WritePas; 
    property MetaUnit: T0SXMetaUnit read FMetaUnit;
  public
    constructor Create(AProj: Tc0SXProject; AUnitName: string); virtual;
    destructor Destroy; override;
    procedure Execute; virtual;
    procedure InitByMetaEntity(AEntity: T8MetaEntity); virtual;
    property ProtoTypes: Ts0EntityPropProtos read FProtoTypes write FProtoTypes;
  end;

implementation

uses
  u0SXMetaClassWriter;


{ Ts8EntityUnitWriter }

constructor Ts8EntityUnitWriter.Create(AProj: Tc0SXProject; AUnitName: string);
begin
  inherited Create;
  FProj := AProj;
  FMetaUnit := AProj.Units.AddUnit(AUnitName);
  InitWriter;     
end;

destructor Ts8EntityUnitWriter.Destroy;
begin
  inherited Destroy;
end;

procedure Ts8EntityUnitWriter.Execute;
begin
end;

procedure Ts8EntityUnitWriter.InitByMetaEntity(AEntity: T8MetaEntity);
begin
end;

procedure Ts8EntityUnitWriter.InitUnit;
begin
end;

procedure Ts8EntityUnitWriter.InitWriter;
begin
end;

procedure Ts8EntityUnitWriter.WritePas;
var
  writer: T0SXMetaClassWriter;
begin
  writer := T0SXMetaClassWriter.Create;
  try
    FMetaUnit.RefreshSequence;
    writer.Execute( FMetaUnit );
    FDestPas.Assign(writer.Dest);
  finally
    FreeAndNil(writer);
  end;
end;

end.
