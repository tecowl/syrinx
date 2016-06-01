unit s0ControlProxy;
{
$History: s0ControlProxy.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/20   Time: 22:34
 * Updated in $/source/D5Integrated
 * Iteratorを使わないように修正
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/13   Time: 23:27
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0ctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, SysUtils, Classes, Controls, ComCtrls,
  Contnrs,
  s0VCLClasses,
  s0ExStringList,
  s0Observer,
  s0Collection;

type
  Ts0TabCtrlProxyImpl = class;

  Ts0TabCtrlProxyItem = class
  private
    FOwnerImpl: Ts0TabCtrlProxyImpl;
    FCaption: string;
    FRect: TRect;
    procedure SetCaption(const Value: string);
    procedure SetRect(const Value: TRect);
  public
    constructor Create(AOwnerImpl: Ts0TabCtrlProxyImpl);
    destructor Destroy; override;
    property Caption: string read FCaption write SetCaption;
    property Rect: TRect read FRect write SetRect;
  end;

  Ts0ControlProxy = class;

  Ts0TabCtrlProxyImpl = class
  private
    FTarget: TCustomTabControl;
    FHasPageByTab: Boolean;
    FActiveTabIndex: Integer;
    function GetCount: Integer;
    procedure SetHasPageByTab(const Value: Boolean);
    function GetItems(const Index: Integer): Ts0TabCtrlProxyItem;
    procedure SetActiveTabIndex(const Value: Integer);
    procedure PositionChangeTabs(NewActiveIndex: Integer);
  protected
    FTabs: TObjectList;
    FOwner: Ts0ControlProxy;
    procedure LoadFromCtrl; virtual;
    function NewItem(ACaption: string): Ts0TabCtrlProxyItem; virtual;
  public
    constructor Create(AOwner: Ts0ControlProxy; ATarget: TCustomTabControl); virtual;
    destructor Destroy; override;
    property Target: TCustomTabControl read FTarget;
    function IndexOfPos(AX, AY: Integer): Integer;
    property ActiveTabIndex: Integer read FActiveTabIndex write SetActiveTabIndex;
    property Count: Integer read GetCount;
    property HasPageByTab: Boolean read FHasPageByTab write SetHasPageByTab;
    property Items[const Index: Integer]: Ts0TabCtrlProxyItem read GetItems; default;
  end;

  Ts0ControlProxies = class;

  Ts0ControlProxy = class(Ts0VCLCollectionItem)
  private
    FReal: TControl;
    FSubItems: Ts0ControlProxies;
    FVisible: Boolean;
    FTabCtrl: Ts0TabCtrlProxyImpl;
    FBoundsRect: TRect;
    FCaption: string;
    procedure SetReal(const Value: TControl);
    procedure SetSubItems(const Value: Ts0ControlProxies);
    procedure SetVisible(const Value: Boolean);
    procedure SetBoundsRect(const Value: TRect);
    procedure SetCaption(const Value: string);
  protected
    function GetSubCollection: Ts0Collection; override;
    function GetSubCollectionClass: Ts0CollectionClass; override;
    function NewTabCtrlImpl(ACtrl: TCustomTabControl): Ts0TabCtrlProxyImpl; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    property Caption: string read FCaption write SetCaption;
    property Real: TControl read FReal write SetReal;
    property BoundsRect: TRect read FBoundsRect write SetBoundsRect;
    property SubItems: Ts0ControlProxies read FSubItems write SetSubItems;
    property Visible: Boolean read FVisible write SetVisible default True;
    property TabCtrl: Ts0TabCtrlProxyImpl read FTabCtrl;
  end;

  Ts0ControlProxies = class(Ts0VCLCollection)
  private
    function GetItems(const Index: Integer): Ts0ControlProxy;
    procedure SetItems(const Index: Integer; const Value: Ts0ControlProxy);
  protected
  public
    function Add: Ts0ControlProxy;
    function ItemByControl(AControl: TControl): Ts0ControlProxy;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property Items[const Index: Integer]: Ts0ControlProxy read GetItems write SetItems; default;
  end;

type
  Ts0ControlProxyList = class(Ts0CollectionItemList)
  private
  protected
    function GetItems(Index: Integer): Ts0ControlProxy;
    procedure SetItems(Index: Integer; AItem: Ts0ControlProxy);
  public
    function Add(AItem: Ts0ControlProxy): Integer;
    function Remove(AItem: Ts0ControlProxy): Integer;
    function IndexOf(AItem: Ts0ControlProxy): Integer;
    procedure Insert(Index: Integer; AItem: Ts0ControlProxy);
    property Items[Index: Integer]: Ts0ControlProxy read GetItems write SetItems; default;
    function First: Ts0ControlProxy;
    function Last: Ts0ControlProxy;
  end;   

type
  Ts0ContainerControlProxy = class(Ts0VCLComponent)
  private
    FItems: Ts0ControlProxies;
    FTarget: TWinControl;
    procedure SetItems(const Value: Ts0ControlProxies);
  protected
    function NewItems: Ts0ControlProxies; virtual;
    procedure SetTarget(const Value: TWinControl); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure BuildItems; virtual;
  protected
    property Items: Ts0ControlProxies read FItems write SetItems;
    property Target: TWinControl read FTarget write SetTarget;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindItem(AControl: TControl): Ts0ControlProxy;
  end;  

implementation

uses
  s0GraphHelper,
  s0ControlVisitor;

{ Ts0TabCtrlProxyItem }

constructor Ts0TabCtrlProxyItem.Create(AOwnerImpl: Ts0TabCtrlProxyImpl);
begin
  inherited Create;
  FOwnerImpl := AOwnerImpl;
end;

destructor Ts0TabCtrlProxyItem.Destroy;
begin
  if FOwnerImpl = nil then ;
  inherited;
end;

procedure Ts0TabCtrlProxyItem.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure Ts0TabCtrlProxyItem.SetRect(const Value: TRect);
begin
  FRect := Value;
end;

{ Ts0TabCtrlProxyImpl }

procedure Ts0TabCtrlProxyImpl.PositionChangeTabs(NewActiveIndex: Integer);
  function RectToStr(Value: TRect): string;
  begin
    Result := Format('%-4.4d%-4.4d', [ Value.Top, Value.Bottom ]);
  end;
  function StrToRect(Value: string): TRect;
  begin
    Result.Top := StrToIntDef( Copy(Value, 1, 4), 0);
    Result.Left := 0;
    Result.Right := 0;
    Result.Bottom := StrToIntDef( Copy(Value, 5, 4), 0);
  end;
  procedure RestoreListOfCtrlList(Dest: Ts0FreeObjStringList);
  var
    i: Integer;
    ct: Integer;
    cl: TObjectList;
  begin
    ct := -999;
    cl := nil;
    for i := 0 to Self.Count -1 do
    begin
      if ct <> Self.Items[i].Rect.Top then
      begin
        cl := TObjectList.Create(False);
        Dest.AddObject( RectToStr(Self.Items[i].Rect) , cl );
      end;
      ct := Self.Items[i].Rect.Top;
      cl.Add( Self.Items[i] );
    end;
    Dest.Sort;
  end;
var
  nt: String;
  i, j: Integer;
  lst: Ts0FreeObjStringList;
  sl: TStringList;
  r: TRect;
  itm: Ts0TabCtrlProxyItem;
begin
  lst := Ts0FreeObjStringList.Create;
  try
    RestoreListOfCtrlList(lst);
    sl := TStringList.Create;
    try
      sl.Assign(lst);
      //
      nt := RectToStr( Self.Items[NewActiveIndex].Rect );
      for i := 0 to lst.Count -1 do
        if lst.Strings[i] = nt then
        begin
          lst.Move(i, lst.Count -1);
          Break;
        end;
      //
      for i := 0 to lst.Count -1 do
      begin
        r := StrToRect( sl.Strings[i] );
        for j := 0 to TList(lst.Objects[i]).Count -1 do
        begin
          itm := Ts0TabCtrlProxyItem( TObjectList(lst.Objects[i]).Items[j] );
          r.Left := itm.Rect.Left;
          r.Right := itm.Rect.Right;
          itm.Rect := r;
        end;
      end;
    finally
      FreeAndNil(sl);
    end;
  finally
    FreeAndNil(lst);
  end;
end;

constructor Ts0TabCtrlProxyImpl.Create(AOwner: Ts0ControlProxy;
  ATarget: TCustomTabControl);
begin
  inherited Create;
  FOwner := AOwner;
  FTarget := ATarget;
  FTabs := TObjectList.Create(True);
  LoadFromCtrl;
end;

destructor Ts0TabCtrlProxyImpl.Destroy;
begin
  FreeAndNil(FTabs);
  inherited;
end;

function Ts0TabCtrlProxyImpl.GetCount: Integer;
begin
  Result := FTabs.Count;
end;

function Ts0TabCtrlProxyImpl.GetItems(
  const Index: Integer): Ts0TabCtrlProxyItem;
begin
  Result := Ts0TabCtrlProxyItem( FTabs.Items[Index] );
end;

function Ts0TabCtrlProxyImpl.IndexOfPos(AX, AY: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count -1 do
    if s0GraphHelper.IsInRect(Point(AX, AY), Self.Items[i].Rect) then
    begin
      Result := i;
      Exit;
    end;
end;

procedure Ts0TabCtrlProxyImpl.LoadFromCtrl;
var
  i: Integer;
begin
  FTabs.Clear;
  FHasPageByTab := False;

  if FTarget is TTabControl then
  begin
    for i := 0 to TTabControl(FTarget).Tabs.Count -1 do
      FTabs.Add( NewItem( TTabControl(FTarget).Tabs.Strings[i] ) );
    Self.ActiveTabIndex := TTabControl(FTarget).TabIndex;
  end
  else
  if FTarget is TPageControl then
  begin
    FHasPageByTab := True;
    for i := 0 to TPageControl(FTarget).PageCount -1 do
      FTabs.Add( NewItem( TPageControl(FTarget).Pages[i].Caption ) );
    Self.ActiveTabIndex := TPageControl(FTarget).ActivePageIndex;
  end;
end;

procedure Ts0TabCtrlProxyImpl.SetActiveTabIndex(const Value: Integer);
var
  i: Integer;
begin
  if FActiveTabIndex = Value then Exit;
  FActiveTabIndex := Value;
  PositionChangeTabs( FActiveTabIndex );
  if not HasPageByTab then Exit;
  for i := 0 to FOwner.SubItems.Count -1 do
    FOwner.SubItems.Items[i].Visible := (i = FActiveTabIndex);
end;

procedure Ts0TabCtrlProxyImpl.SetHasPageByTab(const Value: Boolean);
begin
  FHasPageByTab := Value;
end;

function Ts0TabCtrlProxyImpl.NewItem(ACaption: string): Ts0TabCtrlProxyItem;
begin
  Result := Ts0TabCtrlProxyItem.Create(Self);
  Result.Caption := ACaption;
end;

{ Ts0ControlProxy }

constructor Ts0ControlProxy.Create(ACollection: TCollection);
begin
  inherited;
  FVisible := True;
  FSubItems := Ts0ControlProxies( NewSubCollection );
end;

destructor Ts0ControlProxy.Destroy;
begin
  FreeAndNil(FTabCtrl);
  FreeAndNil(FSubItems);
  inherited;
end;

function Ts0ControlProxy.GetSubCollection: Ts0Collection;
begin
  Result := FSubItems;
end;

function Ts0ControlProxy.GetSubCollectionClass: Ts0CollectionClass;
begin
  Result := Ts0ControlProxies;
end;

function Ts0ControlProxy.NewTabCtrlImpl(ACtrl: TCustomTabControl): Ts0TabCtrlProxyImpl;
begin
  Result := Ts0TabCtrlProxyImpl.Create(Self, ACtrl);
end;

procedure Ts0ControlProxy.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if Real = AComponent then
    Real := nil;
end;

procedure Ts0ControlProxy.SetBoundsRect(const Value: TRect);
begin
  FBoundsRect := Value;
end;

procedure Ts0ControlProxy.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure Ts0ControlProxy.SetReal(const Value: TControl);
begin
  FReal := Value;
  if FReal is TCustomTabControl then
    FTabCtrl := NewTabCtrlImpl( TCustomTabControl(FReal) )
  else
    FreeAndNil(FTabCtrl);
end;

procedure Ts0ControlProxy.SetSubItems(const Value: Ts0ControlProxies);
begin
  FSubItems.Assign(Value);
end;

procedure Ts0ControlProxy.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

{ Ts0ControlProxies }

function Ts0ControlProxies.Add: Ts0ControlProxy;
begin
  Result := Ts0ControlProxy( inherited Add );
end;

function Ts0ControlProxies.GetItems(const Index: Integer): Ts0ControlProxy;
begin
  Result := Ts0ControlProxy( inherited Items[Index] );
end;

function Ts0ControlProxies.ItemByControl(
  AControl: TControl): Ts0ControlProxy;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if Result.Real = AControl then Exit;
  end;
  Result := nil;
end;

procedure Ts0ControlProxies.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if not(AComponent is TControl) then Exit;
  Self.Remove( ItemByControl( TControl(AComponent) ) );
end;

procedure Ts0ControlProxies.SetItems(const Index: Integer;
  const Value: Ts0ControlProxy);
begin
  inherited Items[Index] := Value;
end;



type
  T9ItemFinderByCtrl = class(Ts0CollectionItemFinder)
  private
    FControl: TControl;
  protected
    function Match(AItem: Ts0CollectionItem): Boolean; override;
  public
    property Control: TControl read FControl write FControl;
  end;

{ T9ItemFinderByCtrl }

function T9ItemFinderByCtrl.Match(AItem: Ts0CollectionItem): Boolean;
begin
  Result := False;
  if not(AItem is Ts0ControlProxy) then Exit;
  Result := (Ts0ControlProxy(AItem).Real = FControl);
end;



type
  {
    T9ItemBuilder 「流浪の絵（あるいはコントロール）描き」
    コントロールを渡り歩いてそれをキャンバスに描く旅人。
    というのは、世を忍ぶ仮の姿で、その正体はコントロールごとにTs0RectPartItemの
    インスタンスを生成するBuilderである。
  }
  T9ItemBuilder = class(Ts0ControlVisitor)
  private
    FCurrentCollection: Ts0ControlProxies;
    FTarget: TWinControl;
  protected
    function NewItem(AControl: TControl): Ts0ControlProxy;
    procedure VisitControl(AControl: TControl); override;
    procedure VisitWinControl(AControl: TWinControl); override;
  public
    procedure Execute(AContainer: Ts0ContainerControlProxy; ATarget: TWinControl);
  end;


{ T9ItemBuilder }

procedure T9ItemBuilder.Execute(AContainer: Ts0ContainerControlProxy; ATarget: TWinControl);
begin
  if ATarget = nil then Exit;
  if AContainer = nil then Exit;
  FTarget := ATarget;
  FCurrentCollection := AContainer.Items;
  VisitWinControl(FTarget);
end;

function T9ItemBuilder.NewItem(
  AControl: TControl): Ts0ControlProxy;
begin
  Result := nil;
  if AControl = nil then Exit;
  Result := FCurrentCollection.Add;
  Result.Real := AControl;
  Result.Caption := AControl.Name;
  Result.Visible := AControl.Visible;
end;

procedure T9ItemBuilder.VisitControl(AControl: TControl);
begin
  NewItem(AControl);
end;

procedure T9ItemBuilder.VisitWinControl(AControl: TWinControl);
var
  item: Ts0ControlProxy;
  buf: Ts0ControlProxies;
begin
  item := NewItem(AControl);
  if item = nil then Exit;
  buf := FCurrentCollection;
  FCurrentCollection := item.SubItems;
  try
    VisitChildren(AControl);
  finally
    FCurrentCollection := buf;
  end;
end;




{ Ts0ControlProxyList }

function Ts0ControlProxyList.Add(AItem: Ts0ControlProxy): Integer;
begin
  Result := inherited Add(AItem);
end;

function Ts0ControlProxyList.First: Ts0ControlProxy;
begin
  Result := Ts0ControlProxy( inherited First );
end;

function Ts0ControlProxyList.GetItems(Index: Integer): Ts0ControlProxy;
begin
  Result := Ts0ControlProxy( inherited Items[Index] );
end;

function Ts0ControlProxyList.IndexOf(AItem: Ts0ControlProxy): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure Ts0ControlProxyList.Insert(Index: Integer;
  AItem: Ts0ControlProxy);
begin
  inherited Insert(Index, AItem);
end;

function Ts0ControlProxyList.Last: Ts0ControlProxy;
begin
  Result := Ts0ControlProxy( inherited Last );
end;

function Ts0ControlProxyList.Remove(AItem: Ts0ControlProxy): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure Ts0ControlProxyList.SetItems(Index: Integer; AItem: Ts0ControlProxy);
begin
  inherited Items[Index] := AItem;
end;



{ Ts0ContainerControlProxy }

procedure Ts0ContainerControlProxy.BuildItems;
var
  v: T9ItemBuilder;
begin
  Items.Clear;
  v := T9ItemBuilder.Create;
  try
    v.Execute(Self, FTarget);
  finally
    FreeAndNil(v);
  end;
end;

constructor Ts0ContainerControlProxy.Create(AOwner: TComponent);
begin
  inherited;
  FItems := NewItems;
end;

destructor Ts0ContainerControlProxy.Destroy;
begin
  FreeAndNil(FItems);
  inherited;         
end;

procedure Ts0ContainerControlProxy.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTarget = AComponent then FTarget := nil;
end;

function Ts0ContainerControlProxy.FindItem(
  AControl: TControl): Ts0ControlProxy;
var
  v: T9ItemFinderByCtrl;
begin
  Result := nil;
  v := T9ItemFinderByCtrl.Create;
  try
    v.Control := AControl;
    v.Target := FItems;
    v.AnswerOnlyOne := True;
    v.Execute;
    if v.ResultList.Count < 1 then Exit;
    Result := Ts0ControlProxy( v.ResultList.First );
  finally
    FreeAndNil(v);
  end;
end;


function Ts0ContainerControlProxy.NewItems: Ts0ControlProxies;
begin
  Result := Ts0ControlProxies.Create(Self, Ts0ControlProxy);
end;

procedure Ts0ContainerControlProxy.SetItems(const Value: Ts0ControlProxies);
begin
  FItems.Assign( Value );
end;

procedure Ts0ContainerControlProxy.SetTarget(const Value: TWinControl);
begin
  FTarget := Value;
  BuildItems;
end;

end.
