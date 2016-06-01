{-----------------------------------------------------------------------------
 Unit Name: f8EntityProto
 Author:    akima
 Purpose:
 $History: f8EntityProto.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/04/19   Time: 11:25
 * Updated in $/tools/EntityBuilder3
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:23
 * Created in $/tools/EntityBuilder3
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/13   Time: 14:32
 * Created in $/tools/EntityBuilder2
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/02/14   Time: 23:47
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/06   Time: 4:43
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/10   Time: 13:39
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/01/10   Time: 3:20
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
-----------------------------------------------------------------------------}

unit f8EntityProto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, s0Grids, s0BindGrid, s0BaseGrid, s0DecoGrid,
  s0CtrlGrid, s0CollectionGrid, ComCtrls, s0ObjPropStocker,
  s0IniPropStocker, s0FormEventPublisher, Db, DBTables, s0Query,
  s0EntityPropProto,
  u8DMBuilder,
  u0SXMetaClass,
  u0SXMetaClassWriter,
  u8MetaEntities, s0ObjectGrid, s0CellDecorator, CheckLst, s0ComboBox,
  s0BaseGridCommand, ActnList, Menus, s0MenuBar, ToolWin, s0Button,
  s0Table, s0ObjCtrlBuilder, s0UnifiedObjCtrl, s0Label, s0CheckBox, s0Memo,
  s0CheckListBox, s0Edit, s0DigitEdit, s0ComponentEventWrapper,
  s0VCLClasses;

type
  Tfrm8EntityProto = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    pgSourceCodes: TPageControl;
    pageEntityPas: TTabSheet;
    dspEntityPas: TMemo;
    pageDMPas: TTabSheet;
    dspDMPas: TMemo;
    pageDMDfm: TTabSheet;
    dspDMDfm: TMemo;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0IniPropStocker1: Ts0IniPropStocker;
    pageDetailFormPas: TTabSheet;
    pageDetailFormDfm: TTabSheet;
    pageListFormPas: TTabSheet;
    pageListFormDfm: TTabSheet;
    dspDetailFormPas: TMemo;
    dspDetailFormDfm: TMemo;
    dspListFormPas: TMemo;
    dspListFormDfm: TMemo;
    dspMsg: TMemo;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    grdEnumValue: Ts0CollectionGrid;
    cmbTables: Ts0ComboBox;
    cmbFields: Ts0ComboBox;
    edtSelEntities: TMemo;
    edtSelEntity: TMemo;
    edtInsEntity: TMemo;
    edtUpdEntity: TMemo;
    edtDelEntity: TMemo;
    CoolBar1: TCoolBar;
    s0MenuBar1: Ts0MenuBar;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    actCreateTable: TAction;
    actGenerateSQLs: TAction;
    actGenerateSource: TAction;
    actWriteFiles: TAction;
    Splitter2: TSplitter;
    File1: TMenuItem;
    actGenerateSQLs1: TMenuItem;
    actGenerateSource1: TMenuItem;
    actWriteFiles1: TMenuItem;
    actCreateTable1: TMenuItem;
    DB1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    actClose: TAction;
    Close1: TMenuItem;
    Panel1: TPanel;
    s0Button1: Ts0Button;
    s0Button2: Ts0Button;
    s0Button3: Ts0Button;
    s0Button4: Ts0Button;
    s0Button5: Ts0Button;
    TabSheet1: TTabSheet;
    grdFields: Ts0CollectionGrid;
    c0GridCmd_CopyToClipBoard2: Ts0GridCmd_CopyToClipBoard;
    c0GridCmd_CutToClipBoard2: Ts0GridCmd_CutToClipBoard;
    c0GridCmd_DeleteSelection2: Ts0GridCmd_DeleteSelection;
    Panel2: TPanel;
    TabSheet10: TTabSheet;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    s0Table1: Ts0Table;
    ScrollBox1: TScrollBox;
    chkDefaultIndex1: Ts0CheckBox;
    chkExclusive1: Ts0CheckBox;
    grdFieldDefs1: Ts0CollectionGrid;
    lblFieldDefs1: Ts0Label;
    grdIndexDefs1: Ts0CollectionGrid;
    lblIndexDefs1: Ts0Label;
    cmbTableType1: Ts0ComboBox;
    lblTableType1: Ts0Label;
    actLoadFields: TAction;
    L1: TMenuItem;
    s0Button6: Ts0Button;
    CheckListBox1: TCheckListBox;
    Splitter1: TSplitter;
    s0Edit15: Ts0Edit;
    s0CheckListBox5: Ts0CheckListBox;
    s0ComboBox3: Ts0ComboBox;
    s0DigitEdit7: Ts0DigitEdit;
    s0DigitEdit8: Ts0DigitEdit;
    s0Edit16: Ts0Edit;
    s0Edit17: Ts0Edit;
    s0Edit18: Ts0Edit;
    s0Edit19: Ts0Edit;
    s0Edit20: Ts0Edit;
    s0CheckListBox6: Ts0CheckListBox;
    s0Edit21: Ts0Edit;
    s0DigitEdit9: Ts0DigitEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdFieldsDblClick(Sender: TObject);
    procedure TabSheet9Show(Sender: TObject);
    procedure cmbFieldsDropDown(Sender: TObject);
    procedure actWriteFilesExecute(Sender: TObject);
    procedure actGenerateSQLsExecute(Sender: TObject);
    procedure actGenerateSourceExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actLoadFieldsExecute(Sender: TObject);
    procedure actCreateTableExecute(Sender: TObject);
  private
    FDataBase: TDatabase;
    FSession: TSession;
    FTargetEntity: T8MetaEntity;
    procedure SetTargetEntity(const Value: T8MetaEntity);
  private
    FProdProj: Tc0SXProject;
    FDMBuilder: T8DMBuilder;
    //procedure DoGetIDConstName(Sender: TObject; AEtyClassName: string; var AIDConstName: string);
    procedure RefreshValidMsg;
  public
    property Session: TSession read FSession write FSession;
    property DataBase: TDatabase read FDataBase write FDataBase;
    property TargetEntity: T8MetaEntity read FTargetEntity write SetTargetEntity;
  end;

var
  frm8EntityProto: Tfrm8EntityProto;

implementation

{$R *.DFM}

uses
  s0fObjEditor,
  s0DBEntity,
  s0ValidationMsg,
  u8BuilderParam,
  u8EntityUnitBuilder,
  u8ListFormBuilder,
  u8DetailFormBuilder,
  f8EnumDlg, d8EntityTemplate;

{ Tfrm8EntityProto }

procedure Tfrm8EntityProto.FormCreate(Sender: TObject);
begin
  FProdProj := Tc0SXProject.Create(nil);
//  FDMBuilder := T8DMBuilder.Create(nil);
  actWriteFiles.Enabled := False;
end;

procedure Tfrm8EntityProto.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDMBuilder);
  FreeAndNil(FProdProj);
end;

procedure Tfrm8EntityProto.FormShow(Sender: TObject);
begin
  Self.Caption := Format('Properties - %s (%s)', [
    FTargetEntity.BaseName, FTargetEntity.EtyClassCaption
  ]);
  //
  grdFields.Target := FTargetEntity.ProtoTypes;
  grdFields.LoadFromTarget;
  grdFields.CtrlDecos.HideControls;
  grdFields.CtrlDecos.OverrideCtrlEvent;
  //
//  grdEnumValue.Target := FDMBuilder.FEnumProtos;
  PageControl1.ActivePageIndex := 0;
end;

procedure Tfrm8EntityProto.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm8EntityProto.SetTargetEntity(const Value: T8MetaEntity);
var
  i: Integer;
begin
  FTargetEntity := Value;
{
  pageEntityPas.Caption     := ChangeFileExt(FTargetEntity.EntityUnit.UnitName, '.pas');
  pageDMPas.Caption         := ChangeFileExt(FTargetEntity.ManagerDMUnit.UnitName, '.pas');
  pageDMDfm.Caption         := ChangeFileExt(FTargetEntity.ManagerDMUnit.UnitName, '.dfm');
  pageDetailFormPas.Caption := ChangeFileExt(FTargetEntity.DetailUnit.UnitName, '.pas');
  pageDetailFormDfm.Caption := ChangeFileExt(FTargetEntity.DetailUnit.UnitName, '.dfm');
  pageListFormPas.Caption   := ChangeFileExt(FTargetEntity.ListUnit.UnitName, '.pas');
  pageListFormDfm.Caption   := ChangeFileExt(FTargetEntity.ListUnit.UnitName, '.dfm');
}
  //
  CheckListBox1.Items.Clear;
  CheckListBox1.Items.Add(pageEntityPas.Caption    );
  CheckListBox1.Items.Add(pageDMPas.Caption        );
  CheckListBox1.Items.Add(pageDMDfm.Caption        );
  CheckListBox1.Items.Add(pageDetailFormPas.Caption);
  CheckListBox1.Items.Add(pageDetailFormDfm.Caption);
  CheckListBox1.Items.Add(pageListFormPas.Caption  );
  CheckListBox1.Items.Add(pageListFormDfm.Caption  );
  for i := 0 to CheckListBox1.Items.Count -1 do
    CheckListBox1.Checked[i] := True;
end;

resourcestring
  c9Msg_Finished = '以下のファイルを作成しました: ';

procedure Tfrm8EntityProto.grdFieldsDblClick(Sender: TObject);
var
  frm: Tfrm8EnumDlg;
begin
  inherited;
  if grdFields.Row < 1 then Exit;
  if grdFields.Col = 15 then
  begin
    frm := Tfrm8EnumDlg.Create(nil);
    try
      frm.Members.Text := grdFields.Cells[15, grdFields.Row];
      if frm.ShowModal = mrOK then
        grdFields.Cells[15, grdFields.Row] := frm.Members.Text;
    finally
      FreeAndNil(frm);
    end;
  end;
end;

{
procedure Tfrm8EntityProto.DoGetIDConstName(Sender: TObject;
  AEtyClassName: string; var AIDConstName: string);
var
  m: Tc8MetaEntityMan;
  ety: T8MetaEntity;
begin
  AIDConstName := '';
  if not(FTargetEntity.OwnerComponent is Tc8MetaEntityMan) then Exit;
  m := Tc8MetaEntityMan(FTargetEntity.OwnerComponent);
  ety := m.Entities.FindByClassName(AEtyClassName);
  if ety <> nil then
    AIDConstName := ety.IDConstName;
end;
}

procedure Tfrm8EntityProto.RefreshValidMsg;
var
  i: Integer;
  validMan: Ts0ValidationMessager;
begin
  dspMsg.Lines.Clear;
  validMan := Ts0GlobalValidationManager.Instance;
  dspMsg.Lines.BeginUpdate;
  try
    for i := 0 to validMan.ItemCount -1 do
    begin
      dspMsg.Lines.Add(
        Format('[%s] %s', [
          c0ValidationKindStr[ validMan.Items[i].Kind ],
          validMan.Items[i].Message
        ])
      );
    end;
  finally
    dspMsg.Lines.EndUpdate;
  end;
end;

procedure Tfrm8EntityProto.TabSheet9Show(Sender: TObject);
//var
//  i: Integer;
begin
  Session.GetTableNames(DataBase.DatabaseName, '*', False, True, cmbTables.Items);
  //
{
  FDMBuilder.EnumProtos.BeginUpdate;
  try
    FDMBuilder.EnumProtos.Clear;
    for i := 0 to FTargetEntity.ProtoTypes.Count -1 do
      if FTargetEntity.ProtoTypes.Items[i].EnumName <> '' then
        FDMBuilder.EnumProtos.Add(FTargetEntity.ProtoTypes.Items[i].EnumName);
  finally
    FDMBuilder.EnumProtos.EndUpdate;
  end;
}
end;

procedure Tfrm8EntityProto.cmbFieldsDropDown(Sender: TObject);
var
  tbl: TTable;
  i: Integer;
begin
  tbl := TTable.Create(nil);
  try
    tbl.DatabaseName := DataBase.DatabaseName;
    tbl.SessionName := Session.SessionName;
    tbl.TableName := grdEnumValue.Cells[2, grdEnumValue.Row];
    tbl.Active := True;
    cmbFields.Clear;
    for i := 0 to tbl.Fields.Count -1 do
      cmbFields.Items.Add(tbl.Fields[i].FieldName);
  finally
    FreeAndNil(tbl);
  end;
end;

procedure Tfrm8EntityProto.actWriteFilesExecute(Sender: TObject);
var
  p: String;
  msg: string;

  function IsSaveTarget(AName: string): Boolean;
  var
    idx: Integer;
  begin
    Result := False;
    idx := CheckListBox1.Items.IndexOf(AName);
    if idx < 0 then Exit;
    Result := CheckListBox1.Checked[idx];
  end;
  procedure SaveSources(APage: TTabSheet; ACode: TStrings);
  begin
    if not IsSaveTarget(APage.Caption) then Exit;
    ACode.SaveToFile(p + APage.Caption);
    msg := msg +#13#10+ APage.Caption;
  end;
begin
  msg := '';
  p := IncludeTrailingBackslash( Tc8MetaEntityMan(TargetEntity.OwnerComponent).EntityDir );
  //
  SaveSources(pageEntityPas    , dspEntityPas.Lines     );
  SaveSources(pageDMPas        , dspDMPas.Lines         );
  SaveSources(pageDMDfm        , dspDMDfm.Lines         );
  SaveSources(pageDetailFormPas, dspDetailFormPas.Lines );
  SaveSources(pageDetailFormDfm, dspDetailFormDfm.Lines );
  SaveSources(pageListFormPas  , dspListFormPas.Lines   );
  SaveSources(pageListFormDfm  , dspListFormDfm.Lines   );
  //
  RefreshValidMsg;
  msg := c9Msg_Finished +#13#10 + msg;
  ShowMessage( msg );
end;

procedure Tfrm8EntityProto.actGenerateSQLsExecute(Sender: TObject);
begin
//  if FDMBuilder.SQLGenerated then Exit;
  if not DataBase.Connected then
    DataBase.Connected := True;
//  FDMBuilder.SQLGenerator.TableName := FTargetEntity.Table.TableName;
//  FDMBuilder.SQLGenerator.Source := FTargetEntity.ProtoTypes;
//  FDMBuilder.GenerateSQLs;
{
  edtSelEntities.Lines.Assign(FDMBuilder.SQLs[k0edsDetail]);
  edtSelEntity.Lines.Assign(FDMBuilder.SQLs[k0edsLoadKey]);
  edtInsEntity.Lines.Assign(FDMBuilder.SQLs[k0edsInsert]);
  edtUpdEntity.Lines.Assign(FDMBuilder.SQLs[k0edsUpdate]);
  edtDelEntity.Lines.Assign(FDMBuilder.SQLs[k0edsRemove]);
}
//  FDMBuilder.SQLGenerated := True;
  RefreshValidMsg;
  //
  PageControl1.ActivePage := TabSheet3; 
end;

procedure Tfrm8EntityProto.actGenerateSourceExecute(Sender: TObject);
var
  prm: T8BuilderParam;

  procedure BuildEntityUnit(AUnit: T0SXMetaUnit);
  //var
  //  builder: T8EntityUnitBuilder;
  begin
{
    builder := T8EntityUnitBuilder.Create(nil);
    try
      //builder.Params := prm;
      builder.Target := AUnit;
      builder.Execute;
    finally
      FreeAndNil(builder);
    end;
}
  end;

  procedure BuildDMUnit(AUnit: T0SXMetaUnit; AEtyUnitName: string; ATemplate: Tdm8EntityTemplate);
  var
    variable: T0SXMetaVariable;
  begin
    variable := T0SXMetaVariable(AUnit.Variables.Add);
    variable.Name := FTargetEntity.Files.ManagerDM.UnitClass;
    variable.TypeName := 'T' + FTargetEntity.Files.ManagerDM.UnitClass;
    AUnit.ImplComment := AUnit.Comments.Add('{$R *.DFM}');
    AUnit.ImplComment.CommentKind := k0ckCustom;
    //
    AUnit.UsesIntf.Add( 'Windows'             );
    AUnit.UsesIntf.Add( 'Messages'            );
    AUnit.UsesIntf.Add( 'SysUtils'            );
    AUnit.UsesIntf.Add( 'Classes'             );
    AUnit.UsesIntf.Add( 'Graphics'            );
    AUnit.UsesIntf.Add( 'Controls'            );
    AUnit.UsesIntf.Add( 'Forms'               );
    AUnit.UsesIntf.Add( 'Dialogs'             );
    AUnit.UsesIntf.Add( 's0Entity'            );
    AUnit.UsesIntf.Add( 's0EntityFormManager' );
    AUnit.UsesIntf.Add( 'Db'                  );
    AUnit.UsesIntf.Add( 'DBTables'            );
    AUnit.UsesIntf.Add( 's0DBEntity'          );
    AUnit.UsesIntf.Add( 's0Query'             );
    AUnit.UsesIntf.Add( AEtyUnitName );
    AUnit.UsesImpl.Add( Tc8MetaEntityMan(FTargetEntity.OwnerComponent).IDDefineUnitName );
    //
    //FDMBuilder.Params := prm;
    //FDMBuilder.DestDFM := dspDMDfm.Lines;
    //FDMBuilder.OnGetIDConstName := DoGetIDConstName;
    //FDMBuilder.MetaUnit := AUnit;
    //FDMBuilder.Template := ATemplate;
    FDMBuilder.Execute;
  end;

  procedure BuildDetailForm(AUnit: T0SXMetaUnit);
  var
    dfBuilder: T8DetailFormBuilder;
    variable: T0SXMetaVariable;
  begin
    AUnit.InitializationCode.Add(
      Format('  RegisterDispClass(T%s);', [FTargetEntity.Files.DetailForm.UnitClass])
    );
    AUnit.FinalizationCode.Add(
      Format('  UnRegisterDispClass(T%s);', [FTargetEntity.Files.DetailForm.UnitClass])
    );
    variable := T0SXMetaVariable(AUnit.Variables.Add);
    variable.Name := FTargetEntity.Files.DetailForm.UnitClass;
    variable.TypeName := 'T' + FTargetEntity.Files.DetailForm.UnitClass;
    AUnit.ImplComment := AUnit.Comments.Add('{$R *.DFM}');
    AUnit.ImplComment.CommentKind := k0ckCustom;
    AUnit.UsesIntf.Add( 'Windows' );
    AUnit.UsesIntf.Add( 'Messages' );
    AUnit.UsesIntf.Add( 'SysUtils' );
    AUnit.UsesIntf.Add( 'Classes' );
    AUnit.UsesIntf.Add( 'Graphics' );
    AUnit.UsesIntf.Add( 'Controls' );
    AUnit.UsesIntf.Add( 'Forms' );
    AUnit.UsesIntf.Add( 'Dialogs' );
    AUnit.UsesIntf.Add( 's0Entity' );
    AUnit.UsesIntf.Add( 's0f1EntityDetail' );
    AUnit.UsesIntf.Add( 'ActnList' );
    AUnit.UsesIntf.Add( 's0f0EntityDisplay' );
    AUnit.UsesIntf.Add( 's0EntityDetailImpl' );
    AUnit.UsesIntf.Add( 's0FormEventPublisher' );
    AUnit.UsesIntf.Add( 's0FormRelation' );
    AUnit.UsesIntf.Add( 'ComCtrls' );
    AUnit.UsesIntf.Add( 's0ObjCtrlBuilder' );
    AUnit.UsesIntf.Add( 's0UnifiedObjCtrl' );
    AUnit.UsesIntf.Add( 'Menus' );
    AUnit.UsesIntf.Add( FTargetEntity.Files.EntityUnit.UnitName );
//    dfBuilder := T8DetailFormBuilder.Create;
    try
      //dfBuilder.Params := prm;
//      dfBuilder.MetaUnit := AUnit;
//      dfBuilder.DestDFM := dspDetailFormDfm.Lines;
      dfBuilder.Execute;
    finally
      FreeAndNil(dfBuilder);
    end;
  end;

  procedure BuildListForm(AUnit: T0SXMetaUnit);
  var
    lfBuilder: T8ListFormBuilder;
    variable: T0SXMetaVariable;
  begin
    AUnit.InitializationCode.Add(
      Format('  RegisterDispClass(T%s);', [FTargetEntity.Files.ListForm.UnitClass])
    );
    AUnit.FinalizationCode.Add(
      Format('  UnRegisterDispClass(T%s);', [FTargetEntity.Files.ListForm.UnitClass])
    );
    variable := T0SXMetaVariable(AUnit.Variables.Add);
    variable.Name := FTargetEntity.Files.ListForm.UnitClass;
    variable.TypeName := 'T' + FTargetEntity.Files.ListForm.UnitClass;
    AUnit.ImplComment := AUnit.Comments.Add('{$R *.DFM}');
    AUnit.ImplComment.CommentKind := k0ckCustom;
    AUnit.UsesIntf.Add( 'Windows' );
    AUnit.UsesIntf.Add( 'Messages' );
    AUnit.UsesIntf.Add( 'SysUtils' );
    AUnit.UsesIntf.Add( 'Classes' );
    AUnit.UsesIntf.Add( 'Graphics' );
    AUnit.UsesIntf.Add( 'Controls' );
    AUnit.UsesIntf.Add( 'Forms' );
    AUnit.UsesIntf.Add( 'Dialogs' );
    AUnit.UsesIntf.Add( 's0f1EntityDBGridList' );
    AUnit.UsesIntf.Add( 'ActnList' );
    AUnit.UsesIntf.Add( 'Db' );
    AUnit.UsesIntf.Add( 's0f0EntityDisplay' );
    AUnit.UsesIntf.Add( 's0EntityListImpl' );
    AUnit.UsesIntf.Add( 's0FormEventPublisher' );
    AUnit.UsesIntf.Add( 's0FormRelation' );
    AUnit.UsesIntf.Add( 'ComCtrls' );
    AUnit.UsesIntf.Add( 'Grids' );
    AUnit.UsesIntf.Add( 'DBGrids' );
    AUnit.UsesIntf.Add( 's0Entity' );
    AUnit.UsesIntf.Add( FTargetEntity.Files.EntityUnit.UnitName );
    //lfBuilder := T8ListFormBuilder.Create;
    try
      //lfBuilder.Params := prm;
      //lfBuilder.MetaUnit := AUnit;
      //lfBuilder.DestDFM := dspListFormDfm.Lines;
      lfBuilder.Execute;
    finally
      FreeAndNil(lfBuilder);
    end;
  end;         

  procedure WriteUnit(AUnit: T0SXMetaUnit; Dest: TStrings);
  var
    writer: T0SXMetaClassWriter;
  begin
    writer := T0SXMetaClassWriter.Create;
    try
      AUnit.RefreshSequence;
      writer.Execute( AUnit );
      Dest.Assign(writer.Dest);
    finally
      FreeAndNil(writer);
    end;
  end;
var
  unitEntity: T0SXMetaUnit;
  unitDM: T0SXMetaUnit;
  unitDetail: T0SXMetaUnit;
  unitList: T0SXMetaUnit;
  dmTemplate: Tdm8EntityTemplate;
begin
  prm := T8BuilderParam.Create;
  try
    prm.TargetMetaEntity := FTargetEntity;
    prm.IDDefineUnitName := Tc8MetaEntityMan(FTargetEntity.OwnerComponent).IDDefineUnitName;
    prm.SessionName := FSession.SessionName;
    prm.DataBaseName := FDataBase.DatabaseName;
    //
    Ts0GlobalValidationManager.Instance.ClearMsg;
    try
{
      FDMBuilder.SQLs[k0edsDetail].Assign( edtSelEntities.Lines );
      FDMBuilder.SQLs[k0edsLoadKey].Assign( edtSelEntity.Lines  );
      FDMBuilder.SQLs[k0edsInsert].Assign( edtInsEntity.Lines   );
      FDMBuilder.SQLs[k0edsUpdate].Assign( edtUpdEntity.Lines   );
      FDMBuilder.SQLs[k0edsRemove].Assign( edtDelEntity.Lines   );
}
      grdFields.SaveToTarget;
      FProdProj.Units.Clear;

      unitEntity := FProdProj.Units.AddUnit( FTargetEntity.Files.EntityUnit.UnitName );
      unitDM := FProdProj.Units.AddUnit( FTargetEntity.Files.ManagerDM.UnitName );
      unitList := FProdProj.Units.AddUnit( FTargetEntity.Files.ListForm.UnitName );
      unitDetail := FProdProj.Units.AddUnit( FTargetEntity.Files.DetailForm.UnitName );

      dmTemplate := Tdm8EntityTemplate.Create(nil);
      try
        BuildDMUnit( unitDM, unitEntity.Name, dmTemplate);
        prm.ProtoTypes := dmTemplate.EntityManager.ProtoTypes;

        BuildEntityUnit( unitEntity );
        BuildDetailForm( unitDetail );
        BuildListForm( unitList );
        //
        WriteUnit(unitDM    , dspDMPas.Lines        );
        WriteUnit(unitEntity, dspEntityPas.Lines    );
        WriteUnit(unitDetail, dspDetailFormPas.Lines);
        WriteUnit(unitList  , dspListFormPas.Lines  );
      finally
        FreeAndNil(dmTemplate);
      end;
    finally
      RefreshValidMsg;
    end;
  finally
    FreeAndNil(prm);
  end;
  PageControl1.ActivePage := TabSheet2; 
  actWriteFiles.Enabled := True;
end;

procedure Tfrm8EntityProto.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure Tfrm8EntityProto.actLoadFieldsExecute(Sender: TObject);
  procedure PrepareTableFields(ATargetDefs: TFieldDefs; AProtos: Ts0EntityPropProtos);
  var
    i: Integer;
    p: Ts0EntityPropProto;
  begin
    ATargetDefs.Clear;
    for i := 0 to AProtos.Count -1 do
    begin
      p := AProtos.Items[i];
      if p.FieldName = '' then Continue;
      ATargetDefs.Add(p.FieldName, p.FieldType, p.FieldSize, p.IsRequired);
    end;
  end;
  procedure PrepareTableIndexes(ATargetDefs: TIndexDefs; AProtos: Ts0EntityPropProtos);
  var
    idProp: Ts0EntityPropProto;
  begin
    ATargetDefs.Clear;
    idProp := AProtos.IDProp;
    if idProp = nil then Exit;
    ATargetDefs.Add(idProp.FieldName, idProp.FieldName, [ixUnique]);
  end;
begin
  s0Table1.DatabaseName := DataBase.DatabaseName;
  s0Table1.SessionName := Session.SessionName;
  s0Table1.TableName := TargetEntity.Table.TableName;
  PrepareTableFields(s0Table1.FieldDefs, TargetEntity.ProtoTypes);
  PrepareTableIndexes(s0Table1.IndexDefs, TargetEntity.ProtoTypes);
  s0UnifiedObjCtrl1.LoadFromTarget;
  //
  PageControl1.ActivePage := TabSheet10;
end;

resourcestring
  c9ConfigmMsg_DeleteTable = '既にテーブルは存在しています。削除してもよろしいですか？';

procedure Tfrm8EntityProto.actCreateTableExecute(Sender: TObject);
begin
  s0Table1.DatabaseName := DataBase.DatabaseName;
  s0Table1.SessionName := Session.SessionName;
  s0Table1.TableName := TargetEntity.Table.TableName;
  s0Table1.TableType := ttDefault;
  if not DataBase.Connected then
    DataBase.Connected := True;
  if s0Table1.Exists then
  begin
    if MessageDlg(c9ConfigmMsg_DeleteTable, mtConfirmation, [mbYes,mbCancel], 0) = mrCancel then Exit;
    s0Table1.DeleteTable;
  end;
  if s0Table1.TableName = '' then Exit;
  s0Table1.CreateTable;
end;

end.
