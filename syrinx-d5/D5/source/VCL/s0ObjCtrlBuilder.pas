unit s0ObjCtrlBuilder;
{
$History: s0ObjCtrlBuilder.pas $
 * 
 * *****************  Version 47  *****************
 * User: Akima        Date: 02/05/15   Time: 17:12
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 46  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 45  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 44  *****************
 * User: Akima        Date: 02/03/15   Time: 11:39
 * Updated in $/D5/source/VCL
 * ���x����Caption���������ݒ肳��Ă��Ȃ������B
 * 
 * *****************  Version 43  *****************
 * User: Akima        Date: 02/03/11   Time: 20:30
 * Updated in $/D6/source/VCL
 * BuildCtrls�AClearCtrls��virtual��
 * 
 * *****************  Version 42  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 41  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 40  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 39  *****************
 * User: Akima        Date: 02/02/22   Time: 0:49
 * Updated in $/source/D5Integrated
 * CtrlOfType��public�ɕύX
 * 
 * *****************  Version 38  *****************
 * User: Akima        Date: 02/02/21   Time: 23:23
 * Updated in $/source/D5Integrated
 * Loaded��LoadFromTarget������悤�ɕύX�B
 * Ts0ObjCtrlBridge.MakeDefualtProtoTypes�ł̗]�v�ȏ������폜�B
 * 
 * *****************  Version 37  *****************
 * User: Akima        Date: 02/02/13   Time: 21:09
 * Updated in $/source/D5Integrated
 * Ts0ProtoTypeCtrl.Assign���C���B
 * Ts0ProtoTypeCtrls.Assig�ŁAProtoSource��ݒ肷��悤�ɕύX�B
 * GetCtrlOfTypeClassName��ύX�B
 * 
 * *****************  Version 36  *****************
 * User: Akima        Date: 02/02/08   Time: 8:23
 * Updated in $/source/D6VCLIntegrated
 * UpperCase���g�p���ĕ�����̔�r���s���Ă���������SameText���g�p����悤
 * �ɏC��
 * 
 * *****************  Version 35  *****************
 * User: Akima        Date: 02/02/06   Time: 4:42
 * Updated in $/source/D5Integrated
 * DisabledProps�v���p�e�B��ǉ��B���̃v���p�e�B�ɂ́AProtoTypes�̐����̑�
 * �ۊO�ƂȂ�v���p�e�B�̖��O���w�肷�邱�Ƃ��ł���B
 * 
 * *****************  Version 34  *****************
 * User: Akima        Date: 02/02/06   Time: 1:04
 * Updated in $/source/D5Integrated
 * AutoUpdate�v���p�e�B�̃f�t�H���g�l��True�ɁB
 * Ts0ProtoTypeCtrl.SetCtrl���\�b�h�ł̕s�v�ŊԈ���Ă��鏈�����C���B
 * 
 * *****************  Version 33  *****************
 * User: Akima        Date: 02/01/10   Time: 3:15
 * Updated in $/source/D5Integrated
 * published��TargetComponent�v���p�e�B��ǉ��B
 * Builder��Active�v���p�e�B��ǉ��B�����True�ɂ����Builder.Execute����
 * ��B
 * GetCtrlOfTypeClass�ARegisterCtrlOfType��Ts0CtrlOfType�Ɉړ��B
 * 
 * *****************  Version 32  *****************
 * User: Akima        Date: 02/01/06   Time: 0:21
 * Updated in $/source/D5Integrated
 * CtrlOfTypeClassName�v���p�e�B��ǉ�
 * 
 * *****************  Version 31  *****************
 * User: Akima        Date: 02/01/02   Time: 21:44
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 30  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 29  *****************
 * User: Akima        Date: 01/12/15   Time: 23:30
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 28  *****************
 * User: Akima        Date: 01/12/15   Time: 2:05
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 27  *****************
 * User: Akima        Date: 01/12/13   Time: 18:01
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessor���쐬�B
 * Ts0StringsAccessor��Ts0EnumCollection���g�p����B
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 01/11/28   Time: 1:57
 * Updated in $/source/D5Integrated
 * s0PropertyProtoType�̕ύX�ɔ����C���B
 * �����EntityManager�Ńf�[�^���C������Ă������I�Ƀt�H�[���ɔ��f������
 * ���B
 * 
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 01/11/23   Time: 1:59
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridge��AutoUpdate�v���p�e�B��ǉ������B�����True�ɂ����
 * SaveToTarget���\�b�h���Ă΂Ȃ��Ă������I�ɓ��͂��ꂽ���e�����f�����B
 * ����ɔ����ATs0ProtoTypeCtrl���s�v�ȃf�[�^�̏����������N�����Ȃ��悤��
 * LoadFromTarget�ASaveToTarget���\�b�h�ŐV���ɒǉ�����Modified���`�F�b�N
 * ����
 * �悤�ɂ����B
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 01/10/11   Time: 17:23
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridge.OnSaveToCtrl��OnLoadFromCtrl��
 * OnSaveObjToCtrl��OnLoadObjFromCtrl�ɖ��̕ύX�B
 * Ts0ProtoTypeCtrl��OnLoadFromTarget�AOnSaveToTarget�C�x���g��ǉ��B
 *
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 01/10/09   Time: 9:09
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/10/05   Time: 16:54
 * Updated in $/source/D5Integrated
 * �Ή�����R���g���[����RegisterClass����悤�ɏC��
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/10/05   Time: 14:19
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/10/05   Time: 13:05
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/10/04   Time: 21:08
 * Updated in $/source/D5Integrated
 * ���������R���g���[����Prefix�ƃv���p�e�B������Ȃ�Name�v���p�e�B��ݒ�
 * ����B
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/10/04   Time: 12:25
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/10/03   Time: 23:49
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/03   Time: 0:25
 * Updated in $/source/D5Integrated
 * ClearCtrls���\�b�h�Ȃǂ�ǉ��B
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/02   Time: 3:17
 * Updated in $/source/D5Integrated
 * MakeDefualtProtoTypes���\�b�h�ŁAIsEnum�AIsSet�AIsPersistent�A
 * EnumMember�v���p�e�B��ݒ肷��悤�ɂ����B
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/01   Time: 17:37
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/01   Time: 9:12
 * Updated in $/source/D5Integrated
 * Builder��Bridge�̖����𖾊m�����Ă���Œ��B���t�@�N�^�����O���B
 *
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/25   Time: 10:08
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBridge���g�p���ɃN���C�A���g���ōׂ������䂪�ł���悤��
 * �C�x���g��ǉ�
 *
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/23   Time: 1:09
 * Updated in $/source/D5Integrated
 * ProtoTypes�v���p�e�B�ɍ��ڂ������Ƃ��ɁATarget���w�肳�ꂽ��
 * �f�t�H���g�̍��ڂ��쐬����MakeDefualtProtoTypes���쐬�B
 *
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/21   Time: 17:02
 * Updated in $/source/D5Integrated
 * Ts0ObjCtrlBuilder�ɃN���X����ύX
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/21   Time: 16:25
 * Updated in $/source/D5Integrated
 * ���j�b�g����ύX�����B
 * Entity�Ɉˑ����Ȃ��N���X�ł��B
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/21   Time: 16:22
 * Updated in $/source/D5Integrated
 * LoadFromTarget�ASaveToTarget���\�b�h��Ts0ProtoTypeCtrl�Ɏ��������B
}

interface

uses
  SysUtils, Classes,
  Controls,
  StdCtrls,
  Contnrs,
  TypInfo,
  s0VCLClasses,
  s0Persistent,
  s0TypInfoWrapper,
  s0CommonTypes,
  s0Collection,
  s0CtrlDistiller,
  s0CtrlEventSnatcher,
  s0PropertyProtoType,
  s0CtrlOfType,
  s0InputStyle,
  s0DataAccessor,

  s0Bounds,
  s0Classes,
  s0Iterator,

  s0BoundsLayout,
  s0StringValidater;

type
  {
    Ts0ProtoTypeCtrl�N���X��CtrlBounds�v���p�e�B�̂��߂̃N���X�B
  }
  Ts0PTCBounds = class(Ts0Bounds)
  private
    FLinking: Boolean;
    procedure SetLinking(const Value: Boolean);
    function GetRealCtrl: TControl;
    function GetRealLabel: TCustomLabel;
  protected
    procedure SetBoundsOfCtrl;
    property RealCtrl: TControl read GetRealCtrl;
    property RealLabel: TCustomLabel read GetRealLabel;
  public
    constructor Create(AOwner: TPersistent); override;
  published
    function GetValue(const AKind: Ks0BoundsItemKind): Integer; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Linking: Boolean read FLinking write SetLinking default True;
  end;

type
  Ts0ProtoTypeCtrl = class;

  K0ProtoTypeCtrlEvent = procedure(Sender: Ts0ProtoTypeCtrl) of object;
  K0PTCOption = (k0ptcoAutoChangeCtrlClassName);
  K0PTCOptions = set of K0PTCOption;

  {
    Ts0ObjCtrlBridge�R���|�[�l���g�����삷��ۂ́ATarget�v���p�e�B���Q�Ƃ���
    �e�v���p�e�B�ƁA�e�R���g���[���̋��n�������邽�߂̃N���X�B
  }
  Ts0ProtoTypeCtrl = class(Ts0PropertyProtoType, Is0Bounds, Is0Identified)
  private
    FAccessor: Ts0DataAccessor;
    FCtrl: TControl;
    FCtrlLabel: TCustomLabel;
    FEnumAsString: Boolean;
    FCtrlParent: TWinControl;
    FOnLoadFromTarget: K0ProtoTypeCtrlEvent;
    FOnSaveToTarget: K0ProtoTypeCtrlEvent;
    FCtrlListener: Ts0CtrlEventListener;
    FAutoUpdateKinds: K0CtrlEventTypeSet;
    FRTTIProp: Ts0RTTIProp;
    FCtrlClassName: string;
    FOptions: K0PTCOptions;
    FCtrlBounds: Ts0PTCBounds;
    FIntfBounds: Is0Bounds;
    procedure SetCtrl(const Value: TControl);
    function GetAccessor: Ts0DataAccessor;
    procedure SetCtrlLabel(const Value: TCustomLabel);
    procedure SetCtrlParent(const Value: TWinControl);
    procedure SetAutoUpdateKinds(const Value: K0CtrlEventTypeSet);
    function GetSnatched: Boolean;
    function GetModified: Boolean;
    procedure SetCtrlClassName(const Value: string);
    procedure SetOptions(const Value: K0PTCOptions);
    procedure SetCtrlBounds(Value: Ts0PTCBounds);
  protected
    procedure DoLoadFromTarget;
    procedure DoSaveToTarget;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetWapper: Ts0RTTIPublishedAccessor; override;
    procedure SetAcceptCharTypes(const Value: K1InpCharSet); override;
    procedure SetImeModeSX(const Value: K0ImeMode); override;
    procedure SetPropertyName(const Value: string); override;
    procedure ResetCtrlProp;
  protected
    procedure SetEnumName(const Value: string); override;
    procedure SetIsEnum(const Value: Boolean); override;
    procedure SetIsPersistent(const Value: Boolean); override;
    procedure SetIsSet(const Value: Boolean); override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    {
      Ctrl�v���p�e�B�ŕ\�����֘A����R���g���[����j�����郁�\�b�h�B
    }
    procedure FreeCtrl;
    {
      ���������R���g���[��������������B
      ���ۂɂ́A�֘A����Label��Caption��IMEMode��MaxLength�v���p�e�B�Ȃǂ�
      �ݒ肷��B
    }
    procedure InitCtrl; virtual;
    {
      �Ή�����v���p�e�B�̒l���擾���A�R���g���[���ɔ��f���郁�\�b�h�B
    }
    procedure LoadFromTarget; virtual;
    {
      �R���g���[������l���擾���A�Ή�����v���p�e�B�̒l�ɐݒ肷�郁�\�b�h�B
    }
    procedure SaveToTarget; virtual;
    property Accessor: Ts0DataAccessor read GetAccessor;
    {
      �R���g���[���ɓ��͂���Ă���l�ƁA�Ή�����v���p�e�B�̒l������Ă��邩
      �ǂ����������v���p�e�B�B
    }
    property Modified: Boolean read GetModified;
  protected
    procedure SetUpdating(const Value: Boolean);
    procedure ValidateCtrlClassName; virtual;
  public
    {
      ImeModeSX�v���p�e�B(K0ImeMode�^)�̒l��TImeMode�^�ɕϊ����郁�\�b�h�B
    }
    function GetImeMode: TImeMode;
    {
      �R���g���[���𐶐�����ۂɌĂяo�����A�R���g���[���𐶐�����K�v��
      ���邩�ǂ������������\�b�h�B
    }
    function NeedCtrl: Boolean;
    {
      �R���g���[���̃C�x���g���t�b�N���郁�\�b�h�B
      �t�b�N���邱�ƂŃR���g���[���̃C�x���g�ɂ���Ă��̃N���X�͓�����s���܂��B
      ���̃��\�b�h�ɂ����Snatched�v���p�e�B��True�ɐݒ肳��܂��B
    }
    procedure SnatchEvents;
    {
      �R���g���[���̃C�x���g�̃t�b�N���������郁�\�b�h�B
      ���̃��\�b�h�ɂ����Snatched�v���p�e�B��False�ɐݒ肳��܂��B
    }
    procedure PutBackEvents;
    {
      �R���g���[���̃C�x���g���t�b�N���Ă��邩�ǂ����������v���p�e�B�B
      SnatchEvents�APutBackEvents�ɂ���Ēl�͕ύX����܂��B
    }
    property Snatched: Boolean read GetSnatched;
    { Is0Bounds }
    {
      CtrlBounds�v���p�e�B��Is0Bounds�Ƃ��Ď擾���邽�߂̃v���p�e�B�B
    }
    property IntfBounds: Is0Bounds read FIntfBounds implements Is0Bounds;
  published
    {
      K0CtrlEventType = (k0cetOnExit, k0cetOnClick, k0cetOnPressEnter, k0cetOnKeyUp, k0cetOnChange);
      K0CtrlEventTypeSet = set of K0CtrlEventType;
      
      �t�b�N�����R���g���[���̂ǂ̃C�x���g�ɂ���ĕύX���ꂽ�ƌ��Ȃ�����
      ���߂��v���p�e�B�B
    }
    property AutoUpdateKinds: K0CtrlEventTypeSet read FAutoUpdateKinds write SetAutoUpdateKinds default [];
    {
      �֘A�t�����Ă���R���g���[���������v���p�e�B�B
      �݌v���ɐݒ肷�邱�Ƃ��\�B
    }
    property Ctrl: TControl read FCtrl write SetCtrl;
    {
      �R���g���[���𐶐�����Ƃ��ɁA�R���g���[����Left, Top, Width, Height
      �v���p�e�B��ݒ肷�邽�߂̃v���p�e�B�B
      Ts0PTCBounds�N���X���Q�ƁB
    }
    property CtrlBounds: Ts0PTCBounds read FCtrlBounds write SetCtrlBounds;
    {
      �R���g���[���𐶐�����ۂɁA�ǂ̃N���X�̃R���g���[���𐶐�����̂���
      �w�肷��v���p�e�B�B�݌v����Ctrl�v���p�e�B��ݒ肵���ꍇ�ɂ́A�ݒ肷��
      �K�v�͂���܂���B
    }
    property CtrlClassName: string read FCtrlClassName write SetCtrlClassName;
    {
      �֘A�t����ꂽ�R���g���[���ɑΉ����郉�x�����w��ł���v���p�e�B�B
    }
    property CtrlLabel: TCustomLabel read FCtrlLabel write SetCtrlLabel;
    {
      �R���g���[�������������ۂɁA�ǂ̃R���g���[����Parent�Ƃ��Đ�������̂���
      �w�肷��v���p�e�B�B�f�t�H���g�ł́ATs0ObjCtrlBridge.Builder.CtrlParent
      �v���p�e�B�Ŏw�肳�ꂽ�R���g���[�����ݒ肳���B
    }
    property CtrlParent: TWinControl read FCtrlParent write SetCtrlParent;
    {
      �Ή�����v���p�e�B�̌^���񋓌^�ł������ꍇ�ɁA�v���p�e�B�ɑ΂���
      �l��ݒ肷��Ƃ��ɁA������Ƃ��Đݒ肷��̂��A�{���̗񋓌^�Ƃ��Đݒ肷��
      �̂����w�肷��v���p�e�B�B
      ��{�I�ɕύX����K�v�͂���܂���B
    }
    property EnumAsString: Boolean read FEnumAsString write FEnumAsString;
    {
      Ts0ObjCtrlBridge.LoadFromTarget���\�b�h�����s���ꂽ�Ƃ��ɁA
      �eProtoTypes�̊e���ڂ��ƂɌĂяo�����C�x���g�B
    }
    property OnLoadFromTarget: K0ProtoTypeCtrlEvent read FOnLoadFromTarget write FOnLoadFromTarget;
    {
      Ts0ObjCtrlBridge.SaveToTarget���\�b�h�����s���ꂽ�Ƃ��ɁA
      �eProtoTypes�̊e���ڂ��ƂɌĂяo�����C�x���g�B
    }
    property OnSaveToTarget: K0ProtoTypeCtrlEvent read FOnSaveToTarget write FOnSaveToTarget;
    {
      K0PTCOption = (k0ptcoAutoChangeCtrlClassName);
      K0PTCOptions = set of K0PTCOption;

      Ts0ProtoTypeCtrl�̐U�镑�����w�肷��I�v�V������\���v���p�e�B�B

      k0ptcoAutoChangeCtrlClassName
        IsEnum�v���p�e�B�Ȃǂɂ���āA���������ׂ��R���g���[���̃N���X��
        �ύX�����ׂ��ꍇ�ɁA�����I�ɕύX���邩�ǂ����������܂��B
    }
    property Options: K0PTCOptions read FOptions write SetOptions default [k0ptcoAutoChangeCtrlClassName];
  end;

type
  Ts0ProtoTypeCtrls = class(Ts0PropertyProtoTypes)
  private
    function GetPropCtrls(const Index: Integer): Ts0ProtoTypeCtrl;
    procedure SetPropCtrls(const Index: Integer;
      const Value: Ts0ProtoTypeCtrl);
  protected
    function GetOriginal: Ts0PropertyProtoTypes; override;
    procedure SetOriginal(const Value: Ts0PropertyProtoTypes); override;
    procedure NotifyOriginalUpdate(AItem: Ts0PropertyProtoType); override;
  public
    constructor Create(AOwner: TPersistent; AItemClass: Ts0CollectionItemClass); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IndexOfProp(APropName: string): Integer;
    function FindPropCtrls(const APropName: string): Ts0ProtoTypeCtrl;
    property PropCtrls[const Index: Integer]: Ts0ProtoTypeCtrl read GetPropCtrls write SetPropCtrls;
  end;

type
  K0ECBFindCtrlClassEvent = procedure(Sender: TObject; AProp: Ts0ProtoTypeCtrl;
    var ACtrlClass: TControlClass) of object;

  K0ECBCreateCtrlEvent = procedure(Sender: TObject; AProp: Ts0ProtoTypeCtrl;
    AControl: TControl) of object;

type
  {
    �R���g���[���𐶐�����ۂɁA�R���g���[����Name�v���p�e�B�ɂǂ̂悤��
    �ړ���������̂����w�肷�邽�߂̃N���X�B
    �ړ������w�肷��P�ʂ̓N���X���B
    PartOfCtrlClassName�v���p�e�B���ΏۂƂȂ�R���g���[���̃N���X�A
    Prefix�v���p�e�B���ݒ肳���ړ����������܂��B
  }
  Ts0CtrlNamePrefix = class(Ts0VCLCollectionItem)
  private
    FPrefix: string;
    FPartOfCtrlClassName: string;
    procedure SetPartOfCtrlClassName(const Value: string);
    procedure SetPrefix(const Value: string);
  published
    property PartOfCtrlClassName: string read FPartOfCtrlClassName write SetPartOfCtrlClassName;
    property Prefix: string read FPrefix write SetPrefix;
  end;

type
  Ts0CtrlNamePrefixes = class(Ts0VCLCollection)
  private
    function GetPrefixes(const Index: Integer): Ts0CtrlNamePrefix;
    procedure SetPrefixes(const Index: Integer;
      const Value: Ts0CtrlNamePrefix);
  public
    function Add(APartOfCtrl: string; APrefix: string): Ts0CtrlNamePrefix;
    property Prefixes[const Index: Integer]: Ts0CtrlNamePrefix read GetPrefixes write SetPrefixes; default;
  end;

type
  Ts0ObjCtrlBridge = class;

  Ts0ObjCtrlBuilder = class(Ts0VCLPersistent)
  private
    FCtrlParent: TWinControl;
    FCtrlOwner: TComponent;
    FCtrlMargin: Integer;
    FCtrlPrefixes: Ts0CtrlNamePrefixes;
    FCtrlOfType: Ts0CtrlOfType;
    FActive: Boolean;
    FLabelBreath: Integer;
    FDefaultCtrlWidth: Integer;
    FDefaultCtrlHeight: Integer;
    procedure SetCtrlParent(const Value: TWinControl);
    procedure SetCtrlOwner(const Value: TComponent);
    procedure SetCtrlPrefixes(const Value: Ts0CtrlNamePrefixes);
    function GetProtoTypes: Ts0ProtoTypeCtrls;
    function GetWrapper: Ts0RTTIPublishedAccessor;
    procedure SetCtrlOfType(const Value: Ts0CtrlOfType);
    function GetCtrlOfTypeClassName: string;
    procedure SetCtrlOfTypeClassName(const Value: string);
    procedure SetActive(const Value: Boolean);
    function GetCtrlOfType: Ts0CtrlOfType;
    procedure SetLabelBreath(const Value: Integer);
  protected
    function CreateCtrlOf(AProp: Ts0ProtoTypeCtrl): TControl; virtual;
    function CreateCtrlImpl(ACtrlClass: TControlClass; AProp: Ts0ProtoTypeCtrl): TControl;
    procedure DoBeforeBuild;
    procedure DoAfterBuild;
    procedure DoCreateCtrl(AProp: Ts0ProtoTypeCtrl; AControl: TControl);
    procedure DoInitCtrl(AProp: Ts0ProtoTypeCtrl; AControl: TControl);
    procedure DoFindCtrlClass(AProp: Ts0ProtoTypeCtrl; var ACtrlClass: TControlClass); virtual;
    function GetOwnerBridge: Ts0ObjCtrlBridge;
    function GetPrefixByClassName(AClassName: string): string;
    procedure InitCtrlPrefixes;
    function NewCtrlOfType: Ts0CtrlOfType; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    {
      Ts0ObjCtrlBridge.ProtoTypes�v���p�e�B�����ɁA�R���g���[���̐�����
      ���s���郁�\�b�h�B�ʏ�A���̃��\�b�h���g�p�����ɁA
      Ts0ObjCtrlBridge.BuildCtrls���\�b�h���g�p���Ă��������B
    }
    procedure Execute;
    {
      �R���|�[�l���g�̔j���̒ʒm���󂯂郁�\�b�h�B
      �ʏ킱�̃��\�b�h���A�Ăяo�����Ƃ͂���܂���B
    }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {
      Ts0ObjCtrlBridge.Wrapper�v���p�e�B�Ŏ������Ts0RTTIPublishedAccessor
      ���Q�Ƃ���v���p�e�B�B
    }
    property Wrapper: Ts0RTTIPublishedAccessor read GetWrapper;
    {
      Ts0ObjCtrlBridge.ProtoTypes�v���p�e�B���Q�Ƃ���v���p�e�B�B
    }
    property ProtoTypes: Ts0ProtoTypeCtrls read GetProtoTypes;
    {
      �R���g���[���𐶐�����ۂɁA�v���p�e�B�̌^�Ȃǂɑ΂��Ăǂ̃N���X��
      �R���g���[����ݒ肷��̂��𔻒f���邽�߂̃I�u�W�F�N�g�B
      CtrlOfTypeClassName�v���p�e�B�ɂ���āA�ǂ�Ts0CtrlOfType�N���X���g�p����
      �̂����w��ł��܂��B
    }
    property CtrlOfType: Ts0CtrlOfType read GetCtrlOfType write SetCtrlOfType;
  published
    {
      �݌v����Execute���\�b�h���Ăяo�����߂̃v���p�e�B�B
      True��ݒ肷���Execute���\�b�h�����s����܂��B
    }
    property Active: Boolean read FActive write SetActive stored False;
    {
      �R���g���[���̐�����s���ۂɁA�R���g���[���Ԃ̊Ԋu�����s�N�Z����
      ����̂����w�肷��v���p�e�B
    }
    property CtrlMargin: Integer read FCtrlMargin write FCtrlMargin default 4;
    {
      �R���g���[���̐������s���ۂɁA�R���g���[����Owner���ǂ̃R���|�[�l���g
      �ɂ���̂����w��ł���v���p�e�B�B
      �ʏ�w�肷��K�v�͂���܂���B
    }
    property CtrlOwner: TComponent read FCtrlOwner write SetCtrlOwner;
    {
      �R���g���[���̐������s���ۂɁA�R���g���[����Parent���ǂ̃R���|�[�l���g
      �ɂ���̂����w�肷��v���p�e�B�B
      �R���g���[�����Ƃ�Parent���w�肷��ꍇ�ɂ�Ts0ObjCtrlBridge.ProtoTypes��
      �e���ڂ�CtrlParent�v���p�e�B�Ŏw�肷�邱�Ƃ��ł��܂��B
    }
    property CtrlParent: TWinControl read FCtrlParent write SetCtrlParent;
    {
      �R���g���[���𐶐�����ۂɁA�R���g���[����Name�v���p�e�B�ɂǂ̂悤��
      �ړ���������̂����w�肷�邽�߂̃I�u�W�F�N�g�B
      Ts0CtrlNamePrefixes�N���X���Q�ƁB
    }
    property CtrlPrefixes: Ts0CtrlNamePrefixes read FCtrlPrefixes write SetCtrlPrefixes;
    {
      CtrlOfType�v���p�e�B�������I�u�W�F�N�g�Ƃ��āA�ǂ̃N���X���g�p����̂���
      �����v���p�e�B�BTs0CtrlOfType�̔h���N���X�̖��O���w�肷��B
    }
    property CtrlOfTypeClassName: string read GetCtrlOfTypeClassName write SetCtrlOfTypeClassName;
    {
      ��������R���g���[���̃f�t�H���g��Width���w��ł���v���p�e�B�B
      �e�R���g���[����Width�͐��������ۂ̃f�t�H���g�̒l���g�p����邪�A
      �����ݒ�ł��Ȃ��ꍇ�A���邢�͐����R���g���[���̃N���X�����w��
      �̏ꍇ�ɂ́A���̃v���p�e�B�������l���g�p�����B
    }
    property DefaultCtrlWidth: Integer read FDefaultCtrlWidth write FDefaultCtrlWidth default 300;
    {
      ��������R���g���[���̃f�t�H���g��Height���w��ł���v���p�e�B�B
      �e�R���g���[����Height�͐��������ۂ̃f�t�H���g�̒l���g�p����邪�A
      �����ݒ�ł��Ȃ��ꍇ�A���邢�͐����R���g���[���̃N���X�����w��
      �̏ꍇ�ɂ́A���̃v���p�e�B�������l���g�p�����B
    }
    property DefaultCtrlHeight: Integer read FDefaultCtrlHeight write FDefaultCtrlHeight default 24;
    {
      �R���g���[���𐶐�����ۂɁA���x���̕����邢�͍��������s�N�Z���m��
      ����̂����w�肷��B
    }
    property LabelBreath: Integer read FLabelBreath write SetLabelBreath default 100;
  end;

  K0ObjAccessEvent = procedure(Sender: TObject; AObj: TObject; ACtrl: TControl) of object;

  {
    Target�v���p�e�B�Ŏw�肳�ꂽ�I�u�W�F�N�g��published�v���p�e�B�̒l��
    �t�H�[����Ȃǂ̃R���g���[���ɐݒ肵�A���Z���ꂽ�l���I�u�W�F�N�g�ɐݒ�
    �����邽�߂̃R���|�[�l���g�ł��B

    Target�v���p�e�B��ݒ肷��ƁA���̃I�u�W�F�N�g�̊epublished�v���p�e�B��
    �Ή�����f�[�^��ProtoTypes�v���p�e�B�̍��ڂƂ��Đ�������܂��B
    ProtoTypes�v���p�e�B�̊e���ڂ́A�R���g���[���Ƃ̊֘A��ێ����܂��B

    �R���g���[���́AProtoTypes�v���p�e�B�̊e���ڂ����ɁABuildCtrls���\�b�h�Ȃ�
    �ɂ�萶������܂��B
    Builder�v���p�e�B��CtrlParent�v���p�e�B��ݒ肵�Ă����K�v������܂��B

    Target�v���p�e�B�Ŏw�肳���I�u�W�F�N�g�̊e�v���p�e�B�ƁA����ɑΉ�����
    (ProtoTypes�v���p�e�B�̊e����)�̃R���g���[���Ƃ̃f�[�^�̂����́A
    LoadFromTarget�ASaveToTarget���\�b�h�Ȃǂōs���܂����AAutoUpdate�v���p�e�B
    ��True�Ȃ�Ύ����I�ɂ���炪�s���܂��B
  }
  Ts0ObjCtrlBridge = class(Ts0VCLComponent)
  private
    FBuilder: Ts0ObjCtrlBuilder;
    FTarget: TObject;
    FProtoTypes: Ts0ProtoTypeCtrls;
    FWrapper: Ts0RTTIPublishedAccessor;
    FOnLoadObjFromCtrl: K0ObjAccessEvent;
    FOnSaveObjToCtrl: K0ObjAccessEvent;
    FAutoUpdate: Boolean;
    FProtoSourcePropName: string;
    FProtoSourceCompo: TComponent;
    FOnInitCtrl: K0ECBCreateCtrlEvent;
    FOnStandInCtrls: TNotifyEvent;
    FDisabledProps: TStrings;
    FLayoutSet: Ts0LayoutSet;
    FAfterBuild: TNotifyEvent;
    FBeforeBuild: TNotifyEvent;
    procedure SetProtoTypes(const Value: Ts0ProtoTypeCtrls);
    procedure SetBuilder(const Value: Ts0ObjCtrlBuilder);
    procedure SetAutoUpdate(const Value: Boolean);
    function GetProtoSource: Ts0PropertyProtoTypes;
    procedure SetProtoSource(const Value: Ts0PropertyProtoTypes);
    procedure SetTargetComponent(const Value: TComponent);
    function GetTargetComponent: TComponent;
    procedure SetDisabledProps(const Value: TStrings);
    procedure SetLayoutSet(const Value: Ts0LayoutSet);
  private
    { Is0Aggregate }
    //FAggregate: Is0Aggregate;
  private
    { Builder Event }
    FOnCreateCtrl: K0ECBCreateCtrlEvent;
    FOnFindCtrlClass: K0ECBFindCtrlClassEvent;
  protected
    procedure DoLoadObjFromCtrl(AObj: TObject; ACtrl: TControl);
    procedure DoSaveObjToCtrl(AObj: TObject; ACtrl: TControl);
    function GetCtrlClassNameByProp(AProto: Ts0ProtoTypeCtrl): String; virtual;
    procedure InitProtoCtrl(AProto: Ts0ProtoTypeCtrl);
    procedure MakeDefualtProtoTypes;
    function NewBuilder: Ts0ObjCtrlBuilder; virtual;
    function NewProtoTypes: Ts0ProtoTypeCtrls; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetTarget(const Value: TObject); virtual;
    procedure Loaded; override;
  protected
    procedure BeginUpdate;
    procedure EndUpdate;
    property ProtoSource: Ts0PropertyProtoTypes read GetProtoSource write SetProtoSource;
    //
    procedure DoStandInCtrls;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {
      ProtoTypes�v���p�e�B�̊e���ڂ����ɁA�R���g���[���𐶐�����B
    }
    procedure BuildCtrls; virtual;
    {
      ProtoTypes�v���p�e�B�̊e���ڂɊ֘A�t����ꂽ�R���g���[����j������B
    }
    procedure ClearCtrls; virtual;
    {
      Target�v���p�e�B�Ŏw�肳�ꂽ�I�u�W�F�N�g�̊e�v���p�e�B�̂����A
      ProtoTypes�v���p�e�B�ɓo�^����Ă�����̂ɂ��āA�v���p�e�B��
      �l���֘A�A����Ă���R���g���[���ɐݒ肷��B
      ���ۂɂ́AProtoTypes�̊e���ڂ�LoadFromTarget���\�b�h�����s�����B
    }
    procedure LoadFromTarget; virtual;
    {
      Target�v���p�e�B�Ŏw�肳�ꂽ�I�u�W�F�N�g�̊e�v���p�e�B�̂����A
      ProtoTypes�v���p�e�B�ɓo�^����Ă�����̂ɂ��āA���̃v���p�e�B��
      �債�Ċ֘A�A����Ă���R���g���[���̒l��ݒ肷��B
      ���ۂɂ́AProtoTypes�̊e���ڂ�SaveToTarget���\�b�h�����s�����B
    }
    procedure SaveToTarget; virtual;
    {
      ProtoTypes�̊e���ڂ̕\����̈ʒu�𐮂���B
      ���ۂɂ�ProtoTypes�̊e���ڂ�Bounds�v���p�e�B�ɒl��ݒ肷��B
      Builder.LabelBreath�v���p�e�B�ABuilder.CtrlMargin�v���p�e�B���Q�ƁB
    }
    procedure StandInCtrls; virtual;
    {

    }
    procedure ApplyCtrlClassNames; virtual;
    {
      �f�[�^��\��/�ݒ肷��ΏۂƂȂ�I�u�W�F�N�g��ݒ肷��B
      ���̃R���|�[�l���g���g�p����ۂɂ͕K�����̃v���p�e�B��ݒ肵�Ȃ����
      �Ȃ�܂���B
      ���̃v���p�e�B�ɑ΂���nil�ȊO�̒l��ݒ肵���Ƃ��AProtoTypes�ɍ��ڂ����
      �ݒ肳��Ă��Ȃ��̂ł���΁ATarget�Ŏw�肳�ꂽ�I�u�W�F�N�g��published
      �v���p�e�B����A�Ή�����ProtoTypes�̊e���ڂ���������܂��B
      �܂�ProtoTypes�̊e���ڂ��������ꂽ���_��StandInCtrls���\�b�h�����s
      ����܂��B
    }
    property Target: TObject read FTarget write SetTarget;
    {
      Target�v���p�e�B��published�v���p�e�B�ȂǂɃA�N�Z�X���邽�߂̃v���p�e�B�B
      Ts0RTTIPublishedAccessor�N���X���Q�ƁB
    }
    property Wrapper: Ts0RTTIPublishedAccessor read FWrapper;
  public
    { Is0Aggregate }
    //�C���^�[�t�F�[�X�^�v���p�e�B�ւ̈ϔC
    //property Aggregate: Is0Aggregate read FAggregate implements Is0Aggregate;
  published
    {
      ProtoTypes�v���p�e�B�̊e���ڂɊ֘A�t����ꂽ�R���g���[���ɉ��炩�̕ύX
      ���������ꍇ�ɁATarget�v���p�e�B�Ŏ������I�u�W�F�N�g�̑Ή�����v���p�e�B
      �ɑ΂��āA�����I�ɒl��ݒ肷�邩�ǂ������w�肵�܂��B
      �f�t�H���g�ł�True�B
      False��ݒ肵���ꍇ�A�蓮��LoadFromTarget,SaveToTarget���\�b�h��
      �Ăяo���K�v������܂��B
    }
    property AutoUpdate: Boolean read FAutoUpdate write SetAutoUpdate default True;
    {
      BuildCtrls���\�b�h�Ȃǂɂ��R���g���[���̐������s���ۂɁA���ۂ�
      ���̏������s�����߂̃I�u�W�F�N�g�ւ̎Q�ƁB
      CtrlParent�Ȃǂ̐����ɕK�v�ȃf�[�^��ێ����܂��B
    }
    property Builder: Ts0ObjCtrlBuilder read FBuilder write SetBuilder;
    {
      Target�v���p�e�B�ɉ��炩�̃I�u�W�F�N�g��ݒ肵���ꍇ�ɁAProtoTypes
      �v���p�e�B�ɍ��ڂ�����Ȃ���΁ATarget�v���p�e�B���Q�Ƃ���I�u�W�F�N�g��
      published�v���p�e�B�����ɂ��̃N���X�͎����I�ɑΉ����鍀�ڂ𐶐����܂����A
      ���̍ۂɍ��ڂ̐����̑ΏۂƂȂ�Ȃ��v���p�e�B���w��ł��܂��B
      �f�t�H���g�ł�'Name'��'Tag'���ǉ�����Ă��܂��B
    }
    property DisabledProps: TStrings read FDisabledProps write SetDisabledProps;
    {
      ���̃R���|�[�l���g�����삷��ۂ̊e�v���p�e�B���̃f�[�^��ێ�/�������s��
      �v���p�e�B�B�ڂ�����Ts0ProtoTypeCtrls���Q�Ƃ��Ă��������B
    }
    property ProtoTypes: Ts0ProtoTypeCtrls read FProtoTypes write SetProtoTypes;
    {
      StandInCtrls���\�b�h�����s���āA�e���ڂ̈ʒu�𐮂���ۂɁA���̍��ږ���
      �ʒu��ݒ肷�邽�߂̃R���|�[�l���g���w�肵�܂��B
    }
    property LayoutSet: Ts0LayoutSet read FLayoutSet write SetLayoutSet;
    {
      �݌v����Target�v���p�e�B���w�肷�邽�߂̃v���p�e�B�ł��B
      ���̃v���p�e�B�ɉ��炩�̃R���|�[�l���g��ݒ肷��ƁA�����I��Target
      �v���p�e�B�ɂ��ꂪ�ݒ肳��܂��B
    }
    property TargetComponent: TComponent read GetTargetComponent write SetTargetComponent;
    property OnLoadObjFromCtrl: K0ObjAccessEvent read FOnLoadObjFromCtrl write FOnLoadObjFromCtrl;
    property OnSaveObjToCtrl: K0ObjAccessEvent read FOnSaveObjToCtrl write FOnSaveObjToCtrl;
  published
    {
      �݌v����Target�v���p�e�B��ݒ肷�邽�߂̃v���p�e�B�ł��B
      TargetComponent�v���p�e�B�Ƃ̕��p�͂ł��܂���B
      ProtoSourcePropName�v���p�e�B�ƈꏏ�Ɏg�p���܂��B
      TargetComponent�Ƃ͈���ăR���|�[�l���g�𒼐ڎw�肷��̂ł͂Ȃ��A
      ����R���|�[�l���g�̂���v���p�e�B���Q�Ƃ���I�u�W�F�N�g��Target�v���p�e�B
      �ɐݒ肵�܂��B
      ProtoSourceCompo�v���p�e�B�ŏ�L�́u����R���|�[�l���g�v��ݒ肵�A
      ProtoSourcePropName�v���p�e�B�ŏ�L�́u����v���p�e�B�v��ݒ肵�܂��B
    }
    property ProtoSourceCompo: TComponent read FProtoSourceCompo write FProtoSourceCompo;
    {
      ProtoSourceCompo�v���p�e�B���Q�Ƃ��Ă��������B
    }
    property ProtoSourcePropName: string read FProtoSourcePropName write FProtoSourcePropName;
  published
    { Builder Event }
    {
      BuildCtrls�ȂǂŁA�R���g���[���𐶐����钼�O�ɌĂяo�����C�x���g�ł��B
    }
    property BeforeBuild: TNotifyEvent read FBeforeBuild write FBeforeBuild;
    {
      BuildCtrls�ȂǂŁA�R���g���[���𐶐���������ɌĂяo�����C�x���g�ł��B
    }
    property AfterBuild: TNotifyEvent read FAfterBuild write FAfterBuild;
    {
      BuildCtrls�ȂǂŁA���̃R���g���[���𐶐�����ۂɌĂяo�����
      �C�x���g�ł��B
    }
    property OnCreateCtrl: K0ECBCreateCtrlEvent read FOnCreateCtrl write FOnCreateCtrl;
    {
      BuildCtrls�ȂǂŁA���̃R���g���[���𐶐����A����������ۂ�
      �Ăяo�����C�x���g�ł��B
    }
    property OnInitCtrl: K0ECBCreateCtrlEvent read FOnInitCtrl write FOnInitCtrl;
    {
      BuildCtrls�ȂǂŁA���̃R���g���[���𐶐�����O�ɁA���������
      �R���g���[���̃N���X��₢���킹��C�x���g�ł��B
      ������ACtrlClass�ɓK���ȃR���g���[���̃N���X��ݒ肷�邱�ƂŁA
      ���������R���g���[���̃N���X��ύX���邱�Ƃ��ł��܂��B
    }
    property OnFindCtrlClass: K0ECBFindCtrlClassEvent read FOnFindCtrlClass write FOnFindCtrlClass;
    {
      StandInCtrls���\�b�h�����s����ۂɌĂяo�����C�x���g�ł��B
    }
    property OnStandInCtrls: TNotifyEvent read FOnStandInCtrls write FOnStandInCtrls;
  end;

implementation

uses
  s0ComponentHelper;

{ Ts0PTCBounds }

constructor Ts0PTCBounds.Create(AOwner: TPersistent);
begin
  inherited;
  FLinking := True;
end;

function Ts0PTCBounds.GetRealCtrl: TControl;
begin
  Result := nil;
  if not(OwnerObj is Ts0ProtoTypeCtrl) then Exit;
  Result := Ts0ProtoTypeCtrl(OwnerObj).Ctrl;
end;

function Ts0PTCBounds.GetRealLabel: TCustomLabel;
begin
  Result := nil;
  if not(OwnerObj is Ts0ProtoTypeCtrl) then Exit;
  Result := Ts0ProtoTypeCtrl(OwnerObj).CtrlLabel;
end;

function Ts0PTCBounds.GetValue(const AKind: Ks0BoundsItemKind): Integer;
  function GetBoundsOfCtrls(const AKind: Ks0BoundsItemKind): Integer;
  var
    d: Integer;
  begin
    Result := 0;
    if RealCtrl = nil then Exit;
    if OwnerComponent is Ts0ObjCtrlBridge then
      d := Ts0ObjCtrlBridge(OwnerComponent).Builder.LabelBreath
    else
      d := 0;
    //
    case AKind of
      ks0bkLeft  :
        if RealLabel = nil then
          Result := RealCtrl.Left
        else
          Result := RealLabel.Left;
      ks0bkTop   : Result := RealCtrl.Top;
      ks0bkWidth :
        if RealLabel = nil then
          Result := RealCtrl.Width
        else
          Result := RealCtrl.Width + RealLabel.Width + d;
      ks0bkHeight: Result := RealCtrl.Height;
    end;
  end;
begin
  if FLinking and (RealCtrl <> nil) then
    Result := GetBoundsOfCtrls(AKind)
  else
    Result := inherited GetValue(AKind);
end;

procedure Ts0PTCBounds.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if FLinking and (RealCtrl <> nil) then
    SetBoundsOfCtrl;
end;

procedure Ts0PTCBounds.SetBoundsOfCtrl;
var
  d: Integer;
  bufLinking: Boolean;
begin
  //if not Linking then Exit;
  bufLinking := FLinking;
  FLinking := False;
  try
    if not(OwnerObj is Ts0ProtoTypeCtrl) then Exit;
    if RealCtrl = nil then Exit;
    if OwnerComponent is Ts0ObjCtrlBridge then
      d := Ts0ObjCtrlBridge(OwnerComponent).Builder.LabelBreath
    else
      d := 0;
    //
    if RealLabel = nil then
    begin
      RealCtrl.SetBounds(Left + d, Top, Width -d, Height);
    end
    else
    begin
      RealLabel.SetBounds(Left, Top,         d, Height);
      RealCtrl.SetBounds(Left + d , Top, Width - d, Height);
    end;
  finally
    FLinking := bufLinking;
  end;
end;

procedure Ts0PTCBounds.SetLinking(const Value: Boolean);
begin
  FLinking := Value;
  if FLinking and (RealCtrl <> nil) then
    SetBoundsOfCtrl;
end;

type
  T9ProtoTypeCtrlListener = class(Ts0CtrlEventListener)
  private
    FOwner: Ts0ProtoTypeCtrl;
    FUpdating: Boolean;
    procedure UpdateTarget;
  public
    constructor Create(AOwner: Ts0ProtoTypeCtrl);
    procedure CtrlOnChange(Sender: TObject); override;
    procedure CtrlOnClick(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
    procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); override;
    procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnResize(Sender: TObject); override;
  end;

{ T9ProtoTypeCtrlListener }

constructor T9ProtoTypeCtrlListener.Create(AOwner: Ts0ProtoTypeCtrl);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnChange(Sender: TObject);
begin
  if k0cetOnChange in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnClick(Sender: TObject);
begin
  if k0cetOnClick in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnExit(Sender: TObject);
begin
  if k0cetOnExit in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if k0cetOnPressEnter in FOwner.AutoUpdateKinds then
    if Key = Char(#13) then
      UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if k0cetOnKeyUp in FOwner.AutoUpdateKinds then
    UpdateTarget;
end;

procedure T9ProtoTypeCtrlListener.CtrlOnResize(Sender: TObject);
begin
  if Sender is TControl then
    if TControl(Sender).BoundsRect.Left = 0 then ;
end;

procedure T9ProtoTypeCtrlListener.UpdateTarget;
begin
  if FUpdating then Exit;
  if [csLoading, csReading, csDesigning] * FOwner.OwnerComponent.ComponentState <> [] then Exit;
  if FOwner.Ctrl <> nil then
    if [csLoading, csReading, csDesigning] * FOwner.Ctrl.ComponentState <> [] then Exit;
  FOwner.SaveToTarget;
  if not(FOwner.OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Ts0ObjCtrlBridge(FOwner.OwnerComponent).LoadFromTarget;;
end;

{ Ts0ProtoTypeCtrl }

procedure Ts0ProtoTypeCtrl.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if not(Source is Ts0ProtoTypeCtrl) then Exit;
  Self.FAccessor := nil;
  Self.AutoUpdateKinds := Ts0ProtoTypeCtrl(Source).AutoUpdateKinds;
  Self.CtrlClassName   := Ts0ProtoTypeCtrl(Source).CtrlClassName;
  Self.EnumAsString    := Ts0ProtoTypeCtrl(Source).EnumAsString;
  Self.Options         := Ts0ProtoTypeCtrl(Source).Options;
  FCtrlBounds.Assign( Ts0ProtoTypeCtrl(Source).CtrlBounds );
end;

constructor Ts0ProtoTypeCtrl.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FOptions := [k0ptcoAutoChangeCtrlClassName];
  FCtrlBounds := Ts0PTCBounds.Create(Self);
  FIntfBounds := FCtrlBounds; //�v���p�e�B�ւ̃C���^�t�F�[�X�̈ϔC
  IF OwnerComponent is Ts0ObjCtrlBridge then
    FCtrlParent := Ts0ObjCtrlBridge(OwnerComponent).Builder.CtrlParent;
end;

destructor Ts0ProtoTypeCtrl.Destroy;
begin
  PutBackEvents;
  FIntfBounds := nil; //Don't forget to clear interface reference!
  FreeAndNil(FCtrlBounds);
  inherited;
end;

procedure Ts0ProtoTypeCtrl.DoLoadFromTarget;
begin
  if Assigned(FOnLoadFromTarget) then
    FOnLoadFromTarget(Self);
end;

procedure Ts0ProtoTypeCtrl.DoSaveToTarget;
begin
  if Assigned(FOnLoadFromTarget) then
    FOnSaveToTarget(Self);
end;

procedure Ts0ProtoTypeCtrl.FreeCtrl;
  procedure ClearAndFree(ACtrl: TControl);
  var
    buf: TControl;
  begin
    if ACtrl = nil then Exit;
    buf := ACtrl;
    if ACtrl.Owner <> nil then
      ACtrl.Owner.RemoveComponent( ACtrl );
    FreeAndNil( buf );
  end;
begin
  ClearAndFree( FCtrl );
  ClearAndFree( FCtrlLabel );
  FAccessor := nil;
end;

function Ts0ProtoTypeCtrl.GetAccessor: Ts0DataAccessor;
begin
  if FCtrl <> nil then
    if FAccessor = nil then
      FAccessor := Ts0CtrlDistillBroker.GetAccessor( FCtrl );
  Result := FAccessor;
  if Result = nil then
    Result := Ts0NullDataAccessor.Instance;
end;

function Ts0ProtoTypeCtrl.GetImeMode: TImeMode;
const
  c9ImeModes: array[K0ImeMode] of TImeMode = (
    imDisable, imClose, imOpen, imDontCare,
    imSAlpha, imAlpha, imHira, imSKata, imKata,
    imChinese, imSHanguel, imHanguel);
begin
  Result := c9ImeModes[ImeModeSX];
end;

function Ts0ProtoTypeCtrl.GetModified: Boolean;
var
  w: Ts0RTTIPublishedAccessor;
  s: string;
  obj: TObject;
begin
  Result := False;
  w := GetWapper;
  if w = nil then Exit;
  if RTTIProp = nil then Exit;
  if Ctrl = nil then Exit;
  case RTTIProp.TypeInfo.TypeKind of
    tkUnknown    : ;
    tkInteger    : Result := w.OrdProp[ PropertyName ]   <> Accessor.AsInteger;
    tkChar       : Result := w.OrdProp[ PropertyName ]   <> Accessor.AsInteger;
    tkEnumeration:
    begin
      if EnumAsString then
        s := Accessor.AsString
      else
        s := RTTIProp.TypeInfo.GetName( Accessor.AsInteger );
      Result := w.EnumProp[ PropertyName ] <> s;
    end;
    tkFloat      : Result := w.FloatProp[ PropertyName ] <> Accessor.AsFloat  ;
    tkString     : Result := w.StrProp[ PropertyName ]   <> Accessor.AsString ;
    tkSet        : Result := w.SetProp[ PropertyName ]   <> Accessor.AsString ;
    tkClass      :
    begin
      obj := w.ObjectProp[ PropertyName ];
      if obj = nil then Exit;
      if obj is TStrings then
        Result := TStrings(obj).Text <> Accessor.AsString;
    end;
    tkMethod     : ;
    tkWChar      : ;
    tkLString    : Result := w.StrProp[ PropertyName ]   <> Accessor.AsString ;
    tkWString    : Result := w.StrProp[ PropertyName ]   <> Accessor.AsString ;
    tkVariant    : ;
    tkArray      : ;
    tkRecord     : ;
    tkInterface  : ;
    tkInt64      : ;
    tkDynArray   : ;
  end;
end;

function Ts0ProtoTypeCtrl.GetSnatched: Boolean;
begin
  Result := FCtrlListener <> nil;
end;

function Ts0ProtoTypeCtrl.GetWapper: Ts0RTTIPublishedAccessor;
begin
  Result := nil;
  if OwnerComponent is Ts0ObjCtrlBridge then
    Result := Ts0ObjCtrlBridge(OwnerComponent).Wrapper
end;

procedure Ts0ProtoTypeCtrl.InitCtrl;
  procedure InitByInputStyle;
  var
    ip: Ts0InputStyle;
  begin
    if not Ts0CtrlDistillBroker.IsTarget(Ctrl) then Exit;
    ip := Ts0CtrlDistillBroker.GetInputControl(Ctrl);
    if ip = nil then
    begin
      Ts0CtrlDistillBroker.SetTitle(JPName, FCtrl);
    end
    else
    begin
      ip.ResizingCtrl := True;
      try
        ip.MaxLength := Self.Size;
        ip.AutoWidth := True;
        ip.ImeMode := Self.GetImeMode;
        ip.AcceptCharType := Self.AcceptCharTypes;
        ip.Title := Self.JPName;
      finally
        ip.ResizingCtrl := False;
      end;
    end;
  end;
begin
  if FCtrl = nil then Exit;
  InitByInputStyle;
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Ts0ObjCtrlBridge(OwnerComponent).InitProtoCtrl(Self);
end;

procedure Ts0ProtoTypeCtrl.LoadFromTarget;
var
  w: Ts0RTTIPublishedAccessor;
  s: string;
  obj: TObject;
begin
  w := GetWapper;
  if w = nil then Exit;
  if RTTIProp = nil then Exit;
  if RTTIProp.TypeInfo.TypeKind = tkClass then
  begin
    if OwnerComponent is Ts0ObjCtrlBridge then
      Ts0ObjCtrlBridge(OwnerComponent).DoLoadObjFromCtrl(
        w.ObjectProp[PropertyName], Ctrl
      );
  end;
  if Ctrl = nil then Exit;
  if not Self.Modified then Exit;
  case RTTIProp.TypeInfo.TypeKind of
    tkUnknown    : ;
    tkInteger    : Accessor.AsInteger := w.OrdProp[ PropertyName ];
    tkChar       : Accessor.AsInteger := w.OrdProp[ PropertyName ];
    tkEnumeration:
    begin
      s := w.EnumProp[ PropertyName ];
      if EnumAsString then
        Accessor.AsString  := s
      else
        Accessor.AsInteger := RTTIProp.TypeInfo.GetEnumValue(s);
    end;
    tkFloat      : Accessor.AsFloat   := w.FloatProp[ PropertyName ];
    tkString     : Accessor.AsString  := w.StrProp[ PropertyName ];
    tkSet        : Accessor.AsString  := w.SetProp[ PropertyName ];
    tkClass      :
    begin
      obj := w.ObjectProp[ PropertyName ];
      if obj = nil then Exit;
      if obj is TStrings then
        Accessor.AsString := TStrings(obj).Text;
    end;
    tkMethod     : ;
    tkWChar      : ;
    tkLString    : Accessor.AsString  := w.StrProp[ PropertyName ];
    tkWString    : Accessor.AsString  := w.StrProp[ PropertyName ];
    tkVariant    : ;
    tkArray      : ;
    tkRecord     : ;
    tkInterface  : ;
    tkInt64      : ;
    tkDynArray   : ;
  end;
end;

function Ts0ProtoTypeCtrl.NeedCtrl: Boolean;
begin
  Result := False;
  if WithoutCtrl then Exit;
  if Ctrl <> nil then Exit;
  Result := True;
end;

procedure Ts0ProtoTypeCtrl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FCtrl = AComponent then
  begin
    FCtrl := nil;
    FAccessor := nil;
  end;
  if FCtrlLabel = AComponent then FCtrlLabel := nil;
end;

procedure Ts0ProtoTypeCtrl.PutBackEvents;
begin
  if FCtrlListener = nil then Exit;
  Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FCtrlListener);
  FreeAndNil(FCtrlListener);
end;

procedure Ts0ProtoTypeCtrl.ResetCtrlProp;
var
  ip: Ts0InputStyle;
begin
  if Ctrl = nil then Exit;
  ip := Ts0CtrlDistillBroker.GetInputControl(Ctrl);
  if ip = nil then Exit;
  ip.AcceptCharType := Self.AcceptCharTypes;
  ip.ImeMode := Self.GetImeMode;
end;

procedure Ts0ProtoTypeCtrl.SaveToTarget;
var
  w: Ts0RTTIPublishedAccessor;
  s: string;
  obj: TObject;
begin
  w := GetWapper;
  if w = nil then Exit;
  if RTTIProp = nil then Exit;
  if RTTIProp.TypeInfo.TypeKind = tkClass then
  begin
    if OwnerComponent is Ts0ObjCtrlBridge then
      Ts0ObjCtrlBridge(OwnerComponent).DoSaveObjToCtrl(
        w.ObjectProp[PropertyName], Ctrl);
  end;
  if Ctrl = nil then Exit;
  if not Self.Modified then Exit;
  case RTTIProp.TypeInfo.TypeKind of
    tkUnknown    : ;
    tkInteger    : w.OrdProp[ PropertyName ]   := Accessor.AsInteger;
    tkChar       : w.OrdProp[ PropertyName ]   := Accessor.AsInteger;
    tkEnumeration:
    begin
      if EnumAsString then
        s := Accessor.AsString
      else
        s := RTTIProp.TypeInfo.GetName( Accessor.AsInteger );
      w.EnumProp[ PropertyName ] := s;
    end;
    tkFloat      : w.FloatProp[ PropertyName ] := Accessor.AsFloat  ;
    tkString     : w.StrProp[ PropertyName ]   := Accessor.AsString ;
    tkSet        : w.SetProp[ PropertyName ]   := Accessor.AsString ;
    tkClass      :
    begin
      obj := w.ObjectProp[ PropertyName ];
      if obj = nil then Exit;
      if obj is TStrings then
        TStrings(obj).Text := Accessor.AsString;
    end;
    tkMethod     : ;
    tkWChar      : ;
    tkLString    : w.StrProp[ PropertyName ]   := Accessor.AsString ;
    tkWString    : w.StrProp[ PropertyName ]   := Accessor.AsString ;
    tkVariant    : ;
    tkArray      : ;
    tkRecord     : ;
    tkInterface  : ;
    tkInt64      : ;
    tkDynArray   : ;
  end;
end;

procedure Ts0ProtoTypeCtrl.SetAcceptCharTypes(const Value: K1InpCharSet);
begin
  inherited SetAcceptCharTypes(Value);
  ResetCtrlProp;
end;

procedure Ts0ProtoTypeCtrl.SetAutoUpdateKinds(
  const Value: K0CtrlEventTypeSet);
begin
  FAutoUpdateKinds := Value;
end;

procedure Ts0ProtoTypeCtrl.SetCtrl(const Value: TControl);
begin
  if FCtrl = Value then Exit;
  PutBackEvents;
  FAccessor := nil;
  FCtrl := Value;
  try
    if FCtrl = nil then Exit;
    CtrlBounds.SetBoundsOfCtrl;
    if not Ts0CtrlDistillBroker.IsTarget(FCtrl) then Exit; 
    if not(csLoading in OwnerComponent.ComponentState) then
      FAutoUpdateKinds := Ts0CtrlDistillBroker.GetUpdateEvents(FCtrl);
    if OwnerComponent is Ts0ObjCtrlBridge then
    begin
      if Ts0ObjCtrlBridge(OwnerComponent).AutoUpdate then
        SnatchEvents;
    end;
  finally
    Changed(False);
  end;
end;

procedure Ts0ProtoTypeCtrl.SetCtrlBounds(Value: Ts0PTCBounds);
begin
  FCtrlBounds.Assign( Value );
end;

procedure Ts0ProtoTypeCtrl.SetCtrlClassName(const Value: string);
begin
  FCtrlClassName := Value;
end;

procedure Ts0ProtoTypeCtrl.SetCtrlLabel(const Value: TCustomLabel);
begin
  FCtrlLabel := Value;
  Changed(False);
end;

procedure Ts0ProtoTypeCtrl.SetCtrlParent(const Value: TWinControl);
begin
  FCtrlParent := Value;
  if FCtrlParent = nil then Exit;
  if not(csAcceptsControls in FCtrlParent.ControlStyle) then
    FCtrlParent := nil;
end;

procedure Ts0ProtoTypeCtrl.SetEnumName(const Value: string);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetImeModeSX(const Value: K0ImeMode);
begin
  inherited;
  ResetCtrlProp;
end;

procedure Ts0ProtoTypeCtrl.SetIsEnum(const Value: Boolean);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetIsPersistent(const Value: Boolean);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetIsSet(const Value: Boolean);
begin
  inherited;
  if k0ptcoAutoChangeCtrlClassName in Options then
    ValidateCtrlClassName;
end;

procedure Ts0ProtoTypeCtrl.SetOptions(const Value: K0PTCOptions);
begin
  FOptions := Value;
end;

procedure Ts0ProtoTypeCtrl.SetPropertyName(const Value: string);
begin
  FreeAndNil(FRTTIProp);
  inherited SetPropertyName(Value);
end;

procedure Ts0ProtoTypeCtrl.SetUpdating(const Value: Boolean);
begin
  if FCtrlListener is T9ProtoTypeCtrlListener then
    T9ProtoTypeCtrlListener(FCtrlListener).FUpdating := Value;
end;

procedure Ts0ProtoTypeCtrl.SnatchEvents;
begin
  if FCtrlListener <> nil then Exit;
  if csDesigning in OwnerComponent.ComponentState then Exit;
  if FCtrl = nil then Exit;
  FCtrlListener := T9ProtoTypeCtrlListener.Create(Self);
  Ts0CtrlEventSnatcher.Instance.RegisterListener(FCtrl, FCtrlListener);
end;

procedure Ts0ProtoTypeCtrl.ValidateCtrlClassName;
var
  newCtrlName: string;
begin
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  newCtrlName := Ts0ObjCtrlBridge(OwnerComponent).GetCtrlClassNameByProp(Self);
  if newCtrlName = '' then Exit;
  CtrlClassName := newCtrlName;
end;

{ Ts0ProtoTypeCtrls }

procedure Ts0ProtoTypeCtrls.Assign(Source: TPersistent);
begin
  if Source is Ts0PropertyProtoTypes then
  begin
    if Self.OwnerComponent is Ts0ObjCtrlBridge then
      Ts0ObjCtrlBridge(Self.OwnerComponent).ProtoSource := Ts0PropertyProtoTypes(Source);
  end;
  inherited Assign(Source);
end;

constructor Ts0ProtoTypeCtrls.Create(AOwner: TPersistent;
  AItemClass: Ts0CollectionItemClass);
begin
  inherited;
  CloneAssign := False;
end;

destructor Ts0ProtoTypeCtrls.Destroy;
begin
  inherited Destroy;
end;

function Ts0ProtoTypeCtrls.FindPropCtrls(
  const APropName: string): Ts0ProtoTypeCtrl;
var
  p: Ts0PropertyProtoType;
begin
  Result := nil;
  p := FindByName(APropName);
  if p is Ts0ProtoTypeCtrl then
    Result := Ts0ProtoTypeCtrl(p);
end;

function Ts0ProtoTypeCtrls.GetOriginal: Ts0PropertyProtoTypes;
begin
  Result := nil;
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Result := Ts0ObjCtrlBridge(OwnerComponent).ProtoSource;
end;

function Ts0ProtoTypeCtrls.GetPropCtrls(
  const Index: Integer): Ts0ProtoTypeCtrl;
begin
  Result := Ts0ProtoTypeCtrl(inherited Items[Index]);
end;

function Ts0ProtoTypeCtrls.IndexOfProp(APropName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count -1 do
  begin
    if SameText((inherited Items[i]).PropertyName, APropName) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure Ts0ProtoTypeCtrls.NotifyOriginalUpdate(
  AItem: Ts0PropertyProtoType);
var
  i: Integer;
  myItem: Ts0ProtoTypeCtrl;
begin
  inherited NotifyOriginalUpdate(AItem);
  if AItem <> nil then
  begin
    myItem := FindPropCtrls(AItem.PropertyName);
    if myItem <> nil then
      myItem.InitCtrl;
  end
  else
  begin
    for i := 0 to Self.Count -1 do
      Self.PropCtrls[i].InitCtrl;
  end;
end;

procedure Ts0ProtoTypeCtrls.SetOriginal(const Value: Ts0PropertyProtoTypes);
begin
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Ts0ObjCtrlBridge(OwnerComponent).ProtoSource := Value;
end;

procedure Ts0ProtoTypeCtrls.SetPropCtrls(const Index: Integer;
  const Value: Ts0ProtoTypeCtrl);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CtrlNamePrefix }

procedure Ts0CtrlNamePrefix.SetPartOfCtrlClassName(const Value: string);
begin
  FPartOfCtrlClassName := Value;
end;

procedure Ts0CtrlNamePrefix.SetPrefix(const Value: string);
begin
  FPrefix := Value;
end;

{ Ts0CtrlNamePrefixes }

function Ts0CtrlNamePrefixes.Add(APartOfCtrl,
  APrefix: string): Ts0CtrlNamePrefix;
begin
  Result := Ts0CtrlNamePrefix(inherited Add);
  Result.FPartOfCtrlClassName := APartOfCtrl;
  Result.FPrefix := APrefix;
end;

function Ts0CtrlNamePrefixes.GetPrefixes(
  const Index: Integer): Ts0CtrlNamePrefix;
begin
  Result := Ts0CtrlNamePrefix(inherited Items[Index]);
end;

procedure Ts0CtrlNamePrefixes.SetPrefixes(const Index: Integer;
  const Value: Ts0CtrlNamePrefix);
begin
  inherited Items[Index] := Value;
end;

{ Ts0ObjCtrlBuilder }

procedure Ts0ObjCtrlBuilder.Assign(Source: TPersistent);
begin
  inherited;
end;

constructor Ts0ObjCtrlBuilder.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FDefaultCtrlWidth := 300;
  FDefaultCtrlHeight := 24;
  FLabelBreath := 100;
  FCtrlMargin := 4;
  FCtrlPrefixes := Ts0CtrlNamePrefixes.Create(Self, Ts0CtrlNamePrefix);
  InitCtrlPrefixes;
  FCtrlOfType := NewCtrlOfType;
end;

function Ts0ObjCtrlBuilder.CreateCtrlOf(AProp: Ts0ProtoTypeCtrl): TControl;
  function FincCtrlClass(AClassName: string): TControlClass;
  var
    cls: TClass;
  begin
    Result := nil;
    cls := GetClass(AClassName);
    if cls = nil then Exit;
    if not cls.InheritsFrom(TControl) then Exit;
    Result := TControlClass(cls);
  end;
var
  ctrlClass: TControlClass;
begin
  Result := nil;
  ctrlClass := FincCtrlClass( AProp.CtrlClassName );
  DoFindCtrlClass(AProp, ctrlClass);
  if ctrlClass = nil then Exit;
  Result := CreateCtrlImpl(ctrlClass, AProp);
end;

function Ts0ObjCtrlBuilder.CreateCtrlImpl(ACtrlClass: TControlClass;
  AProp: Ts0ProtoTypeCtrl): TControl;
var
  lOwner: TComponent;
begin
  lOwner := CtrlOwner;
  if lOwner = nil then
    lOwner := Self.OwnerComponent;
  Result := ACtrlClass.Create(lOwner);
  Result.Name :=
    Ts0ComponentHelper.GetNewComponentNameOf(
      Result,
      GetPrefixByClassName(ACtrlClass.ClassName) + AProp.PropertyName
    );
  Result.Parent := AProp.CtrlParent;
end;

destructor Ts0ObjCtrlBuilder.Destroy;
begin
  FreeAndNil(FCtrlOfType);
  FreeAndNil(FCtrlPrefixes);
  inherited Destroy;
end;

procedure Ts0ObjCtrlBuilder.DoAfterBuild;
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FAfterBuild) then
    ownerB.FAfterBuild(ownerB);
end;

procedure Ts0ObjCtrlBuilder.DoBeforeBuild;
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FBeforeBuild) then
    ownerB.FBeforeBuild(ownerB);
end;

procedure Ts0ObjCtrlBuilder.DoCreateCtrl(AProp: Ts0ProtoTypeCtrl;
  AControl: TControl);
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FOnCreateCtrl) then
    ownerB.FOnCreateCtrl(ownerB, AProp, AControl);
end;

procedure Ts0ObjCtrlBuilder.DoFindCtrlClass(AProp: Ts0ProtoTypeCtrl;
  var ACtrlClass: TControlClass);
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FOnFindCtrlClass) then
    ownerB.FOnFindCtrlClass(ownerB, AProp, ACtrlClass);
end;

procedure Ts0ObjCtrlBuilder.DoInitCtrl(AProp: Ts0ProtoTypeCtrl;
  AControl: TControl);
var
  ownerB: Ts0ObjCtrlBridge;
begin
  ownerB := GetOwnerBridge;
  if Assigned(ownerB.FOnInitCtrl) then
    ownerB.FOnInitCtrl(ownerB, AProp, AControl);
end;

procedure Ts0ObjCtrlBuilder.Execute;
  function CreateLabel(AProto: Ts0ProtoTypeCtrl; ACtrl: TControl): TCustomLabel;
    procedure SetFocusControl(ALabel: TCustomLabel);
    const
      c9FocusCtrl = 'FocusControl';
    var
      acsr: Ts0RTTIPublishedAccessor;
    begin
      acsr := Ts0RTTIPublishedAccessor.Create(Result);
      try
        if not acsr.PropertyExists(c9FocusCtrl) then Exit;
        if not SameText(acsr.PropTypeName(c9FocusCtrl), 'TWinControl') then Exit;
        acsr.ObjectProp[c9FocusCtrl] := TWinControl(ACtrl);
      finally
        FreeAndNil(acsr);
      end;
    end;
    procedure SetInpCtrlTitleDisp(inpCtrl: Ts0InputStyle; ALabel: TCustomLabel);
    const
      c9TitleDisp = 'TitleDisplay';
    var
      acsr: Ts0RTTIPublishedAccessor;
    begin
      if inpCtrl = nil then Exit;
      if ALabel = nil then Exit;
      acsr := Ts0RTTIPublishedAccessor.Create(inpCtrl);
      try
        if not acsr.PropertyExists(c9TitleDisp) then Exit;
        if not ALabel.InheritsFrom(acsr.ObjectPropClass[c9TitleDisp]) then Exit;
        acsr.ObjectProp[c9TitleDisp] := ALabel;
      finally
        FreeAndNil(acsr);
      end;
    end;
    function GetLabelClass: TControlClass;
    var
      cls: TClass;
    begin
      Result := nil;
      cls := GetClass('Ts0Label');    /////// !!! �咍�� !!!  ///////
      if (cls <> nil) and cls.InheritsFrom(TControl) then
      begin
        Result := TControlClass(cls);
        Exit;
      end;
      cls := GetClass('TLabel');    /////// !!! �咍�� !!!  ///////
      if (cls <> nil) and cls.InheritsFrom(TControl) then
        Result := TControlClass(cls);
    end;
  var
    labelClass: TControlClass;
  begin
    Result := nil;
    if ACtrl = nil then Exit;
    //�`�F�b�N�{�b�N�X�Ȃ烉�x���͗v��Ȃ��B
    if ACtrl is TCustomCheckBox then Exit;
    labelClass := GetLabelClass;
    if labelClass = nil then Exit;
    Result := TCustomLabel(CreateCtrlImpl(labelClass, AProto));
    Result.Width := FLabelBreath;
{$IFDEF VER130}
      Ts0CtrlDistillBroker.SetTitle(AProto.JPName, Result);
{$ELSE}
      Result.Caption := AProto.JPName;
{$ENDIF}
    if not(ACtrl is TWinControl) then Exit;
    SetFocusControl(Result);
    if not Ts0CtrlDistillBroker.IsTarget(ACtrl) then Exit;
    SetInpCtrlTitleDisp(Ts0CtrlDistillBroker.GetInputControl(ACtrl), Result);
  end;
var
  proto: Ts0ProtoTypeCtrl;
  i: Integer;
  bufLinking: Boolean;
begin
  if CtrlOwner = nil then Exit;
  if CtrlParent = nil then Exit;
  if ProtoTypes = nil then Exit;
  DoBeforeBuild;
  ProtoTypes.BeginUpdate;
  try
    for i := 0 to ProtoTypes.Count -1 do
    begin
      proto := ProtoTypes.PropCtrls[i];
      if not proto.NeedCtrl then Continue;
      //
      if proto.CtrlParent = nil then
        proto.CtrlParent := Self.CtrlParent;
      //
      bufLinking := proto.CtrlBounds.Linking;
      proto.CtrlBounds.Linking := False;
      try
        proto.Ctrl := CreateCtrlOf(proto);
        proto.CtrlLabel := CreateLabel(proto, proto.Ctrl);
      finally
        proto.CtrlBounds.Linking := bufLinking;
      end;
      //
      DoCreateCtrl(proto, proto.Ctrl);
      proto.InitCtrl;
      DoInitCtrl(proto, proto.Ctrl);
    end;
  finally
    ProtoTypes.EndUpdate;
  end;
  DoAfterBuild;
end;

function Ts0ObjCtrlBuilder.GetCtrlOfType: Ts0CtrlOfType;
begin
  Result := FCtrlOfType;
end;

function Ts0ObjCtrlBuilder.GetCtrlOfTypeClassName: string;
begin
  if FCtrlOfType <> nil then
    Result := FCtrlOfType.ClassName
  else
    Result := '';
end;

function Ts0ObjCtrlBuilder.GetOwnerBridge: Ts0ObjCtrlBridge;
begin
  Result := nil;
  if not(OwnerComponent is Ts0ObjCtrlBridge) then Exit;
  Result := Ts0ObjCtrlBridge(OwnerComponent);
end;

function Ts0ObjCtrlBuilder.GetPrefixByClassName(
  AClassName: string): string;
var
  i: Integer;
  n: String;
begin
  Result := '';
  for i := 0 to FCtrlPrefixes.Count -1 do
  begin
    n := CtrlPrefixes[i].PartOfCtrlClassName;
    if Pos(n, AClassName) > 0 then
    begin
      Result := CtrlPrefixes[i].Prefix;
      Exit;
    end;
  end;
end;

function Ts0ObjCtrlBuilder.GetProtoTypes: Ts0ProtoTypeCtrls;
begin
  Result := nil;
  if GetOwnerBridge = nil then Exit;
  Result := GetOwnerBridge.ProtoTypes;
end;

function Ts0ObjCtrlBuilder.GetWrapper: Ts0RTTIPublishedAccessor;
begin
  Result := nil;
  if GetOwnerBridge = nil then Exit;
  Result := GetOwnerBridge.Wrapper;
end;

procedure Ts0ObjCtrlBuilder.InitCtrlPrefixes;
begin
  FCtrlPrefixes.Add('CheckBox'    , 'chk' );
  FCtrlPrefixes.Add('DigitEdit'   , 'dged');
  FCtrlPrefixes.Add('DateEdit'    , 'dted');
  FCtrlPrefixes.Add('Edit'        , 'edt' );
  FCtrlPrefixes.Add('Memo'        , 'mmo' );
  FCtrlPrefixes.Add('ComboBox'    , 'cmb' );
  FCtrlPrefixes.Add('RadioGroup'  , 'rgp' );
  FCtrlPrefixes.Add('CheckListBox', 'clb' );
  FCtrlPrefixes.Add('Label'       , 'lbl' );
  FCtrlPrefixes.Add('Button'      , 'btn' );
  FCtrlPrefixes.Add('ListBox'     , 'lst' );
  FCtrlPrefixes.Add('Grid'        , 'grd' );
end;

function Ts0ObjCtrlBuilder.NewCtrlOfType: Ts0CtrlOfType;
begin
  Result := Ts0CtrlOfType.GetDefaultClass.Create(Self);
end;

procedure Ts0ObjCtrlBuilder.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation <> opRemove then Exit;
  if FCtrlParent = AComponent then
    FCtrlParent := nil;
end;

procedure Ts0ObjCtrlBuilder.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if FActive then
    Execute;
end;

procedure Ts0ObjCtrlBuilder.SetCtrlOfType(const Value: Ts0CtrlOfType);
begin
  FCtrlOfType.Assign(Value);
end;

procedure Ts0ObjCtrlBuilder.SetCtrlOfTypeClassName(const Value: string);
var
  cls: TPersistentClass;
begin
  if SameText(CtrlOfTypeClassName, Value) then Exit;
  cls := GetClass(Value);
  if cls = nil then Exit;
  if not cls.InheritsFrom(Ts0CtrlOfType) then Exit;
  FreeAndNil(FCtrlOfType);
  FCtrlOfType := Ts0CtrlOfTypeClass(cls).Create(Self);
end;

procedure Ts0ObjCtrlBuilder.SetCtrlOwner(const Value: TComponent);
begin
  FCtrlOwner := Value;
end;

procedure Ts0ObjCtrlBuilder.SetCtrlParent(const Value: TWinControl);
begin
  FCtrlParent := Value;
  if FCtrlParent = nil then Exit;
  if not(csAcceptsControls in FCtrlParent.ControlStyle) then
    FCtrlParent := nil;
end;

procedure Ts0ObjCtrlBuilder.SetCtrlPrefixes(const Value: Ts0CtrlNamePrefixes);
begin
  FCtrlPrefixes.Assign(Value)
end;

procedure Ts0ObjCtrlBuilder.SetLabelBreath(const Value: Integer);
begin
  FLabelBreath := Value;
  GetOwnerBridge.StandInCtrls;
end;

type
  Ts9ControlDefaults = class(TComponentList)
  private
    FDefaultWidth: Integer;
    FDefaultHeight: Integer;
    FLabelBreath: Integer;
    function FindCtrlByClassName(AClassName: string): TControl;
    function RegisterCtrl(AClassName: string): TControl;
  public
    procedure SetDefaultSize(AProto: Ts0ProtoTypeCtrl);
    property DefaultWidth: Integer read FDefaultWidth write FDefaultWidth;
    property DefaultHeight: Integer read FDefaultHeight write FDefaultHeight;
    property LabelBreath: Integer read FLabelBreath write FLabelBreath;
  end;

{ Ts9ControlDefaults }

function Ts9ControlDefaults.FindCtrlByClassName(
  AClassName: string): TControl;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := TControl(Self.Items[i]);
    if SameText(Result.ClassName, AClassName) then Exit;
  end;
  Result := nil;
end;

function Ts9ControlDefaults.RegisterCtrl(AClassName: string): TControl;
var
  cls: TPersistentClass;
begin
  Result := nil;
  cls := GetClass(AClassName);
  if cls = nil then Exit;
  if not cls.InheritsFrom(TControl) then Exit;
  Result := TControlClass(cls).Create(nil);
end;

procedure Ts9ControlDefaults.SetDefaultSize(AProto: Ts0ProtoTypeCtrl);
  procedure IncLabelBreath(var w, h: Integer);
  begin
    Inc(w, LabelBreath);
  end;
var
  ctrl: TControl;
  w, h: Integer;
begin
  ctrl := FindCtrlByClassName(AProto.CtrlClassName);
  if ctrl = nil then
    ctrl := RegisterCtrl(AProto.CtrlClassName);
  if ctrl = nil then
  begin
    w := DefaultWidth;
    h := DefaultHeight;
  end
  else
  begin
    w := ctrl.Width;
    h := ctrl.Height;
  end;
  IncLabelBreath(w, h);
  AProto.CtrlBounds.SetBounds(0, 0, w, h);
end;

{ Ts0ObjCtrlBridge }

procedure Ts0ObjCtrlBridge.ApplyCtrlClassNames;
var
  i: Integer;
  p: Ts0ProtoTypeCtrl;
  dummyCtrls: Ts9ControlDefaults;
begin
  dummyCtrls := Ts9ControlDefaults.Create(True);
  try
    dummyCtrls.DefaultWidth  := Builder.DefaultCtrlWidth ;
    dummyCtrls.DefaultHeight := Builder.DefaultCtrlHeight;
    dummyCtrls.LabelBreath := Builder.LabelBreath;
    for i := 0 to ProtoTypes.Count -1 do
    begin
      p := FProtoTypes.PropCtrls[i];
      p.ValidateCtrlClassName;
      dummyCtrls.SetDefaultSize( p );
    end;
  finally
    FreeAndNil(dummyCtrls);
  end;
end;

procedure Ts0ObjCtrlBridge.BeginUpdate;
var
  i: Integer;
begin
  for i := 0 to ProtoTypes.Count -1 do
    ProtoTypes.PropCtrls[i].SetUpdating(True);
end;

procedure Ts0ObjCtrlBridge.BuildCtrls;
begin
  Builder.Execute;
  LoadFromTarget;
end;

procedure Ts0ObjCtrlBridge.ClearCtrls;
var
  i: Integer;
begin
  for i := 0 to FProtoTypes.Count -1 do
    FProtoTypes.PropCtrls[i].FreeCtrl;
end;

constructor Ts0ObjCtrlBridge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProtoSourcePropName := 'ProtoTypes';
  FAutoUpdate := True;
  FBuilder := NewBuilder;
  FBuilder.CtrlOwner := AOwner;
  FProtoTypes := NewProtoTypes;
  FDisabledProps := TStringList.Create;
  FDisabledProps.Add('Name');
  FDisabledProps.Add('Tag');
end;

destructor Ts0ObjCtrlBridge.Destroy;
begin
  FreeAndNil(FDisabledProps);
  FreeAndNil(FProtoTypes);
  FreeAndNil(FWrapper);
  FreeAndNil(FBuilder);
  inherited Destroy;
end;

procedure Ts0ObjCtrlBridge.DoLoadObjFromCtrl(AObj: TObject;
  ACtrl: TControl);
begin
  if Assigned(FOnLoadObjFromCtrl) then
    FOnLoadObjFromCtrl(Self, AObj, ACtrl);
end;

procedure Ts0ObjCtrlBridge.DoSaveObjToCtrl(AObj: TObject;
  ACtrl: TControl);
begin
  if Assigned(FOnSaveObjToCtrl) then
    FOnSaveObjToCtrl(Self, AObj, ACtrl);
end;

procedure Ts0ObjCtrlBridge.DoStandInCtrls;
begin
  if Assigned(FOnStandInCtrls) then
    FOnStandInCtrls(Self);
end;

procedure Ts0ObjCtrlBridge.EndUpdate;
var
  i: Integer;
begin
  for i := 0 to ProtoTypes.Count -1 do
    ProtoTypes.PropCtrls[i].SetUpdating(False);
end;

function Ts0ObjCtrlBridge.GetCtrlClassNameByProp(AProto: Ts0ProtoTypeCtrl): String;
begin
  Result := Builder.CtrlOfType.GetCtrlClassNameByProto(AProto);
end;

function Ts0ObjCtrlBridge.GetProtoSource: Ts0PropertyProtoTypes;
var
  acsr: Ts0RTTIPublishedAccessor;
  cls: TClass;
begin
  Result := nil;
  if FProtoSourceCompo = nil then Exit;
  acsr := Ts0RTTIPublishedAccessor.Create(FProtoSourceCompo);
  try
    if acsr.RTTINavigator.Props.PropByName(FProtoSourcePropName) = nil then Exit;
    cls := acsr.ObjectPropClass[FProtoSourcePropName];
    if cls = nil then Exit;
    if not cls.InheritsFrom(Ts0PropertyProtoTypes) then Exit;
    Result := Ts0PropertyProtoTypes( acsr.ObjectProp[FProtoSourcePropName] );
  finally
    FreeAndNil(acsr);
  end;
end;

function Ts0ObjCtrlBridge.GetTargetComponent: TComponent;
begin
  Result := nil;
  if Target is TComponent then
    Result := TComponent(Target);
end;

procedure Ts0ObjCtrlBridge.InitProtoCtrl(AProto: Ts0ProtoTypeCtrl);
begin
  Builder.CtrlOfType.InitCtrlByProto(AProto, AProto.Ctrl);
end;

procedure Ts0ObjCtrlBridge.Loaded;
begin
  inherited;
  LoadFromTarget;
end;

procedure Ts0ObjCtrlBridge.LoadFromTarget;
var
  i: Integer;
  p: Ts0ProtoTypeCtrl;
begin
  BeginUpdate;
  try
    for i := 0 to FProtoTypes.Count -1 do
    begin
      p := FProtoTypes.PropCtrls[i];
      p.LoadFromTarget;
      {
        p.DoLoadFromTarget�̓C�x���g�̌Ăяo���B
        p.LoadFromTarget �ŌĂяo�������Ƃ��낾���ǁALoadFromTarget��override�����̂ŁA
        �C�x���g�̌Ăяo�����ʓ|�ɂȂ����Ⴄ�B
      }
      p.DoLoadFromTarget;
    end;
  finally
    EndUpdate;
  end;
end;

procedure Ts0ObjCtrlBridge.MakeDefualtProtoTypes;
  function IsDisabled(APropName: string): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    for i := 0 to FDisabledProps.Count -1 do
      if SameText(FDisabledProps.Strings[i], APropName) then
        Exit;
    Result := False;
  end;
  function LoadFromLayoutSet: Boolean;
  var
    layout: Ts0LayoutSetItem;
  begin
    Result := False;
    if FTarget = nil then Exit;
    if FLayoutSet = nil then Exit;
    layout := FLayoutSet.Items.ItemByName(FTarget.ClassName);
    if layout = nil then Exit;
    layout.Target := Self.ProtoTypes;
    layout.LayoutTargets;
    Result := True;
  end;
var
  i: Integer;
  props: Ts0RTTIProps;
  prop: Ts0RTTIProp;
  p: Ts0PropertyProtoType;
begin
  if FWrapper = nil then Exit;
  props := FWrapper.RTTINavigator.Props;
  for i := 0 to props.Count -1 do
  begin
    prop := props[i];
    if IsDisabled(prop.PropName) then Continue;
    p := FProtoTypes.AddProto(prop.PropName, prop.TypeInfo.TypeName, prop.PropName, 0);
    p.DataTypeKind := Ts0TypeKindHelper.GetWrappedTypeKind(p.TypeName, prop.TypeInfo.TypeKind);
    case p.DataTypeKind of
      wtk0Enumeration,
      wtk0Set:
        p.EnumMember.CommaText := prop.TypeInfo.GetNameList;
    end;
  end;
  ApplyCtrlClassNames;
  StandInCtrls;
  LoadFromLayoutSet;
end;

function Ts0ObjCtrlBridge.NewBuilder: Ts0ObjCtrlBuilder;
begin
  Result := Ts0ObjCtrlBuilder.Create(Self);
end;

function Ts0ObjCtrlBridge.NewProtoTypes: Ts0ProtoTypeCtrls;
begin
  Result := Ts0ProtoTypeCtrls.Create(Self, Ts0ProtoTypeCtrl);
end;

procedure Ts0ObjCtrlBridge.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FProtoTypes <> nil then
    FProtoTypes.Notification(AComponent, Operation);
  if Builder <> nil then
    Builder.Notification(AComponent, Operation);
  if Operation <> opRemove then Exit;
  if FLayoutSet = AComponent then
    FLayoutSet := nil;
end;

procedure Ts0ObjCtrlBridge.SaveToTarget;
var
  i: Integer;
  p: Ts0ProtoTypeCtrl;
begin
  for i := 0 to FProtoTypes.Count -1 do
  begin
    p := FProtoTypes.PropCtrls[i];
    p.SaveToTarget;
    {
      p.DoSaveToTarget�̓C�x���g�̌Ăяo���B
      p.SaveToTarget �ŌĂяo�������Ƃ��낾���ǁASaveToTarget��override�����̂ŁA
      �C�x���g�̌Ăяo�����ʓ|�ɂȂ����Ⴄ�B
    }
    p.DoSaveToTarget;
  end;
end;

procedure Ts0ObjCtrlBridge.SetAutoUpdate(const Value: Boolean);
var
  i: Integer;
begin
  FAutoUpdate := Value;
  if [csLoading, csReading, csDesigning] * Self.ComponentState <> [] then Exit;
  for i := 0 to ProtoTypes.Count -1 do
    if FAutoUpdate then
      ProtoTypes.PropCtrls[i].SnatchEvents
    else
      ProtoTypes.PropCtrls[i].PutBackEvents;
end;

procedure Ts0ObjCtrlBridge.SetBuilder(const Value: Ts0ObjCtrlBuilder);
begin
  FBuilder.Assign(Value);
end;

procedure Ts0ObjCtrlBridge.SetDisabledProps(const Value: TStrings);
begin
  FDisabledProps.Assign(Value);
end;

procedure Ts0ObjCtrlBridge.SetLayoutSet(const Value: Ts0LayoutSet);
begin
  FLayoutSet := Value;
end;

procedure Ts0ObjCtrlBridge.SetProtoSource(
  const Value: Ts0PropertyProtoTypes);
begin
  if Value = nil then
  begin
    FProtoSourceCompo := nil;
    FProtoSourcePropName := '';
  end
  else
  begin
    FProtoSourceCompo := Value.OwnerComponent;
    FProtoSourcePropName := Value.PropName;
  end;
end;

procedure Ts0ObjCtrlBridge.SetProtoTypes(const Value: Ts0ProtoTypeCtrls);
begin
  FProtoTypes.Assign(Value);
end;

procedure Ts0ObjCtrlBridge.SetTarget(const Value: TObject);
begin
  FreeAndNil(FWrapper);
  FTarget := Value;
  if FTarget = nil then Exit;
  FWrapper := Ts0RTTIPublishedAccessor.Create(FTarget);
  if ProtoTypes.Count < 1 then
    MakeDefualtProtoTypes;
end;

procedure Ts0ObjCtrlBridge.SetTargetComponent(const Value: TComponent);
begin
  Target := Value;
end;

procedure Ts0ObjCtrlBridge.StandInCtrls;
  procedure GetCtrlParents(Dest: TObjectList);
  var
    i: Integer;
    p: Ts0ProtoTypeCtrl;
    prnt: TWinControl;
  begin
    Dest.Clear;
    Dest.OwnsObjects := False;
    for i := 0 to ProtoTypes.Count -1 do
    begin
      p := ProtoTypes.PropCtrls[i];
      prnt := p.CtrlParent;
      if Dest.IndexOf(prnt) > -1 then Continue;
      Dest.Add(prnt); //Dest�ɂ�nil������\��������B
    end;
  end;
  procedure SortCtrlPosition(AParent: TObject);
  var
    proto: Ts0ProtoTypeCtrl;
    i: Integer;
    y: Integer;
    lastCtrl: Ts0PTCBounds;
  begin
    lastCtrl := nil;
    y := Builder.CtrlMargin;
    for i := 0 to ProtoTypes.Count -1 do
    begin
      if not(ProtoTypes.Items[i] is Ts0ProtoTypeCtrl) then Continue;
      proto := Ts0ProtoTypeCtrl(ProtoTypes.Items[i]);
      if proto.CtrlParent <> AParent then Continue;
      if proto.WithoutCtrl then Continue;
      if lastCtrl <> nil then
        y := lastCtrl.Top + lastCtrl.Height + Builder.CtrlMargin;
      proto.CtrlBounds.Top := y;
      proto.CtrlBounds.Left := Builder.CtrlMargin;
      if (proto.Ctrl <> nil) or (proto.CtrlClassName <> '') then
        lastCtrl := proto.CtrlBounds;
    end;
  end;
var
  parentList: TObjectList;
  i: Integer;
begin
  parentList := TObjectList.Create(False);
  try
    GetCtrlParents(parentList);
    for i := 0 to parentList.Count -1 do
      SortCtrlPosition( parentList.Items[i] );
  finally
    FreeAndNil(parentList);
  end;
  DoStandInCtrls;
end;

end.
