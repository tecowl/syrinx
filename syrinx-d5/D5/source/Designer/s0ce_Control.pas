{-----------------------------------------------------------------------------
 Unit Name: s0ce_Control
 Author:    akima
 Purpose:
 TestCase: tc_s0ce_Control
 See: 
 $History: s0ce_Control.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/13   Time: 0:06
 * Updated in $/source/D5Integrated/Designer
 * IDesignerSelectionsのインタフェースがVER130とVER140で結構ちがうので、対
 * 応した。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/12   Time: 23:43
 * Updated in $/source/D6VCLIntegrated/Designer
 * コンポーネントエディタを継承する方法を確定
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/11   Time: 19:10
 * Updated in $/source/D5Integrated/Designer
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/02/11   Time: 18:47
 * Created in $/source/D6VCLIntegrated/Designer
-----------------------------------------------------------------------------}
unit s0ce_Control;

interface

uses
  SysUtils, Classes, Controls,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf,DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0DesignIntf,
  s0ce_Component;

type
  Ts0ce_Control = class(Ts0ce_Component)
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

type
  Ts0ce_WinControl = class(Ts0ce_Control)
  private
    procedure ImplExecuteVerb(Index: Integer);
    function ImplGetVerb(Index: Integer): string;
    function ImplGetVerbCount: Integer;
    procedure SelectControls;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: T0DesignMenu); override;
  end;

implementation

{ Ts0ce_Control }

procedure Ts0ce_Control.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_Control.GetVerb(Index: Integer): string;
begin
  Result := '';
  if Index < ImplGetVerbCount then
    Result := ImplGetVerb(Index)
  else
    Result := inherited GetVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_Control.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_Control.ImplExecuteVerb(Index: Integer);
begin
end;

function Ts0ce_Control.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
end;

function Ts0ce_Control.ImplGetVerbCount: Integer;
begin
  Result := 0;
end;

procedure Ts0ce_Control.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

{ Ts0ce_WinControl }

procedure Ts0ce_WinControl.ImplExecuteVerb(Index: Integer);
begin
  case Index of
    0: SelectControls;
  end;
end;

resourcestring
  c9Verb_SelectControls = '子コントロールを選択';

function Ts0ce_WinControl.ImplGetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := c9Verb_SelectControls;
  end;
end;

function Ts0ce_WinControl.ImplGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Ts0ce_WinControl.SelectControls;
var
  parent: TWinControl;
  i: Integer;
  selList: IDesignerSelections;
begin
  if Designer = nil then Exit;
  if not(Component is TWinControl) then Exit;
  parent := TWinControl(Component);
  selList := CreateSelectionList;
  for i := 0 to parent.ControlCount -1 do
  begin
    if parent.Controls[i].Owner <> parent.Owner then Continue;
    {$IFDEF VER130}
      selList.Add( MakeIPersistent(parent.Controls[i]) );
    {$ELSE}
      selList.Add(parent.Controls[i]);
    {$ENDIF}
  end;
  Designer.SetSelections(selList);  
end;

function Ts0ce_WinControl.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_WinControl.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_WinControl.GetVerb(Index: Integer): string;
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

procedure Ts0ce_WinControl.PrepareItem(Index: Integer;
  const AItem: T0DesignMenu);
begin
  inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

end.
