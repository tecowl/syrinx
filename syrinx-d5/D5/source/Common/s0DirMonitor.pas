{-----------------------------------------------------------------------------
 Unit Name: s0DirMonitor
 Author:    akima
 Purpose:
 TestCase: tc_s0DirMonitor
 $History: s0DirMonitor.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/06   Time: 21:07
 * Updated in $/source/D6VCLIntegrated
 * FileCtrl���j�b�g��uses�߂���폜
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/11/26   Time: 3:40
 * Updated in $/source/D5Integrated
 * 2�O�̃o�[�W�����ɖ߂����B�����ď�肭�����Ȃ������񂾂���B
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/25   Time: 4:35
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/25   Time: 4:23
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0DirMonitor;

interface

uses
  Windows, SysUtils, Classes,
  SyncObjs,
  s0Collection;

{*************************************************************************************************
    �I�I�I  ���ӎ���  �I�I�I
  1.�I�I�I�I ��d�v �I�I�I�I
  	�Ď�����f�B���N�g����ύX����Ƃ��ɂ̓C���X�^���X����蒼���Ă��������B

  2.���s���̃X���b�h���~���邽�߂ɂ�PargeThread���\�b�h���Ăяo���܂��B
  	PargeThread���\�b�h���Ăяo���ƁA�ێ����Ă���T0MonitorDirInfo�̔z���
    �j������܂��B���̌�ATerminate���\�b�h���Ăяo���܂��B���̂Ƃ�
    FreeOnTerminate�v���p�e�B��True�Ȃ�΃C���X�^���X�͔j������܂��B

  3.T1MonitorDirInfo��ǉ����邱�ƂŁA�����̃f�B���N�g�����Ď��ł��܂��B
    �i����͒萔cMaxDirCount�ŗ^������j
*************************************************************************************************}
type
  K0DirArrayChar = array[0..255] of char;


{  Mode: DWORD
			FILE_NOTIFY_CHANGE_FILE_NAME
      FILE_NOTIFY_CHANGE_DIR_NAME
      FILE_NOTIFY_CHANGE_ATTRIBUTES
      FILE_NOTIFY_CHANGE_SIZE
      FILE_NOTIFY_CHANGE_LAST_WRITE
      FILE_NOTIFY_CHANGE_SECURITY
}
type
  K0MonitorKind = (
    k0mkChangeFileName,
    k0mkChangeDirName,
    k0mkChangeAttributes,
    k0mkChangeSize,
    k0mkChangeLastWrite,
    k0mkChangeSecurity
  );
  K0MonitorKindSet = set of K0MonitorKind;

const
  c0MonitorKinds: array[K0MonitorKind] of DWORD = (
    FILE_NOTIFY_CHANGE_FILE_NAME ,
    FILE_NOTIFY_CHANGE_DIR_NAME  ,
    FILE_NOTIFY_CHANGE_ATTRIBUTES,
    FILE_NOTIFY_CHANGE_SIZE      ,
    FILE_NOTIFY_CHANGE_LAST_WRITE,
    FILE_NOTIFY_CHANGE_SECURITY
  );

type
	Ts0MonitoringDir = class(Ts0CollectionItem)
  private
  	FCharPath: K0DirArrayChar;
    FSubDir: Boolean;
    FMonitorMode: K0MonitorKindSet;
    procedure SetPath(const Value: string);
    function GetMode: DWORD;
    function GetPath: string;
    function GetbSubTree: DWORD;
 protected
    property bSubTree: DWORD read GetbSubTree;
    property CharPath: K0DirArrayChar read FCharPath;
    property Mode: DWORD read GetMode;
    function FindFirstNotificatoinHandle: THandle;
  public
    constructor Create(ACollection: TCollection); override;
    property MonitorMode: K0MonitorKindSet read FMonitorMode write FMonitorMode default [k0mkChangeLastWrite];
		property Path: string read GetPath write SetPath;
    property SubDir: Boolean read FSubDir write FSubDir;
  end;

type
	Ts0MonitoringDirs = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0MonitoringDir;
    procedure SetItems(const Index: Integer; const Value: Ts0MonitoringDir);
  public
    function Add(APath: string; AMode: K0MonitorKindSet; ASubDir: Boolean): Ts0MonitoringDir;
    property Items[const Index: Integer]: Ts0MonitoringDir read GetItems write SetItems;
  end;

type
  K0FindChangeEvent = procedure(Sender: TObject; ADirInfo: Ts0MonitoringDir) of object;

const
	c0MaxDirCount = MAXIMUM_WAIT_OBJECTS -1;

type
	Ts0DirMonitorThread = class(TThread)
  private
    FDirectories: Ts0MonitoringDirs;
    FFindChangeEvent: K0FindChangeEvent;
    FPargeEvent: TEvent;
    FRunning: Boolean;
    FEventIndex: Integer;
  protected
  	procedure Execute; override;
  public
    constructor Create(ADirs: Ts0MonitoringDirs; AFindChangeEvent: K0FindChangeEvent); 
    procedure DoOnFind;
    procedure PargeThread;
    property Running: Boolean read FRunning;
    //property DirInfos[const DirIndex: Integer]: Ts0MonitoringDir read GetDirInfo write SetDirInfo;
  end;

type
  Ts0DirMonitor = class(TComponent)
  private
    FDirectories: Ts0MonitoringDirs;
    FMonitoring: Ts0DirMonitorThread;
    FOnChangeEvent: K0FindChangeEvent;
    procedure SetDirectories(const Value: Ts0MonitoringDirs);
  protected
    procedure DoChangeEvent(Sender: TObject; ADirInfo: Ts0MonitoringDir);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginMonitor;
    procedure EndMonitor;
  published
    property Directories: Ts0MonitoringDirs read FDirectories write SetDirectories;
    property OnChangeEvent: K0FindChangeEvent read FOnChangeEvent write FOnChangeEvent;
  end;


type
  Es0MonitorException = class(Exception);

implementation

uses
	Messages;

const
  WM_ChangeDir = WM_USER+256;
  cBaseOrigin = 1;   //�I���W�����w��       

{ Ts0MonitoringDir }

constructor Ts0MonitoringDir.Create(ACollection: TCollection);
begin
  inherited;
  FMonitorMode := [k0mkChangeLastWrite];
end;

function Ts0MonitoringDir.FindFirstNotificatoinHandle: THandle;
begin
  Result := FindFirstChangeNotification(CharPath, LongBool(bSubTree), Mode);
end;

function Ts0MonitoringDir.GetbSubTree: DWORD;
begin
  if FSubDir then
    Result := 1
  else
    Result := 0;
end;

function Ts0MonitoringDir.GetMode: DWORD;
var
  i: K0MonitorKind;
begin
  Result := 0;
  for i := Low(K0MonitorKind) to High(K0MonitorKind) do
    if i in FMonitorMode then
      Result := Result or c0MonitorKinds[i];  
end;

function Ts0MonitoringDir.GetPath: string;
begin
  Result := FCharPath;
end;

procedure Ts0MonitoringDir.SetPath(const Value: string);
begin
  StrPCopy(FCharPath, Value);
end;

{ Ts0MonitoringDirs }

function Ts0MonitoringDirs.Add(APath: string; AMode: K0MonitorKindSet;
  ASubDir: Boolean): Ts0MonitoringDir;
begin
  Result := Ts0MonitoringDir(inherited Add);
  Result.Path := APath;
  Result.MonitorMode := AMode;
  Result.SubDir := ASubDir;
end;

function Ts0MonitoringDirs.GetItems(const Index: Integer): Ts0MonitoringDir;
begin
  Result := Ts0MonitoringDir(inherited Items[Index]);
end;

procedure Ts0MonitoringDirs.SetItems(const Index: Integer;
  const Value: Ts0MonitoringDir);
begin
  inherited Items[Index] := Value;
end;

{ Ts0DirMonitorThread }

constructor Ts0DirMonitorThread.Create(ADirs: Ts0MonitoringDirs;
  AFindChangeEvent: K0FindChangeEvent);
begin
	inherited Create(True);
  FPargeEvent := nil;
  FDirectories := ADirs;
  FFindChangeEvent := AFindChangeEvent;
end;

procedure Ts0DirMonitorThread.DoOnFind;
begin
  if Assigned(FFindChangeEvent) then
    FFindChangeEvent(Self, FDirectories.Items[FEventIndex]);
end;

procedure Ts0DirMonitorThread.Execute;
var
  breakStatus : boolean;
  waitStatus : DWORD;
  haChanges: TWOHandleArray;
  notifyIdx, arrayCnt: DWORD;
  i: Word;
begin
  breakStatus := False;
  //Execute���I�������邽�߂̃C�x���g
  FPargeEvent := TSimpleEvent.Create;
  if FPargeEvent.Handle = 0 then
  	raise Es0MonitorException.CreateFmt('Error %d', [FPargeEvent.LastError]);
  arrayCnt := FDirectories.Count;
  try
    //DirInfo���P�I���W���Ȃ̂�Execute���I�������邽�߂̃C�x���g��
    //�z��̓��O�Ԗڂɑ��
    haChanges[0] := FPargeEvent.Handle;
    //�f�B���N�g�����Ď�����̂͂P�Ԗڂ���
    for i := 0 to FDirectories.Count -1 do
    begin
      haChanges[i +1] := FDirectories.Items[i].FindFirstNotificatoinHandle;
      //������ChangeNotification���쐬����Ă��邩�ǂ������`�F�b�N
      if haChanges[i +1] = INVALID_HANDLE_VALUE then
      begin
        haChanges[i +1] := 0;
        Exit;
      end;
    end;
    //
    FRunning := True;
    while True do
    begin
      //���s�����Ƃ��̎��ŉ����ύX������܂őҋ@���܂��B
      waitStatus := WaitForMultipleObjects(arrayCnt +1, @haChanges, False, INFINITE);
      notifyIdx := waitStatus - WAIT_OBJECT_0;
      if notifyIdx = 0 then  //PargeThread���Ă΂ꂽ
      begin
        breakStatus := True;  (* Success Exit Thread *)
        break;
      end
      else
      if notifyIdx < arrayCnt +1 then  //�ύX����������
      begin
        //FEventIndex�ŊĎ��Ώۃf�B���N�g���̃C���f�b�N�X��n��
        FEventIndex := notifyIdx -1;
        Synchronize(DoOnFind);
        if not FindNextChangeNotification(haChanges[notifyIdx]) then
          break;
      end
      else
      begin
        break;
      end;
    end; //while
  finally
  	//�I���p�̃C�x���g������
    FreeAndNil(FPargeEvent);
    //�J�������͕��܂��傤
    for i := Low(haChanges) + 1 to High(haChanges) do
      if haChanges[i] <> 0 then
        FindCloseChangeNotification(haChanges[i]);
    if not breakStatus then
      raise Es0MonitorException.CreateFmt('Error %d', [GetLastError]);
  end;
end;

procedure Ts0DirMonitorThread.PargeThread;
begin
  if FPargeEvent <> nil then
  begin
    FPargeEvent.SetEvent;
    FRunning := False;
  end;
end;

{ Ts0DirMonitor }

procedure Ts0DirMonitor.BeginMonitor;
begin
  if FMonitoring <> nil then Exit;
  FMonitoring := Ts0DirMonitorThread.Create(FDirectories, DoChangeEvent);
  FMonitoring.FreeOnTerminate := True;
  FMonitoring.Resume;
end;

constructor Ts0DirMonitor.Create(AOwner: TComponent);
begin
  inherited;
  FDirectories := Ts0MonitoringDirs.Create(Self, Ts0MonitoringDir);
end;

destructor Ts0DirMonitor.Destroy;
begin
  EndMonitor;
  FreeAndNil(FDirectories);
  inherited;               
end;

procedure Ts0DirMonitor.DoChangeEvent(Sender: TObject; ADirInfo: Ts0MonitoringDir);
begin
  if Assigned(FOnChangeEvent) then
    FOnChangeEvent(Self, ADirInfo);
end;

procedure Ts0DirMonitor.EndMonitor;
begin
  if FMonitoring = nil then Exit;
  FMonitoring.PargeThread;
  FMonitoring.Terminate;
  FMonitoring := nil;
end;

procedure Ts0DirMonitor.SetDirectories(const Value: Ts0MonitoringDirs);
begin
  FDirectories.Assign(Value);
end;

end.
