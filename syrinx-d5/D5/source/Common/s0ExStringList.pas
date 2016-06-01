unit s0ExStringList;
{
$History: s0ExStringList.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/08   Time: 15:31
 * Updated in $/source/p0common
 * Ts0StringsHelper��s0StringsHelper���j�b�g�Ɉړ��B
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 18:28
 * Updated in $/source/p0common
 * Ts0StringsHelper�̑�{�P�ȃo�O���C��
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/31   Time: 0:00
 * Updated in $/source/p0common
 * Ts0StringsHelper��ǉ�
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/30   Time: 10:05
 * Updated in $/source/p0common
 * Ts0FreeObjStringList.Move���\�b�h�ŁAItem��Free���Ă��܂��Ă����̂ł���
 * ���悤�ɏC��
 * ���߂�Ƃ��� JP���폜
 * 
 * *****************  Version 9  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * �R�����g�\���R�}���h�ǉ�
}

interface

uses
	SysUtils, Classes;

type
	Ts0ExStringList = class(TStringList)
  private
    fDelimiter: Char;
    fQuote: Char;
    function GetDQCommaText: string;
    procedure SetDQCommaText(const Value: string);
  protected
  public
  	constructor Create; virtual;
    property Delimiter: Char read fDelimiter write fDelimiter default ',';
    property Quote: Char read fQuote write fQuote default '"';
  	property DQCommaText: string read GetDQCommaText write SetDQCommaText;
  end;


type
	Ts0StringListReadOnly = class(TStringList)
  private
    FReadOnly: Boolean;
  protected
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetTextStr(const Value: string); override;
  public
  	constructor Create; reintroduce;
    function Add(const S: string): Integer; override;
    procedure AddStrings(Strings: TStrings); override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Sort; override;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default True;
  end;

type
  Ts0FreeObjStringListClass = class of Ts0FreeObjStringList;
	Ts0FreeObjStringList = class(TStringList)
  private
    FClearWithFree: Boolean;
  	procedure DeleteObj(const Index: Integer);
    function RemoveObj(Index: Integer): TObject;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function GetClassType: Ts0FreeObjStringListClass;
    procedure Clear; override;
    // Delete��Index�Ŏw�肵���I�u�W�F�N�g��Free����B
    procedure Delete(Index: Integer); override;
    procedure DeleteByName(AName: string); virtual;
    //
    procedure Move(CurIndex, NewIndex: Integer); override;
    // Remove�ARemoveByName��
    // �I�u�W�F�N�g�����X�g����u���O���v������Free���Ȃ��B
    procedure Remove(pObj: TObject); virtual;
    function RemoveByName(AName: string): TObject; virtual;
    // Clear�ADelete���s������Objects�v���p�e�B��
    // Free���邩�ǂ������w�肷��X�C�b�`�B�f�t�H���g��True�iFree����j
    property ClearWithFree: Boolean read FClearWithFree write FClearWithFree default True;
  end;


type
	Ts0QuoteStringList = class(TStringList)
  public
    function  GetQuoteText: string; overload;
    function  GetQuoteText(ADelim, AQuote: Char): string; overload;
    procedure SetQuoteText(Value: string); overload;
    procedure SetQuoteText(ADelim, AQuote: Char; Value: string); overload;
  end;

type
	Ts0QueueStrings = class(TStringList)
  private
    FMaxEntry: Integer;
    procedure SetMaxEntry(const Value: Integer);
  public
  	constructor Create(AMaxEntry: Integer = 10); reintroduce;
    property MaxEntry: Integer read FMaxEntry write SetMaxEntry;
    function Push(const S: string): Integer;
    function Pop: String;
  end;



type
  T0CutTextModeKind = (kctmQuote, kctmDelim);

type
	Ts0QuoteStringsHelper = class
  private
    //for SetQuoteText
    function cutStr(var s: string; AToken: Char; DelToken: Boolean = True): string;
    function cutStrByDelim(var s: string): string;
    function cutStrByQuote(var s: string): string;
  public
  	FDelim: Char;
    FQuote: Char;
    FMode: T0CutTextModeKind;
    function  GetQuoteText(Source: TStrings): string;
    procedure SetQuoteText(Dest: TStrings; Value: string);
    class function Instance: Ts0QuoteStringsHelper; //<<SINGLETON>>
  end;

type
  // �K�w�I��TStringList���쐬���A�������߂̃N���X�B
  //
  // lTree := Ts0TreeStringList.Create;
  // lTree.AddObjToTree( ['LotA', 'HoldIndication-1'] , 'HoldInfo-1', Entity1);
  // lTree.AddObjToTree( ['LotA', 'HoldIndication-1'] , 'HoldInfo-2', Entity2);
  // lTree.AddObjToTree( ['LotA', 'HoldIndication-2'] , 'HoldInfo-3', Entity3);
  // lTree.AddObjToTree( ['LotB', 'HoldIndication-3'] , 'HoldInfo-1', Entity4);
  //
  // ��L�̃R�[�h�����s����ƁA�ȉ��̂悤�ȍ\��������Ă����B
  //
  // |-[LotA]---[HoldIndication-1]---[HoldInfo-1]-(Entity1)
  // |        |                    |
  // |        |                    |-[HoldInfo-2]-(Entity2)
  // |        |
  // |        |-[HoldIndication-2]---[HoldInfo-3]-(Entity3)
  // |
  // |-[LotB]---[HoldIndication-3]---[HoldInfo-1]-(Entity4)
  //
  // �v���|�[�V���i���ł͂Ȃ��t�H���g�ł����������B
  // []��TStrings��Strings�v���p�e�B�̓��e���A
  // ()��Objects�v���p�e�B���w���Ă���C���X�^���X��\���Ă������ł��B
  Ts0TreeStringList = class(Ts0FreeObjStringList)
  private
  protected
    function FindObj(pObjName: string; var pObj: TObject): Boolean;
    function GetListByName(pListName: string): TStrings;
    function NeedStrings(AListNames: array of string; pMakeBranch: Boolean = True): TStrings;
    class function NewStrings: TStrings; virtual;
  public
    // �[���R�s�[���s�����\�b�h�BTStringList�̂悤��Objects�v���p�e�B�ŎQ�Ƃ��Ă���
    // �C���X�^���X�̎Q�Ƃ������R�s�[����̂ł͂Ȃ��AObjects�v���p�e�B�ŎQ�Ƃ��Ă���
    // �C���X�^���X�̃N���[�����쐬����B
    procedure Assign(Source: TPersistent); override;
    // �����l���������ʂ̃C���X�^���X���쐬���郁�\�b�h�B
    // Objects�v���p�e�B�̃C���X�^���X���N���[�������R�s�[����B
    function Clone: Ts0TreeStringList;
    // �����Ŏw�肵���C���X�^���XpObj���w�肵�����O�̃p�X��ɒǉ����郁�\�b�h�B
    // ��L�̗���Q�Ƃ���ׂ��B
    procedure AddObjToTree(AListNames: array of string; pObjName: string; pObj: TObject);
    // �؍\���̃��X�g���P�̃��X�g�ɓW�J���郁�\�b�h�B
    // �W�J���pDest�ɂ�AddObjToTree��pObjName��Strings�ɁApObj��Objects��
    // �ݒ肳���悤�ɓW�J�����B
    procedure ConvertToFlatList(pDest: TStrings);
    // �����Ŏw�肵���I�u�W�F�N�g���c���[�̒����猟�����č폜����B
    // �폜����Ƃ��ɃI�u�W�F�N�g���t���[���邩�ǂ�����ClearWithFree�v���p�e�B��
    // True���ǂ����ɂ���Č��肷��B
    procedure DeleteObjFromTree(pObj: TObject); virtual;
    // ���O�Ŏw�肵���C���X�^���X���c���[������O�����\�b�h�B
    // ���O�����C���X�^���X��Free����Ȃ��B
    function RemoveByName(AListNames: array of string; AName: string): TObject; reintroduce; overload; virtual;
    // �����Ŏw�肵���C���X�^���X���c���[���ɂ��邩�ǂ������������\�b�h�B
    function Exists(pObj: TObject): Boolean;
    // �c���[������C���X�^���X�𖼑O�Ō������郁�\�b�h�B
    function FindByName(pObjName: string): TObject;
    // �c���[�ɐV���ɊK�w�̃��X�g����郁�\�b�h�B���ɑ��݂���ꍇ�͍��Ȃ��B
    function MakeBranch(AListNames: array of string): TStrings;
    // �p�X�̖��O�ƃC���X�^���X�̖��O����C���X�^���X���������郁�\�b�h�B
    function GetObj(AListNames: array of string; AName: string): TObject;
    // �w�肵���p�X��\��TStrings�̎Q�Ƃ�Ԃ����\�b�h�B
    function GetStrings(AListNames: array of string): TStrings;
    // �c���[���ɒǉ�����Ă���C���X�^���X�̐��𐔂��郁�\�b�h�B
    // pSubTree��False�̏ꍇ�A���̊K�w�̃C���X�^���X�͐����Ȃ��B
    function NodeCount(pSubTree: Boolean = True): Integer; overload;
    // �w�肳�ꂽ�p�X��̃C���X�^���X�̐��𐔂��郁�\�b�h�B
    // ����pSubTree�̈Ӗ���NodeCount(pSubTree: Boolean = True)�̂��̂Ɠ���
    function NodeCount(AListNames: array of string;
      pSubTree: Boolean = True): Integer; overload;
  end;


type
	Ts0IntegerTaggedStringList = class(TStringList)
  private
    function GetIntTags(const Index: Integer): Integer;
    procedure SetIntTags(const Index, Value: Integer);
  protected
  public
  	constructor Create; reintroduce;
    function AddTags(const S: string; ATag: Integer): Integer; virtual;
    procedure InsertTag(Index: Integer; const S: string; ATag: Integer); virtual;
    property IntTags[const Index: Integer]: Integer read GetIntTags write SetIntTags;
  end;


implementation

uses
  s0StringHelper;


{ Ts0ExStringList }

constructor Ts0ExStringList.Create;
begin
  inherited Create;
  fDelimiter := ',';
	fQuote := '"';
end;

function Ts0ExStringList.GetDQCommaText: string;
var
	i: Integer;
begin
  Result := '';
  for i := 0 to Count -2 do
    Result := Result + AnsiQuotedStr(Strings[i], fQuote) + fDelimiter;

  if Count > 0 then
  	Result := Result + AnsiQuotedStr(Strings[Self.Count -1], fQuote);
end;

procedure Ts0ExStringList.SetDQCommaText(const Value: string);
  procedure AddValueByPos(Str: string; aStart, aEnd: Integer);
  var
  	s: string;
    buf: PChar;
    Len: Integer;
  begin
    buf := nil;
    Len := aEnd - aStart +1;
    if Len > 0 then begin
    	s := copy(Str, aStart, aEnd - aStart +1);
      StrPCopy(buf, s);
    end;
    if buf <> nil then Add( AnsiExtractQuotedStr(buf, fQuote) )
    							else Add( '' );
  end;
var
	c, i, LastDelimiterPos: Integer;
begin
//  Clear;

  c := Length(Value);
  LastDelimiterPos := 0;
  for i := 1 to c do
    if IsDelimiter(fDelimiter, Value, i) then begin
      AddValueByPos(Value, LastDelimiterPos + 1, i -1);
      LastDelimiterPos := i;
    end;

  if LastDelimiterPos <> c then
    AddValueByPos(Value, LastDelimiterPos + 1, c);
end;




{ Ts0StringListReadOnly }

constructor Ts0StringListReadOnly.Create;
begin
  inherited Create;
  FReadOnly := True;
end;

procedure Ts0StringListReadOnly.Assign(Source: TPersistent);
var
	buf: Boolean;
begin
  buf := FReadOnly;
	FReadOnly := False;
  try
  	inherited;      
  finally
		FReadOnly := buf;
  end;
end;

function Ts0StringListReadOnly.Add(const S: string): Integer;
begin
  Result := -1;
	if not FReadOnly then
  	Result := inherited Add(S);
end;


procedure Ts0StringListReadOnly.AddStrings(Strings: TStrings);
begin
	if not FReadOnly then
  begin
  	inherited;
  end
  else
  	if FReadOnly then ;
end;

procedure Ts0StringListReadOnly.Clear;
begin
	if not FReadOnly then inherited;
end;

procedure Ts0StringListReadOnly.Delete(Index: Integer);
begin
	if not FReadOnly then inherited;
end;

procedure Ts0StringListReadOnly.Exchange(Index1, Index2: Integer);
begin
	if not FReadOnly then inherited;
end;

procedure Ts0StringListReadOnly.Insert(Index: Integer; const S: string);
begin
	if not FReadOnly then inherited;
end;

procedure Ts0StringListReadOnly.Put(Index: Integer; const S: string);
begin
	if not FReadOnly then inherited;
end;

procedure Ts0StringListReadOnly.PutObject(Index: Integer; AObject: TObject);
begin
	if not FReadOnly then inherited;
end;

procedure Ts0StringListReadOnly.SetTextStr(const Value: string);
begin
	if not FReadOnly then inherited;
end;

procedure Ts0StringListReadOnly.Sort;
begin
	if not FReadOnly then inherited;
end;


{ Ts0FreeObjStringList }

procedure Ts0FreeObjStringList.Clear;
var
	i: Integer;
begin
  if FClearWithFree then
    for i := Self.Count -1 downto 0 do DeleteObj(i);
  inherited;
end;

constructor Ts0FreeObjStringList.Create;
begin
  inherited Create;
  FClearWithFree := True;
end;

procedure Ts0FreeObjStringList.Delete(Index: Integer);
begin
  if ClearWithFree then
    DeleteObj(Index);
  inherited;
end;

procedure Ts0FreeObjStringList.DeleteByName(AName: string);
var
  idx: Integer;
begin
  idx := IndexOf(AName);
  if idx < 0 then Exit;
  Delete(idx);
end;

procedure Ts0FreeObjStringList.DeleteObj(const Index: Integer);
var
  obj: TObject;
begin
  if Objects[Index] <> nil then
  begin
    obj := Objects[Index];
    Objects[Index] := nil;
    FreeAndNil(obj);
  end;
end;

destructor Ts0FreeObjStringList.Destroy;
begin
  Clear;
  inherited;
end;

function Ts0FreeObjStringList.GetClassType: Ts0FreeObjStringListClass;
begin
  Result := Ts0FreeObjStringListClass( Self.ClassType );
end;

procedure Ts0FreeObjStringList.Move(CurIndex, NewIndex: Integer);
var
  buf: Boolean;
begin
  buf := ClearWithFree;
  try
    ClearWithFree := False;
    inherited Move(CurIndex, NewIndex);
  finally
    Self.ClearWithFree := buf;
  end;
end;

procedure Ts0FreeObjStringList.Remove(pObj: TObject);
var
  i: Integer;
begin
  for i := Self.Count -1 downto 0 do
    if Objects[i] = pObj then
      RemoveObj(i);
end;

function Ts0FreeObjStringList.RemoveByName(AName: string): TObject;
var
  idx: Integer;
begin
  Result := nil;
  idx := IndexOf(AName);
  if idx < 0 then Exit;
  Result := RemoveObj(idx);
end;

function Ts0FreeObjStringList.RemoveObj(Index: Integer): TObject;
begin
  Result := Objects[Index];
  inherited Delete(Index);
end;




{ Ts0QuoteStringList }

function Ts0QuoteStringList.GetQuoteText(ADelim, AQuote: Char): string;
begin
	with Ts0QuoteStringsHelper.Instance do begin
		FDelim := ADelim;
  	FQuote := AQuote;
	  result := GetQuoteText(Self);
  end;
end;

function Ts0QuoteStringList.GetQuoteText: string;
begin
  Result := Ts0QuoteStringsHelper.Instance.GetQuoteText(Self);
end;

procedure Ts0QuoteStringList.SetQuoteText(ADelim, AQuote: Char; Value: string);
begin
	with Ts0QuoteStringsHelper.Instance do begin
		FDelim := ADelim;
  	FQuote := AQuote;
	  SetQuoteText(Self, Value);
  end;
end;

procedure Ts0QuoteStringList.SetQuoteText(Value: string);
begin
	Ts0QuoteStringsHelper.Instance.SetQuoteText(Self, Value);
end;





{ Ts0QuoteStringsHelper }

var
	g9QSHelper: Ts0QuoteStringsHelper;

class function Ts0QuoteStringsHelper.Instance: Ts0QuoteStringsHelper;
begin
  if g9QSHelper = nil then begin
    g9QSHelper := Ts0QuoteStringsHelper.Create;
  end;
  Result := g9QSHelper;
end;

function Ts0QuoteStringsHelper.GetQuoteText(Source: TStrings): string;
var
	i: Integer;
begin
	Result := '';
	for i := 0 to Source.Count -1 do
    if Source.Strings[i] = '' then
      Result := Result + FDelim
    else
      Result := Result + FDelim + AnsiQuotedStr(Source.Strings[i], FQuote);
  if Result <> '' then Delete(Result, 1, 1);
end;

procedure Ts0QuoteStringsHelper.SetQuoteText(Dest: TStrings; Value: string);
var
  ts1, ts2: string;
begin
  ts1 := StringReplace(Value, ^J, #13, [rfReplaceAll]);
  while ts1 <> '' do begin
    case FMode of
      kctmQuote: ts2 := cutStrByQuote(ts1);
      kctmDelim: ts2 := cutStrByDelim(ts1);
      else ts2 := ''; //�Ȃ��͂������ǈꉞ����Ƃ�
    end;
    Dest.Add(ts2);
  end;
end;

function Ts0QuoteStringsHelper.cutStr(var s: string; AToken: Char; DelToken: Boolean): string;
var
  idx: Integer;
begin
  Result := '';
  idx := Pos(AToken, s);
  if idx > 0 then begin
    Result := copy(s, 1, idx -1);
    Delete(s, 1, length(Result));
    if DelToken then Delete(s, 1, 1);
  end
  else if s <> '' then begin
    Result := s;
    s := '';
  end;
end;


function Ts0QuoteStringsHelper.cutStrByDelim(var s: string): string;
begin
  result := cutStr(s, FDelim);
end;

function Ts0QuoteStringsHelper.cutStrByQuote(var s: string): string;
var
	ps: PChar;
begin
  ps := PChar(s);
	result :=	AnsiExtractQuotedStr(ps, FQuote);
  s := ps;
  cutStr(s, FQuote, False);
end;

{ Ts0QueueStrings }

constructor Ts0QueueStrings.Create(AMaxEntry: Integer);
begin
  inherited Create;
  FMaxEntry := AMaxEntry;
end;

function Ts0QueueStrings.Pop: String;
begin
	Result := '';
  if Self.Count > 0 then
  	Result := inherited Strings[0];
end;

function Ts0QueueStrings.Push(const S: string): Integer;
begin
  Result := inherited Add(S);
end;

procedure Ts0QueueStrings.SetMaxEntry(const Value: Integer);
begin
  FMaxEntry := Value;
end;



type
  T9StringListHelper = class
  private
    class procedure ConvertNestListToFlat(pSource, pDest: TStrings);
  public
    class function GetObjectByName(pList: TStrings; AName: string): TObject;
    class function GetListByName(pList: TStrings; AName: string): TStrings;
  end;

{ T9StringListHelper }

class procedure T9StringListHelper.ConvertNestListToFlat(pSource, pDest: TStrings);
var
  i: Integer;
begin
  for i := 0 to pSource.Count -1 do
  begin
    if pSource.Objects[i] is TStrings then
    begin
      // �ċA���Ă��̃��\�b�h���Ăяo���܂��B
      ConvertNestListToFlat( TStrings(pSource.Objects[i]), pDest );
    end
    else
    begin
      pDest.AddObject( pSource.Strings[i], pSource.Objects[i] );
    end;
  end;
end;

class function T9StringListHelper.GetListByName(pList: TStrings; AName: string): TStrings;
var
  lObj: TObject;
begin
  Result := nil;
  lObj := GetObjectByName(pList, AName);
  if lObj is TStrings then
    Result := TStrings(lObj);
end;

class function T9StringListHelper.GetObjectByName(pList: TStrings; AName: string): TObject;
var
  idx: Integer;
begin
  Result := nil;
  idx := pList.IndexOf(AName);
  if idx < 0 then Exit;
  Result := pList.Objects[idx];
end;



{ Ts0TreeStringList }

procedure Ts0TreeStringList.AddObjToTree(AListNames: array of string;
  pObjName: string; pObj: TObject);
var
  lDest: TStrings;
begin
  lDest := NeedStrings(AListNames);
  lDest.AddObject(pObjName, pObj);
end;

procedure Ts0TreeStringList.Assign(Source: TPersistent);
  function CloneObj(pSrc: TObject): TObject;
  var
    lPrs: TPersistent;
  begin
    Result := nil;
    if pSrc is TComponent then
    begin
      lPrs := TComponentClass(pSrc.ClassType).Create(nil);
      lPrs.Assign( TComponent(pSrc) );
      Result := lPrs;
    end
    else
    if pSrc is TPersistent then
    begin
      lPrs := TPersistent(pSrc.ClassType.Create);
      lPrs.Assign( TPersistent(pSrc) );
      Result := lPrs;
    end
  end;
var
  lSrc: Ts0TreeStringList;
  i: Integer;
  lObj: TObject;
begin
  Clear;
  if Source is Ts0TreeStringList then
  begin
    lSrc := Ts0TreeStringList(Source);
    for i := 0 to lSrc.Count -1 do
    begin
      if lSrc.Objects[i] is Ts0TreeStringList then
      begin
        lObj := Ts0TreeStringList(lSrc.Objects[i]).Clone;
      end
      else
      begin
        lObj := CloneObj(lSrc.Objects[i]);
      end;
      Self.AddObject( lSrc.Strings[i], lObj);
    end;
  end
  else
  if Source is TStrings then
  begin
    //inherited Assign(Source);
  end;
end;

function Ts0TreeStringList.Clone: Ts0TreeStringList;
var
  lObj: TObject;
begin
  Result := nil;
  lObj := Self.GetClassType.Create;
  if lObj is Ts0TreeStringList then
  begin
    Result := Ts0TreeStringList(lObj);
    Result.Assign(Self);
  end;
end;

procedure Ts0TreeStringList.ConvertToFlatList(pDest: TStrings);
begin
  T9StringListHelper.ConvertNestListToFlat(Self, pDest);
end;

function Ts0TreeStringList.RemoveByName(AListNames: array of string;
  AName: string): TObject;
var
  lList: TStrings;
begin
  Result := nil;
  lList := GetStrings(AListNames);
  if not (lList is Ts0FreeObjStringList) then Exit;
  Result := GetObj(AListNames, AName);
  if Result = nil then Exit;
  Ts0FreeObjStringList(lList).Remove(Result);
end;

procedure Ts0TreeStringList.DeleteObjFromTree(pObj: TObject);
var
  i: Integer;
begin
  if pObj = nil then Exit;
  for i := Self.Count -1 downto 0 do
    if Objects[i] is Ts0TreeStringList then
    begin
      Ts0TreeStringList(Objects[i]).DeleteObjFromTree(pObj);
    end
    else
    if Objects[i] = pObj then
    begin
      Delete(i);
    end;
end;

function Ts0TreeStringList.Exists(pObj: TObject): Boolean;
var
  i: Integer;
begin
  Result := False;
  if pObj = nil then Exit;
  Result := True;
  for i := 0 to Self.Count -1 do
    if Objects[i] is Ts0TreeStringList then
    begin
      if Ts0TreeStringList(Objects[i]).Exists(pObj) then
        Exit;
    end
    else
    if Objects[i] = pObj then
    begin
      Exit;
    end;
  Result := False;
end;

function Ts0TreeStringList.FindByName(pObjName: string): TObject;
begin
  Result := nil;
  FindObj(pObjName, Result);
end;

function Ts0TreeStringList.FindObj(pObjName: string; var pObj: TObject): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Self.Count -1 do
    if Objects[i] is Ts0TreeStringList then
    begin
      if Ts0TreeStringList(Objects[i]).FindObj(pObjName, pObj) then
      begin
        Result := True;
        Exit;
      end;
    end
    else
    if Strings[i] = pObjName then
    begin
      pObj := Objects[i];
      Result := True;
      Exit;
    end;
end;

function Ts0TreeStringList.GetListByName(pListName: string): TStrings;
begin
  Result := T9StringListHelper.GetListByName(Self, pListName);
end;


function Ts0TreeStringList.GetObj(AListNames: array of string; AName: string): TObject;
var
  sl: TStrings;
begin
  Result := nil;
  sl := GetStrings(AListNames);
  if sl = nil then Exit;
  Result := T9StringListHelper.GetObjectByName(sl, AName);
end;

function Ts0TreeStringList.GetStrings(AListNames: array of string): TStrings;
begin
  Result := NeedStrings(AListNames, False);
end;

function Ts0TreeStringList.MakeBranch(AListNames: array of string): TStrings;
begin
  Result := NeedStrings(AListNames, True);
end;

function Ts0TreeStringList.NeedStrings(AListNames: array of string;
  pMakeBranch: Boolean = True): TStrings;
var
  i: Integer;
  lParent, lList: TStrings;
begin
  Result := nil;
  lList := nil;
  lParent := Self;
  for i := Low(AListNames) to High(AListNames) do
  begin
    lList := T9StringListHelper.GetListByName(lParent, AListNames[i]);
    if lList = nil then
    begin
      if pMakeBranch then
      begin
        lList := NewStrings;
        lParent.AddObject( AListNames[i], lList );
      end
      else
      begin
        Exit;
      end;
    end;
    lParent := lList;
  end;
  Result := lList;
end;



class function Ts0TreeStringList.NewStrings: TStrings;
begin
  // �C���X�^���X��TStringList�ō쐬���Ă��ǂ����ǁA
  // TTreeStringList�̃C���X�^���X���쐬���������g���₷���B
  // 
  // ���̃N���X���g�������A�Ƃ������Ƃ����邩������Ȃ��̂�
  // �C���X�^���X�̐����͂��̃��\�b�h�ɔC����B
  // override����ΐ�������N���X��ύX���邱�Ƃ��\�B
  Result := Ts0TreeStringList.Create;
end;


function Ts0TreeStringList.NodeCount(AListNames: array of string; pSubTree: Boolean): Integer;
var
  lList: TStrings;
begin
  Result := 0;
  if Trim(AListNames[Low(AListNames)]) = ''then
  begin
    Result := NodeCount(pSubTree);
  end
  else
  begin
    lList := GetStrings(AListNames);
    if lList is Ts0TreeStringList then
      Result := Ts0TreeStringList(lList).NodeCount(pSubTree);
  end;
end;

function Ts0TreeStringList.NodeCount(pSubTree: Boolean): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count -1 do
  begin
    if Objects[i] is Ts0TreeStringList then
    begin
      if pSubTree then
        Result := Result + Ts0TreeStringList(Objects[i]).NodeCount(True);
    end
    else
    begin
      Inc(Result);
    end;
  end;  
end;



{ Ts0IntegerTaggedStringList }

function Ts0IntegerTaggedStringList.AddTags(const S: string; ATag: Integer): Integer;
begin
  Result := AddObject(S, TObject(ATag));
end;

constructor Ts0IntegerTaggedStringList.Create;
begin
  inherited Create;
end;

function Ts0IntegerTaggedStringList.GetIntTags(const Index: Integer): Integer;
begin
  Result := Integer( inherited Objects[Index] );
end;

procedure Ts0IntegerTaggedStringList.InsertTag(Index: Integer; const S: string; ATag: Integer);
begin
  inherited InsertObject( Index, S, TObject(ATag) );
end;

procedure Ts0IntegerTaggedStringList.SetIntTags(const Index, Value: Integer);
begin
  inherited Objects[Index] := TObject(Value);
end;

initialization

finalization
  FreeAndNil(g9QSHelper);

end.
