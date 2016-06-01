unit s0CEFinder;

interface

uses
  SysUtils, Classes, Contnrs,
{$IFDEF VER130}
  DsgnIntf;
{$ELSE}
  DesignIntf {, DesignEditors, VCLEditors, RTLConsts};
{$ENDIF}

type
  Ts0CEData = class
  private
    FCompoClass: TComponentClass;
    FCEClass: TComponentEditorClass;
  public
    constructor Create(ACompo: TComponentClass; ACE: TComponentEditorClass);
    property CompoClass: TComponentClass read FCompoClass;
    property CEClass: TComponentEditorClass read FCEClass;
  end;

type
  Ts0CEFinder = class
  private
    FCEDataList: TObjectList;
    function GetCount: Integer;
    function GetItems(const Index: Integer): Ts0CEData;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddCEData(ACompoClass: TComponentClass; ACEClass: TComponentEditorClass);
    function GetCEByComponent(ACompoClass: TComponentClass; AExactly: Boolean = False): TComponentEditorClass;
    function FindCEByComponent(ACompoClass: TComponentClass): TComponentEditorClass;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: Ts0CEData read GetItems;
    class function Instance: Ts0CEFinder;
  end;

implementation

{ Ts0CEData }

constructor Ts0CEData.Create(ACompo: TComponentClass;
  ACE: TComponentEditorClass);
begin
  inherited Create;
  FCompoClass := ACompo;
  FCEClass := ACE;
end;

{ Ts0CEFinder }

procedure Ts0CEFinder.AddCEData(ACompoClass: TComponentClass;
  ACEClass: TComponentEditorClass);
begin
  FCEDataList.Insert(0, Ts0CEData.Create(ACompoClass, ACEClass) );
end;

constructor Ts0CEFinder.Create;
begin
  inherited Create;
  FCEDataList := TObjectList.Create;
end;

destructor Ts0CEFinder.Destroy;
begin
  FreeAndNil(FCEDataList);
  inherited;
end;

function Ts0CEFinder.FindCEByComponent(
  ACompoClass: TComponentClass): TComponentEditorClass;
var
  compoClass: TComponentClass;
  i: Integer;
  d: Ts0CEData;
begin
  Result := nil;
  compoClass := TComponentClass(TPersistent);
  for i := 0 to FCEDataList.Count -1 do
  begin
    d := Items[i];
    if not ACompoClass.InheritsFrom(d.FCompoClass) then Continue;
    if d.FCompoClass = compoClass then Continue;
    if not d.FCompoClass.InheritsFrom(compoClass) then Continue;
    Result := d.FCEClass;
    compoClass := d.FCompoClass;
  end;
end;

var
  g9CEFinder: Ts0CEFinder = nil;

function Ts0CEFinder.GetCEByComponent(ACompoClass: TComponentClass;
  AExactly: Boolean): TComponentEditorClass;
  function IsMatched(AData: Ts0CEData; AClass: TComponentClass): Boolean;
  begin
    if AExactly then
      Result := (AData.FCompoClass = AClass)
    else
      Result := AClass.InheritsFrom(AData.FCompoClass);
  end;
var
  i: Integer;
  d: Ts0CEData;
begin
  Result := nil;
  for i := 0 to FCEDataList.Count -1 do
  begin
    d := Items[i];
    if IsMatched(d, ACompoClass) then
      Result := d.FCEClass;
  end;
end;

function Ts0CEFinder.GetCount: Integer;
begin
  Result := FCEDataList.Count;
end;

function Ts0CEFinder.GetItems(const Index: Integer): Ts0CEData;
begin
  Result := Ts0CEData(FCEDataList.Items[Index]);
end;

class function Ts0CEFinder.Instance: Ts0CEFinder;
begin
  if g9CEFinder = nil then
    g9CEFinder := Ts0CEFinder.Create;
  Result := g9CEFinder;
end;

var
  g9OriginalRegisterCE: TRegisterComponentEditorProc = nil;

procedure RegisterCEHook(ComponentClass: TComponentClass;
  ComponentEditor: TComponentEditorClass);
  procedure CallOriginalRegisterCE;
  begin
    if Assigned(g9OriginalRegisterCE) then
      g9OriginalRegisterCE(ComponentClass, ComponentEditor);
  end;
begin
  CallOriginalRegisterCE;
  Ts0CEFinder.Instance.AddCEData(ComponentClass, ComponentEditor);
end;

initialization
  g9OriginalRegisterCE := DesignIntf.RegisterComponentEditorProc;
  DesignIntf.RegisterComponentEditorProc := RegisterCEHook;

finalization
  DesignIntf.RegisterComponentEditorProc := g9OriginalRegisterCE;
  FreeAndNil(g9CEFinder);

end.
