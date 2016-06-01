unit s0Ikkatsu;

interface

uses
  SysUtils, Classes;

type
  K0IkkatsuOption = (k0ioCustomSetting, k0ioDCC32_cfg, k0ioProj_cfg);

type
  Ts0Ikkatsu = class(TComponent)
  private
    FCompilerNames: TStrings;
    FTargets: TStrings;
    procedure SetCompilerNames(const Value: TStrings);
    procedure SetTargets(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CompilerNames: TStrings read FCompilerNames write SetCompilerNames;
    property Targets: TStrings read FTargets write SetTargets;
    procedure Execute;
  end;

implementation

{ Ts0Ikkatsu }

constructor Ts0Ikkatsu.Create(AOwner: TComponent);
begin
  inherited;
  FCompilerNames := TStringList.Create;
  FTargets := TStringList.Create;
end;

destructor Ts0Ikkatsu.Destroy;
begin
  FreeAndNil(FTargets);
  FreeAndNil(FCompilerNames);
  inherited;                 
end;

procedure Ts0Ikkatsu.Execute;
begin

end;

procedure Ts0Ikkatsu.SetCompilerNames(const Value: TStrings);
begin
  FCompilerNames.Assign(Value);
end;

procedure Ts0Ikkatsu.SetTargets(const Value: TStrings);
begin
  FTargets.Assign(Value);
end;

end.
