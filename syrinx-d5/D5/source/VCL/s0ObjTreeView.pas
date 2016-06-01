unit s0ObjTreeView;

interface

uses
  SysUtils, Classes, Controls, ComCtrls, ExtCtrls,
  Imglist,
  Menus,
  s0CustomComplexCtrl,
  s0BoundsLayout,
  s0ObjCtrlBuilder,
  s0ObjTreeMapper,
  s0ObjTreeMapMenu;

type
  Ts0OTVTree = class(Ts0CCCItem)
  private
    function GetAutoExpand: Boolean;
    function GetChangeDelay: Integer;
    function GetHideSelection: Boolean;
    function GetHotTrack: Boolean;
    function GetImages: TCustomImageList;
    function GetIndent: Integer;
    function GetRightClickSelect: Boolean;
    function GetRowSelect: Boolean;
    function GetShowButtons: Boolean;
    function GetShowHint: Boolean;
    function GetShowLines: Boolean;
    function GetShowRoot: Boolean;
    function GetStateImages: TCustomImageList;
    function GetToolTips: Boolean;
    procedure SetAutoExpand(const Value: Boolean);
    procedure SetChangeDelay(const Value: Integer);
    procedure SetHideSelection(const Value: Boolean);
    procedure SetHotTrack(const Value: Boolean);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetIndent(const Value: Integer);
    procedure SetRightClickSelect(const Value: Boolean);
    procedure SetRowSelect(const Value: Boolean);
    procedure SetShowButtons(const Value: Boolean);
    procedure SetShowHint(const Value: Boolean);
    procedure SetShowLines(const Value: Boolean);
    procedure SetShowRoot(const Value: Boolean);
    procedure SetStateImages(const Value: TCustomImageList);
    procedure SetToolTips(const Value: Boolean);
    function GetMapClasses: K0ObjTreeMapClassKindSet;
    function GetMapTargetAsRoot: Boolean;
    function GetVisibleClasses: K0ObjTreeMapClassKindSet;
    procedure SetMapClasses(const Value: K0ObjTreeMapClassKindSet);
    procedure SetMapTargetAsRoot(const Value: Boolean);
    procedure SetVisibleClasses(const Value: K0ObjTreeMapClassKindSet);
  published
    property BorderStyle;
    property Color;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentFont;
    property ReadOnly;
    property TabOrder;
    property TabStop default True;
    property Visible;
  published
    property AutoExpand: Boolean read GetAutoExpand write SetAutoExpand;
    property ChangeDelay: Integer read GetChangeDelay write SetChangeDelay;
    property HideSelection: Boolean read GetHideSelection write SetHideSelection;
    property HotTrack: Boolean read GetHotTrack write SetHotTrack;
    property Images: TCustomImageList read GetImages write SetImages;
    property Indent: Integer read GetIndent write SetIndent;
    property RightClickSelect: Boolean read GetRightClickSelect write SetRightClickSelect;
    property RowSelect: Boolean read GetRowSelect write SetRowSelect;
    property ShowButtons: Boolean read GetShowButtons write SetShowButtons;
    property ShowHint: Boolean read GetShowHint write SetShowHint;
    property ShowLines: Boolean read GetShowLines write SetShowLines;
    property ShowRoot: Boolean read GetShowRoot write SetShowRoot;
    property StateImages: TCustomImageList read GetStateImages write SetStateImages;
    property ToolTips: Boolean read GetToolTips write SetToolTips;
  published
    property MapTargetAsRoot: Boolean read GetMapTargetAsRoot write SetMapTargetAsRoot default True;
    property MapClasses: K0ObjTreeMapClassKindSet read GetMapClasses write SetMapClasses default [k0otmckCollection, k0otmckPersistent, k0otmckObjectList, k0otmckObject];
    property VisibleClasses: K0ObjTreeMapClassKindSet read GetVisibleClasses write SetVisibleClasses default [k0otmckCollection, k0otmckPersistent, k0otmckObject];
  end;

type
  Ks0ObjTreeViewOption = (ks0otvoRefreshAfterClick);
  Ks0ObjTreeViewOptions = set of Ks0ObjTreeViewOption;

type
  Ts0CustomObjTreeView = class(Ts0CustomComplexCtrl)
  private
    FTreeMapper: Ts0ObjTreeMapper;
    FTreeView: TTreeView;
    FFieldPane: TWinControl;
    FSplitter: TSplitter;
    FObjCtrlBride: Ts0ObjCtrlBridge;
    FTreeMenusCtrl: Ts0ObjTreeMapMenu;
    FLayouts: Ts0LayoutSet;
    FTreeViewProps: Ts0OTVTree;
    FOptions: Ks0ObjTreeViewOptions;
    function GetTarget: TObject;
    procedure SetTarget(const Value: TObject);
    function GetTreeViewWidth: Integer;
    procedure SetTreeViewWidth(const Value: Integer);
    procedure SetLayouts(const Value: Ts0LayoutSet);
    procedure SetTreeViewProps(const Value: Ts0OTVTree);
    function GetSelected: TObject;
    procedure SetSelected(Value: TObject);
    procedure SetOptions(const Value: Ks0ObjTreeViewOptions);
  private
    { Ts0ObjTreeMapMenu }
    function GetAfterMenuItemClick: K0MenuItemClickNotifyEvent;
    function GetBeforeMenuItemClick: K0MenuItemClickQueryEvent;
    procedure SetAfterMenuItemClick(
      const Value: K0MenuItemClickNotifyEvent);
    procedure SetBeforeMenuItemClick(
      const Value: K0MenuItemClickQueryEvent);
  protected
    procedure CreateCtrls; override;
    function NewObjCtrlBride: Ts0ObjCtrlBridge; virtual;
    function NewTreeMapper: Ts0ObjTreeMapper; virtual;
    function NewTreeMenusCtrl: Ts0ObjTreeMapMenu; virtual;
    procedure LayoutCtrls;
  protected
    { events }
    procedure ChaneSelectedOnTree(Node: TTreeNode); virtual;
    procedure TreeViewMenuNeedRefresh(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh;
    property Selected: TObject read GetSelected write SetSelected;
    property Target: TObject read GetTarget write SetTarget;
  protected
    property FieldPane: TWinControl read FFieldPane;
    property TreeMenusCtrl: Ts0ObjTreeMapMenu read FTreeMenusCtrl;
    property ObjCtrlBride: Ts0ObjCtrlBridge read FObjCtrlBride;
    property Splitter: TSplitter read FSplitter;
    property TreeMapper: Ts0ObjTreeMapper read FTreeMapper;
    property TreeView: TTreeView read FTreeView;
  protected
    property TreeViewWidth: Integer read GetTreeViewWidth write SetTreeViewWidth default 121;
    property TreeViewProps: Ts0OTVTree read FTreeViewProps write SetTreeViewProps;
    property Layouts: Ts0LayoutSet read FLayouts write SetLayouts;
    property Options: Ks0ObjTreeViewOptions read FOptions write SetOptions default [ks0otvoRefreshAfterClick];
  protected
    { Ts0ObjTreeMapMenu }
    property BeforeMenuItemClick: K0MenuItemClickQueryEvent read GetBeforeMenuItemClick write SetBeforeMenuItemClick;
    property AfterMenuItemClick: K0MenuItemClickNotifyEvent read GetAfterMenuItemClick write SetAfterMenuItemClick;
  published
    property Width default 200;
    property Height default 150;
  end;

type
  Ts0ObjTreeView = class(Ts0CustomObjTreeView)
  public
    property FieldPane;
    property TreeMenusCtrl;
    property ObjCtrlBride;
    property Splitter;
    property TreeMapper;
    property TreeView;
  published
    property TreeViewWidth;
    property TreeViewProps;
    property Layouts;
  published
    property Align;
    property Color;
    property Font;
    property TabOrder;
    property TabStop;
  published
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnChange;
    property OnPartEnter;
    property OnPartExit;
  published
    property BeforeMenuItemClick;
    property AfterMenuItemClick;
  end;

procedure Register;

implementation

uses
  Forms,
  s0UnifiedObjCtrl,
  s0VCLComCtrlsDistiller;

procedure Register;
begin
  RegisterComponents('P Form', [Ts0ObjTreeView]);
end;

type
  Ts9TreeView = class(TTreeView)
  private
    FOwnerView: Ts0CustomObjTreeView;
  protected
    procedure Change(Node: TTreeNode); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

type
  Ts9TreeMenu = class(Ts0ObjTreeMapMenu)
  private
    FOwnerView: Ts0CustomObjTreeView;
  protected
    function ExecAdd(AObj: TObject): TObject; override;
    procedure ExecClear(AObj: TObject); override;
    procedure ExecRemove(AObj: TObject); override;
  protected
  end;

{ Ts9TreeView }

procedure Ts9TreeView.Change(Node: TTreeNode);
begin
  FOwnerView.ChaneSelectedOnTree(Node);
  inherited;
end;

constructor Ts9TreeView.Create(AOwner: TComponent);
begin
  inherited;
  ChangeDelay := 50;
  ReadOnly := True;
  RightClickSelect := True;
end;

{ Ts9TreeMenu }

function Ts9TreeMenu.ExecAdd(AObj: TObject): TObject;
  function FindNode(AObj: TObject): TTreeNode;
  var
    i: Integer;
  begin
    for i := 0 to TreeView.Items.Count -1 do
    begin
      Result := TreeView.Items[i];
      if TObject(Result.Data) = AObj then Exit;
    end;
    Result := nil;
  end;
var
  node: TTreeNode;
begin
  Result := inherited ExecAdd(AObj);
  if Result = nil then Exit;
  ExecRefresh;
  node := FindNode(Result);
  if node = nil then
    TreeView.FullExpand
  else
    TreeView.Selected := node;
end;

procedure Ts9TreeMenu.ExecClear(AObj: TObject);
begin
  inherited ExecClear(AObj);
  ExecRefresh;
end;

procedure Ts9TreeMenu.ExecRemove(AObj: TObject);
begin
  inherited ExecRemove(AObj);
  ExecRefresh;
end;

{ Ts0OTVTree }

function Ts0OTVTree.GetAutoExpand: Boolean;
begin
  Result := TTreeView(Control).AutoExpand;
end;

function Ts0OTVTree.GetChangeDelay: Integer;
begin
  Result := TTreeView(Control).ChangeDelay;
end;

function Ts0OTVTree.GetHideSelection: Boolean;
begin
  Result := TTreeView(Control).HideSelection;
end;

function Ts0OTVTree.GetHotTrack: Boolean;
begin
  Result := TTreeView(Control).HotTrack;
end;

function Ts0OTVTree.GetImages: TCustomImageList;
begin
  Result := TTreeView(Control).Images;
end;

function Ts0OTVTree.GetIndent: Integer;
begin
  Result := TTreeView(Control).Indent;
end;

function Ts0OTVTree.GetMapClasses: K0ObjTreeMapClassKindSet;
begin
  Result := Ts0CustomObjTreeView(OwnerComponent).TreeMapper.MapClasses;
end;

function Ts0OTVTree.GetMapTargetAsRoot: Boolean;
begin
  Result := Ts0CustomObjTreeView(OwnerComponent).TreeMapper.MapTargetAsRoot;
end;

function Ts0OTVTree.GetRightClickSelect: Boolean;
begin
  Result := TTreeView(Control).RightClickSelect;
end;

function Ts0OTVTree.GetRowSelect: Boolean;
begin
  Result := TTreeView(Control).RowSelect;
end;

function Ts0OTVTree.GetShowButtons: Boolean;
begin
  Result := TTreeView(Control).ShowButtons;
end;

function Ts0OTVTree.GetShowHint: Boolean;
begin
  Result := TTreeView(Control).ShowHint;
end;

function Ts0OTVTree.GetShowLines: Boolean;
begin
  Result := TTreeView(Control).ShowLines;
end;

function Ts0OTVTree.GetShowRoot: Boolean;
begin
  Result := TTreeView(Control).ShowRoot;
end;

function Ts0OTVTree.GetStateImages: TCustomImageList;
begin
  Result := TTreeView(Control).StateImages;
end;

function Ts0OTVTree.GetToolTips: Boolean;
begin
  Result := TTreeView(Control).ToolTips;
end;

function Ts0OTVTree.GetVisibleClasses: K0ObjTreeMapClassKindSet;
begin
  Result := Ts0CustomObjTreeView(OwnerComponent).TreeMapper.VisibleClasses;
end;

procedure Ts0OTVTree.SetAutoExpand(const Value: Boolean);
begin
  TTreeView(Control).AutoExpand := Value;
end;

procedure Ts0OTVTree.SetChangeDelay(const Value: Integer);
begin
  TTreeView(Control).ChangeDelay := Value;
end;

procedure Ts0OTVTree.SetHideSelection(const Value: Boolean);
begin
  TTreeView(Control).HideSelection := Value;
end;

procedure Ts0OTVTree.SetHotTrack(const Value: Boolean);
begin
  TTreeView(Control).HotTrack := Value;
end;

procedure Ts0OTVTree.SetImages(const Value: TCustomImageList);
begin
  TTreeView(Control).Images := Value;
end;

procedure Ts0OTVTree.SetIndent(const Value: Integer);
begin
  TTreeView(Control).Indent := Value;
end;

procedure Ts0OTVTree.SetMapClasses(const Value: K0ObjTreeMapClassKindSet);
begin
  Ts0CustomObjTreeView(OwnerComponent).TreeMapper.MapClasses := Value;
end;

procedure Ts0OTVTree.SetMapTargetAsRoot(const Value: Boolean);
begin
  Ts0CustomObjTreeView(OwnerComponent).TreeMapper.MapTargetAsRoot := Value;
end;

procedure Ts0OTVTree.SetRightClickSelect(const Value: Boolean);
begin
  TTreeView(Control).RightClickSelect := Value;
end;

procedure Ts0OTVTree.SetRowSelect(const Value: Boolean);
begin
  TTreeView(Control).RowSelect := Value;
end;

procedure Ts0OTVTree.SetShowButtons(const Value: Boolean);
begin
  TTreeView(Control).ShowButtons := Value;
end;

procedure Ts0OTVTree.SetShowHint(const Value: Boolean);
begin
  TTreeView(Control).ShowHint := Value;
end;

procedure Ts0OTVTree.SetShowLines(const Value: Boolean);
begin
  TTreeView(Control).ShowLines := Value;
end;

procedure Ts0OTVTree.SetShowRoot(const Value: Boolean);
begin
  TTreeView(Control).ShowRoot := Value;
end;

procedure Ts0OTVTree.SetStateImages(const Value: TCustomImageList);
begin
  TTreeView(Control).StateImages := Value;
end;

procedure Ts0OTVTree.SetToolTips(const Value: Boolean);
begin
  TTreeView(Control).ToolTips := Value;
end;

procedure Ts0OTVTree.SetVisibleClasses(
  const Value: K0ObjTreeMapClassKindSet);
begin
  Ts0CustomObjTreeView(OwnerComponent).TreeMapper.VisibleClasses := Value;
end;

{ Ts0CustomObjTreeView }

procedure Ts0CustomObjTreeView.ChaneSelectedOnTree(Node: TTreeNode);
begin
  FObjCtrlBride.ClearCtrls;
  FObjCtrlBride.ProtoTypes.Clear;
  FObjCtrlBride.Target := Selected;
  FObjCtrlBride.BuildCtrls;
  FObjCtrlBride.LoadFromTarget;
end;

constructor Ts0CustomObjTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [ks0otvoRefreshAfterClick];
  Width := 200;
  Height := 150;
  // components
  FTreeMapper := NewTreeMapper;
  FTreeMapper.TreeView := FTreeView;
  FObjCtrlBride := NewObjCtrlBride;
  FObjCtrlBride.Builder.CtrlParent := FFieldPane;
  FObjCtrlBride.Builder.CtrlOwner := Self;
  FTreeMenusCtrl := NewTreeMenusCtrl;
  FTreeMenusCtrl.TreeView := FTreeView;
  FTreeMenusCtrl.OnNeedRefresh := TreeViewMenuNeedRefresh;
end;

procedure Ts0CustomObjTreeView.CreateCtrls;
begin
  FTreeView := Ts9TreeView.Create(Self);
  Ts9TreeView(FTreeView).FOwnerView := Self;
  FTreeView.Parent := Self;
  FTreeView.Align := alLeft;
  FTreeViewProps := Ts0OTVTree.Create(Self, CCCItems, FTreeView);
  //
  FSplitter := TSplitter.Create(Self);
  FSplitter.Parent := Self;
  FSplitter.Align := alLeft;
  FSplitter.Left := FTreeView.Width + 50;
  //
  FFieldPane := TScrollBox.Create(Self);
  FFieldPane.Parent := Self;
  FFieldPane.Align := alClient;
end;

destructor Ts0CustomObjTreeView.Destroy;
begin
  // components
//  FreeAndNil(FTreeMenusCtrl);
//  FreeAndNil(FObjCtrlBride);
//  FreeAndNil(FTreeMapper);
  inherited;
end;

function Ts0CustomObjTreeView.GetAfterMenuItemClick: K0MenuItemClickNotifyEvent;
begin
  Result := FTreeMenusCtrl.AfterMenuItemClick;
end;

function Ts0CustomObjTreeView.GetBeforeMenuItemClick: K0MenuItemClickQueryEvent;
begin
  Result := FTreeMenusCtrl.BeforeMenuItemClick;
end;

function Ts0CustomObjTreeView.GetSelected: TObject;
begin
  Result := FTreeMapper.Selected;
end;

function Ts0CustomObjTreeView.GetTarget: TObject;
begin
  Result := FTreeMapper.Target;
end;

function Ts0CustomObjTreeView.GetTreeViewWidth: Integer;
begin
  Result := FTreeView.Width;
end;

procedure Ts0CustomObjTreeView.LayoutCtrls;
begin
end;

function Ts0CustomObjTreeView.NewObjCtrlBride: Ts0ObjCtrlBridge;
begin
  Result := Ts0UnifiedObjCtrl.Create(Self);
end;

function Ts0CustomObjTreeView.NewTreeMapper: Ts0ObjTreeMapper;
begin
  Result := Ts0ObjTreeMapper.Create(Self);
end;

function Ts0CustomObjTreeView.NewTreeMenusCtrl: Ts0ObjTreeMapMenu;
begin
  Result := Ts9TreeMenu.Create(Self);
  Ts9TreeMenu(Result).FOwnerView := Self;
end;

procedure Ts0CustomObjTreeView.Refresh;
begin
  FTreeMapper.Refresh;
  FObjCtrlBride.LoadFromTarget;
end;

procedure Ts0CustomObjTreeView.SetAfterMenuItemClick(
  const Value: K0MenuItemClickNotifyEvent);
begin
  FTreeMenusCtrl.AfterMenuItemClick := Value;
end;

procedure Ts0CustomObjTreeView.SetBeforeMenuItemClick(
  const Value: K0MenuItemClickQueryEvent);
begin
  FTreeMenusCtrl.BeforeMenuItemClick := Value;
end;

procedure Ts0CustomObjTreeView.SetLayouts(const Value: Ts0LayoutSet);
begin
  FLayouts := Value;
end;

procedure Ts0CustomObjTreeView.SetOptions(
  const Value: Ks0ObjTreeViewOptions);
begin
  FOptions := Value;
end;

procedure Ts0CustomObjTreeView.SetSelected(Value: TObject);
begin
  FTreeMapper.Selected := Value;
end;

procedure Ts0CustomObjTreeView.SetTarget(const Value: TObject);
begin
  FTreeMapper.Target := Value;
end;

procedure Ts0CustomObjTreeView.SetTreeViewProps(const Value: Ts0OTVTree);
begin
  FTreeViewProps.Assign(Value);
end;

procedure Ts0CustomObjTreeView.SetTreeViewWidth(const Value: Integer);
begin
  FTreeView.Width := Value;
end;

procedure Ts0CustomObjTreeView.TreeViewMenuNeedRefresh(Sender: TObject);
begin
  FTreeMapper.Refresh;
end;

end.
 