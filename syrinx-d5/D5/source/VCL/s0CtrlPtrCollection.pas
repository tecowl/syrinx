unit s0CtrlPtrCollection;
{
$History: s0CtrlPtrCollection.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 *
 * *****************  Version 5  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマ ンド追加
}

interface

uses
  SysUtils, Classes, Controls,
  s0VCLClasses,
  s0Collection;

type
  Ts0CtrlPtrCollectionItem = class(Ts0VCLCollectionItem)
  private
    FControl: TControl;
    procedure SetControl(const Value: TControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Control: TControl read FControl write SetControl;
  end;

type
  Ts0CtrlPtrCollection = class(Ts0VCLCollection)
  public
    function IndexOfCtrl(AControl: TControl): Integer; reintroduce; virtual;
    function AddCtrl(AControl: TControl): Ts0CtrlPtrCollectionItem; reintroduce;
      virtual;
  end;

implementation

{ Ts0CtrlPtrCollectionItem }

procedure Ts0CtrlPtrCollectionItem.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is Ts0CtrlPtrCollectionItem) then
    Exit;
  Control := Ts0CtrlPtrCollectionItem(Source).Control;
end;

procedure Ts0CtrlPtrCollectionItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then
    Exit;
  if FControl = AComponent then
  begin
    GetOwnerComponent.RemoveFreeNotification(AComponent);
    FControl := nil;
  end;
end;

procedure Ts0CtrlPtrCollectionItem.SetControl(const Value: TControl);
begin
  FControl := Value;
  if FControl = GetOwnerComponent then
  begin
    GetOwnerComponent.FreeNotification(FControl);
    FControl := nil;
  end;
end;

{ Ts0CtrlPtrCollection }

function Ts0CtrlPtrCollection.AddCtrl(
  AControl: TControl): Ts0CtrlPtrCollectionItem;
begin
  Result := Ts0CtrlPtrCollectionItem(inherited Add);
  Result.Control := AControl;
end;

function Ts0CtrlPtrCollection.IndexOfCtrl(AControl: TControl): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count - 1 do
    if Ts0CtrlPtrCollectionItem(Items[i]).Control = AControl then
    begin
      Result := i;
      Exit;
    end;
end;

end.

