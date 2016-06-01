unit s0Bounds;

interface

uses
  SysUtils, Classes,
  s0Persistent;

type
  Ks0BoundsItemKind = (ks0bkLeft, ks0bkTop, ks0bkWidth, ks0bkHeight);
  Ks0BoundsKindSet = set of Ks0BoundsItemKind;

  Ks0PositionItemKind = ks0bkLeft..ks0bkTop;
  Ks0PositionItemKindSet = set of Ks0PositionItemKind;

  Ks0AreaItemKind = ks0bkWidth..ks0bkHeight;
  Ks0AreaItemKindSet = set of Ks0AreaItemKind;

type
  Is0Position = interface
  ['{7D518E92-9837-4680-9CE4-D23C6F14D289}']
    function GetTop: Integer;
    function GetLeft: Integer;
    procedure SetTop(Value: Integer);
    procedure SetLeft(Value: Integer);
    function GetValue(const AKind: Ks0BoundsItemKind): Integer;
    procedure SetValue(const AKind: Ks0BoundsItemKind; Value: Integer);
    property Top : Integer read GetTop write SetTop;
    property Left: Integer read GetLeft write SetLeft;
  end;

type
  Is0Bounds = interface(Is0Position)
  ['{4F6D4E49-E873-4B28-AC2A-6EF9D3D01623}']
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetWidth(Value: Integer);
    procedure SetHeight(Value: Integer);
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
  end;

type
  Ts0Bounds = class(Ts0InterfacedPersistent, Is0Position, Is0Bounds)
  private
    FBounds: array[Ks0BoundsItemKind] of Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetLeft(Value: Integer);
    procedure SetTop(Value: Integer);
    procedure SetWidth(Value: Integer);
    procedure SetHeight(Value: Integer);
  public
    procedure Assign(Source: TPersistent); override;
    function GetValue(const AKind: Ks0BoundsItemKind): Integer; virtual;
    procedure SetValue(const AKind: Ks0BoundsItemKind; Value: Integer);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); virtual;
  published
    property Left: Integer read GetLeft write SetLeft;
    property Top : Integer read GetTop write SetTop;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
  end;


implementation

{ Ts0Bounds }

procedure Ts0Bounds.Assign(Source: TPersistent);
begin
  inherited;
  if not(Source is Ts0Bounds) then Exit;
  FBounds[ks0bkLeft  ] := Ts0Bounds(Source).FBounds[ks0bkLeft  ];
  FBounds[ks0bkTop   ] := Ts0Bounds(Source).FBounds[ks0bkTop   ];
  FBounds[ks0bkWidth ] := Ts0Bounds(Source).FBounds[ks0bkWidth ];
  FBounds[ks0bkHeight] := Ts0Bounds(Source).FBounds[ks0bkHeight];
end;

function Ts0Bounds.GetHeight: Integer;
begin
  Result := GetValue(ks0bkHeight);
end;

function Ts0Bounds.GetLeft: Integer;
begin
  Result := GetValue(ks0bkLeft);
end;

function Ts0Bounds.GetTop: Integer;
begin
  Result := GetValue(ks0bkTop);
end;

function Ts0Bounds.GetValue(const AKind: Ks0BoundsItemKind): Integer;
begin
  Result := FBounds[AKind];
end;

function Ts0Bounds.GetWidth: Integer;
begin
  Result := GetValue(ks0bkWidth);
end;

procedure Ts0Bounds.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FBounds[ks0bkLeft  ] := ALeft  ;
  FBounds[ks0bkTop   ] := ATop   ;
  FBounds[ks0bkWidth ] := AWidth ;
  FBounds[ks0bkHeight] := AHeight;
end;

procedure Ts0Bounds.SetHeight(Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure Ts0Bounds.SetLeft(Value: Integer);
begin
  SetBounds(Value, Top, Width, Height);
end;

procedure Ts0Bounds.SetTop(Value: Integer);
begin
  SetBounds(Left, Value, Width, Height);
end;

procedure Ts0Bounds.SetValue(const AKind: Ks0BoundsItemKind; Value: Integer);
begin
  FBounds[AKind] := Value;
end;

procedure Ts0Bounds.SetWidth(Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

end.
