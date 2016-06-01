unit s0EntityDispImpl;

interface

uses
  SysUtils, Classes, Forms,
  Contnrs,
  s0Observer,
  s0Entity,
  s0FormRelation,
  s0VCLClasses;

type
  K0DisplayType = (k0dtDetail, k0dtList);
  K0DisplayTypeSet = set of K0DisplayType;

type
  K0FormCreationMode = (
    k0fcmOnlyOne, //２つ以上生成しない。一つだけ。
    k0fcmByOrigin, //表示を要求するフォームごとにフォームを生成
    k0fcmByEntity, //表示するエンティティのインスタンス毎にフォームを生成
    k0fcmByEntityAndOrigin, //表示を要求するフォームごととエンティティごとにフォームを生成
    k0fcmOnShow //表示の要求があるたびにフォームを生成
    );

type
  {
    オーナーであるはずのTs0frmEntityDisplayにDispEntityClassプロパティの変更を
    通知するためだけのクラス。
  }
  Ts0SetDispEntityClassEvent = class(Ts0Event)
  private
    FTargetClass: Ts0EntityClass;
  public
    property TargetClass: Ts0EntityClass read FTargetClass;
  end;

type
  Ts0EntityDispImpl = class(Ts0VCLComponent)
  private
    FDispEntityClassOnAlt: Ts0EntityClass;
    FOnSetDispEntityClass: Ts0SetDispEntityClassEvent;
    function GetDispEntityClass: Ts0EntityClass;
    function GetOwnerForm: TCustomForm;
    function GetOriginForm: TCustomForm;
    procedure SetDispEntityClass(const Value: Ts0EntityClass);
  protected
    function GetManager: Ts0EntityManager; virtual;
    property OriginForm: TCustomForm read GetOriginForm;
    property OwnerForm: TCustomForm read GetOwnerForm;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DispEntityClass: Ts0EntityClass read GetDispEntityClass write SetDispEntityClass;
    property Manager: Ts0EntityManager read GetManager;
    property OnSetDispEntityClass: Ts0SetDispEntityClassEvent read FOnSetDispEntityClass;
  end;

type
  K0EntityDisplayEvent = procedure(Sender: TObject; ADisplay: TCustomForm)
    of object;

type
  Es0EntityDispImplException = class(Exception);

type
  Ts0EntityFormItem = class
  private
    FFormClass: TCustomFormClass;
    FTarget: Ts0EntityClass;
    FDispType: K0DisplayType;
    FIsAlt: Boolean;
    FCreationMode: K0FormCreationMode;
  public
    constructor Create(AFormClass: TCustomFormClass; ATarget: Ts0EntityClass;
      ADispType: K0DisplayType; AIsAlt: Boolean; ACreationMode: K0FormCreationMode);
    property FormClass   : TCustomFormClass   read FFormClass   ;
    property Target      : Ts0EntityClass     read FTarget      ;
    property DispType    : K0DisplayType      read FDispType    ;
    property IsAlt       : Boolean            read FIsAlt       ;
    property CreationMode: K0FormCreationMode read FCreationMode;
  end;

type
  Ts0EntityFormDispRegister = class
  private
  protected
  public
    class function FindDispItemByForm(AClass: TCustomFormClass): Ts0EntityFormItem;
    class function GetFormByName(AFormClassName: string): TCustomFormClass {Ts0frmEntityDisplayClass};
    class procedure GetAltForms(Dest: TClassList);
    class procedure GetFormsByAEntity(Dest: TClassList; AEntity: Ts0EntityClass);
    //class procedure RegisterDisply(AFormClass: TCustomFormClass {Ts0frmEntityDisplayClass});
    //class procedure UnRegisterDisply(AFormClass: TCustomFormClass {Ts0frmEntityDisplayClass});
    class procedure RegisterDisply(AFormClass: TCustomFormClass;
      AEntityClass: Ts0EntityClass; ADispType: K0DisplayType;
      AIsAlt: Boolean = False;
      ACreationMode: K0FormCreationMode = k0fcmByEntityAndOrigin);
    class procedure UnRegisterDisply(AFormClass: TCustomFormClass {Ts0frmEntityDisplayClass});
  end;

function FindRelation(AForm: TCustomForm): Ts0FormRelation;

implementation

function FindRelation(AForm: TCustomForm): Ts0FormRelation;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AForm.ComponentCount -1 do
    if AForm.Components[i] is Ts0FormRelation then
    begin
      Result := Ts0FormRelation(AForm.Components[i]);
      Exit;
    end;
end;

{ Ts0EntityDispImpl }

constructor Ts0EntityDispImpl.Create(AOwner: TComponent);
begin
  inherited;
  FOnSetDispEntityClass := Ts0SetDispEntityClassEvent.Create(Self);
end;

destructor Ts0EntityDispImpl.Destroy;
begin
  FreeAndNil(FOnSetDispEntityClass);
  inherited;                        
end;

function Ts0EntityDispImpl.GetDispEntityClass: Ts0EntityClass;
var
  formItem: Ts0EntityFormItem;
begin
  Result := nil;
  if csDesigning in Self.ComponentState then Exit;
  if OwnerForm = nil then Exit;
  formItem := Ts0EntityFormDispRegister.FindDispItemByForm( TCustomFormClass(OwnerForm.ClassType) );
  if formItem = nil then Exit;
  if formItem.IsAlt then
    Result := FDispEntityClassOnAlt
  else
    Result := formItem.Target;
end;

function Ts0EntityDispImpl.GetManager: Ts0EntityManager;
begin
  Result := nil;
  if csDesigning in Self.ComponentState then Exit;
  Result := Ts0EntityManBroker.Instance.GetManagerByClass(DispEntityClass);
end;

function Ts0EntityDispImpl.GetOriginForm: TCustomForm;
var
  rel: Ts0FormRelation;
begin
  Result := nil;
  if csDesigning in Self.ComponentState then Exit;
  if OwnerForm = nil then Exit;
  rel := FindRelation(OwnerForm);
  if rel = nil then Exit;
  Result := rel.Origin;
end;

function Ts0EntityDispImpl.GetOwnerForm: TCustomForm;
begin
  Result := nil;
  if csDesigning in Self.ComponentState then Exit;
  if Owner is TCustomForm then
    Result := TCustomForm(Owner);
end;

procedure Ts0EntityDispImpl.SetDispEntityClass(
  const Value: Ts0EntityClass);
var
  formItem: Ts0EntityFormItem;
begin
  if not(csDesigning in Self.ComponentState) and (OwnerForm <> nil) then
  begin
    formItem := Ts0EntityFormDispRegister.FindDispItemByForm( TCustomFormClass(OwnerForm.ClassType) );
    if (formItem <> nil) and formItem.IsAlt then
      FDispEntityClassOnAlt := Value;
  end;
  //
  FOnSetDispEntityClass.FTargetClass := Value;
  FOnSetDispEntityClass.NotifyAll;
end;

{ Ts0EntityFormItem }

constructor Ts0EntityFormItem.Create(AFormClass: TCustomFormClass;
  ATarget: Ts0EntityClass; ADispType: K0DisplayType; AIsAlt: Boolean;
  ACreationMode: K0FormCreationMode);
begin
  inherited Create;
  FFormClass := AFormClass;
  FTarget := ATarget;
  FDispType := ADispType;
  FIsAlt := AIsAlt;
  FCreationMode := ACreationMode;
end;

{ Ts0EntityFormDispRegister }

var
  g9FormList: TObjectList = nil;

class procedure Ts0EntityFormDispRegister.GetAltForms(Dest: TClassList);
var
  i: Integer;
  formItem: Ts0EntityFormItem;
begin
  if Dest = nil then Exit;
  if g9FormList = nil then Exit;
  for i := 0 to g9FormList.Count - 1 do
  begin
    formItem := Ts0EntityFormItem(g9FormList.Items[i]);
    if not formItem.FIsAlt then Continue;
    Dest.Add( formItem.FFormClass );
  end;
end;

class function Ts0EntityFormDispRegister.GetFormByName(
  AFormClassName: string): TCustomFormClass;
var
  i: Integer;
  formItem: Ts0EntityFormItem;
begin
  Result := nil;
  if g9FormList = nil then Exit;
  for i := 0 to g9FormList.Count - 1 do
  begin
    formItem := Ts0EntityFormItem(g9FormList.Items[i]);
    if formItem.FFormClass.ClassName <> AFormClassName then Continue;
    if not formItem.FFormClass.InheritsFrom(TCustomForm) then Continue;
    Result := TCustomFormClass( formItem.FFormClass );
    Exit;
  end;
end;

class procedure Ts0EntityFormDispRegister.GetFormsByAEntity(
  Dest: TClassList; AEntity: Ts0EntityClass);
var
  i: Integer;
  formItem: Ts0EntityFormItem;
begin
  if Dest = nil then Exit;
  if g9FormList = nil then Exit;
  for i := 0 to g9FormList.Count - 1 do
  begin
    formItem := Ts0EntityFormItem(g9FormList.Items[i]);
    if formItem.FIsAlt then Continue;
    if not AEntity.InheritsFrom( formItem.FTarget ) then Continue;
    Dest.Add(formItem.FFormClass);
  end;
end;

class function Ts0EntityFormDispRegister.FindDispItemByForm(AClass: TCustomFormClass): Ts0EntityFormItem;
var
  i: Integer;
begin
  for i := 0 to g9FormList.Count -1 do
  begin
    Result := Ts0EntityFormItem(g9FormList.Items[i]);
    if Result.FFormClass = AClass then Exit;
  end;
  Result := nil;
end;

class procedure Ts0EntityFormDispRegister.RegisterDisply(
  AFormClass: TCustomFormClass; AEntityClass: Ts0EntityClass;
  ADispType: K0DisplayType; AIsAlt: Boolean;
  ACreationMode: K0FormCreationMode);
begin
  if g9FormList = nil then
    g9FormList := TObjectList.Create(True);
  if FindDispItemByForm(AFormClass) <> nil then Exit;
  g9FormList.Insert(0,
    Ts0EntityFormItem.Create(AFormClass, AEntityClass, ADispType, AIsAlt, ACreationMode)
  );
end;

class procedure Ts0EntityFormDispRegister.UnRegisterDisply(
  AFormClass: TCustomFormClass);
var
  formItem: Ts0EntityFormItem;
begin
  if g9FormList = nil then Exit;
  formItem := FindDispItemByForm(AFormClass);
  while g9FormList.Remove(formItem) > -1 do
    formItem := FindDispItemByForm(AFormClass);
end;

initialization

finalization
  FreeAndNil(g9FormList);

end.
