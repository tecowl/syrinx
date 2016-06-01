unit s0TreeFilterMaker;
{
$History: s0TreeFilterMaker.pas $
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/22   Time: 17:15
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/02   Time: 3:16
 * Updated in $/source/D5Integrated
 * GetIdentifierを追加
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/27   Time: 9:15
 * Updated in $/source/D5Integrated
 * Ts0TreeFilterItemsメソッドで上位のCollectionのUpdateを呼び出すようにした
 * 。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/23   Time: 1:10
 * Updated in $/source/D5Integrated
 * Ts0TreeFilterItem.GetSubCollectionの戻り値をFSubItemsではなく、SubItems
 * に変更
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/13   Time: 23:26
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/05   Time: 14:26
 * Updated in $/source/D5Integrated
 * Valueのチェックを変更
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0core
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/16   Time: 17:31
 * Updated in $/source/D5/p0core
 * Enabledプロパティ、Assignメソッドを追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/08   Time: 23:10
 * Updated in $/source/p0common
 * 自動更新を実装した
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/08   Time: 16:43
 * Updated in $/source/p0common
 * Itemsの生成をvirtualなNewItemsメソッドで行うようにした。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/07   Time: 16:30
 * Created in $/source/p0common
 * 新規作成
}

interface

uses
  SysUtils, Classes, 
  s0Collection;

type
  K0FilterItemKind = (
    k0fikEqual,
    k0fikNotEqual,
    k0fikLarge,
    k0fikSmall,
    k0fikLargeEqual,
    k0fikSmallEqual
    );

type
  Ts0TreeFilterItems = class;

  Ts0TreeFilterItem = class(Ts0CollectionItem)
  private
    FFieldName: string;
    FOperator: K0FilterItemKind;
    FValue: string;
    FSubItems: Ts0TreeFilterItems;
    FQuoted: Boolean;
    FQuote: string;
    FEnabled: Boolean;
    procedure SetField(const Value: string);
    procedure SetOperator(const Value: K0FilterItemKind);
    procedure SetValue(const Value: string);
    procedure SetSubItems(const Value: Ts0TreeFilterItems);
    procedure SetQuote(const Value: string);
    procedure SetQuoted(const Value: Boolean);
    function GetSubItems: Ts0TreeFilterItems;
    procedure SetEnabled(const Value: Boolean);
  protected
    function GetDataString: string; virtual;
    function GetIdentifier: string; override;
    function GetOwnerItem: Ts0TreeFilterItem;
    function GetSubCollection: Ts0Collection; override;
    function NewSubCollection: Ts0Collection; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Accept(v: Ts0CollectionVisitor); override;
    procedure Assign(Source: TPersistent); override;
    property DataString: string read GetDataString;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property FieldName: string read FFieldName write SetField;
    property Operator: K0FilterItemKind read FOperator write SetOperator;
    property Value: string read FValue write SetValue;
    property SubItems: Ts0TreeFilterItems read GetSubItems write SetSubItems;
    property Quote: string read FQuote write SetQuote;
    property Quoted: Boolean read FQuoted write SetQuoted default True;
  end;

  Ts0TreeFilterItems = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0TreeFilterItem;
    procedure SetItems(const Index: Integer; const Value: Ts0TreeFilterItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function Add: Ts0TreeFilterItem;
    function AddFilter(AFieldName, AValue: string; AOperator: K0FilterItemKind;
      AQuoted: Boolean = True): Ts0TreeFilterItem;
    property Items[const Index: Integer]: Ts0TreeFilterItem read GetItems write
    SetItems;
  end;

type
  {
    Ts0TreeFilterMaker
    Ts0TreeFilterItem達が作るツリー構造に基づいて、and orを組み合わせた
    条件式を作成します。
    ツリーの親子関係はand、兄弟関係はorで結ばれます。


    <変換例>

    ・(AAA) or (BBB)
    (root)
      |-AAA
      |-BBB

    ・(AAA) and (BBB)
    (root)
      |-AAA
         |-BBB

    ・(AAA) and ((BBB) or (CCC))
    (root)
      |-AAA
         |-BBB
         |-CCC

    ・(AAA) and (((BBB) and (DDD)) or (CCC))
    (root)
      |-AAA
         |-BBB
         |  |-DDD
         |
         |-CCC

    実際の条件式には AAA, BBB, CCC, DDD等には、Ts0TreeFilterItemの
    ' <項目名> <演算子> <値>'
    という文字列が相当します。( '<' '>' はここだけで使用している便宜的な
    デリミタです。)
    また(root)と表したものは、Ts0TreeFilterMakerのItemsプロパティです。

    ・<項目名>はTs0TreeFilterItemのFieldNameプロパティに指定されたものが
      そのまま使用されます。

    ・<演算子>はTs0TreeFilterItemのOperatorプロパティに該当するものが
      使用されます。

    ・<値>はTs0TreeFilterItemのValueプロパティに指定されたものが使用されます。
      ただし、QuotedプロパティがTrueの場合は、Quoteプロパティで指定した文字列で
      Valueを挟みます。このQuoteプロパティのデフォルト値はTs0TreeFilterMakerの
      DefaultQuoteプロパティで指定できます。このDefaultQuoteプロパティの
      デフォルト値はシングルクォーテーション(')です。

    詳しい使い方はtc_s0TreeFilterMakerユニットを参照してください。
  }
  Ts0TreeFilterMaker = class(TComponent)
  private
    FItems: Ts0TreeFilterItems;
    FDefaultQuote: string;
    FOnUpdateItem: TNotifyEvent;
    FEnabled: Boolean;
    procedure SetItems(const Value: Ts0TreeFilterItems);
    function GetFilter: string;
    procedure SetEnabled(const Value: Boolean);
  protected
    procedure DoUpdateItem; virtual;
    function NewItems: Ts0TreeFilterItems; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Filter: string read GetFilter;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Items: Ts0TreeFilterItems read FItems write SetItems;
    property DefaultQuote: string read FDefaultQuote write FDefaultQuote;
    property OnUpdateItem: TNotifyEvent read FOnUpdateItem write FOnUpdateItem;
  end;

implementation

{ Ts0TreeFilterItem }

procedure Ts0TreeFilterItem.Accept(v: Ts0CollectionVisitor);
begin
  if not FEnabled then Exit;
  inherited;                
end;

procedure Ts0TreeFilterItem.Assign(Source: TPersistent);
var
  src: Ts0TreeFilterItem;
begin
  inherited;
  if not(Source is Ts0TreeFilterItem) then Exit;
  src := Ts0TreeFilterItem(Source);
  Self.Enabled   := src.Enabled;
  Self.FieldName := src.FieldName;
  Self.Operator  := src.Operator;
  Self.Value     := src.Value;
  Self.Quote     := src.Quote;
  Self.Quoted    := src.Quoted;
  Self.SubItems.Assign(src.SubItems);
end;

constructor Ts0TreeFilterItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FQuoted := True;
  FEnabled := True;
end;

destructor Ts0TreeFilterItem.Destroy;
begin
  FreeAndNil(FSubItems);
  inherited;
end;

function Ts0TreeFilterItem.GetDataString: string;
const
  c9OperatorStrs: array[K0FilterItemKind] of string = (
    '=', //k0fikEqual,
    '<>', //k0fikNotEqual,
    '>', //k0fikLarge,
    '<', //k0fikSmall,
    '>=', //k0fikLargeEqual,
    '<=' //k0fikSmallEqual
    );
const
  c9DataStringFormat = '%s %s %s';
var
  val: string;
begin
  Result := '';
  if FFieldName = '' then
    Exit;
  if FQuoted then
    val := FQuote + FValue + FQuote
  else
    val := FValue;
  if Value = '' then
    Exit;
  Result := Format(c9DataStringFormat, [
    FFieldName, c9OperatorStrs[FOperator], val
      ]);
end;

function Ts0TreeFilterItem.GetIdentifier: string;
begin
  Result := GetDataString;
  if Result = '' then
    Result := FieldName;
  if Result = '' then
    Result := '(Filter Item)';
end;

function Ts0TreeFilterItem.GetOwnerItem: Ts0TreeFilterItem;
begin
  Result := nil;
  if Collection = nil then
    Exit;
  if CollectionAs0Level.OwnerObj is Ts0TreeFilterItem then
    Result := Ts0TreeFilterItem(CollectionAs0Level.OwnerObj);
end;

function Ts0TreeFilterItem.GetSubCollection: Ts0Collection;
begin
  Result := SubItems;
end;

function Ts0TreeFilterItem.GetSubItems: Ts0TreeFilterItems;
begin
  if FSubItems = nil then
    FSubItems := Ts0TreeFilterItems(NewSubCollection);
  Result := FSubItems;
end;

function Ts0TreeFilterItem.NewSubCollection: Ts0Collection;
begin
  Result := Ts0TreeFilterItems.Create(Self, Ts0TreeFilterItem);
end;

procedure Ts0TreeFilterItem.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  Changed(False);
end;

procedure Ts0TreeFilterItem.SetField(const Value: string);
begin
  FFieldName := Value;
  Changed(False);
end;

procedure Ts0TreeFilterItem.SetOperator(const Value: K0FilterItemKind);
begin
  FOperator := Value;
  Changed(False);
end;

procedure Ts0TreeFilterItem.SetQuote(const Value: string);
begin
  FQuote := Value;
  Changed(False);
end;

procedure Ts0TreeFilterItem.SetQuoted(const Value: Boolean);
begin
  FQuoted := Value;
  Changed(False);
end;

procedure Ts0TreeFilterItem.SetSubItems(const Value: Ts0TreeFilterItems);
begin
  FSubItems.Assign(Value);
  if FSubItems.Count < 1 then
    FreeAndNil(FSubItems);
end;

procedure Ts0TreeFilterItem.SetValue(const Value: string);
begin
  FValue := Value;
  Changed(False);
end;

{ Ts0TreeFilterItems }

function Ts0TreeFilterItems.Add: Ts0TreeFilterItem;
begin
  Result := Ts0TreeFilterItem(inherited Add);
end;

function Ts0TreeFilterItems.AddFilter(AFieldName, AValue: string;
  AOperator: K0FilterItemKind; AQuoted: Boolean): Ts0TreeFilterItem;
begin
  Result := Add;
  Result.FieldName := AFieldName;
  Result.Value := AValue;
  Result.Operator := AOperator;
  Result.Quoted := AQuoted;
  if OwnerComponent is Ts0TreeFilterMaker then
    Result.Quote := Ts0TreeFilterMaker(OwnerComponent).DefaultQuote;
end;

function Ts0TreeFilterItems.GetItems(const Index: Integer): Ts0TreeFilterItem;
begin
  Result := Ts0TreeFilterItem(inherited Items[Index])
end;

procedure Ts0TreeFilterItems.SetItems(const Index: Integer;
  const Value: Ts0TreeFilterItem);
begin
  inherited Items[Index] := Value;
end;

procedure Ts0TreeFilterItems.Update(Item: TCollectionItem);
begin
  if OwnerComponent is Ts0TreeFilterMaker then
    Ts0TreeFilterMaker(OwnerComponent).DoUpdateItem;
  inherited Update(Item);
end;

type
  T9TreeFilterVisitor = class(Ts0CollectionVisitor)
  private
    FResultString: string;
  protected
    procedure VisitCollection(ACollection: Ts0Collection); override;
    procedure VisitItem(AItem: Ts0CollectionItem); override;
  public
    procedure Execute(ATarget: Ts0Collection);
    property ResultString: string read FResultString;
  end;

{ T9TreeFilterVisitor }

procedure T9TreeFilterVisitor.Execute(ATarget: Ts0Collection);
begin
  FResultString := '';
  if ATarget = nil then
    Exit;
  ATarget.Accept(Self);
end;

procedure T9TreeFilterVisitor.VisitCollection(ACollection: Ts0Collection);
var
  i: Integer;
  work: string;
begin
  if not (ACollection is Ts0TreeFilterItems) then
    Exit;
  work := '';
  for i := 0 to ACollection.Count - 1 do
  begin
    FResultString := '';
    ACollection.Items[i].Accept(Self);
    if FResultString <> '' then
    begin
      if work = '' then
        work := FResultString
      else
        work := work + ' or ' + FResultString;
    end;
  end;
  if (work <> '') and (ACollection.Count > 1) and
    (Ts0TreeFilterItems(ACollection).OwnerObj is Ts0TreeFilterItem) then
    FResultString := '(' + work + ')'
  else
    FResultString := work;
end;

procedure T9TreeFilterVisitor.VisitItem(AItem: Ts0CollectionItem);
var
  cur: string;
begin
  if not (AItem is Ts0TreeFilterItem) then
    Exit;
  FResultString := '';
  inherited;
  cur := Ts0TreeFilterItem(AItem).DataString;
  if cur = '' then
    Exit;
  cur := '(' + cur + ')';
  if FResultString = '' then
    FResultString := cur
  else if AItem.Collection.Count > 1 then
    FResultString := '(' + cur + ' and ' + FResultString + ')'
  else
    FResultString := cur + ' and ' + FResultString;
end;

{ Ts0TreeFilterMaker }

procedure Ts0TreeFilterMaker.Assign(Source: TPersistent);
var
  src: Ts0TreeFilterMaker;
begin
  if not(Source is Ts0TreeFilterMaker) then Exit;
  src := Ts0TreeFilterMaker(Source);
  Self.Enabled := src.Enabled;
  Self.Items := src.Items;
  Self.DefaultQuote := src.DefaultQuote;
end;

constructor Ts0TreeFilterMaker.Create(AOwner: TComponent);
begin
  FEnabled := True;
  inherited;
  FItems := NewItems;
  FDefaultQuote := '''';
end;

destructor Ts0TreeFilterMaker.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure Ts0TreeFilterMaker.DoUpdateItem;
begin
  if Assigned(FOnUpdateItem) then
    FOnUpdateItem(Self);
end;

function Ts0TreeFilterMaker.GetFilter: string;
var
  v: T9TreeFilterVisitor;
begin
  Result := '';
  if not Enabled then Exit;
  v := T9TreeFilterVisitor.Create;
  try
    v.Execute(FItems);
    Result := v.ResultString;
  finally
    FreeAndNil(v);
  end;
end;

function Ts0TreeFilterMaker.NewItems: Ts0TreeFilterItems;
begin
  Result := Ts0TreeFilterItems.Create(Self, Ts0TreeFilterItem);
end;

procedure Ts0TreeFilterMaker.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if FItems <> nil then
    FItems.Notification(AComponent, Operation);
  inherited;
end;

procedure Ts0TreeFilterMaker.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure Ts0TreeFilterMaker.SetItems(const Value: Ts0TreeFilterItems);
begin
  FItems.Assign(Value);
end;

end.

