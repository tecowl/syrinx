unit s0ce_WizardPages;

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf,
  Menus,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
  DesignMenus,
{$ENDIF}
  s0DesignIntf,
  s0ce_Control,
  c0SXWizardPages;

type
  Ts0ce_WizardPages = class(Ts0ce_Control)
  private
    procedure ImplExecuteVerb(Index: Integer);
    function ImplGetVerb(Index: Integer): string;
    function ImplGetVerbCount: Integer;
    procedure ImplPrepareItem(Index: Integer; const AItem: T0DesignMenu);
  private
    procedure NewPage(APages: Tc0SXWizardPages);
    procedure NextPage(APages: Tc0SXWizardPages);
    procedure PrevPage(APages: Tc0SXWizardPages);
    procedure DeletePage(APage: Tc0SXWizardPagesheet);
    function GetContainer: Tc0SXWizardPages;
    function GetCurrentPage: Tc0SXWizardPagesheet;
  protected
    property Container: Tc0SXWizardPages read GetContainer;
    property CurrentPage: Tc0SXWizardPagesheet read GetCurrentPage;
    function CanNextPage: Boolean;
    function CanPrevPage: Boolean;
    function CanDelPage: Boolean;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: T0DesignMenu); override;
  end;

procedure Register;

implementation

uses
  s0ComponentHelper, s0ce_Component;

procedure Register;
begin
//  RegisterComponentEditor(Tc0SXWizardPagesheet, Ts0ce_WizardPages);
//  RegisterComponentEditor(Tc0SXWizardPages, Ts0ce_WizardPages);
end;

{ Ts0ce_WizardPages }

resourcestring
  c9VervName_New  = 'ページ新規作成(&W)';
  c9VervName_Next = '次のページ(&X)';
  c9VervName_Prev = '前のページ(&P)';
  c9VervName_Del  = 'ページの削除(&D)';

const
  c9VerbNames: array[0..3] of string = (
    c9VervName_New ,
    c9VervName_Next,
    c9VervName_Prev,
    c9VervName_Del
  );

function Ts0ce_WizardPages.CanDelPage: Boolean;
begin
  Result := CurrentPage <> nil;
end;

function Ts0ce_WizardPages.CanNextPage: Boolean;
begin
  Result := False;
  if Container = nil then Exit;
  if Container.ActivePageIndex > Container.PageCount -2 then Exit;
  Result := True;
end;

function Ts0ce_WizardPages.CanPrevPage: Boolean;
begin
  Result := False;
  if Container = nil then Exit;
  if Container.ActivePageIndex < 1 then Exit;
  Result := True;
end;

procedure Ts0ce_WizardPages.DeletePage(APage: Tc0SXWizardPagesheet);
begin
  FreeAndNil(APage);
end;

procedure Ts0ce_WizardPages.ExecuteVerb(Index: Integer);
begin
  if Index < ImplGetVerbCount then
    ImplExecuteVerb(Index)
  else
    inherited ExecuteVerb(Index - ImplGetVerbCount);
end;

function Ts0ce_WizardPages.GetContainer: Tc0SXWizardPages;
begin
  Result := nil;
  if Component is Tc0SXWizardPages then
    Result := Tc0SXWizardPages(Component)
  else
  if Component is Tc0SXWizardPagesheet then
    if Tc0SXWizardPagesheet(Component).Parent is Tc0SXWizardPages then
      Result := Tc0SXWizardPages(Tc0SXWizardPagesheet(Component).Parent);
end;

function Ts0ce_WizardPages.GetCurrentPage: Tc0SXWizardPagesheet;
begin
  Result := nil;
  if Component is Tc0SXWizardPagesheet then
    Result := Tc0SXWizardPagesheet(Component);
end;

function Ts0ce_WizardPages.GetVerb(Index: Integer): string;
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

function Ts0ce_WizardPages.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + ImplGetVerbCount;
end;

procedure Ts0ce_WizardPages.ImplExecuteVerb(Index: Integer);
begin
  case Index of
    0: NewPage(Container);
    1: NextPage(Container);
    2: PrevPage(Container);
    3: DeletePage(CurrentPage);
  end;
end;

function Ts0ce_WizardPages.ImplGetVerb(Index: Integer): string;
begin
  Result := '';
  if (Index < Low(c9VerbNames)) or (Index > High(c9VerbNames)) then Exit;
  Result := c9VerbNames[Index];
end;

function Ts0ce_WizardPages.ImplGetVerbCount: Integer;
begin
  Result := High(c9VerbNames) - Low(c9VerbNames) +1;
end;

procedure Ts0ce_WizardPages.ImplPrepareItem(Index: Integer; const AItem:
  T0DesignMenu);
begin
  case Index of
    0: ;
    1: AItem.Enabled := CanNextPage;
    2: AItem.Enabled := CanPrevPage;
    3: AItem.Enabled := CanDelPage;
  end;
end;

procedure Ts0ce_WizardPages.NewPage(APages: Tc0SXWizardPages);
var
  pg: Tc0SXWizardPagesheet;
begin
  if APages = nil then Exit;
  pg := Tc0SXWizardPagesheet.Create(APages.Owner);
  pg.Name := Ts0ComponentHelper.GetNewComponentName(pg);
  pg.Parent := APages;
  pg.PageControl := APages;
end;

procedure Ts0ce_WizardPages.NextPage(APages: Tc0SXWizardPages);
begin
  if not CanNextPage then Exit;
  APages.ActivePageIndex := APages.ActivePageIndex +1;
end;

procedure Ts0ce_WizardPages.PrepareItem(Index: Integer; const AItem:
  T0DesignMenu); 
begin
  if Index < ImplGetVerbCount then
    ImplPrepareItem(Index, AItem)
  else
    inherited PrepareItem(Index - ImplGetVerbCount, AItem);
end;

procedure Ts0ce_WizardPages.PrevPage(APages: Tc0SXWizardPages);
begin
  if not CanPrevPage then Exit;
  APages.ActivePageIndex := APages.ActivePageIndex -1;
end;

end.
