{-----------------------------------------------------------------------------
 Unit Name: s0ObjPropStocker
 Author:    akima
 Purpose:
 TestCase: tc_s0ObjPropStocker
 $History: s0ObjPropStocker.pas $
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/03/15   Time: 17:46
 * Updated in $/D5/source/Common
 * iniファイル読み込み時のバグ修正
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/12/10   Time: 16:13
 * Updated in $/source/D5Integrated
 * 存在しないセクション、エントリは読み込みせず、プロパティの値に反映しな
 * いようにした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/12/07   Time: 18:28
 * Updated in $/source/D5Integrated
 * 実行時パッケージに含まれうるユニットからDsgnIntfを削除。
 * それに関係するクラスなどは設計時用のパッケージにまとめた。
-----------------------------------------------------------------------------}

unit s0ObjPropStocker;

interface

uses
  SysUtils, Classes,
  s0Collection, s0Observer, s0ComponentEventWrapper;

type
  Ts0ObjPropStockerItem = class;

  K0ObjPropStockerItemEvent = procedure(Sender: Ts0ObjPropStockerItem;
    var AValue: string; var ACancel: Boolean) of object;

  K0ObjPropStockerItemGetLevelCaptionEvent = procedure(Sender: Ts0ObjPropStockerItem;
    var ALevelCaption: string) of object;

  K0ItemAccessLevel = (k0ialSystem, k0ialApplication, k0ialForm, k0ialInstance);

  K0ItemKeyType = (k0iktLoginUserName, k0iktComputerName,
  	k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance,
    k0iktCustom);
  K0ItemKeyTypeSet = set of K0ItemKeyType;

  Ts0ObjPropStockerItem = class(Ts0CollectionItem)
  private
    FTargetProperty: string;
    FTargetComponent: TComponent;
    FValue: string;
    FDefaultValue: string;
    FOnSetValueToLoad: K0ObjPropStockerItemEvent;
    FOnGetValueToSave: K0ObjPropStockerItemEvent;
    FTargetIsOwner: Boolean;
    FAccessLevel: K0ItemAccessLevel;
    FEnabled: Boolean;
    FTargetItemProperty: string;
    FOnGetLevelCaption: K0ObjPropStockerItemGetLevelCaptionEvent;
    FCustomKey: String;
    FKeys: K0ItemKeyTypeSet;
    procedure SetDefaultValue(const Value: string);
    procedure SetTargetProperty(const Value: string);
    procedure SetTargetIsOwner(const Value: Boolean);
    procedure SetTargetComponent(const Value: TComponent);
    procedure SetValue(const Value: string);
    procedure SetAccessLevel(const Value: K0ItemAccessLevel);
    function GetLevelCaption: string;
    procedure SetTargetItemProperty(const Value: string);
    function GetPropertyEntryName: String;
    procedure SetCustomKey(const Value: String);
    procedure SetKeys(const Value: K0ItemKeyTypeSet);
  protected
    function CanGetValueToSave: Boolean; virtual;
    function CanSetValueToLoad: Boolean; virtual;
    procedure DoGetValueToSave(var AValue: string; var ACancel: Boolean);
    procedure DoSetValueToLoad(var AValue: string; var ACancel: Boolean);
    function GetDisplayName: string; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(ACollection: TCollection); override;
    procedure GetValueToSave;
    procedure SetValueToLoad;
    function ValueExists: boolean; virtual;
    function SectionExists: boolean; virtual;
  public
    property Value: string read FValue write SetValue;
    property LevelCaption: string read GetLevelCaption;
    property PropertyEntryName: String read GetPropertyEntryName;
  published
    property AccessLevel: K0ItemAccessLevel read FAccessLevel write SetAccessLevel default k0ialInstance;
    property CustomKey: String read FCustomKey write SetCustomKey;
    property DefaultValue: string read FDefaultValue write SetDefaultValue;
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property Keys: K0ItemKeyTypeSet read FKeys write SetKeys default [k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance];
    property TargetComponent: TComponent read FTargetComponent write SetTargetComponent;
    property TargetIsOwner: Boolean read FTargetIsOwner write SetTargetIsOwner;
    property TargetProperty: string read FTargetProperty write SetTargetProperty;
    property TargetItemProperty: string read FTargetItemProperty write SetTargetItemProperty;
    property OnGetLevelCaption: K0ObjPropStockerItemGetLevelCaptionEvent
    	read FOnGetLevelCaption write FOnGetLevelCaption;
    { 次回のバージョンアップでOnLoad、OnSaveは削除する }
    property OnLoad: K0ObjPropStockerItemEvent read FOnGetValueToSave write FOnGetValueToSave;
    property OnSave: K0ObjPropStockerItemEvent read FOnSetValueToLoad write FOnSetValueToLoad;
    property OnGetValueToSave: K0ObjPropStockerItemEvent read FOnGetValueToSave write FOnGetValueToSave;
    property OnSetValueToLoad: K0ObjPropStockerItemEvent read FOnSetValueToLoad write FOnSetValueToLoad;
  end;

type
  Ts0ObjPropStockerItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0ObjPropStockerItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0ObjPropStockerItem);
  public
    function AddItem: Ts0ObjPropStockerItem;
    procedure AddAllProp(AObj: TComponent; ALevel: K0ItemAccessLevel);
    function FindItem(AObj: TComponent; AProp: string): Ts0ObjPropStockerItem;
    property Items[const Index: Integer]: Ts0ObjPropStockerItem read GetItems write SetItems; default;
  end;

type
  Ts0ObjPropStocker = class(TComponent)
  private
    FItems: Ts0ObjPropStockerItems;
    FDomainNames: array[K0ItemAccessLevel] of string;
    FFormCloseListener: Ts0EventListener;
    FFormShowListener: Ts0EventListener;
    FOnInitItems: TNotifyEvent;
    FAutoApplicationName: Boolean;
    FLoadEvent: K0FormEventTypeSet;
    FSaveEvent: K0FormEventTypeSet;
    FLoginUserName: String;
    FComputerName: String;
    procedure SetItems(const Value: Ts0ObjPropStockerItems);
    function GetDomainName(const Index: Integer): string;
    procedure SetDomainName(const Index: Integer; const Value: string);
    procedure SetAutoApplicationName(const Value: Boolean);
    procedure SetLoadEvent(const Value: K0FormEventTypeSet);
    procedure SetSaveEvent(const Value: K0FormEventTypeSet);
  protected
    procedure DoInitItems;
    procedure FormCreated(Sender: TObject);
    procedure FormClosing(Sender: TObject);
    function GetLevelCaption(AItem: Ts0ObjPropStockerItem): string;
    function ItemIsVaild: Boolean;
    procedure Loaded; override;
    function NewItems: Ts0ObjPropStockerItems; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadItems; virtual;
    procedure SaveItems; virtual;
    function ValueExists(AItem: Ts0ObjPropStockerItem): Boolean; virtual;
    function SectionExists(AItem: Ts0ObjPropStockerItem): Boolean; virtual;
  public
    property LoginUserName: String read FLoginUserName write FLoginUserName;
    property ComputerName: String read FComputerName write FComputerName;
  published
    property LoadEvent: K0FormEventTypeSet read FLoadEvent write SetLoadEvent;
    property SaveEvent: K0FormEventTypeSet read FSaveEvent write SetSaveEvent;
    property Items: Ts0ObjPropStockerItems read FItems write SetItems;
    property SystemName     : string index 1 read GetDomainName write SetDomainName;
    property ApplicationName: string index 2 read GetDomainName write SetDomainName;
    property AutoApplicationName: Boolean read FAutoApplicationName write SetAutoApplicationName default True;
    property OnInitItems: TNotifyEvent read FOnInitItems write FOnInitItems;
  public
    property UnitName       : string index 3 read GetDomainName write SetDomainName;
    property InstanceName   : string index 4 read GetDomainName write SetDomainName;
  end;


implementation

uses
	Windows,
	s0StringHelper,
  s0TypInfoWrapper,
  s0PropertyAccessor;

{ Ts0ObjPropStockerItem }

constructor Ts0ObjPropStockerItem.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
  FAccessLevel := k0ialInstance;
  FKeys := [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance];
end;

procedure Ts0ObjPropStockerItem.DoGetValueToSave(var AValue: string;
  var ACancel: Boolean);
begin
  if Assigned(FOnGetValueToSave) then
    FOnGetValueToSave(Self, AValue, ACancel);
end;

procedure Ts0ObjPropStockerItem.DoSetValueToLoad(var AValue: string;
  var ACancel: Boolean);
begin
  if Assigned(FOnSetValueToLoad) then
    FOnSetValueToLoad(Self, AValue, ACancel);
end;

function Ts0ObjPropStockerItem.GetDisplayName: string;
begin
  if FTargetComponent = nil then
    Result := FTargetProperty
  else
    Result := FTargetComponent.Name +'.'+ FTargetProperty;
  if FTargetItemProperty <> '' then
		Result := Result + FTargetItemProperty;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function Ts0ObjPropStockerItem.GetLevelCaption: string;
begin
  Result := '';
  if OwnerComponent is Ts0ObjPropStocker then
    Result := Ts0ObjPropStocker(OwnerComponent).GetLevelCaption(Self);
  if Assigned(FOnGetLevelCaption) then
  	FOnGetLevelCaption(Self, Result);
end;

procedure Ts0ObjPropStockerItem.GetValueToSave;
var
  s: string;
  flgCancel: Boolean;
  accessor: Ts0PropertyAccessor;
begin
  if not CanGetValueToSave then Exit;
  if FTargetComponent = nil then
  begin
    s := DefaultValue
  end
  else
  begin
  	accessor := Ts0PropertyAccessor.Create(FTargetProperty, FTargetItemProperty);
    try
    	s := accessor.GetFromTarget(Self.TargetComponent);
    finally
      FreeAndNil(accessor);
    end;
  end;
  flgCancel := False;
  DoGetValueToSave(s, flgCancel);
  if flgCancel then Exit;
  Self.Value := s;
end;

procedure Ts0ObjPropStockerItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTargetComponent = AComponent then
    FTargetComponent := nil;
end;

function Ts0ObjPropStockerItem.SectionExists: boolean;
begin
  if OwnerComponent is Ts0ObjPropStocker then
    Result := Ts0ObjPropStocker(OwnerComponent).SectionExists(Self)
  else
		Result := False;
end;

procedure Ts0ObjPropStockerItem.SetAccessLevel(
  const Value: K0ItemAccessLevel);
const
	c9AccessLevelToKeys: array[K0ItemAccessLevel] of K0ItemKeyTypeSet = (
		[k0iktSystem],
		[k0iktSystem, k0iktApplication],
		[k0iktSystem, k0iktApplication, k0iktForm],
		[k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
  );
begin
  FAccessLevel := Value;
  if not (csLoading in Self.OwnerComponent.ComponentState) then
  	SetKeys( c9AccessLevelToKeys[FAccessLevel] );
end;

procedure Ts0ObjPropStockerItem.SetDefaultValue(const Value: string);
begin
  FDefaultValue := Value;
end;

procedure Ts0ObjPropStockerItem.SetTargetComponent(const Value: TComponent);
begin
  FTargetComponent := Value;
  if OwnerComponent <> nil then
    FTargetIsOwner := (FTargetComponent = OwnerComponent.Owner);
  if (FTargetComponent <> nil) and (not FTargetIsOwner) then
    if [csLoading, csReading] * OwnerComponent.ComponentState = [] then
      AccessLevel := k0ialInstance;
  Changed(False);
end;

procedure Ts0ObjPropStockerItem.SetTargetIsOwner(const Value: Boolean);
begin
  FTargetIsOwner := Value;
  if FTargetIsOwner and (OwnerComponent <> nil) then
    FTargetComponent := OwnerComponent.Owner;
  Changed(False);
end;

procedure Ts0ObjPropStockerItem.SetTargetProperty(const Value: string);
begin
  FTargetProperty := Value;
end;

procedure Ts0ObjPropStockerItem.SetValue(const Value: string);
begin
  FValue := Value;
end;

procedure Ts0ObjPropStockerItem.SetValueToLoad;
var
  s: string;
  flgCancel: Boolean;
  accessor: Ts0PropertyAccessor;
begin
  if not CanSetValueToLoad then Exit;
  s := Self.Value;
  if s = '' then
  	s := DefaultValue;
  if s = '' then
		Exit;
  flgCancel := False;
  DoSetValueToLoad(s, flgCancel);
  if flgCancel then Exit;
  if FTargetComponent = nil then Exit;
  accessor := Ts0PropertyAccessor.Create(FTargetProperty, FTargetItemProperty);
  try
  	accessor.SetToTarget(FTargetComponent, s);
  finally
    FreeAndNil(accessor);
  end;
end;

function Ts0ObjPropStockerItem.CanGetValueToSave: Boolean;
begin
  Result := True;
end;

function Ts0ObjPropStockerItem.CanSetValueToLoad: Boolean;
begin
  Result := True;
end;

procedure Ts0ObjPropStockerItem.SetTargetItemProperty(const Value: string);
begin
  FTargetItemProperty := Value;
end;

function Ts0ObjPropStockerItem.GetPropertyEntryName: String;
begin
 	Result := FTargetProperty;
	if FTargetItemProperty <> '' then
  	Result := Result + '.' + FTargetItemProperty;
end;

procedure Ts0ObjPropStockerItem.SetCustomKey(const Value: String);
begin
  FCustomKey := Value;
end;

procedure Ts0ObjPropStockerItem.SetKeys(const Value: K0ItemKeyTypeSet);
begin
  FKeys := Value;
end;

function Ts0ObjPropStockerItem.ValueExists: boolean;
begin
  if OwnerComponent is Ts0ObjPropStocker then
    Result := Ts0ObjPropStocker(OwnerComponent).ValueExists(Self)
  else
		Result := False;
end;

{ Ts0ObjPropStockerItems }

procedure Ts0ObjPropStockerItems.AddAllProp(AObj: TComponent;
  ALevel: K0ItemAccessLevel);
var
  acsr: Ts0RTTIPublishedAccessor;
  props: Ts0RTTIProps;
  i: Integer;
  pn: string;
  item: Ts0ObjPropStockerItem;
begin
  if AObj = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(AObj);
  try
    if acsr.RTTINavigator = nil then Exit;
    props := acsr.RTTINavigator.Props;
    if props = nil then Exit;
    for i := 0 to props.Count -1 do
    begin
      pn := props[i].PropName;
      if not acsr.EnabledAsString( pn ) then Continue;
      if AnsiCompareText(pn, 'Name') = 0 then Continue;
      if AnsiCompareText(pn, 'Tag') = 0 then Continue;
      item := AddItem;
      item.TargetComponent := AObj;
      item.TargetProperty := pn;
      item.AccessLevel := ALevel;
    end;
  finally
    FreeAndNil(acsr);
  end;
end;

function Ts0ObjPropStockerItems.AddItem: Ts0ObjPropStockerItem;
begin
  Result := Ts0ObjPropStockerItem(inherited Add);
end;

function Ts0ObjPropStockerItems.FindItem(AObj: TComponent;
  AProp: string): Ts0ObjPropStockerItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count -1 do
    if (Items[i].TargetComponent = AObj) and
       (Items[i].TargetProperty = AProp) then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function Ts0ObjPropStockerItems.GetItems(
  const Index: Integer): Ts0ObjPropStockerItem;
begin
  Result := Ts0ObjPropStockerItem(inherited Items[Index]);
end;

procedure Ts0ObjPropStockerItems.SetItems(const Index: Integer;
  const Value: Ts0ObjPropStockerItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0ObjPropStocker }

constructor Ts0ObjPropStocker.Create(AOwner: TComponent);
begin
  inherited;
  FLoadEvent := [k0femShow];
  FSaveEvent := [k0femClose];
  FAutoApplicationName := True;
  FItems := NewItems;
  if Owner = nil then Exit;
  FDomainNames[k0ialForm]     := Owner.ClassName;
  FDomainNames[k0ialInstance] := Owner.Name;
  FFormShowListener := Ts0EventListener.Create(FormCreated);
  FFormCloseListener := Ts0EventListener.Create(FormClosing);
end;

destructor Ts0ObjPropStocker.Destroy;
begin
  FreeAndNil(FFormShowListener);
  FreeAndNil(FFormCloseListener);
  FreeAndNil(FItems);
  inherited;
end;

procedure Ts0ObjPropStocker.DoInitItems;
begin
  if Assigned(FOnInitItems) then
    FOnInitItems (Self);
end;

procedure Ts0ObjPropStocker.FormClosing(Sender: TObject);
begin
  SaveItems;
end;

procedure Ts0ObjPropStocker.FormCreated(Sender: TObject);
begin
  DoInitItems;
  LoadItems;
end;

function Ts0ObjPropStocker.GetDomainName(const Index: Integer): string;
begin
  Result := '';
  case Index of
    1: Result := FDomainNames[k0ialSystem     ];
    2: Result := FDomainNames[k0ialApplication];
    3: Result := FDomainNames[k0ialForm       ];
    4: Result := FDomainNames[k0ialInstance   ];
  end;
end;

function Ts0ObjPropStocker.GetLevelCaption(AItem: Ts0ObjPropStockerItem): string;
  procedure AddToStr(var AStr: string; Addition: string);
  begin
    if AStr = '' then
      AStr := Addition
    else
      AStr := AStr +'.'+ Addition;
  end;
var
  i: K0ItemKeyType;
begin
  Result := '';
  for i := Low(K0ItemKeyType) to High(K0ItemKeyType) do
  begin
    if not (i in AItem.Keys) then
    	Continue;
    case i of
      k0iktLoginUserName: AddToStr(Result, Self.LoginUserName);
      k0iktComputerName: AddToStr(Result, Self.ComputerName);
      k0iktSystem: AddToStr(Result, FDomainNames[k0ialSystem]);
      k0iktApplication: AddToStr(Result, FDomainNames[k0ialApplication]);
      k0iktForm: AddToStr(Result, FDomainNames[k0ialForm]);
      k0iktInstance:
        if AItem.TargetComponent <> nil then
        begin
          if AItem.TargetIsOwner then
          begin
            AddToStr(Result, AItem.TargetComponent.Name);
          end
          else
          begin
            AddToStr(Result, AItem.TargetComponent.Owner.Name);
            AddToStr(Result, AItem.TargetComponent.Name);
          end;
        end
        else
        begin
          AddToStr(Result, FDomainNames[k0ialInstance]);
        end;
      k0iktCustom:
				AddToStr(Result, AItem.CustomKey);
    end;
  end;
end;

function Ts0ObjPropStocker.ItemIsVaild: Boolean;
begin
  Result := (FItems <> nil);
end;

procedure Ts0ObjPropStocker.Loaded;
var
  publisher: Ts0ComponentEventWrapper;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then
    Exit;
  if FAutoApplicationName and (ApplicationName = '') then
    ApplicationName := ChangeFileExt( ExtractFileName(ParamStr(0)), '');
  publisher := Ts0ComponentEventWrapper.FindEventWrapper(Owner);
  if publisher = nil then
    Exit;
  publisher.AddListener(FFormShowListener, LoadEvent);
  publisher.AddListener(FFormCloseListener, SaveEvent);
end;

procedure Ts0ObjPropStocker.LoadItems;
var
  i: Integer;
begin
  for i := 0 to Items.Count -1 do
    Items[i].SetValueToLoad;
end;

function Ts0ObjPropStocker.NewItems: Ts0ObjPropStockerItems;
	procedure PrepareLoginUserName;
  var
  	valueChars: array[0..127] of char;
    sizeOfChars: DWORD;
  begin
    sizeOfChars := SizeOf(valueChars);
    GetUserName(valueChars, sizeOfChars);
    Self.LoginUserName := valueChars;
  end;
	procedure PrepareComputerName;
  var
  	valueChars: array[0..127] of char;
    sizeOfChars: DWORD;
  begin
    sizeOfChars := SizeOf(valueChars);
    GetComputerName(valueChars, sizeOfChars);
    Self.ComputerName := valueChars;
  end;
begin
  Result := Ts0ObjPropStockerItems.Create(Self, Ts0ObjPropStockerItem);
  PrepareLoginUserName;
  PrepareComputerName;
end;

procedure Ts0ObjPropStocker.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FItems <> nil then
    FItems.Notification(AComponent, Operation);
end;

procedure Ts0ObjPropStocker.SaveItems;
var
  i: Integer;
begin
  for i := 0 to Items.Count -1 do
    Items[i].GetValueToSave;
end;

function Ts0ObjPropStocker.SectionExists(
  AItem: Ts0ObjPropStockerItem): Boolean;
begin
	Result := False;
end;

procedure Ts0ObjPropStocker.SetAutoApplicationName(const Value: Boolean);
begin
  FAutoApplicationName := Value;
end;

procedure Ts0ObjPropStocker.SetDomainName(const Index: Integer;
  const Value: string);
begin
  case Index of
    1: FDomainNames[k0ialSystem     ] := Value;
    2: FDomainNames[k0ialApplication] := Value;
    3: FDomainNames[k0ialForm       ] := Value;
    4: FDomainNames[k0ialInstance   ] := Value;
  end;
end;

procedure Ts0ObjPropStocker.SetItems(const Value: Ts0ObjPropStockerItems);
begin
  FItems.Assign(Value);
end;

procedure Ts0ObjPropStocker.SetLoadEvent(const Value: K0FormEventTypeSet);
begin
  FLoadEvent := Value;
end;

procedure Ts0ObjPropStocker.SetSaveEvent(const Value: K0FormEventTypeSet);
begin
  FSaveEvent := Value;
end;

function Ts0ObjPropStocker.ValueExists(
  AItem: Ts0ObjPropStockerItem): Boolean;
begin
	Result := False;
end;

end.
