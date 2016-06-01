unit s0SingletonKeeper;
{
$History: s0SingletonKeeper.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/18   Time: 19:15
 * Created in $/source/p0common
 * Singletonのクラスに余計なインスタンスを作れないようにするクラス。
}

interface

uses
  SysUtils, Classes;

type
  Ts0SingletonKeeper = class
  private
    FList: TStrings;
  protected
    function GetSingletionByName(AName: string): TObject;
  public
    constructor Create;
    destructor Destroy; override;
    function GetSingletion(AClass: TClass): TObject;
    procedure RegisterSingletion(ASingleton: TObject; AName: string = '');
    procedure UnRegisterSingletion(ASingleton: TObject);
    class function Instance: Ts0SingletonKeeper;
  end;

type
  Es0SingletonKeeperException = class(Exception);

implementation

{ Ts0SingletonKeeper }

constructor Ts0SingletonKeeper.Create;
begin
  FList := TStringList.Create;
  TStringList(FList).Sorted := True;
  TStringList(FList).Duplicates := dupError;
end;

destructor Ts0SingletonKeeper.Destroy;
begin
  FreeAndNil(Flist);
  inherited;
end;

function Ts0SingletonKeeper.GetSingletion(AClass: TClass): TObject;
begin
  Result :=Self.GetSingletionByName(AClass.ClassName);
end;

function Ts0SingletonKeeper.GetSingletionByName(AName: string): TObject;
var
  idx: Integer;
begin
  Result := nil;
  idx := FList.IndexOf( UpperCase(AName) );
  if idx < 0 then Exit;
  Result := FList.Objects[idx];
end;

resourcestring
  c9ErrMsg_RegisterException = 'Ts0SingletonKeeperへの登録に失敗しました';
  c9ErrMsg_RegisterDuplicates = 'Ts0SingletonKeeperへの２重に登録しようとしました';

procedure Ts0SingletonKeeper.RegisterSingletion(ASingleton: TObject; AName: string);
  function CheckDuplicate(AID: string): Boolean;
  var
    obj: TObject;
  begin
    Result := True;
    obj := GetSingletionByName(AID);
    if obj = nil then Exit;
    if obj = ASingleton then Exit;
    Result := False;
  end;
begin
  if ASingleton = nil then
    raise Es0SingletonKeeperException.Create(c9ErrMsg_RegisterException);
  if AName = '' then
    AName := ASingleton.ClassName;
  if not CheckDuplicate(AName) then
    raise Es0SingletonKeeperException.Create(c9ErrMsg_RegisterDuplicates);
  FList.AddObject( UpperCase(AName), ASingleton);
end;

procedure Ts0SingletonKeeper.UnRegisterSingletion(ASingleton: TObject);
var
  idx: Integer;
begin
  idx := FList.IndexOfObject(ASingleton);
  if idx < 0 then Exit;
  FList.Delete(idx);
end;

var
  g9Keeper: Ts0SingletonKeeper = nil;

class function Ts0SingletonKeeper.Instance: Ts0SingletonKeeper;
begin
  if g9Keeper = nil then
    g9Keeper := Ts0SingletonKeeper.Create;
  Result := g9Keeper;
end;

initialization

finalization
  FreeAndNil(g9Keeper);

end.
