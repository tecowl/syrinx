{-----------------------------------------------------------------------------
 Unit Name: s0WrappedCE
 Author:    akima
 Purpose:
 Comment: "Chain of Responsibility"の実装だす。
 $History: s0WrappedCE.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:28
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/06   Time: 23:12
 * Updated in $/source/D6VCLIntegrated/Designer
 * VER130、VER140共用にした
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/01/10   Time: 3:21
 * Updated in $/source/D5Integrated/Designer
-----------------------------------------------------------------------------}

unit s0WrappedCE;

interface

uses
  SysUtils, Classes, Controls,
{$IFDEF VER130}
  DsgnIntf,
  Menus,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
  DesignMenus,
{$ENDIF}
  s0DesignIntf;

type
  Ts0WrappedCE = class(TComponentEditor)
  private
    FOriginalCE: IComponentEditor;
    function CreateCEOfOriginal: IComponentEditor;
  protected
    function GetIndexOfNew(AOrigIndex: Integer): Integer;
    { You can override these methods. }
    procedure ExecuteNewVerb(Index: Integer); virtual;
    function GetNewVerb(Index: Integer): string; virtual;
    function GetNewVerbCount: Integer; virtual;
{$IFDEF VER130}
    procedure PrepareNewItem(Index: Integer; const AItem: TMenuItem); virtual;
{$ELSE}
    procedure PrepareNewItem(Index: Integer; const AItem: IMenuItem); virtual;
{$ENDIF}
  public
    constructor Create(AComponent: TComponent; ADesigner: I0Designer); override;
    destructor Destroy; override;
    { Don't override these methods any more. }
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
{$IFDEF VER130}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
{$ELSE}
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
{$ENDIF}
    { You can override these methods on demand}
    procedure Copy; override;
    procedure Edit; override;
  end;

implementation

{ Ts0WrappedCE }

procedure Ts0WrappedCE.Copy;
begin
  if FOriginalCE <> nil then
    FOriginalCE.Copy;
end;

threadvar
  g9NeedDummy: Boolean;

constructor Ts0WrappedCE.Create(AComponent: TComponent;
  ADesigner: I0Designer);
begin
  inherited Create(AComponent, ADesigner);
  if g9NeedDummy then
    FOriginalCE := nil
  else
    FOriginalCE := CreateCEOfOriginal;
end;

function Ts0WrappedCE.CreateCEOfOriginal: IComponentEditor;
{$IFDEF VER130}
  function GetEditorOfClass(AClass: TComponentClass): TComponentEditor;
  var
    dmy: TComponent;
    dmyEditor: TComponentEditor;
    dmyEditorClass: TComponentEditorClass;
  begin
    Result := nil;
    dmy := AClass.Create(nil);
    try
      g9NeedDummy := True;
      try
        dmyEditor := GetComponentEditor(dmy, Self.Designer);
        if dmyEditor = nil then Exit;
        dmyEditorClass := TComponentEditorClass(dmyEditor.ClassType);
        if dmyEditorClass = Self.ClassType then Exit;
        Result := dmyEditorClass.Create(Self.Component, Self.Designer);
      finally
        g9NeedDummy := False;
      end;
    finally
      FreeAndNil(dmy);
    end;
  end;
{$ELSE}
  function GetEditorOfClass(AClass: TComponentClass): TComponentEditor;
  begin
    Result := nil;
  end;
{$ENDIF}

  function GetSuperCompoClass(AClass: TClass): TComponentClass;
  var
    superClass: TClass;
  begin
    Result := nil;
    if AClass = nil then Exit;
    superClass := AClass.ClassParent;
    if superClass = nil then Exit;
    if not superClass.InheritsFrom(TComponent) then Exit;
    Result := TComponentClass(superClass);
  end;
var
  edtr: TComponentEditor;
  compoClass: TComponentClass;
begin
  Result := nil;
  if Component = nil then Exit;
  compoClass := GetSuperCompoClass(Component.ClassType);
  edtr := GetEditorOfClass(compoClass);
  while (compoClass <> nil) and (edtr = nil) do
  begin
    compoClass := GetSuperCompoClass(compoClass);
    edtr := GetEditorOfClass(compoClass);
  end;
  Result := edtr;
end;

destructor Ts0WrappedCE.destroy;
begin
  FOriginalCE := nil;
  inherited;
end;

procedure Ts0WrappedCE.Edit;
begin
  if FOriginalCE <> nil then
    FOriginalCE.Edit;
end;

procedure Ts0WrappedCE.ExecuteNewVerb(Index: Integer);
begin
end;

procedure Ts0WrappedCE.ExecuteVerb(Index: Integer);
var
  newIdx: Integer;
begin
  newIdx := GetIndexOfNew(Index);
  if newIdx < 0 then
    FOriginalCE.ExecuteVerb(Index)
  else
    ExecuteNewVerb(newIdx);
end;

function Ts0WrappedCE.GetIndexOfNew(AOrigIndex: Integer): Integer;
begin
  if FOriginalCE = nil then
    Result := AOrigIndex
  else
    Result := AOrigIndex - FOriginalCE.GetVerbCount;
end;

function Ts0WrappedCE.GetNewVerb(Index: Integer): string;
begin
  Result := '';
end;

function Ts0WrappedCE.GetNewVerbCount: Integer;
begin
  Result := 0;
end;

function Ts0WrappedCE.GetVerb(Index: Integer): string;
var
  newIdx: Integer;
begin
  newIdx := GetIndexOfNew(Index);
  if newIdx < 0 then
    Result := FOriginalCE.GetVerb(Index)
  else
    Result := GetNewVerb(newIdx);
end;

function Ts0WrappedCE.GetVerbCount: Integer;
begin
  if FOriginalCE = nil then
    Result := GetNewVerbCount
  else
    Result := FOriginalCE.GetVerbCount + GetNewVerbCount;
end;

{$IFDEF VER130}
procedure Ts0WrappedCE.PrepareItem(Index: Integer; const AItem: TMenuItem);
{$ELSE}
procedure Ts0WrappedCE.PrepareItem(Index: Integer; const AItem: IMenuItem);
{$ENDIF}
var
  newIdx: Integer;
begin
  newIdx := GetIndexOfNew(Index);
  if newIdx < 0 then
    FOriginalCE.PrepareItem(Index, AItem)
  else
    PrepareNewItem(newIdx, AItem);

//  AItem.Caption := AItem.Caption + ' - ' + IntToStr(fTestValue);
end;

{$IFDEF VER130}
procedure Ts0WrappedCE.PrepareNewItem(Index: Integer;
  const AItem: TMenuItem);
{$ELSE}
procedure Ts0WrappedCE.PrepareNewItem(Index: Integer;
  const AItem: IMenuItem);
{$ENDIF}
begin
end;

end.
