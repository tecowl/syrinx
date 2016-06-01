program EntityBuilder2;

uses
  Forms,
  f0SelectItems in 'f0SelectItems.pas' {frm0SelectItems},
  u8MetaEntities in 'u8MetaEntities.pas',
  f0SelectTables in 'f0SelectTables.pas' {frm0SelectTables},
  f8EBMain in 'f8EBMain.pas' {frm8EBMain},
  f8EntityProto in 'f8EntityProto.pas' {frm8EntityProto},
  u8SQLGenerator in 'u8SQLGenerator.pas',
  u8EntityUnitBuilder in 'u8EntityUnitBuilder.pas',
  u8DMBuilder in 'u8DMBuilder.pas',
  d8EntityTemplate in 'd8EntityTemplate.pas' {dm8EntityTemplate: TDataModule},
  f8EnumDlg in 'f8EnumDlg.pas' {frm8EnumDlg},
  f8EntityListTemplate in 'f8EntityListTemplate.pas' {frm8EntityListTemplate},
  u8ListFormBuilder in 'u8ListFormBuilder.pas',
  f8EntityDetailTemplate in 'f8EntityDetailTemplate.pas' {frm8EntityDetailTemplate},
  u8DetailFormBuilder in 'u8DetailFormBuilder.pas',
  u8BuilderParam in 'u8BuilderParam.pas',
  u0SXMetaClass in 'u0SXMetaClass.pas',
  u0SXMetaClassWriter in 'u0SXMetaClassWriter.pas',
  s0f0EntityDisplay in '..\..\D5\source\Forms\s0f0EntityDisplay.pas' {s0frmEntityDisplay},
  s0f1EntityDetail in '..\..\D5\source\Forms\s0f1EntityDetail.pas' {s0frmEntityDetail},
  s0f1EntityDBGridList in '..\..\D5\source\Forms\s0f1EntityDBGridList.pas' {s0frmEntityDBGridList},
  s0fObjPropEditor in '..\..\D5\source\VCL\s0fObjPropEditor.pas' {s0frmObjPropEditor},
  d8EntityBuilder in 'd8EntityBuilder.pas' {dm8EntityBuilder: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm8EBMain, frm8EBMain);
  Application.CreateForm(Ts0frmEntityDisplay, s0frmEntityDisplay);
  Application.CreateForm(Ts0frmEntityDetail, s0frmEntityDetail);
  Application.CreateForm(Ts0frmEntityDBGridList, s0frmEntityDBGridList);
  Application.CreateForm(Tdm8EntityBuilder, dm8EntityBuilder);
  Application.Run;
end.
