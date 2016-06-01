{-----------------------------------------------------------------------------
 Unit Name: s0ObjTreeMapAction
 Author:    akima
 See also: StdActns
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit s0ObjTreeMapAction;

interface

uses
  SysUtils, Classes,
  Contnrs,
  ComCtrls,
  ActnList,
  s0ObjTreeMapper;

type
  Ks0MappActionOption = (
    ks0maoRefreshAfterExecute, ks0maoHandleUpperNode, ks0maoEnabledCtrlByProp
    );
  Ks0MappActionOptions = set of Ks0MappActionOption;

type
  Ts0Custom0ObjTreeMapAction = class(TAction)
  private
    FMapper: Ts0ObjTreeMapper;
    FTargetClassName: string;
    FTargetMethodName: string;
    FOptions: Ks0MappActionOptions;
    FEnabledCtrlPropName: string;
    procedure SetMapper(const Value: Ts0ObjTreeMapper);
    procedure SetTargetClassName(const Value: string);
    procedure SetTargetMethodName(const Value: string);
    procedure SetOptions(const Value: Ks0MappActionOptions);
  protected
    function FindUpperNodeTarget(ASubNode: TTreeNode): TTreeNode;
    function GetTargetObj: TObject;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
  public
    function IsTargetObj(AObj: TObject): Boolean; virtual;
    property Mapper: Ts0ObjTreeMapper read FMapper write SetMapper;
  published
    property EnabledCtrlPropName: string read FEnabledCtrlPropName write FEnabledCtrlPropName;
    property TargetClassName: string read FTargetClassName write SetTargetClassName;
    property TargetMethodName: string read FTargetMethodName write SetTargetMethodName;
    property Options: Ks0MappActionOptions read FOptions write SetOptions
      default [ks0maoRefreshAfterExecute, ks0maoHandleUpperNode, ks0maoEnabledCtrlByProp];
  end;

type
  Ts0ObjTreeMapAction = class(Ts0Custom0ObjTreeMapAction)
  published
    property TargetClassName;
    property TargetMethodName;
  end;

implementation

uses
  s0ObjectHelper,
  TypInfo,
  s0TypInfoWrapper;
  
{ Ts0Custom0ObjTreeMapAction }

constructor Ts0Custom0ObjTreeMapAction.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [ks0maoRefreshAfterExecute, ks0maoHandleUpperNode, ks0maoEnabledCtrlByProp];
end;

procedure Ts0Custom0ObjTreeMapAction.ExecuteTarget(Target: TObject);
var
  obj: TObject;
  acsr: Ts0RTTIPublishedAccessor;
begin
  if TargetMethodName = '' then Exit;
  if Mapper = nil then Exit;
  if Mapper.Selected = nil then Exit;
  obj := GetTargetObj;
  if obj = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(obj);
  try
    acsr.ExecuteMethod(TargetMethodName);
  finally
    FreeAndNil(acsr);
  end;
  if ks0maoRefreshAfterExecute in Options then
    Mapper.Refresh;
end;

function Ts0Custom0ObjTreeMapAction.FindUpperNodeTarget(
  ASubNode: TTreeNode): TTreeNode;
begin
  Result := nil;
  if ASubNode = nil then Exit;
  Result := ASubNode.Parent;
  while Result <> nil do
  begin
    if Result.Data <> nil then
      if IsTargetObj(TObject(Result.Data)) then Exit;
    Result := Result.Parent;
  end;
  Result := nil;
end;

function Ts0Custom0ObjTreeMapAction.GetTargetObj: TObject;
var
  n: TTreeNode;
begin
  Result := nil;
  if Mapper = nil then Exit;
  if IsTargetObj(Mapper.Selected) then
    Result := Mapper.Selected;
  if not(ks0maoHandleUpperNode in Options) then Exit;
  if Result <> nil then Exit;
  if Mapper.TreeView = nil then Exit;
  n := FindUpperNodeTarget(Mapper.TreeView.Selected);
  if n = nil then Exit;
  if n.Data = nil then Exit;
  Result := TObject(n.Data);
end;

function Ts0Custom0ObjTreeMapAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := GetTargetObj <> nil;
end;

function Ts0Custom0ObjTreeMapAction.IsTargetObj(AObj: TObject): Boolean;
  function HasMethod(AObj: TObject): Boolean;
  var
    acsr: Ts0RTTIPublishedAccessor;
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      Result := acsr.RTTINavigator.MethodEnumerator.IndexOf(TargetMethodName) > -1;
    finally
      FreeAndNil(acsr);
    end;
  end;
begin
  Result := False;
  if AObj = nil then Exit;
  if TargetClassName <> '' then
    if not Ts0ObjectHelper.ClassInheritesFrom(AObj.ClassType, FTargetClassName) then Exit;
  Result := HasMethod(AObj);
end;

procedure Ts0Custom0ObjTreeMapAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FMapper = AComponent then
    FMapper := nil;
end;

procedure Ts0Custom0ObjTreeMapAction.SetMapper(const Value: Ts0ObjTreeMapper);
begin
  if Value <> FMapper then
  begin
    FMapper := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure Ts0Custom0ObjTreeMapAction.SetOptions(
  const Value: Ks0MappActionOptions);
begin
  FOptions := Value;
end;

procedure Ts0Custom0ObjTreeMapAction.SetTargetClassName(
  const Value: string);
begin
  FTargetClassName := Value;
end;

procedure Ts0Custom0ObjTreeMapAction.SetTargetMethodName(
  const Value: string);
begin
  FTargetMethodName := Value;
end;

procedure Ts0Custom0ObjTreeMapAction.UpdateTarget(Target: TObject);
  function GetEnabledByProp: Boolean;
  var
    obj: TObject;
    acsr: Ts0RTTIPublishedAccessor;
    p: Ts0RTTIProp;
  begin
    Result := False;
    obj := GetTargetObj;
    if obj = nil then Exit;
    acsr := Ts0RTTIPublishedAccessor.Create(obj);
    try
      p := acsr.RTTINavigator.Props.PropByName(FEnabledCtrlPropName);
      if p = nil then Exit;
      if not(p.TypeInfo.TypeKind in [tkInteger, tkChar, tkEnumeration]) then Exit;
      Result := acsr.OrdProp[FEnabledCtrlPropName] = Integer(True);
    finally
      FreeAndNil(acsr);
    end;
  end;
begin
  if (ks0maoEnabledCtrlByProp in Options) and (FEnabledCtrlPropName <> '') then
    Enabled := GetEnabledByProp
  else
    Enabled := True;
end;

end.
