unit s0PackageManager;
{
$History: s0PackageManager.pas $
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
 * *****************  Version 6  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:32
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes;

type
  Ts0PackageManagerClass = class of Ts0PackageManager;
  Ts0PackageManager = class(TComponent)
  protected
    function AppCanRun: Boolean; virtual;
    procedure StanByManagers; virtual;
    procedure ShutDownManagers; virtual;
    class function CreateInstance: Ts0PackageManager; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure GetPkgManagers(Dest: TList);
    class procedure SetupManagers;
    class procedure TerminateManagers;
    class function ApplicationCanRun: Boolean;
    class procedure RegisterPkgManClass(AClass: Ts0PackageManagerClass);
  end;

implementation

{ Ts0PackageManager }

var
  g9PkgManClasses: TList = nil;
  g9PkgMen: TList = nil;

procedure Ts0PackageManager.StanByManagers;
begin
end;

procedure Ts0PackageManager.ShutDownManagers;
begin
end;

function Ts0PackageManager.AppCanRun: Boolean;
begin
  Result := False;
end;

class procedure Ts0PackageManager.SetupManagers;
var
  i: Integer;
  pkg: Ts0PackageManager;
begin
  if g9PkgManClasses = nil then Exit;
  for i := 0 to g9PkgManClasses.Count -1 do
  begin
    pkg := Ts0PackageManagerClass(g9PkgManClasses.Items[i]).CreateInstance;
    pkg.StanByManagers;
  end;
end;

class procedure Ts0PackageManager.TerminateManagers;
var
  i: Integer;
begin
  if g9PkgMen = nil then Exit;
  for i := g9PkgMen.Count -1 downto 0 do
  begin
    Ts0PackageManager(g9PkgMen.Items[i]).ShutDownManagers;
    Ts0PackageManager(g9PkgMen.Items[i]).Free;
  end;
end;

class function Ts0PackageManager.ApplicationCanRun: Boolean;
var
  i: Integer;
begin
  Result := True;
  if g9PkgMen = nil then Exit;
  for i := 0 to g9PkgMen.Count -1 do
    Result := Result and Ts0PackageManager(g9PkgMen.Items[i]).AppCanRun;
end;

constructor Ts0PackageManager.Create(AOwner: TComponent);
begin
  inherited;
  if g9PkgMen = nil then
    g9PkgMen := TList.Create;
  g9PkgMen.Add(Self);
end;

destructor Ts0PackageManager.Destroy;
begin
  if g9PkgMen <> nil then
    g9PkgMen.Remove(Self);
  inherited;
end;

class procedure Ts0PackageManager.GetPkgManagers(Dest: TList);
var
  i: Integer;
begin
  Dest.Clear;
  for i := 0 to g9PkgMen.Count -1 do
    Dest.Add(g9PkgMen.Items[i]);
end;

class procedure Ts0PackageManager.RegisterPkgManClass(
  AClass: Ts0PackageManagerClass);
begin
  if g9PkgManClasses = nil then
    g9PkgManClasses := TList.Create;
  g9PkgManClasses.Add(AClass);
end;

initialization

finalization
  //Ts0PackageManager.TerminateManagers;
  FreeAndNil(g9PkgMen);
  FreeAndNil(g9PkgManClasses);

end.
