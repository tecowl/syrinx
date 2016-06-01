unit s0Iterator;
{
  s0Iterator

  Ts0ListIterator
  Ts0AbstractObjectListIterator
    <|--- Ts0StringsIterator
    <|--- Ts0ObjectListIterator
    <|--- Ts0ComponentListIterator
    <|--- Ts0CollectionIterator

  Delphiは、Javaと違ってGC（Garbage Collection）はないし、
  Interfaceはあっても使いにくいので、良く使われる
  TList, TStrings, TCollection と ContnrsユニットのTObjectList, TComponentList
  それぞれに専用のIteratorを作りました。

  それぞれのListがJavaのようにIteratorメソッドを実装していれば楽ですが、
  それがないので、IteratorのコンストラクタにListを引数として渡します。

$History: s0Iterator.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/30   Time: 14:02
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/06   Time: 1:08
 * Updated in $/source/D5Integrated
 * IsLastの間違いを修正
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/05   Time: 4:32
 * Updated in $/source/D5Integrated
 * HasNextの間違いを修正
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/01/28   Time: 17:14
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/01/23   Time: 3:43
 * Created in $/source/D6VCLIntegrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/17   Time: 23:57
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/18   Time: 19:14
 * Created in $/source/p0common
 * Iterator、ただしJavaのそれとは結構違う
}

interface

uses
  SysUtils, Classes, Contnrs,
  s0Persistent;

type
  Is0ObjIterator = Interface
  ['{CC7B0929-48FB-448B-993A-7BA173D8E8F9}']
    function GetCount: Integer;
    function GetCurrentItem: TObject;
    function GetHasNext: Boolean;
    function Next: TObject;
    property HasNext: Boolean read GetHasNext;
    property Count: Integer read GetCount;
    property CurrentItem: TObject read GetCurrentItem;
  end;

type
  Is0Aggregate = interface
  ['{318D8A92-24B2-464C-AA82-BC6CB2AD69B7}']
    function Iterator: Is0ObjIterator;
  end;



type
  Ts0AbstractIterator = class(Ts0InterfacedPersistent)
  public
    procedure First; virtual; abstract;
    procedure GotoEnd; virtual; abstract;
    procedure Last;  virtual; abstract;
    procedure Next; virtual; abstract;
    procedure Prior; virtual; abstract;
    function IsEnd: Boolean; virtual; abstract;
    function IsFirst: Boolean; virtual; abstract;
    function IsLast: Boolean; virtual; abstract;
    function HasNext: Boolean; virtual; abstract;
    function HasPrior: Boolean; virtual; abstract;
  end;

type
  Ts0IndexIterator = class(Ts0AbstractIterator)
  protected
    FIndex: Integer;
    function GetItemCount: Integer; virtual;
    procedure SetIndex(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure First; override;
    procedure GotoEnd; override;
    procedure Last;  override;
    procedure Next; override;
    procedure Prior; override;
    function IsEnd: Boolean; override;
    function IsFirst: Boolean; override;
    function IsLast: Boolean; override;
    function HasNext: Boolean; override;
    function HasPrior: Boolean; override;
    property Index: Integer read FIndex write SetIndex;
    property ItemCount: Integer read GetItemCount;
  end;

type
  Ts0ListIterator = class(Ts0IndexIterator)
  private
    FSource: TList;
  protected
    function GetItemCount: Integer; override;
  public
    constructor Create(ASource: TList); reintroduce;
    function CurrentItem: Pointer;
    function NextItem: Pointer;
  end;

type
  Ts0AbstractObjectListIterator = class(Ts0IndexIterator, Is0ObjIterator)
  public
    function CurrentItem: TObject; virtual;
    function NextItem: TObject; virtual;
    //
    function Is0ObjIterator.GetCount = GetItemCount;
    function Is0ObjIterator.GetCurrentItem = CurrentItem;
    function Is0ObjIterator.GetHasNext = HasNext;
    function Is0ObjIterator.Next = NextItem;
  end;

type
  Ts0StringsIterator = class(Ts0AbstractObjectListIterator)
  private
    FSource: TStrings;
  protected
    function GetItemCount: Integer; override;
  public
    constructor Create(ASource: TStrings); reintroduce;
    function CurrentItem: TObject; override;
    function CurrentString: string;
    function NextString: string;
  end;

type
  Ts0ObjectListIterator = class(Ts0AbstractObjectListIterator)
  private
    FSource: TObjectList;
  protected
    function GetItemCount: Integer; override;
  public
    constructor Create(ASource: TObjectList); reintroduce;
    function CurrentItem: TObject; override;
  end;

type
  Ts0ComponentListIterator = class(Ts0AbstractObjectListIterator)
  private
    FSource: TComponentList;
  protected
    function GetItemCount: Integer; override;
  public
    constructor Create(ASource: TComponentList); reintroduce;
    function CurrentItem: TObject; override;
    function CurrentComponent: TComponent;
    function NextComponent: TComponent;
  end;

type
  Ts0CollectionIterator = class(Ts0AbstractObjectListIterator)
  private
    FSource: TCollection;
  protected
    function GetItemCount: Integer; override;
  public
    constructor Create(ASource: TCollection); reintroduce;
    function CurrentItem: TObject; override;
    function CurrentCollectionItem: TCollectionItem;
    function NextCollectionItem: TCollectionItem;
  end;
    
type
  Es0IteratorException = class(Exception);

implementation

resourcestring
  c9ErrMsg_SourceIsNil = 'コンストラクタの引数Sourceがnilです';

{ Ts0IndexIterator }

constructor Ts0IndexIterator.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FIndex := 0;
end;

procedure Ts0IndexIterator.First;
begin
  if GetItemCount < 1 then
    FIndex := -1
  else
    FIndex := 0;
end;

function Ts0IndexIterator.GetItemCount: Integer;
begin
  Result := 0;
end;

procedure Ts0IndexIterator.GotoEnd;
begin
  FIndex := GetItemCount;
end;

function Ts0IndexIterator.HasNext: Boolean;
begin
  Result := not IsLast;
end;

function Ts0IndexIterator.HasPrior: Boolean;
begin
  Result := not IsFirst;
end;

function Ts0IndexIterator.IsEnd: Boolean;
begin
  Result := FIndex > GetItemCount -1;
end;

function Ts0IndexIterator.IsFirst: Boolean;
begin
  Result := FIndex < 1;
end;

function Ts0IndexIterator.IsLast: Boolean;
begin
  Result := (FIndex > GetItemCount -1);
end;

procedure Ts0IndexIterator.Last;
begin
  FIndex := GetItemCount -1;
end;

procedure Ts0IndexIterator.Next;
begin
  Inc(FIndex);
  if IsEnd then
    GotoEnd;
end;

procedure Ts0IndexIterator.Prior;
begin
  Dec(FIndex);
  if FIndex < 0 then
    First;
end;

procedure Ts0IndexIterator.SetIndex(const Value: Integer);
begin
  FIndex := Value;
end;

{ Ts0ListIterator }

constructor Ts0ListIterator.Create(ASource: TList);
begin
  if ASource = nil then
    raise Es0IteratorException.Create(c9ErrMsg_SourceIsNil);
  inherited Create(nil);
  FSource := ASource;
end;

function Ts0ListIterator.CurrentItem: Pointer;
begin
  Result := FSource.Items[FIndex];
end;

function Ts0ListIterator.GetItemCount: Integer;
begin
  Result := FSource.Count;
end;

function Ts0ListIterator.NextItem: Pointer;
begin
  Result := CurrentItem;
  Next;
end;

{ Ts0AbstractObjectListIterator }

function Ts0AbstractObjectListIterator.CurrentItem: TObject;
begin
  Result := nil;
end;

function Ts0AbstractObjectListIterator.NextItem: TObject;
begin
  Result := CurrentItem;
  Next;
end;

{ Ts0StringsIterator }

constructor Ts0StringsIterator.Create(ASource: TStrings);
begin
  if ASource = nil then
    raise Es0IteratorException.Create(c9ErrMsg_SourceIsNil);
  inherited Create(nil);
  FSource := ASource;
  FIndex := 0;
end;

function Ts0StringsIterator.CurrentItem: TObject;
begin
  Result := FSource.Objects[FIndex];
end;

function Ts0StringsIterator.CurrentString: string;
begin
  Result := FSource.Strings[FIndex];
end;

function Ts0StringsIterator.GetItemCount: Integer;
begin
  Result := FSource.Count;
end;

function Ts0StringsIterator.NextString: string;
begin
  Result := CurrentString;
  Next;
end;

{ Ts0ObjectListIterator }

constructor Ts0ObjectListIterator.Create(ASource: TObjectList);
begin
  if ASource = nil then
    raise Es0IteratorException.Create(c9ErrMsg_SourceIsNil);
  inherited Create(nil);
  FSource := ASource;
end;

function Ts0ObjectListIterator.CurrentItem: TObject;
begin
  Result := FSource.Items[FIndex];
end;

function Ts0ObjectListIterator.GetItemCount: Integer;
begin
  Result := FSource.Count;
end;

{ Ts0ComponentListIterator }

constructor Ts0ComponentListIterator.Create(ASource: TComponentList);
begin
  if ASource = nil then
    raise Es0IteratorException.Create(c9ErrMsg_SourceIsNil);
  inherited Create(nil);
  FSource := ASource;
end;

function Ts0ComponentListIterator.CurrentComponent: TComponent;
begin
  Result := FSource.Items[FIndex];
end;

function Ts0ComponentListIterator.CurrentItem: TObject;
begin
  Result := CurrentComponent;
end;

function Ts0ComponentListIterator.GetItemCount: Integer;
begin
  Result := FSource.Count;
end;

function Ts0ComponentListIterator.NextComponent: TComponent;
begin
  Result := CurrentComponent;
  Next;
end;

{ Ts0CollectionIterator }

constructor Ts0CollectionIterator.Create(ASource: TCollection);
begin
  if ASource = nil then
    raise Es0IteratorException.Create(c9ErrMsg_SourceIsNil);
  inherited Create(nil);
  FSource := ASource;
  FIndex := 0;
end;

function Ts0CollectionIterator.CurrentCollectionItem: TCollectionItem;
begin
  Result := FSource.Items[FIndex];
end;

function Ts0CollectionIterator.CurrentItem: TObject;
begin
  Result := CurrentCollectionItem;
end;

function Ts0CollectionIterator.GetItemCount: Integer;
begin
  Result := FSource.Count;
end;

function Ts0CollectionIterator.NextCollectionItem: TCollectionItem;
begin
  Result := CurrentCollectionItem;
  Next;
end;

end.
