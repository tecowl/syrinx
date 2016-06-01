unit s0CtrlOfType_EtyCtrls;

interface

uses
  SysUtils, Classes, Controls,
  s0EntityPropProto,
  s0PropertyProtoType,
  s0TypInfoWrapper,
  s0CtrlOfType,
  s0CtrlOfType_StdCtrls;

type
  Ts0COTItemNaviEdit = class(Ts0CtrlOfTypeItem)
  public
    constructor Create(ACollection: TCollection); override;
    procedure InitCtrlByProto(AProto: Ts0PropertyProtoType; AControl: TControl); override;
  end;

type
  Ts0COTEtyCtrls = class(Ts0COTStdCtrls)
  private
    FCtrlClassNameOfNavi: string;
    procedure SetCtrlClassNameOfNavi(const Value: string);
  protected
    procedure DoInitItems; override;
    class function GetEntProto(AProto: Ts0PropertyProtoType): Ts0EntityPropProto;
  public
    function GetCtrlClassNameByProto(AProto: Ts0PropertyProtoType): string; override;
  public
    property CtrlClassNameOfNavi: string read FCtrlClassNameOfNavi write SetCtrlClassNameOfNavi;
  end;

implementation

uses
  s0ObjCtrlBuilder,
  s0NaviSelEdit;

{ Ts0COTItemNaviEdit }

constructor Ts0COTItemNaviEdit.Create(ACollection: TCollection);
begin
  inherited;
  CtrlClassName := Ts0NaviEdit.ClassName;
end;

procedure Ts0COTItemNaviEdit.InitCtrlByProto(AProto: Ts0PropertyProtoType;
  AControl: TControl);
var
  entProto: Ts0EntityPropProto;
  edt: Ts0NaviEdit;
begin
  if AControl is Ts0NaviEdit then
  begin
    edt := Ts0NaviEdit(AControl);
    entProto := Ts0COTEtyCtrls.GetEntProto(AProto);
    if entProto = nil then Exit;
    edt.NaviEntityClassName := entProto.NaviClassName;
  end
  else
    inherited InitCtrlByProto(AProto, AControl);
end;

{ Ts0COTEtyCtrls }

procedure Ts0COTEtyCtrls.DoInitItems;
begin
  inherited DoInitItems;
  FCtrlClassNameOfNavi := Ts0NaviEdit.ClassName;
  Ts0COTItemNaviEdit.Create(Items);
end;

function Ts0COTEtyCtrls.GetCtrlClassNameByProto(AProto: Ts0PropertyProtoType): string;
var
  entProto: Ts0EntityPropProto;
begin
  entProto := GetEntProto(AProto);
  if (entProto <> nil) and entProto.IsNavigator then
  begin
    Result := FCtrlClassNameOfNavi;
  end
  else
    Result := inherited GetCtrlClassNameByProto(AProto);
end;

class function Ts0COTEtyCtrls.GetEntProto(
  AProto: Ts0PropertyProtoType): Ts0EntityPropProto;
begin
  Result := nil;
  if AProto is Ts0EntityPropProto then
    Result := Ts0EntityPropProto(AProto)
  else
  if AProto.OriginalItem is Ts0EntityPropProto then
    Result := Ts0EntityPropProto(AProto.OriginalItem);
end;

procedure Ts0COTEtyCtrls.SetCtrlClassNameOfNavi(const Value: string);
begin
  FCtrlClassNameOfNavi := Value;
end;

var
  g9COTBuf: Ts0CtrlOfTypeClass = nil;

initialization
  RegisterClass(Ts0NaviEdit);
  g9COTBuf := Ts0CtrlOfType.GetDefaultClass;
  Ts0CtrlOfType.RegisterCOT(Ts0COTEtyCtrls);
  Ts0CtrlOfType.SetDefaultClass(Ts0COTEtyCtrls);

finalization
  Ts0CtrlOfType.SetDefaultClass(g9COTBuf);
  Ts0CtrlOfType.UnRegisterCOT(Ts0COTEtyCtrls);
  UnRegisterClass(Ts0COTEtyCtrls);

end.
