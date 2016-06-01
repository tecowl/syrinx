unit u8MetaEntities;

interface

uses
  SysUtils, Classes,
  s0Collection,
  s0EntityPropProto;

type
  T8MetaEntity = class(Ts0CollectionItem)
  private
    FEntityClassCaption: string;
    FEntityClassName: string;
    FTableName: string;
    FBaseName: string;
    FDataModuleUnitName: string;
    FEntityUnitName: string;
    FDataModuleName: string;
    FSourceExists: Boolean;
    FIDConstValue: Integer;
    FIDConstName: string;
    FTableExists: Boolean;
    FDetailFormUnitName: string;
    FListFormName: string;
    FDetailFormName: string;
    FListFormUnitName: string;
    FProtoTypes: Ts0EntityPropProtos;
    procedure SetIDConstValue(const Value: Integer);
    procedure SetBaseName(const Value: string);
    procedure SetProtoTypes(const Value: Ts0EntityPropProtos);
    procedure SetDataModuleName(const Value: string);
    procedure SetDataModuleUnitName(const Value: string);
    procedure SetDetailFormName(const Value: string);
    procedure SetDetailFormUnitName(const Value: string);
    procedure SetEntityClassCaption(const Value: string);
    procedure SetEntityClassName(const Value: string);
    procedure SetEntityUnitName(const Value: string);
    procedure SetIDConstName(const Value: string);
    procedure SetListFormName(const Value: string);
    procedure SetListFormUnitName(const Value: string);
    procedure SetSourceExists(const Value: Boolean);
    procedure SetTableExists(const Value: Boolean);
    procedure SetTableName(const Value: string);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function HasUniqueValue: Boolean;
  published
    property BaseName: string read FBaseName write SetBaseName;
    property EtyClassCaption: string read FEntityClassCaption write SetEntityClassCaption;
    //
    property TableName: string read FTableName write SetTableName;
    property IDConstName: string read FIDConstName write SetIDConstName;
    property IDConstValue: Integer read FIDConstValue write SetIDConstValue;
    property TableExists: Boolean read FTableExists write SetTableExists;
    property SourceExists: Boolean read FSourceExists write SetSourceExists;
    //
    property DMName: string read FDataModuleName write SetDataModuleName; //not class name
    property DMUnitName: string read FDataModuleUnitName write SetDataModuleUnitName;
    property EtyClassName: string read FEntityClassName write SetEntityClassName;
    property EtyUnitName: string read FEntityUnitName write SetEntityUnitName;
    //
    property DetailFormName: string read FDetailFormName write SetDetailFormName;
    property DetailFormUnitName: string read FDetailFormUnitName write SetDetailFormUnitName;
    property ListFormName: string read FListFormName write SetListFormName;
    property ListFormUnitName: string read FListFormUnitName write SetListFormUnitName;
    //
    property ProtoTypes: Ts0EntityPropProtos read FProtoTypes write SetProtoTypes;
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
    function Add(ABaseName, ATableName: string): T8MetaEntity;
    function FindByClassName(AClassName: string): T8MetaEntity;
    function FindByTableName(ATableName: string): T8MetaEntity;
    property Items[const Index: Integer]: T8MetaEntity read GetItems write SetItems;
  end;

type
  Tc8MetaEntityMan =class(TComponent)
  private
    FEntities: T8MetaEntities;
    FFmt_DataModuleUnitName: string;
    FFmt_DataModuleName: string;
    FFmt_EntityUnitName: string;
    FFmt_EntityClassName: string;
    FEntityDir: string;
    FBDEAliasName: string;
    FIDDefineUnitName: string;
    FFmt_IDConstName: string;
    FFmt_DetailFormUnitName: string;
    FFmt_ListFormName: string;
    FFmt_DetailFormName: string;
    FFmt_ListFormUnitName: string;
    FModified: Boolean;
    procedure SetEntities(const Value: T8MetaEntities);
    procedure SetBDEAliasName(const Value: string);
    procedure SetFmt_DataModuleName(const Value: string);
    procedure SetFmt_DataModuleUnitName(const Value: string);
    procedure SetFmt_DetailFormName(const Value: string);
    procedure SetFmt_DetailFormUnitName(const Value: string);
    procedure SetFmt_EntityClassName(const Value: string);
    procedure SetFmt_EntityUnitName(const Value: string);
    procedure SetFmt_IDConstName(const Value: string);
    procedure SetFmt_ListFormName(const Value: string);
    procedure SetFmt_ListFormUnitName(const Value: string);
    procedure SetIDDefineUnitName(const Value: string);
  protected
    function NewEntities: T8MetaEntities; virtual;
    procedure SetEntityDir(const Value: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Modified: Boolean read FModified write FModified;
  published
    property Entities: T8MetaEntities read FEntities write SetEntities;
    property BDEAliasName: string read FBDEAliasName write SetBDEAliasName;
    property EntityDir: string read FEntityDir write SetEntityDir;
    property IDDefineUnitName: string read FIDDefineUnitName write SetIDDefineUnitName;
    property Fmt_IDConstName: string read FFmt_IDConstName write SetFmt_IDConstName;
    property Fmt_EntityClassName: string read FFmt_EntityClassName write SetFmt_EntityClassName;
    property Fmt_EntityUnitName: string read FFmt_EntityUnitName write SetFmt_EntityUnitName;
    property Fmt_DataModuleName: string read FFmt_DataModuleName write SetFmt_DataModuleName;
    property Fmt_DataModuleUnitName: string read FFmt_DataModuleUnitName write SetFmt_DataModuleUnitName;
    property Fmt_DetailFormName: string read FFmt_DetailFormName write SetFmt_DetailFormName;
    property Fmt_DetailFormUnitName: string read FFmt_DetailFormUnitName write SetFmt_DetailFormUnitName;
    property Fmt_ListFormName: string read FFmt_ListFormName write SetFmt_ListFormName;
    property Fmt_ListFormUnitName: string read FFmt_ListFormUnitName write SetFmt_ListFormUnitName;
  end;


type
  E8MetaEntityException = class(Exception); 

implementation

uses
  s0TypInfoWrapper;

{ T8MetaEntity }

procedure T8MetaEntity.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is T8MetaEntity) then Exit;
  FEntityClassCaption := T8MetaEntity(Source).FEntityClassCaption;
  FEntityClassName    := T8MetaEntity(Source).FEntityClassName   ;
  FTableName          := T8MetaEntity(Source).FTableName         ;
  FBaseName           := T8MetaEntity(Source).FBaseName          ;
  FDataModuleUnitName := T8MetaEntity(Source).FDataModuleUnitName;
  FEntityUnitName     := T8MetaEntity(Source).FEntityUnitName    ;
  FDataModuleName     := T8MetaEntity(Source).FDataModuleName    ;
  FSourceExists       := T8MetaEntity(Source).FSourceExists      ;
end;

constructor T8MetaEntity.Create(ACollection: TCollection);
begin
  inherited;
  FProtoTypes := Ts0EntityPropProtos.Create(Self, Ts0EntityPropProto);
  FIDConstValue := Index;
end;

destructor T8MetaEntity.Destroy;
begin
  FreeAndNil(FProtoTypes);
  inherited Destroy;
end;

function T8MetaEntity.HasUniqueValue: Boolean;
begin
  Result := False;
  if Collection is T8MetaEntities then
    Result := T8MetaEntities(Collection).IsUniqueValue(Self, IDConstValue);
end;

procedure T8MetaEntity.SetBaseName(const Value: string);
var
  m: Tc8MetaEntityMan;
begin
  if FBaseName = Value then Exit;
  FBaseName := Value;
  if not(OwnerComponent is Tc8MetaEntityMan) then Exit;
  m := Tc8MetaEntityMan(OwnerComponent);
  FEntityClassName    := Format(m.Fmt_EntityClassName   , [FBaseName]);
  FEntityUnitName     := Format(m.Fmt_EntityUnitName    , [FBaseName]);
  FDataModuleName     := Format(m.Fmt_DataModuleName    , [FBaseName]);
  FDataModuleUnitName := Format(m.Fmt_DataModuleUnitName, [FBaseName]);
  FDetailFormName     := Format(m.Fmt_DetailFormName    , [FBaseName]);
  FDetailFormUnitName := Format(m.Fmt_DetailFormUnitName, [FBaseName]);
  FListFormName       := Format(m.Fmt_ListFormName      , [FBaseName]);
  FListFormUnitName   := Format(m.Fmt_ListFormUnitName  , [FBaseName]);
  FIDConstName        := Format(m.Fmt_IDConstName, [FBaseName]);
  Changed(False);
end;

procedure T8MetaEntity.SetDataModuleName(const Value: string);
begin
  if FDataModuleName = Value then Exit;
  FDataModuleName := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetDataModuleUnitName(const Value: string);
begin
  if FDataModuleUnitName = Value then Exit;
  FDataModuleUnitName := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetDetailFormName(const Value: string);
begin
  if FDetailFormName = Value then Exit;
  FDetailFormName := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetDetailFormUnitName(const Value: string);
begin
  if FDetailFormUnitName = Value then Exit;
  FDetailFormUnitName := Value;
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
  if FEntityClassName = Value then Exit;
  FEntityClassName := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetEntityUnitName(const Value: string);
begin
  if FEntityUnitName = Value then Exit;
  FEntityUnitName := Value;
  Changed(False);
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

procedure T8MetaEntity.SetListFormName(const Value: string);
begin
  if FListFormName = Value then Exit;
  FListFormName := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetListFormUnitName(const Value: string);
begin
  if FListFormUnitName = Value then Exit;
  FListFormUnitName := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetProtoTypes(const Value: Ts0EntityPropProtos);
begin
  FProtoTypes.Assign(Value);
  Changed(False);
end;

procedure T8MetaEntity.SetSourceExists(const Value: Boolean);
begin
  if FSourceExists = Value then Exit;
  FSourceExists := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetTableExists(const Value: Boolean);
begin
  if FTableExists = Value then Exit;
  FTableExists := Value;
  Changed(False);
end;

procedure T8MetaEntity.SetTableName(const Value: string);
begin
  if FTableName = Value then Exit;
  FTableName := Value;
  Changed(False);
end;

{ T8MetaEntities }

function T8MetaEntities.Add(ABaseName, ATableName: string): T8MetaEntity;
begin
  Result := T8MetaEntity(inherited Add);
  Result.TableName := ATableName;
  Result.BaseName := ABaseName;
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
    if AnsiCompareText(Items[i].TableName, ATableName) = 0 then
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

constructor Tc8MetaEntityMan.Create(AOwner: TComponent);
begin
  inherited;
  FEntities := NewEntities;
  FIDDefineUnitName := 'u8EntityIDs';
  FFmt_DataModuleUnitName := 'd8%s' ;
  FFmt_DataModuleName     := 'dm8%s';
  FFmt_EntityUnitName     := 'e8%s' ;
  FFmt_EntityClassName    := 'Te8%s' ;
  FFmt_DetailFormName     := 'frm8%sDetail';
  FFmt_DetailFormUnitName := 'f8%sDetail';
  FFmt_ListFormName       := 'frm8%sList';
  FFmt_ListFormUnitName   := 'f8%sList';
  FFmt_IDConstName := 'c8EtyID_%s';
end;

destructor Tc8MetaEntityMan.Destroy;
begin
  FreeAndNil(FEntities);
  inherited;
end;

function Tc8MetaEntityMan.NewEntities: T8MetaEntities;
begin
  Result := T8MetaEntities.Create(Self, T8MetaEntity);
end;

procedure Tc8MetaEntityMan.SetBDEAliasName(const Value: string);
begin
  if FBDEAliasName = Value then Exit;
  FBDEAliasName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetEntities(const Value: T8MetaEntities);
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

procedure Tc8MetaEntityMan.SetFmt_DataModuleName(const Value: string);
begin
  if FFmt_DataModuleName = Value then Exit;
  FFmt_DataModuleName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_DataModuleUnitName(const Value: string);
begin
  if FFmt_DataModuleUnitName = Value then Exit;
  FFmt_DataModuleUnitName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_DetailFormName(const Value: string);
begin
  if FFmt_DetailFormName = Value then Exit;
  FFmt_DetailFormName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_DetailFormUnitName(const Value: string);
begin
  if FFmt_DetailFormUnitName = Value then Exit;
  FFmt_DetailFormUnitName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_EntityClassName(const Value: string);
begin
  if FFmt_EntityClassName = Value then Exit;
  FFmt_EntityClassName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_EntityUnitName(const Value: string);
begin
  if FFmt_EntityUnitName = Value then Exit;
  FFmt_EntityUnitName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_IDConstName(const Value: string);
begin
  if FFmt_IDConstName = Value then Exit;
  FFmt_IDConstName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_ListFormName(const Value: string);
begin
  if FFmt_ListFormName = Value then Exit;
  FFmt_ListFormName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetFmt_ListFormUnitName(const Value: string);
begin
  if FFmt_ListFormUnitName = Value then Exit;
  FFmt_ListFormUnitName := Value;
  FModified := True;
end;

procedure Tc8MetaEntityMan.SetIDDefineUnitName(const Value: string);
begin
  if FIDDefineUnitName = Value then Exit;
  FIDDefineUnitName := Value;
  FModified := True;
end;

end.
