unit u8MetaEntities;

interface

uses
  SysUtils, Classes,
  s0Classes,
  s0Persistent,
  s0Collection,
  s0EntityPropProto,
  s0Observer,
  //
  s8EntityFile,
  s8EntityBDE,
  s8EntityTable,
  s8EntitySQL,
  s8EnumProto;

type
  T8MetaEntity = class(Ts0CollectionItem)
  private
    FEntityClassCaption: string;
    FBaseName: string;
    FIDConstValue: Integer;
    FIDConstName: string;
    FProtoTypes: Ts0EntityPropProtos;
    FTable: Ts8EntityTable;
    FSQLs: Ts8EntitySQLs;
    FFiles: Ts8EntityFiles;
    FEnums: Ts8EnumProtos;
    FChangeListener: Ts0EventListener;
    procedure SetIDConstValue(const Value: Integer);
    procedure SetBaseName(const Value: string);
    procedure SetProtoTypes(const Value: Ts0EntityPropProtos);
    procedure SetEntityClassCaption(const Value: string);
    procedure SetEntityClassName(const Value: string);
    procedure SetIDConstName(const Value: string);
    procedure SetTable(Value: Ts8EntityTable);
    procedure SetFiles(Value: Ts8EntityFiles);
    procedure SetSQLs(Value: Ts8EntitySQLs);
    procedure SetEnums(const Value: Ts8EnumProtos);
    function GetEntityClassName: string;
  protected
    function NewFiles: Ts8EntityFiles; virtual;
    function NewTable: Ts8EntityTable; virtual;
    function GetDisplayName: string; override;
    procedure PropChanged(Sender: TObject);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function HasUniqueValue: Boolean;
    class procedure SetFilesClass(AClass: Ts8EntityFilesClass);
  published
    property BaseName: string read FBaseName write SetBaseName;
    property EtyClassName: string read GetEntityClassName write SetEntityClassName;
    property EtyClassCaption: string read FEntityClassCaption write SetEntityClassCaption;
    property IDConstName: string read FIDConstName write SetIDConstName;
    property IDConstValue: Integer read FIDConstValue write SetIDConstValue;
  published
    property ProtoTypes: Ts0EntityPropProtos read FProtoTypes write SetProtoTypes;
    property SQLs: Ts8EntitySQLs read FSQLs write SetSQLs;
    property Files: Ts8EntityFiles read FFiles write SetFiles;
    property Table: Ts8EntityTable read FTable write SetTable;
    property Enums: Ts8EnumProtos read FEnums write SetEnums;
  published
    procedure GenerateSQLs;
    procedure GenerateFiles;
    procedure SaveToFiles;
    procedure ExportToTable;
    procedure CreateTable;
    procedure DeleteTable;
  end;

type
  T8MetaEntities = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): T8MetaEntity;
    procedure SetItems(const Index: Integer; const Value: T8MetaEntity);
  protected
    function IsUniqueValue(AItem: T8MetaEntity; Value: Integer): Boolean;
    procedure SetUniqueValue(AItem: T8MetaEntity; Value: Integer);
    procedure Update(Item: TCollectionItem); override;
  public
    function AddTable(ATableName: string): T8MetaEntity;
    function Add(ABaseName, ATableName: string): T8MetaEntity;
    function FindByClassName(AClassName: string): T8MetaEntity;
    function FindByTableName(ATableName: string): T8MetaEntity;
    property Items[const Index: Integer]: T8MetaEntity read GetItems write SetItems;
  published
    procedure SelectFromBDE;
  end;

type
  Tc8MetaEntityManClass = class of Tc8MetaEntityMan;
  Tc8MetaEntityMan = class(TComponent, IUnknown, Is0Modified)
  private
    FEntities: T8MetaEntities;
    FEntityDir: string;
    FIDDefineUnitName: string;
    FFmt_IDConstName: string;
    FModified: Boolean;
    FFmt_ClassName: array[K8EntityFileKind] of string;
    FFmt_UnitName: array[K8EntityFileKind] of string;
    FBDEConnection: Ts8DataBaseAlias;
    procedure SetIDDefineUnitName(const Value: string);
    procedure SetEntities(Value: T8MetaEntities);
    procedure SetFmt_IDConstName(const Value: string);
    function GetFmtClassName(const Index: Integer): string;
    function GetFmtUnitName(const Index: Integer): string;
    procedure SetFmtClassName(const Index: Integer; const Value: string);
    procedure SetFmtUnitName(const Index: Integer; const Value: string);
    procedure SetBDEConnection(Value: Ts8DataBaseAlias);
    function GetModified: Boolean;
    procedure SetModified(const Value: Boolean);
  protected
    function NewEntities: T8MetaEntities; virtual;
    procedure SetEntityDir(const Value: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateEntityDir: Boolean;
  published
    property BDEConnection: Ts8DataBaseAlias read FBDEConnection write SetBDEConnection;
    property EntityDir: string read FEntityDir write SetEntityDir;
    property IDDefineUnitName: string read FIDDefineUnitName write SetIDDefineUnitName;
    property Fmt_IDConstName: string read FFmt_IDConstName write SetFmt_IDConstName;
    property Fmt_EntityClassName   : string index 0 read GetFmtClassName write SetFmtClassName;
    property Fmt_DataModuleName    : string index 1 read GetFmtClassName write SetFmtClassName;
    property Fmt_DetailFormName    : string index 2 read GetFmtClassName write SetFmtClassName;
    property Fmt_ListFormName      : string index 3 read GetFmtClassName write SetFmtClassName;
    //
    property Fmt_EntityUnitName    : string index 0 read GetFmtUnitName  write SetFmtUnitName ;
    property Fmt_DataModuleUnitName: string index 1 read GetFmtUnitName  write SetFmtUnitName ;
    property Fmt_DetailFormUnitName: string index 2 read GetFmtUnitName  write SetFmtUnitName ;
    property Fmt_ListFormUnitName  : string index 3 read GetFmtUnitName  write SetFmtUnitName ;
    property Entities: T8MetaEntities read FEntities write SetEntities;
    //
    property Modified: Boolean read GetModified write SetModified;
  published
    procedure SelectFromBDE; virtual;
    procedure SaveIDConstUnit;
  end;


var
  g8EntityTableClass: Ts8EntityTableClass = Ts8EntityTable;

implementation

uses
  FileCtrl,
  s0ValidationMsg,
  s0TypInfoWrapper;

const
  c9IntToFileKind: array[0..3] of K8EntityFileKind =(
    k8efkEntityUnit,
    k8efkManagerDM,
    k0efkDetailForm,
    k0efkListForm
  );

type
  Ts9DataBaseAlias = class(Ts8DataBaseAlias)
  protected
    procedure Change; override;
  end;

{ Ts9DataBaseAlias }

procedure Ts9DataBaseAlias.Change;
begin
  inherited Change;
  if OwnerObj is Tc8MetaEntityMan then
    Tc8MetaEntityMan(OwnerObj).Modified := True;
end;

type
  Ts9EntitySQLs = class(Ts8EntitySQLs)
  protected
    function GetEntityName: string; override;
    function GetTableName: string; override;
  end;

{ Ts9EntitySQLs }

function Ts9EntitySQLs.GetEntityName: string;
begin
  if OwnerObj is T8MetaEntity then
    Result := T8MetaEntity(OwnerObj).EtyClassName
  else
    Result := '';
end;

function Ts9EntitySQLs.GetTableName: string;
begin
  if OwnerObj is T8MetaEntity then
    Result := T8MetaEntity(OwnerObj).Table.TableName
  else
    Result := '';
end;

{ T8MetaEntity }

procedure T8MetaEntity.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is T8MetaEntity) then Exit;
  FEntityClassCaption := T8MetaEntity(Source).FEntityClassCaption;
  FBaseName           := T8MetaEntity(Source).FBaseName          ;
  FIDConstValue       := T8MetaEntity(Source).FIDConstValue      ;
  FIDConstName        := T8MetaEntity(Source).FIDConstName       ;
  FTable.Assign(T8MetaEntity(Source).FTable);
  FFiles.Assign(T8MetaEntity(Source).FFiles);
  FEnums.Assign(T8MetaEntity(Source).FEnums);
  FSQLs.Assign(T8MetaEntity(Source).FSQLs);
  FProtoTypes.Assign(T8MetaEntity(Source).FProtoTypes);
end;

constructor T8MetaEntity.Create(ACollection: TCollection);
  procedure AttachListener(AEvents: array of Ts0Event);
  var
    i: Integer;
  begin
    for i := Low(AEvents) to High(AEvents) do
      AEvents[i].Attach(FChangeListener);
  end;
begin
  inherited;
  FChangeListener := Ts0EventListener.Create(PropChanged);
  FProtoTypes := Ts0EntityPropProtos.Create(Self, Ts0EntityPropProto);
  FTable := NewTable;
  FFiles := NewFiles;
  FSQLs  := Ts9EntitySQLs.Create(Self);
  FEnums := Ts8EnumProtos.Create(Self, Ts8EnumProto);
  AttachListener([
    FTable.OnChange, FFiles.OnChange, FSQLs.OnChange, FProtoTypes.OnUpdate
  ]);
  //
  FTable.ProtoTypes := Self.ProtoTypes;
  FSQLs.ProtoTypes := Self.ProtoTypes;
  FFiles.ProtoTypes := Self.ProtoTypes;
  FIDConstValue := Index;
  //
  if OwnerComponent is Tc8MetaEntityMan then
  begin
    Table.BDEConnection.SessionName := Tc8MetaEntityMan(OwnerComponent).BDEConnection.SessionName;
    Table.BDEConnection.DataBaseName := Tc8MetaEntityMan(OwnerComponent).BDEConnection.DataBaseName;
  end;
end;

procedure T8MetaEntity.CreateTable;
begin
  Table.CreateTable;
end;

procedure T8MetaEntity.DeleteTable;
begin
  Table.DeleteTable;
end;

destructor T8MetaEntity.Destroy;
begin
  FreeAndNil(FEnums);
  FreeAndNil(FSQLs);
  FreeAndNil(FFiles);
  FreeAndNil(FTable);
  FreeAndNil(FProtoTypes);
  FreeAndNil(FChangeListener);
  inherited Destroy;
end;

procedure T8MetaEntity.ExportToTable;
begin
  Table.ExportToTable;
end;

procedure T8MetaEntity.GenerateFiles;
begin
  Files.GenerateFiles;
end;

procedure T8MetaEntity.GenerateSQLs;
begin
  SQLs.GenerateSQLs;
end;

function T8MetaEntity.GetDisplayName: string;
begin
  Result := EtyClassName;
  if Result <> '' then Exit;
  Result := BaseName;
  if Result <> '' then Exit;
  Result := 'New Entity';
//  if Result <> '' then Exit;
//  Result := inherited GetDisplayName;
end;

function T8MetaEntity.GetEntityClassName: string;
begin
  Result := '';
  if Files = nil then Exit;
  if Files.EntityUnit = nil then Exit;
  Result := Files.EntityUnit.UnitClass;
end;

function T8MetaEntity.HasUniqueValue: Boolean;
begin
  Result := False;
  if Collection is T8MetaEntities then
    Result := T8MetaEntities(Collection).IsUniqueValue(Self, IDConstValue);
end;

var
  g9FilesClass: Ts8EntityFilesClass = Ts8EntityFiles;

function T8MetaEntity.NewFiles: Ts8EntityFiles;
begin
  Result := g9FilesClass.Create(Self);
end;

function T8MetaEntity.NewTable: Ts8EntityTable;
begin
  Result := g8EntityTableClass.Create(Self);
end;

procedure T8MetaEntity.PropChanged(Sender: TObject);
begin
  Changed(False);
end;

procedure T8MetaEntity.SaveToFiles;
begin
  Files.SaveToFiles;
end;

procedure T8MetaEntity.SetBaseName(const Value: string);
  procedure SetFileNamesByManagerFormats;
  var
    i: K8EntityFileKind;
    f: Ts8EntityFile;
    m: Tc8MetaEntityMan;
  begin
    if not(OwnerComponent is Tc8MetaEntityMan) then Exit;
    m := Tc8MetaEntityMan(OwnerComponent);
    for i := Low(K8EntityFileKind) to High(K8EntityFileKind) do
    begin
      f := Files[i];
      f.UnitClass := Format(m.FFmt_ClassName[i], [FBaseName]);
      f.UnitName  := Format(m.FFmt_UnitName[i], [FBaseName]);
    end;
    FIDConstName := Format(m.Fmt_IDConstName, [FBaseName]);
  end;
begin
  if FBaseName = Value then Exit;
  if Table.TableName = FBaseName then
    Table.TableName := Value;
  FBaseName := Value;
  SetFileNamesByManagerFormats;
  Changed(False);
end;

procedure T8MetaEntity.SetEntityClassCaption(const Value: string);
begin
  if FEntityClassCaption = Value then Exit;
  FEntityClassCaption := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetEntityClassName(const Value: string);
begin
  if Files = nil then Exit;
  if Files.EntityUnit = nil then Exit;
  Files.EntityUnit.UnitClass := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetEnums(const Value: Ts8EnumProtos);
begin
  FEnums.Assign(Value);
  Changed(False);
end;

procedure T8MetaEntity.SetFiles(Value: Ts8EntityFiles);
begin
  FFiles.Assign(Value);
  Changed(False);
end;

class procedure T8MetaEntity.SetFilesClass(AClass: Ts8EntityFilesClass);
begin
  g9FilesClass := AClass;
end;

procedure T8MetaEntity.SetIDConstName(const Value: string);
begin
  if FIDConstName = Value then Exit;
  FIDConstName := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetIDConstValue(const Value: Integer);
begin
  if (FIDConstValue = Value) and HasUniqueValue then Exit;
  if Collection is T8MetaEntities then
    T8MetaEntities(Collection).SetUniqueValue(Self, Value);
end;

procedure T8MetaEntity.SetProtoTypes(const Value: Ts0EntityPropProtos);
begin
  FProtoTypes.Assign(Value);
  Changed(False);
end;

procedure T8MetaEntity.SetSQLs(Value: Ts8EntitySQLs);
begin
  FSQLs.Assign(Value);
  Changed(False);
end;

procedure T8MetaEntity.SetTable(Value: Ts8EntityTable);
begin
  FTable.Assign(Value);
  Changed(False);
end;

{ T8MetaEntities }

function T8MetaEntities.Add(ABaseName, ATableName: string): T8MetaEntity;
begin
  Result := T8MetaEntity(inherited Add);
  Result.Table.TableName := ATableName;
  Result.BaseName := ABaseName;
end;

function T8MetaEntities.AddTable(ATableName: string): T8MetaEntity;
begin
  Result := FindByTableName(ATableName);
  if Result <> nil then Exit;
  Result := Add(ATableName, ATableName);
  Result.Table.LoadProtoFromTable;
end;

function T8MetaEntities.FindByClassName(AClassName: string): T8MetaEntity;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if AnsiCompareText(Items[i].EtyClassName, AClassName) = 0 then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function T8MetaEntities.FindByTableName(ATableName: string): T8MetaEntity;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if AnsiCompareText(Items[i].Table.TableName, ATableName) = 0 then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function T8MetaEntities.GetItems(const Index: Integer): T8MetaEntity;
begin
  Result := T8MetaEntity(inherited Items[Index]);
end;

function T8MetaEntities.IsUniqueValue(AItem: T8MetaEntity;
  Value: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Self.Count -1 do
  begin
    if Items[i] = AItem then Continue;
    if Items[i].IDConstValue = Value then
      Exit;
  end;
  Result := True;
end;

procedure T8MetaEntities.SelectFromBDE;
begin
  if OwnerComponent is Tc8MetaEntityMan then
    Tc8MetaEntityMan(OwnerComponent).SelectFromBDE;
end;

procedure T8MetaEntities.SetItems(const Index: Integer;
  const Value: T8MetaEntity);
begin
  inherited Items[Index] := Value;
end;

procedure T8MetaEntities.SetUniqueValue(AItem: T8MetaEntity; Value: Integer);
var
  i: Integer;
  curr: T8MetaEntity;
begin
  for i := Self.Count -1 downto 0 do
  begin
    curr := Items[i];
    if curr = AItem then Continue;
    if curr.IDConstValue = Value then
      Self.SetUniqueValue(curr, Value + 1);
  end;
  AItem.FIDConstValue := Value;
  Update(nil);
end;

procedure T8MetaEntities.Update(Item: TCollectionItem);
begin
  inherited;
  if OwnerComponent is Tc8MetaEntityMan then
    Tc8MetaEntityMan(OwnerComponent).Modified := True;
end;

{ Tc8MetaEntityMan }

const
  c9FmtClassName: array[K8EntityFileKind] of string = (
    'Te8%s' ,
    'dm8%s',
    'frm8%sDetail',
    'frm8%sList'
  );

  c9FmtUnitName: array[K8EntityFileKind] of string = (
    'e8%s' ,
    'd8%s' ,
    'f8%sDetail',
    'f8%sList'
  );

constructor Tc8MetaEntityMan.Create(AOwner: TComponent);
  procedure SetFormatDefaults;
  var
    i: K8EntityFileKind;
  begin
    for i := Low(K8EntityFileKind) to High(K8EntityFileKind) do
    begin
      FFmt_ClassName[i] := c9FmtClassName[i];
      FFmt_UnitName[i]  := c9FmtUnitName[i];
    end;
  end;
begin
  inherited;
  FBDEConnection := Ts9DataBaseAlias.Create(Self);
  FEntities := NewEntities;
  FIDDefineUnitName := 'u8EntityIDs';
  FFmt_IDConstName := 'c8EtyID_%s';
  SetFormatDefaults;
end;

destructor Tc8MetaEntityMan.Destroy;
begin
  FreeAndNil(FBDEConnection);
  FreeAndNil(FEntities);
  inherited;
end;

function Tc8MetaEntityMan.GetFmtClassName(const Index: Integer): string;
begin
  Result := FFmt_ClassName[ c9IntToFileKind[Index] ];
end;

function Tc8MetaEntityMan.GetFmtUnitName(const Index: Integer): string;
begin
  Result := FFmt_UnitName[ c9IntToFileKind[Index] ];
end;

function Tc8MetaEntityMan.GetModified: Boolean;
begin
  Result := FModified;
end;

function Tc8MetaEntityMan.NewEntities: T8MetaEntities;
begin
  Result := T8MetaEntities.Create(Self, T8MetaEntity);
end;

procedure Tc8MetaEntityMan.SaveIDConstUnit;
var
  sl: TStringList;
  i: Integer;
  ety: T8MetaEntity;
begin
  if not ValidateEntityDir then Exit;
  sl := TStringList.Create;
  try
    sl.Add('unit ' + IDDefineUnitName +';');
    sl.Add('');
    sl.Add('interface');
    sl.Add('');
    sl.Add('const');
    for i := 0 to Entities.Count -1 do
    begin
      ety := Entities.Items[i];
      if ety.EtyClassName = '' then Continue;
      if ety.IDConstName = '' then Continue;
      sl.Add(
        Format('  %s = %d;  { %s }', [
          ety.IDConstName, ety.IDConstValue, ety.EtyClassName
        ])
      );
    end;
    sl.Add('');
    sl.Add('implementation');
    sl.Add('');
    sl.Add('end.');
    //
    sl.SaveToFile(
      IncludeTrailingBackslash(EntityDir) +
      ChangeFileExt(IDDefineUnitName, '.pas')
    );
  finally
    FreeAndNil(sl);
  end;
end;


procedure Tc8MetaEntityMan.SelectFromBDE;
begin
end;

procedure Tc8MetaEntityMan.SetBDEConnection(Value: Ts8DataBaseAlias);
begin
  FBDEConnection.Assign( Value );
end;

procedure Tc8MetaEntityMan.SetEntities(Value: T8MetaEntities);
begin
  FEntities.Assign(Value);
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetEntityDir(const Value: string);
begin
  if FEntityDir = Value then Exit;
  FEntityDir := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmtClassName(const Index: Integer;
  const Value: string);
begin
  FFmt_ClassName[ c9IntToFileKind[Index] ] := Value;
end;

procedure Tc8MetaEntityMan.SetFmtUnitName(const Index: Integer;
  const Value: string);
begin
  FFmt_UnitName[ c9IntToFileKind[Index] ] := Value;
end;

procedure Tc8MetaEntityMan.SetFmt_IDConstName(const Value: string);
begin
  if FFmt_IDConstName = Value then Exit;
  FFmt_IDConstName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetIDDefineUnitName(const Value: string);
begin
  if FIDDefineUnitName = Value then Exit;
  FIDDefineUnitName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetModified(const Value: Boolean);
begin
  FModified := Value;
end;

function Tc8MetaEntityMan.ValidateEntityDir: Boolean;
begin
  Result := False;
  if Trim(FEntityDir) = '' then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg('EntityDirÇ™éwíËÇ≥ÇÍÇƒÇ¢Ç‹ÇπÇÒÅB', k0vrFatalError);
    Exit;
  end;
  if not DirectoryExists(FEntityDir) then
  begin
    Ts0GlobalValidationManager.Instance.NewMsg('EntityDirÇÕë∂ç›ÇµÇ‹ÇπÇÒÅB', k0vrFatalError);
    Exit;
  end;
  Result := True;
end;

initialization
  RegisterClass(T8MetaEntity);
  RegisterClass(T8MetaEntities);
  RegisterClass(Tc8MetaEntityMan);
  RegisterClass(Ts9EntitySQLs);

finalization
  UnRegisterClass(T8MetaEntity);
  UnRegisterClass(T8MetaEntities);
  UnRegisterClass(Tc8MetaEntityMan);
  UnRegisterClass(Ts9EntitySQLs);

end.
