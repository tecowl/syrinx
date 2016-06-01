{-----------------------------------------------------------------------------
 Unit Name: s0FileStream
 Author:    akima
 Purpose:
 History:
-----------------------------------------------------------------------------}
{
$History: s0FileStream.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/15   Time: 15:46
 * Created in $/source/D5Integrated
}

unit s0FileStream;

interface

uses
  SysUtils, Classes;

type
  K0FileOpenMode = (
    k0fomCreate, //�w�肵�����O�Ńt�@�C�����쐬����B�w�肵�����O�̃t�@�C�������łɑ��݂���ꍇ�́CfmOpenWrite �Ɠ���������s��
    k0fomOpenRead, //�ǂݏo���p�Ƀt�@�C�����J��
    k0fomOpenWrite, //�������ݗp�Ƀt�@�C�����J���B�����̃t�@�C�����J�����ꍇ�C�Â����e�͔j�������
    k0fomOpenReadWrite //�t�@�C�����J���C���e�ɕύX��������B�Â����e�͈ێ������
    );

type
  K0FileShareMode = (
    k0fsmExclusive, //���̃A�v���P�[�V�����̓t�@�C�����J�����Ƃ��ł��Ȃ�
    k0fsmDenyWrite, //���̃A�v���P�[�V�����͓ǂݏo���p�Ƀt�@�C�����J�����Ƃ͂ł��邪�C�������ݗp�ɊJ�����Ƃ͂ł��Ȃ�
    k0fsmDenyNone //���̃A�v���P�[�V��������̃t�@�C���̓ǂݏo������я������݂�W���鏈���͍s���Ȃ�
    );
    
type
  Ts0WriteFileStream = class(TFileStream)
  private
    FOpenMode: K0FileOpenMode;
    FShareMode: K0FileShareMode;
    FFileName: string;
  protected
    procedure ValidateFileName(AFileName: string);
  public
    constructor Create(const AFileName: string; AShareMode: K0FileShareMode);
    property FileName: string read FFileName write FFileName;
    property OpenMode: K0FileOpenMode read FOpenMode;
    property ShareMode: K0FileShareMode read FShareMode write FShareMode;
  end;

type
  Ts0WriteBuffer = class(TMemoryStream)
  private
  protected
    FDest: TStream;
  public
    constructor Create(ADest: TStream);
    function WriteToDest: Integer; virtual;
    property Dest: TStream read FDest;
  end;

type
  Ts0WriteFileBuffer = class(Ts0WriteBuffer)
  private
    FShareMode: K0FileShareMode;
    FFileName: string;
    function GetOpened: Boolean;
  public
    constructor Create(const AFileName: string; AShareMode: K0FileShareMode; AKeepOpen: Boolean = False);
    destructor Destroy; override;
    procedure Open;
    procedure Close;
    function WriteToDest: Integer; override;
    property Opened: Boolean read GetOpened;
    property FileName: string read FFileName write FFileName;
    property ShareMode: K0FileShareMode read FShareMode write FShareMode;
  end;


type
  Es0FileStreamException = class(Exception);
  Es0WriteBufferException = class(Exception);
  Es0WriteFileBufferException = class(Exception);

function GetFileMode(AOpen: K0FileOpenMode; AShare: K0FileShareMode): Word;

implementation

function GetFileMode(AOpen: K0FileOpenMode; AShare: K0FileShareMode): Word;
const
  c9OpenModes: array[K0FileOpenMode] of Word = (
    fmCreate, fmOpenRead, fmOpenWrite, fmOpenReadWrite
    );
const
  c9ShareModes: array[K0FileShareMode] of Word = (
    fmShareExclusive, fmShareDenyWrite, fmShareDenyNone
    );
begin
  Result := c9OpenModes[AOpen] or c9ShareModes[AShare];
end;

{ Ts0WriteFileStream }

constructor Ts0WriteFileStream.Create(const AFileName: string;
  AShareMode: K0FileShareMode);
begin
  ValidateFileName(AFileName);
  FileName := AFileName;
  FShareMode := AShareMode;
  if FileExists(FFileName) then
    FOpenMode := k0fomOpenReadWrite
  else
    FOpenMode := k0fomCreate;
  inherited Create(FFileName, GetFileMode(FOpenMode, FShareMode));
  if FOpenMode = k0fomOpenReadWrite then
    Seek(0, soFromEnd);
end;

resourcestring
  c9ErrMsg_IllegalFileName = '�s���ȃt�@�C����';

procedure Ts0WriteFileStream.ValidateFileName(AFileName: string);
begin
  if AFileName = '' then
    raise Es0FileStreamException.Create(c9ErrMsg_IllegalFileName);
end;

{ Ts0WriteBuffer }

constructor Ts0WriteBuffer.Create(ADest: TStream);
begin
  inherited Create;
  FDest := ADest;
end;

resourcestring
  c9ErrMsg_IllegalDestination = '�������ݐ�̃X�g���[�����w�肳��Ă��܂���';

function Ts0WriteBuffer.WriteToDest: Integer;
begin
  if FDest = nil then
    raise Es0WriteBufferException(c9ErrMsg_IllegalDestination);
  Result := FDest.CopyFrom(Self, 0);
  Self.Clear;
end;

{ Ts0WriteFileBuffer }

procedure Ts0WriteFileBuffer.Close;
begin
  if FDest = nil then Exit;
  FreeAndNil(FDest);
end;

constructor Ts0WriteFileBuffer.Create(const AFileName: string;
  AShareMode: K0FileShareMode; AKeepOpen: Boolean);
begin
  inherited Create(nil);
  FFileName := AFileName;
  FShareMode := AShareMode;
  if AKeepOpen then
    Open;
end;

destructor Ts0WriteFileBuffer.Destroy;
begin
  Close;
  inherited;
end;

function Ts0WriteFileBuffer.GetOpened: Boolean;
begin
  Result := FDest <> nil;
end;

procedure Ts0WriteFileBuffer.Open;
begin
  if FDest <> nil then Exit;
  FDest := Ts0WriteFileStream.Create(FFileName, FShareMode);
end;

resourcestring
  c9ErrMsg_CannotWriteWithoutOpen = 'Open����Ă��Ȃ����߁A�t�@�C���ɏ������ނ��Ƃ͂ł��܂���B';

function Ts0WriteFileBuffer.WriteToDest: Integer;
begin
  if not Opened then
    raise Es0FileStreamException.Create(c9ErrMsg_CannotWriteWithoutOpen);
  Result := inherited WriteToDest;
end;

end.
