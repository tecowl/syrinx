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
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCase���g�p���ĕ�����̔�r���s���Ă���������SameText���g�p����悤
 * �ɏC��
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/13   Time: 23:26
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Create�̈�����TCollection�^�ɖ߂��āAoverride����悤
 * �ɕύX�����B�����Ă����āA���ꂾ��IDE����override���Ă���R���X�g���N�^
 * ���Ăяo���Ă��炦�Ȃ��񂾂���B���B
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem�̃R���X�g���N�^�̈�����TCollection����Ts0Collection�ɕ�
 * �X
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/06   Time: 14:20
 * Updated in $/source/p0control
 * �폜������0LogManager��uses���Ă����̂ŁAuses����폜�����B
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 14:08
 * Updated in $/source/p0control
 * Ts0Event�̃R���X�g���N�^�̕ύX�̔��f
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/01   Time: 13:22
 * Updated in $/source/p0control
 * �R�����g��ǉ�
 *
 * *****************  Version 1  *****************
 * User: Hirakawa     Date: 01/06/22   Time: 9:51
 * Created in $/GUI/Source/View
 * �V�K�쐬
 * �F���ꊇ�Ǘ����邽�߂̃R���|�[�l���g�̊��N���X�B
}

{
  ���@
  �A�v���P�[�V�������ƂɃO���b�h�ɂ͗l�X�ȐF�̎w�肪�Ȃ����ꍇ�����邪�A
  ���̐F���g�́A�V�X�e���Ƃ��Ă�����x���߂Ă���B
  �A�v���J���҂��A��������T0ColorDeco�ȂǂŐF�̎w�������Ɣ��ɖʓ|�������̂ŁA
  �V�X�e���Ƃ��Ĉꊇ���ĐF���w�肵�Ă����A�A�v���J���҂͉��炩�̎w������邾����
  �����I�ɐF��ݒ肳�������B
  request from  CS�R�{����

  �g����
  ��{�I�ɃA�v���J���҂͂��̃R���|�[�l���g�̔h���N���X�ɑ΂��āA
  ��������ł��Ȃ����A���Ă͂Ȃ�Ȃ��B

  �A�v���J���҂́AT0ColorDeco.ColorIdentifier�Ȃǂ̃v���p�e�B��
  �Y������F�̎w����s���B���̍ۂɎw��ł���̂́ATs0ColorSet��Identifier�Ƃ���
  �I������Ă�����̂����ł���B

  �V�X�e���̋��ʎd�l�S���́A����Ts0ColorManager���p�����A
  LoadItems���\�b�h��override���āA���̃��\�b�h�ɂ�����
  T0COlorSet�̃C���X�^���X��K�v�ȕ����������A�ݒ肷��K�v������B

  �A�v���J���҂����ۂɎg�p����̂́A���̃V�X�e���̋��ʎd�l�S����
  �쐬����Ts0ColorManager�̔h���N���X�ł���B
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
    k0ckColor, //���ʂ̃R���g���[���̔w�i�F�i�O���b�h�̃Z���̔w�i�F���܂ށj
    k0ckFontColor, //���ʂ̃R���g���[���̕����F�i�O���b�h�̃Z���̕����F���܂ށj
    k0ckGridSelColor, //�O���b�h�̑I���Z���̔w�i�F
    k0ckGridSelFontColor, //�O���b�h�̑I���Z���̕����F
    k0ckGridFocusColor, //�O���b�h�̃t�H�[�J�X�Z���̔w�i�F
    k0ckGridFocusFontColor, //�O���b�h�̃t�H�[�J�X�Z���̕����F
    k0ckGridFixedColor, //�O���b�h�̌Œ�Z���̔w�i�F
    k0ckGridFixedFontColor //�O���b�h�̌Œ�Z���̕����F
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
      ���ʎq�B���̕�����̓��j�[�N�ɂȂ�܂��B
    }
    property Identifier: string read FIdentifier write SetIdentifier;
    {
      Comment
      �A�v���J���҂��ǂ�ȂƂ��ɂ���ColorSet���g�p����̂���
      ������悤�ȃR�����g�������Ă����ĂˁB
    }
    property Comment: string read FComment write SetComment;
    {
      *Color
      �F��ȐF�B���ɑΉ�������̂��� K0ColorKind �̋L�q�����Ă��������B
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
      Ts0ColorSet�̃C���X�^���X�̐����A�ݒ莞�Ɏg�����\�b�h�B
    }
    function AddColorSet(AIdentifier: string; AColors: array of TColor;
      AComment: string): Ts0ColorSet;
    {
      CreateItems
      �h���N���X��Ts0ColorSetCollection�̔h���N���X���g�p�������ꍇ�́A
      ���̃��\�b�h��override���ĂˁB
    }
    function CreateItems: Ts0ColorSetCollection; virtual;
    procedure Loaded; override;
    {
      ValidateReadOnly
      �����I�Ɏg�p����郁�\�b�h�ł��B
      �����ύX���������ꍇ�ɁA���̃��\�b�h�ɂ����ReadOnly���̏������ݕs�Ȃǂ�
      ���f���Ă��܂��B
    }
    procedure ValidateReadOnly;
    {
      LoadItems
      �V�X�e���̋��ʎd�l�S���͂��̃��\�b�h��override����
      Items�𐶐��A�ݒ肵�Ă��������B
    }
    procedure LoadItems; virtual;
    procedure DoLoadItems;
    {
      ReadOnly
      �ǂݍ��ݐ�p��\���B��{�I��True�̒l���Ƃ�B
      �������A�����ł�LoadItems���Ăяo�����O��ReadOnly��False�ɐݒ肳��A
      �Ăяo���ꂽ���True�ɍĐݒ肳���B
    }
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {
      GetIdentifiers
      Items��Identifier�̈ꗗ���擾����B
    }
    procedure GetIdentifiers(Dest: TStrings);
    {
      FindColorSet
      ����AIdentifier�ƈ�v����Identifier������Ts0ColorSet����������B
    }
    function FindColorSet(AIdentifier: string): Ts0ColorSet;
    {
      OnLoadItems
      Items�����ׂĐݒ肳�ꂽ����ɔ�������C�x���g�B
    }
    property OnLoadItems: Ts0Event read FOnLoadItems;
    property LoadedItems: Boolean read FLoadedItems;
    {
      Instance
      �ɂ�Singleton�̂��߂̃��\�b�h�B
      ���̃��\�b�h���Ăяo���Ă��A�C���X�^���X�𐶐�����킯�ł͂Ȃ��ł��B
      �C���X�^���X�̎Q�Ƃ��ȒP�Ɏ擾���邽�߂̂��́B
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
      �V�X�e���̋��ʎd�l�S���͂��̃��\�b�h��override����
      Items�𐶐��A�ݒ肵�Ă��������B
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
    �V�X�e���̋��ʎd�l�S���̕��́A���̃��\�b�h��override����
    Items�̐����A�ݒ������Ă��������B
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
    '�e�X�g�p�ł���Ńe�L�g�[�ɏ���������Ă܂��ł��f�X'
    );

  AddColorSet(
    'Test02',
    [clWindow, clBlue, clTeal, clWhite, clBlack, clWhite, clBtnFace, clBlack],
    'Urrrrrrryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
    );
end;

end.
