unit s0ObjTreeMapMenu;

interface

uses
  SysUtils, Classes,
  ComCtrls,
  Menus,
  s0VCLClasses;


type
  K0MapMenuItemKind = (k0mmikRefresh, k0mmikAddChild, k0mmikRemoveSelf, k0mmikClearChildren, k0mmikPublishedMethods, k0mmikNone);
  K0MapMenuItemKinds = set of K0MapMenuItemKind;

  K0MapMenuItemQueryEvent = procedure(Sender: TObject; AObj: TObject;
    var AKinds: K0MapMenuItemKinds) of object;

  K0MenuItemClickQueryEvent = procedure(Sender: TObject; AItem: TMenuItem;
    AObj: TObject; AMethodName: string; var AKind: K0MapMenuItemKind;
    var AutoExecute: Boolean) of object;

  K0MenuItemClickNotifyEvent = procedure(Sender: TObject; AItem: TMenuItem;
    AObj: TObject; AMethodName: string; AKind: K0MapMenuItemKind) of object;

type
  Ts0ObjTreeMapMenu = class(Ts0VCLComponent)
  private
    FPopup: TPopupMenu;
    FTreeView: TTreeView;
    FOnPrepareItems: K0MapMenuItemQueryEvent;
    FBeforeMenuItemClick: K0MenuItemClickQueryEvent;
    FOnNeedRefresh: TNotifyEvent;
    FAfterMenuItemClick: K0MenuItemClickNotifyEvent;
    procedure SetTreeView(const Value: TTreeView);
    function GetSelected: TObject;
  protected
    function ExecAdd(AObj: TObject): TObject; virtual;
    procedure ExecClear(AObj: TObject); virtual;
    procedure ExecMethod(AObj: TObject; AMethod: string); virtual;
    procedure ExecRefresh; virtual;
    procedure ExecRemove(AObj: TObject); virtual;
  protected
    function CreateMenuItem(ACaption: string; AObj: TObject;
      AKind: K0MapMenuItemKind; AMethodName: string; AAction: TBasicAction = nil): TMenuItem;
    procedure DoPrepareItems(AObj: TObject; var AKinds: K0MapMenuItemKinds);
    function GetMapItemKinds(AObj: TObject): K0MapMenuItemKinds;
    function NewPopup: TPopupMenu; virtual;
    procedure PrepareItems;
  protected
    procedure DoBeforeMenuItemClick(AItem: TMenuItem; AObj: TObject;
      AMethodName: string; var AKind: K0MapMenuItemKind; var AutoExecute: Boolean); virtual;
    procedure DoAfterMenuItemClick(AItem: TMenuItem;
      AObj: TObject; AMethodName: string; AKind: K0MapMenuItemKind); virtual;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Popup: TPopupMenu read FPopup;
    property Selected: TObject read GetSelected;
  published
    property TreeView: TTreeView read FTreeView write SetTreeView;
    property OnNeedRefresh: TNotifyEvent read FOnNeedRefresh write FOnNeedRefresh;
    property OnPrepareItems: K0MapMenuItemQueryEvent read FOnPrepareItems write FOnPrepareItems;
    property BeforeMenuItemClick: K0MenuItemClickQueryEvent read FBeforeMenuItemClick write FBeforeMenuItemClick;
    property AfterMenuItemClick: K0MenuItemClickNotifyEvent read FAfterMenuItemClick write FAfterMenuItemClick;
  end;

implementation

uses
  Forms,
  s0ObjectHelper,
  s0ObjTreeMapAction,
  s0ComponentVisitor,
  s0StringHelper,
  s0TypInfoWrapper;

type
  Ts9PopupMenu = class(TPopupMenu)
  private
    FOwnerMenuCtrl: Ts0ObjTreeMapMenu;
  protected
    procedure DoPopup(Sender: TObject); override;
  end;

type
  Ts9MenuItem = class(TMenuItem)
  private
    FOwnerMenuCtrl: Ts0ObjTreeMapMenu;
    FItemKind: K0MapMenuItemKind;
    FObject: TObject;
    FExecMethodName: string;
  protected
    procedure FookOnClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
    property ExecMethodName: string read FExecMethodName;
  end;

{ Ts9PopupMenu }

procedure Ts9PopupMenu.DoPopup(Sender: TObject);
begin
  FOwnerMenuCtrl.PrepareItems;
  inherited DoPopup(Sender);
end;

{ Ts9MenuItem }

procedure Ts9MenuItem.Click;
  function QueryToExecute: Boolean;
  begin
    Result := True;
    FOwnerMenuCtrl.DoBeforeMenuItemClick(Self, FObject, FExecMethodName, FItemKind, Result);
  end;
  procedure NotifyAfterClick;
  begin
    FOwnerMenuCtrl.DoAfterMenuItemClick(Self, FObject, FExecMethodName, FItemKind);
  end;
begin
  if not Enabled then Exit;
  if not QueryToExecute then Exit; 
  inherited Click;
  NotifyAfterClick;
end;

constructor Ts9MenuItem.Create(AOwner: TComponent);
begin
  inherited;
  OnClick := FookOnClick;
end;

procedure Ts9MenuItem.FookOnClick(Sender: TObject);
begin
  case FItemKind of
    k0mmikRefresh: FOwnerMenuCtrl.ExecRefresh;
    k0mmikAddChild: FOwnerMenuCtrl.ExecAdd(FObject);
    k0mmikRemoveSelf: FOwnerMenuCtrl.ExecRemove(FObject);
    k0mmikClearChildren: FOwnerMenuCtrl.ExecClear(FObject);
    k0mmikPublishedMethods: FOwnerMenuCtrl.ExecMethod(FObject, FExecMethodName);
    k0mmikNone: ;
  end;
end;

type
  Ts9ActionFinder = class(Ts0ComponentFinder)
  private
    FTreeView: TTreeView;
  protected
    function DoMatch(AComponent: TComponent): Boolean; override;
  public
    property TreeView: TTreeView read FTreeView write FTreeView;
    procedure Execute; override;
  end;

{ Ts9ActionFinder }

function Ts9ActionFinder.DoMatch(AComponent: TComponent): Boolean;
begin
  Result := AComponent is Ts0Custom0ObjTreeMapAction;
end;

procedure Ts9ActionFinder.Execute;
var
  f: TCustomForm;
begin
  if FTreeView = nil then Exit;
  f := GetParentForm(FTreeView);
  if f = nil then Exit;
  Target := f;
  inherited Execute;
end;

{ Ts0ObjTreeMapMenu }

constructor Ts0ObjTreeMapMenu.Create(AOwner: TComponent);
begin
  inherited;
  FPopup := NewPopup;
end;

function Ts0ObjTreeMapMenu.CreateMenuItem(ACaption: string; AObj: TObject;
  AKind: K0MapMenuItemKind; AMethodName: string; AAction: TBasicAction): TMenuItem;
begin
  Result := Ts9MenuItem.Create(nil);
  Result.Caption := ACaption;
  Result.Action := AAction;
  Ts9MenuItem(Result).FOwnerMenuCtrl := Self;
  Ts9MenuItem(Result).FItemKind := AKind;
  Ts9MenuItem(Result).FExecMethodName := AMethodName;
  Ts9MenuItem(Result).FObject := AObj;
  FPopup.Items.Add(Result);
end;

destructor Ts0ObjTreeMapMenu.Destroy;
begin
  FreeAndNil(FPopup);
  inherited;
end;

procedure Ts0ObjTreeMapMenu.DoPrepareItems(AObj: TObject;
  var AKinds: K0MapMenuItemKinds);
begin
  if Assigned(FOnPrepareItems) then
    FOnPrepareItems(Self, AObj, AKinds);
end;

procedure Ts0ObjTreeMapMenu.DoAfterMenuItemClick(AItem: TMenuItem;
  AObj: TObject; AMethodName: string; AKind: K0MapMenuItemKind);
begin
  if Assigned(FAfterMenuItemClick) then
    FAfterMenuItemClick(Self, AItem, AObj, AMethodName, AKind);
end;

procedure Ts0ObjTreeMapMenu.DoBeforeMenuItemClick(AItem: TMenuItem;
  AObj: TObject; AMethodName: string; var AKind: K0MapMenuItemKind;
  var AutoExecute: Boolean);
begin
  if Assigned(FBeforeMenuItemClick) then
    FBeforeMenuItemClick(Self, AItem, AObj, AMethodName, AKind, AutoExecute);
end;

procedure Ts0ObjTreeMapMenu.ExecRefresh;
begin
  if Assigned(FOnNeedRefresh) then
    FOnNeedRefresh(Self);
end;

function Ts0ObjTreeMapMenu.ExecAdd(AObj: TObject): TObject;
begin
  Result := nil;
  if AObj is TCollection then
    Result := TCollection(AObj).Add;
end;

procedure Ts0ObjTreeMapMenu.ExecRemove(AObj: TObject);
begin
  if AObj is TCollectionItem then
    TCollectionItem(AObj).Free;
end;

procedure Ts0ObjTreeMapMenu.ExecClear(AObj: TObject);
begin
  if AObj is TCollection then
    TCollection(AObj).Clear;
end;

procedure Ts0ObjTreeMapMenu.ExecMethod(AObj: TObject; AMethod: string);
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  acsr := Ts0RTTIPublishedAccessor.Create(AObj);
  try
    if acsr.RTTINavigator.MethodEnumerator.IndexOf(AMethod) < 0 then Exit;
    acsr.ExecuteMethod(AMethod);
  finally
    FreeAndNil(acsr);
  end;
end;

function Ts0ObjTreeMapMenu.GetMapItemKinds(
  AObj: TObject): K0MapMenuItemKinds;
begin
  Result := [k0mmikRefresh];
  if AObj is TCollectionItem then
    Result := [k0mmikRefresh, k0mmikRemoveSelf]
  else
  if AObj is TCollection then
    Result := [k0mmikRefresh, k0mmikAddChild, k0mmikClearChildren];
  //
  Include(Result, k0mmikPublishedMethods);
  DoPrepareItems(AObj, Result);
end;

function Ts0ObjTreeMapMenu.GetSelected: TObject;
begin
  Result := nil;
  if FTreeView = nil then Exit;
  if FTreeView.Selected = nil then Exit;
  if FTreeView.Selected.Data = nil then Exit;
  Result := TObject(FTreeView.Selected.Data);
end;

function Ts0ObjTreeMapMenu.NewPopup: TPopupMenu;
begin
  Result := Ts9PopupMenu.Create(nil);
  Ts9PopupMenu(Result).FOwnerMenuCtrl := Self;
end;

procedure Ts0ObjTreeMapMenu.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTreeView = AComponent then
    FTreeView := nil;
end;

procedure Ts0ObjTreeMapMenu.PrepareItems;
  function FindAction(AObj: TObject; AMethodName: string): Ts0Custom0ObjTreeMapAction;
  var
    finder: Ts9ActionFinder;
    nextBest: Ts0Custom0ObjTreeMapAction;
    i: Integer;
    act: Ts0Custom0ObjTreeMapAction;
  begin
    nextBest := nil;
    finder := Ts9ActionFinder.Create;
    try
      finder.TreeView := FTreeView;
      finder.Execute;
      for i := 0 to finder.ResultList.Count -1 do
      begin
        if not(finder.ResultList.Items[i] is Ts0Custom0ObjTreeMapAction) then Continue;
        act := Ts0Custom0ObjTreeMapAction(finder.ResultList.Items[i]);
        if not SameText(act.TargetMethodName, AMethodName) then Continue;
        if act.TargetClassName = '' then
          nextBest := act
        else
        begin
          if Ts0ObjectHelper.ClassInheritesFrom(AObj.ClassType, act.TargetClassName) then
          begin
            Result := act;
            Exit;
          end;
        end;
      end;
      Result := nextBest;
    finally
      FreeAndNil(finder);
    end;
  end;

  procedure CreateWithAction(AObj: TObject; AMethodName: string);
  var
    act: Ts0Custom0ObjTreeMapAction;
  begin
    act := FindAction(AObj, AMethodName);
    if act = nil then
      CreateMenuItem(AMethodName, AObj, k0mmikPublishedMethods, AMethodName)
    else
      CreateMenuItem(act.Caption, AObj, k0mmikPublishedMethods, AMethodName, act);
  end;

  procedure AddItemByRTTI(AObj: TObject);
  var
    acsr: Ts0RTTIPublishedAccessor;
    methods: Ts0MethodEnumerator;
    i: Integer;
  begin
    if AObj = nil then Exit;
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      methods := acsr.RTTINavigator.MethodEnumerator;
      if methods.MethodCount < 1 then Exit;
      CreateMenuItem('-', nil, k0mmikNone, '');
      for i := 0 to methods.MethodCount -1 do
        CreateWithAction(AObj, methods.NameOfMethod[i]);
    finally
      FreeAndNil(acsr);
    end;
  end;

  procedure AddMenuItem(AObj: TObject; AKind: K0MapMenuItemKind);
  const
    c9Captions: array[K0MapMenuItemKind] of string = (
      //'Refresh', 'Add', 'Remove', 'Clear', '', ''
      '最新の情報に更新(&R)', '追加(&A)', '削除(&D)', 'クリア(&C)', '', ''
    );
  begin
    case AKind of
      k0mmikRefresh,
      k0mmikAddChild,
      k0mmikRemoveSelf,
      k0mmikClearChildren: CreateMenuItem(c9Captions[AKind], AObj, AKind, c9Captions[AKind]);
      k0mmikPublishedMethods: AddItemByRTTI(AObj);
      k0mmikNone: ;
    end;
  end;
var
  obj: TObject;
  i: K0MapMenuItemKind;
  addItemKind: K0MapMenuItemKinds;
begin
  FPopup.Items.Clear;
  obj := Selected;
  addItemKind := GetMapItemKinds(obj);
  for i := Low(K0MapMenuItemKind) to High(K0MapMenuItemKind) do
    if i in addItemKind then
      AddMenuItem(obj, i);
end;

procedure Ts0ObjTreeMapMenu.SetTreeView(const Value: TTreeView);
begin
  if FTreeView = Value then Exit;
  if Value = nil then
    FTreeView.PopupMenu := nil;
  FTreeView := Value;
  if FTreeView <> nil then
    FTreeView.PopupMenu := FPopup;
end;

end.
