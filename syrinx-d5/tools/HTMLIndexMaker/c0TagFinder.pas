unit c0TagFinder;

interface

uses
  SysUtils, Classes,
  s0Collection;

type
  Tc0TagFinder = class(TComponent)
  private
    FNoDelimTags: TStrings;
    procedure SetNoDelimTags(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property NoDelimTags: TStrings read FNoDelimTags write SetNoDelimTags;
  end;


implementation

{ Tc0TagFinder }

constructor Tc0TagFinder.Create(AOwner: TComponent);
begin
  inherited;
  FNoDelimTags := TStringList.Create;
end;

destructor Tc0TagFinder.Destroy;
begin
  FreeAndNil(FNoDelimTags);
  inherited;               
end;

procedure Tc0TagFinder.SetNoDelimTags(const Value: TStrings);
begin
  FNoDelimTags.Assign(Value);
end;

end.
