{-----------------------------------------------------------------------------
 Unit Name: s0FileFinder
 Author:    akima
 Purpose:
 TestCase: tc_s0FileFinder
$History: s0FileFinder.pas $
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/02/06   Time: 21:00
 * Updated in $/source/D5Integrated
 * VER130�ł́AFileCtrl���j�b�g��uses����悤�ɕύX
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/06   Time: 19:52
 * Updated in $/source/D6VCLIntegrated
 * uses�߂���FileCtrl���폜
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/06   Time: 19:26
 * Updated in $/source/D6VCLIntegrated
 * IncludeTrailingBackslash�AExcludeTrailingBackslash���g�p���Ă���������
 * �A
 * s0FileNameHelper��IncludeTrailingPathDelimiter�AExcludeTrailingPathDeli
 * miter
 * �֐����g�p����悤�ɕύX�B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/11/29   Time: 1:28
 * Updated in $/source/D5Integrated
 * �t�B���^�����O�̕s��C��
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/11/27   Time: 2:41
 * Updated in $/source/D5Integrated
 * �f�B���N�g����ΏۂƂ��邩�ǂ����ƁA�T�u�f�B���N�g�����������邩�ǂ���
 * �𖾊m�ɕ������B�e�X�g�P�[�X���쐬�����B
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/11/25   Time: 5:33
 * Updated in $/source/D5Integrated
 * �g���ɂ��������̂ŁA�啝�Ƀ��t�@�N�^�����O�����B
 * OnFindFile�̌^K0FindFileMatchEvent��ύX�����ȊO�́A
 * �قƂ�ǃC���^�t�F�[�X�̕ύX�͖����B
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0Extend
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
-----------------------------------------------------------------------------}

unit s0FileFinder;

interface

uses
  SysUtils, Classes,
  s0FileHelper;

type
	K0FindFileMatchEvent = procedure(Sender: TObject; const aDir: string;
    aFindFileRec: TSearchRec; var IsMatched: Boolean) of object;

{-----------------------------------------------------------------------------------
  �t�@�C������������R���|�[�l���g�ł��B
  Active�v���p�e�B��True�ɂ��邩�ASearch���\�b�h���Ăяo���΁A�������J�n���܂��B
-----------------------------------------------------------------------------------}
type
  Ts0FileFinder = class(TComponent)
  private
    FSubDir: Boolean;
    FSearchDir: string;
    FMasks: TStrings;
    FResultList: TStrings;
    FOnFindFile: K0FindFileMatchEvent;
    FResultDisplay: TStrings;
    FAttrMask: K0FileAttrSet;
    procedure SetAttrMask(const Value: K0FileAttrSet);
  protected
    FActive: Boolean;
    procedure AddToResult(TargetDir: string; AInfo: TSearchRec);
    function IsMatched(TargetDir: string; AInfo: TSearchRec): Boolean;
    procedure PrepareMasks;
    procedure UnPrepareMasks;
    procedure SearchFiles(TargetDir: string); virtual;
    procedure SetSearchDir(Value: string); virtual;
    procedure SetActive(const Value: Boolean); virtual;
    procedure SetMasks(const Value: TStrings); virtual;
    procedure SetResultDisplay(const Value: TStrings); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Search; 
    property ResultList: TStrings read FResultList;
    property ResultDisplay: TStrings read FResultDisplay write SetResultDisplay;
  published
    property Active: Boolean read FActive write SetActive;
    property AttrMask: K0FileAttrSet read FAttrMask write SetAttrMask default [k0faReadOnly..k0faArchive];
    property Masks: TStrings read FMasks write SetMasks;
    property SearchDir: string read FSearchDir write SetSearchDir;
    property SubDir: Boolean read FSubDir write FSubDir default True;
    property OnFindFile: K0FindFileMatchEvent read FOnFindFile write FOnFindFile;
  end;


type
  Es0FileFinderError = class(Exception);

implementation

uses
{$IFDEF VER130}
  FileCtrl,
{$ENDIF}
  s0FileNameHelper,
	Masks;

{ Ts0FileFinder }

procedure Ts0FileFinder.AddToResult(TargetDir: string; AInfo: TSearchRec);
begin
  FResultList.Add(IncludeTrailingPathDelimiter(TargetDir) + AInfo.Name);
end;

constructor Ts0FileFinder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActive := False;
  FSubDir := True;
  FSearchDir := Ts0FileNameHelper.GetCurrentDirectory;
  FMasks := TStringList.Create;
  FMasks.Add('*.*');
  FResultList := TStringList.Create;
  FAttrMask := [k0faReadOnly..k0faArchive];
end;

destructor Ts0FileFinder.Destroy;
begin
  FreeAndNil(FMasks);
  FResultList.Free;
  inherited;
end;

function Ts0FileFinder.IsMatched(TargetDir: string; AInfo: TSearchRec): Boolean;
var
	i: integer;
begin
  Result := False;
  if AInfo.Name = '.' then Exit;
  if AInfo.Name = '..' then Exit;
  Result := (AInfo.Attr and Ts0FileHelper.AttrToWin32Attr(FAttrMask) <> 0);
  if Result then
  begin
    Result := False;
    for i := 0 to FMasks.Count -1 do
    begin
      if TMask(FMasks.Objects[i]).Matches(AInfo.Name) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
  if Assigned(FOnFindFile) then
    FOnFindFile(Self, TargetDir, AInfo, Result);
end;

procedure Ts0FileFinder.PrepareMasks;
var
	i: integer;
begin
  for i := 0 to FMasks.Count -1 do
  	FMasks.Objects[i] := TMask.Create(FMasks.Strings[i]);
end;

resourcestring
  cErrorDirNotExists = '"%s"�Ƃ����f�B���N�g���͑��݂��܂���B';

procedure Ts0FileFinder.Search;
begin
  if not DirectoryExists(FSearchDir) then
    raise Es0FileFinderError.CreateFmt(cErrorDirNotExists, [FSearchDir]);
  FActive := True;
  PrepareMasks;
  try
    FResultList.Clear;
    SearchFiles(FSearchDir);
    if assigned(FResultDisplay) then
    begin
      FResultDisplay.BeginUpdate;
      try
        FResultDisplay.Assign(FResultList);
      finally
        FResultDisplay.EndUpdate;
      end;
    end;
  finally
    UnPrepareMasks;
  end;
  FActive := False;
end;

procedure Ts0FileFinder.SearchFiles(TargetDir: string);
  procedure FoundDir(TargetDir: string; SearchResult: TSearchRec);
  begin
    if SubDir then
      SearchFiles(TargetDir+'\'+SearchResult.Name);
  end;
  procedure FoundFile(TargetDir: string; SearchResult: TSearchRec);
  begin
    if (SearchResult.Name = '.') or (SearchResult.Name = '..') then Exit;
    if IsMatched(TargetDir, SearchResult) then
      AddToResult(TargetDir, SearchResult);
    if (SearchResult.Attr and faDirectory) <> 0 then
      FoundDir(TargetDir, SearchResult);
  end;
var
  SearchFile: TSearchRec;
  lFound: Integer;
begin
  try
    lFound :=
      FindFirst(
        IncludeTrailingPathDelimiter(TargetDir) + '*', faAnyFile, SearchFile
      );
    if lFound = 0 then
    begin
      FoundFile(TargetDir, SearchFile);
      while FindNext(SearchFile) =0 do
        FoundFile(TargetDir, SearchFile);
    end;
  finally
    FindClose(SearchFile);
  end;
end;

procedure Ts0FileFinder.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if FActive then
    Search;
end;

procedure Ts0FileFinder.SetAttrMask(const Value: K0FileAttrSet);
begin
  FAttrMask := Value;
end;

procedure Ts0FileFinder.SetMasks(const Value: TStrings);
begin
  FMasks.Assign(Value);
end;

procedure Ts0FileFinder.SetResultDisplay(const Value: TStrings);
begin
  FResultDisplay := Value;
end;

procedure Ts0FileFinder.SetSearchDir(Value: string);
begin
  FSearchDir := ExcludeTrailingPathDelimiter(Value);
end;

procedure Ts0FileFinder.UnPrepareMasks;
var
	i: integer;
begin
  for i := 0 to FMasks.Count -1 do
  begin
  	FMasks.Objects[i].Free;
    FMasks.Objects[i] := nil;
  end;
end;

end.
