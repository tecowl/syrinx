{-----------------------------------------------------------------------------
 Unit Name: s0TextComparer
 Author:    akima
 Purpose:
 TestCase: tc_s0TextComparer
 $History: s0TextComparer.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/12   Time: 2:35
 * Updated in $/D6/source/Common
 * Ts0CompareResultItemのプロパティをpublishedに。
 * Compareで、CompareResultをBeginUpdate～EndUpdateするように修正
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/27   Time: 2:42
 * Updated in $/source/D5Integrated
 * 比較の方法を大幅に変えた。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/26   Time: 4:02
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0TextComparer;

interface

uses
  SysUtils, Classes,
  s0Collection;

type
  K0SourceKind = (kskOne, kskTwo);
  K0SourceKindSet = set of K0SourceKind;

type
  K0ComparedType = (kcrDifferent, kcrEqual, kcrLike);
  K0CompareStringEvent = procedure(Sender: TObject; S1, S2: string;
    var AResult: K0ComparedType) of object;

type
  Ts0CompareResultItem = class(Ts0CollectionItem)
  private
    FComparedType: K0ComparedType;
    FStr1: string;
    FStr2: string;
    function GetStr(const Index: Integer): string;
  public
    procedure Assign(Source: TPersistent); override;
    property Strings[const Index: Integer]: string read GetStr; default;
  published
    property Str1: string read FStr1;
    property Str2: string read FStr2;
    property ComparedType: K0ComparedType read FComparedType;
  end;

type
  Ts0CompareResultItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0CompareResultItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0CompareResultItem);
  public
    function Add(AStr1, AStr2: string; AComparedType: K0ComparedType): Ts0CompareResultItem;
    procedure GetResult(Dest: TStrings; AKind: K0SourceKind);
    property Items[const Index: Integer]: Ts0CompareResultItem read GetItems write SetItems; default;
  end;

type
  Ts0PullSL = class(TStringList)
  private
    function GetFirst: string;
  public
    function PullFirst: string;
    property First: string read GetFirst;
  end;

type
  Ts0TextComparer = class(TComponent)
  private
    FOnCompareStr: K0CompareStringEvent;
    FCompareResult: Ts0CompareResultItems;
    FTrimedCompare: Boolean;
    function GetSource(idx: K0SourceKind): TStrings;
    procedure SetCompareResult(const Value: Ts0CompareResultItems);
    function IsEqual(AStr1, AStr2: string): Boolean;
  protected
    FSrc1, FSrc2: Ts0PullSL;
    procedure AddText(ATarget: K0SourceKindSet; ADiff: K0ComparedType);
    function Serach(ASearch, ATarget: K0SourceKind): Integer;
    function NewResultItems: Ts0CompareResultItems; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Compare;
    property Source[idx: K0SourceKind]: TStrings read GetSource;
    property CompareResult: Ts0CompareResultItems read FCompareResult write SetCompareResult;
  published
    property TrimedCompare: Boolean read FTrimedCompare write FTrimedCompare default True;
    property OnCompareStr: K0CompareStringEvent read FOnCompareStr write
      FOnCompareStr;
  end;

implementation

uses
  s0StringHelper;

{ Ts0PullSL }

function Ts0PullSL.GetFirst: string;
begin
  Result := '';
  if Self.Count < 1 then Exit;
  Result := Self.Strings[0];
end;

function Ts0PullSL.PullFirst: string;
begin
  Result := First;
  if Self.Count < 1 then Exit;
  Delete(0);
end;


{ Ts0CompareResultItem }

procedure Ts0CompareResultItem.Assign(Source: TPersistent);
begin

end;

function Ts0CompareResultItem.GetStr(const Index: Integer): string;
begin
  Result := '';
  case Index of
    1: Result := FStr1;
    2: Result := FStr2;
  else
    Assert(False);
  end;
end;

{ Ts0CompareResultItems }

function Ts0CompareResultItems.Add(AStr1, AStr2: string;
  AComparedType: K0ComparedType): Ts0CompareResultItem;
begin
  Result := Ts0CompareResultItem(inherited Add);
  Result.FComparedType := AComparedType;
  Result.FStr1 := AStr1;
  Result.FStr2 := AStr2;
end;

function Ts0CompareResultItems.GetItems(
  const Index: Integer): Ts0CompareResultItem;
begin
  Result := Ts0CompareResultItem(inherited Items[Index]);
end;

procedure Ts0CompareResultItems.GetResult(Dest: TStrings;
  AKind: K0SourceKind);
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    case AKind of
      kskOne: Dest.Add(Items[i].FStr1);
      kskTwo: Dest.Add(Items[i].FStr2);
    end;
  end;
end;

procedure Ts0CompareResultItems.SetItems(const Index: Integer;
  const Value: Ts0CompareResultItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0TextComparer }

procedure Ts0TextComparer.AddText(ATarget: K0SourceKindSet; ADiff:
  K0ComparedType);
var
  i: K0SourceKind;
  t: array[K0SourceKind] of string;
begin
  for i := Low(K0SourceKind) to High(K0SourceKind) do
  begin
    t[i] := '';
    if i in ATarget then
      t[i] := Ts0PullSL(Source[i]).PullFirst;
  end;
  if not Self.IsEqual(t[kskOne], t[kskTwo]) then
  begin
    if Ts0StringHelper.areLike(t[kskOne], t[kskTwo]) then
      ADiff := kcrLike
    else
      ADiff := kcrDifferent;
  end
  else
  begin
    ADiff := kcrEqual;
  end;
  CompareResult.Add(t[kskOne], t[kskTwo], ADiff);
end;

procedure Ts0TextComparer.Compare;
var
  twoBasedOne, oneBasedTwo: Integer;
begin
  FCompareResult.BeginUpdate;
  try
    FCompareResult.Clear;
    while (FSrc1.Count > 0) or (FSrc2.Count > 0) do
    begin
      if not IsEqual(FSrc1.First, FSrc2.First) then
      begin
        twoBasedOne := Serach(kskOne, kskTwo);
        oneBasedTwo := Serach(kskTwo, kskOne);
        if twoBasedOne > 0 then
        begin
          while Serach(kskOne, kskTwo) > 0 do
            AddText([kskTwo], kcrDifferent);
        end
        else
        if oneBasedTwo > 0 then
        begin
          while Serach(kskTwo, kskOne) > 0 do
            AddText([kskOne], kcrDifferent);
        end
        else
        begin
          AddText([kskOne, kskTwo], kcrDifferent);
        end;
      end
      else
      begin
        AddText([kskOne, kskTwo], kcrEqual);
      end;
    end;
  finally
    FCompareResult.EndUpdate;
  end;
end;

constructor Ts0TextComparer.Create(AOwner: TComponent);
begin
  inherited;
  FTrimedCompare := True;
  FCompareResult := NewResultItems;
  FSrc1 := Ts0PullSL.Create;
  FSrc2 := Ts0PullSL.Create;
end;

destructor Ts0TextComparer.Destroy;
begin
  FreeAndNil(FSrc1);
  FreeAndNil(FSrc2);
  FreeAndNil(FCompareResult);
  inherited;
end;

function Ts0TextComparer.GetSource(idx: K0SourceKind): TStrings;
begin
  case idx of
    kskOne:  Result := FSrc1;
    kskTwo:  Result := FSrc2;
  else
    Result := nil;
  end;
end;

function Ts0TextComparer.IsEqual(AStr1, AStr2: string): Boolean;
begin
  if Self.TrimedCompare then
    Result := Trim(AStr1) = Trim(AStr2)
  else
    Result := AStr1 = AStr2;
end;

function Ts0TextComparer.NewResultItems: Ts0CompareResultItems;
begin
  Result := Ts0CompareResultItems.Create(Self, Ts0CompareResultItem);
end;

function Ts0TextComparer.Serach(ASearch, ATarget: K0SourceKind): Integer;
var
  i: Integer;
  s: string;
begin
  //Result := FTarget[ATarget].IndexOf(FTarget[ASearch].Strings[0]);
  Result := -1;
  s := Ts0PullSL(Source[ASearch]).First;
  for i := 0 to Source[ATarget].Count -1 do
  begin
    if IsEqual(Source[ATarget].Strings[i], s) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure Ts0TextComparer.SetCompareResult(
  const Value: Ts0CompareResultItems);
begin
  FCompareResult.Assign(Value);
end;

end.

