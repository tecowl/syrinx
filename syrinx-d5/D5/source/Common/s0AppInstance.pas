unit s0AppInstance;
{
$History: s0AppInstance.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/01   Time: 0:09
 * Updated in $/source/D5/p0additional
 * �݌v���ɂ̓R���X�g���N�^�ő��̃C���X�^���X�����݂��Ă��邩�ǂ������`�F
 * �b�N���Ȃ��悤�ɏC��
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/07   Time: 10:34
 * Updated in $/source/p0common
 * �R�����g��ǉ�
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/12   Time: 18:59
 * Updated in $/source/p0common
 * �o�^����R���|�[�l���g�p���b�g��Techno�̂܂܂������B
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:27
 * Created in $/Projects/SDRFrameWork/src/lib0
 * �V�K�ǉ�
 * \Usr\takima\Lecture\StaffDailyReport\Source����ړ����܂����B
 * VSS�ł͋��L���Ă܂���B
}

interface

uses
  Windows, SysUtils, Classes;

type
  K0AppInstNeedNameEvent = procedure(Sender: TObject; var AName: string) of
    object;

type
  {
    Ts0AppInstance
    �A�v���P�[�V�����̓�d�N����h�����߂̃R���|�[�l���g�B
    ���̃R���|�[�l���g�͒u�������ŏ���ɓ����܂��B

    ��G�c�ȓ����������ƁA�R���|�[�l���g�����s���Ƀ��[�h���ꂽ�Ƃ��A
    Loaded���\�b�h���Ăяo����A�����ŃA�v���P�[�V�����ŗL�̖��O���g����
    �~���[�e�b�N�X���������āA���݂��Ă���i���̃A�v�����N�����Ă���j
    protected��FailToStartApp���\�b�h�����s�����B

    FailToStartApp���\�b�h�ł́AAutoTerminate�v���p�e�B��True�Ȃ�
    Application.Terminate�����s���ăA�v�����I�������AAutoTerminate�v���p�e�B��
    False�Ȃ�Es0AppInstException��O�𔭐�������B

    �A�v���P�[�V�����ŗL�̖��O�́AAppInstName�v���p�e�B�Ŏw�肵�Ă������Ƃ�
    �ł��邪�AOnMakeAppInstName�C�x���g���n���h�����O���Ă��̃n���h����
    ����AName�ɑ�����邱�Ƃœ��I�Ɏw�肷�邱�Ƃ��\�B

    �܂�Enabled�v���p�e�B��False�Ȃ�΁A���̃R���|�[�l���g�͑S���@�\���Ȃ��B
  }
  Ts0AppInstance = class(TComponent)
  private
    FAppInstName: string;
    FOnMakeAppInstName: K0AppInstNeedNameEvent;
    FAutoTerminate: Boolean;
    FEnabled: Boolean;
    procedure SetAppInstName(const Value: string);
    procedure SetEnabled(const Value: Boolean);
  protected
    procedure InitializeApp;
    procedure Loaded; override;
    function DoOnMakeAppInstName: string;
    function CanStartApp: Boolean;
    procedure FailToStartApp;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {
      GetInstance
      �N���ł����ꍇ�A���̃R���|�[�l���g�̃C���X�^���X�̓A�v���P�[�V������
      ������Ȃ��̂ŁA����ɃA�N�Z�X���邽�߂̃��\�b�h�B
    }
    class function GetInstance: Ts0AppInstance;
  published
    {
      AutoTerminate
      2�d�N�����Ă���ꍇ�ɁA�����I�ɏI�����邩�ۂ��B
    }
    property AutoTerminate: Boolean read FAutoTerminate write FAutoTerminate
      default True;
    {
      AppInstName
      OnMakeAppInstName
      �A�v���P�[�V�����Ƃ��Ă̌ŗL�̖��O�B
      OnMakeAppInstName�C�x���g�Ŏg�p�����O�ɕύX���邱�Ƃ��ł���B
    }
    property AppInstName: string read FAppInstName write SetAppInstName;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property OnMakeAppInstName: K0AppInstNeedNameEvent read FOnMakeAppInstName
      write FOnMakeAppInstName;
  end;

type
  Es0AppInstException = class(Exception);

implementation

uses
  s0Application;

{ Ts0AppInstance }

var
  g9ApInstance: Ts0AppInstance = nil;
  g9AppMutex: THandle = 0;

function Ts0AppInstance.CanStartApp: Boolean;
var
  existance: THandle;
begin
  Result := False;
  existance := OpenMutex(MUTEX_ALL_ACCESS, False, PChar(FAppInstName));
  if existance <> 0 then
  begin
    CloseHandle(existance);
    Exit;
  end;
  Result := True;
end;

resourcestring
  c9ExcptMsg_DuplicateComponent =
    'Ts0AppInstance��2�ȏ㓯���Ɏg�p�ł��܂���';

constructor Ts0AppInstance.Create(AOwner: TComponent);
begin
  inherited;
  if not(csDesigning in Self.ComponentState) then 
    if g9ApInstance <> nil then
      raise Es0AppInstException.Create(c9ExcptMsg_DuplicateComponent);
  g9ApInstance := Self;
  FAutoTerminate := True;
  FEnabled := True;
  FAppInstName := 'AppIdentifier';
end;

destructor Ts0AppInstance.Destroy;
begin
  inherited;
  g9ApInstance := nil;
end;

function Ts0AppInstance.DoOnMakeAppInstName: string;
begin
  Result := FAppInstName;
  if Assigned(FOnMakeAppInstName) then
    FOnMakeAppInstName(Self, Result);
end;

resourcestring
  c9ExcptMsg_FailToStart = '�A�v���P�[�V�����̋N���Ɏ��s���܂���';

procedure Ts0AppInstance.FailToStartApp;
begin
  if FAutoTerminate then
  begin
    Ts0Application.Instance.Terminate
  end
  else
    raise Es0AppInstException.Create(c9ExcptMsg_FailToStart);
end;

class function Ts0AppInstance.GetInstance: Ts0AppInstance;
begin
  Result := g9ApInstance;
end;

procedure Ts0AppInstance.InitializeApp;
begin
  if not Enabled then
    Exit;
  FAppInstName := DoOnMakeAppInstName;
  //
  if CanStartApp then
    g9AppMutex := CreateMutex(nil, False, PChar(FAppInstName))
  else
    FailToStartApp;
end;

procedure Ts0AppInstance.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then
    Exit;
  InitializeApp;
end;

procedure Ts0AppInstance.SetAppInstName(const Value: string);
begin
  FAppInstName := Value;
end;

procedure Ts0AppInstance.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

initialization

finalization
  ReleaseMutex(g9AppMutex);

end.
