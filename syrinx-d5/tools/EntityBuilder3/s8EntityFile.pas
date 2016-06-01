unit s8EntityFile;

interface

uses
  SysUtils, Classes,
  s0Persistent,
  s0EntityPropProto;

type
  K8EntityFileKind = (
    k8efkEntityUnit,
    k8efkManagerDM,
    k0efkDetailForm,
    k0efkListForm
  );
  K8EntityFileKindSet = set of K8EntityFileKind;

type
  Ts8EntityFile = class(Ts0InterfacedPersistent)
  private
    FUnitClass: string;
    FUnitName: string;
    FKind: K8EntityFileKind;
    FDfmLines: TStrings;
    FPasLines: TStrings;
    procedure SetDfmLines(const Value: TStrings);
    procedure SetPasLines(const Value: TStrings);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Kind: K8EntityFileKind read FKind write FKind;
    procedure SaveAs(Source: TStrings; AFileName: string);
  published
    property UnitName: string read FUnitName write FUnitName;
    property UnitClass: string read FUnitClass write FUnitClass;
    property PasLines: TStrings read FPasLines write SetPasLines;
    property DfmLines: TStrings read FDfmLines write SetDfmLines;
  published
    procedure SaveToFile;
  end;

type
  Ts8EntityFilesClass = class of Ts8EntityFiles;
  Ts8EntityFiles = class(Ts0InterfacedPersistent)
  private
    FFiles: array[K8EntityFileKind] of Ts8EntityFile;
    FSaveFileKinds: K8EntityFileKindSet;
    FProtoTypes: Ts0EntityPropProtos;
    function GetFiles(const Index: K8EntityFileKind): Ts8EntityFile;
    procedure SetFiles(const Index: K8EntityFileKind; Value: Ts8EntityFile);
    function GetPublishedFiles(const Index: Integer): Ts8EntityFile;
    procedure SetPublishedFiles(const Index: Integer; Value: Ts8EntityFile);
    procedure SetSaveFileKinds(const Value: K8EntityFileKindSet);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Files[const Index: K8EntityFileKind]: Ts8EntityFile read GetFiles write SetFiles; default;
    property ProtoTypes: Ts0EntityPropProtos read FProtoTypes write FProtoTypes;
    function ConfirmSaveFile(AFileName: string): Boolean; virtual;
  published
    property SaveFileKinds: K8EntityFileKindSet read FSaveFileKinds write SetSaveFileKinds
      default [k8efkEntityUnit, k8efkManagerDM, k0efkDetailForm, k0efkListForm];
    property EntityUnit: Ts8EntityFile index 0 read GetPublishedFiles write SetPublishedFiles;
    property ManagerDM : Ts8EntityFile index 1 read GetPublishedFiles write SetPublishedFiles;
    property DetailForm: Ts8EntityFile index 2 read GetPublishedFiles write SetPublishedFiles;
    property ListForm  : Ts8EntityFile index 3 read GetPublishedFiles write SetPublishedFiles;
  published
    procedure GenerateFiles;
    procedure SaveToFiles;
  end;

implementation

uses
  u8EntityUnitBuilder,
  u8DMBuilder,
  u8DetailFormBuilder,
  u8ListFormBuilder,
  //
  s0FileNameHelper,
  s0ValidationMsg,
  u0SXMetaClass,
  u8MetaEntities,
  s8EntityUnitWriter;

{ Ts8EntityFile }

procedure Ts8EntityFile.Assign(Source: TPersistent);
var
  src: Ts8EntityFile;
begin
  inherited Assign(Source);
  if not(Source is Ts8EntityFile) then Exit; 
  src := Ts8EntityFile(Source);
  FUnitClass := src.FUnitClass;
  FUnitName  := src.FUnitName ;
  FKind      := src.FKind     ;
  FDfmLines.Assign( src.FDfmLines );
  FPasLines.Assign( src.FPasLines );
end;

constructor Ts8EntityFile.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FPasLines := TStringList.Create;
  FDfmLines := TStringList.Create;
end;

destructor Ts8EntityFile.Destroy;
begin
  FreeAndNil(FDfmLines);
  FreeAndNil(FPasLines);
  inherited;
end;

procedure Ts8EntityFile.SaveAs(Source: TStrings; AFileName: string);
begin
  if OwnerObj is Ts8EntityFiles then
    if not Ts8EntityFiles(OwnerObj).ConfirmSaveFile(AFileName) then Exit;
  Source.SaveToFile(AFileName);
end;

procedure Ts8EntityFile.SaveToFile;
  function GetEntity: T8MetaEntity;
  begin
    Result := nil;
    if not(OwnerObj is Ts8EntityFiles) then Exit;
    if not(Ts8EntityFiles(OwnerObj).OwnerObj is T8MetaEntity) then Exit;
    Result := T8MetaEntity(Ts8EntityFiles(OwnerObj).OwnerObj);
  end;
var
  ety: T8MetaEntity;
  fileName: String;
begin
  if UnitName = '' then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg('ユニット名が指定されていません', k0vrFatalError);
    Exit;
  end;
  ety := GetEntity;
  Assert(ety <> nil);
  Assert(ety.OwnerComponent is Tc8MetaEntityMan);
  if not Tc8MetaEntityMan(ety.OwnerComponent).ValidateEntityDir then Exit;
  fileName :=
    IncludeTrailingPathDelimiter(Tc8MetaEntityMan(ety.OwnerComponent).EntityDir) +
    UnitName;
  SaveAs(PasLines, ChangeFileExt(fileName, '.pas'));
  if FKind <> k8efkEntityUnit then
    SaveAs(DfmLines, ChangeFileExt(fileName, '.dfm'));
end;

procedure Ts8EntityFile.SetDfmLines(const Value: TStrings);
begin
  FDfmLines.Assign(Value);
end;

procedure Ts8EntityFile.SetPasLines(const Value: TStrings);
begin
  FPasLines.Assign(Value);
end;

{ Ts8EntityFiles }

procedure Ts8EntityFiles.Assign(Source: TPersistent);
var
  i: K8EntityFileKind;
begin
  inherited;
  if not(Source is Ts8EntityFiles) then Exit;
  for i := Low(K8EntityFileKind) to High(K8EntityFileKind) do
    FFiles[i].Assign( Ts8EntityFiles(Source).Files[i] );
end;

function Ts8EntityFiles.ConfirmSaveFile(AFileName: string): Boolean;
begin
  Result := not FileExists(AFileName);
end;

constructor Ts8EntityFiles.Create(AOwner: TPersistent);
var
  i: K8EntityFileKind;
begin
  inherited Create(AOwner);
  FSaveFileKinds := [k8efkEntityUnit, k8efkManagerDM, k0efkDetailForm, k0efkListForm];
  for i := Low(K8EntityFileKind) to High(K8EntityFileKind) do
  begin
    FFiles[i] := Ts8EntityFile.Create(Self);
    FFiles[i].Kind := i;
    FFiles[i].NotifyChangeToOwner := True;
  end;
end;

destructor Ts8EntityFiles.Destroy;
var
  i: K8EntityFileKind;
begin
  for i := Low(K8EntityFileKind) to High(K8EntityFileKind) do
    FreeAndNil( FFiles[i] );
  inherited;
end;

procedure Ts8EntityFiles.GenerateFiles;
  function WriteUnit(AKind: K8EntityFileKind; AProj: Tc0SXProject;
    AProtos: Ts0EntityPropProtos): Ts8EntityUnitWriter;
  const
    c9WriterClasses: array[K8EntityFileKind] of Ts8EntityUnitWriterClass = (
      T8EntityUnitBuilder, T8DMBuilder, T8DetailFormBuilder, T8ListFormBuilder
    );
  begin
    Result := c9WriterClasses[AKind].Create(AProj, Files[AKind].UnitName);
    Assert(OwnerObj is T8MetaEntity);
    Result.InitByMetaEntity( T8MetaEntity(OwnerObj) );
    Result.ProtoTypes := AProtos;
    Result.Execute;
  end;
var
  proj: Tc0SXProject;
  dmWriter: Ts8EntityUnitWriter;
  templateProto: Ts0EntityPropProtos;
begin
  proj := Tc0SXProject.Create(nil);
  try
    dmWriter := WriteUnit(k8efkManagerDM, proj, Self.ProtoTypes);
    templateProto := T8DMBuilder(dmWriter).Template.EntityManager.ProtoTypes;
    WriteUnit(k8efkEntityUnit, proj, templateProto);
    WriteUnit(k0efkDetailForm, proj, templateProto);
    WriteUnit(k0efkListForm  , proj, templateProto);      
  finally
    FreeAndNil(proj);
  end;
end;

function Ts8EntityFiles.GetFiles(
  const Index: K8EntityFileKind): Ts8EntityFile;
begin
  Result := FFiles[Index];
end;

function Ts8EntityFiles.GetPublishedFiles(
  const Index: Integer): Ts8EntityFile;
begin
  Result := GetFiles( K8EntityFileKind(Index) );
end;

procedure Ts8EntityFiles.SaveToFiles;
var
  i: K8EntityFileKind;
begin
  for i := Low(K8EntityFileKind) to High(K8EntityFileKind) do
    if i in FSaveFileKinds then
      Files[i].SaveToFile;
end;

procedure Ts8EntityFiles.SetFiles(const Index: K8EntityFileKind;
  Value: Ts8EntityFile);
begin
  FFiles[Index].Assign(Value);
end;

procedure Ts8EntityFiles.SetPublishedFiles(const Index: Integer;
  Value: Ts8EntityFile);
begin
  GetPublishedFiles(Index).Assign( Value );
end;

procedure Ts8EntityFiles.SetSaveFileKinds(
  const Value: K8EntityFileKindSet);
begin
  FSaveFileKinds := Value;
end;

initialization
  RegisterClass(Ts8EntityFile);
  RegisterClass(Ts8EntityFiles);

finalization
  UnRegisterClass(Ts8EntityFile);
  UnRegisterClass(Ts8EntityFiles);
  
end.
