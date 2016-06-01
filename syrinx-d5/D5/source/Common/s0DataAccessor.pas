unit s0DataAccessor;
{
$History: s0DataAccessor.pas $
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/10   Time: 3:20
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessor.GetAsIntegerの不具合修正
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/11   Time: 21:41
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/12/10   Time: 16:15
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessor.GetAsString、Ts0StringsAccessor.SetAsStringを修正
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessorを作成。
 * Ts0StringsAccessorはTs0EnumCollectionを使用する。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/30   Time: 1:45
 * Updated in $/source/D5Integrated
 * AsIntegerKindを廃止。
 * これが必要なコントロールのAccessorはそのクラス用に独自にプロパティを
 * 作成することにした。だって普通のコントロールでは使わないんだもん。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/16   Time: 17:31
 * Updated in $/source/D5/p0core
 * AsBoolean,AsDateTime,AsFloatプロパティを追加
 * Ts0NullDataAccessor（Null Objectパターン）を追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/08   Time: 15:30
 * Updated in $/source/p0common
 * HeaderDelimiterプロパティを追加。
 * 派生クラスで使えるメソッドを追加。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/07   Time: 22:31
 * Updated in $/source/p0common
 * 例外クラスの名前を変更
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/07   Time: 21:55
 * Created in $/source/p0common
 * 新規作成
}

interface

uses
  SysUtils, Classes;

type
  Ts0DataAccessor = class(TPersistent)
  private
    FOwner: TComponent;
    FHeaderDelimiter: Char;
    procedure SetOwner(const Value: TComponent);
    procedure SetHeaderDelimiter(const Value: Char);
  protected
    function GetAsBoolean: Boolean; virtual;
    function GetAsDateTime: TDateTime; virtual;
    function GetAsFloat: Double; virtual;
    function GetAsInteger: Integer; virtual;
    function GetAsString: String; virtual;
    function GetHeader: string; virtual;
    procedure SetAsBoolean(const Value: Boolean); virtual;
    procedure SetAsDateTime(const Value: TDateTime); virtual;
    procedure SetAsFloat(const Value: Double); virtual;
    procedure SetAsInteger(const Value: Integer); virtual;
    procedure SetAsString(const Value: String); virtual;
    procedure SetHeader(const Value: string); virtual;
  protected
    function GetHeaderOfText(AText: string): string;
    function IndexOfHeader(AList: TStrings; AHeader: String): Integer;
    function IndexOfHeaderAsInt(AList: TStrings; AHeader: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); virtual;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsString: String read GetAsString write SetAsString;
    property Header: string read GetHeader write SetHeader;
    property Owner: TComponent read FOwner write SetOwner;
  published
    property HeaderDelimiter: Char read FHeaderDelimiter write SetHeaderDelimiter default ':';
  end;


type
  K0StringsAsIntegerKind = (k0saikFromItemIndex, k0saikFromString,
    k0saikFromStringHeader, k0saikFromObjects);

type
  K0StringsAsStringKind = (k0saskIndexString, k0saskText, k0saskCommaText);

type
  Ts0StringsAccessor = class(Ts0DataAccessor)
  private
    FAsIntegerKind: K0StringsAsIntegerKind;
    FAsStringKind: K0StringsAsStringKind;
    FEnumName: string;
    procedure SetAsIntegerKind(const Value: K0StringsAsIntegerKind);
    procedure SetAsStringKind(const Value: K0StringsAsStringKind);
    procedure SetEnumName(const Value: string);
  protected
    function GetAsInteger: Integer; override;
    function GetAsString: String; override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: String); override;
    procedure SetHeader(const Value: String); override;
  protected
    function GetItemIndex: Integer; virtual; abstract;
    function GetSource: TStrings; virtual; abstract;
    procedure SetItemIndex(const Value: Integer); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property Source: TStrings read GetSource;
    procedure LoadEnum;
  published
    property AsIntegerKind: K0StringsAsIntegerKind read FAsIntegerKind
      write SetAsIntegerKind default k0saikFromItemIndex;
    property AsStringKind: K0StringsAsStringKind read FAsStringKind
      write SetAsStringKind default k0saskIndexString;
    property EnumName: string read FEnumName write SetEnumName;
  end;

type
  Es0DataAccessorException = class(Exception);

type
  Ts0NullDataAccessor = class(Ts0DataAccessor)
  public
    class function Instance: Ts0DataAccessor;
  end;


implementation

uses
  s0EnumCollection,
  s0TypeConvertor,
  s0StringsHelper,
  s0StringHelper;

{ Ts0DataAccessor }

constructor Ts0DataAccessor.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
  FHeaderDelimiter := ':';
end;

function Ts0DataAccessor.GetAsBoolean: Boolean;
begin
  Result := False;
end;

function Ts0DataAccessor.GetAsDateTime: TDateTime;
begin
  Result := 0;
end;

function Ts0DataAccessor.GetAsFloat: Double;
begin
  Result := 0;
end;

function Ts0DataAccessor.GetAsInteger: Integer;
begin
  Result := 0;
end;

function Ts0DataAccessor.GetAsString: String;
begin
  Result := '';
end;

function Ts0DataAccessor.GetHeader: string;
begin
  Result := GetHeaderOfText(AsString);
end;

function Ts0DataAccessor.GetHeaderOfText(AText: string): string;
begin
  Result := Ts0StringHelper.GetNameSliced(AText, FHeaderDelimiter);
end;

function Ts0DataAccessor.IndexOfHeader(AList: TStrings;
  AHeader: String): Integer;
begin
  Result := Ts0StringsHelper.IndexOfHeader(AList, AHeader, FHeaderDelimiter);
end;

function Ts0DataAccessor.IndexOfHeaderAsInt(AList: TStrings;
  AHeader: Integer): Integer;
begin
  Result := Ts0StringsHelper.IndexOfHeaderAsInt(AList, AHeader, FHeaderDelimiter);
end;

procedure Ts0DataAccessor.SetAsBoolean(const Value: Boolean);
begin
end;

procedure Ts0DataAccessor.SetAsDateTime(const Value: TDateTime);
begin
end;

procedure Ts0DataAccessor.SetAsFloat(const Value: Double);
begin
end;

procedure Ts0DataAccessor.SetAsInteger(const Value: Integer);
begin
end;

procedure Ts0DataAccessor.SetAsString(const Value: String);
begin          
end;

procedure Ts0DataAccessor.SetHeader(const Value: string);
begin
end;

procedure Ts0DataAccessor.SetHeaderDelimiter(const Value: Char);
begin
  FHeaderDelimiter := Value;
end;

procedure Ts0DataAccessor.SetOwner(const Value: TComponent);
begin
  FOwner := Value;
end;

{ Ts0StringsAccessor }

constructor Ts0StringsAccessor.Create(AOwner: TComponent);
begin
  inherited;
  FAsIntegerKind := k0saikFromItemIndex;
  FAsStringKind := k0saskIndexString;
end;

function Ts0StringsAccessor.GetAsInteger: Integer;
begin
  Result := 0;
  case AsIntegerKind of
    k0saikFromItemIndex   : Result := ItemIndex;
    k0saikFromString      : Result := Ts0TypeConv.StrToInt(Source.Strings[ItemIndex]);
    k0saikFromStringHeader: Result := Ts0TypeConv.StrToInt( Header );
    k0saikFromObjects     :
      if ItemIndex > -1 then
        Result := Integer(Source.Objects[ItemIndex]);
  end;
end;

function Ts0StringsAccessor.GetAsString: String;
begin
  Result := '';
  case AsStringKind of
    k0saskIndexString:
      if ItemIndex > -1 then
        Result := Source.Strings[ItemIndex];
    k0saskText       : Result := Source.Text;
    k0saskCommaText  : Result := Source.CommaText;
  end;
end;

procedure Ts0StringsAccessor.LoadEnum;
var
  enum: Ts0EnumCollection;
  i: Integer;
  s: TStrings;
begin
  enum := Ts0EnumCollectionBroker.Instance.FindByName(Self.EnumName);
  if enum = nil then Exit;
  AsIntegerKind := k0saikFromObjects;
  s := Source;
  s.BeginUpdate;
  try
    s.Clear;
    for i := 0 to enum.Items.Count -1 do
      s.AddObject(enum.Items[i].Text, TObject(enum.Items[i].ItemID));
  finally
    s.EndUpdate;
  end;
end;

procedure Ts0StringsAccessor.SetAsInteger(const Value: Integer);
begin
  case AsIntegerKind of
    k0saikFromItemIndex   : ItemIndex := Value;
    k0saikFromString      : ItemIndex := Source.IndexOf(IntToStr(Value));
    k0saikFromStringHeader: ItemIndex := IndexOfHeaderAsInt(Source, Value);
    k0saikFromObjects     : ItemIndex := Source.IndexOfObject(TObject(Value));
  end;
end;

procedure Ts0StringsAccessor.SetAsIntegerKind(
  const Value: K0StringsAsIntegerKind);
begin
  FAsIntegerKind := Value;
end;

procedure Ts0StringsAccessor.SetAsString(const Value: String);
begin
  case AsStringKind of
    k0saskIndexString: ItemIndex := Source.IndexOf(Value);
    k0saskText       : Source.Text  := Value;
    k0saskCommaText  : Source.CommaText := Value;
  end;
end;

procedure Ts0StringsAccessor.SetAsStringKind(
  const Value: K0StringsAsStringKind);
begin
  FAsStringKind := Value;
end;

procedure Ts0StringsAccessor.SetEnumName(const Value: string);
begin
  FEnumName := Value;
end;

procedure Ts0StringsAccessor.SetHeader(const Value: String);
begin
  ItemIndex := IndexOfHeader(Source, Value);
end;

{ Ts0NullDataAccessor }

var
  g9NullAccessor: Ts0DataAccessor = nil;

class function Ts0NullDataAccessor.Instance: Ts0DataAccessor;
begin
  if g9NullAccessor = nil then
    g9NullAccessor := Ts0NullDataAccessor.Create(nil);
  Result := g9NullAccessor;
end;

initialization

finalization
  FreeAndNil(g9NullAccessor);

end.
