{-----------------------------------------------------------------------------
 Unit Name: s0UnifiedObjCtrl
 Author:    akima
 Purpose:
 TestCase: tc_s0UnifiedObjCtrl
 See: Qs0UnifiedObjCtrl
 $History: s0UnifiedObjCtrl.pas $
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/03/12   Time: 2:33
 * Updated in $/D6/source/VCL
 * BuildCtrlsÅAClearCtrlsÇoverrideÇµÇΩÅB
-----------------------------------------------------------------------------}

unit s0UnifiedObjCtrl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CtrlOfType,
  s0PropertyProtoType,
  s0ObjCtrlBuilder,
  s0CollectionGrid;

type
  Ts0UOCProtoType = class(Ts0ProtoTypeCtrl)
  public
    procedure LoadFromTarget; override;
    procedure SaveToTarget; override;
  end;

type
  Ts0UOCProtoTypes = class(Ts0ProtoTypeCtrls)
  protected
  end;

type
  Ts0UOCBuilder = class(Ts0ObjCtrlBuilder)
  protected
    function CreateCtrlOf(AProp: Ts0ProtoTypeCtrl): TControl; override;
    procedure DoFindCtrlClass(AProp: Ts0ProtoTypeCtrl; var ACtrlClass: TControlClass); override;
  end;

type
  Ts0UnifiedObjCtrl = class(Ts0ObjCtrlBridge)
  private
    FGrid: Ts0CollectionGrid;
  protected
    function NewBuilder: Ts0ObjCtrlBuilder; override;
    function NewProtoTypes: Ts0ProtoTypeCtrls; override;
    procedure SetTarget(const Value: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BuildCtrls; override;
    procedure ClearCtrls; override;
    procedure LoadFromTarget; override;
    procedure SaveToTarget; override;
  end;

implementation

uses
  TypInfo,
  s0CtrlOfType_StdCtrls,
  s0ComponentHelper,
  s0TypInfoWrapper;

{ Ts0UOCProtoType }

procedure Ts0UOCProtoType.LoadFromTarget;
begin
  if Ctrl is Ts0CollectionGrid then
    Ts0CollectionGrid(Ctrl).LoadFromTarget
  else
    inherited LoadFromTarget;
end;

procedure Ts0UOCProtoType.SaveToTarget;
begin
  if Ctrl is Ts0CollectionGrid then
    Ts0CollectionGrid(Ctrl).SaveToTarget
  else
    inherited SaveToTarget;
end;

{ Ts0UOCBuilder }

const
  c9GridWidthMargin = 10;

function Ts0UOCBuilder.CreateCtrlOf(AProp: Ts0ProtoTypeCtrl): TControl;
var
  w: Ts0RTTIPublishedAccessor;
  obj: TObject;
begin
  Result := inherited CreateCtrlOf(AProp);
  if not(Result is Ts0CollectionGrid) then Exit;
  w := Wrapper;
  if w.PropTypeKind(AProp.PropertyName) <> tkClass then Exit;
  obj := w.ObjectProp[ AProp.PropertyName ];
  if not(obj is TCollection) then Exit;
  if Ts0CollectionGrid(Result).Target <> obj then
  begin
    Ts0CollectionGrid(Result).Target := TCollection(obj);
    Result.Width := Ts0CollectionGrid(Result).Columns.AllColWidth + c9GridWidthMargin;
    Ts0CollectionGrid(Result).PrepareCommands;
    Ts0CollectionGrid(Result).CreateCmdMenu;
  end;
  Ts0CollectionGrid(Result).LoadFromTarget;
end;

procedure Ts0UOCBuilder.DoFindCtrlClass(AProp: Ts0ProtoTypeCtrl;
  var ACtrlClass: TControlClass);
var
  cls: TPersistentClass;
begin
  cls := GetClass(AProp.TypeName);
  if cls = nil then Exit;
  if cls.InheritsFrom(TCollection) then
    ACtrlClass := Ts0CollectionGrid;
  inherited DoFindCtrlClass(AProp, ACtrlClass);
end;

{ Ts0UnifiedObjCtrl }

procedure Ts0UnifiedObjCtrl.BuildCtrls;
begin
  if Target is TCollection then
  begin
    if FGrid = nil then
    begin
      FGrid := Ts0CollectionGrid.Create(Self);
      FGrid.Parent := Builder.CtrlParent;
      FGrid.Name := Ts0ComponentHelper.GetNewComponentName(FGrid);
      FGrid.Align := alClient;
      FGrid.Width := FGrid.Columns.AllColWidth + c9GridWidthMargin;
      FGrid.PrepareCommands;
      FGrid.CreateCmdMenu;
    end;
    FGrid.Target := TCollection(Target);
  end;
  inherited BuildCtrls;
end;

procedure Ts0UnifiedObjCtrl.ClearCtrls;
begin
  if FGrid <> nil then
  begin
    FreeAndNil(FGrid);
  end;
  inherited;
end;

constructor Ts0UnifiedObjCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor Ts0UnifiedObjCtrl.Destroy;
begin
  inherited;
end;

procedure Ts0UnifiedObjCtrl.LoadFromTarget;
  procedure BindGridTargets;
  var
    i: Integer;
    p: Ts0ProtoTypeCtrl;
    obj: TObject;
  begin
    if Wrapper = nil then Exit; 
    for i := 0 to ProtoTypes.Count -1 do
    begin
      p := ProtoTypes.PropCtrls[i];
      if not(p.Ctrl is Ts0CollectionGrid) then Continue;
      obj := Wrapper.ObjectProp[p.PropertyName];
      if not(obj is TCollection) then Exit;
      if Ts0CollectionGrid(p.Ctrl).Target = TCollection(obj) then Exit;
      Ts0CollectionGrid(p.Ctrl).Target := TCollection(obj);
    end;
  end;
begin
  BindGridTargets;
  if FGrid <> nil then
    FGrid.LoadFromTarget
  else
    inherited LoadFromTarget;
end;

function Ts0UnifiedObjCtrl.NewBuilder: Ts0ObjCtrlBuilder;
begin
  Result := Ts0UOCBuilder.Create(Self);
end;

function Ts0UnifiedObjCtrl.NewProtoTypes: Ts0ProtoTypeCtrls;
begin
  Result := Ts0UOCProtoTypes.Create(Self, Ts0UOCProtoType);
end;

procedure Ts0UnifiedObjCtrl.SaveToTarget;
begin
  if FGrid <> nil then
    FGrid.SaveToTarget
  else
    inherited SaveToTarget;
end;

procedure Ts0UnifiedObjCtrl.SetTarget(const Value: TObject);
var
  ti: Ts0RTTITypeInfo;
  prop: Ts0RTTIProp;
  i: Integer;
begin
  inherited SetTarget(Value);
  if Target = nil then Exit;
  if Target is TPersistent then
    RegisterClass( TPersistentClass(Target.ClassType) );
  if not(Target is TCollection) then
  begin
    ti := Ts0RTTIPublishedBroker.Instance.GetTypeInfoByClass( Target.ClassType );
    for i := 0 to ti.PublishedProps.Props.Count -1 do
    begin
      prop := ti.PublishedProps.Props[i];
      if prop.TypeInfo = nil then Continue;
      if prop.TypeInfo.ClassOfType = nil then Continue;
      if prop.TypeInfo.ClassOfType.InheritsFrom(TPersistent) then
        RegisterClass( TPersistentClass(prop.TypeInfo.ClassOfType) );
    end;
  end;
end;

end.
