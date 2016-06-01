unit s0pe_StockerItemDomainTarget;
{
$History: s0pe_StockerItemDomainTarget.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/06   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0core
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  c0SXInfoStocker;


type
  Ts0pe_StockerItemDomainTarget = class(TComponentProperty)
  protected
    FLastTarget: TComponent;
    procedure FinderOnMatch(Sender: TObject; AComponent: TComponent; var AMatch: Boolean);
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

implementation

uses
  Forms,
  Contnrs,
  s0Collection,
  s0ComponentVisitor
  ;

{ Ts0pe_StockerItemDomainTarget }

procedure Ts0pe_StockerItemDomainTarget.FinderOnMatch(Sender: TObject;
  AComponent: TComponent; var AMatch: Boolean);
begin
  AMatch := (Tc0SXInfoStocker.GetStockerClass(AComponent) <> nil);
end;

function Ts0pe_StockerItemDomainTarget.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

procedure Ts0pe_StockerItemDomainTarget.GetValues(Proc: TGetStrProc);
  procedure AddValues(AList: TComponentList);
  var
    i: Integer;
  begin
    if AList = nil then Exit;
    for i := 0 to AList.Count -1 do
    begin
      if AList.Items[i] = nil then Continue;
      Proc(AList.Items[i].Name);
    end;
  end;
  function GetTarget(AItem: TPersistent): TComponent;
  begin
    Result := nil;
    if AItem is Ts0CollectionItem then
      Result := GetTarget( Ts0CollectionItem(AItem).OwnerComponent )
    else
    if (AItem is TCustomForm) or (AItem is TDataModule) then
      Result := TComponent(AItem)
    else
    if AItem is TComponent then
      Result := TComponent(AItem).Owner;
  end;
var
  v: Ts0ComponentFinder;
  lst: T0DesignerSelections;
begin
  FLastTarget := nil;
  v := Ts0ComponentFinder.Create;
  try
    v.ExitOnFind := False;
    v.OnMatch := FinderOnMatch;
    v.Duplicates := dupIgnore;
    //
    lst := T0DesignerSelections.Create;
    try
      Designer.GetSelections(lst);
      if lst.Count > 0 then
      begin
        v.Target := GetTarget(lst.Items[0]);
        if v.Target <> nil then
          FLastTarget := v.Target;
        v.Execute;
      end;
    finally
      FreeAndNil(lst);
    end;
    AddValues(v.ResultList);
  finally
    FreeAndNil(v);
  end;
end;

procedure Ts0pe_StockerItemDomainTarget.SetValue(const Value: string);
  function GetStokerDomainItem: T0SXStockerItemDomain;
  var
    lst: T0DesignerSelections;
  begin
    Result := nil;
    lst := T0DesignerSelections.Create;
    try
      Designer.GetSelections(lst);
      if lst.Count < 1 then Exit;
      if lst.Items[0] is T0SXStockerItemDomain then
        Result := T0SXStockerItemDomain(lst.Items[0]);
    finally
      FreeAndNil(lst);
    end;
  end;
var
  selected: T0SXStockerItemDomain;
begin
  selected := GetStokerDomainItem;
  if FLastTarget <> nil then
    if Value = FLastTarget.Name then
    begin
      selected.DomainName := FLastTarget.Name;
      inherited SetValue('');
      Exit;
    end;

  inherited SetValue(Value);
end;

end.
 
