unit s0CanvasDrawer;
{
$History: s0CanvasDrawer.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0ctrl
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
}

interface

uses
  Windows, {Messages,} SysUtils, Classes, Graphics,
  Contnrs;

type
  K0CanvasDrawerName = type string;


type
  Ts0CanvasDrawerClass = class of Ts0CanvasDrawer;
  Ts0CanvasDrawer = class
  public
    procedure Draw(ACanvas: TCanvas; ARect: TRect); virtual;
    class function GetDrawerName: K0CanvasDrawerName; virtual;
    class function GetDrawerByName(AName: K0CanvasDrawerName;
      AFilter: Ts0CanvasDrawerClass = nil): Ts0CanvasDrawerClass;
    class procedure GetRegisteredList(AList: TClassList; AFilter: Ts0CanvasDrawerClass = nil);
    class procedure RegisterDrawer(AClass: Ts0CanvasDrawerClass);
    class procedure UnRegisterDrawer(AClass: Ts0CanvasDrawerClass);
    class procedure GetRegisteredNames(Proc: TGetStrProc; AFilter: Ts0CanvasDrawerClass = nil);
  end;


type
  Es0CanvasDrawerException = class(Exception);


implementation

{ Ts0CanvasDrawer }

procedure Ts0CanvasDrawer.Draw(ACanvas: TCanvas; ARect: TRect);
begin
  ACanvas.Rectangle(ARect);
end;

var
  g9DrawerList: TClassList = nil;

class function Ts0CanvasDrawer.GetDrawerByName(AName: K0CanvasDrawerName;
  AFilter: Ts0CanvasDrawerClass): Ts0CanvasDrawerClass;
var
  lst: TClassList;
  i: Integer;
begin
  Result := nil;
  lst := TClassList.Create;
  try
    GetRegisteredList(lst, AFilter);
    for i := 0 to lst.Count -1 do
    begin
      if Ts0CanvasDrawerClass( lst.Items[i] ).GetDrawerName = AName then
      begin
        Result := Ts0CanvasDrawerClass( lst.Items[i] );
        Exit;
      end;
    end;
  finally
    FreeAndNil(lst);
  end;
end;

class function Ts0CanvasDrawer.GetDrawerName: K0CanvasDrawerName;
begin
  Result := Self.ClassName;
end;

class procedure Ts0CanvasDrawer.GetRegisteredList(AList: TClassList;
  AFilter: Ts0CanvasDrawerClass);
var
  i: Integer;
begin
  if AList = nil then Exit;
  if g9DrawerList = nil then Exit;
  for i := 0 to g9DrawerList.Count -1 do
  begin
    if not g9DrawerList.Items[i].InheritsFrom(AFilter) then Continue;
    AList.Add( g9DrawerList.Items[i] );
  end;
end;

resourcestring
  c9ErrMsg_DuplicateName = '�قȂ�Ts0CanvasDrawer�N���X�ɓ������O���g�p���Ă��܂��B: "%s"';

class procedure Ts0CanvasDrawer.GetRegisteredNames(Proc: TGetStrProc;
  AFilter: Ts0CanvasDrawerClass);
var
  lst: TClassList;
  i: Integer;
begin
  lst := TClassList.Create;
  try
    GetRegisteredList(lst, AFilter);
    for i := 0 to lst.Count -1 do
      Proc( Ts0CanvasDrawerClass(lst.Items[i]).GetDrawerName );
  finally
    FreeAndNil(lst);
  end;
end;

class procedure Ts0CanvasDrawer.RegisterDrawer(AClass: Ts0CanvasDrawerClass);
var
  drwr: Ts0CanvasDrawerClass;
begin
  if g9DrawerList = nil then
    g9DrawerList := TClassList.Create;
  if g9DrawerList.IndexOf(AClass) > -1 then Exit;
  drwr := GetDrawerByName(AClass.GetDrawerName);
  if drwr <> nil then
    raise Es0CanvasDrawerException.CreateFmt(c9ErrMsg_DuplicateName, [AClass.GetDrawerName]);
  g9DrawerList.Add(AClass);
end;

class procedure Ts0CanvasDrawer.UnRegisterDrawer(
  AClass: Ts0CanvasDrawerClass);
begin
  if g9DrawerList = nil then Exit;
  while g9DrawerList.Remove(AClass) > -1 do ;
end;

initialization

finalization
  FreeAndNil(g9DrawerList);

end.
