{-----------------------------------------------------------------------------
 Unit Name: s0IniPropStocker
 Author:    akima
 Purpose:
 TestCase: tc_s0IniPropStocker
 $History: s0IniPropStocker.pas $
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/03/18   Time: 13:56
 * Updated in $/D5/source/Common
 * T9IniLoaderをちょっと修正
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/12/10   Time: 16:13
 * Updated in $/source/D5Integrated
 * 存在しないセクション、エントリは読み込みせず、プロパティの値に反映しな
 * いようにした。
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/12/07   Time: 18:28
 * Updated in $/source/D5Integrated
 * 実行時パッケージに含まれうるユニットからDsgnIntfを削除。
 * それに関係するクラスなどは設計時用のパッケージにまとめた。
-----------------------------------------------------------------------------}

unit s0IniPropStocker;

interface

uses
  SysUtils, Classes,
  IniFiles,
  s0ObjPropStocker;

type
  K0IniAccessEvent = procedure(Sender: TObject; AIni: TCustomIniFile) of object;

type
  Ts0IniPropStocker = class(Ts0ObjPropStocker)
  private
    FIniFileName: string;
    FIniDirOfExec: Boolean;
    FOnLoadItem: K0IniAccessEvent;
    FOnSaveItem: K0IniAccessEvent;
    procedure SetIniFileName(const Value: string);
  protected
    procedure DoLoadItems(AIni: TCustomIniFile);
    procedure DoSaveItems(AIni: TCustomIniFile);
    procedure Loaded; override;
    function RealIniFileName: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadItems; override;
    procedure SaveItems; override;
    function ValueExists(AItem: Ts0ObjPropStockerItem): Boolean; override;
    function SectionExists(AItem: Ts0ObjPropStockerItem): Boolean; override;
  published
    property IniDirOfExec: Boolean read FIniDirOfExec write FIniDirOfExec default True;
    property IniFileName: string read FIniFileName write SetIniFileName;
    property OnLoadItem: K0IniAccessEvent read FOnLoadItem write FOnLoadItem;
    property OnSaveItem: K0IniAccessEvent read FOnSaveItem write FOnSaveItem;
  end;

procedure Register;

implementation

uses
  s0Application,
  s0Collection;

procedure Register;
begin
  RegisterComponents('P DM', [Ts0IniPropStocker]);
end;

type
  T9IniAccessor = class(Ts0CollectionVisitor)
  private
    FOwner: Ts0IniPropStocker;
    FIni: TCustomIniFile;
  public
    property Owner: Ts0IniPropStocker read FOwner write FOwner;
    property Ini: TCustomIniFile read FIni write FIni;
    procedure Execute;
  end;

type
  T9IniLoader = class(T9IniAccessor)
  protected
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  end;

type
  T9IniSaver = class(T9IniAccessor)
  protected
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  end;

{ T9IniAccessor }

procedure T9IniAccessor.Execute;
begin
  if Owner = nil then Exit;
  if Ini = nil then Exit;
  Owner.Items.Accept(Self);
end;

{ T9IniLoader }

procedure T9IniLoader.VisitItem(AItem: Ts0CollectionItem);
var
  stkr: Ts0ObjPropStockerItem;
  loadedValue: String;
  entry: String;
begin
  if not(AItem is Ts0ObjPropStockerItem) then Exit;
  stkr := Ts0ObjPropStockerItem(AItem);
  stkr.Value := stkr.DefaultValue;
  if not stkr.Enabled then Exit;
  if stkr.LevelCaption = '' then Exit;
  entry := stkr.PropertyEntryName;
  if entry = '' then Exit;
  if not FIni.ValueExists(stkr.LevelCaption, entry) then Exit;
  loadedValue := FIni.ReadString(stkr.LevelCaption, entry, stkr.DefaultValue);
  stkr.Value := loadedValue;
end;

{ T9IniSaver }

procedure T9IniSaver.VisitItem(AItem: Ts0CollectionItem);
var
  stkr: Ts0ObjPropStockerItem;
  entry: String;
begin
  if not(AItem is Ts0ObjPropStockerItem) then Exit;
  stkr := Ts0ObjPropStockerItem(AItem);
  if not stkr.Enabled then Exit;
  if stkr.LevelCaption = '' then Exit;
  entry := stkr.PropertyEntryName;
  if entry = '' then Exit;
  FIni.WriteString(stkr.LevelCaption, entry, stkr.Value);
end;


{ Ts0IniPropStocker }

constructor Ts0IniPropStocker.Create(AOwner: TComponent);
begin
  inherited;
  FIniDirOfExec := True;
end;

destructor Ts0IniPropStocker.Destroy;
begin
  inherited;
end;

procedure Ts0IniPropStocker.DoLoadItems(AIni: TCustomIniFile);
begin
  if Assigned(FOnLoadItem) then
    FOnLoadItem(Self, AIni);
end;

procedure Ts0IniPropStocker.DoSaveItems(AIni: TCustomIniFile);
begin
  if Assigned(FOnSaveItem) then
    FOnSaveItem(Self, AIni);
end;

procedure Ts0IniPropStocker.Loaded;
begin
  inherited Loaded;
end;

procedure Ts0IniPropStocker.LoadItems;
  procedure ClearItemsToDefault;
  var
    i: Integer;
  begin
    for i := 0 to Self.items.Count -1 do
      Items[i].Value := Items[i].DefaultValue;
  end;
var
  iniFile: TIniFile;
  v: T9IniLoader;
begin
  if not FileExists(RealIniFileName) then
  begin
    Exit;
  end;
  iniFile := TIniFile.Create(RealIniFileName);
  try
    v := T9IniLoader.Create;
    try
      v.Owner := Self;
      v.Ini := iniFile;
      v.Execute;
      DoLoadItems(iniFile);
    finally
      FreeAndNil(v);
    end;
  finally
    FreeAndNil(iniFile);
  end;
  inherited LoadItems;
end;

function Ts0IniPropStocker.RealIniFileName: string;
begin
  Result := FIniFileName;
  if IniDirOfExec then
    Result :=
      ExtractFilePath( Ts0Application.Instance.ExeName ) + ExtractFileName( FIniFileName );
end;

procedure Ts0IniPropStocker.SaveItems;
var
  iniFile: TIniFile;
  v: T9IniSaver;
begin
  inherited SaveItems;
  iniFile := TIniFile.Create(RealIniFileName);
  try
    v := T9IniSaver.Create;
    try
      v.Owner := Self;
      v.Ini := iniFile;
      v.Execute;
      DoSaveItems(iniFile);
    finally
      FreeAndNil(v);
    end;
  finally
    FreeAndNil(iniFile);
  end;
end;

function Ts0IniPropStocker.SectionExists(
  AItem: Ts0ObjPropStockerItem): Boolean;
var
  iniFile: TIniFile;
begin
	Result := False;
  if AItem = nil then
  	Exit;
  if AItem.LevelCaption = '' then
    Exit;
  iniFile := TIniFile.Create(RealIniFileName);
  try
    Result := iniFile.SectionExists(AItem.LevelCaption);
  finally
    FreeAndNil(iniFile);
  end;
end;

procedure Ts0IniPropStocker.SetIniFileName(const Value: string);
begin
  FIniFileName := Value;
end;

function Ts0IniPropStocker.ValueExists(AItem: Ts0ObjPropStockerItem): Boolean;
var
  entry: String;
  iniFile: TIniFile;
begin
	Result := False;
  if AItem = nil then
  	Exit;
  if AItem.LevelCaption = '' then
    Exit;
  iniFile := TIniFile.Create(RealIniFileName);
  try
    entry := AItem.PropertyEntryName;
    if entry = '' then
    	Exit;
    Result := iniFile.ValueExists(AItem.LevelCaption, entry);
  finally
    FreeAndNil(iniFile);
  end;
end;

end.
