unit u8ListFormBuilder;

interface

uses
  SysUtils, Classes,
  u0SXMetaClass,
  s0PropertyProtoType,
  s0f1EntityDBGridList,
  f8EntityListTemplate,
  u8BuilderParam,
  s0EntityPropProto;

type
  T8ListFormBuilder = class
  private
    FMetaUnit: T0SXMetaUnit;
    FDestDFM: TStrings;
    FDefinedList: TStrings;
    FParams: T8BuilderParam;
    function IsDefined(ACompoName: string): Boolean;
    procedure SaveDFMToList(Dest: TStrings; AAncestor: Ts0frmEntityDBGridList; AForm: Tfrm8EntityListTemplate);
    procedure GenerateMetaClass(AMeta: T0SXMetaClass;
      AForm: Tfrm8EntityListTemplate);
    function GetEntityClassName: string;
    function GetListFormName: string;
  public
    constructor Create;
    destructor Destroy; override;
    property MetaUnit: T0SXMetaUnit read FMetaUnit write FMetaUnit;
    property ListFormName: string read GetListFormName;
    property DestDFM: TStrings read FDestDFM write FDestDFM;
    property EntityClassName: string read GetEntityClassName;
    property Params: T8BuilderParam read FParams write FParams;
    procedure Execute;
  end;

implementation

uses
  s0ObjectHelper;

{ T8ListFormBuilder }

constructor T8ListFormBuilder.Create;
begin
  inherited Create;
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
    template.Name := ListFormName;
    tempAncs := Ts0frmEntityDBGridList.Create(nil);
    try
      SaveDFMToList(DestDFM, tempAncs, template);
    finally
      FreeAndNil(tempAncs);
    end;
    //
    frm := T0SXMetaClass.Create(nil);
    frm.Name := 'T' + ListFormName;
    frm.SuperClassName := 'Ts0frmEntityDBGridList';
    frm.Collection := MetaUnit.Types;
    GenerateMetaClass(frm, template);
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
    Format('  Result := %s;', [EntityClassName])
  );
end;

function T8ListFormBuilder.GetEntityClassName: string;
begin
  Result := FParams.TargetMetaEntity.EtyClassName; 
end;

function T8ListFormBuilder.GetListFormName: string;
begin
  Result := FParams.TargetMetaEntity.ListFormName;
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
      Dest.Text := StringReplace(DestDFM.Text, 'frm8EntityListTemplate', AForm.Name, [rfReplaceAll]);
    finally
      Dest.EndUpdate;
    end;
  finally
    FreeAndNil(ms1);
  end;
end;

end.
