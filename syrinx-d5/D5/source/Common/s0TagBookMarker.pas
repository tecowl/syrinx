{-----------------------------------------------------------------------------
 Unit Name: s0TagBookMarker
 Author:    akima
 Purpose:
 TestCase: tc_s0TagBookMarker
 $History: s0TagBookMarker.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * ê⁄ì™é´ÇïœçXÅBxxSXÅ`Ç…ÇµÇΩÅB
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/02/21   Time: 23:10
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0TagBookMarker;

interface

uses
  SysUtils, Classes,
  s0TagPolicy,
  s0TaggedPage,
  s0Collection;

type
  Ts0TagBookMarker = class(Ts0TagPolicyComponent)
  private
    FTarget: Ts0TaggedPage;
    FFindTags: TStrings;
    procedure SetFindTags(const Value: TStrings);
    procedure SetTarget(const Value: Ts0TaggedPage);
  protected
    FMarkingNum: Integer;
    procedure FindTargetItems(Dest: Ts0CollectionItemList);
    procedure InsertMarkTag(AFound: Ts0Tag);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
  published
    property Target: Ts0TaggedPage read FTarget write SetTarget;
    property FindTags: TStrings read FFindTags write SetFindTags;
  end;

implementation

{ Ts0TagBookMarker }

constructor Ts0TagBookMarker.Create(AOwner: TComponent);
begin
  inherited;
  FFindTags := TStringList.Create;
end;

destructor Ts0TagBookMarker.Destroy;
begin
  FreeAndNil(FFindTags);
  inherited;            
end;

procedure Ts0TagBookMarker.Execute;
var
  lst: Ts0CollectionItemList;
  i: Integer;
begin              
  Assert(FTarget <> nil);
  FMarkingNum := 1;
  lst := Ts0CollectionItemList.Create(False);
  try
    FindTargetItems(lst);
    for i := 0 to lst.Count -1 do
    begin
      Assert(lst.Items[i] is Ts0Tag);
      InsertMarkTag(Ts0Tag(lst.Items[i]));
    end;
  finally
    FreeAndNil(lst);
  end;
end;

procedure Ts0TagBookMarker.FindTargetItems(Dest: Ts0CollectionItemList);
var
  lst: Ts0CollectionItemList;
  i, j: Integer;
begin
  lst := Ts0CollectionItemList.Create(False);
  try
    for i := 0 to FindTags.Count -1 do
    begin
      FTarget.Contents.FindByTagName(lst, FindTags.Strings[i], [k0tfoUseMask, k0tfoIgnoreCase, k0tfoNestSearch]);
      for j := 0 to lst.Count -1 do
        Dest.Add(lst.Items[j]);
    end;
  finally
    FreeAndNil(lst);
  end;
end;

procedure Ts0TagBookMarker.InsertMarkTag(AFound: Ts0Tag);
  function GetMarkParam: string;
  begin
    Result := Format('name="%-4.4d"', [FMarkingNum]);
    Inc(FMarkingNum);
  end;                   
var
  idx: Integer;
  foundPair: Ts0Tag;
  parentContent: Ts0Tags;
  markTag: Ts0Tag;
begin
  foundPair := AFound.PairTag;
  Assert(AFound.Collection is Ts0Tags);
  parentContent := Ts0Tags(AFound.Collection);
  idx := AFound.Index;
  //
  markTag := parentContent.InsertTagWithParam(idx, 'a', [GetMarkParam]);
  AFound.ParentTag := markTag;
  //
  if foundPair <> nil then
    foundPair.ParentTag := markTag;
end;

procedure Ts0TagBookMarker.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTarget = AComponent then
    FTarget := nil;
end;

procedure Ts0TagBookMarker.SetFindTags(const Value: TStrings);
begin
  FFindTags.Assign(Value);
end;

procedure Ts0TagBookMarker.SetTarget(const Value: Ts0TaggedPage);
begin
  FTarget := Value;
  if FTarget <> nil then
    PolicyName := FTarget.PolicyName;
end;

end.
