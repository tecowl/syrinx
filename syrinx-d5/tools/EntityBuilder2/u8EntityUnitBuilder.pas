unit u8EntityUnitBuilder;
{
$History: u8EntityUnitBuilder.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/13   Time: 14:32
 * Created in $/tools/EntityBuilder2
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/14   Time: 23:47
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/01/07   Time: 21:57
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/12/11   Time: 3:40
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/22   Time: 22:00
 * Updated in $/source/D5Integrated/tools/EntityBuilder2
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/02   Time: 14:12
 * Created in $/source/D5Integrated/tools/EntityBuilder2
 * �V�K�쐬
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/10/24   Time: 5:19
 * Created in $/source/D5Integrated/tools/EntityBuilder
 * �V�K�쐬
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/02   Time: 3:19
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/01   Time: 9:17
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/21   Time: 17:03
 * Updated in $/source/D5/tools/EntityBuilder
 * Ts0PropertyProtoTypes����Ts0EntityPropProto���g�p����悤�ɕύX
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/21   Time: 13:09
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/20   Time: 18:43
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/16   Time: 23:33
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/07   Time: 17:23
 * Updated in $/source/D5/tools/EntityBuilder
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/03   Time: 11:11
 * Created in $/source/D5/tools/EntityBuilder
}

interface

uses
  SysUtils, Classes, DB,
  u8MetaEntities,
  u0SXMetaClass,
  s0Collection,
  s0PropertyProtoType,
  s0EntityPropProto,
  u8BuilderParam;

type
  T8EntityUnitBuilder = class(TComponent)
  private
    FTarget: T0SXMetaUnit;
    FPropID: T0SXMetaProperty;
    FPropCaption: T0SXMetaProperty;
    FParams: T8BuilderParam;
    procedure SetTarget(const Value: T0SXMetaUnit);
    procedure AddDefaultProtectedMethods(AClass: T0SXMetaClass);
    procedure AddDefaultPublicMethods(AClass: T0SXMetaClass;
      AProps: Ts0CollectionItemList);
    procedure AddInputProps(AClass: T0SXMetaClass;
      AProps: Ts0CollectionItemList);
    procedure WriteDestructor(AClass: T0SXMetaClass;
      AProps: Ts0CollectionItemList);
    procedure WriteGetterCode(AProps: Ts0CollectionItemList);
    procedure WriteSetterCode(AProps: Ts0CollectionItemList);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    property Target: T0SXMetaUnit read FTarget write SetTarget;
    property Params: T8BuilderParam read FParams write FParams;
  end;

implementation

uses
  s0ValidationMsg,
  s0StringHelper,
  s0CheckBoxHelper;


{ T8EntityUnitBuilder }

procedure T8EntityUnitBuilder.AddDefaultPublicMethods(AClass: T0SXMetaClass; AProps: Ts0CollectionItemList);
var
  mthd: T0SXMetaMethod;
  i: Integer;
  AssignCode, equalsCode: TStrings;
  pr: T0SXMetaProperty;
begin
  //Public Methods
  mthd := AClass.Methods.Add('Assign', '', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Params.AddParam('Source', 'TPersistent', k0pkNone);
  mthd.Visibility := k0cpvPublic;
  AssignCode := mthd.ImplMethod.ImplementCode;
  AssignCode.Add( '  inherited Assign(Source);' );
  AssignCode.Add( '  if not(Source is '+ AClass.Name +') then Exit;' );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'Assign���\�b�h�́u�[���R�s�[�v���s���܂�',
    'DB�ɕۑ������悤�ȃv���p�e�B��ǉ������ꍇ�ɂ́A',
    '�K��Assign���\�b�h�Œl���R�s�[�����悤�ɂ��ĉ������B'
  ]);

  mthd := AClass.Methods.Add('Equals', 'Boolean', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Params.AddParam('AEntity', 'Ts0Entity', k0pkNone);
  mthd.Visibility := k0cpvPublic;
  equalsCode := mthd.ImplMethod.ImplementCode;
  equalsCode.Add( '  Result := False;' );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'Equals���\�b�h�́u�Ⴄ�C���X�^���X���m�𓯂����̂Ƃ��Č��Ȃ��邩�ǂ����v',
    '�Ƃ������f���s���܂��B'
  ]);              
  for i := 0 to AProps.Count -1 do
  begin
    pr := T0SXMetaProperty(AProps.Items[i]);
    assignCode.Add( Format('  Self.%s := %s(Source).%s;', [pr.Name, AClass.Name, pr.ReadAccessorName]));
    equalsCode.Add( Format('  if Self.%s <> %s(AEntity).%s then Exit;', [pr.Name, AClass.Name, pr.ReadAccessorName]));
  end;
  equalsCode.Add( '  Result := True;');

  mthd := AClass.Methods.Add('GetClassID', 'Integer', True);
  mthd.MethodKind := k0mkOverride;
  mthd.IsStatic := True;
  mthd.Visibility := k0cpvPublic;

  mthd.ImplMethod.ImplementCode.Add(
    Format('  Result := %s;', [ Params.TargetMetaEntity.IDConstName ])
  );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'GetClassID���\�b�h�͂���G���e�B�e�B�̃N���X����ӂɎ��ʂ��鐮����Ԃ��܂��B',
    '���̃��\�b�h�́u�K���v�I�[�o�[���C�h���Ă��������B',
    '�߂�l�ɂ́A���̃G���e�B�e�B��GetClassID�̖߂�l�ƈقȂ��ӂ̐�����ݒ肵�Ă��������B',
    '�߂�l�ƂȂ�l�́A1�̃��j�b�g���Œ萔�Ƃ��Đ錾���Ă������Ƃ������߂��܂��B'
  ]);

  mthd := AClass.Methods.Add('GetClassCaption', 'String', True);
  mthd.MethodKind := k0mkOverride;
  mthd.IsStatic := True;
  mthd.Visibility := k0cpvPublic;
  mthd.ImplMethod.ImplementCode.Add(                                      
    Format('  Result := ''%s'';', [Params.TargetMetaEntity.EtyClassCaption])
  );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'GetClassCaption���\�b�h�͂���G���e�B�e�B�̃N���X�̖��O��Ԃ��܂��B',
    '����́A�t�H�[���ȂǂɃG���e�B�e�B����\������ꍇ�ȂǂɎg�p����܂��B'
  ]);
end;

procedure T8EntityUnitBuilder.AddDefaultProtectedMethods(AClass: T0SXMetaClass);
var
  mthd: T0SXMetaMethod;
begin
  //Protected Methods
  mthd := AClass.Methods.Add('GetCaption', 'string', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Visibility := k0cpvProtected;
  if (FPropCaption <> nil) and
     SameText(FPropCaption.ReturnTypeName, 'string') then
    mthd.ImplMethod.ImplementCode.Add('  Result := ' + FPropCaption.Name +';' );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'GetCaption���\�b�h�́ACaption�v���p�e�B�̒l���擾����Ƃ��ɌĂяo����A',
    '����G���e�B�e�B�̃C���X�^���X�̓��e���������O�̂悤�ȕ������Ԃ��܂��B',
    '���̃��\�b�h�̖߂�l�͂���C���X�^���X�ɑ΂��Ĉ�ӂł���K�v�͂���܂���B',
    '�ǂ̂悤�Ȓl��߂�l�Ƃ��ĕԂ��̂��ɂ��ẮA����͂���܂���B'
  ]);

  mthd := AClass.Methods.Add('GetID', 'Integer', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Visibility := k0cpvProtected;
  if FPropID <> nil then
    mthd.ImplMethod.ImplementCode.Add('  Result := ' + FPropID.Name +';' );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'GetID���\�b�h�́AID�v���p�e�B�̒l���擾����Ƃ��ɌĂяo����A',
    '����G���e�B�e�B�̃C���X�^���X��ID��Ԃ��܂��B',
    '���̃��\�b�h�̖߂�l�͂���C���X�^���X�ɑ΂��Ĉ�ӂł���K�v������܂��B'
  ]);

  mthd := AClass.Methods.Add('SetCaption', '', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Params.AddParam('Value', 'string', k0pkConst);
  mthd.Visibility := k0cpvProtected;
  if FPropCaption <> nil then
    mthd.ImplMethod.ImplementCode.Add( '  '+ FPropCaption.Name +' := Value;');
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'SetCaption���\�b�h�́ACaption�v���p�e�B�̒l��ݒ肷��Ƃ��ɌĂяo����A',
    '����G���e�B�e�B�̃C���X�^���X��Caption��ݒ肵�܂��B',
    '���̃��\�b�h�Œl��ݒ肷��̂́A���ۂ�Caption�����������o�ϐ��ł͂Ȃ��A',
    'Caption��\���v���p�e�B�ɑ΂��čs���A����Caption�̃v���p�e�B��write���\�b�h��',
    'Change���\�b�h���Ăяo���悤�ɂ��ĉ������B'
  ]);

  mthd := AClass.Methods.Add('SetID', '', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Params.AddParam('Value', 'Integer', k0pkConst);
  mthd.Visibility := k0cpvProtected;
  if FPropID <> nil then
    mthd.ImplMethod.ImplementCode.Add( '  '+ FPropID.Name +' := Value;');
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'SetID���\�b�h�́AID�v���p�e�B�̒l��ݒ肷��Ƃ��ɌĂяo����A',
    '����G���e�B�e�B�̃C���X�^���X��ID��ݒ肵�܂��B',
    '���̃��\�b�h�Œl��ݒ肷��̂́A���ۂ�ID�����������o�ϐ��ł͂Ȃ��A',
    'ID��\���v���p�e�B�ɑ΂��čs���A����ID�̃v���p�e�B��write���\�b�h��',
    'ChangeID���\�b�h���Ăяo���悤�ɂ��ĉ������B'
  ]);
end;

procedure T8EntityUnitBuilder.AddInputProps(AClass: T0SXMetaClass; AProps: Ts0CollectionItemList);
  procedure AddOrdConvMethod(AType: T0SXMetaOrdinaryType; AProp: Ts0EntityPropProto);
  var
    mthd: T0SXMetaMethod;
    cd: TStrings;
    i: Integer;
    s: string;
    constName: string;
    toStrName: string;
  begin
    if AType = nil then Exit;
    { "XXXToStr" }
    toStrName := AProp.PropertyName + 'ToStr';
    mthd := AClass.Methods.Add(toStrName, 'String', True);
    mthd.MethodKind := k0mkFinal;
    mthd.Params.AddParam('Value', AType.Name, k0pkConst);
    mthd.ReturnTypeName := 'String';
    mthd.IsStatic := True;
    mthd.Visibility := k0cpvPublic;
    mthd.ImplMethod.WithoutBeginEnd := True;
    cd := mthd.ImplMethod.ImplementCode;
    constName := Format('c9%sArray', [AProp.PropertyName]);
    cd.Add('const');
    cd.Add(Format('  %s: array[%s] of string =(', [constName, AType.Name]) );
    for i := 0 to AType.Elements.Count -1 do
    begin
      s := Format('    ''%s''', [
        AProp.EnumMember.Values[ T0SXAbsrtactItem(AType.Elements.Items[i]).Name ]
      ]);
      if i <> AType.Elements.Count -1 then
        s := s +',';
      cd.Add(s);
    end;
    cd.Add('  );');
    cd.Add('begin');
    cd.Add('  Result := '''';');
    cd.Add(Format( '  if (value < Low(%s)) or (value > High(%s)) then Exit;', [AType.Name, AType.Name]));
    cd.Add(Format( '  Result := %s[ Value ];', [constName]));
    cd.Add('end;');
    //
    { "StrToXXX" }
    mthd := AClass.Methods.Add('StrTo' + AProp.PropertyName, 'String', True);
    mthd.MethodKind := k0mkFinal;
    mthd.Params.AddParam('Value', 'String', k0pkConst);
    mthd.ReturnTypeName := AType.Name;
    mthd.IsStatic := True;
    mthd.Visibility := k0cpvPublic;
    mthd.ImplMethod.WithoutBeginEnd := True;
    cd := mthd.ImplMethod.ImplementCode;
    cd.Add('var');
    cd.Add('  i: '+ AType.Name +';');
    cd.Add('begin');
    cd.Add(Format('  Result := Low(%s);', [AType.Name]));
    cd.Add(Format('  for i := Low(%s) to High(%s) do', [AType.Name, AType.Name]));
    cd.Add(Format('    if AnsiCompareText(%s(i), Value) = 0 then', [toStrName]));
    cd.Add('    begin');
    cd.Add('      Result := i;');
    cd.Add('      Exit;');
    cd.Add('    end');
    cd.Add('end;');
  end;
  function AddOrdType(AIsSet: Boolean; ATypeName: string; AProp: Ts0EntityPropProto): T0SXMetaOrdinaryType;
  var
    elem: T0SXAbsrtactItem;
    i: Integer;
  begin
    Result := nil;
    if Ts0StringHelper.IndexOfArray(ATypeName, [
      //�����֌W
      'Shortint', 'Smallint', 'Longint', 'Int64',
      'Byte', 'Word', 'Longword', 'Integer', 'Cardinal',
      //�����n
      'Real48', 'Single', 'Double', 'Extended', 'Comp',
      'Currency', 'Real', 'TDateTime', 'TDate', 'TTime',
      //������֌W
      'String', 'AnsiString', 'WideString',
      //�񋓌^�n
      'Boolean'
      ]) > -1 then
    begin
      Ts0GlobalValidationManager.Instance.NewMsg(
        Format('���ɓo�^����Ă���^"%s"���Ē�`���邱�Ƃ͂ł��܂���B', [ATypeName]),
        k0vrFatalError
      );
      Exit;
    end;
    //
    if AIsSet then
      Result := T0SXMetaSetType.Create(nil)
    else
      Result := T0SXMetaOrdinaryType.Create(nil);
    Result.Name := ATypeName;
    for i := 0 to AProp.EnumMember.Count -1 do
    begin
      elem := T0SXAbsrtactItem(Result.Elements.Add);
      elem.Name := AProp.EnumMember.Names[i];
      elem.Comment := Target.Comments.Add( AProp.EnumMember.Values[ elem.Name ]);
    end;
    if Result is T0SXMetaSetType then
    begin
      T0SXMetaSetType(Result).RestoreOrdinary;
      AddOrdConvMethod(T0SXMetaSetType(Result).OrdinaryType, AProp);
    end
    else
    begin
      AddOrdConvMethod(Result, AProp);
    end;
    Result.Collection := Target.Types;       
  end;
  //
  procedure AddEnumStrProp(AProto: Ts0EntityPropProto; AProp: T0SXMetaProperty);
  var
    asStr: T0SXMetaProperty;
    strPropName: string;
    toStr, fromStr: T0SXMetaMethod;
  begin
    toStr := AClass.Methods.Add(AProto.PropertyName + 'ToStr', 'String', True);
    toStr.MethodKind := k0mkFinal;
    toStr.Params.AddParam('Value', AProto.TypeName, k0pkConst);
    toStr.ReturnTypeName := 'String';
    toStr.IsStatic := True;
    toStr.Visibility := k0cpvPublic;
    toStr.ImplMethod.ImplementCode.Add(
      '  Result := inherited EnumValueToStr(' + AnsiQuotedStr(AProto.EnumName, '''') + ', Value);'
    );
    fromStr := AClass.Methods.Add('StrTo'+ AProto.PropertyName, AProto.TypeName, True);
    fromStr.MethodKind := k0mkFinal;
    fromStr.Params.AddParam('Value', 'String', k0pkConst);
    fromStr.ReturnTypeName := AProto.TypeName;
    fromStr.IsStatic := True;
    fromStr.Visibility := k0cpvPublic;
    fromStr.ImplMethod.ImplementCode.Add(
      '  Result := inherited StrToEnumValue(' + AnsiQuotedStr(AProto.EnumName, '''') + ', Value);'
    );
    strPropName := AProto.PropertyName +'Str';
    asStr := AClass.Properties.Add(strPropName, 'String', 'Get'+ strPropName, 'Set'+ strPropName, True);
    asStr.Visibility := k0cpvPublic;
    if asStr.ReadAccessor is T0SXMetaMethod then
      T0SXMetaMethod(asStr.ReadAccessor).ImplMethod.ImplementCode.Add(
        '  Result := '+ toStr.Name +'(' + AProp.ReadAccessor.Name +');'
      );
    if asStr.WriteAccessor is T0SXMetaMethod then
      T0SXMetaMethod(asStr.WriteAccessor).ImplMethod.ImplementCode.Add(
        '  '+ AProp.ReadAccessor.Name +' := '+ fromStr.Name +'(Value);'
      );
  end;
var
  p: Ts0EntityPropProto;
  pn, pt, pr, pw: string;
  prop: T0SXMetaProperty;
  fld: T0SXMetaField;
  i: Integer;
begin
  for i := 0 to Params.ProtoTypes.Count -1 do
  begin
    p := Params.ProtoTypes.Items[i];
    pn := Trim(p.PropertyName);
    pt := Trim(p.TypeName);
    if pn = '' then Continue;
    if pt = '' then Continue;
    if p.IsPersistent then
    begin
      pr := 'Get' + pn;
      fld :=  AClass.Fields.Add('F' + pn, pt);
      fld.Visibility := k0cpvPrivate;
      fld.Comment := Target.Comments.Add(p.JPName);
    end
    else
    begin
      pr := 'F' + pn;
      fld :=  AClass.Fields.Add(pr, pt);
      fld.Visibility := k0cpvPrivate;
      fld.Comment := Target.Comments.Add(p.JPName);
    end;
    pw := 'Set' + pn;
    prop := AClass.Properties.Add(pn, pt, pr, pw, True);
    prop.Visibility := k0cpvPublished;
    AProps.Add(prop);
    //
    if p.IsID then
      FPropID := prop;
    if p.IsCaption then
      FPropCaption := prop;
    //
    if p.IsEnum or p.IsSet then
      AddOrdType(p.IsSet, pt, p)
    else
    if Trim(p.EnumName) <> '' then
      AddEnumStrProp(p, prop);      
  end;
end;

procedure T8EntityUnitBuilder.WriteSetterCode(AProps: Ts0CollectionItemList);
var
  i: Integer;
  p: Ts0EntityPropProto;
  prop: T0SXMetaProperty;
  mthd: T0SXMetaMethod;
  cd: TStrings;
begin
  for i := 0 to AProps.Count -1 do
  begin
    prop := T0SXMetaProperty(AProps.Items[i]);
    p := Params.ProtoTypes.FindByName(prop.Name);
    if not(prop.WriteAccessor is T0SXMetaMethod) then Continue;
    mthd := T0SXMetaMethod(prop.WriteAccessor);
    if mthd.ImplMethod = nil then Continue;
    mthd.ImplMethod.Comment :=
      Target.Comments.Add(prop.Name + '�v���p�e�B��write���\�b�h�ł��B');
    cd := mthd.ImplMethod.ImplementCode;
    cd.Clear;
    if (p <> nil) and p.IsPersistent then
    begin
      cd.Add( '  if Value = nil then' );
      cd.Add( '    FreeAndNil('+ 'F'+ prop.Name +')' );
      cd.Add( '  else ' );
      cd.Add( '    '+ prop.Name +'.Assign(Value);' );
      mthd.ImplMethod.Comment.AddStrs([
        '���̃v���p�e�B��TPersistent����h�����Ă��邽�ߎQ�Ƃ̃R�s�[�ł͂Ȃ�',
        '�[���R�s�[���s���悤�ɂȂ��Ă��܂��B',
        '�Q�Ƃ̃R�s�[���s���ꍇ�ɂ͂��̃��\�b�h���C�����Ă��������B'
      ]);
    end
    else
    begin
      cd.Add( '  Self.'+ prop.ReadAccessorName +' := Value;' );
    end;
    //
    if prop = FPropID then
    begin
      cd.Add('  ChangeID;');
      mthd.ImplMethod.Comment.AddStrs([
        '���̃v���p�e�B��ID�Ƃ��Ďg�p����Ă��܂��̂ŁA',
        '�ʏ�A�l���ύX���ꂽ�ꍇ�ɂ�ChangeID���\�b�h���Ăяo���悤�ɂ��Ă��������B'
      ]);
    end
    else
    begin
      cd.Add('  Change;');
      mthd.ImplMethod.Comment.AddStrs([
        '���̃v���p�e�B�͒ʏ�̑����Ƃ��Ďg�p����Ă��܂��̂ŁA',
        '�ʏ�A�l���ύX���ꂽ�ꍇ�ɂ�Change���\�b�h���Ăяo���悤�ɂ��Ă��������B'
      ]);
    end;
  end;
end;

procedure T8EntityUnitBuilder.WriteGetterCode(AProps: Ts0CollectionItemList);
var
  i: Integer;
  prop: T0SXMetaProperty;
  mthd: T0SXMetaMethod;
  cd: TStrings;
  p: Ts0EntityPropProto;
  clsName: string;
begin
  for i := 0 to AProps.Count -1 do
  begin
    prop := T0SXMetaProperty(AProps.Items[i]);
    p := Params.ProtoTypes.FindByName(prop.Name);
    if not(prop.ReadAccessor is T0SXMetaMethod) then Continue;
    mthd := T0SXMetaMethod(prop.ReadAccessor);
    if mthd.ImplMethod = nil then Continue;
    mthd.ImplMethod.Comment :=
      Target.Comments.Add(prop.Name + '�v���p�e�B��read���\�b�h�ł��B');
    cd := mthd.ImplMethod.ImplementCode;
    cd.Clear;
    if (p <> nil) and p.IsPersistent then
    begin
      clsName := prop.ReturnTypeName;
      if SameText(clsName, 'TStrings') then
        clsName := 'TStringList';
      cd.Add( '  if '+ 'F'+ prop.Name +' = nil then' );
      cd.Add( '    '+ 'F'+ prop.Name + ' := '+ clsName +'.Create;' );
      cd.Add( '  Result := '+ 'F'+ prop.Name +';');
      mthd.ImplMethod.Comment.AddStrs([
        '���̃v���p�e�B�͖߂�l�ƂȂ�ׂ��C���X�^���X���Ȃ���΁A',
        '����𐶐����܂��B'
      ]);
    end
    else
    begin
      cd.Add( '  Result := Self.'+ prop.ReadAccessorName +';' );
    end;
  end;
end;

procedure T8EntityUnitBuilder.WriteDestructor(AClass: T0SXMetaClass; AProps: Ts0CollectionItemList);
var
  i: Integer;
  p: Ts0EntityPropProto;
  prop: T0SXMetaProperty;
  mthd: T0SXMetaMethod;
  cd: TStrings;
begin
  mthd := nil;
  cd := nil;
  for i := 0 to AProps.Count -1 do
  begin
    prop := T0SXMetaProperty(AProps.Items[i]);
    p := Params.ProtoTypes.FindByName(prop.Name);
    if p = nil then Continue;
    if not p.IsPersistent then Continue;
    if mthd = nil then
    begin
      mthd := AClass.Methods.Add('Destroy', '', True);
      mthd.MethodType := k0mtDestructor;
      mthd.MethodKind := k0mkOverride;
      mthd.Visibility := k0cpvPublic;
      if mthd.ImplMethod <> nil then
        cd := mthd.ImplMethod.ImplementCode;
    end;
    if cd = nil then Exit;
    cd.Add( '  FreeAndNil(' +'F'+ prop.Name +');' );
    mthd.ImplMethod.Comment :=
      Target.Comments.AddWithStrs([
        '�R���X�g���N�^��v���p�e�B��read���\�b�h�ȂǂŐ��������C���X�^���X��',
        '������͔j������Ȃ���΂Ȃ�܂���B���A�f�X�g���N�^�Ŕj�����܂��B'
      ]);
  end;
  if cd <> nil then
    cd.Add('  inherited Destroy;' );
end;

procedure T8EntityUnitBuilder.Execute;
var
  cls: T0SXMetaClass;
  props: Ts0CollectionItemList;
begin
  cls := T0SXMetaClass.Create(nil);
  cls.Name := Params.TargetMetaEntity.EtyClassName;
  cls.SuperClassName := 'Ts0Entity';
  cls.Collection := Target.Types;
  props := Ts0CollectionItemList.Create(False);
  try
    AddInputProps(cls, props);
    AddDefaultProtectedMethods(cls);
    AddDefaultPublicMethods(cls, props);
    WriteSetterCode(props);
    WriteGetterCode(props);
    WriteDestructor(cls, props);
  finally
    FreeAndNil(props);
  end;
  Target.UsesIntf.Add('SysUtils');
  Target.UsesIntf.Add('Classes');
  Target.UsesIntf.Add('s0Entity');
  Target.UsesImpl.Add(Params.IDDefineUnitName);
  Target.InitializationCode.Add('  Ts0EntityRegister.RegisterEntity(' +  cls.Name + ');' );
end;

procedure T8EntityUnitBuilder.SetTarget(const Value: T0SXMetaUnit);
begin
  FTarget := Value;
end;

constructor T8EntityUnitBuilder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor T8EntityUnitBuilder.Destroy;
begin
  inherited;
end;

end.
