unit s0ce_DSLogger;

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
  s0DSLogger;

type
  Ts0pe_DSLoggerStyleName = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

type
  Ts0ce_DSLogger = class(Ts0ce_Component)
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

procedure Register;
  
implementation

procedure Register;
begin
  RegisterComponentEditor(Ts0DSLogger, Ts0ce_DSLogger);
  RegisterPropertyEditor(TypeInfo(string), Ts0DSLogger,
    'StyleName', Ts0pe_DSLoggerStyleName);
end;

{ Ts0pe_DSLoggerStyleName }

function Ts0pe_DSLoggerStyleName.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect, paRevertable];
end;

procedure Ts0pe_DSLoggerStyleName.GetValues(Proc: TGetStrProc);
begin
  Ts0DSLoggerStyleRegister.Instance.GetStyleNames(Proc);
end;

{ Ts0ce_DSLogger }

resourcestring
  c9Verb_PropertyOfStyle = 'Styleのプロパティ';

procedure Ts0ce_DSLogger.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_DSLogger.GetVerb(Index: Integer): string;
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

function Ts0ce_DSLogger.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_DSLogger.ImplExecuteVerb(Index: Integer);
  procedure ShowStyleByOI(ALogger: Ts0DSLogger);
  begin
    if not(Component is Ts0DSLogger) then Exit;
    Designer.SelectComponent(ALogger.Style);
  end;
begin
  case Index of
    0: ShowStyleByOI( Ts0DSLogger(Component) );
  end;
end;

function Ts0ce_DSLogger.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := c9Verb_PropertyOfStyle;
  end;
end;

function Ts0ce_DSLogger.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Ts0ce_DSLogger.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

end.
