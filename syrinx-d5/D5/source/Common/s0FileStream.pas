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
 * 接頭辞を変更。xxSX～にした。
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
    k0fomCreate, //指定した名前でファイルを作成する。指定した名前のファイルがすでに存在する場合は，fmOpenWrite と同じ動作を行う
    k0fomOpenRead, //読み出し用にファイルを開く
    k0fomOpenWrite, //書き込み用にファイルを開く。既存のファイルを開いた場合，古い内容は破棄される
    k0fomOpenReadWrite //ファイルを開き，内容に変更を加える。古い内容は維持される
    );

type
  K0FileShareMode = (
    k0fsmExclusive, //他のアプリケーションはファイルを開くことができない
    k0fsmDenyWrite, //他のアプリケーションは読み出し用にファイルを開くことはできるが，書き込み用に開くことはできない
    k0fsmDenyNone //他のアプリケーションからのファイルの読み出しおよび書き込みを妨げる処理は行われない
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
  c9ErrMsg_IllegalFileName = '不正なファイル名';

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
  c9ErrMsg_IllegalDestination = '書き込み先のストリームが指定されていません';

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
  c9ErrMsg_CannotWriteWithoutOpen = 'Openされていないため、ファイルに書き込むことはできません。';

function Ts0WriteFileBuffer.WriteToDest: Integer;
begin
  if not Opened then
    raise Es0FileStreamException.Create(c9ErrMsg_CannotWriteWithoutOpen);
  Result := inherited WriteToDest;
end;

end.
