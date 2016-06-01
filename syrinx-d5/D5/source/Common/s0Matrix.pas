unit s0Matrix;
{
$History: s0Matrix.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/10/01   Time: 16:31
 * Updated in $/source/D5Integrated
 * �N�H�[�e�[�V�����̒��̉��s��F������悤�ɂ����B
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0common
 * u0GUIType��u0GUIViewType�����t�@�N�^�����O�������ʁA������p�~���A
 * s0CommonTypes�Ƃ��Ă܂Ƃ߂��̂ŁA����ɑΉ������B
 * 
 * *****************  Version 20  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * �R�����g�\���R�}���h�ǉ�
}
{
  �ύX����

  2001/06/15
    DeleteRows�AInsertBlankRows���\�b�h��ǉ��B
    OnDeleteRow�AOnInsertBlankRow�C�x���g��ǉ��B

    Assign�AClear�ADeleteRows�AInsertBlankRows���\�b�h�ɂ����āA
    �}�g���b�N�X�̃f�[�^��ύX����OnChange�C�x���g���������Ȃ��悤�ɁA
    �����o�ϐ�FChanging��ǉ��B
}
interface

uses
	SysUtils, Classes,
	s0ExStringList;


type
	K0NeedSortKeyEvent = procedure(Sender: TObject; ARow: Integer; var AKey: string) of object;
  K0MatrixRowEvent = procedure(Sender: TObject; ARowIndex, ARowCount: Integer) of object;

type
  {
    Ts0Matrix
    �O���b�h�ŕ\�������悤��2�����̃f�[�^�\����\���N���X�B
    ���̃N���X�́A���������f�[�^�\����\�����߂̃C���^�t�F�[�X���`���Ă��邾���ŁA
    �����̎����͔h���N���X�ōs���B���Ă̒ʂ�A���ۃ��\�b�h�����B
    ����Ă��̃N���X�̃C���X�^���X�͐������Ă͂Ȃ�Ȃ��B
    ��������K�v������ꍇ�A���̃N���X�̔h���N���X�̃C���X�^���X�𐶐����邱�ƁB
  }
	Ts0Matrix = class(TPersistent)
  private
    FSortIndex: Integer;
    FOnChange: TNotifyEvent;
    FOnDeleteRow: K0MatrixRowEvent;
    FOnInsertBlankRow: K0MatrixRowEvent;
    procedure SetTitleRow(const Value: TStrings);
    function GetCommaText: string;
    function GetText: string;
    procedure SetSortIndex(const Value: Integer);
  protected
    FChanging: Boolean;
  	FTitleRow: TStrings;
    FOnNeedSortKey: K0NeedSortKeyEvent;
    function GetMaxCol: Integer; virtual; abstract;
    function GetMaxRow: Integer; virtual; abstract;
    function GetSorted: Boolean; virtual; abstract;
    procedure SetSorted(const Value: Boolean); virtual; abstract;
    function GetCells(const x, y: Integer): string; virtual; abstract;
    procedure SetCells(const x, y: Integer; const Value: string); virtual; abstract;
    function GetRows(const Index: Integer): TStrings; virtual; abstract;
    procedure DelCol(const Index: Integer); virtual; abstract;
    procedure DelRow(const Index: Integer); virtual; abstract;
    procedure DoChange; virtual;
    procedure DoDeleteRows(const ARowIndex, ARowCount: Integer); virtual;
    procedure DoInsertBlankRows(const ARowIndex, ARowCount: Integer); virtual;
  public
  	constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    {
      AddRow
      Matrix�ɍs��ǉ����郁�\�b�h�B
      �ǉ������AData��TStrings�̕��́A�����Ŏw�肵���C���X�^���X��
      �}�g���b�N�X�ɒǉ�����킯�ł͂Ȃ��āA�����Ŏw�肵���C���X�^���X�̃f�[�^��
      �R�s�[���ă}�g���b�N�X�ɒǉ�����B

      �u�I�����ō�����C���X�^���X�́A�����Ŕj�����悤�I�v�Ƃ������j�ɂ̂��Ƃ��Ă���B
      InsertRow�����l
    }
  	function AddRow(const AData: array of string; AKey: string = ''): Integer; overload; virtual; abstract;
  	function AddRow(const AData: TStrings; AKey: string = ''): Integer; overload; virtual; abstract;
    {
      Assign
      �f�[�^�̃R�s�[���s���B
    }
    procedure Assign(Source: TPersistent); override;
    {
      Clear
      �f�[�^�����ׂď�������BColCount�ARowCount�v���p�e�B��0�ɂȂ�B
    }
    procedure Clear; virtual; abstract;
    {
      DeleteRow
      �s���폜����B

      DeleteRows
      ARowIndex�Ŏw�肵���s����AARowCount���̍s���폜����B
    }
    procedure DeleteRow(const Index: Integer); virtual;
    procedure DeleteRows(const ARowIndex, ARowCount: Integer);
    {
      Equals
      �ێ����Ă���f�[�^�������Ŏw�肳�ꂽMatrix�Ɠ����ꍇ��True
    }
    function Equals(AMatrix: Ts0Matrix): Boolean; virtual;
    {
      InsertRow

      �����Ŏw�肵��Matrix�̍s�ɁA�󔒂̍s��}�����郁�\�b�h�B
      �ǉ������AData��TStrings�̕��́A�����Ŏw�肵���C���X�^���X��
      �}�g���b�N�X�ɒǉ�����킯�ł͂Ȃ��āA�����Ŏw�肵���C���X�^���X�̃f�[�^��
      �R�s�[���ă}�g���b�N�X�ɑ}������B

      �u�I�����ō�����C���X�^���X�́A�����Ŕj�����悤�I�v�Ƃ������j�ɂ̂��Ƃ��Ă���B
      AddRow�����l
    }
  	function InsertRow(ARow: Integer; const AData: array of string; AKey: string = ''): Integer; overload; virtual; abstract;
  	function InsertRow(ARow: Integer; const AData: TStrings; AKey: string = ''): Integer; overload; virtual; abstract;
    procedure InsertBlankRows(const ARowIndex, ARowCount: Integer);
    {
      SaveToStream�ALoadFromStream
      Matrix�̃f�[�^��TStream�ɕۑ�/�ǂݍ��݂��s���B
    }
    procedure SaveToStream(ADest: TStream; ADelim: Char = ','; AQuote: Char = '"');
    procedure LoadFromStream(ASource: TStream; ADelim: Char = ','; AQuote: Char = '"');
    {
      Sort
      �\�[�g���s���B
      ����AReverse��True�Ɏw�肷��ƁA�t���Ń\�[�g����B
    }
    procedure Sort(AReverse: Boolean = False); virtual; abstract;
    {
      RefreshSortKey
      OnNeedSortKeyByIndex
      �\�[�g���s���ۂ̃L�[�̕�������Đݒ肷�邽�߂̃��\�b�h�B
      ���̃��\�b�h�ł́ASortIndex�v���p�e�B�Ŏw�肵�����
      �e�Z���̒l�������I�ɃL�[���ڂƂ��Đݒ肷��B
      ���̌�A�e�Z�����Ƃ�OnNeedSortKeyByIndex�C�x���g�𔭐����A
      �����I�ɐݒ肳�ꂽ�l��ύX���邱�Ƃ��ł���B
    }
    procedure RefreshSortKey; virtual; abstract;
    {
      Cells
      �}�g���b�N�X���ێ�����2�����̃f�[�^���ꂼ��ɒl��ݒ�/�擾���邽�߂̃v���p�e�B�B
    }
  	property Cells[const x, y: Integer]: string read GetCells write SetCells;
    {
      ColCount�ARowCount
      �}�g���b�N�X���ێ�����2�����̃f�[�^�̗񐔁A�s���������B�ݒ�s�B
    }
    property ColCount: Integer read GetMaxCol;
    property RowCount: Integer read GetMaxRow;
    {
      Rows
      �}�g���b�N�X�̊e�s��TStrings�Ƃ��Ĉ������߂̃v���p�e�B�B
    }
    property Rows[const Index: Integer]: TStrings read GetRows;
    {
      Sorted
      �}�g���b�N�X���A�s�P�ʂŃ\�[�g����Ă��邩�ۂ��������B
      True���ݒ肳�ꂽ�ꍇ�A�����I��RefreshSortKey�����s���A�\�[�g���s���B
    }
    property Sorted: Boolean read GetSorted write SetSorted;
    {
      SortIndex
      �\�[�g���s���ۂ̃L�[���ڂ�������������ۂɁA�ǂ̗�̃Z���̒l��
      �g�p����̂����w�肷��v���p�e�B�B
    }
    property SortIndex: Integer read FSortIndex write SetSortIndex;
    {
      TitleRow
      �e�񂪂ǂ̂悤�ȃf�[�^��ێ�����̂���\���A�������񂲂Ƃɕ\�����邽�߂�
      �����񃊃X�g�B
      �����A�قƂ�ǎg��Ȃ��ł��B
    }
    property TitleRow: TStrings read FTitleRow write SetTitleRow;
    property OnNeedSortKeyByIndex: K0NeedSortKeyEvent read FOnNeedSortKey write FOnNeedSortKey;
  public
    {
      Text�ACommaText
      �}�g���b�N�X�̓��e�𕶎���Ƃ��Ď擾���邽�߂̃v���p�e�B�B�ǂݍ��ݐ�p�B
      Text�v���p�e�B�́A�������P���Ɍq���邪�ACommaText�́A�_�u���N�H�[�e�[�V�����A
      �J���}�ɂ���Ċe�Z���̒l����؂�B
    }
    property Text: string read GetText;
    property CommaText: string read GetCommaText;
    {
      OnChange
      �\�[�g���ꂽ�ꍇ��A�e�Z���̒l�ȂǂɕύX���������ꍇ�ɁA
      ���s�����C�x���g�B
    }
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDeleteRow: K0MatrixRowEvent read FOnDeleteRow write FOnDeleteRow;
    property OnInsertBlankRow: K0MatrixRowEvent read FOnInsertBlankRow write FOnInsertBlankRow;
  end;

type
  {
    Ts0MatrixMaker
    TStream���邢�͕����񂩂�f���~�^�Ȃǂɂ���ăZ���̒l��؂�o���A
    FMatrix�ɒl��ݒ肷�邽�߂̃N���X�B

    ��{�I�ɓ����Ŏg�p����邾���B
  }
	Ts0MatrixMaker = class
  public
    FDelim: Char;
    FQuote: Char;
    FMode: T0CutTextModeKind;
    FTarget: Ts0Matrix;
    constructor Create;
    procedure cut2Matrix(Source: TStream); overload;
    procedure cut2Matrix(Source: String); overload;
    class function Instance: Ts0MatrixMaker; //<<SINGLETON>>
  end;



type
	Ts0RowBaseMatrix = class(Ts0Matrix)
  private
  	FMaxCol: Integer;
  protected
  	FBaseColumn: TStrings;
    function GetSorted: Boolean; override;
    procedure SetSorted(const Value: Boolean); override;
    function GetCells(const x, y: Integer): string; override;
    procedure SetCells(const x, y: Integer; const Value: string); override;
    function GetMaxCol: Integer; override;
    function GetMaxRow: Integer; override;
    function GetColCountByRow(const Index: Integer): Integer;
    function GetRows(const Index: Integer): TStrings; override;
    function DoNeedSortKey(ARow: Integer): string;
    procedure DelCol(const Index: Integer); override;
    procedure DelRow(const Index: Integer); override;
    //
    function CreateNewRow: TStrings;
    procedure BaseColumnChanged(Sender: TObject);
    procedure RowsChanged(Sender: TObject);
  public
  	constructor Create; override;
    destructor Destroy; override;
    procedure RefreshSortKey; override;
  	function AddRow(const AData: array of string; AKey: string = ''): Integer; override;
  	function AddRow(const AData: TStrings; AKey: string = ''): Integer; override;
    procedure Clear; override;
  	function InsertRow(ARow: Integer; const AData: array of string; AKey: string = ''): Integer; overload; override;
  	function InsertRow(ARow: Integer; const AData: TStrings; AKey: string = ''): Integer; overload; override;
    procedure Sort(AReverse: Boolean = False); override;
  end;


implementation

uses
  s0StringHelper;

type
  Ts0MatrixSL = class(Ts0FreeObjStringList)
  public
    procedure Sort(AReverse: Boolean); reintroduce;
  end;

{ Ts0MatrixSL }

procedure Ts0MatrixSL.Sort(AReverse: Boolean);
var
  sl: TStringList;
  i: Integer;
  lBuf: Boolean;
begin
  if not AReverse then
  begin
    inherited Sort;
    Exit;
  end;
  sl := TStringList.Create;
  try
    for i := 0 to Self.Count -1 do
      sl.AddObject(Self.Strings[i], Self.Objects[i]);

    sl.Sort;

    lBuf := Self.ClearWithFree;
    try
      Self.ClearWithFree := False;
      Self.Clear;
    finally
      Self.ClearWithFree := lBuf;
    end;

    for i := sl.Count -1 downto 0 do
      Self.AddObject(sl.Strings[i], sl.Objects[i]);
  finally
    FreeAndNil(sl);
  end;
end;


{ Ts0Matrix }

procedure Ts0Matrix.Assign(Source: TPersistent);
var
  i, c: Integer;
  buf: Boolean;
begin
  if not(Source is Ts0Matrix) then Exit;
  //Self.OnNeedSortKeyByIndex := Ts0Matrix(Source).OnNeedSortKeyByIndex;
  c := Ts0Matrix(Source).RowCount;
  buf := FChanging;
  FChanging := True;
  try
    Self.Clear;
    for i := 0 to c -1 do
    begin
      Self.AddRow(Ts0Matrix(Source).Rows[i], '');
    end;
  finally
    FChanging := buf;
    if FChanging then DoChange;
  end;
end;

constructor Ts0Matrix.Create;
begin
  inherited Create;
  FTitleRow := TStringList.Create;
  FChanging := False;
end;

procedure Ts0Matrix.DeleteRow(const Index: Integer);
begin
  DeleteRows(Index, 1);
end;

procedure Ts0Matrix.DeleteRows(const ARowIndex, ARowCount: Integer);
var
  i: Integer;
  lChangingBuf: Boolean;
begin
  lChangingBuf := FChanging;
  FChanging := True;
  try
    for i := 0 to ARowCount -1 do
      DelRow(ARowIndex);
    DoDeleteRows(ARowIndex, ARowCount);
  finally
    FChanging := lChangingBuf;
    if FChanging then DoChange;
  end;
end;

destructor Ts0Matrix.Destroy;
begin
  FreeAndNil(FTitleRow);
  inherited;
end;

procedure Ts0Matrix.DoChange;
begin
  if FChanging then Exit;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure Ts0Matrix.DoDeleteRows(const ARowIndex, ARowCount: Integer);
begin
  if Assigned(FOnDeleteRow) then
    FOnDeleteRow(Self, ARowIndex, ARowCount);
end;

procedure Ts0Matrix.DoInsertBlankRows(const ARowIndex, ARowCount: Integer);
begin
  if Assigned(FOnInsertBlankRow) then
    FOnInsertBlankRow(Self, ARowIndex, ARowCount);
end;

function Ts0Matrix.Equals(AMatrix: Ts0Matrix): Boolean;
begin
  Result := (Self.CommaText = AMatrix.CommaText);
end;

function Ts0Matrix.GetCommaText: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Self.RowCount -1 do
    Result := Result +#13#10+ Self.Rows[i].Text;
end;

function Ts0Matrix.GetText: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Self.RowCount -1 do
    Result := Result +#13#10+ Self.Rows[i].CommaText;
end;

procedure Ts0Matrix.InsertBlankRows(const ARowIndex, ARowCount: Integer);
var
  i: Integer;
  lChangingBuf: Boolean;
  sl: TStringList;
begin
  lChangingBuf := FChanging;
  FChanging := True;
  try
    sl := TStringList.Create;
    try
      sl.Add('');
      for i := 0 to ARowCount -1 do
        InsertRow(ARowIndex, sl);
    finally
      FreeAndNil(sl);
    end;
    DoInsertBlankRows(ARowIndex, ARowCount);
  finally
    FChanging := lChangingBuf;
    if FChanging then DoChange;
  end;
end;

procedure Ts0Matrix.LoadFromStream(ASource: TStream; ADelim: Char = ','; AQuote: Char = '"');
begin
	with Ts0MatrixMaker.Instance do begin
    FQuote := AQuote;
  	FDelim := ADelim;
    FTarget := Self;
    Clear;
    cut2Matrix(ASource);
  end;
end;

procedure Ts0Matrix.SaveToStream(ADest: TStream; ADelim, AQuote: Char);
var
	i: integer;
  sl, tempRow: TStrings;
begin
  with Ts0QuoteStringsHelper.Instance do begin
  	FDelim := ADelim;
    FQuote := AQuote;
  end;
  sl := TStringList.Create;
  try
  	for i := 0 to Self.RowCount -1 do begin
      tempRow := GetRows(i);
      if tempRow is Ts0QuoteStringList then
        sl.Add( Ts0QuoteStringList(tempRow).GetQuoteText );
    end;
    sl.SaveToStream(ADest);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0Matrix.SetSortIndex(const Value: Integer);
begin
  if FSortIndex = Value then Exit;
  if Value < 0 then Exit;
  FSortIndex := Value;
  RefreshSortKey;
end;

procedure Ts0Matrix.SetTitleRow(const Value: TStrings);
begin
  FTitleRow.Assign(Value);
end;

{ Ts0MatrixMaker }

var
	gMatrixHelper: Ts0MatrixMaker;

class function Ts0MatrixMaker.Instance: Ts0MatrixMaker;
begin
  if gMatrixHelper = nil then
  	gMatrixHelper := Ts0MatrixMaker.Create;
  result := gMatrixHelper;
end;


constructor Ts0MatrixMaker.Create;
begin
  inherited Create;
  FDelim := ',';
  FQuote := '"';
end;

procedure Ts0MatrixMaker.cut2Matrix(Source: TStream);
var
  r: TStringList;
  s: string;
  cur: Char;
  inQuote: Boolean;
begin
  r := TStringList.Create;
  try
    inQuote := False;
    while Source.Position < Source.Size do
    begin
      Source.Read(cur, 1);
      if cur = FQuote then
      begin
        inQuote := not inQuote
      end
      else
      if cur = FDelim then
      begin
        if not inQuote then
        begin
          r.Add( Ts0StringHelper.ExtractQuotedStr(s) );
          s := '';
          Continue;
        end;
      end
      else
      if (cur = #13) and (not inQuote) then
      begin
        r.Add( Ts0StringHelper.ExtractQuotedStr(s) );
        s := '';
        //
        FTarget.AddRow(r);
        r.Clear;
        Source.Read(cur, 1);
        if cur = #10 then
          Continue;
      end;
      s := s + cur;
    end;
  finally
    FreeAndNil(r);
  end;
end;


procedure Ts0MatrixMaker.cut2Matrix(Source: String);
var
  ss: TStringStream;
begin
  ss := TStringStream.Create(Source);
  try
    cut2Matrix(ss);
  finally
    FreeAndNil(ss);
  end;
end;







{ Ts0RowBaseMatrix }

constructor Ts0RowBaseMatrix.Create;
begin
  inherited Create;
  FBaseColumn := Ts0MatrixSL.Create;
  Ts0MatrixSL(FBaseColumn).OnChange := BaseColumnChanged;
end;

destructor Ts0RowBaseMatrix.Destroy;
begin
  Self.OnChange := nil;
  Ts0MatrixSL(FBaseColumn).OnChange := nil;
  FreeAndNil(FBaseColumn);
  inherited;
end;



function Ts0RowBaseMatrix.AddRow(const AData: TStrings; AKey: string = ''): Integer;
var
	t: TStrings;
begin
  //Result := -1;
  t := CreateNewRow;
  if AData <> nil then 
    t.Assign(AData)
  else
    t.Add('');

  if FMaxCol < t.Count then FMaxCol := t.Count;
  if AKey <> '' then begin
  	Result := FBaseColumn.AddObject(AKey, t);
  end
  else begin
  	if t.Count < 1 then Result := FBaseColumn.AddObject('', t)
    							 else Result := FBaseColumn.AddObject(t.Strings[0], t);
  end;
end;

function Ts0RowBaseMatrix.AddRow(const AData: array of string; AKey: string = ''): Integer;
var
	temp: TStringList;
  i: Integer;
begin
  //Result := -1;
  temp := TStringList.Create;
  try
  	for i := Low(AData) to High(AData) do temp.Add(AData[i]);
  	Result := AddRow(temp, AKey);
  finally
    FreeAndNil(temp);
  end;
end;

procedure Ts0RowBaseMatrix.RefreshSortKey;
var
	i: Integer;
  sortedBuf: Boolean;
begin
  if SortIndex > Self.ColCount -1 then Exit;
  sortedBuf := Sorted;
  Sorted := False;
  try
    for i := 0 to FBaseColumn.Count -1 do
      FBaseColumn.Strings[i] := DoNeedSortKey(i);
  finally
    Sorted := sortedBuf;
  end;
end;

procedure Ts0RowBaseMatrix.Clear;
var
  buf: Boolean;
begin
  buf := FChanging;
  FChanging := True;
  try
    Self.OnChange := nil;
    FBaseColumn.Clear;
    FMaxCol := 0;
  finally
    FChanging := buf;
    if FChanging then DoChange;
  end;
end;

function Ts0RowBaseMatrix.DoNeedSortKey(ARow: Integer): string;
begin
  Result := Self.Cells[Self.SortIndex, ARow];  //FBaseColumn.Strings[ARow];
  if Assigned(FOnNeedSortKey) then
    FOnNeedSortKey(Self, ARow, Result);
end;

function Ts0RowBaseMatrix.GetCells(const x, y: Integer): string;
begin
  Result := '';
	if x < 0 then Exit;
	if y < 0 then Exit;
  if y > Self.RowCount -1 then Exit;
  if GetColCountByRow(y) > x then
  	Result := TStrings(FBaseColumn.Objects[y]).Strings[x];
end;

procedure Ts0RowBaseMatrix.SetCells(const x, y: Integer; const Value: string);
var
	tempColCnt: Integer;
  i: Integer;
  l: TStringList;
begin
	if x < 0 then Exit;
	if y < 0 then Exit;
  if y > FBaseColumn.Count -1 then
  begin
    l := TStringList.Create;
    try
      for i := FBaseColumn.Count to y do
        AddRow(l);
    finally
      FreeAndNil(l);
    end;
  end;
  tempColCnt := GetColCountByRow(y);
  for i := tempColCnt to x do
    Rows[y].Add('');
  Rows[y].Strings[x] := Value;
  if x > FMaxCol then FMaxCol := x;
end;

function Ts0RowBaseMatrix.GetSorted: Boolean;
begin
  Result := Ts0MatrixSL(FBaseColumn).Sorted;
end;

procedure Ts0RowBaseMatrix.SetSorted(const Value: Boolean);
begin
  if Value then begin
    RefreshSortKey;
  end;
  Ts0MatrixSL(FBaseColumn).Sorted := Value;
end;

procedure Ts0RowBaseMatrix.Sort(AReverse: Boolean = False);
begin
  Ts0MatrixSL(FBaseColumn).Sort(AReverse);
end;


function Ts0RowBaseMatrix.GetMaxCol: Integer;
begin
  Result := FMaxCol;
end;

function Ts0RowBaseMatrix.GetMaxRow: Integer;
begin
  Result := FBaseColumn.Count;
end;

function Ts0RowBaseMatrix.GetRows(const Index: Integer): TStrings;
begin
  Result := TStrings(FBaseColumn.Objects[Index])
end;

procedure Ts0RowBaseMatrix.DelCol(const Index: Integer);
var
	i: Integer;
  temp: TStrings;
begin
  for i := 0 to FBaseColumn.Count -1 do begin
  	temp := TStrings(FBaseColumn.Objects[i]);
    if Index < temp.Count then
    	temp.Delete(Index);
  end;
end;

procedure Ts0RowBaseMatrix.DelRow(const Index: Integer);
begin
  FBaseColumn.Delete(Index);
end;

function Ts0RowBaseMatrix.GetColCountByRow(const Index: Integer): Integer;
begin
  Result := 0;
  if Index > FBaseColumn.Count -1 then Exit;
  if FBaseColumn.Objects[Index] = nil then Exit;
	Result := TStrings(FBaseColumn.Objects[Index]).Count;
end;




function Ts0RowBaseMatrix.InsertRow(ARow: Integer;
  const AData: array of string; AKey: string): Integer;
var
	temp: TStringList;
  i: Integer;
begin
  temp := TStringList.Create;
  try
  	for i := Low(AData) to High(AData) do temp.Add(AData[i]);
  	Result := InsertRow(ARow, temp, AKey);
  finally
    FreeAndNil(temp);
  end;
end;

function Ts0RowBaseMatrix.InsertRow(ARow: Integer; const AData: TStrings;
  AKey: string): Integer;
var
	t: TStrings;
begin
  Result := ARow;
  //Result := -1;
  t := CreateNewRow;
  t.Assign(AData);

  if FMaxCol < t.Count then FMaxCol := t.Count;
  if AKey <> '' then begin
  	FBaseColumn.InsertObject(ARow, AKey, t);
  end
  else begin
  	if t.Count < 1 then FBaseColumn.InsertObject(ARow, '', t)
    							 else FBaseColumn.InsertObject(ARow, t.Strings[0], t);
  end;
end;



procedure Ts0RowBaseMatrix.BaseColumnChanged(Sender: TObject);
begin
  DoChange;
end;

procedure Ts0RowBaseMatrix.RowsChanged(Sender: TObject);
begin
  DoChange;
end;

function Ts0RowBaseMatrix.CreateNewRow: TStrings;
begin
  Result := Ts0QuoteStringList.Create;
  Ts0QuoteStringList(Result).OnChange := RowsChanged;
end;

initialization


finalization
	FreeAndNil(gMatrixHelper);

end.
