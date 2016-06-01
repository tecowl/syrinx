unit s0ModeController;
{
$History: s0ModeController.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/13   Time: 23:26
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
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0ctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/25   Time: 22:13
 * Updated in $/source/D5/p0ctrl
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/17   Time: 18:23
 * Created in $/source/D5/p0ctrl
 * 新規作成
 * 
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/08/17   Time: 18:21
 * Created in $/Projects/Pleiades/source/D5/p0ctrl
}

interface

uses
  {Windows, Messages, }SysUtils, Classes, {Graphics, }Controls, {Forms, Dialogs,}
  s0VCLClasses,
  s0Collection;

type
  Ts0ModeCtrlItem = class(Ts0VCLCollectionItem)
  private
    FBufEnabled: Boolean;
    FBufReadOnly: Boolean;
    FBufVisible: Boolean;
    FEnabled: Boolean;
    FReadOnly: Boolean;
    FVisible: Boolean;
    FTarget: TControl;
    procedure SetTarget(const Value: TControl);
    procedure SetEnabled(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
    procedure Activate;
    procedure Deactivate;
    function GetDisplayName: string; override;
    procedure SetEnabledOfParentCtrlItem;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Target: TControl read FTarget write SetTarget;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

type
  Ts0ModeCtrlItems = class(Ts0VCLCollection)
  private
    function GetItem(const Index: Integer): Ts0ModeCtrlItem;
    procedure SetItem(const Index: Integer; const Value: Ts0ModeCtrlItem);
  protected
    procedure Activate;
    procedure Deactivate;
  public
    function Add(ACtrl: TControl): Ts0ModeCtrlItem;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function ItemByCtrl(AControl: TControl): Ts0ModeCtrlItem;
    property Items[const Index: Integer]: Ts0ModeCtrlItem read GetItem write SetItem; default;
  end;

type
  Ts0ModeItem = class(Ts0VCLCollectionItem)
  private
    FModeName: string;
    FCtrlItems: Ts0ModeCtrlItems;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    procedure SetModeName(const Value: string);
    procedure SetCtrlItems(const Value: Ts0ModeCtrlItems);
    function GetActive: Boolean;
    procedure DoActivate;
    procedure DoDeactivate;
  protected
    function GetIdentifier: string; override;
    function GetSubCollection: Ts0Collection; override;
    function NewCtrlItems: Ts0ModeCtrlItems; virtual;
    procedure Activate;
    procedure Deactivate;
    procedure CreateCtrlItems;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Active: Boolean read GetActive;
  published
    property ModeName: string read FModeName write SetModeName;
    property CtrlItems: Ts0ModeCtrlItems read FCtrlItems write SetCtrlItems;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
  end;

type
  Ts0ModeItems = class(Ts0VCLCollection)
  private
    function GetItem(const Index: Integer): Ts0ModeItem;
    procedure SetItem(const Index: Integer; const Value: Ts0ModeItem);
  public
    property Items[const Index: Integer]: Ts0ModeItem read GetItem write SetItem; default;
  end;



type
  Ts0ModeController = class(Ts0VCLComponent)
  private
    FActiveMode: Ts0ModeItem;
    FModes: Ts0ModeItems;
    function GetActiveModeIndex: Integer;
    procedure SetActiveModeIndex(const Value: Integer);
    procedure SetActiveMode(const Value: Ts0ModeItem);
    procedure SetModes(const Value: Ts0ModeItems);
  protected
    procedure Loaded; override;
    function NewModes: Ts0ModeItems; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ActiveMode: Ts0ModeItem read FActiveMode write SetActiveMode;
  published
    property ActiveModeIndex: Integer read GetActiveModeIndex write SetActiveModeIndex;
    property Modes: Ts0ModeItems read FModes write SetModes;
  end;

implementation

uses
  Forms,
  s0CtrlDistiller,
  s0InputStyle;

{ Ts0ModeCtrlItem }

procedure Ts0ModeCtrlItem.Activate;
var
  inpCtrl: Ts0InputStyle;
begin
  FBufEnabled := FTarget.Enabled;
  FTarget.Enabled := FEnabled;
  //
  FBufReadOnly := FTarget.Enabled;
  inpCtrl := Ts0CtrlDistillBroker.GetInputControl(FTarget);
  if inpCtrl <> nil then
    FTarget.Enabled := inpCtrl.ReadOnly;
  //
  FBufVisible := FTarget.Visible;
  FTarget.Visible := FVisible;
end;

procedure Ts0ModeCtrlItem.Assign(Source: TPersistent);
var
  src: Ts0ModeCtrlItem;
begin
  inherited;
  if not(Source is Ts0ModeCtrlItem) then Exit;
  src := Ts0ModeCtrlItem(Source);
  Self.Enabled := src.Enabled;
  Self.ReadOnly := src.ReadOnly;
end;

constructor Ts0ModeCtrlItem.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
  FReadOnly := False;
  FVisible := True;
end;

procedure Ts0ModeCtrlItem.Deactivate;
var
  inpCtrl: Ts0InputStyle;
begin
  FTarget.Enabled := FBufEnabled;
  //
  inpCtrl := Ts0CtrlDistillBroker.GetInputControl(FTarget);
  if inpCtrl <> nil then
    inpCtrl.ReadOnly := FBufReadOnly;
  //
  FTarget.Visible := FBufVisible;
end;

function Ts0ModeCtrlItem.GetDisplayName: string;
  function BoolToStr(Value: Boolean): string;
  begin
    if Value then
      Result := 'T'
    else
      Result := 'F';
  end;
const
  c9DispNameFmt = 'E:%s R:%s V:%s %s';
begin
  if FTarget <> nil then
    Result := FTarget.Name
  else
    Result := inherited GetDisplayName;

  Result := Format(c9DispNameFmt, [
    BoolToStr(FEnabled),
    BoolToStr(FReadOnly),
    BoolToStr(FVisible),
    Result
  ]);
end;

procedure Ts0ModeCtrlItem.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  SetEnabledOfParentCtrlItem;
  Changed(True);
end;

procedure Ts0ModeCtrlItem.SetEnabledOfParentCtrlItem;
var
  ctrl: TControl;
  Items: Ts0ModeCtrlItems;
  item: Ts0ModeCtrlItem;
begin
  if not FEnabled then Exit;
  if FTarget = nil then Exit;
  Items := Ts0ModeCtrlItems(Collection);
  ctrl := FTarget.Parent;
  while ctrl <> nil do
  begin
    item := Items.ItemByCtrl(ctrl);
    if item <> nil then
      item.Enabled := True;
    ctrl := ctrl.Parent;
  end;
end;

procedure Ts0ModeCtrlItem.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
  Changed(True);
end;

procedure Ts0ModeCtrlItem.SetTarget(const Value: TControl);
begin
  FTarget := Value;
  Changed(False);
end;

procedure Ts0ModeCtrlItem.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

{ Ts0ModeCtrlItems }

procedure Ts0ModeCtrlItems.Activate;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].Activate;
end;

function Ts0ModeCtrlItems.Add(ACtrl: TControl): Ts0ModeCtrlItem;
begin
  Result := Ts0ModeCtrlItem(inherited Add);
  Result.Target := ACtrl;
end;

procedure Ts0ModeCtrlItems.Deactivate;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
    Items[i].Deactivate;
end;

function Ts0ModeCtrlItems.GetItem(const Index: Integer): Ts0ModeCtrlItem;
begin
  Result := Ts0ModeCtrlItem(inherited Items[Index]);
end;

function Ts0ModeCtrlItems.ItemByCtrl(AControl: TControl): Ts0ModeCtrlItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if Items[i].Target = AControl then
    begin
      Result := Items[i];
      Exit;
    end;
end;

procedure Ts0ModeCtrlItems.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  item: Ts0ModeCtrlItem;
begin
  if AComponent is TControl then
  begin
    item := ItemByCtrl(TControl(AComponent));
    if (item <> nil) and (Operation = opRemove) then
    begin
      Self.Remove(item);
    end
    else
    if (item = nil) and (Operation = opInsert) then
      Self.Add(TControl(AComponent));
  end;
  inherited;
end;

procedure Ts0ModeCtrlItems.SetItem(const Index: Integer;
  const Value: Ts0ModeCtrlItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0ModeItem }

procedure Ts0ModeItem.Activate;
begin
  DoActivate;
  FCtrlItems.Activate;
end;

procedure Ts0ModeItem.Assign(Source: TPersistent);
var
  src: Ts0ModeItem;
begin
  inherited;
  if not(Source is Ts0ModeItem) then Exit;
  src := Ts0ModeItem(Source);
  Self.ModeName := src.ModeName;
  Self.CtrlItems := src.CtrlItems;
end;

constructor Ts0ModeItem.Create(ACollection: TCollection);
begin
  FCtrlItems := NewCtrlItems;
  inherited;
  CreateCtrlItems;
end;

procedure Ts0ModeItem.CreateCtrlItems;
var
  frm: TCustomForm;
  i: Integer;
begin
  FCtrlItems.Clear;
  if OwnerComponent = nil then Exit;
  if not(OwnerComponent.Owner is TCustomForm) then Exit;
  frm := TCustomForm(OwnerComponent.Owner);
  for i := 0 to frm.ComponentCount -1 do
    if frm.Components[i] is TControl then
      FCtrlItems.Add( TControl(frm.Components[i]) );
end;

procedure Ts0ModeItem.Deactivate;
begin
  DoDeactivate;
  FCtrlItems.Deactivate;
end;

destructor Ts0ModeItem.Destroy;
begin
  FreeAndNil(FCtrlItems);
  inherited;
end;

procedure Ts0ModeItem.DoActivate;
begin
  if Assigned(FOnActivate) then
    FOnActivate(Self);
end;

procedure Ts0ModeItem.DoDeactivate;
begin
  if Assigned(FOnDeactivate) then
    FOnDeactivate(Self);
end;

function Ts0ModeItem.GetActive: Boolean;
begin
  Result := False;
  if not(OwnerComponent is Ts0ModeController) then Exit;
  Result := (Ts0ModeController(OwnerComponent).ActiveMode = Self);
end;

function Ts0ModeItem.GetIdentifier: string;
begin
  Result := FModeName;
end;

function Ts0ModeItem.GetSubCollection: Ts0Collection;
begin
  Result := FCtrlItems;
end;

function Ts0ModeItem.NewCtrlItems: Ts0ModeCtrlItems;
begin
  Result := Ts0ModeCtrlItems.Create(Self, Ts0ModeCtrlItem);
end;

procedure Ts0ModeItem.SetCtrlItems(const Value: Ts0ModeCtrlItems);
begin
  FCtrlItems.Assign(Value);
end;

procedure Ts0ModeItem.SetModeName(const Value: string);
begin
  FModeName := Value;
end;

{ Ts0ModeItems }

function Ts0ModeItems.GetItem(const Index: Integer): Ts0ModeItem;
begin
  Result := Ts0ModeItem( inherited Items[Index] );
end;

procedure Ts0ModeItems.SetItem(const Index: Integer; const Value: Ts0ModeItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0ModeController }

constructor Ts0ModeController.Create(AOwner: TComponent);
begin
  FModes := NewModes; 
  inherited;
end;

destructor Ts0ModeController.Destroy;
begin
  FreeAndNil(FModes);
  inherited;         
end;

function Ts0ModeController.GetActiveModeIndex: Integer;
begin
  if FActiveMode = nil then
    Result := -1
  else
    Result := FActiveMode.Index;
end;

procedure Ts0ModeController.Loaded;
begin
  inherited;
  if csDesigning in Self.ComponentState then Exit;
  if ActiveMode <> nil then
    ActiveMode.Activate;
end;

function Ts0ModeController.NewModes: Ts0ModeItems;
begin
  Result := Ts0ModeItems.Create(Self, Ts0ModeItem);
end;

procedure Ts0ModeController.SetActiveMode(const Value: Ts0ModeItem);
begin
  if FActiveMode <> nil then FActiveMode.Deactivate;
  FActiveMode := Value;
  if FActiveMode <> nil then FActiveMode.Activate;
end;

procedure Ts0ModeController.SetActiveModeIndex(const Value: Integer);
begin
  if (Value < 0) or (Value > FModes.Count -1) then
    ActiveMode := nil
  else
    ActiveMode := FModes.Items[Value];
end;

procedure Ts0ModeController.SetModes(const Value: Ts0ModeItems);
begin
  FModes.Assign(Value);
end;

end.
