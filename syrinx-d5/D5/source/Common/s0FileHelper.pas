unit s0FileHelper;

interface

uses
  SysUtils, Classes;

type
  K0FileAttr = (
    k0faReadOnly ,
    k0faHidden   ,
    k0faSysFile  ,
    k0faVolumeID ,
    k0faDirectory,
    k0faArchive
  );
  K0FileAttrSet = set of K0FileAttr;

{$IFDEF LINUX}
const
  c0FileAttr: array[K0FileAttr] of Integer = (
    //$00000001, //faReadOnly
    //$00000002, //faHidden
    //$00000004, //faSysFile
    //$00000008, //faVolumeID
    $00000010  //faDirectory
    //$00000020  //faArchive
  );
{$ELSE}
const
  c0FileAttr: array[K0FileAttr] of Integer = (
    $00000001, //faReadOnly ,
    $00000002, //faHidden   ,
    $00000004, //faSysFile  ,
    $00000008, //faVolumeID ,
    $00000010, //faDirectory,
    $00000020  //faArchive
  );
{$ENDIF}

type
  Ts0FileHelper = class
  public
    class function CompareFileContext(AFile1, AFile2: TFileName): Boolean;
    class procedure CopyFile(Source, Dest: TFileName);
    class function GetFileDate(AFileName: TFileName): TDateTime;
    class procedure SetFileDate(AFileName: TFileName; Value: TDateTime);
{$IFNDEF LINUX}
    class function Win32AttrToAttr(AWin32Attr: Integer): K0FileAttrSet;
    class function AttrToWin32Attr(Attr: K0FileAttrSet) : Integer;
{$ENDIF}
  end;

implementation

{$IFDEF VER130}
uses
  FileCtrl;
{$ENDIF}

{ Ts0FileHelper }

{$IFNDEF LINUX}
class function Ts0FileHelper.AttrToWin32Attr(Attr: K0FileAttrSet): Integer;
var
  i: K0FileAttr;
begin
  Result := 0;
  for i := Low(K0FileAttr) to High(K0FileAttr) do
    if i in Attr then
      Result := Result or c0FileAttr[i];
end;
{$ENDIF}

class function Ts0FileHelper.CompareFileContext(AFile1,
  AFile2: TFileName): Boolean;
var
  f1, f2: TFileStream;
  c1, c2: Char;
begin
  Result := False;
  if not FileExists(AFile1) then Exit;
  if not FileExists(AFile2) then Exit;
  f1 := TFileStream.Create(AFile1, fmOpenRead or fmShareDenyNone);
  f2 := TFileStream.Create(AFile2, fmOpenRead or fmShareDenyNone);
  try
    if f1.Size <> f2.Size then Exit;
    f1.Seek(0, soFromBeginning);
    f2.Seek(0, soFromBeginning);
    while f1.Position < f1.Size do
    begin
      f1.Read(c1, 1);
      f2.Read(c2, 1);
      if c1 <> c2 then Exit;
    end;
    Result := True;
  finally
    FreeAndNil(f1);
    FreeAndNil(f2);
  end;   
end;

class procedure Ts0FileHelper.CopyFile(Source, Dest: TFileName);
var
  src, dst: TFileStream;
  newDir: string;
begin
  newDir := ExtractFileDir(Dest);
  if not DirectoryExists(newDir) then
    ForceDirectories(newDir);
  //
  src := TFileStream.Create(Source, fmOpenRead or fmShareDenyWrite);
  try
    dst := TFileStream.Create(Dest, fmCreate or fmShareDenyWrite);
    try
      dst.CopyFrom(src, 0);
    finally
      FreeAndNil(dst);
    end;
  finally
    FreeAndNil(src);
  end;
end;

class function Ts0FileHelper.GetFileDate(AFileName: TFileName): TDateTime;
var
  fh: Integer;
begin
  Result := 0;
  fh := FileOpen(AFileName, fmOpenRead or fmShareDenyNone);
  if fh < 0 then Exit;
  try
    Result := FileDateToDateTime(FileGetDate(fh));
  finally
    FileClose(fh);
  end;
end;

class procedure Ts0FileHelper.SetFileDate(AFileName: TFileName;
  Value: TDateTime);
var
  fh: Integer;
begin
  fh := FileOpen(AFileName, fmOpenWrite or fmShareDenyNone);
  if fh < 0 then Exit;
  try
    FileSetDate(fh, DateTimeToFileDate(Value));
  finally
    FileClose(fh);
  end;
end;

{$IFNDEF LINUX}
class function Ts0FileHelper.Win32AttrToAttr(
  AWin32Attr: Integer): K0FileAttrSet;
var
  i: K0FileAttr;
begin
  Result := [];
  for i := Low(K0FileAttr) to High(K0FileAttr) do
    if AWin32Attr and c0FileAttr[i] <> 0 then
      Include(Result, i);
end;
{$ENDIF}

end.


