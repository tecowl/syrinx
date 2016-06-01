unit s0DSFilterMaker;
{
$History: s0DSFilterMaker.pas $
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/22   Time: 17:15
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/02   Time: 3:14
 * Updated in $/source/D5Integrated
 * UpdateDSFilterメソッドを追加
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/27   Time: 9:14
 * Updated in $/source/D5Integrated
 * SubItemsプロパティを再宣言
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/13   Time: 23:26
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/05   Time: 14:27
 * Updated in $/source/D5Integrated
 * ItemsをDefault指定にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0dbctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0dbctrl
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/16   Time: 18:06
 * Updated in $/source/D5/p0dbctrl
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/08   Time: 23:06
 * Created in $/source/p0control/p0dbCtrl
 * 新規作成
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,
  s0Collection,
  s0TreeFilterMaker,
  s0CtrlEventSnatcher,
  s0CtrlDistiller;

type
  K0FilterValueKind = (k0fvkInteger, k0fvkString);

type
  Ts0DSFilterItems = class;

  Ts0DSFilterItem = class(Ts0TreeFilterItem)
  private
    FAutoLoadValue: Boolean;
    FCheckEventListener: Ts0CtrlEventListener;
    FCtrlEventListener: Ts0CtrlEventListener;
    FEnabledControl: TControl;
    FModifyEvents: K0CtrlEventTypeSet;
    FValueControl: TControl;
    FValueKind: K0FilterValueKind;
    procedure SetValueControl(const Value: TControl);
    procedure SetValueKind(const Value: K0FilterValueKind);
    procedure SetAutoLoadValue(const Value: Boolean);
    procedure SetModifyEvents(const Value: K0CtrlEventTypeSet);
    procedure SetEnabledControl(const Value: TControl);
    function GetSubItems: Ts0DSFilterItems;
    procedure SetSubItems(const Value: Ts0DSFilterItems);
  protected
    procedure LoadValueFromCtrl;
    procedure EnabledCtrlChecked;
    function NewSubCollection: Ts0Collection; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property AutoLoadValue: Boolean read FAutoLoadValue write SetAutoLoadValue default True;
    property EnabledControl: TControl read FEnabledControl write SetEnabledControl;
    property ModifyEvents: K0CtrlEventTypeSet read FModifyEvents write SetModifyEvents;
    property ValueControl: TControl read FValueControl write SetValueControl;
    property ValueKind: K0FilterValueKind read FValueKind write SetValueKind default k0fvkInteger;
    property SubItems: Ts0DSFilterItems read GetSubItems write SetSubItems;
  end;

  Ts0DSFilterItems = class(Ts0TreeFilterItems)
  private
    function GetItems(const Index: Integer): Ts0DSFilterItem;
    procedure SetItems(const Index: Integer; const Value: Ts0DSFilterItem);
  public
    property Items[const Index: Integer]: Ts0DSFilterItem read GetItems write SetItems; default;
  end;

type
  Ts0DSFilter = class(Ts0TreeFilterMaker)
  private
    FTarget: TDataSet;
    FAutoRefresh: Boolean;
    procedure SetTarget(const Value: TDataSet);
    procedure SetAutoRefresh(const Value: Boolean);
    function GetItems: Ts0DSFilterItems;
    procedure SetItems(const Value: Ts0DSFilterItems);
  protected
    procedure DoUpdateItem; override;
    function NewItems: Ts0TreeFilterItems; override;
  public
    procedure UpdateDSFilter;
  published
    property AutoRefresh: Boolean read FAutoRefresh write SetAutoRefresh default False;
    property Target: TDataSet read FTarget write SetTarget;
    property Items: Ts0DSFilterItems read GetItems write SetItems;
  end;

type
  Es0DSFilterException = class(Exception);

implementation

uses
  StdCtrls,
  s0DataAccessor;

type
  T9DSFICtrlEventListener = class(Ts0CtrlEventListener)
  private
    FOwnerItem: Ts0DSFilterItem;
  public
    procedure CtrlOnChange(Sender: TObject); override;
    procedure CtrlOnClick(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); override;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
  end;

{ T9DSFICtrlEventListener }

procedure T9DSFICtrlEventListener.CtrlOnChange(Sender: TObject);
begin
  if k0cetOnChange in FOwnerItem.ModifyEvents then
    FOwnerItem.LoadValueFromCtrl;
end;

procedure T9DSFICtrlEventListener.CtrlOnClick(Sender: TObject);
begin
  if k0cetOnClick in FOwnerItem.ModifyEvents then
    FOwnerItem.LoadValueFromCtrl;
end;

procedure T9DSFICtrlEventListener.CtrlOnExit(Sender: TObject);
begin
  if k0cetOnExit in FOwnerItem.ModifyEvents then
    FOwnerItem.LoadValueFromCtrl;
end;

procedure T9DSFICtrlEventListener.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key <> #13 then Exit;
  if k0cetOnPressEnter in FOwnerItem.ModifyEvents then
    FOwnerItem.LoadValueFromCtrl;
end;

procedure T9DSFICtrlEventListener.CtrlOnKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if k0cetOnKeyUp in FOwnerItem.ModifyEvents then
    FOwnerItem.LoadValueFromCtrl;
end;

type
  T9DSFICheckEventListener = class(Ts0CtrlEventListener)
  private
    FOwnerItem: Ts0DSFilterItem;
  public
    procedure CtrlOnClick(Sender: TObject); override;
  end;

{ T9DSFICheckEventListener }

procedure T9DSFICheckEventListener.CtrlOnClick(Sender: TObject);
begin
  FOwnerItem.EnabledCtrlChecked;
end;

{ Ts0DSFilterItem }

constructor Ts0DSFilterItem.Create(ACollection: TCollection);
begin
  FCheckEventListener := T9DSFICheckEventListener.Create;
  T9DSFICheckEventListener(FCheckEventListener).FOwnerItem := Self;
  FCtrlEventListener := T9DSFICtrlEventListener.Create;
  T9DSFICtrlEventListener(FCtrlEventListener).FOwnerItem := Self;
  inherited Create(ACollection);
  FValueKind := k0fvkInteger;
  FAutoLoadValue := True;
end;

destructor Ts0DSFilterItem.Destroy;
begin
  FreeAndNil(FCtrlEventListener);
  FreeAndNil(FCheckEventListener);
  inherited;                     
end;

procedure Ts0DSFilterItem.EnabledCtrlChecked;
var
  acsr: Ts0DataAccessor;
begin
  if FEnabledControl = nil then Exit;
  acsr := Ts0CtrlDistillBroker.GetAccessor(FEnabledControl);
  Self.Enabled := acsr.AsBoolean;
  LoadValueFromCtrl;
  if OwnerComponent is Ts0DSFilter then
    Ts0DSFilter(OwnerComponent).UpdateDSFilter;
end;

function Ts0DSFilterItem.GetSubItems: Ts0DSFilterItems;
begin
  Result := Ts0DSFilterItems(inherited SubItems);
end;

procedure Ts0DSFilterItem.LoadValueFromCtrl;
var
  acsr: Ts0DataAccessor;
begin
  if FValueControl = nil then Exit;
  acsr := Ts0CtrlDistillBroker.GetAccessor(FValueControl);
  case FValueKind of
    k0fvkInteger: Self.Value := IntToStr( acsr.AsInteger );
    k0fvkString : Self.Value := acsr.AsString;
  end;
end;

function Ts0DSFilterItem.NewSubCollection: Ts0Collection;
begin
  Result := Ts0DSFilterItems.Create(Self, Ts0DSFilterItem);
end;

procedure Ts0DSFilterItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FEnabledControl = AComponent then
    FEnabledControl := nil;
  if FValueControl = AComponent then
    FValueControl := nil;
end;

resourcestring
  c9ErrMsg_CtrlIsNotTargetOfDistiller = 'このコントロールを指定することはできません: %s';

procedure Ts0DSFilterItem.SetAutoLoadValue(const Value: Boolean);
begin
  FAutoLoadValue := Value;
end;

procedure Ts0DSFilterItem.SetEnabledControl(const Value: TControl);
begin
  if FEnabledControl = Value then Exit;
  if Value <> nil then
    if not(Value is TCustomCheckBox) then
      Exit;
  FEnabledControl := Value;
  Changed(False);
  if csDesigning in OwnerComponent.ComponentState then Exit;
  if FEnabledControl = nil then
    Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FCheckEventListener)
  else
    Ts0CtrlEventSnatcher.Instance.RegisterListener(FEnabledControl, FCheckEventListener);
end;

procedure Ts0DSFilterItem.SetModifyEvents(const Value: K0CtrlEventTypeSet);
begin
  FModifyEvents := Value;
end;

procedure Ts0DSFilterItem.SetSubItems(const Value: Ts0DSFilterItems);
begin
  inherited SubItems := Value;
end;

procedure Ts0DSFilterItem.SetValueControl(const Value: TControl);
begin
  if Value <> nil then
    if not Ts0CtrlDistillBroker.IsTarget(Value) then
      raise Es0DSFilterException.CreateFmt(c9ErrMsg_CtrlIsNotTargetOfDistiller, [Value.Name]);
  FValueControl := Value;
  if [csLoading, csReading] * OwnerComponent.ComponentState = [] then
  begin
    if FValueControl <> nil then
      FModifyEvents := Ts0CtrlDistillBroker.GetUpdateEvents(FValueControl)
    else
      FModifyEvents := [];
  end;
  Changed(False);
  if csDesigning in OwnerComponent.ComponentState then Exit;
  if FValueControl = nil then
    Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FCtrlEventListener)
  else
    Ts0CtrlEventSnatcher.Instance.RegisterListener(FValueControl, FCtrlEventListener);
end;

procedure Ts0DSFilterItem.SetValueKind(const Value: K0FilterValueKind);
begin
  FValueKind := Value;
  Changed(False);
end;

{ Ts0DSFilterItems }

function Ts0DSFilterItems.GetItems(const Index: Integer): Ts0DSFilterItem;
begin
  Result := Ts0DSFilterItem(inherited Items[Index]);
end;

procedure Ts0DSFilterItems.SetItems(const Index: Integer;
  const Value: Ts0DSFilterItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0DSFilter }

procedure Ts0DSFilter.DoUpdateItem;
begin
  inherited;
  if FAutoRefresh then
    UpdateDSFilter;
end;

function Ts0DSFilter.GetItems: Ts0DSFilterItems;
begin
  Result := Ts0DSFilterItems(inherited Items)
end;

function Ts0DSFilter.NewItems: Ts0TreeFilterItems;
begin
  Result := Ts0DSFilterItems.Create(Self, Ts0DSFilterItem);
end;

procedure Ts0DSFilter.SetAutoRefresh(const Value: Boolean);
begin
  FAutoRefresh := Value;
  if FAutoRefresh then DoUpdateItem;
end;

procedure Ts0DSFilter.SetItems(const Value: Ts0DSFilterItems);
begin
  inherited Items := Value;
end;

procedure Ts0DSFilter.SetTarget(const Value: TDataSet);
begin
  FTarget := Value;
  if FAutoRefresh then DoUpdateItem;
end;

procedure Ts0DSFilter.UpdateDSFilter;
begin
  if csDesigning in Self.ComponentState then Exit;
  if FTarget = nil then Exit;
  FTarget.Filter := Self.Filter;
  if not FTarget.Filtered then
    FTarget.Filtered := True;
end;

initialization
{$IFNDEF VER130}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(Ts0DSFilterItem, TControl);
  GroupDescendentsWith(Ts0DSFilterItems, TControl);
  GroupDescendentsWith(Ts0DSFilter, TControl);
{$ENDIF}

end.
