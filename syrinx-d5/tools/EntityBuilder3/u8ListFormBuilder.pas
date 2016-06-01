unit u8ListFormBuilder;

interface

uses
  SysUtils, Classes,
  s8EntityUnitWriter,
  u8MetaEntities,
  //
  u0SXMetaClass,
  s0PropertyProtoType,
  s0f1EntityDBGridList,
  f8EntityListTemplate,
  s0EntityPropProto;

type
  T8ListFormBuilder = class(Ts8EntityUnitWriter)
  private
    FDestDFM: TStrings;
    FDefinedList: TStrings;
    FListFormName: string;
    FEntityClassName: string;
    FEntityUnitName: string;
    function IsDefined(ACompoName: string): Boolean;
    procedure SaveDFMToList(Dest: TStrings; AAncestor: Ts0frmEntityDBGridList; AForm: Tfrm8EntityListTemplate);
    procedure GenerateMetaClass(AMeta: T0SXMetaClass;
      AForm: Tfrm8EntityListTemplate);
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

{ T8ListFormBuilder }

destructor T8ListFormBuilder.Destroy;
begin
  FreeAndNil(FDefinedList);
  inherited Destroy;
end;

procedure T8ListFormBuilder.Execute;
var
  tempAncs: Ts0frmEntityDBGridList;
  template: Tfrm8EntityListTemplate;
  frm: T0SXMetaClass;
begin
  template := Tfrm8EntityListTemplate.Create(nil);
  try
    template.Name := FListFormName;
    tempAncs := Ts0frmEntityDBGridList.Create(nil);
    try
      SaveDFMToList(FDestDFM, tempAncs, template);
    finally
      FreeAndNil(tempAncs);
    end;
    //
    frm := T0SXMetaClass.Create(nil);
    frm.Name := 'T' + FListFormName;
    frm.SuperClassName := 'Ts0frmEntityDBGridList';
    frm.Collection := MetaUnit.Types;
    GenerateMetaClass(frm, template);
    //
    InitUnit;
    WritePas;
  finally
    FreeAndNil(template);
  end;
end;

procedure T8ListFormBuilder.GenerateMetaClass(AMeta: T0SXMetaClass; AForm: Tfrm8EntityListTemplate);
var
  i: Integer;
  fld: T0SXMetaField;
  mthd: T0SXMetaMethod;
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
end;

procedure T8ListFormBuilder.InitByMetaEntity(AEntity: T8MetaEntity);
begin
  FDestPas := AEntity.Files.ListForm.PasLines;
  FDestDFM := AEntity.Files.ListForm.DfmLines;
  FEntityClassName := AEntity.EtyClassName;
  FEntityUnitName := AEntity.Files.EntityUnit.UnitName;
  FListFormName := AEntity.Files.ListForm.UnitClass;
  if (FListFormName <> '') and (FListFormName[1] = 'T') then
    Delete(FListFormName, 1, 1);
end;

procedure T8ListFormBuilder.InitUnit;
var
  variable: T0SXMetaVariable;
begin
  MetaUnit.InitializationCode.Add(
    Format('  RegisterDispClass(T%s);', [FListFormName])
  );
  MetaUnit.FinalizationCode.Add(
    Format('  UnRegisterDispClass(T%s);', [FListFormName])
  );
  variable := T0SXMetaVariable(MetaUnit.Variables.Add);
  variable.Name := FListFormName;
  variable.TypeName := 'T' + FListFormName;
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
  MetaUnit.UsesIntf.Add( 's0f1EntityDBGridList' );
  MetaUnit.UsesIntf.Add( 'ActnList' );
  MetaUnit.UsesIntf.Add( 'Db' );
  MetaUnit.UsesIntf.Add( 's0f0EntityDisplay' );
  MetaUnit.UsesIntf.Add( 's0EntityListImpl' );
  MetaUnit.UsesIntf.Add( 's0FormEventPublisher' );
  MetaUnit.UsesIntf.Add( 's0FormRelation' );
  MetaUnit.UsesIntf.Add( 'ComCtrls' );
  MetaUnit.UsesIntf.Add( 'Grids' );
  MetaUnit.UsesIntf.Add( 'DBGrids' );
  MetaUnit.UsesIntf.Add( 's0Entity' );
  MetaUnit.UsesIntf.Add( FEntityUnitName );
end;

procedure T8ListFormBuilder.InitWriter;
begin
  FDefinedList := TStringList.Create;
  FDefinedList.Add('s0FormRelation1');
  FDefinedList.Add('impList');
  FDefinedList.Add('DataSource1');
  FDefinedList.Add('ActionList1');
  FDefinedList.Add('actRefresh');
  FDefinedList.Add('grdEntities');
  FDefinedList.Add('actNewEntity');
  FDefinedList.Add('actRemoveEntity');
  FDefinedList.Add('actClose');
  FDefinedList.Add('StatusBar1');
  FDefinedList.Add('actEditEntity');
  FDefinedList.Add('actShowDetail');
end;

function T8ListFormBuilder.IsDefined(ACompoName: string): Boolean;
begin
  Result := FDefinedList.IndexOf(ACompoName) > -1;
end;

procedure T8ListFormBuilder.SaveDFMToList(Dest: TStrings;
  AAncestor: Ts0frmEntityDBGridList; AForm: Tfrm8EntityListTemplate);
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
      Dest.Text := StringReplace(FDestDFM.Text, 'frm8EntityListTemplate', AForm.Name, [rfReplaceAll]);
    finally
      Dest.EndUpdate;
    end;
  finally
    FreeAndNil(ms1);
  end;
end;

end.
