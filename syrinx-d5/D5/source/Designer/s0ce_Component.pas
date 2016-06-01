{-----------------------------------------------------------------------------
 Unit Name: s0ce_Component
 Author:    akima
 Purpose:
 TestCase: tc_s0ce_Component
 See: 
 $History: s0ce_Component.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/13   Time: 0:13
 * Updated in $/source/D6VCLIntegrated/Designer
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/13   Time: 0:06
 * Updated in $/source/D5Integrated/Designer
 * IDesignerSelectionsのインタフェースがVER130とVER140で結構ちがうので、対
 * 応した。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/02/12   Time: 23:43
 * Updated in $/source/D6VCLIntegrated/Designer
 * RegisterComponentEditorProcをフックする処理をすべて削除。断念した。
 * コンポーネントエディタを継承する方法を確定
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/11   Time: 19:10
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/11   Time: 17:47
 * Updated in $/source/D5Integrated/Designer
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/08   Time: 18:13
 * Updated in $/source/D6VCLIntegrated/Designer
 * もうちょっとでうまくいきそうなんだけど・・・・
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/08   Time: 5:04
 * Updated in $/source/D6VCLIntegrated/Designer
 * 「関連するコンポーネントを選択'」を追加
-----------------------------------------------------------------------------}
unit s0ce_Component;

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
  Menus,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
  Menus,
  DesignMenus,
{$ENDIF}
  s0DesignIntf,
  Forms;

type
  Ts0ce_Component = class(TDefaultEditor)
  private
    procedure ImplExecuteVerb(Index: Integer);
    function ImplGetVerb(Index: Integer): string;
    function ImplGetVerbCount: Integer;
    procedure ImplPrepareItem(Index: Integer; const AItem: T0DesignMenu);
  protected
    procedure EditCollection(Sender: TObject);
    procedure SelectRelativeComponents;
  public
    constructor Create(AComponent: TComponent; ADesigner: I0Designer); override;
    destructor Destroy; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: T0DesignMenu); override;
  end;

implementation

uses
  Contnrs,
  s0TypInfoWrapper,
  s0ComponentHelper,
  s0StringHelper,
  s0fObjEditor,
  s0ce_fCompoPropFilter;

{ Ts0ce_Component }

constructor Ts0ce_Component.Create(AComponent: TComponent;
  ADesigner: I0Designer);
begin
  inherited Create(AComponent, ADesigner);
end;

destructor Ts0ce_Component.Destroy;
begin
  inherited;
end;

procedure Ts0ce_Component.EditCollection(Sender: TObject);
var
  acsr: Ts0RTTIPublishedAccessor;
  m: TMenuItem;
  pn: string;
begin
  if not (Sender is TMenuItem) then Exit;
  m := TMenuItem(Sender);
  acsr := Ts0RTTIPublishedAccessor.Create(Component);
  try
    if GetClass(Component.ClassName) = nil then
      RegisterClass( TComponentClass(Component.ClassType) );
    pn := Ts0StringHelper.DeleteChar(m.Caption, '&');
    if not acsr.PropertyExists(pn) then Exit;
    Ts0frmObjEditor.ShowEditorModal(acsr.ObjectProp[pn]);
  finally
    FreeAndNil(acsr);
  end;
end;

procedure Ts0ce_Component.ExecuteVerb(Index: Integer);
begin
  ImplExecuteVerb(Index);
end;

function Ts0ce_Component.GetVerb(Index: Integer): string;
begin
  Result := ImplGetVerb(Index);
end;

function Ts0ce_Component.GetVerbCount: Integer;
begin
  Result := ImplGetVerbCount;
end;

procedure Ts0ce_Component.ImplExecuteVerb(Index: Integer);
  procedure ShowCompoPropFilter;
  var
    frm: Ts0ce_frmCompoPropFilter;
  begin
    frm := Ts0ce_frmCompoPropFilter.Create(nil);
    try
      frm.Target := Ts0ComponentHelper.GetRootOwner(Component);
      frm.ShowModal;
      if Designer <> nil then
        Designer.Modified;
    finally
      FreeAndNil(frm);
    end;
  end;
begin
  case Index of
    0: ShowCompoPropFilter;
    1: SelectRelativeComponents;
    2: ; //do nothing
  end;
end;

resourcestring
  c9Verb_EditCompoProp = 'プロパティをまとめて編集';
  c9Verb_SelectRelativeComponents = '関連するコンポーネントを選択';
  c9Verb_EditCollectionProp = 'コレクションを編集';

function Ts0ce_Component.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := c9Verb_EditCompoProp;
    1: Result := c9Verb_SelectRelativeComponents;
    2: Result := c9Verb_EditCollectionProp;
  end;
end;

function Ts0ce_Component.ImplGetVerbCount: Integer;
begin
  Result := 3;
end;

procedure Ts0ce_Component.ImplPrepareItem(Index: Integer; const AItem:
  T0DesignMenu);

  procedure AddMenuItem(const ACaption: WideString; AShortCut: TShortCut;
      AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent = nil;
      hCtx: THelpContext = 0; const AName: string = '');
{$IFDEF VER130}
  var
    newItem: TMenuItem;
{$ENDIF}
  begin
{$IFDEF VER130}
    newItem := TMenuItem.Create(AItem);
    newItem.Caption := ACaption;
    newItem.ShortCut := AShortCut;
    newItem.Checked := AChecked;
    newItem.Enabled := AEnabled;
    newItem.OnClick := AOnClick;
    newItem.HelpContext := hCtx;
    newItem.Name := AName;
    AItem.Add(newItem);
{$ELSE}
    AItem.AddItem(ACaption, AShortCut, AChecked, AEnabled, AOnClick, hCtx, AName);
{$ENDIF}
  end;

  procedure PrepareCollectionItems;
  var
    acsr: Ts0RTTIPublishedAccessor;
    i: Integer;
    sl: TStringList;
    obj: TObject;
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(Component);
    try
      sl := TStringList.Create;
      try
        acsr.RTTINavigator.GetPropNamesByClass(sl, TCollection);
        for i := 0 to sl.Count -1 do
        begin
          obj := acsr.ObjectProp[ sl.Strings[i] ];
          if not(obj is TCollection) then Continue;
          AddMenuItem(sl.Strings[i], 0, False, True, EditCollection);
        end;
      finally
        FreeAndNil(sl);
      end;
    finally
      FreeAndNil(acsr);
    end;
    AItem.Enabled := AItem.Count > 0;
  end;
begin
  case Index of
//    0: if AItem.HasParent then AItem.Parent.InsertLine(AItem.MenuIndex);
    2: PrepareCollectionItems;
  end;
end;

procedure Ts0ce_Component.PrepareItem(Index: Integer; const AItem: T0DesignMenu);
begin
  if Index < ImplGetVerbCount then
    ImplPrepareItem(Index, AItem)
  else
    inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

procedure Ts0ce_Component.SelectRelativeComponents;
var
  acsr: Ts0RTTIPublishedAccessor;
  i: Integer;
  sl: TStrings;
  obj: TObject;
  selList: IDesignerSelections;
begin
  if Designer = nil then Exit;
  if Component = nil then Exit;
  selList := CreateSelectionList;
  acsr := Ts0RTTIPublishedAccessor.Create(Component);
  try
    sl := TStringList.Create;
    try
      acsr.RTTINavigator.GetPropNamesByClass(sl, TComponent);
      for i := 0 to sl.Count -1 do
      begin
        obj := acsr.ObjectProp[ sl.Strings[i] ];
        if obj = nil then Continue;
        if not(obj is TComponent) then Continue;
        {$IFDEF VER130}
          selList.Add( MakeIPersistent(TComponent(obj)) );
        {$ELSE}
          selList.Add( TComponent(obj) );
        {$ENDIF}
      end;
      Designer.SetSelections(selList);
    finally
      FreeAndNil(sl);
    end;
  finally
    FreeAndNil(acsr);
  end;
end;

end.
