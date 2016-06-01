{-----------------------------------------------------------------------------
 Unit Name: s0ObjListGrid
 Author:    akima
 Purpose:
 TestCase: tc_s0ObjListGrid
 $History: s0ObjListGrid.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/14   Time: 21:53
 * Updated in $/source/D5Integrated
 * 正しく動作するようにした。完成
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 1:07
 * Updated in $/source/D5Integrated
 * 修正中
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/25   Time: 5:35
 * Updated in $/source/D5Integrated
 * 行削除時の処理を変更
-----------------------------------------------------------------------------}

unit s0ObjListGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Contnrs,
  s0Grids, s0ObjectGrid;

type
  Ts0ObjListGridController = class(Ts0ObjectGridController)
  private
    FTarget: TObjectList;
    FMappingClassName: string;
    FMappingClass: TClass;
    procedure SetTarget(const Value: TObjectList);
    procedure SetMappingClassName(const Value: string);
    procedure SetMappingClass(const Value: TClass);
  protected
    function CanMapping: Boolean; override;
    function MappingItemExists(AObj: TObject): Boolean; override;
    function GetMappingClass: TClass; override;
    function GetMappingCount: Integer; override;
    function GetMappingItem(AIndex: Integer): TObject; override;
    function NewMappingObj(ARow: Integer): TObject; override;
    procedure RemoveObj(ARow: Integer); override;
  public
    property Target: TObjectList read FTarget write SetTarget;
    property MappingClass: TClass read FMappingClass write SetMappingClass;
  published
    property MappingClassName: string read FMappingClassName write SetMappingClassName;
  end;

type
  Ts0CustomObjListGrid = class(Ts0CustomObjectGrid)
  private
    FTarget: TObjectList;
    procedure SetTarget(const Value: TObjectList);
    function GetController: Ts0ObjListGridController;
    procedure SetController(const Value: Ts0ObjListGridController);
  protected
    function NewController: Ts0ObjectGridController; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function ItemByRow(ARow: Integer): TObject;
    property Target: TObjectList read FTarget write SetTarget;
    property Controller: Ts0ObjListGridController read GetController write SetController;
  end;

type
  Ts0ObjListGrid = class(Ts0CustomObjListGrid)
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
    property Controller;
  end;       

implementation

{ Ts0ObjListGridController }

function Ts0ObjListGridController.CanMapping: Boolean;
begin
  Result := FTarget <> nil;
end;

function Ts0ObjListGridController.GetMappingClass: TClass;
begin
  Result := FMappingClass;
end;

function Ts0ObjListGridController.GetMappingCount: Integer;
begin
  Result := 0;
  if FTarget = nil then Exit;
  Result := FTarget.Count;
end;

function Ts0ObjListGridController.GetMappingItem(
  AIndex: Integer): TObject;
begin
  Result := nil;
  if FTarget = nil then Exit;
  if AIndex < 0 then Exit;
  if AIndex > FTarget.Count -1 then Exit;
  Result := FTarget.Items[AIndex];
end;

function Ts0ObjListGridController.MappingItemExists(
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

function Ts0ObjListGridController.NewMappingObj(ARow: Integer): TObject;
  function NewObj(AClass: TClass): TObject;
  begin
    if AClass.InheritsFrom(TComponent) then
      Result := TComponentClass(AClass).Create(nil)
    else
    if AClass.InheritsFrom(TCollectionItem) then
      Result := TCollectionItem(AClass).Create(nil)
    else
      Result := AClass.Create;
  end;
var
  idx: Integer;
begin
  Result := nil;
  if FTarget = nil then Exit;
  if MappingClass = nil then Exit;
  Result := NewObj(MappingClass);
  idx := RowToIndex(ARow);
  if idx < 0 then idx := 0;
  FTarget.Insert(idx, Result);
end;

procedure Ts0ObjListGridController.RemoveObj(ARow: Integer);
var
  idx: Integer;
begin
  idx := RowToIndex(ARow);
  if idx < 0 then Exit;
  if idx > Target.Count -1 then Exit;
  Target.Delete( idx );
end;

procedure Ts0ObjListGridController.SetMappingClass(const Value: TClass);
begin
  FMappingClass := Value;
  if FMappingClass = nil then
    FMappingClassName := ''
  else
    FMappingClassName := FMappingClass.ClassName;
end;

procedure Ts0ObjListGridController.SetMappingClassName(const Value: string);
begin
  FMappingClassName := Trim(Value);
  if FMappingClassName = '' then
    FMappingClass := nil
  else
    FMappingClass := GetClass(FMappingClassName);
end;

procedure Ts0ObjListGridController.SetTarget(const Value: TObjectList);
begin
  FTarget := Value;
  FOwnerGrid.InitColumns;
  FOwnerGrid.LoadFromTarget;
end;

{ Ts0CustomObjListGrid }

function Ts0CustomObjListGrid.GetController: Ts0ObjListGridController;
begin
  Result := Ts0ObjListGridController(inherited Controller);
end;

function Ts0CustomObjListGrid.ItemByRow(ARow: Integer): TObject;
begin
  Result := inherited Controller.GetMappingItemByRow(ARow);
end;

function Ts0CustomObjListGrid.NewController: Ts0ObjectGridController;
begin
  Result := Ts0ObjListGridController.Create(Self);
end;

procedure Ts0CustomObjListGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

end;

procedure Ts0CustomObjListGrid.SetController(
  const Value: Ts0ObjListGridController);
begin
  inherited Controller := Value;
end;

procedure Ts0CustomObjListGrid.SetTarget(const Value: TObjectList);
var
  ctrl: Ts0ObjListGridController;
begin
  Assert(Controller is Ts0ObjListGridController);
  ctrl := Ts0ObjListGridController(Controller);
  if ctrl.Target <> Value then
    ctrl.Target := Value;
end;

end.
