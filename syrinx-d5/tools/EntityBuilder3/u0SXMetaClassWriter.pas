unit u0SXMetaClassWriter;
{
$History: u0SXMetaClassWriter.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:23
 * Created in $/tools/EntityBuilder3
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/15   Time: 10:26
 * Created in $/tools/EntityBuilder2
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/02   Time: 14:19
 * Updated in $/source/D5Integrated
 * クラスの可視性を必ず出力するようにした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/01   Time: 9:16
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/28   Time: 1:50
 * Updated in $/source/D5Integrated
 * コンストラクタとデストラクタのImplementationがうまく記述できていなかっ
 * たので修正
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 4:57
 * Updated in $/source/D5Integrated
 * WriteVariableで ； を記述してなかったので修正
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/03   Time: 2:31
 * Updated in $/source/D5/p0additional
 * エンティティ生成関係とりあえずOKできました
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/02   Time: 1:33
 * Created in $/source/D5/p0additional
 * 新規作成
}

interface

uses
  SysUtils, Classes,
  s0Collection,
  u0SXMetaClass;

type
  T0SXMetaClassVisitor = class(Ts0CollectionVisitor)
  private
    FDest: TStrings;
  protected
    procedure VisitItem(AItem: Ts0CollectionItem); override;
    //
    procedure VisitField(AItem: T0SXMetaField);
    procedure VisitMethod(AItem: T0SXMetaMethod);
    procedure VisitProperty(AItem: T0SXMetaProperty);
  public
    procedure Execute(AClass: T0SXMetaClass);
  end;

type
  T0SXMetaUnitVisitor = class(Ts0CollectionVisitor)
  private
    FDest: TStrings;
    FIndent: Integer;
    FLastDeclare: T0SXDeclareItem;
    FClassVisitor: T0SXMetaClassVisitor;
    FLastFuncImpl: T0SXMetaFunctionImpl;
    function GetIndentSpc: string;
    function GetCommaNameList(AItems: T0SXAbsrtactItems): string;
  protected
    procedure VisitItem(AItem: Ts0CollectionItem); override;
    //
    class function WriteFuncCommon(AName, AReturn: string; AParams:
      T0SXMethodParams; AHeader: string = ''): string;
    class function WriteParam(AItem: T0SXMethodParam): string;
    class function WriteParams(AItems: T0SXMethodParams;
      ABracketHead: Char = '('; ABracketTail: Char = ')'): string;
    //
    procedure WriteCommentItem(AItem: T0SXCommentItem);
    procedure WriteVariable(AItem: T0SXMetaVariable);
    procedure WriteConstant(AItem: T0SXMetaConstant);
    procedure WriteType(AItem: T0SXMetaType);
    procedure WriteOrdinaryType(AItem: T0SXMetaOrdinaryType);
    procedure WriteSetType(AItem: T0SXMetaSetType);
    procedure WriteRecoedType(AItem: T0SXMetaRecoedType);
    procedure WriteFunctionIntf(AItem: T0SXMetaFunctionIntf);
    procedure WriteFunctionImpl(AItem: T0SXMetaFunctionImpl);
  public
    procedure Execute(AUnit: T0SXMetaUnit);
  end;

type
  T0SXMetaClassWriter = class
  private
    FClassVstr: T0SXMetaClassVisitor;
    FUnitVstr: T0SXMetaUnitVisitor;
    FDest: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute(AUnit: T0SXMetaUnit);
    property Dest: TStrings read FDest;
  end;

implementation

{ T0SXMetaClassVisitor }

procedure T0SXMetaClassVisitor.Execute(AClass: T0SXMetaClass);
const
  c9VisibilityStrs: array[K0ClassPartVisibility] of string = (
    '',
    'private',
    'protected',
    'public',
    'published',
    'automated'
  );
var
  i: K0ClassPartVisibility;
  j: Integer;
begin
  FDest.Add('  ' + AClass.Name +' = class(' + AClass.SuperClassName +')' );
  for i := Low(K0ClassPartVisibility) to High(K0ClassPartVisibility) do
  begin
    if i <> k0cpvNone then
      FDest.Add('  ' + c9VisibilityStrs[i]);
    if AClass.SeqMembers[i].Count < 1 then Continue;
    for j := 0 to AClass.SeqMembers[i].Count -1 do
      VisitItem( AClass.SeqMembers[i].Items[j].Item );
  end;
  FDest.Add('  end;');
end;

procedure T0SXMetaClassVisitor.VisitField(AItem: T0SXMetaField);
var
  s: string;
begin
  s := '    ' + AItem.Name +': '+ AItem.TypeName +';';
  if (AItem.Comment <> nil) and (AItem.Comment.Description.Count = 1) then
    s := s + ' { ' + AItem.Comment.Description.Strings[0] +' }';
  FDest.Add( s );
end;

procedure T0SXMetaClassVisitor.VisitItem(AItem: Ts0CollectionItem);
begin
  if AItem is T0SXMetaField then VisitField( T0SXMetaField(AItem) )
  else if AItem is T0SXMetaMethod then VisitMethod( T0SXMetaMethod(AItem) )
  else if AItem is T0SXMetaProperty then VisitProperty( T0SXMetaProperty(AItem) );
end;

procedure T0SXMetaClassVisitor.VisitMethod(AItem: T0SXMetaMethod);
var
  mthdStr: string;
  hdr: string;
begin
  hdr := '';
  case AItem.MethodType of
    k0mtNormal: ;
    k0mtConstructor: hdr := 'constructor';
    k0mtDestructor : hdr := 'destructor';
  end;
  mthdStr := T0SXMetaUnitVisitor.WriteFuncCommon(
    AItem.Name, AItem.ReturnTypeName, AItem.Params, hdr);
  if AItem.IsStatic then
    mthdStr := 'class '+ mthdStr;
  case AItem.MethodKind of
    k0mkFinal   : ;
    k0mkDynamic : mthdStr := mthdStr + ' dynamic;';
    k0mkvirtual : mthdStr := mthdStr + ' virtual;';
    k0mkOverride: mthdStr := mthdStr + ' override;';
  end;
  if AItem.IsAbstract then
    mthdStr := mthdStr + ' abstract;';
  FDest.Add('    ' + mthdStr );
end;

procedure T0SXMetaClassVisitor.VisitProperty(AItem: T0SXMetaProperty);
var
  prStr: string;
  prm: string;
begin
  prStr := 'property '+ AItem.Name;
  if AItem.ReturnTypeName <> '' then
  begin
    prm := T0SXMetaUnitVisitor.WriteParams(AItem.Params, '[', ']');
    if prm <> '' then prStr := prStr + prm;
    prStr := prStr + ': ' + AItem.ReturnTypeName;
    if AItem.ReadAccessorName <> '' then
      prStr := prStr + ' read ' + AItem.ReadAccessorName;
    if AItem.WriteAccessorName <> '' then
      prStr := prStr + ' write ' + AItem.WriteAccessorName;
    //
    if AItem.DefaultAccess then
      prStr := prStr + '; default'
    else
    if AItem.DefaultValue <> '' then
      prStr := prStr + 'default ' + AItem.DefaultValue
    else
    if AItem.StoredValue <> '' then
      prStr := prStr + 'stored ' + AItem.StoredValue;
  end;
  prStr := prStr + ';';
  FDest.Add('    ' + prStr);
end;

{ T0SXMetaUnitVisitor }

procedure T0SXMetaUnitVisitor.Execute(AUnit: T0SXMetaUnit);
  procedure AddUses(AUnitNameList: TStrings);
  var
    i: Integer;
    str: string;
  begin
    str := '';
    if AUnitNameList.Count > 0 then
    begin
      FDest.Add('uses');
      str := AUnitNameList.Strings[0];
      for i := 1 to AUnitNameList.Count -1 do
        str := str +', '+ AUnitNameList.Strings[i];
      FDest.Add('  '+ str + ';');
    end;
  end;
var
  i: Integer;
begin
  FLastDeclare := nil;
  FLastFuncImpl := nil;
  if AUnit = nil then Exit;
  FDest.Add('unit ' + AUnit.Name +';');
  if AUnit.Comment <> nil then
    WriteCommentItem(AUnit.Comment);
  FDest.Add('');

  FDest.Add('interface');
  FDest.Add('');
  AddUses(AUnit.UsesIntf);
  for i := 0 to AUnit.SeqIntf.Count -1 do
    VisitItem( AUnit.SeqIntf.Items[i].Item );

  FDest.Add('');
  FDest.Add('implementation');
  if AUnit.ImplComment <> nil then
  begin
    FDest.Add('');
    VisitItem(AUnit.ImplComment);
  end;
  FDest.Add('');
  AddUses(AUnit.UsesImpl);
  for i := 0 to AUnit.SeqImpl.Count -1 do
    VisitItem(AUnit.SeqImpl.Items[i].Item );

  if (AUnit.InitializationCode.Count > 0) or
     (AUnit.FinalizationCode.Count > 0) then
  begin
    FDest.Add('');
    FDest.Add('initialization');
    FDest.AddStrings( AUnit.InitializationCode );
  end;

  if AUnit.FinalizationCode.Count > 0 then
  begin
    FDest.Add('');
    FDest.Add('finalization');
    FDest.AddStrings( AUnit.FinalizationCode );
  end;
  
  FDest.Add('');
  FDest.Add('end.');
end;

function T0SXMetaUnitVisitor.GetIndentSpc: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FIndent do
    Result := Result + ' ';
end;

procedure T0SXMetaUnitVisitor.VisitItem(AItem: Ts0CollectionItem);
begin
{
  if AItem is T0SXAbsrtactItem then
    if T0SXAbsrtactItem(AItem).Comment <> nil then
      WriteCommentItem( T0SXAbsrtactItem(AItem).Comment );
  //
}
  if AItem is T0SXCommentItem then WriteCommentItem( T0SXCommentItem(AItem) )
  else if AItem is T0SXMetaConstant then WriteConstant( T0SXMetaConstant(AItem) )
  else if AItem is T0SXMetaType then WriteType( T0SXMetaType(AItem) )
  else if AItem is T0SXMetaVariable then WriteVariable( T0SXMetaVariable(AItem) )
  else if AItem is T0SXMetaFunctionIntf then WriteFunctionIntf( T0SXMetaFunctionIntf(AItem) )
  else if AItem is T0SXMetaFunctionImpl then WriteFunctionImpl( T0SXMetaFunctionImpl(AItem) );
end;

procedure T0SXMetaUnitVisitor.WriteCommentItem(AItem: T0SXCommentItem);
var
  hdr: string;
  i: Integer;
begin
  hdr := GetIndentSpc;
  case AItem.CommentKind of
    k0ckDoubleSlash: hdr := hdr +'//';
    k0ckBracket    : FDest.Add('{');
    k0ckBracketWithAsterisk: FDest.Add('(*');
    k0ckCustom: hdr := '';
  end;
  for i := 0 to AItem.Description.Count -1 do
    FDest.Add(hdr + AItem.Description.Strings[i]);
  case AItem.CommentKind of
    k0ckBracket    : FDest.Add('}');
    k0ckBracketWithAsterisk: FDest.Add('*)');
    k0ckCustom: ;
  end;
end;

procedure T0SXMetaUnitVisitor.WriteConstant(AItem: T0SXMetaConstant);
begin
  if not(FLastDeclare is T0SXMetaConstant) then
  begin
    FDest.Add('');
    FDest.Add('const');
    FIndent := 2;
  end;
  FDest.Add(GetIndentSpc + AItem.Name +' = '+ AItem.Value );
  FLastDeclare := AItem;
end;

class function T0SXMetaUnitVisitor.WriteFuncCommon(AName, AReturn: string;
  AParams: T0SXMethodParams; AHeader: string): string;
var
  prm: string;
begin
  Result := '';
  prm := WriteParams(AParams);
  if AHeader = '' then
    if AReturn = '' then
      AHeader := 'procedure'
    else
      AHeader := 'function';

  if AReturn = '' then
    Result := Format('%s %s%s;', [AHeader, AName, prm])
  else
    Result := Format('%s %s%s: %s;', [AHeader, AName, prm, AReturn]);
end;

procedure T0SXMetaUnitVisitor.WriteFunctionImpl(AItem: T0SXMetaFunctionImpl);
  function NeedClassNameComment: Boolean;
  begin
    Result := False;
    if not(AItem.IntfMethod is T0SXMetaMethod) then Exit;
    if FLastFuncImpl = nil then
    begin
      Result := True;
    end
    else
    if FLastFuncImpl.IntfMethod is T0SXMetaMethod  then
    begin
      Result := T0SXMetaMethod(AItem.IntfMethod).OwnerClass <>
                T0SXMetaMethod(FLastFuncImpl.IntfMethod).OwnerClass;
    end
    else
    begin
      Result := True;
    end;
  end;
var
  mthd: string;
  header: string;
begin
  if NeedClassNameComment and (AItem.IntfMethod is T0SXMetaMethod) then
  begin
  FDest.Add('');
  if T0SXMetaMethod(AItem.IntfMethod).OwnerClass <> nil then
    FDest.Add( '{ '+ T0SXMetaMethod(AItem.IntfMethod).OwnerClass.Name +' }');
  end;
  FLastFuncImpl := AItem;
  //
  FDest.Add('');
  if AItem.Comment <> nil then
  begin
    FDest.Add('{');
    FDest.Add( AItem.Name +':');
    FDest.AddStrings( AItem.Comment.Description );
    FDest.Add('}');
  end;
  header := '';
  if AItem.IntfMethod is T0SXMetaMethod then
  begin
    case T0SXMetaMethod(AItem.IntfMethod).MethodType of
      k0mtConstructor: header := 'constructor';
      k0mtDestructor : header := 'destructor';
    end;
  end;
  mthd := WriteFuncCommon(
            AItem.Name, AItem.IntfMethod.ReturnTypeName, AItem.IntfMethod.Params, header
          );
  if AItem.IntfMethod is T0SXMetaMethod then
    if T0SXMetaMethod(AItem.IntfMethod).IsStatic then
      mthd := 'class ' + mthd;
  FDest.Add(mthd);
  if AItem.WithoutBeginEnd then
  begin
    FDest.AddStrings( AItem.ImplementCode);
  end
  else
  begin
    FDest.Add('begin');
    FDest.AddStrings( AItem.ImplementCode);
    FDest.Add('end;');
  end;
  FLastDeclare := nil;
end;

procedure T0SXMetaUnitVisitor.WriteFunctionIntf(AItem: T0SXMetaFunctionIntf);
begin
  FDest.Add(
    WriteFuncCommon(
      AItem.Name, AItem.ReturnTypeName, AItem.Params
    )
  );
  FLastDeclare := nil;
end;

class function T0SXMetaUnitVisitor.WriteParam(AItem: T0SXMethodParam): string;
begin
  Result := '';
  case AItem.ParamKind of
    k0pkNone : ;
    k0pkVar  : Result := 'var ';
    k0pkConst: Result := 'const ';
    k0pkOut  : Result := 'out ';
  end;
  Result := Result + AItem.Name +': ' +AItem.TypeName;
end;

class function T0SXMetaUnitVisitor.WriteParams(AItems: T0SXMethodParams;
  ABracketHead: Char = '('; ABracketTail: Char = ')'): string;
var
  i: Integer;
begin
  Result := '';
  if AItems.Count > 0 then
  begin
    Result := WriteParam(AItems.Items[0]);
    for i := 1 to AItems.Count -1 do
      Result := Result +'; '+ WriteParam(AItems.Items[i]);
    Result := ABracketHead +Result +ABracketTail;
  end;
end;

procedure T0SXMetaUnitVisitor.WriteOrdinaryType(AItem: T0SXMetaOrdinaryType);
begin
  FDest.Add(
    Format(
      '  %s = (' + #13#10+ '    %s'+#13#10+ '  );', [
      AItem.Name,
      StringReplace(
        GetCommaNameList(AItem.Elements),
        ',',    ',' + #13#10+ '    ',
        [ rfReplaceAll{, rfIgnoreCase} ]
      )
     ])
  );
end;

procedure T0SXMetaUnitVisitor.WriteRecoedType(AItem: T0SXMetaRecoedType);
var
  i: Integer;
begin
  FDest.Add('  ' + AItem.Name +' = packed record');
  for i := 0 to AItem.Fields.Count -1 do
    WriteVariable( T0SXMetaVariable(AItem.Fields.Items[i]) );
  FDest.Add('  end;');
end;

procedure T0SXMetaUnitVisitor.WriteSetType(AItem: T0SXMetaSetType);
begin
  if AItem.OrdinaryType <> nil then
  begin
    FDest.Add( Format('  %s = set of %s;', [ AItem.Name, AItem.OrdinaryType.Name ]) );
  end
  else
  begin
    FDest.Add(
      Format(
        '  %s = set of (' + #13#10+ '    %s'+#13#10+ '  );', [
        AItem.Name,
        StringReplace(
          GetCommaNameList(AItem.Elements),
          ',',    ',' + #13#10+ '    ',
          [ rfReplaceAll{, rfIgnoreCase} ]
        )
       ])
    );
  end;
end;

procedure T0SXMetaUnitVisitor.WriteType(AItem: T0SXMetaType);
begin
  if not(FLastDeclare is T0SXMetaType) then
  begin
    FDest.Add('');
    FDest.Add('type');
    FIndent := 2;
  end
  else
  begin
    if AItem is T0SXMetaClass then
      FDest.Add('');
  end;
  //
  if AItem is T0SXMetaRecoedType then WriteRecoedType( T0SXMetaRecoedType(AItem) )
  else if AItem is T0SXMetaSetType then WriteSetType( T0SXMetaSetType(AItem) )
  else if AItem is T0SXMetaOrdinaryType then WriteOrdinaryType( T0SXMetaOrdinaryType(AItem) )
  else if AItem is T0SXMetaClass then
    if FClassVisitor <> nil then
      FClassVisitor.Execute( T0SXMetaClass(AItem) );
  FLastDeclare := AItem;
end;

procedure T0SXMetaUnitVisitor.WriteVariable(AItem: T0SXMetaVariable);
begin
  Assert(AItem.CollectionAs0Level <> nil, 'Illegal Collection Class');
  if not(AItem.CollectionAs0Level.OwnerObj is T0SXMetaRecoedType) then
    if not(FLastDeclare is T0SXMetaVariable) then
    begin
      FDest.Add('');
      FDest.Add('var ');
    end;
  FDest.Add( '  '+ AItem.Name +': '+ AItem.TypeName +';');
  FLastDeclare := AItem;
end;

function T0SXMetaUnitVisitor.GetCommaNameList(AItems: T0SXAbsrtactItems): string;
  function GetElemDesc(Elem: T0SXAbsrtactItem): string;
  begin
    Result := Elem.Name;
    if (Elem.Comment <> nil) and (Elem.Comment.Description.Count = 1) then
      Result := Result + ' { ' + Elem.Comment.Description.Strings[0] +' }';
  end;
var
  i: Integer;
begin
  Result := '';
  if AItems.Count < 1 then Exit;
  Result := '  '+  GetElemDesc( T0SXAbsrtactItem(AItems.Items[0]) );
  for i := 1 to AItems.Count -1 do
    Result := Result + ', ' + GetElemDesc( T0SXAbsrtactItem(AItems.Items[i]) );
end;

{ T0SXMetaClassWriter }

constructor T0SXMetaClassWriter.Create;
begin
  inherited Create;
  FDest := TStringList.Create;
  FClassVstr := T0SXMetaClassVisitor.Create;
  FClassVstr.FDest := FDest;

  FUnitVstr := T0SXMetaUnitVisitor.Create;
  FUnitVstr.FClassVisitor := FClassVstr;
  FUnitVstr.FDest := FDest;
end;

destructor T0SXMetaClassWriter.Destroy;
begin
  FreeAndNil(FClassVstr);
  FreeAndNil(FUnitVstr);
  FreeAndNil(FDest);
  inherited;
end;

procedure T0SXMetaClassWriter.Execute(AUnit: T0SXMetaUnit);
begin
  FUnitVstr.Execute(AUnit);
end;

end.
