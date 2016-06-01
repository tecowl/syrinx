unit d8EntityTemplate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Entity, s0EntityFormManager, Db, DBTables, s0DBEntity, s0Query;

type
  Tdm8EntityTemplate = class(TDataModule)
    EntityManager: Ts0DBEntityManager;
    selEntity: Ts0Query;
    selEntities: Ts0Query;
    insEntity: Ts0Query;
    updEntity: Ts0Query;
    delEntity: Ts0Query;
    procedure EntityManagerExecDetail(Sender: TObject; ADataSet: TDataSet;
      AEntity: Ts0Entity);
    procedure EntityManagerExecInsert(Sender: TObject; ADataSet: TDataSet;
      AEntity: Ts0Entity);
    procedure EntityManagerExecRemove(Sender: TObject; ADataSet: TDataSet;
      AEntity: Ts0Entity);
    procedure EntityManagerExecUpdate(Sender: TObject; ADataSet: TDataSet;
      AEntity: Ts0Entity);
    procedure EntityManagerLoadKey(Sender: TObject; ADataSet: TDataSet;
      AEntity: Ts0Entity);
    procedure selEntitiesCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  dm8EntityTemplate: Tdm8EntityTemplate;

implementation

{$R *.DFM}

procedure Tdm8EntityTemplate.EntityManagerExecDetail(Sender: TObject;
  ADataSet: TDataSet; AEntity: Ts0Entity);
begin
//
end;

procedure Tdm8EntityTemplate.EntityManagerExecInsert(Sender: TObject;
  ADataSet: TDataSet; AEntity: Ts0Entity);
begin
//
end;

procedure Tdm8EntityTemplate.EntityManagerExecRemove(Sender: TObject;
  ADataSet: TDataSet; AEntity: Ts0Entity);
begin
//
end;

procedure Tdm8EntityTemplate.EntityManagerExecUpdate(Sender: TObject;
  ADataSet: TDataSet; AEntity: Ts0Entity);
begin
//
end;

procedure Tdm8EntityTemplate.EntityManagerLoadKey(Sender: TObject;
  ADataSet: TDataSet; AEntity: Ts0Entity);
begin
//
end;

procedure Tdm8EntityTemplate.selEntitiesCalcFields(DataSet: TDataSet);
begin
//
end;

procedure Tdm8EntityTemplate.DataModuleCreate(Sender: TObject);
begin
//
end;

procedure Tdm8EntityTemplate.DataModuleDestroy(Sender: TObject);
begin
//
end;

end.
