unit d8EntityBuilder;

interface

uses
  SysUtils, Classes, Contnrs, Forms,
  DBTables, Db, s0Database,
  u8MetaEntities,
  s0Collection,
  s0Persistent, Dialogs, s0ComponentEventWrapper, s0FormEventPublisher,
  s0ObjPropStocker, s0IniPropStocker;

type
  Ts8XMLMetaEntityMan = class;
  Tdm8EntityBuilder = class;

  Ts8ProjectList = class(TObjectList)
  private
    FOnwerDM: Tdm8EntityBuilder;
    function GetProjects(const Index: Integer): Ts8XMLMetaEntityMan;
  public
    property Projects[const Index: Integer]: Ts8XMLMetaEntityMan read GetProjects; default;
  published
    procedure AddProject;
    procedure LoadProject;
  end;

  Tdm8EntityBuilder = class(TDataModule)
    s0Database1: Ts0Database;
    Session1: TSession;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FProjects: Ts8ProjectList;
    FRemoved: TObjectList;
    FMetaEntityManClass: Tc8MetaEntityManClass;
    FLastAccessFileName: string;
    procedure SetProjects(Value: Ts8ProjectList);
    procedure AddProjectImpl(AProj: Tc8MetaEntityMan);
  public
    property MetaEntityManClass: Tc8MetaEntityManClass read FMetaEntityManClass write FMetaEntityManClass;
    procedure SaveProject(AProj: Tc8MetaEntityMan);
    procedure RemoveProjFromList(AProj: Tc8MetaEntityMan);
  published
    procedure AddProject;
    procedure LoadProject;
    property Projects: Ts8ProjectList read FProjects write SetProjects;
  end;

  Ts8XMLMetaEntityMan = class(Tc8MetaEntityMan)
  private
    FOwnerDM: Tdm8EntityBuilder;
    FFileName: TFileName;
    procedure SetCaption(const Value: string);
    function GetCaption: string;
  public
    constructor Create(AOwner: TComponent); override;
    property FileName: TFileName read FFileName write FFileName;
  published
    procedure SaveProject;
    procedure RemoveProject; virtual;
    property Caption: string read GetCaption write SetCaption;
  end;

var
  dm8EntityBuilder: Tdm8EntityBuilder;

implementation

{$R *.DFM}

uses
  s0EntityPropProto,
  s0TaggedPage;

{ Ts8ProjectList }

procedure Ts8ProjectList.AddProject;
begin
  FOnwerDM.AddProject;
end;

function Ts8ProjectList.GetProjects(
  const Index: Integer): Ts8XMLMetaEntityMan;
begin
  Result := Ts8XMLMetaEntityMan(inherited Items[Index]);
end;

procedure Ts8ProjectList.LoadProject;
begin
  FOnwerDM.LoadProject;
end;

{ Tdm8EntityBuilder }

procedure Tdm8EntityBuilder.AddProject;
begin
  AddProjectImpl(FMetaEntityManClass.Create(nil));
end;

procedure Tdm8EntityBuilder.DataModuleCreate(Sender: TObject);
begin
  FLastAccessFileName := '';
  FMetaEntityManClass := Ts8XMLMetaEntityMan;
  FProjects := Ts8ProjectList.Create(False);
  FProjects.FOnwerDM := Self;
  FRemoved := TObjectList.Create(False);
end;

procedure Tdm8EntityBuilder.DataModuleDestroy(Sender: TObject);
begin
  FProjects.OwnsObjects := True;
  FreeAndNil( FProjects );
  FRemoved.OwnsObjects := True;
  FreeAndNil( FRemoved );
end;

procedure Tdm8EntityBuilder.AddProjectImpl(AProj: Tc8MetaEntityMan);
begin
  if AProj is Ts8XMLMetaEntityMan then
    Ts8XMLMetaEntityMan(AProj).FOwnerDM := Self;
  AProj.BDEConnection.DataBase := s0Database1;
  Projects.Add(AProj);
end;

procedure Tdm8EntityBuilder.LoadProject;
  function FindProj(AFileName: string): Ts8XMLMetaEntityMan;
  var
    i: Integer;
  begin
    for i := 0 to FProjects.Count -1 do
    begin
      if not(FProjects.Items[i] is Ts8XMLMetaEntityMan) then Continue;
      Result := Ts8XMLMetaEntityMan(FProjects.Items[i]);
      if SameText(Result.FileName, AFileName) then Exit;
    end;
    Result := nil;
  end;
var
  page: Ts0TaggedPage;
  obj: TObject;
begin
  OpenDialog1.FileName := FLastAccessFileName;
  if not OpenDialog1.Execute then Exit;
  FLastAccessFileName := OpenDialog1.FileName;
  if FindProj(OpenDialog1.FileName) <> nil then Exit;
  page := Ts0TaggedPage.Create(nil);
  try
    page.PolicyName := 'XML';
    page.LoadFromFile(OpenDialog1.FileName);
    obj := page.ReadObject;
    if obj is Ts8XMLMetaEntityMan then
    begin
      Ts8XMLMetaEntityMan(obj).FileName := OpenDialog1.FileName;
      AddProjectImpl( Ts8XMLMetaEntityMan(obj) );
      Ts8XMLMetaEntityMan(obj).Modified := False;
    end;
  finally
    FreeAndNil(page);
  end;
end;

procedure Tdm8EntityBuilder.SaveProject(AProj: Tc8MetaEntityMan);
var
  page: Ts0TaggedPage;
begin
  SaveDialog1.FileName := FLastAccessFileName;
  if not SaveDialog1.Execute then Exit;
  FLastAccessFileName := SaveDialog1.FileName;
  AProj.Modified := False;
  if AProj is Ts8XMLMetaEntityMan then
    Ts8XMLMetaEntityMan(AProj).FileName := SaveDialog1.FileName;
  page := Ts0TaggedPage.Create(nil);
  try
    page.PolicyName := 'XML';
    page.WriteObject(AProj);
    page.SaveToFile(SaveDialog1.FileName);
  finally
    FreeAndNil(page);
  end;
end;

procedure Tdm8EntityBuilder.SetProjects(Value: Ts8ProjectList);
begin
end;

procedure Tdm8EntityBuilder.RemoveProjFromList(AProj: Tc8MetaEntityMan);
begin
  while FProjects.Remove(AProj) > -1 do ;
  if FRemoved.IndexOf(AProj) > -1 then Exit;
  FRemoved.Add(AProj);
end;

{ Ts8XMLMetaEntityMan }

constructor Ts8XMLMetaEntityMan.Create(AOwner: TComponent);
begin
  inherited;
  FFileName := 'New Project';
  Modified := True;
end;

function Ts8XMLMetaEntityMan.GetCaption: string;
begin
  Result := FFileName;
end;

procedure Ts8XMLMetaEntityMan.RemoveProject;
begin
  FOwnerDM.RemoveProjFromList(Self);
end;

procedure Ts8XMLMetaEntityMan.SaveProject;
begin
  if FOwnerDM <> nil then
    FOwnerDM.SaveProject(Self);
end;

procedure Ts8XMLMetaEntityMan.SetCaption(const Value: string);
begin
end;

initialization
  RegisterClass(Ts0EntityPropProto);
  RegisterClass(Ts0EntityPropProtos);
  RegisterClass(Ts8XMLMetaEntityMan);

finalization
  UnRegisterClass(Ts0EntityPropProto);
  UnRegisterClass(Ts0EntityPropProtos);
  UnRegisterClass(Ts8XMLMetaEntityMan);

end.
