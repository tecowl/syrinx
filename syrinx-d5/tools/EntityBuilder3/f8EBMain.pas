unit f8EBMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ActnList, ComCtrls, s0MenuBar, ToolWin, StdCtrls,
  s0Grids, s0BindGrid, s0BaseGrid, s0DecoGrid, s0CtrlGrid, s0CollectionGrid,
  u8MetaEntities, s0ObjCtrlBuilder, s0UnifiedObjCtrl, s0ComboBox,
  s0GridCellControl, s0GridCellCheck, s0ObjPropStocker, s0IniPropStocker,
  s0FormEventPublisher, Db, DBTables, s0Database,
  f8EntityProto, s0ObjectGrid, s0Button, s0BaseGridCommand, s0Memo, s0Edit,
  s0CellDecorator, s0ComponentEventWrapper, s0VCLClasses;

type
  T8EBMetaEntity = class(T8MetaEntity)
  private
    FProtoForm: Tfrm8EntityProto;
  protected
  public
    destructor Destroy; override;
    function GetCSVFileName: string;
    procedure ShowProtoForm;
    property ProtoForm: Tfrm8EntityProto read FProtoForm;
  end;

type
  T8EBMetaEntities = class(T8MetaEntities)
  private
    function GetItems(const Index: Integer): T8EBMetaEntity;
    procedure SetItems(const Index: Integer; const Value: T8EBMetaEntity);
  public
    function Add(ABaseName, ATableName: string): T8EBMetaEntity;
    property Items[const Index: Integer]: T8EBMetaEntity read GetItems write SetItems;
  end;

type
  Tfrm8EBMain = class;

  Tc8EBMetaEntityMan = class(Tc8MetaEntityMan)
  private
    FOwnerForm: Tfrm8EBMain;
    FCSVDir: String;
    FEntityDetailFileNameFormat: string;
    FEntityDefineFileName: string;
    function GetEntities: T8EBMetaEntities;
    procedure SetEntities(const Value: T8EBMetaEntities);
    procedure SetCSVDir(const Value: String);
    procedure SetEntityDefineFileName(const Value: string);
    procedure SetEntityDetailFileNameFormat(const Value: string);
    function GetBDEAliasPW: String;
    procedure SetBDEAliasPW(const Value: String);
  protected
    function NewEntities: T8MetaEntities; override;
    procedure SetEntityDir(const Value: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Entities: T8EBMetaEntities read GetEntities write SetEntities;
    function GetCSVFileName: string;
  published
    property CSVDir: String read FCSVDir write SetCSVDir;
    property CSVEntityDefineFileName: string read FEntityDefineFileName write SetEntityDefineFileName;
    property CSVEntityDetailFileNameFormat: string read FEntityDetailFileNameFormat write SetEntityDetailFileNameFormat;
    property BDEAliasPW: String read GetBDEAliasPW write SetBDEAliasPW;
  end;           

  Tfrm8EBMain = class(TForm)
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    ScrollBox1: TScrollBox;
    Splitter1: TSplitter;
    s0CollectionGrid1: Ts0CollectionGrid;
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0Database1: Ts0Database;
    SaveDialog1: TSaveDialog;
    ActionList1: TActionList;
    actSaveIDDefineUnit: TAction;
    actSaveAsCSV: TAction;
    actLoadAsCSV: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    CSV1: TMenuItem;
    CSV2: TMenuItem;
    N1: TMenuItem;
    actClose: TAction;
    Close1: TMenuItem;
    T1: TMenuItem;
    actSelectTables: TAction;
    N2: TMenuItem;
    CoolBar1: TCoolBar;
    ID1: TMenuItem;
    Panel1: TPanel;
    actEntityDetail: TAction;
    s0Button1: Ts0Button;
    s0Button2: Ts0Button;
    s0Button3: Ts0Button;
    s0Button4: Ts0Button;
    s0Button6: Ts0Button;
    Show1: TMenuItem;
    N6: TMenuItem;
    s0MenuBar1: Ts0MenuBar;
    s0Button5: Ts0Button;
    s0GridCmd_CopyToClipBoard1: Ts0GridCmd_CopyToClipBoard;
    s0GridCmd_CutToClipBoard1: Ts0GridCmd_CutToClipBoard;
    s0GridCmd_PasteFromClipBoard2: Ts0GridCmd_PasteFromClipBoard;
    s0GridCmd_DeleteSelection2: Ts0GridCmd_DeleteSelection;
    s0GridCmd_InsertRow1: Ts0GridCmd_InsertRow;
    s0GridCmd_RemoveRow1: Ts0GridCmd_RemoveRow;
    s0GridCmd_AddRow1: Ts0GridCmd_AddRow;
    procedure FormShow(Sender: TObject);
    procedure s0CollectionGrid1ClickFixedCell(Sender: TObject; ACol,
      ARow: Integer);
    procedure actSelectTablesExecute(Sender: TObject);
    procedure actSaveIDDefineUnitExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actEntityDetailExecute(Sender: TObject);
    procedure actSaveAsCSVExecute(Sender: TObject);
    procedure actLoadAsCSVExecute(Sender: TObject);
    procedure actSaveAsCSVUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMetaEntityMan: Tc8EBMetaEntityMan;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frm8EBMain: Tfrm8EBMain;

implementation

{$R *.DFM}

uses
  FileCtrl,
  s0FieldHelper,
  s0EntityPropProto,
  s0Iterator,
  s0fObjPropEditor,
  f0SelectTables,
  s0ObjCSVReader,
  s0ObjCSVWriter,
  s0PropertyProtoType;

{ T8EBMetaEntity }

destructor T8EBMetaEntity.Destroy;
begin
  FreeAndNil(FProtoForm);
  inherited;
end;

function T8EBMetaEntity.GetCSVFileName: string;
var
  metaMan: Tc8EBMetaEntityMan;
begin
  Result := '';
  if not (OwnerComponent is Tc8EBMetaEntityMan) then Exit;
  metaMan := Tc8EBMetaEntityMan(OwnerComponent);
  Result :=
    IncludeTrailingBackslash(metaMan.CSVDir) +
    Format(metaMan.CSVEntityDetailFileNameFormat, [Self.BaseName]); 
end;

procedure T8EBMetaEntity.ShowProtoForm;
begin
{
  if FProtoForm = nil then
  begin
    FProtoForm := Tfrm8EntityProto.Create(nil);
    FProtoForm.TargetEntity := Self;
    FProtoForm.DataBase := Tc8EBMetaEntityMan(OwnerComponent).FOwnerForm.s0Database1;
    FProtoForm.Session := Tc8EBMetaEntityMan(OwnerComponent).FOwnerForm.Session1;
  end;
  FProtoForm.Show;
}
end;

{ T8EBMetaEntities }

function T8EBMetaEntities.Add(ABaseName,
  ATableName: string): T8EBMetaEntity;
begin
  Result := T8EBMetaEntity(inherited Add(ABaseName, ATableName));
end;

function T8EBMetaEntities.GetItems(const Index: Integer): T8EBMetaEntity;
begin
  Result := T8EBMetaEntity(inherited Items[Index]);
end;

procedure T8EBMetaEntities.SetItems(const Index: Integer;
  const Value: T8EBMetaEntity);
begin
  inherited Items[Index] := Value;
end;

{ Tc8EBMetaEntityMan }

constructor Tc8EBMetaEntityMan.Create(AOwner: TComponent);
begin
  inherited;
  FEntityDefineFileName := 'Entities.csv';
  FEntityDetailFileNameFormat := 'Ety_%s.csv';
end;

function Tc8EBMetaEntityMan.GetBDEAliasPW: String;
begin
  Result := '';
  if FOwnerForm is Tfrm8EBMain then
    Result := Tfrm8EBMain(FOwnerForm).s0Database1.LoginPassword;
end;

function Tc8EBMetaEntityMan.GetCSVFileName: string;
begin
  Result := IncludeTrailingBackslash(CSVDir) + CSVEntityDefineFileName;
end;

function Tc8EBMetaEntityMan.GetEntities: T8EBMetaEntities;
begin
  Result := T8EBMetaEntities(inherited Entities);
end;

function Tc8EBMetaEntityMan.NewEntities: T8MetaEntities;
begin
  Result := T8EBMetaEntities.Create(Self, T8EBMetaEntity);
end;

procedure Tc8EBMetaEntityMan.SetBDEAliasPW(const Value: String);
begin
  if FOwnerForm is Tfrm8EBMain then
    Tfrm8EBMain(FOwnerForm).s0Database1.LoginPassword := Value;
end;

procedure Tc8EBMetaEntityMan.SetCSVDir(const Value: String);
begin
  if FCSVDir = Value then Exit;
  FCSVDir := Value;
  Modified := True;
end;

procedure Tc8EBMetaEntityMan.SetEntities(const Value: T8EBMetaEntities);
begin
  inherited Entities := Value;
end;

procedure Tc8EBMetaEntityMan.SetEntityDefineFileName(const Value: string);
begin
  if FEntityDefineFileName = Value then Exit;
  FEntityDefineFileName := Value;
  Modified := True;
end;

procedure Tc8EBMetaEntityMan.SetEntityDetailFileNameFormat(
  const Value: string);
begin
  if FEntityDetailFileNameFormat = Value then Exit;
  FEntityDetailFileNameFormat := Value;
  Modified := True;
end;

procedure Tc8EBMetaEntityMan.SetEntityDir(const Value: string);
  function GetCSVDirStr(AEntityDir: string): string;
  begin
    Result := IncludeTrailingBackslash(AEntityDir) + 'csv';
  end;
var
  buf: string;
begin
  buf := EntityDir;
  inherited;
  if EntityDir = '' then Exit;
  if (CSVDir = '') or (CSVDir = GetCSVDirStr(buf)) then
    CSVDir := GetCSVDirStr(EntityDir);
end;

{ Tfrm8EBMain }

constructor Tfrm8EBMain.Create(AOwner: TComponent);
begin
  inherited;
  RegisterClass(T8EBMetaEntity);
  RegisterClass(T8EBMetaEntities);
  FMetaEntityMan := Tc8EBMetaEntityMan.Create(nil);
  FMetaEntityMan.FOwnerForm := Self;
  FMetaEntityMan.Name := 'MetaEntityMan';
  FMetaEntityMan.EntityDir := ExtractFileDir(Application.ExeName); 
  s0IniPropStocker1.Items.AddAllProp(FMetaEntityMan, k0ialInstance);
end;

destructor Tfrm8EBMain.Destroy;
begin
  FreeAndNil( FMetaEntityMan );
  inherited;
end;

procedure Tfrm8EBMain.FormShow(Sender: TObject);
var
  proto: Ts0PropertyProtoType;
begin
  s0UnifiedObjCtrl1.Target := FMetaEntityMan;
  proto := s0UnifiedObjCtrl1.ProtoTypes.FindByName('Entities');
  proto.WithoutCtrl := True;

  proto := s0UnifiedObjCtrl1.ProtoTypes.FindByName('EntityDir');
  proto.Size := 100;
  proto := s0UnifiedObjCtrl1.ProtoTypes.FindByName('CSVDir');
  proto.Size := 100;

  s0UnifiedObjCtrl1.BuildCtrls;
  s0UnifiedObjCtrl1.LoadFromTarget;
  s0CollectionGrid1.Target := FMetaEntityMan.Entities;
  //
  ScrollBox1.HorzScrollBar.Position := 0;
end;

procedure Tfrm8EBMain.s0CollectionGrid1ClickFixedCell(Sender: TObject;
  ACol, ARow: Integer);
begin
  if ARow < s0CollectionGrid1.FixedRows then Exit;
  s0Database1.Connected := False;
  s0Database1.SessionName := Session1.SessionName;
  s0Database1.AliasName := FMetaEntityMan.BDEConnection.AliasName;
  s0Database1.DatabaseName := FMetaEntityMan.BDEConnection.DataBaseName;
  s0Database1.Connected := True;
  s0CollectionGrid1.Row := ARow;
  actEntityDetail.Execute;
end;

resourcestring
  c9ErrMsg_CannotOpenTable = 'テーブル"%s"を開くことはできませんでした。';

procedure Tfrm8EBMain.actSelectTablesExecute(Sender: TObject);
  procedure LoadProtoFromDS(AEntity: T8EBMetaEntity);
  var
    fld: TField;
    p: Ts0EntityPropProto;
    i: Integer;
    tbl: TTable;
  begin
    tbl := TTable.Create(nil);
    try
      tbl.DatabaseName := s0Database1.DatabaseName;
      tbl.SessionName := Session1.SessionName;
      tbl.TableName := AEntity.BDEConnection.TableName;
      if not tbl.Exists then
      begin
        MessageDlg(Format(c9ErrMsg_CannotOpenTable, [tbl.TableName]), mtWarning, [mbOK], 0);
        Exit;
      end;
      tbl.Open;
      AEntity.ProtoTypes.BeginUpdate;
      try
        AEntity.ProtoTypes.Clear;
        for i := 0 to tbl.Fields.Count -1 do
        begin
          fld := tbl.Fields[i];
          p := AEntity.ProtoTypes.AddProto;
          p.FieldName := fld.FieldName;
          p.FieldType := fld.DataType;
          p.FieldSize := fld.Size;
          p.Size := p.FieldSize;
          p.PropertyName := p.FieldName;
          p.TypeName :=
            Ts0EntityPropProto.FieldTypeToPropTypeStr(
              Ts0FieldHelper.FieldTypeFromNative(fld.DataType)
            );
          p.JPName := '';
          p.IsRequired := fld.Required;
        end;
      finally
        AEntity.ProtoTypes.EndUpdate;
      end;
      tbl.Close;
    finally
      FreeAndNil(tbl);
    end;
  end;

var
  frm: Tfrm0SelectTables;
  sl: TStringList;
  i: Integer;
  ety: T8EBMetaEntity;
begin
  s0UnifiedObjCtrl1.SaveToTarget;
  frm := Tfrm0SelectTables.Create(nil);
  try
    frm.Session := Session1;
    frm.DataBase := s0Database1;
    frm.BDEAliasName := FMetaEntityMan.BDEConnection.AliasName;
    if frm.ShowModal <> mrOK then Exit;
    FMetaEntityMan.BDEConnection.AliasName := frm.BDEAliasName;
    sl := TStringList.Create;
    try
      sl.Assign(frm.Dest);
        for i := 0 to sl.Count -1 do
        begin
          if FMetaEntityMan.Entities.FindByTableName(sl.Strings[i]) <> nil then Continue;
          ety := FMetaEntityMan.Entities.Add(sl.Strings[i], sl.Strings[i]);
          LoadProtoFromDS(ety);
        end;
    finally
      FreeAndNil(sl);
    end;
  finally
    FreeAndNil(frm);
  end;
  s0UnifiedObjCtrl1.LoadFromTarget;
  s0CollectionGrid1.LoadFromTarget;
end;

procedure Tfrm8EBMain.actSaveIDDefineUnitExecute(Sender: TObject);
var
  sl: TStringList;
  i: Integer;
  ety: T8EBMetaEntity;
begin
  sl := TStringList.Create;
  try
    sl.Add('unit ' + FMetaEntityMan.IDDefineUnitName +';');
    sl.Add('');
    sl.Add('interface');
    sl.Add('');
    sl.Add('const');
    for i := 0 to FMetaEntityMan.Entities.Count -1 do
    begin
      ety := FMetaEntityMan.Entities.Items[i];
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
      IncludeTrailingBackslash(FMetaEntityMan.EntityDir) +
      ChangeFileExt(FMetaEntityMan.IDDefineUnitName, '.pas')
    );
  finally
    FreeAndNil(sl);
  end;
end;

procedure Tfrm8EBMain.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure Tfrm8EBMain.actEntityDetailExecute(Sender: TObject);
var
  ety: T8EBMetaEntity;
begin
  s0CollectionGrid1.SaveToTarget;
  ety := FMetaEntityMan.Entities.Items[s0CollectionGrid1.Row -1];
  ety.ShowProtoForm;
  //BDEAliasPWが変更されてたらここで反映される
  s0UnifiedObjCtrl1.LoadFromTarget;
end;

resourcestring
  c9Confirm_OverWriteFile = 'ファイル"%s"は既に存在しています。上書きしますか？';

procedure Tfrm8EBMain.actSaveAsCSVExecute(Sender: TObject);
  procedure SavePropAsCSV(AFileName: string; ACollection: TCollection);
  var
    ite: Ts0CollectionIterator;
    csvW: Ts0ObjCSVWriter;
    fs: TFileStream;
  begin
    fs := TFileStream.Create(AFileName, fmCreate or fmShareDenyNone);
    try
      ite := Ts0CollectionIterator.Create(ACollection, False);
      try
        csvW := Ts0ObjCSVWriter.Create;
        try
          csvW.Source := ite;
          csvW.Dest := fs;
          csvW.AddAllPropsOf(ACollection.ItemClass);
          csvW.IncludeTitles := True;
          csvW.Execute;
        finally
          FreeAndNil(csvW);
        end;
      finally
        FreeAndNil(ite);
      end;
    finally
      FreeAndNil(fs);
    end;
  end;         

  function ConfitmOverWrite(AFileName: string): Boolean;
  begin
    Result := not FileExists(AFileName);
    if Result then Exit;
    Result :=
      MessageDlg(
        Format(c9Confirm_OverWriteFile, [AFileName]),
        mtConfirmation, [mbYes, mbNo], 0
      ) = mrYes;
  end;

  procedure SaveEtyProps(AEntity: T8EBMetaEntity; AFileNameFormat: string);
  var
    fn: String;
  begin
    fn := AEntity.GetCSVFileName;
    if ConfitmOverWrite(fn) then
      SavePropAsCSV(fn, AEntity.ProtoTypes);
  end;

  procedure SaveEntitieDefines;
  var
    fn: string;
  begin
    fn := FMetaEntityMan.GetCSVFileName;
    if ConfitmOverWrite(fn) then
      SavePropAsCSV( fn, FMetaEntityMan.Entities );
  end;
var
  i: Integer;
begin
  FMetaEntityMan.CSVDir := ExcludeTrailingBackslash(FMetaEntityMan.CSVDir);
  if not DirectoryExists( FMetaEntityMan.CSVDir ) then
    ForceDirectories( FMetaEntityMan.CSVDir );
  //
  SaveEntitieDefines;
  for i := 0 to FMetaEntityMan.Entities.Count -1 do
  begin
    SaveEtyProps(
      FMetaEntityMan.Entities.Items[i],
      FMetaEntityMan.CSVEntityDetailFileNameFormat
    );
  end;
end;

resourcestring
  c9ErrMsg_DirNotFound = 'ディレクトリ"%s"は見つかりませんでした';
  c9ErrMsg_FileNotFound = 'ファイル"%s"は見つかりませんでした';

procedure Tfrm8EBMain.actLoadAsCSVExecute(Sender: TObject);
  procedure LoadPropAsCSV(AFileName: string; ACollection: TCollection);
  var
    csvR: Ts0CollectionCSVReader;
    fs: TFileStream;
  begin
    if not FileExists(AFileName) then
    begin
      MessageDlg(Format(c9ErrMsg_FileNotFound, [FMetaEntityMan.GetCSVFileName]), mtError, [mbOK], 0);
      Exit;
    end;
    //
    ACollection.Clear;
    fs := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
    try
      csvR := Ts0CollectionCSVReader.Create;
      try
        csvR.Source := fs;
        csvR.ReadTitles := True;
        csvR.TargetCollection := ACollection;
        csvR.Execute;
      finally
        FreeAndNil(csvR);
      end;
    finally
      FreeAndNil(fs);
    end;
  end;

var
  i: Integer;
begin
  FMetaEntityMan.CSVDir := ExcludeTrailingBackslash(FMetaEntityMan.CSVDir);
  if not DirectoryExists( FMetaEntityMan.CSVDir ) then
  begin
    MessageDlg(Format(c9ErrMsg_DirNotFound, [FMetaEntityMan.CSVDir]), mtError, [mbOK], 0);
    Exit;
  end;
  //
  LoadPropAsCSV(FMetaEntityMan.GetCSVFileName, FMetaEntityMan.Entities);
  for i := 0 to FMetaEntityMan.Entities.Count -1 do
    LoadPropAsCSV(
      FMetaEntityMan.Entities.Items[i].GetCSVFileName,
      FMetaEntityMan.Entities.Items[i].ProtoTypes
    );
  s0CollectionGrid1.LoadFromTarget;
end;

procedure Tfrm8EBMain.actSaveAsCSVUpdate(Sender: TObject);
begin
  actSaveAsCSV.Enabled := FMetaEntityMan.Modified;
end;

procedure Tfrm8EBMain.FormCreate(Sender: TObject);
begin
  s0CollectionGrid1.CreateCmdMenu;
  //
  if s0UnifiedObjCtrl1.Builder.CtrlOfType.CtrlClassNameOfEnum = '' then ;
  if s0UnifiedObjCtrl1.Builder.CtrlOfType.CtrlClassNameOfSet = '' then ;

  s0UnifiedObjCtrl1.Builder.CtrlOfTypeClassName := 'Ts0COTEtyCtrls';
  if s0UnifiedObjCtrl1.Builder.CtrlOfType.CtrlClassNameOfEnum = '' then ;
  if s0UnifiedObjCtrl1.Builder.CtrlOfType.CtrlClassNameOfSet = '' then ;
end;

end.
