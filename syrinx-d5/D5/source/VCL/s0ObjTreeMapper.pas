{-----------------------------------------------------------------------------
 Unit Name: s0ObjTreeMapper
 Author:    akima
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit s0ObjTreeMapper;

interface

uses
  SysUtils, Classes,
  ComCtrls,
  Contnrs,
  s0VCLClasses;

type
  K0GetObjVisible = procedure(Sender: TObject; AParent: TObject; AProp: string;
    AObj: TObject; var AVisible: Boolean) of object;
  K0GetObjCanMap = procedure(Sender: TObject; AParent: TObject; AProp: string;
    AObj: TObject; var ACanMap: Boolean) of object;

type
  K0GetCaptionEvent = procedure(Sender: TObject; AObj: TObject; var ACaption: string) of object;

type
  K0ObjTreeMapClassKind = (
    k0otmckComponent,
    k0otmckCollection,
    k0otmckStrings,
    k0otmckPersistent,
    k0otmckObjectList,
    k0otmckObject
  );
  K0ObjTreeMapClassKindSet = set of K0ObjTreeMapClassKind;

type
  Ts0ObjTreeMapper = class(Ts0VCLComponent)
  private
    FTarget: TObject;
    FTreeView: TTreeView;
    FOnGetCaption: K0GetCaptionEvent;
    FOnCanMap: K0GetObjCanMap;
    FOnGetVisible: K0GetObjVisible;
    FMapClasses: K0ObjTreeMapClassKindSet;
    FMapTargetAsRoot: Boolean;
    FVisibleClasses: K0ObjTreeMapClassKindSet;
    procedure SetTarget(const Value: TObject);
    procedure SetTreeView(const Value: TTreeView);
    procedure SetMapClasses(const Value: K0ObjTreeMapClassKindSet);
    procedure SetMapTargetAsRoot(const Value: Boolean);
    procedure SetVisibleClasses(const Value: K0ObjTreeMapClassKindSet);
    function GetSelected: TObject;
    procedure SetSelected(Value: TObject);
  protected
    function IsInClass(AObj: TObject; AKindSet: K0ObjTreeMapClassKindSet): Boolean;
    function DoCanMap(AParent: TObject; AProp: string; AObj: TObject): Boolean;
    function DoGetVisible(AParent: TObject; AProp: string; AObj: TObject): Boolean;
    procedure DoGetCaption(AObj: TObject; var ACaption: string);
    function GetObjCaption(AObj: TObject; ADefault: string = ''): string;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Target: TObject read FTarget write SetTarget;
    property Selected: TObject read GetSelected write SetSelected;
    procedure Refresh;
  published
    property MapTargetAsRoot: Boolean read FMapTargetAsRoot write SetMapTargetAsRoot default True;
    property MapClasses: K0ObjTreeMapClassKindSet read FMapClasses write SetMapClasses default [k0otmckCollection, k0otmckPersistent, k0otmckObjectList, k0otmckObject];
    property VisibleClasses: K0ObjTreeMapClassKindSet read FVisibleClasses write SetVisibleClasses default [k0otmckCollection, k0otmckPersistent, k0otmckObject];
    property TreeView: TTreeView read FTreeView write SetTreeView;
    property OnGetCaption: K0GetCaptionEvent read FOnGetCaption write FOnGetCaption;
    property OnGetVisible: K0GetObjVisible read FOnGetVisible write FOnGetVisible;
    property OnCanMap: K0GetObjCanMap read FOnCanMap write FOnCanMap;
  end;

type
  Ts0NodeBuilder = class
  private
    FCurrentNode: TTreeNode;
    FMapper: Ts0ObjTreeMapper;
    FMappedList: TObjectList;
    procedure SetCurrentNode(const Value: TTreeNode);
  public
    constructor Create(AMapper: Ts0ObjTreeMapper);
    destructor Destroy; override;
    procedure AddSubNodes(AObj: TObject);
    procedure AddNode(AObj: TObject; ACaption: string; AVisible: Boolean);
    property CurrentNode: TTreeNode read FCurrentNode write SetCurrentNode;
  end;

implementation

uses
  TypInfo,
  s0TypInfoWrapper;

{ Ts0ObjTreeMapper }

constructor Ts0ObjTreeMapper.Create(AOwner: TComponent);
begin
  inherited;
  FMapTargetAsRoot := True;
  FMapClasses := [k0otmckCollection, k0otmckPersistent, k0otmckObjectList, k0otmckObject];
  FVisibleClasses := [k0otmckCollection, k0otmckPersistent, k0otmckObject];
end;

destructor Ts0ObjTreeMapper.Destroy;
begin
  inherited Destroy;
end;

function Ts0ObjTreeMapper.DoCanMap(AParent: TObject; AProp: string;
  AObj: TObject): Boolean;
begin
  Result := IsInClass(AObj, FMapClasses);
  if Assigned(FOnCanMap) then
    FOnCanMap(Self, AParent, AProp, AObj, Result);
end;

procedure Ts0ObjTreeMapper.DoGetCaption(AObj: TObject; var ACaption: string);
begin
  if Assigned(FOnGetCaption) then
    FOnGetCaption(Self, AObj, ACaption);
end;

function Ts0ObjTreeMapper.DoGetVisible(AParent: TObject; AProp: string;
  AObj: TObject): Boolean;
begin
  Result := IsInClass(AObj, FVisibleClasses);
  if Assigned(FOnCanMap) then
    FOnCanMap(Self, AParent, AProp, AObj, Result);
end;

function Ts0ObjTreeMapper.GetObjCaption(AObj: TObject; ADefault: string): string;
  function GetDefaultCaption(AObj: TObject): string;
  var
    acsr: Ts0RTTIPublishedAccessor;
  begin
    Result := '';
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      if acsr.PropertyExists('Caption') and
        (acsr.PropTypeKind('Caption') in [tkString, tkLString, tkWString]) then
      begin
        Result := acsr.PropAsString[ 'Caption' ];
      end;
    finally
      FreeAndNil(acsr);
    end;
  end;
begin
  Result := '';
  if AObj is TComponent then
    Result := TComponent(AObj).Name
  else
  if AObj is TCollectionItem then
    Result := TCollectionItem(AObj).DisplayName;
  //
  if Result = '' then
    Result := GetDefaultCaption(AObj);
  DoGetCaption(AObj, Result);
  //
  if Result <> '' then Exit;
  if ADefault <> '' then
    Result := ADefault
  else
    Result := 'no caption';
end;

function Ts0ObjTreeMapper.GetSelected: TObject;
begin
  Result := nil;
  if FTreeView = nil then Exit;
  if FTreeView.Selected = nil then Exit;
  if FTreeView.Selected.Data = nil then Exit;
  Result := TObject(FTreeView.Selected.Data);
end;

function Ts0ObjTreeMapper.IsInClass(AObj: TObject;
  AKindSet: K0ObjTreeMapClassKindSet): Boolean;
begin
  if AObj is TComponent then
    Result := (k0otmckComponent in AKindSet)
  else
  if AObj is TCollection then
    Result := (k0otmckCollection in AKindSet)
  else
  if AObj is TStrings then
    Result := (k0otmckStrings in AKindSet)
  else
  if AObj is TPersistent then
    Result := (k0otmckPersistent in AKindSet)
  else
  if AObj is TObjectList then
    Result := (k0otmckObjectList in AKindSet)
  else
    Result := (k0otmckObject in AKindSet)
end;

procedure Ts0ObjTreeMapper.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTreeView = AComponent then
    FTreeView := nil;
end;

procedure Ts0ObjTreeMapper.Refresh;
  procedure SaveExpandedNames(Dest: TList);
  var
    i: Integer;
  begin
    for i := 0 to FTreeView.Items.Count -1 do
    begin
      if not FTreeView.Items[i].Expanded then Continue;
      if FTreeView.Items[i].Data = nil then Continue;
      Dest.Add( FTreeView.Items[i].Data );
    end;
  end;
  procedure ExpandItems(AExpandItems: TList);
  var
    i: Integer;
  begin
    for i := 0 to FTreeView.Items.Count -1 do
    begin
      if AExpandItems.IndexOf( FTreeView.Items[i].Data ) > -1 then
        FTreeView.Items[i].Expanded := True;
    end;
  end;
var
  builder: Ts0NodeBuilder;
  selItem: TObject;
  expanded: TList;
begin
  if FTreeView = nil then Exit;
  if FTarget = nil then Exit;
  selItem := Selected;
  expanded := TList.Create;
  try
    SaveExpandedNames(expanded);
    FTreeView.Items.BeginUpdate;
    try
      FTreeView.Items.Clear;
      builder := Ts0NodeBuilder.Create(Self);
      try
        builder.CurrentNode := nil;
        builder.AddNode(FTarget, GetObjCaption(FTarget), MapTargetAsRoot);
      finally
        FreeAndNil(builder);
      end;
    finally
      FTreeView.Items.EndUpdate;
    end;
    ExpandItems(expanded);
    Selected := selItem;
  finally
    FreeAndNil(expanded);
  end;
end;

procedure Ts0ObjTreeMapper.SetMapClasses(const Value: K0ObjTreeMapClassKindSet);
begin
  FMapClasses := Value;
end;

procedure Ts0ObjTreeMapper.SetMapTargetAsRoot(const Value: Boolean);
begin
  FMapTargetAsRoot := Value;
end;

procedure Ts0ObjTreeMapper.SetSelected(Value: TObject);
var
  i: Integer;
begin
  if FTreeView = nil then Exit;
  for i := 0 to FTreeView.Items.Count -1 do
  begin
    if FTreeView.Items[i].Data = Value then
      FTreeView.Selected := FTreeView.Items[i];
  end;
end;

procedure Ts0ObjTreeMapper.SetTarget(const Value: TObject);
begin
  FTarget := Value;
end;

procedure Ts0ObjTreeMapper.SetTreeView(const Value: TTreeView);
begin
  FTreeView := Value;
end;

procedure Ts0ObjTreeMapper.SetVisibleClasses(
  const Value: K0ObjTreeMapClassKindSet);
begin
  FVisibleClasses := Value;
end;

{ Ts0NodeBuilder }

procedure Ts0NodeBuilder.AddNode(AObj: TObject; ACaption: string; AVisible: Boolean);
  function AlreadyExists(AObj: TObject): Boolean;
  begin
    Result := FMappedList.IndexOf(AObj) > -1;
  end;
var
  bufNode: TTreeNode;
begin
  if AObj = nil then Exit;
  bufNode := FCurrentNode;
  try
    if AlreadyExists(AObj) then Exit;
    if AVisible then
      FCurrentNode :=
        FMapper.TreeView.Items.AddChildObject(FCurrentNode, ACaption, AObj);
    FMappedList.Add(AObj);
    AddSubNodes(AObj);
  finally
    FCurrentNode := bufNode;
  end;
end;

procedure Ts0NodeBuilder.AddSubNodes(AObj: TObject);
  procedure AddPropItem(AItem: TObject; APropName: string);
  var
    cptn: string;
  begin
    if not FMapper.DoCanMap(AObj, APropName, AItem) then Exit;
    cptn := FMapper.GetObjCaption(AItem, APropName);
    AddNode( AItem, cptn, FMapper.DoGetVisible(AObj, APropName, AItem) );
  end;
var
  acsr: Ts0RTTIPublishedAccessor;
  props: Ts0RTTIProps;
  p: Ts0RTTIProp;
  i: Integer;
  itemObj: TObject;
begin
  if AObj is TCollection then
  begin
    for i := 0 to TCollection(AObj).Count -1 do
      AddPropItem(TCollection(AObj).Items[i], 'Items');
  end
  else
  if AObj is TObjectList then
  begin
    for i := 0 to TObjectList(AObj).Count -1 do
      AddPropItem(TObjectList(AObj).Items[i], 'Items');
  end
  else
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      props := acsr.RTTINavigator.Props;
      for i := 0 to props.Count -1 do
      begin
        p := props.Props[i];
        if p.TypeInfo.TypeKind <> tkClass then Continue;
        itemObj := acsr.ObjectProp[p.PropName];
        if itemObj = nil then Continue;
        AddPropItem(itemObj, p.PropName);
      end;
    finally
      FreeAndNil(acsr);
    end;
  end;
end;

constructor Ts0NodeBuilder.Create(AMapper: Ts0ObjTreeMapper);
begin
  inherited Create;
  FMapper := AMapper;
  FMappedList := TObjectList.Create(False);
end;

destructor Ts0NodeBuilder.Destroy;
begin
  FreeAndNil(FMappedList);
  inherited;
end;

procedure Ts0NodeBuilder.SetCurrentNode(const Value: TTreeNode);
begin
  FCurrentNode := Value;
end;

end.
