unit s0ColpilerDCC32;
{
�R�}���h���C���R���p�C���I�v�V�����ꗗ

A          |  |unit=alias|���j�b�g�̃G���A�X�ݒ�
B          |  |          |���ׂẴ��j�b�g�̍\�z
CC         |  |          |�R���\�[���A�v���P�[�V�����̍쐬
CG         |  |          |GUI �A�v���P�[�V�����̍쐬
D          |  |defines   |�����V���{���̒�`
E          |  |path      |EXE �̃f�B���N�g��
F          |  |address   |���s���G���[�̌��o
GS         |  |          |�Z�O�����g�t���}�b�v�t�@�C��
GP         |  |          |�p�u���b�N�t���}�b�v�t�@�C��
GD         |  |          |�ڍ׃}�b�v�t�@�C��
H          |  |          |�q���g���b�Z�[�W�̕\��
I          |  |paths     |�C���N���[�h�f�B���N�g��
J          |  |          |OBJ �t�@�C���̍쐬
JP         |  |          |C++ OBJ �t�@�C���̍쐬
K          |  |address   |�C���[�W�x�[�X�A�h���X�̐ݒ�
LE         |  |path      |�p�b�P�[�W�� BPL �f�B���N�g��
LN         |  |path      |�p�b�P�[�W�� DCP �f�B���N�g��
LU         |  |package   |�A�v���P�[�V�����Ŏg�p����ǉ��̎��s���p�b�P�[�W�̎w��
M          |  |          |���C�N�i�ύX���j�b�g�̂ݍăR���p�C���j
N          |  |path      |DCU �f�B���N�g��
O          |  |paths     |�I�u�W�F�N�g�t�@�C���f�B���N�g��
P          |  |          |8.3 �t�@�C����������
Q          |  |          |Quiet ���[�h�R���p�C��
R          |  |paths     |���\�[�X�t�@�C���f�B���N�g��
TX         |  |ext       |�^�[�Q�b�g�t�@�C���g���q
U          |  |paths     |���j�b�g�t�@�C���f�B���N�g��
V          |  |          |Turbo Debugger �f�o�b�O���
VN         |  |          |���O��Ԃ̃f�o�b�O�����CC++Builder �Ŏg���� Giant �`���Ő���
VR         |  |          |�����[�g�f�o�b�O�p�� rsm �t�@�C���̐���
W          |  |          |�x�����b�Z�[�W�̏o��
Z          |  |          |�Öق̃R���p�C���̗}�~
--Help     |D6|          |�m�w���v�n��ʂ̕\���I�v�V�����̕\���B�܂��C�R�}���h���C���� dcc32 ��������͂���ƁC�R�}���h���C���R���p�C���̍\���ƃI�v�V�����̈ꗗ���\������܂��B
--version  |D6|          |�v���W�F�N�g�̖��O�ƃo�[�W�����̕\��

$directive |  |          |�R���p�C���w��

$A |  |+/-  |+|�t�B�[���h�̃A���C�������g
$B |  |+/-  |-|�_�����̕]��
$C |  |+/-  |+|�A�T�[�g
$D |  |+/-  |+|�f�o�b�O���
$G |  |+/-  |+|�C���|�[�g�f�[�^
$H |  |+/-  |+|����������
$I |  |+/-  |+|���o�̓`�F�b�N
$J |  |+/-  |+|�������݉\�Ȍ^�t���萔
$L |  |+/-  |+|���[�J���V���{�����
$M |  |+/-  |-|���s���^���
$O |  |+/-  |+|�œK��
$P |  |+/-  |+|�I�[�v��������p�����[�^
$Q |  |+/-  |-|���l���Z�I�[�o�[�t���[�`�F�b�N
$R |  |+/-  |-|�͈̓`�F�b�N
$T |  |+/-  |-|�^�`�F�b�N�|�C���^
$U |  |+/-  |-|Pentium�̈��S��FDIV���Z
$V |  |+/-  |+|�ϐ�������`�F�b�N
$W |  |+/-  |-|Windows�X�^�b�N�t���[��
$X |  |+/-  |+|�g���\��
$Y |  |+/-/D|D|�V���{���Q�Ə��
$Z |  |1/2/4|1|�񋓌^�T�C�Y
}

{
�R���p�C���w�߂̈ꗗ
# ���$A�`$Z�ȊO�͎g��Ȃ����ǁA�����������ׂĂ��������Ȃ�����c���Ă����B

$A                 |  |+/-               |+             |�t�B�[���h�̃A���C�������g
$ALIGN             |  |ON/OFF            |ON            |�t�B�[���h�̃A���C�������g
$APPTYPE           |  |GUI/CONSOLE       |GUI           |�A�v���P�[�V�����̎��
$B                 |  |+/-               |-             |�_�����̕]��
$BOOLEVAL          |  |ON/OFF            |OFF           |�_�����̕]��
$C                 |  |+/-               |+             |�A�T�[�g
$ASSERTIONS        |  |ON/OFF            |ON            |�A�T�[�g
$D                 |  |+/-               |+             |�f�o�b�O���
$DEBUGINFO         |  |ON/OFF            |ON            |�f�o�b�O���
$D                 |  |param             |              |�L�q����
$DESCRIPTION       |  |param             |              |�L�q����
$DENYPACKAGEUNIT   |  |ON/OFF            |OFF           |���j�b�g���p�b�P�[�W�Ɋ܂܂�邱�Ƃ�h��
$DESIGNONLY        |  |ON/OFF            |OFF           |IDE�ւ̃C���X�g�[���p�p�b�P�[�W
$E                 |  |extension         |              |���s�`���t�@�C���̊g���q
$EXTENSION         |D6|extension         |              |���s�`���t�@�C���̊g���q
$EXTERNALSYM       |  |param             |              |�O���V���{��
$G                 |  |+/-               |+             |�C���|�[�g�f�[�^
$H                 |  |+/-               |+             |����������
$LONGSTRINGS       |  |ON/OFF            |ON            |����������
$HINTS             |  |ON/OFF            |ON            |�R���p�C���q���g
$HPPEMIT           |  |param             |              |C++Builder�p�ǉ��V���{��
$I                 |  |+/-               |+             |���o�̓`�F�b�N
$IOCHECKS          |  |ON/OFF            |ON            |���o�̓`�F�b�N
$I                 |  |filename          |              |�C���N���[�h�t�@�C��
$INCLUDE           |  |filename          |              |�C���N���[�h�t�@�C��
$IMAGEBASE         |  |number            |$00400000     |�C���[�W�x�[�X�A�h���X
$IMPLICITBUILD     |  |ON/OFF            |ON            |�Öق̍\�z
$IMPORTEDDATA      |  |ON/OFF            |ON            |�C���|�[�g�f�[�^
$P                 |  |+/-               |+             |�I�[�v��������p�����[�^
$J                 |  |+/-               |+             |�������݉\�Ȍ^�t���萔
$WRITABLECONST     |  |ON/OFF            |ON            |�������݉\�Ȍ^�t���萔
$L                 |  |+/-               |+             |���[�J���V���{�����
$LOCALSYMBOLS      |  |ON/OFF            |ON            |���[�J���V���{�����
$L                 |  |filename          |              |�����N�I�u�W�F�N�g�t�@�C��
$LINK              |  |filename          |              |�����N�I�u�W�F�N�g�t�@�C��
$LIBPREFIX         |D6|param             |              |���C�u�����p�R���p�C���w��
$LIBSUFFIX         |D6|param             |              |���C�u�����p�R���p�C���w��
$LIBVERSION        |D6|param             |              |���C�u�����p�R���p�C���w��
$M                 |  |+/-               |-             |���s���^���
$TYPEINFO          |  |ON/OFF            |OFF           |���s���^���
$M                 |  |min,max           |16384,1048576 |�X�^�b�N���蓖�ăT�C�Y
$MINSTACKSIZE      |  |number            |16384         |�X�^�b�N�T�C�Y<�ŏ�>
$MAXSTACKSIZE      |  |number            |1048576       |�X�^�b�N�T�C�Y<�ő�>
$MESSAGE           |D6|identifier msg    |              |���b�Z�[�W [HINT/WARN/ERROR/FATAL]
$NODEFINE          |  |identifier        |              |�v���C�x�[�g�V���{��
$NOINCLUDE         |  |filename          |              |�v���C�x�[�g���j�b�g
$O                 |  |+/-               |+             |�œK��
$OPTIMIZATION      |  |ON/OFF            |ON            |�œK��
$ObjExportAll      |  |On/Off            |Off           |�V���{���̃G�N�X�|�[�g
$OPENSTRINGS       |  |ON/OFF            |ON            |�I�[�v��������p�����[�^
$Q                 |  |+/-               |-             |���l���Z�I�[�o�[�t���[�`�F�b�N
$OVERFLOWCHECKS    |  |ON/OFF            |OFF           |���l���Z�I�[�o�[�t���[�`�F�b�N
$R                 |  |+/-               |-             |�͈̓`�F�b�N
$RANGECHECKS       |  |ON/OFF            |OFF           |�͈̓`�F�b�N
$R                 |  |filename          |              |���\�[�X�t�@�C��
$RESOURCE          |  |filename          |              |���\�[�X�t�@�C��
$REALCOMPATIBILITY |  |ON/OFF            |OFF           |Real48 �Ƃ̌݊���
$RUNONLY           |  |ON/OFF            |OFF           |���s����p�p�b�P�[�W
$SetPEFlags        |D6|                  |              |PE�w�b�_�[�t���O
$SetPEOptFlags     |D6|                  |              |PE�w�b�_�[�t���O
$T                 |  |+/-               |-             |�^�`�F�b�N�|�C���^
$TYPEDADDRESS      |  |ON/OFF            |OFF           |�^�`�F�b�N�|�C���^
$U                 |  |+/-               |-             |Pentium�̈��S�� FDIV ���Z
$SAVEDIVIDE        |  |ON/OFF            |OFF           |Pentium�̈��S�� FDIV ���Z
$V                 |  |+/-               |+             |�ϐ�������`�F�b�N
$VARSTRINGCHECKS   |  |ON/OFF            |ON            |�ϐ�������`�F�b�N
$W                 |  |+/-               |-             |Windows �X�^�b�N�t���[��
$STACKFRAMES       |  |ON/OFF            |OFF           |Windows �X�^�b�N�t���[��
$W                 |D6|+/-               |+             |�x�����b�Z�[�W
$WARN              |D6|identifier ON/OFF |              |�x�����b�Z�[�W
$WARNINGS          |  |ON/OFF            |ON            |�R���p�C���x��
$WEAKPACKAGEUNIT   |  |ON/OFF            |OFF           |�ア�p�b�P�[�W��
$X                 |  |+/-               |+             |�g���\��
$EXTENDSYNTAX      |  |ON/OFF            |ON            |�g���\��
$Y                 |  |+/-/D             |D             |�V���{���Q�Ə��
$DEFINITIONINFO    |  |ON/OFF            |ON            |�V���{���Q�Ə��
$REFERENCEINFO     |  |ON/OFF            |OFF           |�V���{���Q�Ə��
$Z                 |  |1/2/4             |1             |�񋓌^�T�C�Y
$MINENUMSIZE       |  |1/2/4             |1             |�񋓌^�T�C�Y

WARN identifier
SYMBOL_PLATFORM	���݂̃��j�b�g���̃V���{���ɂ��āCplatform �w�߂Ɋւ��邷�ׂĂ̌x����L���܂��͖����ɂ��܂��B
SYMBOL_LIBRARY	���݂̃��j�b�g���̃V���{���ɂ��āClibrary �w�߂Ɋւ��邷�ׂĂ̌x����L���܂��͖����ɂ��܂��B
SYMBOL_DEPRECATED	���݂̃��j�b�g���̃V���{���ɂ��āCdeprecated �w�߂Ɋւ��邷�ׂĂ̌x����L���܂��͖����ɂ��܂��B
UNIT_DEPRECATED	���j�b�g�錾�ɓK�p���ꂽ deprecated �w�߂Ɋւ��邷�ׂĂ̌x����L���܂��͖����ɂ��܂��B
UNIT_LIBRARY	library �w�߂��w�肳��Ă��郆�j�b�g���ŁClibrary �w�߂Ɋւ��邷�ׂĂ̌x����L���܂��͖����ɂ��܂��B
UNIT_PLATFORM	platform �w�߂��w�肳��Ă��郆�j�b�g���ŁCplatform �w�߂Ɋւ��邷�ׂĂ̌x����L���܂��͖����ɂ��܂��B

$ELSEIF            //D6//                    //�����R���p�C��
$IF                //D6//                    //�����R���p�C��
$IFEND             //D6//                    //�����R���p�C��
$DEFINE            //  //name                //�����R���p�C��
$ELSE              //  //                    //�����R���p�C��
$ENDIF             //  //                    //�����R���p�C��
$IFDEF             //  //name                //�����R���p�C��
$IFNDEF            //  //name                //�����R���p�C��
$IFOPT             //  //switch              //�����R���p�C��
$UNDEF             //  //name                //�����R���p�C��
}

interface

uses
  SysUtils, Classes,
  s0Persistent,
  s0Collection;

type
  K0CLCParamTypeKind = (
    k0cokNone,
    k0cokSwitch,
    k0cokSelection,
    k0cokNameAndValue,
    k0cokDefines,
    k0cokPath,
    k0cokPaths,
    k0cokAddress,
    k0cokPackage,
    k0cokExt
  );

type
  //CLC: Command Line Compiler
  Ts0CLCParamType = class(Ts0CollectionItem)
  private
    FTypeKind: K0CLCParamTypeKind;
    FDefaultValue: string;
    FParamTypeName: string;
    FDescription: string;
    FSelections: TStrings;
    procedure SetDefaultValue(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetParamTypeName(const Value: string);
    procedure SetSelections(const Value: TStrings);
    procedure SetTypeKind(const Value: K0CLCParamTypeKind);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ParamTypeName: string read FParamTypeName write SetParamTypeName;
    property Description: string read FDescription write SetDescription;
    property TypeKind: K0CLCParamTypeKind read FTypeKind write SetTypeKind;
    property Selections: TStrings read FSelections write SetSelections;
    property DefaultValue: string read FDefaultValue write SetDefaultValue;
  end;

type
  Ts0CLCParamTypes = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0CLCParamType;
    procedure SetItems(const Index: Integer; const Value: Ts0CLCParamType);
  public
    function Add(AName: string; AKind: K0CLCParamTypeKind; ADesc: string ='';
      ADefault: string = ''): Ts0CLCParamType;
    function AddWith(AName: string; 
      ASelection: array of string; ADefault: string = ''; ADesc: string =''
      ): Ts0CLCParamType;
    function ItemByName(AName: string): Ts0CLCParamType;
    property Items[const Index: Integer]: Ts0CLCParamType read GetItems write SetItems;
  end;

type
  K0CLCVersion = (k0clcv130, k0clcv140);

type
  Ts0CLCParamTypeSet = class(TComponent)
  private
    FVersion: K0CLCVersion;
    FParamTypes: Ts0CLCParamTypes;
    procedure SetParamTypes(const Value: Ts0CLCParamTypes);
    procedure SetVersion(const Value: K0CLCVersion);
  protected
    procedure InitParamTypes; virtual;
    class procedure ClearInstances;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function Instance: Ts0CLCParamTypeSet;
  published
    property Version: K0CLCVersion read FVersion write SetVersion;
    property ParamTypes: Ts0CLCParamTypes read FParamTypes write SetParamTypes;
  end;



type
  Ts0CLCParam = class(Ts0CollectionItem)
  private
    FParamName: string;
    FParamValue: string;
    FEnabled: Boolean;
    procedure SetParamName(const Value: string);
    procedure SetParamValue(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    function GetLineStr: string;
    procedure SetLineStr(Value: string);
  protected
    function GetParamType: Ts0CLCParamType;
    function GetParamTypes: Ts0CLCParamTypes; virtual;
  public
    constructor Create(ACollection: TCollection); override;
    property ParamType: Ts0CLCParamType read GetParamType;
    property LineStr: string read GetLineStr write SetLineStr;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property ParamName: string read FParamName write SetParamName;
    property ParamValue: string read FParamValue write SetParamValue;
  end;

type
  Ts0CLCParams = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0CLCParam;
    procedure SetItems(const Index: Integer;
      const Value: Ts0CLCParam);
  public
    function Add(AParam: string = ''; AEnabled: Boolean = True): Ts0CLCParam;
    function AddLine(ALine: string): Ts0CLCParam;
    property Items[const Index: Integer]: Ts0CLCParam read GetItems write SetItems;
  end;

type
  Ts0CLCOption = class(Ts0Persistent)
  private
    FParams: Ts0CLCParams;
    procedure SetParams(const Value: Ts0CLCParams);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    function GetParamStr: string;
    procedure GetParamList(Dest: TStrings);
  published
    property Params: Ts0CLCParams read FParams write SetParams;
  end;

type
  Ts0CommandLineCompiler = class(TComponent)
  private
    FCLCConfig: Ts0CLCOption;
    FExeFileName: TFileName;
    FCLCVersion: K0CLCVersion;
    FExecResult: TStrings;
    procedure SetCLCConfig(const Value: Ts0CLCOption);
    procedure SetCLCVersion(const Value: K0CLCVersion);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute(ASourceFile: string);
    property ExecResult: TStrings read FExecResult;
  published
    property ExeFileName: TFileName read FExeFileName write FExeFileName;
    property CLCVersion: K0CLCVersion read FCLCVersion write SetCLCVersion;
    property CLCConfig: Ts0CLCOption read FCLCConfig write SetCLCConfig;
  end;

implementation

uses
  ShellAPI, Forms,
  s0ExecFile,
  s0StringHelper;           

{ Ts0CLCParamType }

procedure Ts0CLCParamType.Assign(Source: TPersistent);
begin
  inherited;

end;

constructor Ts0CLCParamType.Create(ACollection: TCollection);
begin
  inherited;
  FSelections := TStringList.Create;
end;

destructor Ts0CLCParamType.Destroy;
begin
  FreeAndNil(FSelections);
  inherited;              
end;

procedure Ts0CLCParamType.SetDefaultValue(const Value: string);
begin
  FDefaultValue := Value;
end;

procedure Ts0CLCParamType.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure Ts0CLCParamType.SetParamTypeName(const Value: string);
begin
  FParamTypeName := Value;
end;

procedure Ts0CLCParamType.SetSelections(const Value: TStrings);
begin
  FSelections.Assign(Value);
end;

procedure Ts0CLCParamType.SetTypeKind(const Value: K0CLCParamTypeKind);
begin
  FTypeKind := Value;
end;

{ Ts0CLCParamTypes }

function Ts0CLCParamTypes.Add(AName: string; AKind: K0CLCParamTypeKind;
  ADesc, ADefault: string): Ts0CLCParamType;
begin
  Result := Ts0CLCParamType(inherited Add);
  Result.ParamTypeName := AName;
  Result.TypeKind := AKind;
  Result.Description := ADesc;
  Result.DefaultValue := ADefault;
end;

function Ts0CLCParamTypes.AddWith(AName: string; 
  ASelection: array of string; ADefault, ADesc: string): Ts0CLCParamType;
var
  i: Integer;
begin
  Result := Add(AName, k0cokSelection, ADesc, ADefault);
  for i := Low(ASelection) to High(ASelection) do
    Result.Selections.Add(ASelection[i]);
end;

function Ts0CLCParamTypes.GetItems(const Index: Integer): Ts0CLCParamType;
begin
  Result := Ts0CLCParamType(inherited Items[Index]);
end;

function Ts0CLCParamTypes.ItemByName(AName: string): Ts0CLCParamType;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if Result.ParamTypeName = AName then Exit;
  end;
  Result := nil;
end;

procedure Ts0CLCParamTypes.SetItems(const Index: Integer;
  const Value: Ts0CLCParamType);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CLCParamTypeSet }

var
  g9ParamTypeSet: Ts0CLCParamTypeSet;

class procedure Ts0CLCParamTypeSet.ClearInstances;
begin
  FreeAndNil(g9ParamTypeSet);
end;

constructor Ts0CLCParamTypeSet.Create(AOwner: TComponent);
begin
  inherited;
  FParamTypes := Ts0CLCParamTypes.Create(Self, Ts0CLCParamType); 
end;

destructor Ts0CLCParamTypeSet.Destroy;
begin
  FreeAndNil(FParamTypes);
  inherited;              
end;

procedure Ts0CLCParamTypeSet.InitParamTypes;
var
  p: Ts0CLCParamTypes;
begin
//�R�}���h���C���R���p�C���I�v�V����
  p := Self.ParamTypes;
  p.Add('A' , {unit=alias}k0cokNameAndValue, '���j�b�g�̃G���A�X�ݒ�');
  p.Add('B' , {          }k0cokNone        , '���ׂẴ��j�b�g�̍\�z');
  p.Add('CC', {          }k0cokNone        , '�R���\�[���A�v���P�[�V�����̍쐬');
  p.Add('CG', {          }k0cokNone        , 'GUI �A�v���P�[�V�����̍쐬');
  p.Add('D' , {defines   }k0cokDefines     , '�����V���{���̒�`');
  p.Add('E' , {path      }k0cokPath        , 'EXE �̃f�B���N�g��');
  p.Add('F' , {address   }k0cokAddress     , '���s���G���[�̌��o');
  p.Add('GS', {          }k0cokNone        , '�Z�O�����g�t���}�b�v�t�@�C��');
  p.Add('GP', {          }k0cokNone        , '�p�u���b�N�t���}�b�v�t�@�C��');
  p.Add('GD', {          }k0cokNone        , '�ڍ׃}�b�v�t�@�C��');
  p.Add('H' , {          }k0cokNone        , '�q���g���b�Z�[�W�̕\��');
  p.Add('I' , {paths     }k0cokPaths       , '�C���N���[�h�f�B���N�g��');
  p.Add('J' , {          }k0cokNone        , 'OBJ �t�@�C���̍쐬');
  p.Add('JP', {          }k0cokNone        , 'C++ OBJ �t�@�C���̍쐬');
  p.Add('K' , {address   }k0cokAddress     , '�C���[�W�x�[�X�A�h���X�̐ݒ�');
  p.Add('LE', {path      }k0cokPath        , '�p�b�P�[�W�� BPL �f�B���N�g��');
  p.Add('LN', {path      }k0cokPath        , '�p�b�P�[�W�� DCP �f�B���N�g��');
  p.Add('LU', {package   }k0cokPackage     , '�A�v���P�[�V�����Ŏg�p����ǉ��̎��s���p�b�P�[�W�̎w��');
  p.Add('M' , {          }k0cokNone        , '���C�N�i�ύX���j�b�g�̂ݍăR���p�C���j');
  p.Add('N' , {path      }k0cokPath        , 'DCU �f�B���N�g��');
  p.Add('O' , {paths     }k0cokPaths       , '�I�u�W�F�N�g�t�@�C���f�B���N�g��');
  p.Add('P' , {          }k0cokNone        , '8.3 �t�@�C����������');
  p.Add('Q' , {          }k0cokNone        , 'Quiet ���[�h�R���p�C��');
  p.Add('R' , {paths     }k0cokPaths       , '���\�[�X�t�@�C���f�B���N�g��');
  p.Add('TX', {ext       }k0cokExt         , '�^�[�Q�b�g�t�@�C���g���q');
  p.Add('U' , {paths     }k0cokPaths       , '���j�b�g�t�@�C���f�B���N�g��');
  p.Add('V' , {          }k0cokNone        , 'Turbo Debugger �f�o�b�O���');
  p.Add('VN', {          }k0cokNone        , '���O��Ԃ̃f�o�b�O�����CC++Builder �Ŏg���� Giant �`���Ő���');
  p.Add('VR', {          }k0cokNone        , '�����[�g�f�o�b�O�p�� rsm �t�@�C���̐���');
  p.Add('W' , {          }k0cokNone        , '�x�����b�Z�[�W�̏o��');
  p.Add('Z' , {          }k0cokNone        , '�Öق̃R���p�C���̗}�~');

//�R���p�C���w��
  p.AddWith('$A', ['+', '-'     ], '+', '�t�B�[���h�̃A���C�������g');
  p.AddWith('$B', ['+', '-'     ], '+', '�_�����̕]��');
  p.AddWith('$C', ['+', '-'     ], '+', '�A�T�[�g');
  p.AddWith('$D', ['+', '-'     ], '+', '�f�o�b�O���');
  p.AddWith('$G', ['+', '-'     ], '+', '�C���|�[�g�f�[�^');
  p.AddWith('$H', ['+', '-'     ], '+', '����������');
  p.AddWith('$I', ['+', '-'     ], '+', '���o�̓`�F�b�N');
  p.AddWith('$J', ['+', '-'     ], '+', '�������݉\�Ȍ^�t���萔');
  p.AddWith('$L', ['+', '-'     ], '+', '���[�J���V���{�����');
  p.AddWith('$M', ['+', '-'     ], '+', '���s���^���');
  p.AddWith('$O', ['+', '-'     ], '+', '�œK��');
  p.AddWith('$P', ['+', '-'     ], '+', '�I�[�v��������p�����[�^');
  p.AddWith('$Q', ['+', '-'     ], '+', '���l���Z�I�[�o�[�t���[�`�F�b�N');
  p.AddWith('$R', ['+', '-'     ], '+', '�͈̓`�F�b�N');
  p.AddWith('$T', ['+', '-'     ], '+', '�^�`�F�b�N�|�C���^');
  p.AddWith('$U', ['+', '-'     ], '+', 'Pentium�̈��S��FDIV���Z');
  p.AddWith('$V', ['+', '-'     ], '+', '�ϐ�������`�F�b�N');
  p.AddWith('$W', ['+', '-'     ], '+', 'Windows�X�^�b�N�t���[��');
  p.AddWith('$X', ['+', '-'     ], '+', '�g���\��');
  p.AddWith('$Y', ['+', '-', 'D'], 'D', '�V���{���Q�Ə��');
  p.AddWith('$Z', ['1', '2', '4'], '1', '�񋓌^�T�C�Y');
end;

class function Ts0CLCParamTypeSet.Instance: Ts0CLCParamTypeSet;
begin
  if g9ParamTypeSet = nil then
    g9ParamTypeSet := Ts0CLCParamTypeSet.Create(nil);
  Result := g9ParamTypeSet;  
end;

procedure Ts0CLCParamTypeSet.SetParamTypes(const Value: Ts0CLCParamTypes);
begin
  FParamTypes.Assign(Value);
end;

procedure Ts0CLCParamTypeSet.SetVersion(const Value: K0CLCVersion);
begin
  FVersion := Value;
end;

{ Ts0CLCParam }

constructor Ts0CLCParam.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
end;

function Ts0CLCParam.GetLineStr: string;
begin
  Result := '-' + FParamName + FParamValue;
end;

function Ts0CLCParam.GetParamType: Ts0CLCParamType;
begin
  Result := Ts0CLCParamTypeSet.Instance.ParamTypes.ItemByName(FParamName);
end;

function Ts0CLCParam.GetParamTypes: Ts0CLCParamTypes;
begin
  Result := Ts0CLCParamTypeSet.Instance.ParamTypes;
end;

procedure Ts0CLCParam.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure Ts0CLCParam.SetLineStr(Value: string);
var
  s: string;
  pt: Ts0CLCParamType;
begin
  FParamName := '';
  FParamValue := '';
  if Value = '' then Exit;
  //
  if Value[1] in ['-', '/'] then
    System.Delete(Value, 1, 1);
  //
  if Value = '' then Exit;
  s := Copy(Value, 1, 1);
  pt := Ts0CLCParamTypeSet.Instance.ParamTypes.ItemByName(s);
  if (s <> '$') and (pt <> nil) then
  begin
    FParamName := s;
    if Length(Value) > 1 then
      FParamValue := Copy(Value, 2,  Length(Value) -1)
    else
      FParamValue := '';
    Exit;
  end;
  //
  if Length(Value) < 2 then Exit;
  s := Copy(Value, 1, 2);
  pt := Ts0CLCParamTypeSet.Instance.ParamTypes.ItemByName(s);
  if pt <> nil then
  begin
    FParamName := s;
    if Length(Value) > 2 then
      FParamValue := Copy(Value, 3, Length(Value) -2)
    else
      FParamValue := '';
  end;
end;

procedure Ts0CLCParam.SetParamName(const Value: string);
begin
  FParamName := Value;
end;

procedure Ts0CLCParam.SetParamValue(const Value: string);
begin
  FParamValue := Value;
end;

{ Ts0CLCParams }

function Ts0CLCParams.Add(AParam: string; AEnabled: Boolean): Ts0CLCParam;
begin
  Result := Ts0CLCParam(inherited Add);
  Result.ParamName := AParam;
  Result.Enabled := AEnabled;
end;

function Ts0CLCParams.AddLine(ALine: string): Ts0CLCParam;
begin
  Result := Ts0CLCParam(inherited Add);
  Result.LineStr := ALine;
end;

function Ts0CLCParams.GetItems(const Index: Integer): Ts0CLCParam;
begin
  Result := Ts0CLCParam(inherited Items[Index]);
end;

procedure Ts0CLCParams.SetItems(const Index: Integer;
  const Value: Ts0CLCParam);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CLCOption }

constructor Ts0CLCOption.Create(AOwner: TPersistent);
begin
  inherited;
  FParams := Ts0CLCParams.Create(Self, Ts0CLCParam);
end;

destructor Ts0CLCOption.Destroy;
begin
  FreeAndNil(FParams);
  inherited;          
end;

procedure Ts0CLCOption.GetParamList(Dest: TStrings);
var
  i: Integer;
begin
  Dest.Clear;
  for i := 0 to Params.Count -1 do
    Dest.Add( Params.Items[i].LineStr );
end;

function Ts0CLCOption.GetParamStr: string;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    GetParamList(sl);
    Result := Ts0StringHelper.ConcatStrings(sl, ' ');
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0CLCOption.SetParams(const Value: Ts0CLCParams);
begin
  FParams.Assign(Value);
end;

{ Ts0CommandLineCompiler }

constructor Ts0CommandLineCompiler.Create(AOwner: TComponent);
begin
  inherited;
  FExecResult := TStringList.Create;
end;

destructor Ts0CommandLineCompiler.Destroy;
begin
  FreeAndNil(FExecResult);
  inherited;
end;

procedure Ts0CommandLineCompiler.Execute(ASourceFile: string);
begin
  FExecResult.Clear;
  Ts0ExecFile.ExecuteFile(FExeFileName, CLCConfig.GetParamStr, FExecResult);
end;

procedure Ts0CommandLineCompiler.SetCLCConfig(const Value: Ts0CLCOption);
begin
  FCLCConfig.Assign(Value);
end;

procedure Ts0CommandLineCompiler.SetCLCVersion(const Value: K0CLCVersion);
begin
  FCLCVersion := Value;
end;

initialization

finalization
  Ts0CLCParamTypeSet.ClearInstances;
  
end.
