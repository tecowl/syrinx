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
 * 接頭辞を変更。xxSX～にした。
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
 * 新規作成
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/10/24   Time: 5:19
 * Created in $/source/D5Integrated/tools/EntityBuilder
 * 新規作成
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
 * Ts0PropertyProtoTypesからTs0EntityPropProtoを使用するように変更
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
    'Assignメソッドは「深いコピー」を行います',
    'DBに保存されるようなプロパティを追加した場合には、',
    '必ずAssignメソッドで値がコピーされるようにして下さい。'
  ]);

  mthd := AClass.Methods.Add('Equals', 'Boolean', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Params.AddParam('AEntity', 'Ts0Entity', k0pkNone);
  mthd.Visibility := k0cpvPublic;
  equalsCode := mthd.ImplMethod.ImplementCode;
  equalsCode.Add( '  Result := False;' );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'Equalsメソッドは「違うインスタンス同士を同じものとして見なせるかどうか」',
    'という判断を行います。'
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
    'GetClassIDメソッドはあるエンティティのクラスを一意に識別する整数を返します。',
    'このメソッドは「必ず」オーバーライドしてください。',
    '戻り値には、他のエンティティのGetClassIDの戻り値と異なる一意の整数を設定してください。',
    '戻り値となる値は、1つのユニット内で定数として宣言しておくことをお勧めします。'
  ]);

  mthd := AClass.Methods.Add('GetClassCaption', 'String', True);
  mthd.MethodKind := k0mkOverride;
  mthd.IsStatic := True;
  mthd.Visibility := k0cpvPublic;
  mthd.ImplMethod.ImplementCode.Add(                                      
    Format('  Result := ''%s'';', [Params.TargetMetaEntity.EtyClassCaption])
  );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'GetClassCaptionメソッドはあるエンティティのクラスの名前を返します。',
    'これは、フォームなどにエンティティ名を表示する場合などに使用されます。'
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
    'GetCaptionメソッドは、Captionプロパティの値を取得するときに呼び出され、',
    'あるエンティティのインスタンスの内容を示す名前のような文字列を返します。',
    'このメソッドの戻り値はあるインスタンスに対して一意である必要はありません。',
    'どのような値を戻り値として返すのかについては、制約はありません。'
  ]);

  mthd := AClass.Methods.Add('GetID', 'Integer', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Visibility := k0cpvProtected;
  if FPropID <> nil then
    mthd.ImplMethod.ImplementCode.Add('  Result := ' + FPropID.Name +';' );
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'GetIDメソッドは、IDプロパティの値を取得するときに呼び出され、',
    'あるエンティティのインスタンスのIDを返します。',
    'このメソッドの戻り値はあるインスタンスに対して一意である必要があります。'
  ]);

  mthd := AClass.Methods.Add('SetCaption', '', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Params.AddParam('Value', 'string', k0pkConst);
  mthd.Visibility := k0cpvProtected;
  if FPropCaption <> nil then
    mthd.ImplMethod.ImplementCode.Add( '  '+ FPropCaption.Name +' := Value;');
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'SetCaptionメソッドは、Captionプロパティの値を設定するときに呼び出され、',
    'あるエンティティのインスタンスのCaptionを設定します。',
    'このメソッドで値を設定するのは、実際のCaptionを示すメンバ変数ではなく、',
    'Captionを表すプロパティに対して行い、そのCaptionのプロパティのwriteメソッドで',
    'Changeメソッドを呼び出すようにして下さい。'
  ]);

  mthd := AClass.Methods.Add('SetID', '', True);
  mthd.MethodKind := k0mkOverride;
  mthd.Params.AddParam('Value', 'Integer', k0pkConst);
  mthd.Visibility := k0cpvProtected;
  if FPropID <> nil then
    mthd.ImplMethod.ImplementCode.Add( '  '+ FPropID.Name +' := Value;');
  mthd.ImplMethod.Comment := Target.Comments.AddWithStrs([
    'SetIDメソッドは、IDプロパティの値を設定するときに呼び出され、',
    'あるエンティティのインスタンスのIDを設定します。',
    'このメソッドで値を設定するのは、実際のIDを示すメンバ変数ではなく、',
    'IDを表すプロパティに対して行い、そのIDのプロパティのwriteメソッドで',
    'ChangeIDメソッドを呼び出すようにして下さい。'
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
      //整数関係
      'Shortint', 'Smallint', 'Longint', 'Int64',
      'Byte', 'Word', 'Longword', 'Integer', 'Cardinal',
      //実数系
      'Real48', 'Single', 'Double', 'Extended', 'Comp',
      'Currency', 'Real', 'TDateTime', 'TDate', 'TTime',
      //文字列関係
      'String', 'AnsiString', 'WideString',
      //列挙型系
      'Boolean'
      ]) > -1 then
    begin
      Ts0GlobalValidationManager.Instance.NewMsg(
        Format('既に登録されている型"%s"を再定義することはできません。', [ATypeName]),
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
      Target.Comments.Add(prop.Name + 'プロパティのwriteメソッドです。');
    cd := mthd.ImplMethod.ImplementCode;
    cd.Clear;
    if (p <> nil) and p.IsPersistent then
    begin
      cd.Add( '  if Value = nil then' );
      cd.Add( '    FreeAndNil('+ 'F'+ prop.Name +')' );
      cd.Add( '  else ' );
      cd.Add( '    '+ prop.Name +'.Assign(Value);' );
      mthd.ImplMethod.Comment.AddStrs([
        'このプロパティはTPersistentから派生しているため参照のコピーではなく',
        '深いコピーを行うようになっています。',
        '参照のコピーを行う場合にはこのメソッドを修正してください。'
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
        'このプロパティはIDとして使用されていますので、',
        '通常、値が変更された場合にはChangeIDメソッドを呼び出すようにしてください。'
      ]);
    end
    else
    begin
      cd.Add('  Change;');
      mthd.ImplMethod.Comment.AddStrs([
        'このプロパティは通常の属性として使用されていますので、',
        '通常、値が変更された場合にはChangeメソッドを呼び出すようにしてください。'
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
      Target.Comments.Add(prop.Name + 'プロパティのreadメソッドです。');
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
        'このプロパティは戻り値となるべきインスタンスがなければ、',
        'それを生成します。'
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
        'コンストラクタやプロパティのreadメソッドなどで生成したインスタンスは',
        'いずれは破棄されなければなりません。大抵、デストラクタで破棄します。'
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
