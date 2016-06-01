unit c8PWController;

interface

uses
	SysUtils, Classes, SvcMgr,
  JvParameterListParameter,
	JvParameterList,
  JvCipher,
  JvAppStorage;

type
	K8MessageType = (k8mtInfo, k8mtWarn, k8mtError);

const
	c8MessageTypeName: array[K8MessageType] of String = (
  	'情報', '警告', 'エラー'
  );

type
	T8Messenger = class
  private
    FMinLogLevel: K8MessageType;
  protected
  	procedure DoSend(msg: String; msgType: K8MessageType); virtual; abstract;
  public
  	procedure Send(msg: String; msgType: K8MessageType); virtual;
    property MinLogLevel: K8MessageType read FMinLogLevel write FMinLogLevel;
  end;

type
	T8EventMessenger = class(T8Messenger)
  private
  	FLogger: TEventLogger;
  protected
  	procedure DoSend(msg: String; msgType: K8MessageType); override;
  public
  	constructor Create(name: String);
    destructor Destroy; override;
  end;

type
	T8DialogMessenger = class(T8Messenger)
  protected
  	procedure DoSend(msg: String; msgType: K8MessageType); override;
  end;

type
	T8PWController = class
  private
    FConfirmPW: Boolean;
  protected
    FMessenger: T8Messenger;
    FAppStorage: TJvCustomAppStorage;
    function CreateRegParameters: TJvParameterList;
    function CheckImpl(const pA, pB: String): Boolean;
  public
  	constructor Create(AAppStorage: TJvCustomAppStorage);
    destructor Destroy; override;
    //パスワードが正しいかどうかを調べる
    function CheckPW(const s: String): Boolean;
    //パスワードが正しいかどうかを調べた上で保存する。
    procedure SavePW(const s: String);
    //実行可能かどうかを調べるメソッド
  	function CanStart: Boolean;
    //CanStart時に、パスワードが正しくない場合にパスワードを入力させるかどうか
    property ConfirmPW: Boolean read FConfirmPW write FConfirmPW;
    property Messenger: T8Messenger read FMessenger write FMessenger;
    property AppStorage: TJvCustomAppStorage read FAppStorage;
  end;

type
	T8PWControllerFactory = class
  private
  	class function CreateDefaultCipher: TJvCustomCipher;
  	class function CreateDefaultStrage: TJvCustomAppStorage;
  public
  	class function GetSingletonOfForm(ConfirmPW: Boolean): T8PWController;
  	class function GetSingletonOfService: T8PWController;
  end;


implementation

uses
  Windows,
	Dialogs,
  JvTypes,
  JvAppRegistryStorage,
  u8Encrypt,
  u8PWConst,
	u8MacAddress;

{ T8Messenger }

procedure T8Messenger.Send(msg: String; msgType: K8MessageType);
begin
	if msgType < Self.MinLogLevel then
  	Exit;
  DoSend(msg, msgType);
end;

{ T8EventMessenger }

constructor T8EventMessenger.Create(name: String);
begin
	FLogger := TEventLogger.Create(name);
end;

destructor T8EventMessenger.Destroy;
begin
	FreeAndNil(FLogger);
  inherited;
end;


const
	c9_EVENT_LOG_TYPE: array[K8MessageType] of Integer = (
  	EVENTLOG_INFORMATION_TYPE,
    EVENTLOG_WARNING_TYPE,
    EVENTLOG_ERROR_TYPE
  );

procedure T8EventMessenger.DoSend(msg: String; msgType: K8MessageType);
begin
  FLogger.LogMessage(msg, c9_EVENT_LOG_TYPE[msgType]);
end;

{ T8DialogMessenger }

procedure T8DialogMessenger.DoSend(msg: String; msgType: K8MessageType);
begin
  ShowMessage(c8MessageTypeName[msgType] + ' '+ msg);
end;

{ T8PWController }

function T8PWController.CanStart: Boolean;
var
  ParameterList: TJvParameterList;
  pA, pB: TJvEditParameter;
begin
  Result := False;
  ParameterList := CreateRegParameters();
  try
    ParameterList.LoadData;
    //
    pA := TJvEditParameter(ParameterList.ParameterByName('pA'));
    pB := TJvEditParameter(ParameterList.ParameterByName('pB'));
    if CheckImpl(pA.AsString, pB.AsString) then
    begin
      Messenger.Send('1. parameters check OK. ', k8mtInfo);
		  Result := True;
      Exit;
    end;
    if Self.ConfirmPW then
    begin
      ParameterList.ShowParameterDialog;
      pA.AsString := T8MacAddress.GetPrimaryMacAddress;
      if CheckImpl(pA.AsString, pB.AsString) then
      begin
        ParameterList.storeData;
        Messenger.Send('0. correct parameters are stored.', k8mtInfo);
        Result := True;
        Exit;
      end;
    end;
    Messenger.Send('Parameters are incorrect.', k8mtError);
  finally
    ParameterList.Free;
  end;
end;

function T8PWController.CheckImpl(const pA, pB: String): Boolean;
var
	encryptedMac: String;
begin
	Result := False;
	if (pA = '') or (pB = '') then
  	Exit;
  //レジストリに保存されているMACアドレスと実際のアドレスが違ってたらNG
  if pA <> T8MacAddress.GetPrimaryMacAddress then
  	Exit;
  //暗号化されたMACアドレスが、入力されたパスワードと違ってたらNG
  encryptedMac := T8PWGen.Encrypt(pA);
  if (encryptedMac <> pB) then
  	Exit;
	Result := True;
end;

function T8PWController.CheckPW(const s: String): Boolean;
begin
	Result := CheckImpl(T8MacAddress.GetPrimaryMacAddress, s);
end;

constructor T8PWController.Create(AAppStorage: TJvCustomAppStorage);
begin
	FAppStorage := AAppStorage;
end;

function T8PWController.CreateRegParameters: TJvParameterList;
var
  p: TJvEditParameter;
begin
  Result := TJvParameterList.Create(nil);
  p := TJvEditParameter.Create(Result);
  p.SearchName := 'pA';
  p.Caption := 'MacAddress';
  p.StoreValueCrypted := True;
  p.Visible := False;
  Result.AddParameter(p);
  //
  p := TJvEditParameter.Create(Result);
  p.SearchName := 'pB';
  p.Caption := 'Password';
  p.StoreValueCrypted := True;
  Result.AddParameter(p);
  //
  Result.HistoryEnabled := False;
  Result.AppStorage := Self.AppStorage;
  Result.AppStoragePath := c8_APP_STRAGE_REG_PATH;
end;

destructor T8PWController.Destroy;
begin
  inherited;
end;

procedure T8PWController.SavePW(const s: String);
var
  ParameterList: TJvParameterList;
  pA, pB: TJvEditParameter;
begin
  ParameterList := CreateRegParameters();
  try
    pA := TJvEditParameter(ParameterList.ParameterByName('pA'));
    pB := TJvEditParameter(ParameterList.ParameterByName('pB'));
    pA.AsString := T8MacAddress.GetPrimaryMacAddress;
    pB.AsString := s;
    if CheckImpl(pA.AsString, pB.AsString) then
    begin
      ParameterList.storeData;
      Messenger.Send('2. parameters check OK and stored ', k8mtInfo);
      Exit;
    end;
    Messenger.Send('Parameters are incorrect.', k8mtError);
  finally
    ParameterList.Free;
  end;
end;

type
	T9OwnedPWController = class(T8PWController)
  private
    FCipher: TJvCustomCipher;
    procedure SetCipher(const Value: TJvCustomCipher);
  public
  	destructor Destroy; override;
    property Cipher: TJvCustomCipher read FCipher write SetCipher;
    procedure DecryptValue(var Value: String);
    procedure EncryptValue(var Value: String);
  end;

{ T9OwnedPWController }

procedure T9OwnedPWController.DecryptValue(var Value: String);
begin
  FCipher.Encoded := Value;
  Value := FCipher.Decoded;
end;

destructor T9OwnedPWController.Destroy;
begin
	FreeAndNil(FAppStorage);
	FreeAndNil(FCipher);
	FreeAndNil(FMessenger);
  inherited;
end;

procedure T9OwnedPWController.EncryptValue(var Value: String);
begin
  FCipher.Decoded := Value;
  Value := FCipher.Encoded;
end;

procedure T9OwnedPWController.SetCipher(const Value: TJvCustomCipher);
begin
  FCipher := Value;
  if FCipher <> nil then
  begin
    AppStorage.OnDecryptPropertyValue := Self.DecryptValue;
    AppStorage.OnEncryptPropertyValue := Self.EncryptValue;
  end
  else
  begin
    AppStorage.OnDecryptPropertyValue := nil;
    AppStorage.OnEncryptPropertyValue := nil;
  end;
end;

{ T8PWControllerFactory }

class function T8PWControllerFactory.CreateDefaultCipher: TJvCustomCipher;
var
	c: TJvVigenereCipher;
begin
  Result := TJvVigenereCipher.Create(nil);
  c := TJvVigenereCipher(Result);
  c.Name := 'Cipher';
  c.Key := c8_APP_STRAGE_CIPHER_KEY;
end;

class function T8PWControllerFactory.CreateDefaultStrage: TJvCustomAppStorage;
var
  strage: TJvAppRegistryStorage;
begin
  Result := TJvAppRegistryStorage.Create(nil);
  strage := TJvAppRegistryStorage(Result);
  strage.Name := 'JvAppRegistryStorage';
  strage.StorageOptions.BooleanStringTrueValues := 'TRUE, YES, Y';
  strage.StorageOptions.BooleanStringFalseValues := 'FALSE, NO, N';
  strage.StorageOptions.SetAsString := True;
  strage.StorageOptions.DefaultIfReadConvertError := True;
  strage.RegRoot := hkLocalMachine;
  strage.Root := c8_APP_STRAGE_REG_ROOT;
end;


class function T8PWControllerFactory.GetSingletonOfForm(ConfirmPW: Boolean): T8PWController;
var
	c: T9OwnedPWController;
	storage: TJvCustomAppStorage;
begin
	storage := CreateDefaultStrage;
  Result := T9OwnedPWController.Create(storage);
  c := T9OwnedPWController(Result);
  c.ConfirmPW := ConfirmPW;
  c.Messenger := T8DialogMessenger.Create();
  c.Cipher := CreateDefaultCipher;
end;

class function T8PWControllerFactory.GetSingletonOfService: T8PWController;
var
	c: T9OwnedPWController;
	storage: TJvCustomAppStorage;
begin
	storage := CreateDefaultStrage;
  Result := T9OwnedPWController.Create(storage);
  c := T9OwnedPWController(Result);
  c.Messenger := T8EventMessenger.Create(c8_EVENT_LOGGER_NAME);
  c.Cipher := CreateDefaultCipher;
end;

end.
