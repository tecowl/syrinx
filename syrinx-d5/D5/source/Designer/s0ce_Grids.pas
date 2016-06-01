unit s0ce_Grids;

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  s0ce_Control,
  s0CellDecorator,
  s0Grids;

type
  Ts0ce_Grids = class(Ts0ce_Control)
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
  s0ce_fCustomStringGrid;

{ Ts0ce_Grids }

procedure Ts0ce_Grids.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_Grids.GetVerb(Index: Integer): string;
begin
  Result := '';
  if Index < ImplGetVerbCount then
  begin
    Result := ImplGetVerb(Index);
  end
  else
    Result := inherited GetVerb(Index - ImplGetVerbCount)
end;

function Ts0ce_Grids.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_Grids.ImplExecuteVerb(Index: Integer);
  procedure ShowEditCells;
  var
    frm: Ts0ce_frmCustomStringGrid;
  begin
    if not (Component is Ts0CustomDecoStringGrid) then Exit;
    frm := Ts0ce_frmCustomStringGrid.Create(nil);
    try
      frm.TargetGrid := Ts0CustomDecoStringGrid(Component);
      frm.ShowModal;
      if Designer <> nil then
        Designer.Modified;
    finally
      FreeAndNil(frm);
    end;
  end;
begin
  case Index of
    0: ShowEditCells;
  end;
end;

resourcestring
  c9Verb_EditCells = 'ÉZÉãÇÃï“èW';

function Ts0ce_Grids.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  case Index of
    0: Result := c9Verb_EditCells;
  end;
end;

function Ts0ce_Grids.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Ts0ce_Grids.PrepareItem(Index: Integer; const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

end.
