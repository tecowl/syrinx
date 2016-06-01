unit s8EntityBDE;

interface

uses
  SysUtils, Classes,
  DBTables,
  s0DataBase,
  s0Persistent;

type
  Is8DBDataSet = interface
  ['{3C132CE9-7333-4044-AAB5-E81673A959EC}']
    function GetDataBaseName: string;
    function GetSessionName: string;
    procedure SetDataBaseName(const Value: string);
    procedure SetSessionName(const Value: string);
    property DataBaseName: string read GetDataBaseName write SetDataBaseName;
    property SessionName : string read GetSessionName  write SetSessionName ;
  end;

type
  Is0DataBase = interface(Is8DBDataSet)
  ['{C4810398-D3F5-4CB1-A1C9-312FF5C0AE0C}']
    function GetAliasName: string;
    procedure SetAliasName(const Value: string);
    property AliasName: string read GetAliasName write SetAliasName;
  end;

type
  Is0PWDataBase = interface(Is0DataBase)
  ['{3D49BE33-4860-4824-9C6A-16171B0385B2}']
    function GetPassword: string;
    function GetUserName: string;
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
  end;

type
  Ts8DBDataSetAlias = class(Ts0InterfacedPersistent, Is8DBDataSet)
  private
    FDataSet: TDBDataSet;
    procedure SetDataSet(const Value: TDBDataSet);
  protected
    function GetDataBaseName: string;
    function GetSessionName: string;
    procedure SetDataBaseName(const Value: string);
    procedure SetSessionName(const Value: string);
  protected
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property DataSet: TDBDataSet read FDataSet write SetDataSet;
  published
    property DataBaseName: string read GetDataBaseName write SetDataBaseName;
    property SessionName : string read GetSessionName  write SetSessionName ;
  end;

type
  Ts8DataBaseAlias = class(Ts0InterfacedPersistent, Is0PWDataBase)
  private
    FDataBase: Ts0Database;
    procedure SetDataBase(const Value: Ts0Database);
  protected
    function GetDataBaseName: string;
    function GetSessionName: string;
    procedure SetDataBaseName(const Value: string);
    procedure SetSessionName(const Value: string);
  protected
    function GetAliasName: string;
    procedure SetAliasName(const Value: string);
  protected
    function GetPassword: string;
    function GetUserName: string;
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
  protected
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property DataBase: Ts0Database read FDataBase write SetDataBase;
  published
    property AliasName: string read GetAliasName write SetAliasName;
  published
    property DataBaseName: string read GetDataBaseName write SetDataBaseName;
    property SessionName : string read GetSessionName  write SetSessionName ;
  published
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
  end;         

implementation

{ Ts8DBDataSetAlias }

constructor Ts8DBDataSetAlias.Create(AOwner: TPersistent);
begin
  inherited;
end;

destructor Ts8DBDataSetAlias.Destroy;
begin
  inherited;
end;

function Ts8DBDataSetAlias.GetDataBaseName: string;
begin
  if FDataSet = nil then
    Result := ''
  else
    Result := FDataSet.DatabaseName;
end;

function Ts8DBDataSetAlias.GetSessionName: string;
begin
  if FDataSet = nil then
    Result := ''
  else
    Result := FDataSet.SessionName;
end;

procedure Ts8DBDataSetAlias.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FDataSet = AComponent then
    FDataSet := nil;
end;

procedure Ts8DBDataSetAlias.SetDataBaseName(const Value: string);
begin
  if FDataSet = nil then
  else
    FDataSet.DatabaseName := Value;
  Change;
end;

procedure Ts8DBDataSetAlias.SetDataSet(const Value: TDBDataSet);
begin
  FDataSet := Value;
  Change;
end;

procedure Ts8DBDataSetAlias.SetSessionName(const Value: string);
begin
  if FDataSet = nil then
  else
    FDataSet.SessionName := Value;
  Change;
end;

{ Ts8DataBaseAlias }

constructor Ts8DataBaseAlias.Create(AOwner: TPersistent);
begin
  inherited;

end;

destructor Ts8DataBaseAlias.Destroy;
begin
  inherited;

end;

function Ts8DataBaseAlias.GetAliasName: string;
begin
  if FDataBase = nil then
    Result := ''
  else
    Result := FDataBase.AliasName;
end;

function Ts8DataBaseAlias.GetDataBaseName: string;
begin
  if FDataBase = nil then
    Result := ''
  else
    Result := FDataBase.DatabaseName;
end;

function Ts8DataBaseAlias.GetPassword: string;
begin
  if FDataBase = nil then
    Result := ''
  else
    Result := FDataBase.LoginPassword;
end;

function Ts8DataBaseAlias.GetSessionName: string;
begin
  if FDataBase = nil then
    Result := ''
  else
    Result := FDataBase.SessionName;
end;

function Ts8DataBaseAlias.GetUserName: string;
begin
  if FDataBase = nil then
    Result := ''
  else
    Result := FDataBase.LoginUserName;
end;

procedure Ts8DataBaseAlias.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FDataBase = AComponent then
    FDataBase := nil;
end;

procedure Ts8DataBaseAlias.SetAliasName(const Value: string);
begin
  if FDataBase = nil then Exit;
  if FDataBase.Connected then
  begin
    FDataBase.Connected := False;
    FDataBase.AliasName := Value;
    FDataBase.Connected := True;
  end
  else
    FDataBase.AliasName := Value;
  Change;
end;

procedure Ts8DataBaseAlias.SetDataBase(const Value: Ts0Database);
begin
  FDataBase := Value;
  Change;
end;

procedure Ts8DataBaseAlias.SetDataBaseName(const Value: string);
begin
  if FDataBase = nil then Exit;
  if FDataBase.Connected then
  begin
    FDataBase.Connected := False;
    FDataBase.DatabaseName := Value;
    FDataBase.Connected := True;
  end
  else
    FDataBase.DatabaseName := Value;
  Change;
end;

procedure Ts8DataBaseAlias.SetPassword(const Value: string);
begin
  if FDataBase = nil then Exit;
  FDataBase.LoginPassword := Value;
  Change;
end;

procedure Ts8DataBaseAlias.SetSessionName(const Value: string);
begin
  if FDataBase = nil then Exit;
  if FDataBase.Connected then
  begin
    FDataBase.Connected := False;
    FDataBase.SessionName := Value;
    FDataBase.Connected := True;
  end
  else
    FDataBase.SessionName := Value;
  Change;
end;

procedure Ts8DataBaseAlias.SetUserName(const Value: string);
begin
  if FDataBase = nil then Exit;
  FDataBase.LoginUserName := Value;
  Change;
end;

initialization
  RegisterClass(Ts8DBDataSetAlias);
  RegisterClass(Ts8DataBaseAlias);

finalization
  UnRegisterClass(Ts8DBDataSetAlias);
  UnRegisterClass(Ts8DataBaseAlias);

end.
