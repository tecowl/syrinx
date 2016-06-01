{-----------------------------------------------------------------------------
 Unit Name: s0TreeViewController
 Author:    akima
 Purpose:
 TestCase: tc_s0TreeViewController
 See: Qs0TreeViewController
 $History: s0TreeViewController.pas $
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/12   Time: 2:32
 * Updated in $/D6/source/VCL
 * ツリーへのノードの追加の仕組みを変更
-----------------------------------------------------------------------------}

unit s0TreeViewController;
{
$History: s0TreeViewController.pas $
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/12   Time: 2:32
 * Updated in $/D6/source/VCL
 * ツリーへのノードの追加の仕組みを変更
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/25   Time: 12:40
 * Updated in $/source/D5Integrated
 * 指定したプロパティ名で、ツリーのノードにチェックを描画するオプションを
 * 追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/02/21   Time: 23:25
 * Updated in $/source/D5Integrated
 * TreeViewへ表示する際のCaptionをどのように取得するのかを設定できるように
 * CaptionKindプロパティを追加。
 * リフレッシュするタイミングをRefreshAfterMenuClickプロパティで指定できる
 * ようにした。
 * また、リフレッシュした際にFullExpandするかどうかを指定するRefreshWithFu
 * llExpandプロパティを追加。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/03   Time: 23:47
 * Updated in $/source/D5Integrated
 * s0fObjPropEditor -> s0fObjEditor
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/02   Time: 5:13
 * Updated in $/source/D5/p0EntityCtrl
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/02   Time: 3:16
 * Updated in $/source/D5Integrated
 * イベントを追加した。
 * 更新の排他フラグがずっとTrueのままだったので修正。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/01   Time: 9:12
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/27   Time: 9:16
 * Updated in $/source/D5Integrated
 * 変更中に一時チェックイン。
 * CollectionからNodeを作成する。
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/25   Time: 10:13
 * Created in $/source/D5Integrated
 * 新規作成
}

interface

uses
  Windows, SysUtils, Classes, Controls, StdCtrls,
  ComCtrls, Menus,
  s0VCLClasses,
  s0Observer,
  s0Collection;

type
  K0NewTreeNodeQueryEvent = procedure(Sender: TObject; AParent: TTreeNode;
    var CanAdd: Boolean) of object;
  K0NewTreeNodeEvent = procedure(Sender: TObject; AParent: TTreeNode;
    var ACaption: string; var AData: TObject) of object;

type
  K0AccessObjEvent = procedure(Sender: TObject; ATarget: TTreeNode) of object;

type
  K0RemoveTreeNodeQueryEvent = procedure(Sender: TObject; ATarget:
    TTreeNode; var CanRemove: Boolean) of object;
  K0RemoveTreeNodeEvent = K0AccessObjEvent;

type
  K0ItemCaptionKind = (k0ickDisplayName, k0ickNamePath, k0ickIdentifier, k0ickCustom);

type
  K0TreeViewCtrlOption = (k0tvcoRefreshAfterMenuClick, k0tvcoRefreshWithFullExpand,
    k0tvcoCheckEnabled);
  K0TreeViewCtrlOptions = set of K0TreeViewCtrlOption;

type
  K0GetItemCheckedEvent = procedure(Sender: TObject; AItem: TObject;
    var AState: TCheckBoxState) of object;
  K0SetItemCheckedEvent = procedure(Sender: TObject; AItem: TObject;
    AState: TCheckBoxState) of object;

type
  K0CallSubItems = procedure(ASubItems: Ts0Collection) of object;
  K0GetSubItemsEvent = procedure(Sender: TObject; AItem: Ts0CollectionItem;
    Proc: K0CallSubItems) of object;

type
  Ts0TreeViewController = class(Ts0VCLComponent)
  private
    FTreeView: TTreeView;
    FMenuAdd: TMenuItem;
    FMenuAddChild: TMenuItem;
    FMenuProperty: TMenuItem;
    FMenuRefresh: TMenuItem;
    FMenuRemove: TMenuItem;
    FOnAddItem: K0NewTreeNodeEvent;
    FOnRemoveItem: K0RemoveTreeNodeEvent;
    FOnCanAddItem: K0NewTreeNodeQueryEvent;
    FOnCanRemoveItem: K0RemoveTreeNodeQueryEvent;
    FModel: Ts0Collection;
    FCollectionUpdateListener: Ts0EventListener;
    FModelUpdating: Boolean;
    FOnRefreshView: TNotifyEvent;
    FAfterShowProp: K0AccessObjEvent;
    FBeforeShowProp: K0AccessObjEvent;
    FCaptionKind: K0ItemCaptionKind;
    FOptions: K0TreeViewCtrlOptions;
    FStateImages: TImageList;
    FOnGetItemChecked: K0GetItemCheckedEvent;
    FCheckedPropName: string;
    FOnChangeItemChecked: K0SetItemCheckedEvent;
    FOnGetSubItems: K0GetSubItemsEvent;
    procedure SetTreeView(const Value: TTreeView);
    procedure SetModel(const Value: Ts0Collection);
    function GetSelectedItem: Ts0CollectionItem;
    procedure SetCaptionKind(const Value: K0ItemCaptionKind);
    procedure SetOptions(const Value: K0TreeViewCtrlOptions);
    procedure SetCheckedPropName(const Value: string);
  protected
    procedure CreateMenus;
    procedure DoAddItem(AParent: TTreeNode; var ACaption: string; var AData: TObject);
    procedure DoAfterShowProp(ATarget: TTreeNode);
    procedure DoBeforeShowProp(ATarget: TTreeNode);
    function DoCanAddItem(AParent: TTreeNode): Boolean;
    function DoCanRemoveItem(ATarget: TTreeNode): Boolean;
    procedure DoRemoveItem(ATarget: TTreeNode);
    procedure DoRefreshView;
    procedure InitTreeView;
    procedure DoGetSubItems(AItem: Ts0CollectionItem; Proc: K0CallSubItems);
    procedure Loaded; override;
  protected
    procedure TreeViewOnClick(Sender: TObject);
    function GetItemCheckState(AItem: TObject): TCheckBoxState;
    procedure PrepareStateImages;
    property StateImages: TImageList read FStateImages;
  protected
    procedure MenuAddClick(Sender: TObject);
    procedure MenuAddChildClick(Sender: TObject);
    procedure MenuPopup(Sender: TObject);
    procedure MenuPropertyClick(Sender: TObject);
    procedure MenuRefreshClick(Sender: TObject);
    procedure MenuRemoveClick(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
  protected
    procedure ModelUpdated(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshView;
    property Model: Ts0Collection read FModel write SetModel;
    property ModelUpdating: Boolean read FModelUpdating;
    property SelectedItem: Ts0CollectionItem read GetSelectedItem;
  published
    property TreeView: TTreeView read FTreeView write SetTreeView;
    property AfterShowProp : K0AccessObjEvent read FAfterShowProp  write FAfterShowProp  ;
    property BeforeShowProp: K0AccessObjEvent read FBeforeShowProp write FBeforeShowProp ;
    property OnAddItem: K0NewTreeNodeEvent read FOnAddItem write FOnAddItem;
    property OnCanAddItem: K0NewTreeNodeQueryEvent read FOnCanAddItem write FOnCanAddItem;
    property OnCanRemoveItem: K0RemoveTreeNodeQueryEvent read FOnCanRemoveItem write FOnCanRemoveItem;
    property OnRemoveItem: K0RemoveTreeNodeEvent read FOnRemoveItem write FOnRemoveItem;
    property OnRefreshView: TNotifyEvent read FOnRefreshView write FOnRefreshView;
    property OnGetItemChecked: K0GetItemCheckedEvent read FOnGetItemChecked write FOnGetItemChecked;
    property OnChangeItemChecked: K0SetItemCheckedEvent read FOnChangeItemChecked write FOnChangeItemChecked;
    property OnGetSubItems: K0GetSubItemsEvent read FOnGetSubItems write FOnGetSubItems;
  published
    property CheckedPropName: string read FCheckedPropName write SetCheckedPropName;
    property CaptionKind: K0ItemCaptionKind read FCaptionKind write SetCaptionKind default k0ickDisplayName;
    property Options: K0TreeViewCtrlOptions read FOptions write SetOptions;
  end;

implementation

uses
  Graphics,
  TypInfo,
  s0CheckBoxHelper,
  s0TypInfoWrapper,
  s0CheckDrawer,
  s0ObjectHelper,
  s0fObjEditor;

type
  T9CollectionWalker = class(Ts0CollectionVisitor)
  private
    FTreeView: TTreeView;
    FRoot: Ts0Collection;
    FCurrentNode: TTreeNode;
    FController: Ts0TreeViewController;
  protected
    procedure CallBackSubItem(ASubItems: Ts0Collection);
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  public
    procedure Execute;
    property Root: Ts0Collection read FRoot write FRoot;
    property TreeView: TTreeView read FTreeView write FTreeView;
    property Controller: Ts0TreeViewController read FController write FController;
  end;


{ T9CollectionWalker }

procedure T9CollectionWalker.CallBackSubItem(ASubItems: Ts0Collection);
begin
  if ASubItems <> nil then
    ASubItems.Accept(Self);
end;

procedure T9CollectionWalker.Execute;
begin
  if FController = nil then Exit;
  if FTreeView = nil then Exit;
  if FRoot = nil then Exit;
  FTreeView.Items.Clear;
  FController.PrepareStateImages;
  FCurrentNode := nil;
  FRoot.Accept(Self);
end;

procedure T9CollectionWalker.VisitItem(AItem: Ts0CollectionItem);
var
  curBuf: TTreeNode;
  s: string;
  obj: TObject;
begin
  curBuf := FCurrentNode;
  try
    s := '';
    obj := AItem;
    case FController.CaptionKind of
      k0ickDisplayName: s := AItem.DisplayName;
      k0ickNamePath   : s := AItem.GetNamePath;
      k0ickIdentifier : s := AItem.Identifier;
      k0ickCustom     : FController.DoAddItem(FCurrentNode, s, obj);
    end;
    FCurrentNode := FTreeView.Items.AddChildObject(FCurrentNode, s, AItem);
    if k0tvcoCheckEnabled in FController.Options then
      FCurrentNode.StateIndex := Integer(FController.GetItemCheckState(AItem)) + 1;
    //
    FController.DoGetSubItems(AItem, CallBackSubItem);
  finally
    FCurrentNode := curBuf;
  end;
end;


{ Ts0TreeViewController }

procedure Ts0TreeViewController.ModelUpdated(Sender: TObject);
begin
  RefreshView;
end;

constructor Ts0TreeViewController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCaptionKind := k0ickDisplayName;
  FCollectionUpdateListener := Ts0EventListener.Create(ModelUpdated);
  FModelUpdating := False;
  FOptions := [];
  FCheckedPropName := 'Checked';
end;

procedure Ts0TreeViewController.CreateMenus;
  function AddMenuItem(ACaption: string; AShortCut: TShortCut): TMenuItem;
  begin
    Result := TMenuItem.Create(TreeView.PopupMenu);
    Result.Caption := ACaption;
    Result.ShortCut := AShortCut;
    TreeView.PopupMenu.Items.Add(Result);
  end;
var
  m: TMenuItem;
begin
  if TreeView = nil then Exit;
  if TreeView.PopupMenu <> nil then Exit;
  TreeView.PopupMenu := TPopupMenu.Create(TreeView.Owner);
  TreeView.PopupMenu.OnPopup := MenuPopup;
  //
  FMenuAdd := AddMenuItem('&Add', ShortCut(VK_INSERT, [ssCtrl]));
  FMenuAdd.OnClick := MenuAddClick;
  //
  FMenuAddChild := AddMenuItem('Add &Child', ShortCut(VK_INSERT, [ssCtrl, ssShift]));
  FMenuAddChild.OnClick := MenuAddChildClick;
  //
  FMenuRemove := AddMenuItem('&Delete', ShortCut(VK_DELETE, [ssCtrl]));
  FMenuRemove.OnClick := MenuRemoveClick;
  //
  m := TMenuItem.Create(FTreeView.PopupMenu);
  m.Caption := '-';
  FTreeView.PopupMenu.Items.Add(m);
  //
  FMenuRefresh := AddMenuItem('&Refresh', ShortCut(VK_F5, []));
  FMenuRefresh.OnClick := MenuRefreshClick;
  //
  m := TMenuItem.Create(FTreeView.PopupMenu);
  m.Caption := '-';
  FTreeView.PopupMenu.Items.Add(m);
  //
  FMenuProperty := AddMenuItem('&Property', 0);
  FMenuProperty.OnClick := MenuPropertyClick;
end;

destructor Ts0TreeViewController.Destroy;
begin
  FreeAndNil(FCollectionUpdateListener);
  FreeAndNil(FStateImages);
  inherited Destroy;                            
end;

procedure Ts0TreeViewController.DoAddItem(AParent: TTreeNode;
  var ACaption: string; var AData: TObject);
begin
  if Assigned(FOnAddItem) then
    FOnAddItem(Self, AParent, ACaption, AData);
end;

function Ts0TreeViewController.DoCanAddItem(AParent: TTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnCanAddItem) then
    FOnCanAddItem(Self, AParent, Result);
end;

function Ts0TreeViewController.DoCanRemoveItem(ATarget: TTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnCanRemoveItem) then
    FOnCanRemoveItem(Self, ATarget, Result);
end;

procedure Ts0TreeViewController.DoRemoveItem(ATarget: TTreeNode);
begin
  if Assigned(FOnRemoveItem) then
    FOnRemoveItem(Self, ATarget);
end;

procedure Ts0TreeViewController.InitTreeView;
begin
  if csDesigning in Self.ComponentState then Exit;
  if FTreeView = nil then Exit;
  CreateMenus;
  FTreeView.RightClickSelect := True;
  FTreeView.DragMode := dmAutomatic;
  FTreeView.OnDragDrop := TreeViewDragDrop;
  FTreeView.OnDragOver := TreeViewDragOver;
  FTreeView.OnClick    := TreeViewOnClick;
end;

procedure Ts0TreeViewController.Loaded;
begin
  inherited;
  InitTreeView;
end;

procedure Ts0TreeViewController.MenuAddChildClick(Sender: TObject);
  function NewObj: TObject;
  begin
    Result := nil;
    if Model = nil then Exit;
    if FTreeView.Selected = nil then
    begin
      Result := FModel.Add;
    end
    else
    begin
      if not(TObject(FTreeView.Selected.Data) is Ts0CollectionItem) then Exit;
      if Ts0CollectionItem(FTreeView.Selected.Data).SubCollection = nil then Exit;
      Result := Ts0CollectionItem(FTreeView.Selected.Data).SubCollection.Add;
    end;
  end;
var
  s: string;
  obj: TObject;
begin
  if FTreeView = nil then Exit;
  FModelUpdating := True;
  try
    obj := NewObj;
    DoAddItem(FTreeView.Selected, s, obj);
    if s = '' then
      s := Ts0ObjectHelper.GetObjectCaption(obj);
    FTreeView.Items.AddChildObject(FTreeView.Selected, s, obj);
  finally
    FModelUpdating := False;
  end;
  if k0tvcoRefreshAfterMenuClick in FOptions then RefreshView;
end;

procedure Ts0TreeViewController.MenuAddClick(Sender: TObject);
  function NewObj: TObject;
  begin
    Result := nil;
    if Model = nil then Exit;
    if FTreeView.Selected = nil then
    begin
      Result := FModel.Add;
    end
    else
    begin
      if not(TObject(FTreeView.Selected.Data) is Ts0CollectionItem) then Exit;
      if Ts0CollectionItem(FTreeView.Selected.Data).Collection = nil then Exit;
      Result := Ts0CollectionItem(FTreeView.Selected.Data).Collection.Add;
    end;
  end;
var
  s: string;
  obj: TObject;
begin
  if FTreeView = nil then Exit;
  FModelUpdating := True;
  try
    obj := NewObj;
    DoAddItem(FTreeView.Selected, s, obj);
    if s = '' then
      s := Ts0ObjectHelper.GetObjectCaption(obj);
    FTreeView.Items.AddChildObject(FTreeView.Selected, s, obj);
  finally
    FModelUpdating := False;
  end;
  if k0tvcoRefreshAfterMenuClick in FOptions then RefreshView;
end;

procedure Ts0TreeViewController.MenuPopup(Sender: TObject);
begin
  if FTreeView = nil then Exit;
  if FMenuAddChild <> nil then
    FMenuAddChild.Enabled := DoCanAddItem(FTreeView.Selected);
  if FMenuRemove <> nil then
    FMenuRemove.Enabled := (FTreeView.Selected <> nil) and DoCanRemoveItem(FTreeView.Selected);
  if FMenuProperty <> nil then
    FMenuProperty.Enabled := (FTreeView.Selected <> nil) and (FTreeView.Selected.Data <> nil);
end;

procedure Ts0TreeViewController.MenuPropertyClick(Sender: TObject);
begin
  if FTreeView = nil then Exit;
  if FTreeView.Selected = nil then Exit;
  if FTreeView.Selected.Data = nil then Exit;
  DoBeforeShowProp(FTreeView.Selected);
  Ts0frmObjEditor.ShowEditorModal( TObject(FTreeView.Selected.Data) );
  DoAfterShowProp(FTreeView.Selected);
  if k0tvcoRefreshAfterMenuClick in FOptions then RefreshView;
end;

procedure Ts0TreeViewController.MenuRefreshClick(Sender: TObject);
begin
  RefreshView;
end;

procedure Ts0TreeViewController.MenuRemoveClick(Sender: TObject);
begin
  if FTreeView = nil then Exit;
  DoRemoveItem(FTreeView.Selected);
  if FTreeView.Selected.Data <> nil then
    TObject(FTreeView.Selected.Data).Free;
  FTreeView.Items.Delete( FTreeView.Selected );
  if k0tvcoRefreshAfterMenuClick in FOptions then RefreshView;
end;

procedure Ts0TreeViewController.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTreeView = AComponent then
    FTreeView := nil;
end;

procedure Ts0TreeViewController.RefreshView;
var
  v: T9CollectionWalker;
begin
  if FModelUpdating then Exit;
  v := T9CollectionWalker.Create;
  try
    v.Controller := Self;
    v.TreeView := TreeView;
    v.Root := Model;
    v.Execute;
    if k0tvcoRefreshWithFullExpand in FOptions then 
      FTreeView.FullExpand;
  finally
    FreeAndNil(v);
  end;
  DoRefreshView;
end;

procedure Ts0TreeViewController.SetModel(const Value: Ts0Collection);
begin
  if FModel <> nil then
    FModel.OnUpdate.Detach(FCollectionUpdateListener);
  FModel := Value;
  if FModel <> nil then
    FModel.OnUpdate.Attach(FCollectionUpdateListener);
end;

procedure Ts0TreeViewController.SetTreeView(const Value: TTreeView);
begin
  FTreeView := Value;
  if FTreeView <> nil then
    InitTreeView;
  RefreshView;
end;

procedure Ts0TreeViewController.TreeViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  n: TTreeNode;
begin
  if Sender <> TreeView then Exit;
  if Source <> TreeView then Exit;
  n := TreeView.GetNodeAt(X, Y);
  if n = nil then Exit;
  TreeView.Selected.MoveTo(n, naAddChild);
end;

procedure Ts0TreeViewController.TreeViewDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  n: TTreeNode;
begin
  if Sender <> TreeView then Exit;
  if Source <> TreeView then Exit;
  n := TreeView.GetNodeAt(X, Y);
  if n = nil then Exit;
  if TreeView.Selected <> n then
  begin
    if n.HasAsParent(TreeView.Selected) then
      Accept := False;
  end;
end;

procedure Ts0TreeViewController.DoRefreshView;
begin
  if Assigned(FOnRefreshView) then
    FOnRefreshView(Self);
end;

procedure Ts0TreeViewController.DoAfterShowProp(ATarget: TTreeNode);
begin
  if Assigned(FAfterShowProp) then
    FAfterShowProp(Self, ATarget);
end;

procedure Ts0TreeViewController.DoBeforeShowProp(ATarget: TTreeNode);
begin
  if Assigned(FBeforeShowProp) then
    FBeforeShowProp(Self, ATarget);
end;


function Ts0TreeViewController.GetSelectedItem: Ts0CollectionItem;
begin
  Result := nil;
  if TreeView.Selected = nil then Exit;
  if TObject(TreeView.Selected.Data) is Ts0CollectionItem then
    Result := Ts0CollectionItem(TreeView.Selected.Data);
end;

procedure Ts0TreeViewController.SetCaptionKind(
  const Value: K0ItemCaptionKind);
begin
  FCaptionKind := Value;
  if FModel = nil then Exit;
  if FTreeView = nil then Exit;
  RefreshView;
end;

procedure Ts0TreeViewController.SetOptions(
  const Value: K0TreeViewCtrlOptions);
begin
  FOptions := Value;
end;

procedure Ts0TreeViewController.PrepareStateImages;
var
  bmp: TBitmap;
  i: TCheckBoxState;
  x: Integer;
begin
  if FStateImages <> nil then Exit;
  FStateImages := TImageList.Create(nil);
  FStateImages.Masked := False;
  FStateImages.Height := 16;
  FStateImages.Width := 16;
  bmp := TBitMap.Create;
  try
    bmp.Height := 16;
    bmp.Width := 64;
    bmp.Canvas.pen.Color := clWindowText;
    //bmp.Canvas.Brush.Color := clLtGray;
    Ts0CheckDrawer.DrawTo(bmp.Canvas, Rect( 0 , 0, 15, 15), cbUnchecked);
    for i := Low(TCheckBoxState) to High(TCheckBoxState) do
    begin
      x := (Integer(i) + 1) * 16;
      Ts0CheckDrawer.DrawTo(bmp.Canvas, Rect( x , 0, x + 15, 15), i);
    end;
    FStateImages.Add(bmp, nil);
  finally
    FreeAndNil(bmp);
  end;
  if FTreeView = nil then Exit;
  if FTreeView.StateImages <> FStateImages then
    FTreeView.StateImages := FStateImages;
end;

function Ts0TreeViewController.GetItemCheckState(
  AItem: TObject): TCheckBoxState;
  function GetCheckStateByRTTI(AObj: TObject): TCheckBoxState;
  var
    acsr: Ts0RTTIPublishedAccessor;
    tn: string;
  begin
    Result := cbUnchecked;
    if AObj = nil then Exit;
    acsr := Ts0RTTIPublishedAccessor.Create(AItem);
    try
      if not acsr.PropertyExists(FCheckedPropName) then Exit;
      if acsr.PropTypeKind(FCheckedPropName) <> tkEnumeration then Exit;
      tn := acsr.PropTypeName(FCheckedPropName);
      if SameText(tn, 'TCheckBoxState') then
        Result := TCheckBoxState(acsr.OrdProp[FCheckedPropName])
      else
      if SameText(tn, 'Boolean') then
      begin
        Result := Ts0CheckBoxHelper.BoolToState( Boolean(acsr.OrdProp[FCheckedPropName]) );
      end;
    finally
      FreeAndNil(acsr);
    end;
  end;
begin
  Result := cbUnchecked;
  if Assigned(FOnGetItemChecked) then
    FOnGetItemChecked(Self, AItem, Result)
  else
    Result := GetCheckStateByRTTI(AItem);
end;

procedure Ts0TreeViewController.SetCheckedPropName(const Value: string);
begin
  FCheckedPropName := Value;
end;

procedure Ts0TreeViewController.TreeViewOnClick(Sender: TObject);
  procedure ChangeCheckStateByRTTI(AObj: TObject; ACurrentState: TCheckBoxState);
  var
    acsr: Ts0RTTIPublishedAccessor;
    tn: string;
  begin
    if AObj = nil then Exit;
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      if not acsr.PropertyExists(FCheckedPropName) then Exit;
      if acsr.PropTypeKind(FCheckedPropName) <> tkEnumeration then Exit;
      tn := acsr.PropTypeName(FCheckedPropName);
      if SameText(tn, 'TCheckBoxState') then
      begin
        case ACurrentState of
          cbUnchecked: acsr.OrdProp[FCheckedPropName] := Integer(cbGrayed);
          cbChecked  : acsr.OrdProp[FCheckedPropName] := Integer(cbUnchecked);
          cbGrayed   : acsr.OrdProp[FCheckedPropName] := Integer(cbChecked);
        end;
      end
      else
      if SameText(tn, 'Boolean') then
      begin
        case ACurrentState of
          cbUnchecked: acsr.OrdProp[FCheckedPropName] := Integer(True);
          cbChecked  : acsr.OrdProp[FCheckedPropName] := Integer(False);
          cbGrayed   : acsr.OrdProp[FCheckedPropName] := Integer(True);
        end;
      end;
    finally
      FreeAndNil(acsr);
    end;
  end;
var
  obj: TObject;
  cbs: TCheckBoxState;
  //
  HitInfo: THitTests;
  node: TTreeNode;
  Pos: TPoint;
begin
  if FTreeView = nil then Exit;
  GetCursorPos(Pos);
  Pos := FTreeView.ScreenToClient(Pos);
  node := FTreeView.GetNodeAt(Pos.X, Pos.Y);
  if node = nil then Exit;
  HitInfo := FTreeView.GetHitTestInfoAt(Pos.X, Pos.Y);
  if not (HtOnStateIcon in HitInfo) then Exit;

  cbs := TCheckBoxState(node.StateIndex -1);
  if node.Data = nil then Exit;
  //
  obj := TObject(node.Data);
  if Assigned(FOnChangeItemChecked) then
    FOnChangeItemChecked(Self, obj, cbs)
  else
    ChangeCheckStateByRTTI(obj, cbs);
  //
  node.StateIndex := Integer(GetItemCheckState(obj)) + 1;
end;

procedure Ts0TreeViewController.DoGetSubItems(AItem: Ts0CollectionItem;
  Proc: K0CallSubItems);
begin
  if Assigned(FOnGetSubItems) then
    FOnGetSubItems(Self, AItem, Proc)
  else
  if AItem.SubCollection <> nil then
    Proc(AItem.SubCollection)
end;

end.
