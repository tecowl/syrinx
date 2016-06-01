unit s0ColorSet;
{
$History: s0ColorSet.pas $
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCaseを使用して文字列の比較を行っていた部分をSameTextを使用するよう
 * に修正
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
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/06   Time: 14:20
 * Updated in $/source/p0control
 * 削除したｃ0LogManagerをusesしていたので、usesから削除した。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 14:08
 * Updated in $/source/p0control
 * Ts0Eventのコンストラクタの変更の反映
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/01   Time: 13:22
 * Updated in $/source/p0control
 * コメントを追加
 *
 * *****************  Version 1  *****************
 * User: Hirakawa     Date: 01/06/22   Time: 9:51
 * Created in $/GUI/Source/View
 * 新規作成
 * 色を一括管理するためのコンポーネントの基底クラス。
}

{
  動機
  アプリケーションごとにグリッドには様々な色の指定がなされる場合があるが、
  その色自身は、システムとしてある程度決めてある。
  アプリ開発者が、いちいちT0ColorDecoなどで色の指定をすると非常に面倒くさいので、
  システムとして一括して色を指定しておき、アプリ開発者は何らかの指定をするだけで
  自動的に色を設定させたい。
  request from  CS山本さん

  使い方
  基本的にアプリ開発者はこのコンポーネントの派生クラスに対して、
  何も操作できないし、してはならない。

  アプリ開発者は、T0ColorDeco.ColorIdentifierなどのプロパティに
  該当する色の指定を行う。その際に指定できるのは、Ts0ColorSetのIdentifierとして
  選択されているものだけである。

  システムの共通仕様担当は、このTs0ColorManagerを継承し、
  LoadItemsメソッドをoverrideして、そのメソッドにおいて
  T0COlorSetのインスタンスを必要な分だけ生成、設定する必要がある。

  アプリ開発者が実際に使用するのは、このシステムの共通仕様担当が
  作成したTs0ColorManagerの派生クラスである。
}

interface

uses
  SysUtils, Classes,
  Graphics,
  s0VCLClasses,
  s0Collection,
  s0Exception,
  s0Observer;

type
  K0ColorKind = (
    k0ckColor, //普通のコントロールの背景色（グリッドのセルの背景色を含む）
    k0ckFontColor, //普通のコントロールの文字色（グリッドのセルの文字色を含む）
    k0ckGridSelColor, //グリッドの選択セルの背景色
    k0ckGridSelFontColor, //グリッドの選択セルの文字色
    k0ckGridFocusColor, //グリッドのフォーカスセルの背景色
    k0ckGridFocusFontColor, //グリッドのフォーカスセルの文字色
    k0ckGridFixedColor, //グリッドの固定セルの背景色
    k0ckGridFixedFontColor //グリッドの固定セルの文字色
    );

type
  K0ColorSetArray = array[K0ColorKind] of TColor;

type
  Ts0ColorSet = class(Ts0VCLCollectionItem)
  private
    FColorSet: K0ColorSetArray;
    FIdentifier: string;
    FComment: string;
    function GetColor(const Index: Integer): TColor;
    procedure SetColor(const Index: Integer; const Value: TColor);
    procedure SetIdentifier(const Value: string);
    procedure SetComment(const Value: string);
  protected
    class function ColorKindByPropIndex(const Value: Integer): K0ColorKind;
    procedure ValidateChange;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetNamePath: string; override;
  published
    {
      Identifier
      識別子。この文字列はユニークになります。
    }
    property Identifier: string read FIdentifier write SetIdentifier;
    {
      Comment
      アプリ開発者がどんなときにこのColorSetを使用するのかが
      分かるようなコメントを書いてあげてね。
    }
    property Comment: string read FComment write SetComment;
    {
      *Color
      色んな色。何に対応するものかは K0ColorKind の記述を見てください。
    }
    property Color: TColor index 0 read GetColor write SetColor;
    property FontColor: TColor index 1 read GetColor write SetColor;
    property GridSelColor: TColor index 2 read GetColor write SetColor;
    property GridSelFontColor: TColor index 3 read GetColor write SetColor;
    property GridFocusColor: TColor index 4 read GetColor write SetColor;
    property GridFocusFontColor: TColor index 5 read GetColor write SetColor;
    property GridFixedColor: TColor index 6 read GetColor write SetColor;
    property GridFixedFontColor: TColor index 7 read GetColor write SetColor;
  end;

type
  Ts0ColorSetCollection = class(Ts0VCLCollection)
  private
    function GetItems(const Index: Integer): Ts0ColorSet;
    procedure SetItems(const Index: Integer; const Value: Ts0ColorSet);
  public
    function Add: Ts0ColorSet; reintroduce; virtual;
    function ItemByIdentifier(AIndentifier: string): Ts0ColorSet;
    property Items[const Index: Integer]: Ts0ColorSet read GetItems write
      SetItems;
  end;

type
  Ts0ColorManager = class(Ts0VCLComponent)
  private
    FItems: Ts0ColorSetCollection;
    FReadOnly: Boolean;
    FOnLoadItems: Ts0Event;
    FLoadedItems: Boolean;
    procedure SetItems(const Value: Ts0ColorSetCollection);
  protected
    {
      AddColorSet
      Ts0ColorSetのインスタンスの生成、設定時に使うメソッド。
    }
    function AddColorSet(AIdentifier: string; AColors: array of TColor;
      AComment: string): Ts0ColorSet;
    {
      CreateItems
      派生クラスでTs0ColorSetCollectionの派生クラスを使用したい場合は、
      このメソッドをoverrideしてね。
    }
    function CreateItems: Ts0ColorSetCollection; virtual;
    procedure Loaded; override;
    {
      ValidateReadOnly
      内部的に使用されるメソッドです。
      何か変更があった場合に、このメソッドによってReadOnly時の書き込み不可などを
      判断しています。
    }
    procedure ValidateReadOnly;
    {
      LoadItems
      システムの共通仕様担当はこのメソッドをoverrideして
      Itemsを生成、設定してください。
    }
    procedure LoadItems; virtual;
    procedure DoLoadItems;
    {
      ReadOnly
      読み込み専用を表す。基本的にTrueの値をとる。
      ただし、内部ではLoadItemsが呼び出される前にReadOnlyはFalseに設定され、
      呼び出された後にTrueに再設定される。
    }
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {
      GetIdentifiers
      ItemsのIdentifierの一覧を取得する。
    }
    procedure GetIdentifiers(Dest: TStrings);
    {
      FindColorSet
      引数AIdentifierと一致するIdentifierを持つTs0ColorSetを検索する。
    }
    function FindColorSet(AIdentifier: string): Ts0ColorSet;
    {
      OnLoadItems
      Itemsがすべて設定された直後に発生するイベント。
    }
    property OnLoadItems: Ts0Event read FOnLoadItems;
    property LoadedItems: Boolean read FLoadedItems;
    {
      Instance
      にせSingletonのためのメソッド。
      このメソッドを呼び出しても、インスタンスを生成するわけではないです。
      インスタンスの参照を簡単に取得するためのもの。
    }
    class function Instance: Ts0ColorManager;
  published
    property Items: Ts0ColorSetCollection read FItems write SetItems stored
      False;
  end;

type
  Es0ColorSetException = class(Es0Exception);

type
  Ts0TestColorManager = class(Ts0ColorManager)
  protected
    {
      LoadItems
      システムの共通仕様担当はこのメソッドをoverrideして
      Itemsを生成、設定してください。
    }
    procedure LoadItems; override;
  end;

implementation

uses
  Controls;

{ Ts0ColorSet }

procedure Ts0ColorSet.Assign(Source: TPersistent);
var
  i: K0ColorKind;
begin
  inherited;
  if Source is Ts0ColorSet then
  begin
    for i := Low(K0ColorKind) to High(K0ColorKind) do
      FColorSet[i] := Ts0ColorSet(Source).FColorSet[i];
  end;
end;

const
  c9ColorKinds: array[0..7] of K0ColorKind = (
    k0ckColor,
    k0ckFontColor,
    k0ckGridSelColor,
    k0ckGridSelFontColor,
    k0ckGridFocusColor,
    k0ckGridFocusFontColor,
    k0ckGridFixedColor,
    k0ckGridFixedFontColor
    );

class function Ts0ColorSet.ColorKindByPropIndex(const Value: Integer):
  K0ColorKind;
begin
  Result := c9ColorKinds[Value];
end;

const
  c9ColorSetDefault: K0ColorSetArray = (
    clWindow, // k0ckColor
    clWindowText, // k0ckFontColor
    clTeal, // k0ckGridSelColor
    clWhite, // k0ckGridSelFontColor
    clBlack, // k0ckGridFocusColor
    clWhite, // k0ckGridFocusFontColor
    clBtnFace, // k0ckGridFixedColor
    clBlack // k0ckGridFixedFontColor
    );

constructor Ts0ColorSet.Create(Collection: TCollection);
begin
  ValidateChange;
  inherited;
  FIdentifier := '';
  FComment := '';
  FColorSet := c9ColorSetDefault;
end;

destructor Ts0ColorSet.Destroy;
begin
  ValidateChange;
  inherited;
end;

function Ts0ColorSet.GetColor(const Index: Integer): TColor;
begin
  Result := FColorSet[ColorKindByPropIndex(Index)];
end;

function Ts0ColorSet.GetNamePath: string;
begin
  Result := FIdentifier;
  if Result <> '' then
    Exit;
  Result := inherited GetNamePath;
end;

procedure Ts0ColorSet.SetColor(const Index: Integer; const Value: TColor);
begin
  ValidateChange;
  FColorSet[ColorKindByPropIndex(Index)] := Value;
end;

resourcestring
  c9ErrMsg_DuplicateIdentifier = 'Duplicate Identifier';

procedure Ts0ColorSet.SetComment(const Value: string);
begin
  ValidateChange;
  FComment := Value;
end;

procedure Ts0ColorSet.SetIdentifier(const Value: string);
begin
  ValidateChange;
  if Collection is Ts0ColorSetCollection then
    if Ts0ColorSetCollection(Collection).ItemByIdentifier(Value) <> nil then
      raise Es0ColorSetException.Create(c9ErrMsg_DuplicateIdentifier);
  FIdentifier := Trim(Value);
end;

procedure Ts0ColorSet.ValidateChange;
begin
  if Ts0ColorManager.Instance = nil then
    Exit;
  Ts0ColorManager.Instance.ValidateReadOnly;
end;

{ Ts0ColorSetCollection }

function Ts0ColorSetCollection.Add: Ts0ColorSet;
begin
  Result := Ts0ColorSet(inherited Add);
end;

function Ts0ColorSetCollection.GetItems(const Index: Integer): Ts0ColorSet;
begin
  Result := Ts0ColorSet(inherited Items[Index]);
end;

function Ts0ColorSetCollection.ItemByIdentifier(
  AIndentifier: string): Ts0ColorSet;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.Count - 1 do
    if SameText(Self.Items[i].Identifier, AIndentifier) then
    begin
      Result := Self.Items[i];
      Exit;
    end;
end;

procedure Ts0ColorSetCollection.SetItems(const Index: Integer;
  const Value: Ts0ColorSet);
begin
  if Ts0ColorManager.Instance <> nil then
    Ts0ColorManager.Instance.ValidateReadOnly;
  inherited Items[Index] := Value;
end;

{ Ts0ColorManager }

function Ts0ColorManager.AddColorSet(AIdentifier: string;
  AColors: array of TColor; AComment: string): Ts0ColorSet;
var
  i: Integer;
  colMin: Integer;
  idx: Integer;
begin
  Result := Items.Add;
  Result.FIdentifier := AIdentifier;
  Result.FComment := AComment;
  colMin := Low(AColors);
  for i := Low(AColors) to High(AColors) do
  begin
    idx := i - colMin;
    if idx < Low(c9ColorKinds) then
      Continue;
    if idx > High(c9ColorKinds) then
      Continue;
    Result.FColorSet[Ts0ColorSet.ColorKindByPropIndex(idx)] := AColors[i];
  end;
end;

var
  g9ColorMan: Ts0ColorManager = nil;

constructor Ts0ColorManager.Create(AOwner: TComponent);
begin
  inherited;
  FItems := CreateItems;
  FOnLoadItems := Ts0Event.Create(Self);
  FLoadedItems := False;
  //
  if g9ColorMan = nil then
  begin
    g9ColorMan := Self;
  end;
end;

function Ts0ColorManager.CreateItems: Ts0ColorSetCollection;
begin
  Result := Ts0ColorSetCollection.Create(Self, Ts0ColorSet);
end;

destructor Ts0ColorManager.Destroy;
begin
  if g9ColorMan = Self then
  begin
    g9ColorMan := nil;
  end;
  FreeAndNil(FOnLoadItems);
  FreeAndNil(FItems);
  inherited;
end;

procedure Ts0ColorManager.DoLoadItems;
begin
  FOnLoadItems.NotifyAll;
  FLoadedItems := True;
end;

function Ts0ColorManager.FindColorSet(AIdentifier: string): Ts0ColorSet;
begin
  Result := FItems.ItemByIdentifier(AIdentifier);
end;

procedure Ts0ColorManager.GetIdentifiers(Dest: TStrings);
var
  i: Integer;
begin
  Dest.Clear;
  for i := 0 to FItems.Count - 1 do
    Dest.Add(FItems.Items[i].Identifier);
end;

class function Ts0ColorManager.Instance: Ts0ColorManager;
begin
  Result := g9ColorMan;
end;

procedure Ts0ColorManager.Loaded;
begin
  inherited;
  FReadOnly := False;
  try
    LoadItems;
  finally
    FReadOnly := True;
  end;
  DoLoadItems;
end;

procedure Ts0ColorManager.LoadItems;
begin
  {
    システムの共通仕様担当の方は、このメソッドをoverrideして
    Itemsの生成、設定をやってください。
  }
end;

procedure Ts0ColorManager.SetItems(const Value: Ts0ColorSetCollection);
begin
  ValidateReadOnly;
  FItems.Assign(Value);
end;

resourcestring
  c9ErrMsg_ColorSetIsReadOnly = 'ColorSet is ReadOnly.';

procedure Ts0ColorManager.ValidateReadOnly;
begin
  if csDestroying in Self.ComponentState then
    Exit;
  if Self.ReadOnly then
    raise Es0ColorSetException.Create(c9ErrMsg_ColorSetIsReadOnly);
end;

{ Ts0TestColorManager }

procedure Ts0TestColorManager.LoadItems;
begin
  AddColorSet(
    'Test01',
    [clWindow, clWindowText, clTeal, clWhite, clBlack, clWhite, clBtnFace,
      clBlack],
    'テスト用ですんでテキトーに書いちゃってますですデス'
    );

  AddColorSet(
    'Test02',
    [clWindow, clBlue, clTeal, clWhite, clBlack, clWhite, clBtnFace, clBlack],
    'Urrrrrrryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
    );
end;

end.
