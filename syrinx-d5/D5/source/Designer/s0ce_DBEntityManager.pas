unit s0ce_DBEntityManager;

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  s0ce_Component,
  s0DBEntity;

type
  Ts0ce_DBEntityMan = class(Ts0ce_Component)
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
  s0fObjEditor;

{ Ts0ce_DBEntityMan }

procedure Ts0ce_DBEntityMan.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_DBEntityMan.GetVerb(Index: Integer): string;
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

function Ts0ce_DBEntityMan.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_DBEntityMan.ImplExecuteVerb(Index: Integer);
var
  dbMan: Ts0DBEntityManager;
begin
  if not(Component is Ts0DBEntityManager) then Exit;
  dbMan := Ts0DBEntityManager(Component);
  case Index of
    0: Ts0frmObjEditor.ShowEditorModal( dbMan.ProtoTypes );
  end;
end;

resourcestring
  c9Verb_EditProtoTypes = 'ProtoTypes�̕ҏW';

function Ts0ce_DBEntityMan.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := c9Verb_EditProtoTypes;
  end;
end;

function Ts0ce_DBEntityMan.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Ts0ce_DBEntityMan.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

end.
