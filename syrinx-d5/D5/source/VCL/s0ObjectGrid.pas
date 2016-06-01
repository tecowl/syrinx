{-----------------------------------------------------------------------------
 Unit Name: s0ObjectGrid
 Author:    akima
 Purpose:
 TestCase: tc_s0ObjectGrid
 $History: s0ObjectGrid.pas $
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/02/14   Time: 21:53
 * Updated in $/source/D5Integrated
 * ResetPropToGridをoverrideして、CtrlDecoの位置調整を行うようにした。
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/02/06   Time: 4:43
 * Updated in $/source/D5Integrated
 * AdjustFromGridメソッドで、ちゃんと帳尻が合うようにした。
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/02/06   Time: 1:07
 * Updated in $/source/D5Integrated
 * Ts0ObjectGridをTs0CustomObjectGridとTs0ObjectGridに分けた。
 * アップデート終了時にEndUpdateTargetメソッドで、Targetが変更されていたら
 * LoadFromTargetを行うようにした。そのためにFModifiedCountを追加。
 * Ts0CustomObjectGrid.InitColumnsで、ロード中はカラムをクリアしないように
 * 修正。
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/02/05   Time: 4:32
 * Updated in $/source/D5Integrated
 * Controllerクラスを追加してMVCの形にした。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/01/30   Time: 17:33
 * Updated in $/source/D5Integrated
 * Ts0GridCmd_AddRowを追加
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/01/28   Time: 17:14
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/01/10   Time: 13:39
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/01/10   Time: 3:17
 * Updated in $/source/D5Integrated
 * Ts0GridCtrlOfTypeクラスを追加。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/01/06   Time: 0:22
 * Updated in $/source/D5Integrated
 * SetCellsメソッドにおいてUpdateViewCountによる再帰防止
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/12/10   Time: 17:39
 * Updated in $/source/D5Integrated
 * 大リファクタリング後、グリッドがやーっと安定しました。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/10   Time: 16:15
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessorを作成。
 * Ts0StringsAccessorはTs0EnumCollectionを使用する。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/12/07   Time: 18:56
 * Updated in $/source/D5Integrated
 * InplaceEditorを削除するというビッグリファクタリング成功！！！！
 * s0Gridsに修正多数
 * 
 * Ts0CustomStringGrid 
 *   <|--- Ts0CustomBindGrid
 *     <|--- Ts0CustomBaseGrid
 *       <|--- Ts0CustomDecoGrid
 *         <|--- Ts0CustomCtrlGrid
 *           <|--- Ts0CustomObjectGrid
 * となっていた継承関係を以下のように変更
 * 
 * Ts0CustomStringGrid 
 *   <|--- Ts0CustomDecoStringGrid (s0CellDecoratorに新規作成)
 *     <|--- Ts0CustomBindGrid
 *       <|--- Ts0CustomCtrlGrid
 *         <|--- Ts0CustomDecoGrid
 *           <|--- Ts0CustomBaseGrid
 *             <|--- Ts0CustomObjectGrid
 * 
 * 常々InplaceEditorが邪魔だなーと思っていたが、スパイクのつもりで
 * 削除してみたら大成功！もうInplaceEditorとCtrlDecoのコントロールを
 * 区別しません！わーい。処理が速くなったし、全体的にすっきりしたっす。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/12/06   Time: 20:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/12/05   Time: 18:49
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/11/28   Time: 21:59
 * Updated in $/source/D5Integrated
 * 破棄中には実行しないようにInitColumnsに事前条件を加えた
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/11/25   Time: 5:35
 * Updated in $/source/D5Integrated
 * AutoUpdateTargetプロパティを追加。
 * SetCellsが呼び出されたときに、Targetを自動的に変更する。
 * ConfirmUpdateプロパティを削除。
-----------------------------------------------------------------------------}

unit s0ObjectGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Contnrs,
  s0VCLClasses,
  s0Persistent,
  s0Matrix,
  s0Grids, s0BindGrid, s0CtrlGrid, s0DecoGrid, s0BaseGrid,
  s0Observer,
  s0Collection,
  s0CellDecorator,
  s0TypInfoWrapper,
  s0CtrlOfType;

type
  Ts0GridCtrlOfTypeClass = class of Ts0GridCtrlOfType;
  Ts0GridCtrlOfType = class(Ts0CtrlOfType)
  public
    class procedure RegisterGridCOT(AGridCOTClass: Ts0GridCtrlOfTypeClass);
    class procedure UnRegisterGridCOT(AGridCOTClass: Ts0GridCtrlOfTypeClass);
    class procedure GetRegisteredGridCOTs(Dest: TClassList);
    class function GetDefaultCOT: Ts0GridCtrlOfTypeClass;
    class procedure SetDefaultCOT(AGridCOTClass: Ts0GridCtrlOfTypeClass);
  end;

type
  K0ObjectGridColumnLoadEvent = procedure(Sender: TObject; Accessor: Ts0RTTIPublishedAccessor; var Value: string) of object;
  K0ObjectGridColumnSaveEvent = procedure(Sender: TObject; Accessor: Ts0RTTIPublishedAccessor; Value: string) of object;

type
  Ts0ObjectGridColumn = class(Ts0GridColumn)
  private
    FProp: Ts0RTTIProp;
    FCtrlDeco: Ts0CtrlDecorator;
    FCanShowObjEditor: Boolean;
    FUpdateIndex: Integer;
    FCustomAccess: Boolean;
    FOnCustomLoad: K0ObjectGridColumnLoadEvent;
    FOnCustomSave: K0ObjectGridColumnSaveEvent;
    FPropName: string;
    FCustomCtrl: Boolean;
    procedure SetProp(const Value: Ts0RTTIProp);
    function GetUpdateIndex: Integer;
    procedure SetUpdateIndex(const Value: Integer);
    procedure SetPropName(const Value: string);
    function GetCtrlOfType: Ts0CtrlOfType;
  protected
    procedure DoCustomLoad(Accessor: Ts0RTTIPublishedAccessor; var Value: string);
    procedure DoCustomSave(Accessor: Ts0RTTIPublishedAccessor; Value: string);
    property CtrlOfType: Ts0CtrlOfType read GetCtrlOfType;
    function InitCtrlDeco: Ts0CtrlDecorator;
    procedure RestoreDefaultValue;
    function LoadFromAccessor(Accessor: Ts0RTTIPublishedAccessor): string;
    procedure SaveToAccessor(Accessor: Ts0RTTIPublishedAccessor; Value: string);
    procedure ResetPropToGrid; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure ShowObjEditor(AInstance: TObject);
    property Prop: Ts0RTTIProp read FProp write SetProp;
  published
    property CanShowObjEditor: Boolean read FCanShowObjEditor write FCanShowObjEditor default True;
    property CustomAccess: Boolean read FCustomAccess write FCustomAccess default False;
    property CustomCtrl: Boolean read FCustomCtrl write FCustomCtrl default False;
    property PropName: string read FPropName write SetPropName;
    property UpdateIndex: Integer read GetUpdateIndex write SetUpdateIndex;
    property OnCustomLoad: K0ObjectGridColumnLoadEvent read FOnCustomLoad write FOnCustomLoad;
    property OnCustomSave: K0ObjectGridColumnSaveEvent read FOnCustomSave write FOnCustomSave;
  end;

type
  Ts0ObjectGridColumns = class(Ts0GridColumns)
  private
    FUpdateSequence: Ts0CollectionItemList;
    function GetColumns(const Index: Integer): Ts0ObjectGridColumn;
    procedure SetColumns(const Index: Integer;
      const Value: Ts0ObjectGridColumn);
  protected
    function AddToSeq(AItem: Ts0ObjectGridColumn): Integer;
    procedure RemoveFromSeq(AItem: Ts0ObjectGridColumn);
  public
    constructor Create(AOwner: TPersistent; AItemClass: Ts0CollectionItemClass); override;
    destructor Destroy; override;
    function FindColumn(APropName: string): Ts0ObjectGridColumn;
    procedure FixUpdateSeq;
    property Columns[const Index: Integer]: Ts0ObjectGridColumn read GetColumns write SetColumns; default;
  end;

type
  Ts0ObjectGridController = class;

  Ts0CustomObjectGrid = class(Ts0CustomBaseGrid)
  private
    FAutoUpdateTarget: Boolean;
    FMappingColumnBase: Boolean;
    FCtrlOfType: Ts0GridCtrlOfType;
    FController: Ts0ObjectGridController;
    function GetColumns: Ts0ObjectGridColumns;
    procedure SetColumns(const Value: Ts0ObjectGridColumns);
    function GetCtrlOfTypeClassName: string;
    procedure SetCtrlOfType(const Value: Ts0GridCtrlOfType);
    procedure SetCtrlOfTypeClassName(const Value: string);
    procedure SetController(const Value: Ts0ObjectGridController);
  protected
    procedure ChangeSize(NewColCount, NewRowCount: Longint); override; //Entry Point
    procedure DecoDestroy(Sender: TObject; AItem: Ts0CollectionItem); override;
    procedure DblClick; override; //Entry Point
    function GetColUpdateSeq: Ts0CollectionItemList;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override; //Entry Point
    procedure Loaded; override;
    function NewColums: Ts0GridColumns; override;
    function NewController: Ts0ObjectGridController; virtual;
    function NewCtrlDecos: Ts0CtrlDecorators; override;
    function NewCtrlOfType: Ts0GridCtrlOfType; virtual;
    procedure ShowObjPropEditor;
  protected
    function IsReadOnly(ACol, ARow: Integer): Boolean; override;
    procedure SetCells(ACol, ARow: Integer; const Value: string); override;
    procedure SetRowCount(Value: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EndUpdateView; override;
    procedure InitColumns;
    procedure PrepareCommands;
    procedure LoadFromTarget;
    procedure SaveToTarget;
    property Controller: Ts0ObjectGridController read FController write SetController;
  public
    procedure ExecAddRow(ARowCount: Integer = 1); override;
    procedure ExecInsertRow(ARowIndex: Integer; ARowCount: Integer = 1); override;
    procedure ExecRemoveRow(ARowIndex: Integer; ARowCount: Integer = 1); override;
    procedure LoadFromMatrixByRect(AMatrix: Ts0Matrix; ACoord: TGridCoord); override;
  protected
    property AutoUpdateTarget: Boolean read FAutoUpdateTarget write FAutoUpdateTarget default True;
    property CtrlOfTypeClassName: string read GetCtrlOfTypeClassName write SetCtrlOfTypeClassName;
    property CtrlOfType: Ts0GridCtrlOfType read FCtrlOfType write SetCtrlOfType;
    property MappingColumnBase: Boolean read FMappingColumnBase write FMappingColumnBase default False;
    property Columns: Ts0ObjectGridColumns read GetColumns write SetColumns;
  end;

  Ts0ObjectGridController = class(Ts0VCLPersistent)
  private
    FAutoUpdate: Boolean;
    FUpdateTargetCount: Integer;
    FMappedItemCount: Integer;
    procedure SetAutoUpdate(const Value: Boolean);
  protected
    FTargetListener: Ts0EventListener;
    FModifiedCount: Integer;
    FOwnerGrid: Ts0CustomObjectGrid;
    function CanMapping: Boolean; virtual;
    function GetMappingClass: TClass; virtual;
    function GetMappingCount: Integer; virtual;
    function GetMappingItem(AIndex: Integer): TObject; virtual;
    function MappingItemExists(AObj: TObject): Boolean; virtual;
    function NewMappingObj(ARow: Integer): TObject; virtual;
    procedure RemoveObj(ARow: Integer); virtual;
  protected
    procedure TargetItemUpdate(Sender: TObject);
  protected
    function IndexToRow(AIndex: Integer): Integer;
    function RowToIndex(ARow: Integer): Integer;
  protected
    procedure AdjustFromGrid;
    procedure AdjustFromTarget;
  protected
    procedure LoadFromTarget;
    procedure LoadFromTargetItem(ARow: Integer; Accessor: Ts0RTTIPublishedAccessor);
    function LoadFromTargetItemProp(Accessor: Ts0RTTIPublishedAccessor;
      ACol: Ts0ObjectGridColumn): string;
  protected
    procedure SaveFromCell(ACol, ARow: Integer; const Value: string);
    procedure SaveToTarget;
    procedure SaveToTargetItem(ARow: Integer; Accessor: Ts0RTTIPublishedAccessor);
    procedure SaveToTargetItemProp(Accessor: Ts0RTTIPublishedAccessor;
      ACol: Ts0ObjectGridColumn; AValue: string);
  protected
    procedure AddItems(ACount: Integer);
    procedure InsertItems(ARowIndex, ACount: Integer);
    procedure RemoveItems(ARowIndex, ACount: Integer);
  public
    constructor Create(AOnwer: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdateTarget; virtual;
    procedure EndUpdateTarget; virtual;
    function GetMappingItemByRow(ARow: Integer): TObject;
    property MappedItemCount: Integer read FMappedItemCount;
    property UpdateTargetCount: Integer read FUpdateTargetCount;
  published
    property AutoUpdate: Boolean read FAutoUpdate write SetAutoUpdate;
  end;

type
  Es0ObjectGridController = class(Exception);

implementation

uses
  s0GridCtrlOfType_Default,
  s0BaseGridCommand,
  s0ComponentHelper,
  s0ObjectHelper,
  StdCtrls,
  s0GridCellCheck,
  s0ComboBox,
  s0CheckListBox,
  TypInfo,
  s0fObjEditor;

{ Ts0GridCtrlOfType }

var
  g9DefaultCOT: Ts0GridCtrlOfTypeClass = nil;
  g9RegisteredGridCOTs: TClassList;

class function Ts0GridCtrlOfType.GetDefaultCOT: Ts0GridCtrlOfTypeClass;
begin
  if (g9DefaultCOT = nil) then
    if (g9RegisteredGridCOTs <> nil) and (g9RegisteredGridCOTs.Count > 0) then
      g9DefaultCOT := Ts0GridCtrlOfTypeClass(g9RegisteredGridCOTs.First);
  Result := g9DefaultCOT;
end;

class procedure Ts0GridCtrlOfType.GetRegisteredGridCOTs(Dest: TClassList);
var
  i: Integer;
begin
  for i := 0 to g9RegisteredGridCOTs.Count -1 do
    Dest.Add( g9RegisteredGridCOTs.Items[i] );
end;

class procedure Ts0GridCtrlOfType.RegisterGridCOT(
  AGridCOTClass: Ts0GridCtrlOfTypeClass);
begin
  if g9RegisteredGridCOTs = nil then
    g9RegisteredGridCOTs := TClassList.Create;
  if g9RegisteredGridCOTs.IndexOf(AGridCOTClass) > -1 then Exit;
  g9RegisteredGridCOTs.Add(AGridCOTClass);
end;

class procedure Ts0GridCtrlOfType.SetDefaultCOT(
  AGridCOTClass: Ts0GridCtrlOfTypeClass);
begin
  g9DefaultCOT := AGridCOTClass;
end;

class procedure Ts0GridCtrlOfType.UnRegisterGridCOT(
  AGridCOTClass: Ts0GridCtrlOfTypeClass);
begin
  if g9RegisteredGridCOTs = nil then Exit;
  while g9RegisteredGridCOTs.Remove(AGridCOTClass) > -1 do;
end;

{ Ts0ObjectGridColumn }

constructor Ts0ObjectGridColumn.Create(ACollection: TCollection);
begin
  inherited;
  FCustomAccess := False;
  FCanShowObjEditor := True;
  if not(Collection is Ts0ObjectGridColumns) then Exit;
  Ts0ObjectGridColumns(Collection).AddToSeq(Self);
end;

destructor Ts0ObjectGridColumn.Destroy;
begin
  if Collection is Ts0ObjectGridColumns then
    Ts0ObjectGridColumns(Collection).RemoveFromSeq(Self);
  inherited Destroy;
end;

procedure Ts0ObjectGridColumn.DoCustomLoad(
  Accessor: Ts0RTTIPublishedAccessor; var Value: string);
begin
  if Assigned(FOnCustomLoad) then
    FOnCustomLoad(Self, Accessor, Value);
end;

procedure Ts0ObjectGridColumn.DoCustomSave(
  Accessor: Ts0RTTIPublishedAccessor; Value: string);
begin
  if Assigned(FOnCustomSave) then
    FOnCustomSave(Self, Accessor, Value);
end;

function Ts0ObjectGridColumn.GetCtrlOfType: Ts0CtrlOfType;
begin
  Result := nil;
  if OwnerGrid is Ts0CustomObjectGrid then
    Result := Ts0CustomObjectGrid(OwnerGrid).CtrlOfType;
end;

function Ts0ObjectGridColumn.GetUpdateIndex: Integer;
var
  seq: Ts0CollectionItemList;
begin
  Result := -1;
  if not(Collection is Ts0ObjectGridColumns) then Exit;
  seq := Ts0ObjectGridColumns(Collection).FUpdateSequence;
  Result := seq.IndexOf(Self);
end;

function Ts0ObjectGridColumn.InitCtrlDeco: Ts0CtrlDecorator;
  function CreateCtrl(AType: Ts0RTTITypeInfo): TWinControl;
  var
    cls: TClass;
    ctrlClass: TWinControlClass;
    ctrlClassName: string;
  begin
    Result := nil;
    if AType = nil then Exit;
    if CtrlOfType = nil then Exit;
    ctrlClassName :=
      CtrlOfType.GetCtrlClassName(
        AType.TypeName,
        Ts0TypeKindHelper.GetWrappedTypeKind(AType.TypeName, AType.TypeKind)
      );
    cls := GetClass(ctrlClassName);
    if cls = nil then Exit;
    if not cls.InheritsFrom(TWinControl) then Exit;
    ctrlClass := TWinControlClass(cls);
    Result := ctrlClass.Create(Self.OwnerGrid.Owner);
    Result.Top := -100;
    Result.Parent := OwnerGrid.Parent;
    Result.Name := Ts0ComponentHelper.GetNewComponentName(Result);
    CtrlOfType.InitCtrl(FProp, Result);
  end;
  function NewCtrlDeco(AProp: Ts0RTTIProp): Ts0CtrlDecorator;
  begin
    Result := nil;
    if not(OwnerGrid is Ts0CustomObjectGrid) then Exit;
    Result := Ts0CustomObjectGrid(OwnerGrid).CtrlDecos.Add(nil);
    Result.FreeWithCtrl := True;
    Result.Control :=  CreateCtrl(FProp.TypeInfo);
    Result.Enabled := True;
    Result.RegionKind := k0gcrCols;
    Result.Left := Self.Index;
    Result.Right := Self.Index;
  end;
begin
  if FProp <> nil then
  begin
    if (FCtrlDeco = nil) and (not FCustomCtrl) then
      FCtrlDeco := NewCtrlDeco(FProp);
  end
  else
  begin
    FreeAndNil(FCtrlDeco);
  end;
  Result := FCtrlDeco;
end;

function Ts0ObjectGridColumn.LoadFromAccessor(
  Accessor: Ts0RTTIPublishedAccessor): string;
begin
  Result := Accessor.PropAsString[PropName];
  if FCustomAccess then
    DoCustomLoad(Accessor, Result);
end;

procedure Ts0ObjectGridColumn.ResetPropToGrid;
  procedure ResetCtrlDeco;
  begin
    if FCtrlDeco = nil then Exit;
    FCtrlDeco.Left := Self.Index;
    FCtrlDeco.Right := Self.Index;
  end;
begin
  inherited;
  ResetCtrlDeco;
end;

procedure Ts0ObjectGridColumn.RestoreDefaultValue;
begin
  if FProp = nil then Exit;
  if FProp.TypeInfo = nil then Exit;
  case FProp.TypeInfo.TypeKind of
    tkUnknown    : ;
    tkInteger    : DefaultValue := IntToStr(FProp.DefaultValue);
    tkChar       : DefaultValue := Char(FProp.DefaultValue);
    tkEnumeration: DefaultValue := FProp.TypeInfo.GetName(FProp.DefaultValue);
    tkFloat      : DefaultValue := '0';
    tkString     : ;
    tkSet        : ;
    tkClass      : DefaultValue := '(nil)';
    tkMethod     : ;
    tkWChar      : ;
    tkLString    : ;
    tkWString    : ;
    tkVariant    : ;
    tkArray      : ;
    tkRecord     : ;
    tkInterface  : ;
    tkInt64      : DefaultValue:= IntToStr(FProp.DefaultValue);
    tkDynArray   : ;
  end;
end;

procedure Ts0ObjectGridColumn.SaveToAccessor(
  Accessor: Ts0RTTIPublishedAccessor; Value: string);
begin
  if FCustomAccess then
  begin
    DoCustomSave(Accessor, Value);
  end
  else
  if FProp <> nil then
    if Accessor.PropAsString[ FProp.PropName ] <> Value then
      Accessor.PropAsString[ FProp.PropName ] := Value;
end;

procedure Ts0ObjectGridColumn.SetProp(const Value: Ts0RTTIProp);
begin
  FProp := Value;
  if FProp <> nil then
    PropName := FProp.PropName;
  InitCtrlDeco;
  RestoreDefaultValue;
end;

procedure Ts0ObjectGridColumn.SetPropName(const Value: string);
begin
  FPropName := Value;
  if Title = '' then
    Title := FPropName;
end;

procedure Ts0ObjectGridColumn.SetUpdateIndex(const Value: Integer);
var
  seq: Ts0CollectionItemList;
  v: Integer;
begin
  if not(Collection is Ts0ObjectGridColumns) then Exit;
  seq := Ts0ObjectGridColumns(Collection).FUpdateSequence;
  if UpdateIndex < 0 then
    Ts0ObjectGridColumns(Collection).AddToSeq(Self);
  if [csLoading, csReading] * OwnerGrid.ComponentState <> [] then
  begin
    FUpdateIndex := Value;
  end
  else
  begin
    v := Value;
    if v < 0 then v := 0;
    if v > seq.Count -1 then v := seq.Count -1;
    if v = UpdateIndex then Exit;
    seq.Remove(Self);
    seq.Insert(Value, Self);
  end;
end;

procedure Ts0ObjectGridColumn.ShowObjEditor(AInstance: TObject);
var
  acsr: Ts0RTTIPublishedAccessor;
  obj: TObject;
begin
  if not CanShowObjEditor then Exit;
  if AInstance = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create( AInstance );
  try
    obj := acsr.ObjectProp[Prop.PropName];
    Ts0frmObjEditor.ShowEditorModal( obj );
  finally
    FreeAndNil(acsr);
  end;
end;

{ Ts0ObjectGridColumns }

function Ts0ObjectGridColumns.AddToSeq(
  AItem: Ts0ObjectGridColumn): Integer;
begin
  Result := FUpdateSequence.IndexOf(AItem);
  if Result > -1 then Exit;
  Result := FUpdateSequence.Add(AItem);
end;

constructor Ts0ObjectGridColumns.Create(AOwner: TPersistent;
  AItemClass: Ts0CollectionItemClass);
begin
  inherited;
  FUpdateSequence := Ts0CollectionItemList.Create(False);
end;

destructor Ts0ObjectGridColumns.Destroy;
begin
  FreeAndNil(FUpdateSequence);
  inherited Destroy;
end;         

function Ts0ObjectGridColumns.FindColumn(APropName: string): Ts0ObjectGridColumn;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Columns[i];
    if Result.Prop = nil then Continue;
    if CompareText(Result.Prop.PropName, APropName) = 0 then Exit;
  end;
  Result := nil;
end;

procedure Ts0ObjectGridColumns.FixUpdateSeq;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Columns[i].UpdateIndex := Columns[i].FUpdateIndex;
end;

function Ts0ObjectGridColumns.GetColumns(
  const Index: Integer): Ts0ObjectGridColumn;
begin
  Result := Ts0ObjectGridColumn(inherited Columns[Index]);
end;

procedure Ts0ObjectGridColumns.RemoveFromSeq(
  AItem: Ts0ObjectGridColumn);
begin
  if FUpdateSequence = nil then Exit;
  FUpdateSequence.Remove(AItem);
end;

procedure Ts0ObjectGridColumns.SetColumns(const Index: Integer;
  const Value: Ts0ObjectGridColumn);
begin
  inherited Columns[Index] := Value;
end;

{ Ts0CustomObjectGrid }

procedure Ts0CustomObjectGrid.ChangeSize(NewColCount, NewRowCount: Integer);
begin
  if Controller.UpdateTargetCount >0 then Exit;
  inherited ChangeSize(NewColCount, NewRowCount);       
end;

constructor Ts0CustomObjectGrid.Create(AOwner: TComponent);
begin
  inherited;
  FAutoUpdateTarget := True;
  FMappingColumnBase := False; 
  Self.ColWidths[0] := 20;
  FCtrlOfType := NewCtrlOfType;
  Options := Options + [goRowSizing, goColSizing];
  FController := NewController;
end;

procedure Ts0CustomObjectGrid.DblClick;
begin
  inherited DblClick;
  ShowObjPropEditor;
end;

procedure Ts0CustomObjectGrid.DecoDestroy(Sender: TObject;
  AItem: Ts0CollectionItem);
  procedure ClearColDeco(ACtrlDeco: Ts0CtrlDecorator);
  var
    i: Integer;
  begin
    for i := 0 to Columns.Count -1 do
      if Columns[i].FCtrlDeco = ACtrlDeco then
        Columns[i].FCtrlDeco := nil;
  end;
begin
  if AItem is Ts0CtrlDecorator then
    ClearColDeco( Ts0CtrlDecorator(AItem) );
  inherited DecoDestroy(Sender, AItem);
end;

destructor Ts0CustomObjectGrid.Destroy;
begin
  FreeAndNil(FController);
  FreeAndNil(FCtrlOfType);
  inherited Destroy;
end;

procedure Ts0CustomObjectGrid.EndUpdateView;
begin
  inherited EndUpdateView;
end;

procedure Ts0CustomObjectGrid.ExecAddRow(ARowCount: Integer);
begin
  Controller.AddItems(ARowCount);
  Controller.LoadFromTarget;
  Invalidate;
end;

procedure Ts0CustomObjectGrid.ExecInsertRow(ARowIndex, ARowCount: Integer);
begin
  Controller.InsertItems(ARowIndex, ARowCount);
  Controller.LoadFromTarget;
  Invalidate;
end;

procedure Ts0CustomObjectGrid.ExecRemoveRow(ARowIndex, ARowCount: Integer);
begin
  Controller.RemoveItems(ARowIndex, ARowCount);
  Controller.LoadFromTarget;
  Invalidate;
end;

function Ts0CustomObjectGrid.GetColumns: Ts0ObjectGridColumns;
begin
  Result := Ts0ObjectGridColumns( inherited Columns );
end;

function Ts0CustomObjectGrid.GetColUpdateSeq: Ts0CollectionItemList;
begin
  Result := Columns.FUpdateSequence;
end;

function Ts0CustomObjectGrid.GetCtrlOfTypeClassName: string;
begin
  Result := FCtrlOfType.ClassName;
end;

procedure Ts0CustomObjectGrid.InitColumns;
  procedure ClearColumns;
  var
    i: Integer;
  begin
    if [csLoading, csReading] * Self.ComponentState <> [] then Exit;
    CtrlDecos.Clear;
    for i := 0 to Columns.Count -1 do
    begin
      Columns.Columns[i].FCtrlDeco := nil;
      Columns.Columns[i].Prop := nil;
    end;
    ColCount := FixedCols + 1;
  end;
  procedure InitBasedColumns(AProps: Ts0RTTIProps);
  var
    colCol: Ts0ObjectGridColumn;
    cl: Ts0CollectionItemList;
    i: Integer;
    p: Ts0RTTIProp;
  begin
    if Self.ColCount < AProps.Count + 1 then
      Self.ColCount := AProps.Count + 1;
    cl := Ts0CollectionItemList.Create(False);
    try
      for i := 0 to AProps.Count -1 do
        cl.Add( AProps.Props[i]);
      if cl.Count = 0 then Exit;
      for i := 1 to Self.Columns.Count -1 do
      begin
        Assert(Columns[i] is Ts0ObjectGridColumn, 'Illegal column class');
        colCol := Ts0ObjectGridColumn(Columns[i]);
        p := nil;
        if Trim(colCol.PropName) <> '' then
          p := Ts0RTTIProp( cl.FindByIdentifier( Trim(colCol.PropName)) );
        colCol.Prop := p;
        cl.Remove( p );
      end;
    finally
      FreeAndNil(cl);
    end;
  end;
  procedure InitBasedProps(AProps: Ts0RTTIProps);
  var
    i: Integer;
    colCol: Ts0ObjectGridColumn;
  begin
    Columns.Clear;
    ClearColumns;
    Self.ColCount := AProps.Count + 1;
    for i := 0 to AProps.Count - 1 do
    begin
      Assert(Columns[i] is Ts0ObjectGridColumn, 'Illegal column class');
      colCol := Ts0ObjectGridColumn(Columns[i + FixedCols]);
      colCol.Prop := AProps.Props[i];
      colCol.PropName := colCol.Prop.PropName;
      colCol.Title := colCol.Prop.PropName;
    end;
  end;
var
  ti: Ts0RTTITypeInfo;
begin
  if [csDestroying {, csFreeNotification} ] * Self.ComponentState <> [] then Exit;
  if not Controller.CanMapping then
  begin
    ClearColumns;
    Exit;
  end;
  ti := Ts0RTTIPublishedBroker.Instance.GetTypeInfoByClass( Controller.GetMappingClass );
  if ti = nil then Exit;
  //CtrlDecos.Clear;
  Self.FixedCols := 1;
  Self.FixedRows := 1;
  Self.ColWidths[0] := 20;
  if Self.Columns.Count > 0 then
  begin
    Self.Columns[0].Title := '';
    Self.Columns[0].PropName := '';
  end;
  if FMappingColumnBase then
    InitBasedColumns(ti.PublishedProps.Props)
  else
    InitBasedProps(ti.PublishedProps.Props);
  CtrlDecos.HideControls;
  CtrlDecos.OverrideCtrlEvent;
end;

function Ts0CustomObjectGrid.IsReadOnly(ACol, ARow: Integer): Boolean;
begin
  Result := True;
  if Controller.MappedItemCount <= Controller.RowToIndex(ARow) then Exit;
  Result := inherited IsReadOnly(ACol, ARow);
end;

procedure Ts0CustomObjectGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    ShowObjPropEditor;
end;

procedure Ts0CustomObjectGrid.Loaded;
begin
  inherited Loaded;
  Columns.FixUpdateSeq;
end;

procedure Ts0CustomObjectGrid.LoadFromMatrixByRect(AMatrix: Ts0Matrix;
  ACoord: TGridCoord);
begin
  inherited LoadFromMatrixByRect(AMatrix, ACoord);
  LoadFromTarget;
end;

procedure Ts0CustomObjectGrid.LoadFromTarget;
begin
  Controller.LoadFromTarget;
end;

function Ts0CustomObjectGrid.NewColums: Ts0GridColumns;
begin
  Result := Ts0ObjectGridColumns.Create(Self, Ts0ObjectGridColumn);
end;

function Ts0CustomObjectGrid.NewController: Ts0ObjectGridController;
begin
  Result := Ts0ObjectGridController.Create(Self);  
end;

function Ts0CustomObjectGrid.NewCtrlDecos: Ts0CtrlDecorators;
begin
  Result := inherited NewCtrlDecos;
  Result.OnItemDestroy := Self.DecoDestroy;
end;

function Ts0CustomObjectGrid.NewCtrlOfType: Ts0GridCtrlOfType;
begin
  Result := nil;
  if Ts0GridCtrlOfType.GetDefaultCOT = nil then Exit;
  Result := Ts0GridCtrlOfType.GetDefaultCOT.Create(Self);
end;

procedure Ts0CustomObjectGrid.PrepareCommands;
begin
  Commands.Clear;
  Commands.AddItem(Ts0GridCmd_CopyToClipBoard);
  Commands.AddItem(Ts0GridCmd_CutToClipBoard);
  Commands.AddItem(Ts0GridCmd_DeleteSelection);
  Commands.AddItem(Ts0GridCmd_PasteFromClipBoard);
  Commands.AddItem(Ts0GridCmd_SelectAll);
  Commands.AddItem(Ts0GridCmd_AddRow);
  Commands.AddItem(Ts0GridCmd_InsertRow);
  Commands.AddItem(Ts0GridCmd_RemoveRow);
  Commands.AddItem(Ts0ChangeCellSize);
end;

procedure Ts0CustomObjectGrid.SaveToTarget;
begin
  Controller.SaveToTarget;
end;

procedure Ts0CustomObjectGrid.SetCells(ACol, ARow: Integer; const Value: string);
begin
  inherited SetCells(ACol, ARow, Value);
  if not FAutoUpdateTarget then Exit;
  if [csLoading, csReading, csDesigning] * Self.ComponentState <> [] then Exit;
  if ACol < FixedCols then Exit;
  if ARow < FixedRows then Exit;
  Controller.BeginUpdateTarget;
  try
    Controller.SaveFromCell(ACol, ARow, Value);
  finally
    Controller.EndUpdateTarget;
  end;
end;

procedure Ts0CustomObjectGrid.SetColumns(
  const Value: Ts0ObjectGridColumns);
begin
  inherited Columns := Value;
end;

procedure Ts0CustomObjectGrid.SetController(
  const Value: Ts0ObjectGridController);
begin
  FController.Assign(Value);
end;

procedure Ts0CustomObjectGrid.SetCtrlOfType(const Value: Ts0GridCtrlOfType);
begin
  FCtrlOfType := Value;
end;

procedure Ts0CustomObjectGrid.SetCtrlOfTypeClassName(const Value: string);
var
  cls: TPersistentClass;
begin
  if SameText(CtrlOfTypeClassName, Value) then Exit;
  cls := GetClass(Value);
  if cls = nil then Exit;
  if not cls.InheritsFrom(Ts0GridCtrlOfType) then Exit;
  FreeAndNil(FCtrlOfType);
  FCtrlOfType := Ts0GridCtrlOfTypeClass(cls).Create(Self);
end;

procedure Ts0CustomObjectGrid.SetRowCount(Value: Integer);
begin
  inherited SetRowCount(Value);
  if not Controller.CanMapping then Exit;
  Controller.AdjustFromGrid;
end;

procedure Ts0CustomObjectGrid.ShowObjPropEditor;
var
  c: Ts0ObjectGridColumn;
begin
  if not Controller.CanMapping then Exit;
  c := nil;
  if Columns[Self.Col] is Ts0ObjectGridColumn then
    c := Ts0ObjectGridColumn(Columns[Self.Col]);
  if c = nil then Exit;
  if c.Prop = nil then Exit;
  if c.Prop.TypeInfo.TypeKind <> tkClass then Exit;
  SaveToTarget;
  c.ShowObjEditor( Controller.GetMappingItemByRow(Self.Row) );
end;

{ Ts0ObjectGridController }

procedure Ts0ObjectGridController.AddItems(ACount: Integer);
var
  i: Integer;
begin
  if Self.UpdateTargetCount > 0 then Exit;
  BeginUpdateTarget;
  try
    for i := 0 to ACount -1 do
      NewMappingObj( IndexToRow(GetMappingCount) );
    FMappedItemCount := GetMappingCount;
  finally
    EndUpdateTarget;
  end;
end;

procedure Ts0ObjectGridController.AdjustFromGrid;
var
  i: Integer;
  mc, gc: Integer;
begin
  if Self.UpdateTargetCount > 0 then Exit;
  BeginUpdateTarget;
  try
    mc := IndexToRow(GetMappingCount);
    gc := FOwnerGrid.RowCount;
    if gc = FOwnerGrid.FixedRows + 1 then
      if FMappedItemCount = 0 then
        Dec(gc);
    if gc = mc then
      Exit
    else
    if gc < mc then
    begin
      for i := mc -1 downto gc do
        RemoveObj(i);
    end
    else
    begin
      for i := 0 to (gc - mc) do
        NewMappingObj(mc);
    end;
  finally
    FMappedItemCount := GetMappingCount;
    EndUpdateTarget;
  end;
end;

procedure Ts0ObjectGridController.AdjustFromTarget;
begin
  FOwnerGrid.InhrSetRowCount(GetMappingCount + FOwnerGrid.FixedRows);
end;

procedure Ts0ObjectGridController.Assign(Source: TPersistent);
begin

end;

procedure Ts0ObjectGridController.BeginUpdateTarget;
begin
  Inc(FUpdateTargetCount);
end;

resourcestring
  c9ErrMsg_IllegalOwner = '<Ts0ObjectGridController> Illegal Owner';

function Ts0ObjectGridController.CanMapping: Boolean;
begin
  Result := False;
end;

constructor Ts0ObjectGridController.Create(AOnwer: TPersistent);
begin
  if not(AOnwer is Ts0CustomObjectGrid) then
    Es0ObjectGridController.Create(c9ErrMsg_IllegalOwner);
  inherited Create(AOnwer);
  FMappedItemCount := 0;
  FOwnerGrid := Ts0CustomObjectGrid(AOnwer);
  FTargetListener := Ts0EventListener.Create(TargetItemUpdate);
end;

destructor Ts0ObjectGridController.Destroy;
begin
  FreeAndNil(FTargetListener);
  inherited;
end;

procedure Ts0ObjectGridController.EndUpdateTarget;
begin
  Dec(FUpdateTargetCount);
  if FUpdateTargetCount < 0 then
    FUpdateTargetCount := 0;
  //BeginUpdateTarget ～ EndUpdateTargetまでに変更されていたら、再読み込み
  if FUpdateTargetCount < 1 then
    if FModifiedCount > 0 then
      LoadFromTarget;
end;

function Ts0ObjectGridController.GetMappingClass: TClass;
begin
  Result := nil;
end;

function Ts0ObjectGridController.GetMappingCount: Integer;
begin
  Result := 0;
end;

function Ts0ObjectGridController.GetMappingItem(AIndex: Integer): TObject;
begin
  Result := nil;
end;

function Ts0ObjectGridController.GetMappingItemByRow(
  ARow: Integer): TObject;
begin
  Result := GetMappingItem( RowToIndex(ARow) );
end;

function Ts0ObjectGridController.IndexToRow(AIndex: Integer): Integer;
begin
  Result := AIndex + FOwnerGrid.FixedRows;
end;

procedure Ts0ObjectGridController.InsertItems(ARowIndex, ACount: Integer);
var
  i: Integer;
begin
  if Self.UpdateTargetCount > 0 then Exit;
  BeginUpdateTarget;
  try
    for i := 0 to ACount -1 do
      NewMappingObj(ARowIndex);
    FMappedItemCount := GetMappingCount;
  finally
    EndUpdateTarget;
  end;
end;

procedure Ts0ObjectGridController.LoadFromTarget;
var
  i: Integer;
  acsr: Ts0RTTIPublishedAccessor;
begin
  if FOwnerGrid.UpdateViewCount > 0 then Exit;
  FOwnerGrid.BeginUpdateView;
  try
    if FMappedItemCount <> GetMappingCount then
      FMappedItemCount := GetMappingCount;
    AdjustFromTarget;
    if GetMappingCount < 1 then
    begin
      FOwnerGrid.ClearRow(FOwnerGrid.FixedRows);
    end
    else
    begin
      for i := 0 to GetMappingCount -1 do
      begin
        acsr := Ts0RTTIPublishedAccessor.Create( GetMappingItem(i) );
        try
          LoadFromTargetItem(IndexToRow(i), acsr);
        finally
          FreeAndNil(acsr);
        end;
      end;
    end;
  finally
    FOwnerGrid.EndUpdateView;
    FModifiedCount := 0;
  end;
end;

procedure Ts0ObjectGridController.LoadFromTargetItem(ARow: Integer; Accessor:
  Ts0RTTIPublishedAccessor);
var
  j: Integer;
  seq: Ts0CollectionItemList;
  col: Ts0ObjectGridColumn;
  newVal: string;
begin
  seq := FOwnerGrid.GetColUpdateSeq;
  for j := 0 to seq.Count -1 do
  begin
    Assert(seq.Items[j] is Ts0ObjectGridColumn);
    col := Ts0ObjectGridColumn(seq.Items[j]);
    newVal := LoadFromTargetItemProp(Accessor, col);
    FOwnerGrid.InhrSetCells(col.Index, ARow, newVal);
  end;
end;

function Ts0ObjectGridController.LoadFromTargetItemProp(Accessor:
  Ts0RTTIPublishedAccessor; ACol: Ts0ObjectGridColumn): string;
begin
  Result := ACol.LoadFromAccessor(Accessor);
end;

function Ts0ObjectGridController.MappingItemExists(AObj: TObject): Boolean;
begin
  Result := False;
end;

function Ts0ObjectGridController.NewMappingObj(ARow: Integer): TObject;
begin
  Result := nil;
end;

procedure Ts0ObjectGridController.RemoveItems(ARowIndex, ACount: Integer);
var
  i: Integer;
begin
  if not CanMapping then Exit;
  if Self.UpdateTargetCount > 0 then Exit;
  BeginUpdateTarget;
  try
    for i := ARowIndex + ACount -1 downto ARowIndex do
      RemoveObj(i);
    FMappedItemCount := GetMappingCount;
  finally
    EndUpdateTarget;
  end;
end;

procedure Ts0ObjectGridController.RemoveObj(ARow: Integer);
begin
end;

function Ts0ObjectGridController.RowToIndex(ARow: Integer): Integer;
begin
  Result := ARow - FOwnerGrid.FixedRows;
end;

procedure Ts0ObjectGridController.SaveFromCell(ACol, ARow: Integer; const Value: string);
var
  obj: TObject;
  acsr: Ts0RTTIPublishedAccessor;
begin
  obj := GetMappingItem( RowToIndex(ARow) );
  if obj = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(obj);
  try
    SaveToTargetItemProp(acsr, FOwnerGrid.Columns.Columns[ACol], Value);
    FOwnerGrid.Invalidate;
  finally
    FreeAndNil(acsr);
  end;
end;

procedure Ts0ObjectGridController.SaveToTarget;
var
  i: Integer;
  acsr: Ts0RTTIPublishedAccessor;
  obj: TObject;
begin
  AdjustFromGrid;
  for i := FOwnerGrid.FixedRows to FOwnerGrid.RowCount -1 do
  begin
    obj := GetMappingItem(RowToIndex(i));
    if obj = nil then Exit;
    acsr := Ts0RTTIPublishedAccessor.Create( obj );
    try
      SaveToTargetItem(i, acsr);
    finally
      FreeAndNil(acsr);
    end;
  end;
  FOwnerGrid.Invalidate;
end;

procedure Ts0ObjectGridController.SaveToTargetItem(ARow: Integer; Accessor:
  Ts0RTTIPublishedAccessor);
var
  j: Integer;
  seq: Ts0CollectionItemList;
  col: Ts0ObjectGridColumn;
begin
  seq := FOwnerGrid.GetColUpdateSeq;
  for j := 0 to seq.Count -1 do
  begin
    Assert(seq.Items[j] is Ts0ObjectGridColumn);
    col := Ts0ObjectGridColumn(seq.Items[j]);
    SaveToTargetItemProp(Accessor, col, FOwnerGrid.Cells[col.Index, ARow]);
  end;
end;

procedure Ts0ObjectGridController.SaveToTargetItemProp(Accessor:
  Ts0RTTIPublishedAccessor; ACol: Ts0ObjectGridColumn; AValue: string);
begin
  ACol.SaveToAccessor(Accessor, AValue);
end;

procedure Ts0ObjectGridController.SetAutoUpdate(const Value: Boolean);
begin
  FAutoUpdate := Value;
end;                         

procedure Ts0ObjectGridController.TargetItemUpdate(Sender: TObject);
begin
  if Self.UpdateTargetCount > 0 then
  begin
    Inc(FModifiedCount);
    Exit;
  end;
  LoadFromTarget;
end;

initialization

finalization
  FreeAndNil(g9RegisteredGridCOTs);

end.
