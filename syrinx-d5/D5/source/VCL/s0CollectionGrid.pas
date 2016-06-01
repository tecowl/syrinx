{-----------------------------------------------------------------------------
 Unit Name: s0CollectionGrid
 Author:    akima
 Purpose:
 TestCase: tc_s0CollectionGrid
 $History: s0CollectionGrid.pas $
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/02/14   Time: 21:50
 * Updated in $/source/D5Integrated
 * MappingClassNameを削除
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/02/06   Time: 4:40
 * Updated in $/source/D5Integrated
 * NewMappingObjメソッドで、0より小さいIndexに対しては0に設定することにし
 * た。
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/02/06   Time: 1:00
 * Updated in $/source/D5Integrated
 * Ts0CollectionGridとTs0CustomCollectionGridに分けた
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/02/05   Time: 4:33
 * Updated in $/source/D5Integrated
 * MVCにした
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/12/10   Time: 10:45
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/12/06   Time: 20:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/11/25   Time: 5:32
 * Updated in $/source/D5Integrated
 * 要素（TargetのItem）の追加、削除に関する処理を見直した
-----------------------------------------------------------------------------}

unit s0CollectionGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Grids, {s0BindGrid, s0BaseGrid, s0DecoGrid, s0CtrlGrid, }
  s0ObjectGrid,
  s0Collection,
  s0TypInfoWrapper;

type
  Ts0CollectionGridController = class(Ts0ObjectGridController)
  private
    FTarget: TCollection;
    procedure SetTarget(const Value: TCollection);
  protected
    function CanMapping: Boolean; override;
    function MappingItemExists(AObj: TObject): Boolean; override;
    function GetMappingClass: TClass; override;
    function GetMappingCount: Integer; override;
    function GetMappingItem(AIndex: Integer): TObject; override;
    function NewMappingObj(ARow: Integer): TObject; override;
    procedure RemoveObj(ARow: Integer); override;
  public
    property Target: TCollection read FTarget write SetTarget;
  end;


type
  Ts0CustomCollectionGrid = class(Ts0CustomObjectGrid)
  private
    FTarget: TCollection;
    FTargetOwner: TComponent;
    FTargetPropName: string;
    procedure SetTarget(const Value: TCollection);
    procedure SetTargetImpl;
    procedure SetTargetOwner(const Value: TComponent);
    procedure SetTargetPropName(const Value: string);
    function GetTargetOwner: TComponent;
    function GetTargetPropName: string;
  protected
    function NewController: Ts0ObjectGridController; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function ItemByRow(ARow: Integer): TCollectionItem;
    property Target: TCollection read FTarget write SetTarget;
  protected
    property TargetOwner: TComponent read GetTargetOwner write SetTargetOwner;
    property TargetPropName: string read GetTargetPropName write SetTargetPropName;
  end;

type
  Ts0CollectionGrid = class(Ts0CustomCollectionGrid)
  published
    property TargetOwner;
    property TargetPropName;
  published
    property DoubleBuffered;
  published
    property DefaultColWidth;
    property DefaultRowHeight;
    //property DefaultDrawing;
    property FixedColor;
    property FixedCols;
    property FixedRows;
    property ColCount; //必ずFixedColsより後に宣言
    property RowCount; //必ずFixedRowsより後に宣言
    property GridLineWidth;
    property Options;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property VisibleColCount;
    property VisibleRowCount;
    property OnClick;
    property OnColumnMoved;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawCell;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetEditMask;
    property OnGetEditText;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnRowMoved;
    property OnSelectCell;
    property OnSetEditText;
    property OnStartDock;
    property OnStartDrag;
    property OnTopLeftChanged;
  published
    property BindSeals;
    property MultiLine;
    property ReadOnlySeals;
  published
    property CtrlDecos;
  published
    property AlignmentDecos;
    property ColorDecos;
  published
    property AutoUpdateTarget   ;
    property CtrlOfTypeClassName;
    property CtrlOfType         ;
    property MappingColumnBase  ;
    property Columns            ;
  end;

implementation

{ Ts0CollectionGridController }

function Ts0CollectionGridController.CanMapping: Boolean;
begin
  Result := FTarget <> nil;
end;

function Ts0CollectionGridController.GetMappingClass: TClass;
begin
  Result := nil;
  if FTarget = nil then Exit;
  Result := FTarget.ItemClass;
end;

function Ts0CollectionGridController.GetMappingCount: Integer;
begin
  Result := 0;
  if FTarget = nil then Exit;
  Result := FTarget.Count;
end;

function Ts0CollectionGridController.GetMappingItem(
  AIndex: Integer): TObject;
begin
  Result := nil;
  if FTarget = nil then Exit;
  if AIndex < 0 then Exit;
  if AIndex > FTarget.Count -1 then Exit;
  Result := FTarget.Items[AIndex];
end;

function Ts0CollectionGridController.MappingItemExists(
  AObj: TObject): Boolean;
var
  i: Integer;
begin
  Result := False;
  if FTarget = nil then Exit;
  Result := True;
  for i := 0 to FTarget.Count - 1 do
    if FTarget.Items[i] = AObj then
      Exit;
  Result := False;
end;

function Ts0CollectionGridController.NewMappingObj(ARow: Integer): TObject;
var
  idx: Integer;
begin
  Result := nil;
  if FTarget = nil then Exit;
  Result := FTarget.Add;
  idx := RowToIndex(ARow);
  if idx < 0 then idx := 0;
  if TCollectionItem(Result).Index <> idx then
    TCollectionItem(Result).Index := idx;
end;

procedure Ts0CollectionGridController.RemoveObj(ARow: Integer);
var
  idx: Integer;
begin
  idx := RowToIndex(ARow);
  if idx < 0 then Exit;
  if idx > Target.Count -1 then Exit;
  Target.Delete( idx );
end;

procedure Ts0CollectionGridController.SetTarget(const Value: TCollection);
begin
  if FTarget = Value then
  begin
    FOwnerGrid.InitColumns;
    FOwnerGrid.LoadFromTarget;
  end
  else
  begin
    RegisterClass(TPersistentClass(Value.ClassType));
    RegisterClass(Value.ItemClass);

    if FTarget is Ts0Collection then
    begin
      Ts0Collection(FTarget).OnUpdate.Detach(FTargetListener);
//      if FTargetOwner <> nil then
//        FTargetOwner.RemoveFreeNotification(Self);
    end;
    FTarget := Value;

    FOwnerGrid.InitColumns;
    FOwnerGrid.LoadFromTarget;

    if FTarget is Ts0Collection then
    begin
      Ts0Collection(FTarget).OnUpdate.Attach(FTargetListener);
{
      FTargetOwner := Ts0Collection(FTarget).OwnerComponent;
      FTargetPropName := Ts0Collection(FTarget).PropName;
      if FTargetOwner <> nil then
        if FTargetOwner.Owner <> Self.Owner then
          FTargetOwner.FreeNotification(Self);
}
    end;
  end;
end;

{ Ts0CustomCollectionGrid }

function Ts0CustomCollectionGrid.GetTargetOwner: TComponent;
begin
  Result := nil;
  if Target = nil then
    Result := FTargetOwner
  else
  if Target is Ts0Collection then
    Result := Ts0Collection(Target).OwnerComponent
end;

function Ts0CustomCollectionGrid.GetTargetPropName: string;
begin
  Result := '';
  if Target = nil then
    Result := FTargetPropName
  else
  if Target is Ts0Collection then
    Result := Ts0Collection(Target).PropName;
end;

function Ts0CustomCollectionGrid.ItemByRow(ARow: Integer): TCollectionItem;
begin
  Result := TCollectionItem(inherited Controller.GetMappingItemByRow(ARow));
end;

function Ts0CustomCollectionGrid.NewController: Ts0ObjectGridController;
begin
  Result := Ts0CollectionGridController.Create(Self);
end;

procedure Ts0CustomCollectionGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTargetOwner = AComponent then
  begin
    FTargetOwner := nil;
    FTargetPropName := '';
    FTarget := nil;
    InitColumns;
  end;
end;

procedure Ts0CustomCollectionGrid.SetTarget(const Value: TCollection);
var
  ctrl: Ts0CollectionGridController;
begin
  Assert(Controller is Ts0CollectionGridController);
  ctrl := Ts0CollectionGridController(Controller);
  if ctrl.Target <> Value then 
    ctrl.Target := Value;
end;

procedure Ts0CustomCollectionGrid.SetTargetImpl;
  function GetTargetByRTTI: TCollection;
  var
    obj: TObject;
    w: Ts0RTTIPublishedAccessor;
  begin
    Result := nil;
    if FTargetOwner = nil then Exit;
    if FTargetPropName = '' then Exit;
    w := Ts0RTTIPublishedAccessor.Create(FTargetOwner);
    try
      if not w.PropertyExists(FTargetPropName) then Exit;
      if not w.ObjectPropClass[FTargetPropName].InheritsFrom(TCollection) then Exit;
      obj := w.ObjectProp[FTargetPropName];
      if not(obj is TCollection) then Exit;
      Result := TCollection( obj );
    finally
      FreeAndNil(w);
    end;
  end;
begin
  Target := GetTargetByRTTI;
end;

procedure Ts0CustomCollectionGrid.SetTargetOwner(const Value: TComponent);
begin
  FTargetOwner := Value;
  SetTargetImpl;
end;

procedure Ts0CustomCollectionGrid.SetTargetPropName(const Value: string);
begin
  FTargetPropName := Value;
  SetTargetImpl;
end;

end.
