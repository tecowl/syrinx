unit s8EnumProto;

interface

uses
  SysUtils, Classes,
  s0Collection;

type
  Ts8EnumProto = class(Ts0CollectionItem)
  private
    FEnumName: string;
    FTextField: string;
    FTanbleName: string;
    FItemIDField: string;
    procedure SetEnumName(const Value: string);
    procedure SetItemIDField(const Value: string);
    procedure SetTanbleName(const Value: string);
    procedure SetTextField(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property EnumName: string read FEnumName write SetEnumName;
    property TanbleName: string read FTanbleName write SetTanbleName;
    property ItemIDField: string read FItemIDField write SetItemIDField;
    property TextField: string read FTextField write SetTextField;
  end;

type
  Ts8EnumProtos = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts8EnumProto;
    procedure SetItems(const Index: Integer; const Value: Ts8EnumProto);
  public
    function Add(AEnumName: string): Ts8EnumProto;
    property Items[const Index: Integer]: Ts8EnumProto read GetItems write SetItems;
  end;

implementation

{ Ts8EnumProto }

procedure Ts8EnumProto.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is Ts8EnumProto) then Exit;
  FEnumName    := Ts8EnumProto(Source).FEnumName   ;
  FTextField   := Ts8EnumProto(Source).FTextField  ;
  FTanbleName  := Ts8EnumProto(Source).FTanbleName ;
  FItemIDField := Ts8EnumProto(Source).FItemIDField;
end;

procedure Ts8EnumProto.SetEnumName(const Value: string);
begin
  FEnumName := Value;
  Changed(False);
end;

procedure Ts8EnumProto.SetItemIDField(const Value: string);
begin
  FItemIDField := Value;
  Changed(False);
end;

procedure Ts8EnumProto.SetTanbleName(const Value: string);
begin
  FTanbleName := Value;
  Changed(False);
end;

procedure Ts8EnumProto.SetTextField(const Value: string);
begin
  FTextField := Value;
  Changed(False);
end;

{ Ts8EnumProtos }

function Ts8EnumProtos.Add(AEnumName: string): Ts8EnumProto;
begin
  Result := Ts8EnumProto(inherited Add);
  Result.FEnumName := AEnumName;
end;

function Ts8EnumProtos.GetItems(const Index: Integer): Ts8EnumProto;
begin
  Result := Ts8EnumProto(inherited Items[Index]);
end;

procedure Ts8EnumProtos.SetItems(const Index: Integer;
  const Value: Ts8EnumProto);
begin
  inherited Items[Index] := Value;
end;

initialization
  RegisterClass(Ts8EnumProto);
  RegisterClass(Ts8EnumProtos);

finalization
  UnRegisterClass(Ts8EnumProto);
  UnRegisterClass(Ts8EnumProtos);
  
end.
