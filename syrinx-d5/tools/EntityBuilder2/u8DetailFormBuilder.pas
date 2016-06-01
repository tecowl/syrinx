unit u8DetailFormBuilder;

interface

uses
  SysUtils, Classes,
  u0SXMetaClass,
  s0PropertyProtoType,
  s0f1EntityDetail,
  f8EntityDetailTemplate,
  u8BuilderParam,
  s0EntityPropProto;

type
  T8DetailFormBuilder = class
  private
    FMetaUnit: T0SXMetaUnit;
    FDestDFM: TStrings;
    FDefinedList: TStrings;
    FParams: T8BuilderParam;
    function IsDefined(ACompoName: string): Boolean;
    procedure SaveDFMToList(Dest: TStrings; AAncestor: Ts0frmEntityDetail; AForm: Tfrm8EntityDetailTemplate);
    procedure GenerateMetaClass(AMeta: T0SXMetaClass;
      AForm: Tfrm8EntityDetailTemplate);
    function GetDetailFormName: string;
    function GetEntityClassName: string;
    function GetProtoTypes: Ts0EntityPropProtos;
  public
    constructor Create;
    destructor Destroy; override;
    property ProtoTypes: Ts0EntityPropProtos read GetProtoTypes;
    property MetaUnit: T0SXMetaUnit read FMetaUnit write FMetaUnit;
    property DetailFormName: string read GetDetailFormName;
    property EntityClassName: string read GetEntityClassName;
    property DestDFM: TStrings read FDestDFM write FDestDFM;
    property Params: T8BuilderParam read FParams write FParams;
    procedure Execute;
  end;

implementation

uses
  s0ObjectHelper;

{ T8DetailFormBuilder }

constructor T8DetailFormBuilder.Create;
begin
  inherited Create;
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
    template.Name := DetailFormName;
    template.s0UnifiedObjCtrl1.ProtoTypes.Assign( ProtoTypes );
    template.s0UnifiedObjCtrl1.BuildCtrls;
    template.s0UnifiedObjCtrl1.LoadFromTarget;
    tempAncs := Ts0frmEntityDetail.Create(nil);
    try
      SaveDFMToList(DestDFM, tempAncs, template);
    finally
      FreeAndNil(tempAncs);
    end;
    //
    frm := T0SXMetaClass.Create(nil);
    frm.Name := 'T' + DetailFormName;
    frm.SuperClassName := 'Ts0frmEntityDetail';
    frm.Collection := MetaUnit.Types;
    GenerateMetaClass(frm, template);
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
    Format('  Result := %s;', [EntityClassName])
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

function T8DetailFormBuilder.GetDetailFormName: string;
begin
  Result := Params.TargetMetaEntity.DetailFormName;
end;

function T8DetailFormBuilder.GetEntityClassName: string;
begin
  Result := Params.TargetMetaEntity.EtyClassName;
end;

function T8DetailFormBuilder.GetProtoTypes: Ts0EntityPropProtos;
begin
  Result := Params.ProtoTypes;
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
      Dest.Text := StringReplace(DestDFM.Text, 'frm8EntityDetailTemplate', AForm.Name, [rfReplaceAll]);
    finally
      Dest.EndUpdate;
    end;
  finally
    FreeAndNil(ms1);
  end;
end;

end.
