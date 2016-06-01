{-----------------------------------------------------------------------------
 Unit Name: s0ce_ObjPropStocker
 Author:    akima
 Purpose:
 TestCase: tc_s0ce_ObjPropStocker
 $History: s0ce_ObjPropStocker.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/13   Time: 0:06
 * Updated in $/source/D5Integrated/Designer
 * IDesignerSelectionsのインタフェースがVER130とVER140で結構ちがうので、対
 * 応した。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/12   Time: 23:44
 * Updated in $/source/D6VCLIntegrated/Designer
 * コンポーネントエディタを継承する方法を確定
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/11   Time: 3:34
 * Created in $/source/D5Integrated/Designer
-----------------------------------------------------------------------------}

unit s0ce_ObjPropStocker;

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
  Menus,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
  DesignMenus,
{$ENDIF}
  s0DesignIntf,
  s0ce_Component,
  s0ObjPropStocker;

type
  Ts0ce_ObjPropStocker = class(Ts0ce_Component)
  private
    procedure ImplExecuteVerb(Index: Integer);
    function ImplGetVerb(Index: Integer): string;
    function ImplGetVerbCount: Integer;
    procedure ImplPrepareItem(Index: Integer; const AItem: T0DesignMenu);
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: T0DesignMenu); override;
  end;


type
  Ts0pe_ObjPropStockerItemTargetProperty = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

procedure Register;

implementation

uses
  s0TypInfoWrapper,
  Forms;

procedure Register;
begin
  RegisterComponentEditor(Ts0ObjPropStocker, Ts0ce_ObjPropStocker);
  RegisterPropertyEditor(TypeInfo(string), Ts0ObjPropStockerItem,
    'TargetProperty', Ts0pe_ObjPropStockerItemTargetProperty);
end;

{ Ts0ce_ObjPropStocker }

procedure Ts0ce_ObjPropStocker.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_ObjPropStocker.GetVerb(Index: Integer): string;
begin
  Result := '';
  if Index < ImplGetVerbCount then
  begin
    Result := ImplGetVerb(Index);
  end
  else
    if ClassType <> Ts0ce_Component then
      Result := inherited GetVerb(Index - ImplGetVerbCount)
end;

function Ts0ce_ObjPropStocker.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_ObjPropStocker.ImplExecuteVerb(Index: Integer);
  procedure AddOnNotFound(AStocker: Ts0ObjPropStocker; AProp, ADefault: string);
  var
    item: Ts0ObjPropStockerItem;
  begin
    item := AStocker.Items.FindItem(AStocker.Owner, AProp);
    if item = nil then
    begin
      item := AStocker.Items.AddItem;
      item.TargetComponent := AStocker.Owner;
      item.TargetProperty := AProp;
    end;
    item.AccessLevel := k0ialForm;
    item.DefaultValue := ADefault;
  end;
  procedure AddPositionItems(AStocker: Ts0ObjPropStocker);
  var
    frm: TForm;
  begin
    if not(AStocker.Owner is TForm) then Exit;
    frm := TForm(AStocker.Owner);
    AddOnNotFound(AStocker, 'Left'  , IntToStr(frm.Left  ) );
    AddOnNotFound(AStocker, 'Top'   , IntToStr(frm.Top   ) );
    AddOnNotFound(AStocker, 'Height', IntToStr(frm.Height) );
    AddOnNotFound(AStocker, 'Width' , IntToStr(frm.Width ) );
    Designer.Modified;
  end;
var
  stocker: Ts0ObjPropStocker;
begin
  if not(Component is Ts0ObjPropStocker) then Exit;
  stocker := Ts0ObjPropStocker(Component);
  case Index of
    0: AddPositionItems(stocker);
  end;
end;

resourcestring
  c9Verb_AddPositionItems = 'フォーム位置保存項目追加';

function Ts0ce_ObjPropStocker.ImplGetVerb(Index: Integer): string;
begin
  Result := c9Verb_AddPositionItems;
end;

function Ts0ce_ObjPropStocker.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Ts0ce_ObjPropStocker.ImplPrepareItem(Index: Integer; const AItem:
  T0DesignMenu);
begin
  case Index of
    0: AItem.Enabled := Component.Owner is TForm;
  end;
end;

procedure Ts0ce_ObjPropStocker.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  if Index < ImplGetVerbCount then
    ImplPrepareItem(Index, AItem)
  else
    inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

{ Ts0pe_ObjPropStockerItemTargetProperty }

function Ts0pe_ObjPropStockerItemTargetProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

procedure Ts0pe_ObjPropStockerItemTargetProperty.GetValues(
  Proc: TGetStrProc);

  function GetSelectedItem: Ts0ObjPropStockerItem;
  var
    lst: IDesignerSelections;
    item: TPersistent;
  begin
    Result := nil;
    lst := CreateSelectionList;
    Designer.GetSelections(lst);
    if lst.Count < 1 then Exit;
{$IFDEF VER130}
    item := ExtractPersistent( lst.Items[0] );
{$ELSE}
    item := lst.Items[0];
{$ENDIF}
    if item is Ts0ObjPropStockerItem then
      Result := Ts0ObjPropStockerItem(item);
  end;
var
  sel: Ts0ObjPropStockerItem;
  acsr: Ts0RTTIPublishedAccessor;
  props: Ts0RTTIProps;
  i: Integer;
  pn: string;
begin
  sel := GetSelectedItem;
  if sel = nil then Exit;
  if sel.TargetComponent = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(sel.TargetComponent);
  try
    if acsr.RTTINavigator = nil then Exit;
    props := acsr.RTTINavigator.Props;
    for i := 0 to props.Count -1 do
    begin
      pn := props.Props[i].PropName;
      if acsr.EnabledAsString(pn) then
        Proc( pn );
    end;
  finally
    FreeAndNil(acsr);
  end;
end;

procedure Ts0pe_ObjPropStockerItemTargetProperty.SetValue(
  const Value: string);
begin
  inherited SetValue(Value);
end;

end.
