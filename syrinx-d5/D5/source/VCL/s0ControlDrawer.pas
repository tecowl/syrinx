unit s0ControlDrawer;
{
$History: s0ControlDrawer.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/21   Time: 23:20
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemFinderの仕様変更に対応
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/11/20   Time: 22:34
 * Updated in $/source/D5Integrated
 * Iteratorを使わないように修正
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0ctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/30   Time: 10:06
 * Updated in $/source/p0control
 * s0ControlProxyを作成したので、コントロールのProxyとしての機能はそちらに
 * 移行した。
 * その他変更多数
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/18   Time: 19:16
 * Created in $/Real/p0control
 * 指定したコントロールの位置情報をCanvasに描くコンポーネント
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,
  ComCtrls,
  Contnrs,
  s0GraphHelper,
  s0CanvasDrawer,
  s0Collection,
  s0ControlProxy;


type
  Ts0ControlMarkerClass = class of Ts0ControlMarker;
  Ts0ControlMarker = class(Ts0CanvasDrawer)
  protected
    procedure DrawTabControl(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy); virtual;
    procedure DrawControl(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy); virtual;
  public
    procedure Draw(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy); reintroduce; virtual;
  end;

type
  Ts0CustomControlDrawer = class(Ts0ContainerControlProxy)
  private
    FMargin: Integer;
    FMarker: Ts0ControlMarker;
    FScaleX: Single;
    FScaleY: Single;
    FFixedScale: Boolean;
    FCanvas: TCanvas;
    procedure SetMargin(const Value: Integer);
    procedure SetItems(const Value: Ts0ControlProxies);
    function GetScaleX: Single;
    function GetScaleY: Single;
    procedure SetFixedScale(const Value: Boolean);
    function GetItems: Ts0ControlProxies;
    procedure SetCanvas(const Value: TCanvas);
    procedure ResetScale;
    function GetMarkerName: K0CanvasDrawerName;
    procedure SetMarkerName(const Value: K0CanvasDrawerName);
  protected
    procedure SetTarget(const Value: TWinControl); override;
    function GetCanvasRect(AControl: TControl): TRect;
    function ConvertRect(ARect: TRect): TRect;
    procedure BuildItems; override;
    procedure ResetItemRect;
    procedure DrawItemMark(AItem: Ts0ControlProxy); virtual;
  protected
    function NewItems: Ts0ControlProxies; override;
    function NewMarker(AClass: Ts0ControlMarkerClass): Ts0ControlMarker; virtual;
    property Items: Ts0ControlProxies read GetItems write SetItems;
    function GetCanvasHeight: Integer; virtual;
    function GetCanvasWidth: Integer; virtual;
  protected
    property CanvasHeight: Integer read GetCanvasHeight;
    property CanvasWidth: Integer read GetCanvasWidth;
  protected
    { for published }
    property Margin: Integer read FMargin write SetMargin;
    property ScaleX: Single read GetScaleX;
    property ScaleY: Single read GetScaleY;
    property FixedScale: Boolean read FFixedScale write SetFixedScale default True;
    property MarkerName: K0CanvasDrawerName read GetMarkerName write SetMarkerName;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh; virtual;
    function ItemByCanvasPos(APos: TPoint): Ts0ControlProxy;
    property Canvas: TCanvas read FCanvas write SetCanvas;
  published
  end;


type
  Ts0ControlDrawer = class(Ts0CustomControlDrawer)
  private
    FDest: TImage;
    procedure SetDest(const Value: TImage);
  protected
    function GetCanvasHeight: Integer; override;
    function GetCanvasWidth: Integer; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property Items;
  published
    property Dest: TImage read FDest write SetDest;
    property MarkerName;
    property Margin;
    property Target;
    property ScaleX;
    property ScaleY;
    property FixedScale;
  end;

implementation

uses
//  c0LogManager,
  s0ExStringList,
  s0ControlHelper,
//  s0Iterator,
  s0ControlVisitor;

{ Ts0ControlMarker }

procedure Ts0ControlMarker.Draw(ACanvas: TCanvas; ARect: TRect; AItem: Ts0ControlProxy);
begin
  if AItem.Real is TCustomTabControl then
    DrawTabControl( ACanvas, ARect, AItem )
  else
    DrawControl( ACanvas, ARect, AItem );
end;

procedure Ts0ControlMarker.DrawControl(ACanvas: TCanvas; ARect: TRect;
  AItem: Ts0ControlProxy);
begin
  ACanvas.Rectangle(ARect);
end;

procedure Ts0ControlMarker.DrawTabControl(ACanvas: TCanvas; ARect: TRect;
  AItem: Ts0ControlProxy);
begin
  ACanvas.Rectangle(ARect);
end;



type
  T9ItemFinderByCanvasPos = class(Ts0CollectionItemFinder)
  private
    FPosition: TPoint;
  protected
    function Match(AItem: Ts0CollectionItem): Boolean; override;
  public
    constructor Create; override;
    procedure VisitCollection(ACollection: Ts0Collection); override;
    procedure VisitItem(AItem: Ts0CollectionItem); override;
    property Position: TPoint read FPosition write FPosition;
  end;

{ T9ItemFinderByCanvasPos }

constructor T9ItemFinderByCanvasPos.Create;
begin
  inherited;
  TimingOfSubFind := k0fsikBeforeMatch;
end;

function T9ItemFinderByCanvasPos.Match(AItem: Ts0CollectionItem): Boolean;
begin
  Result := False;
  if not(AItem is Ts0ControlProxy) then Exit;
  if Ts0ControlProxy(AItem).Real = nil then Exit;
  //if not Ts0ControlProxy(AItem).Visible then Exit;
  Result := s0GraphHelper.IsInRect(FPosition, Ts0ControlProxy(AItem).BoundsRect);
end;

procedure T9ItemFinderByCanvasPos.VisitCollection(
  ACollection: Ts0Collection);
var
  i: Integer;
begin
  if AnswerOnlyOne and (ResultList.Count > 0) then Exit;
  for i := ACollection.Count - 1 downto 0 do
    ACollection.Items[i].Accept(Self);
end;

procedure T9ItemFinderByCanvasPos.VisitItem(AItem: Ts0CollectionItem);
begin
  if not(AItem is Ts0ControlProxy) then Exit;
  if not Ts0ControlProxy(AItem).Visible then Exit;
  inherited;
end;



type
  T9ItemSizeAdjuster = class(Ts0CollectionVisitor)
  protected
    FDrawer: Ts0CustomControlDrawer;
    procedure AdjustTabRect(AImpl: Ts0TabCtrlProxyImpl; ATabCtrl: TCustomTabControl);
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  public
    procedure Execute(ADrawer: Ts0CustomControlDrawer);
  end;

{ T9ItemSizeAdjuster }

procedure T9ItemSizeAdjuster.AdjustTabRect(AImpl: Ts0TabCtrlProxyImpl;
  ATabCtrl: TCustomTabControl);
var
  r: TRect;
  i: Integer;
begin
  for i := 0 to AImpl.Count -1 do
  begin
    r := ATabCtrl.TabRect(i);
    s0GraphHelper.ParallelTranslateRect(r, ATabCtrl.Left, ATabCtrl.Top);
    AImpl.Items[i].Rect := FDrawer.ConvertRect(r);
  end;
end;

procedure T9ItemSizeAdjuster.Execute(ADrawer: Ts0CustomControlDrawer);
begin
  FDrawer := ADrawer;
  if FDrawer = nil then Exit;
  FDrawer.Items.Accept(Self);
end;

procedure T9ItemSizeAdjuster.VisitItem(AItem: Ts0CollectionItem);
var
  item: Ts0ControlProxy;
begin
  if not(AItem is Ts0ControlProxy) then Exit;
  item := Ts0ControlProxy(AItem);
  //
  item.BoundsRect :=  FDrawer.GetCanvasRect(item.Real);
  //
  if (item.Real is TCustomTabControl) and
     (item.TabCtrl is Ts0TabCtrlProxyImpl) then
  begin
    AdjustTabRect( Ts0TabCtrlProxyImpl(item.TabCtrl), TCustomTabControl(item.Real) );
  end;
  inherited;
end;





type
  T9ItemDrawer = class(Ts0CollectionVisitor)
  protected
    FDrawer: Ts0CustomControlDrawer;
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  public
    procedure Execute(ADrawer: Ts0CustomControlDrawer);
  end;


{ T9ItemDrawer }

procedure T9ItemDrawer.Execute(ADrawer: Ts0CustomControlDrawer);
begin
  FDrawer := ADrawer;
  FDrawer.Items.Accept(Self);
end;

procedure T9ItemDrawer.VisitItem(AItem: Ts0CollectionItem);
begin
  if not(AItem is Ts0ControlProxy) then Exit;
  if not Ts0ControlProxy(AItem).Visible then Exit;
  FDrawer.DrawItemMark( Ts0ControlProxy(AItem) );
  inherited VisitItem(AItem);
end;




{ Ts0CustomControlDrawer }

constructor Ts0CustomControlDrawer.Create(AOwner: TComponent);
begin
  inherited;
  FCanvas := nil;
  FFixedScale := True;
  FMarker := NewMarker(Ts0ControlMarker);
end;

destructor Ts0CustomControlDrawer.Destroy;
begin
  FreeAndNil(FMarker);
  inherited;
end;

function Ts0CustomControlDrawer.NewItems: Ts0ControlProxies;
begin
  Result := Ts0ControlProxies.Create(Self, Ts0ControlProxy);
end;

procedure Ts0CustomControlDrawer.BuildItems;
begin
  inherited BuildItems;
//  c0LogManager.Trace(Self, 'BuildItems');
  ResetItemRect;
end;

procedure Ts0CustomControlDrawer.Refresh;
var
  v: T9ItemDrawer;
begin
  if FCanvas = nil then Exit;
  FCanvas.FillRect( Rect(0, 0, CanvasWidth, CanvasHeight) );
  v := T9ItemDrawer.Create;
  try
    v.Execute(Self);
  finally
    FreeAndNil(v);
  end;
end;

procedure Ts0CustomControlDrawer.SetCanvas(const Value: TCanvas);
begin
  FCanvas := Value;
  if FCanvas <> nil then
  begin
//    c0LogManager.Trace(Self, 'SetCanvas');
    ResetItemRect;
  end;
  Refresh;
end;

procedure Ts0CustomControlDrawer.SetItems(const Value: Ts0ControlProxies);
begin
  inherited Items := Value;
  Refresh;
end;

procedure Ts0CustomControlDrawer.SetMargin(const Value: Integer);
begin
  FMargin := Value;
  Refresh;
end;

procedure Ts0CustomControlDrawer.SetTarget(const Value: TWinControl);
begin
  inherited SetTarget(Value);
//  c0LogManager.Trace(Self, 'SetTarget');
  ResetItemRect;
  Refresh;
end;

function Ts0CustomControlDrawer.GetCanvasRect(AControl: TControl): TRect;
begin
  Result := AControl.BoundsRect;
  if Target = nil then Exit;
  if AControl is TCustomForm then
    Result := ConvertRect( Rect(0, 0, AControl.Width, AControl.Height) )
  else
    Result := ConvertRect(Ts0ControlHelper.GetRelativeBoundsRect(Target, AControl));
end;

function Ts0CustomControlDrawer.ConvertRect(ARect: TRect): TRect;
begin
  Result := ARect;
  s0GraphHelper.MagnifyRect(Result, ScaleX, ScaleY);
  s0GraphHelper.ParallelTranslateRect(Result, Margin, Margin);
end;

function Ts0CustomControlDrawer.ItemByCanvasPos(
  APos: TPoint): Ts0ControlProxy;
var
  v: T9ItemFinderByCanvasPos;
begin
  Result := nil;
  v := T9ItemFinderByCanvasPos.Create;
  try
    v.Position := APos;
    v.Target := Self.Items;
    v.AnswerOnlyOne := True;
    v.Execute;
    if v.ResultList.Count < 1 then Exit;
    Result := Ts0ControlProxy( v.ResultList.First );
  finally
    FreeAndNil(v);
  end;
end;

function Ts0CustomControlDrawer.GetScaleX: Single;
begin
  Result := FScaleX;
end;

function Ts0CustomControlDrawer.GetScaleY: Single;
begin
  Result := FScaleY;
end;

procedure Ts0CustomControlDrawer.ResetItemRect;
var
  v: T9ItemSizeAdjuster;
begin
  ResetScale;
  v := T9ItemSizeAdjuster.Create;
  try
    v.Execute(Self);
  finally
    FreeAndNil(v);
  end;
end;

procedure Ts0CustomControlDrawer.DrawItemMark(AItem: Ts0ControlProxy);
begin
  if FMarker = nil then Exit;
  FMarker.Draw(FCanvas, AItem.BoundsRect, AItem);
end;

procedure Ts0CustomControlDrawer.ResetScale;
begin
  FScaleX := 0;
  FScaleY := 0;
  if FCanvas = nil then Exit;
  if Target = nil then Exit;
  if Target.Width = 0 then Exit;
  if Target.Height = 0 then Exit;
  FScaleX := (CanvasWidth - FMargin * 2) / Target.Width;
  FScaleY := (CanvasHeight - FMargin * 2) / Target.Height;
  if not FFixedScale then Exit;
  if FScaleX < FScaleY then
    FScaleY := FScaleX
  else
    FScaleX := FScaleY;
end;

procedure Ts0CustomControlDrawer.SetFixedScale(const Value: Boolean);
begin
  FFixedScale := Value;
//  c0LogManager.Trace(Self, 'SetFixedScale');
  ResetItemRect;
  Refresh;
end;

function Ts0CustomControlDrawer.GetItems: Ts0ControlProxies;
begin
  Result := Ts0ControlProxies( inherited Items );
end;



function Ts0CustomControlDrawer.GetCanvasHeight: Integer;
begin
  Result := TControlCanvas(FCanvas).Control.ClientHeight;
end;

function Ts0CustomControlDrawer.GetCanvasWidth: Integer;
begin
  Result := TControlCanvas(FCanvas).Control.ClientWidth;
end;

function Ts0CustomControlDrawer.GetMarkerName: K0CanvasDrawerName;
begin
  Result := '';
  if FMarker = nil then Exit;
  Result := FMarker.GetDrawerName;
end;

procedure Ts0CustomControlDrawer.SetMarkerName(const Value: K0CanvasDrawerName);
var
  drw: Ts0CanvasDrawerClass;
begin
  drw := Ts0CanvasDrawer.GetDrawerByName(Value, Ts0ControlMarker);
  if drw = nil then Exit;
  FreeAndNil(FMarker);
  FMarker := NewMarker( Ts0ControlMarkerClass(drw) );
end;

function Ts0CustomControlDrawer.NewMarker(
  AClass: Ts0ControlMarkerClass): Ts0ControlMarker;
begin
  Result := AClass.Create;
end;

{ Ts0ControlDrawer }

procedure Ts0ControlDrawer.SetDest(const Value: TImage);
begin
  FDest := Value;
  if FDest = nil then
     Canvas := nil
   else
     Canvas := FDest.Canvas;

//  c0LogManager.Trace(Self, 'SetDest');
  ResetItemRect;
  Refresh;
end;


procedure Ts0ControlDrawer.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FDest = AComponent then
  begin
    FDest := nil;
    FCanvas := nil;
  end;
end;

function Ts0ControlDrawer.GetCanvasHeight: Integer;
begin
  Result := 0;
  if FDest <> nil then
    Result := FDest.ClientHeight;
end;

function Ts0ControlDrawer.GetCanvasWidth: Integer;
begin
  Result := 0;
  if FDest <> nil then
    Result := FDest.ClientWidth;
end;




initialization
  Ts0CanvasDrawer.RegisterDrawer(Ts0ControlMarker);

finalization
  Ts0CanvasDrawer.UnRegisterDrawer(Ts0ControlMarker);

end.

