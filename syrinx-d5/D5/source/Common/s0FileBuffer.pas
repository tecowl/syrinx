unit s0FileBuffer;
{
$History: s0FileBuffer.pas $
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
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0core
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes,
  s0FileStream;

type
  Ts0FileBuffer = class(TMemoryStream)
  private
    FFileName: string;
    FReal: TFileStream;
    FOpenMode: K0FileOpenMode;
    FShareMode: K0FileShareMode;
  protected
    procedure ValidateFileAccess;
  public
    constructor Create(AFileName: string; AOpenMode: K0FileOpenMode;
      AShareMode: K0FileShareMode); reintroduce; overload;
    destructor Destroy; override;
    property FileName: string read FFileName write FFileName;
    property OpenMode: K0FileOpenMode read FOpenMode write FOpenMode;
    property ShareMode: K0FileShareMode read FShareMode write FShareMode;
    procedure AppendToFile(AClearOnSave: Boolean = True);
    procedure LoadFromFile;
    procedure SaveToFile;
  end;

type
  Es0FileBufferException = class(Exception);

implementation

type
  T9FileStream = class(TFileStream)
  end;

  { Ts0FileBuffer }

procedure Ts0FileBuffer.AppendToFile(AClearOnSave: Boolean);
var
  fs: TFileStream;
begin
  ValidateFileAccess;
  if FileExists(FFileName) then
  begin
    fs := TFileStream.Create(FFileName, GetFileMode(k0fomOpenReadWrite, FShareMode));
    fs.Seek(0, soFromEnd);
  end
  else
  begin
    fs := TFileStream.Create(FFileName, GetFileMode(k0fomCreate, FShareMode));
    fs.Seek(0, soFromBeginning);
  end;
  try
    fs.CopyFrom(Self, 0);
    if AClearOnSave then
      Self.Clear;
  finally
    FreeAndNil(fs);
  end;
end;

constructor Ts0FileBuffer.Create(AFileName: string; AOpenMode: K0FileOpenMode;
  AShareMode: K0FileShareMode);
begin
  inherited Create;
  FFileName := AFileName;
  FOpenMode := AOpenMode;
  FShareMode := FShareMode;
end;

destructor Ts0FileBuffer.Destroy;
begin
  FreeAndNil(FReal);
  inherited;
end;

procedure Ts0FileBuffer.LoadFromFile;
var
  fs: TFileStream;
begin
  ValidateFileAccess;
  if not (FOpenMode in [k0fomOpenRead, k0fomOpenReadWrite]) then
    Exit;
  Self.Clear;
  fs := TFileStream.Create(FFileName, GetFileMode(FOpenMode, FShareMode));
  try
    fs.Seek(0, soFromBeginning);
    Self.CopyFrom(fs, 0);
    Seek(0, soFromBeginning);
  finally
    FreeAndNil(fs);
  end;
end;

procedure Ts0FileBuffer.SaveToFile;
var
  fs: TFileStream;
  bufPosition: Integer;
begin
  ValidateFileAccess;
  if not (FOpenMode in [k0fomCreate, k0fomOpenWrite, k0fomOpenReadWrite]) then
    Exit;
  fs := TFileStream.Create(FFileName, GetFileMode(FOpenMode, FShareMode));
  try
    bufPosition := Self.Position;
    fs.CopyFrom(Self, 0);
    Self.Position := bufPosition;
  finally
    FreeAndNil(fs);
  end;
end;

resourcestring
  c9ErrMsg_IllegalFileName = '不正なファイル名です。: "%s"';

procedure Ts0FileBuffer.ValidateFileAccess;
begin
  if FFileName = '' then
    Es0FileBufferException.CreateFmt(c9ErrMsg_IllegalFileName, [FFileName]);
end;

end.

