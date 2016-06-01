unit s0ce_ObjCtrlBridge;

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  s0ce_Component,
  s0ObjCtrlBuilder;

type
  Ts0pe_ObjCtrlBuilderCOTName = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

type
  Ts0ce_ObjCtrlBridge = class(Ts0ce_Component)
  private
    procedure ImplExecuteVerb(Index: Integer);
    function ImplGetVerb(Index: Integer): string;
    function ImplGetVerbCount: Integer;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: T0DesignMenu); override;
  end;  

implementation

uses
  Contnrs,
  Dialogs,
  s0CtrlOfType,
  s0fObjEditor;

{ Ts0pe_ObjCtrlBuilderCOTName }

function Ts0pe_ObjCtrlBuilderCOTName.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

procedure Ts0pe_ObjCtrlBuilderCOTName.GetValues(Proc: TGetStrProc);
var
  lst: TClassList;
  i: Integer;
begin
  lst := TClassList.Create;
  try
    Ts0CtrlOfType.GetRegisteredCOTs(lst);
    for i := 0 to lst.Count -1 do
      Proc(lst.Items[i].ClassName);
  finally
    FreeAndNil(lst);
  end;
end;

{ Ts0ce_ObjCtrlBridge }

procedure Ts0ce_ObjCtrlBridge.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_ObjCtrlBridge.GetVerb(Index: Integer): string;
begin
  Result := '';
  if Index < ImplGetVerbCount then
  begin
    Result := ImplGetVerb(Index);
  end
  else
    if ClassType <> Ts0ce_Component then
      Result := inherited GetVerb(Index - ImplGetVerbCount)
end;

function Ts0ce_ObjCtrlBridge.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_ObjCtrlBridge.ImplExecuteVerb(Index: Integer);
var
  bridge: Ts0ObjCtrlBridge;
begin
  if not(Component is Ts0ObjCtrlBridge) then Exit;
  bridge := Ts0ObjCtrlBridge(Component);
  case Index of
    0: bridge.BuildCtrls;
  end;
  if Designer <> nil then
    Designer.Modified;
end;

resourcestring
  c9Verb_CreateCtrl = 'ÉRÉìÉgÉçÅ[ÉãÇÃê∂ê¨(&C)';

function Ts0ce_ObjCtrlBridge.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := c9Verb_CreateCtrl;
  end;
end;

function Ts0ce_ObjCtrlBridge.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Ts0ce_ObjCtrlBridge.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

end.
