unit u8DetailFormBuilder;

interface

uses
  SysUtils, Classes,
  s8EntityUnitWriter,
  u8MEtaEntities,
  //
  u0SXMetaClass,
  s0PropertyProtoType,
  s0f1EntityDetail,
  f8EntityDetailTemplate,
//  u8BuilderParam,
  s0EntityPropProto;

type
  T8DetailFormBuilder = class(Ts8EntityUnitWriter)
  private
    FDestDFM: TStrings;
    FDefinedList: TStrings;
    FDetailFormName: string;
    FEntityClassName: string;
    FEntityUnitName: string;
    function IsDefined(ACompoName: string): Boolean;
    procedure SaveDFMToList(Dest: TStrings; AAncestor: Ts0frmEntityDetail; AForm: Tfrm8EntityDetailTemplate);
    procedure GenerateMetaClass(AMeta: T0SXMetaClass;
      AForm: Tfrm8EntityDetailTemplate);
  protected
    procedure InitUnit; override;
    procedure InitWriter; override;
  public
    destructor Destroy; override;
    procedure Execute; override;
    procedure InitByMetaEntity(AEntity: T8MetaEntity); override;
  end;

implementation

uses
  s0ObjectHelper;

{ T8DetailFormBuilder }

destructor T8DetailFormBuilder.Destroy;
begin
  FreeAndNil(FDefinedList);
  inherited Destroy;
end;

procedure T8DetailFormBuilder.Execute;
var
  tempAncs: Ts0frmEntityDetail;
  template: Tfrm8EntityDetailTemplate;
  frm: T0SXMetaClass;
begin
  template := Tfrm8EntityDetailTemplate.Create(nil);
  try
    template.Name := FDetailFormName;
    template.s0UnifiedObjCtrl1.ProtoTypes.Assign( ProtoTypes );
    template.s0UnifiedObjCtrl1.ApplyCtrlClassNames;
    template.s0UnifiedObjCtrl1.StandInCtrls;
    template.s0UnifiedObjCtrl1.BuildCtrls;
    template.s0UnifiedObjCtrl1.LoadFromTarget;
    tempAncs := Ts0frmEntityDetail.Create(nil);
    try
      SaveDFMToList(FDestDFM, tempAncs, template);
    finally
      FreeAndNil(tempAncs);
    end;
    //
    frm := T0SXMetaClass.Create(nil);
    frm.Name := 'T' + FDetailFormName;
    frm.SuperClassName := 'Ts0frmEntityDetail';
    frm.Collection := MetaUnit.Types;
    GenerateMetaClass(frm, template);
    //
    InitUnit;
    WritePas;
  finally
    FreeAndNil(template);
  end;
end;

procedure T8DetailFormBuilder.GenerateMetaClass(AMeta: T0SXMetaClass;
  AForm: Tfrm8EntityDetailTemplate);
var
  i: Integer;
  fld: T0SXMetaField;
  mthd: T0SXMetaMethod;
  sl: TStrings;
begin
  for i := 0 to AForm.ComponentCount -1 do
  begin
    if IsDefined(AForm.Components[i].Name) then Continue;
    fld := AMeta.Fields.Add(AForm.Components[i].Name, AForm.Components[i].ClassName);
    fld.Visibility := k0cpvNone;
  end;
  mthd := AMeta.Methods.Add( 'GetTargetClassBeforeCreate', 'Ts0EntityClass', True);
  mthd.Visibility := k0cpvPublic;
  mthd.MethodKind := k0mkOverride;
  mthd.IsStatic := True;
  mthd.ImplMethod.ImplementCode.Add(
    Format('  Result := %s;', [FEntityClassName])
  );
  //
  mthd := AMeta.Methods.Add( 'impDetailDetailLoad', '', True);
  mthd.Params.AddParam('Sender', 'TObject');
  mthd.Visibility := k0cpvNone;
  mthd.MethodKind := k0mkFinal;
  mthd.IsStatic := False;
  sl := mthd.ImplMethod.ImplementCode;
  sl.Add('  //Entityのデータをフォームに反映させる');
  sl.Add('  s0UnifiedObjCtrl1.LoadFromTarget;' );
  //
  mthd := AMeta.Methods.Add( 'impDetailDetailSave', '', True);
  mthd.Params.AddParam('Sender', 'TObject');
  mthd.Visibility := k0cpvNone;
  mthd.MethodKind := k0mkFinal;
  mthd.IsStatic := False;
  sl := mthd.ImplMethod.ImplementCode;
  sl.Add('  //OnChangeイベントを起こさないように、BeginUpdate～EndUpdateを行う。');
  sl.Add('  impDetail.DispTarget.BeginUpdate;');
  sl.Add('  try');
  sl.Add('    //フォームに入力されている内容をEntityに反映させる');
  sl.Add('    s0UnifiedObjCtrl1.SaveToTarget;');
  sl.Add('  finally');
  sl.Add('    impDetail.DispTarget.EndUpdate;');
  sl.Add('  end;');
  //
  mthd := AMeta.Methods.Add( 'impDetailSetTarget', '', True);
  mthd.Params.AddParam('Sender', 'TObject');
  mthd.Visibility := k0cpvNone;
  mthd.MethodKind := k0mkFinal;
  mthd.IsStatic := False;
  sl := mthd.ImplMethod.ImplementCode;
  sl.Add('  //impDetailに対して設定されたEntity(=impDetail.DispTarget)を');
  sl.Add('  //s0UnifiedObjCtrl1のTargetに設定する。');
  sl.Add('  s0UnifiedObjCtrl1.Target := impDetail.DispTarget;');
end;

procedure T8DetailFormBuilder.InitByMetaEntity(AEntity: T8MetaEntity);
begin
  FDestPas := AEntity.Files.DetailForm.PasLines;
  FDestDFM := AEntity.Files.DetailForm.DfmLines;
  FEntityClassName := AEntity.EtyClassName;
  FEntityUnitName := AEntity.Files.EntityUnit.UnitName;
  FDetailFormName := AEntity.Files.DetailForm.UnitClass;
  if (FDetailFormName <> '') and (FDetailFormName[1] = 'T') then
    Delete(FDetailFormName, 1, 1);
end;

procedure T8DetailFormBuilder.InitUnit;
var
  variable: T0SXMetaVariable;
begin
  MetaUnit.InitializationCode.Add(
    Format('  RegisterDispClass(T%s);', [FDetailFormName])
  );
  MetaUnit.FinalizationCode.Add(
    Format('  UnRegisterDispClass(T%s);', [FDetailFormName])
  );
  variable := T0SXMetaVariable(MetaUnit.Variables.Add);
  variable.Name := FDetailFormName;
  variable.TypeName := 'T' + FDetailFormName;
  MetaUnit.ImplComment := MetaUnit.Comments.Add('{$R *.DFM}');
  MetaUnit.ImplComment.CommentKind := k0ckCustom;
  MetaUnit.UsesIntf.Add( 'Windows' );
  MetaUnit.UsesIntf.Add( 'Messages' );
  MetaUnit.UsesIntf.Add( 'SysUtils' );
  MetaUnit.UsesIntf.Add( 'Classes' );
  MetaUnit.UsesIntf.Add( 'Graphics' );
  MetaUnit.UsesIntf.Add( 'Controls' );
  MetaUnit.UsesIntf.Add( 'Forms' );
  MetaUnit.UsesIntf.Add( 'Dialogs' );
  MetaUnit.UsesIntf.Add( 's0Entity' );
  MetaUnit.UsesIntf.Add( 's0f1EntityDetail' );
  MetaUnit.UsesIntf.Add( 'ActnList' );
  MetaUnit.UsesIntf.Add( 's0f0EntityDisplay' );
  MetaUnit.UsesIntf.Add( 's0EntityDetailImpl' );
  MetaUnit.UsesIntf.Add( 's0FormEventPublisher' );
  MetaUnit.UsesIntf.Add( 's0FormRelation' );
  MetaUnit.UsesIntf.Add( 'ComCtrls' );
  MetaUnit.UsesIntf.Add( 's0ObjCtrlBuilder' );
  MetaUnit.UsesIntf.Add( 's0UnifiedObjCtrl' );
  MetaUnit.UsesIntf.Add( 'Menus' );
  MetaUnit.UsesIntf.Add( FEntityUnitName );
end;

procedure T8DetailFormBuilder.InitWriter;
begin
  FDefinedList := TStringList.Create;
  FDefinedList.Add('s0FormRelation1');
  FDefinedList.Add('impDetail');
  FDefinedList.Add('ActionList1');
  FDefinedList.Add('actShowNaviList');
  FDefinedList.Add('actRefresh');
  FDefinedList.Add('actNewEntity');
  FDefinedList.Add('actSaveEntity');
  FDefinedList.Add('actRemoveEntity');
  FDefinedList.Add('actClose');
  FDefinedList.Add('actReadOnly');
  FDefinedList.Add('StatusBar1');
end;

function T8DetailFormBuilder.IsDefined(ACompoName: string): Boolean;
begin
  Result := FDefinedList.IndexOf(ACompoName) > -1;
end;

procedure T8DetailFormBuilder.SaveDFMToList(Dest: TStrings;
  AAncestor: Ts0frmEntityDetail; AForm: Tfrm8EntityDetailTemplate);
var
  ms1, ms2: TMemoryStream;
begin
  ms1 := TMemoryStream.Create;
  try
    ms2 := TMemoryStream.Create;
    try
      ms2.WriteDescendent(AForm, AAncestor);
      ms2.Position := 0;
      ObjectBinaryToText(ms2, ms1);
    finally
      FreeAndNil(ms2);
    end;
    ms1.Position := 0;
    Dest.BeginUpdate;
    try
      Dest.LoadFromStream(ms1);
      { インスタンス名、クラス名を変更 }
      Dest.Text := StringReplace(FDestDFM.Text, 'frm8EntityDetailTemplate', AForm.Name, [rfReplaceAll]);
    finally
      Dest.EndUpdate;
    end;
  finally
    FreeAndNil(ms1);
  end;
end;

end.
