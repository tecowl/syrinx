unit s0Application;
{
$History: s0Application.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0additional
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/06   Time: 14:03
 * Updated in $/source/p0common
 * Ts0AppStarterなどを追加。変更多数。
 *
 * *****************  Version 7  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:32
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes,
  s0Observer;

type
  K0ApplicationStatus = (k0asStarted, k0asInitialized, k0asRunning, k0asFinalizing);

type
  Ts0AppStarterClass = class of Ts0AppStarter;
  Ts0AppStarter = class(TComponent)
  public
    function CanStart: Boolean; virtual;
    function CanTerminate: Boolean; virtual;
  end;

type
  Ts0AppStarters = class(TComponent)
  private
    function GetStarterCount: Integer;
    function GetStarters(const Index: Integer): Ts0AppStarter;
  protected
    procedure CreateStarters;
  public
    property StarterCount: Integer read GetStarterCount;
    property Starters[const Index: Integer]: Ts0AppStarter read GetStarters;
    class procedure RegisterStarter(AStarter: Ts0AppStarterClass);
    class procedure UnRegisterStarter(AStarter: Ts0AppStarterClass);
  end;

type
  Ts0ApplicationClass = class of Ts0Application;
  Ts0Application = class(TComponent)
  private
    FAppStatus: K0ApplicationStatus;
    FOnAfterInit: TNotifyEvent;
    FOnBeforeRun: TNotifyEvent;
    FOnAfterRun: TNotifyEvent;
    FOnBeforeFinalize: TNotifyEvent;
    FStarters: Ts0AppStarters;
  protected
    function CanRun: Boolean; virtual;
    function CanTerminate: Boolean; virtual;
    procedure ChangeStatus(AStatus: K0ApplicationStatus); virtual;
    procedure DoNotifyEvent(AEvent: TNotifyEvent);
    property AppStatus: K0ApplicationStatus read FAppStatus;
  protected
    function ImplGetExeName: string; virtual;
    procedure ImplInitialize; virtual;
    procedure ImplRun; virtual;
    procedure ImplTerminate; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    class function GetAppStatus: K0ApplicationStatus;
    class function CanCreateSingleton: Boolean;
    procedure Initialize;
    procedure Run;
    procedure Terminate;
    property ExeName: string read ImplGetExeName;
    //Singleton
    class function Instance: Ts0Application;
    class procedure RegisterClass(AClass: Ts0ApplicationClass);
  published
    property OnAfterInit     : TNotifyEvent read FOnAfterInit      write FOnAfterInit     ;
    property OnBeforeRun     : TNotifyEvent read FOnBeforeRun      write FOnBeforeRun     ;
    property OnAfterRun      : TNotifyEvent read FOnAfterRun       write FOnAfterRun      ;
    property OnBeforeFinalize: TNotifyEvent read FOnBeforeFinalize write FOnBeforeFinalize;
  end;

  
{
  Forms  .TApplication

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateHint(CursorPos: TPoint);
    procedure BringToFront;
    procedure ControlDestroyed(Control: TControl);
    procedure CancelHint;
    procedure CreateForm(InstanceClass: TComponentClass; var Reference);
    procedure CreateHandle;
    function ExecuteAction(Action: TBasicAction): Boolean; reintroduce;
    procedure HandleException(Sender: TObject);
    procedure HandleMessage;
    function HelpCommand(Command: Integer; Data: Longint): Boolean; 
    function HelpContext(Context: THelpContext): Boolean; 
    function HelpJump(const JumpID: string): Boolean;
    function HelpKeyword(const Keyword: String): Boolean;
    procedure HideHint;
    procedure HintMouseMessage(Control: TControl; var Message: TMessage);
    procedure HookMainWindow(Hook: TWindowHook);
    procedure HookSynchronizeWakeup;
    procedure Initialize;
    function IsRightToLeft: Boolean;
    function MessageBox(const Text, Caption: PChar; Flags: Longint = MB_OK): Integer;
    procedure Minimize;
    procedure NormalizeAllTopMosts;
    procedure NormalizeTopMosts;
    procedure ProcessMessages;
    procedure Restore;
    procedure RestoreTopMosts;
    procedure Run;
    procedure ShowException(E: Exception);
    procedure Terminate;
    procedure UnhookMainWindow(Hook: TWindowHook);
    procedure UnhookSynchronizeWakeup;
    function UpdateAction(Action: TBasicAction): Boolean; reintroduce;
    function UseRightToLeftAlignment: Boolean;
    function UseRightToLeftReading: Boolean;
    function UseRightToLeftScrollBar: Boolean;
    property Active: Boolean read FActive;
    property AllowTesting: Boolean read FAllowTesting write FAllowTesting;
    property AutoDragDocking: Boolean read FAutoDragDocking write FAutoDragDocking default True;
    property HelpSystem : IHelpSystem read FHelpSystem;
    property CurrentHelpFile: string read GetCurrentHelpFile;
    property DialogHandle: HWnd read GetDialogHandle write SetDialogHandle;
    property ExeName: string read GetExeName;
    property Handle: HWnd read FHandle write SetHandle;
    property HelpFile: string read FHelpFile write FHelpFile;
    property Hint: string read FHint write SetHint;
    property HintColor: TColor read FHintColor write SetHintColor;
    property HintHidePause: Integer read FHintHidePause write FHintHidePause;
    property HintPause: Integer read FHintPause write FHintPause;
    property HintShortCuts: Boolean read FHintShortCuts write FHintShortCuts;
    property HintShortPause: Integer read FHintShortPause write FHintShortPause;
    property Icon: TIcon read FIcon write SetIcon;
    property MainForm: TForm read FMainForm;
    property BiDiMode: TBiDiMode read FBiDiMode
      write SetBiDiMode default bdLeftToRight;
    property BiDiKeyboard: string read FBiDiKeyboard write FBiDiKeyboard;
    property NonBiDiKeyboard: string read FNonBiDiKeyboard write FNonBiDiKeyboard;
    property ShowHint: Boolean read FShowHint write SetShowHint;
    property ShowMainForm: Boolean read FShowMainForm write FShowMainForm;
    property Terminated: Boolean read FTerminate;
    property Title: string read GetTitle write SetTitle;
    property UpdateFormatSettings: Boolean read FUpdateFormatSettings
      write FUpdateFormatSettings;
    property UpdateMetricSettings: Boolean read FUpdateMetricSettings
      write FUpdateMetricSettings;
    property OnActionExecute: TActionEvent read FOnActionExecute write FOnActionExecute;
    property OnActionUpdate: TActionEvent read FOnActionUpdate write FOnActionUpdate;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnException: TExceptionEvent read FOnException write FOnException;
    property OnIdle: TIdleEvent read FOnIdle write FOnIdle;
    property OnHelp: THelpEvent read FOnHelp write FOnHelp;
    property OnHint: TNotifyEvent read FOnHint write FOnHint;
    property OnMessage: TMessageEvent read FOnMessage write FOnMessage;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
    property OnShowHint: TShowHintEvent read FOnShowHint write FOnShowHint;
    property OnShortCut: TShortCutEvent read FOnShortCut write FOnShortCut;
    property OnSettingChange: TSettingChangeEvent read FOnSettingChange write FOnSettingChange;
  end;
}

(*
  QForms.TApplication
  
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateHint(CursorPos: TPoint);
    procedure BringToFront;
    procedure CancelHint;
    procedure ControlDestroyed(Control: TControl);
    procedure CreateForm(InstanceClass: TComponentClass; var Reference);
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure HandleException(Sender: TObject);
    procedure HandleMessage;
    procedure HideHint;
    procedure HintMouseMessage(Control: TControl; Shift: TShiftState; X, Y: Integer);
    procedure HookSynchronizeWakeup;
    procedure Initialize;
    function IsShortCut(Key: Integer; Shift: TShiftState; const KeyText: WideString): Boolean;
    procedure InvokeHelp;
    function ContextHelp(const HelpContext: THelpContext): Boolean;
    function KeywordHelp(const HelpKeyword: string): Boolean;
    function MessageBox(const Text: WideString; const Caption: WideString = '';
      Buttons: TMessageButtons = [smbOK]; Style: TMessageStyle = smsInformation;
      Default: TMessageButton = smbOK; Escape: TMessageButton = smbCancel): TMessageButton;
    procedure Minimize;
    procedure ModalStarted(Sender: TObject);
    procedure ModalFinished(Sender: TObject);
    procedure NormalizeTopMosts;
    procedure ProcessMessages;
    procedure Restore;
    procedure RestoreTopMosts;
    procedure Run;
    procedure ShowException(E: Exception);
    procedure Terminate;
    procedure UnhookSynchronizeWakeup;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Active: Boolean read FActive;
    property CurrentHelpFile: string read GetCurrentHelpFile;
    property Desktop: QWidgetH read GetDesktop;
{$IFDEF LINUX}
    property Display: PDisplay read GetDisplay;
{$ENDIF}
    property EnableQtAccelerators: Boolean read FQtAccels write FQtAccels;
    property ExeName: string read GetExeName;
    property Font: TFont read GetFont write SetFont;
    property Handle: QApplicationH read FHandle write SetHandle;
    property HelpFile: string read FHelpFile write FHelpFile;
    property HelpKey: Integer read FHelpKey write FHelpKey default Key_F1;
    property HelpSystem: IHelpSystem read FHelpSystem;
    property HelpWord: string read FHelpKeyword write SetHelpKeyword;
    property HelpContext: THelpContext read FHelpContext write SetHelpContext;
    property HelpType: THelpType read FHelpType write FHelpType;
    property Hint: WideString read FHint write SetHint;
    property HintColor: TColor read FHintColor write SetHintColor;
    property HintHidePause: Integer read FHintHidePause write FHintHidePause;
    property HintPause: Integer read FHintPause write FHintPause;
    property HintShortCuts: Boolean read FHintShortCuts write FHintShortCuts;
    property HintShortPause: Integer read FHintShortPause write FHintShortPause;
    property Icon: TIcon read FIcon write SetIcon;
    property KeyState: TShiftState read FKeyState;
    property MainForm: TCustomForm read FMainForm;
    property Palette: TPalette read FPalette;
    property ShowHint: Boolean read FShowHint write SetShowHint default True;
    property ShowMainForm: Boolean read FShowMainForm write FShowMainForm;
    property Style: TApplicationStyle read GetStyle write SetStyle;
    property Terminated: Boolean read FTerminated;
    property Title: WideString read FTitle write SetTitle;
    property OnActionExecute: TActionEvent read FOnActionExecute write FOnActionExecute;
    property OnActionUpdate: TActionEvent read FOnActionUpdate write FOnActionUpdate;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnEvent: TEventEvent read FOnEvent write FOnEvent;
    property OnException: TExceptionEvent read FOnException write FOnException;
    property OnHelp: THelpEvent read FOnHelp write FOnHelp;
    property OnHint: TNotifyEvent read FOnHint write FOnHint;
    property OnIdle: TIdleEvent read FOnIdle write FOnIdle;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnModalBegin: TNotifyEvent read FOnModalBegin write FOnModalBegin;
    property OnModalEnd: TNotifyEvent read FOnModalEnd write FOnModalEnd;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
    property OnShowHint: TShowHintEvent read FOnShowHint write FOnShowHint;
    property OnShortCut: TShortCutEvent read FOnShortCut write FOnShortCut;
  end;
*)

implementation

uses
{$IFDEF VER130}
  //s0ApplicationImpl,
{$ENDIF}
{$IFDEF SYRINX_CLX}
  Qs0ApplicationImpl,
{$ENDIF}
  Contnrs,
  s0Exception;

{ Ts0AppStarter }

function Ts0AppStarter.CanStart: Boolean;
begin
  Result := True;
end;

function Ts0AppStarter.CanTerminate: Boolean;
begin
  Result := True;
end;

{ Ts0AppStarters }

var
  g9StarterList: TClassList = nil;

procedure Ts0AppStarters.CreateStarters;
var
  i: Integer;
begin
  for i := 0 to g9StarterList.Count -1 do
    Ts0AppStarterClass(g9StarterList.Items[i]).Create(Self);
end;

function Ts0AppStarters.GetStarterCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Self.ComponentCount -1 do
    if Self.Components[i] is Ts0AppStarter then
      Inc(Result);
end;

function Ts0AppStarters.GetStarters(const Index: Integer): Ts0AppStarter;
var
  i, idx: Integer;
begin
  Result := nil;
  idx := 0;
  for i := 0 to Self.ComponentCount -1 do
    if Self.Components[i] is Ts0AppStarter then
    begin
      if Index = idx then
      begin
        Result := Ts0AppStarter(Self.Components[i]);
        Exit;
      end;
      Inc(idx);
    end;
end;

class procedure Ts0AppStarters.RegisterStarter(AStarter: Ts0AppStarterClass);
begin
  if g9StarterList = nil then
    g9StarterList := TClassList.Create;
  if g9StarterList.IndexOf(AStarter) > -1 then Exit;
  g9StarterList.Add(AStarter);
end;

class procedure Ts0AppStarters.UnRegisterStarter(
  AStarter: Ts0AppStarterClass);
begin
  if g9StarterList = nil then Exit;
  while g9StarterList.Remove(AStarter) > -1 do ;
end;

{ Ts0Application }

procedure Ts0Application.Assign(Source: TPersistent);
begin
  inherited;
end;

function Ts0Application.CanRun: Boolean;
var
  i, c: Integer;
begin
  Result := False;
  FStarters.CreateStarters;
  c := FStarters.StarterCount;
  for i := 0 to c -1 do
    if not FStarters.Starters[i].CanStart then Exit;
  Result := True;
end;

procedure Ts0Application.ChangeStatus(AStatus: K0ApplicationStatus);
begin
  FAppStatus := AStatus;
end;

constructor Ts0Application.Create(AOwner: TComponent);
begin
  inherited;
  FStarters := Ts0AppStarters.Create(nil);
  FAppStatus := k0asStarted;
end;

destructor Ts0Application.Destroy;
begin
  FreeAndNil(FStarters);
  inherited;
end;

procedure Ts0Application.DoNotifyEvent(AEvent: TNotifyEvent);
begin
  if Assigned(AEvent) then AEvent(Self);
end;

procedure Ts0Application.Initialize;
begin
  ImplInitialize;
  ChangeStatus(k0asInitialized);
  DoNotifyEvent(FOnAfterInit);
end;

procedure Ts0Application.Run;
begin
  DoNotifyEvent(FOnBeforeRun);
  try
    if not CanRun then Exit;
    ChangeStatus(k0asRunning);
    ImplRun;
    DoNotifyEvent(FOnAfterRun);
    Terminate;
  finally
    DoNotifyEvent(FOnBeforeFinalize);
    ChangeStatus(k0asFinalizing);
  end;
end;


class function Ts0Application.CanCreateSingleton: Boolean;
begin
  Result := GetAppStatus <> k0asFinalizing;
end;

function Ts0Application.CanTerminate: Boolean;
var
  i, c: Integer;
begin
  Result := False;
  c := FStarters.StarterCount;
  for i := 0 to c -1 do
    if not FStarters.Starters[i].CanTerminate then Exit;
  Result := True;
end;

procedure Ts0Application.Terminate;
begin
  ImplTerminate;
end;

var
  g9AppManagerClass: Ts0ApplicationClass = Ts0Application; 
  g9AppManager: Ts0Application = nil;

resourcestring
  c9ErrMsg_AppManClassNotRegistered = 'Application Manager Class is not registered.';

class function Ts0Application.Instance: Ts0Application;
begin
  if g9AppManager = nil then
  begin
    if g9AppManagerClass = nil then
      raise Es0ProgExcept.Create(c9ErrMsg_AppManClassNotRegistered);
    g9AppManager := g9AppManagerClass.Create(nil);
    g9AppManager.Name := 'Zeus';
  end;
  Result := g9AppManager;
end;

class procedure Ts0Application.RegisterClass(AClass: Ts0ApplicationClass);
begin
  g9AppManagerClass := AClass;
end;

class function Ts0Application.GetAppStatus: K0ApplicationStatus;
begin
  Result := k0asStarted;
  if g9AppManager = nil then Exit;
    Result := g9AppManager.AppStatus;
end;

procedure Ts0Application.ImplInitialize;
begin
//  Application.Initialize;
end;

procedure Ts0Application.ImplRun;
begin
//  Application.Run;
end;

procedure Ts0Application.ImplTerminate;
begin
//  Application.Terminate;
end;

function Ts0Application.ImplGetExeName: string;
begin
  Result := ParamStr(0);
end;

initialization

finalization
  FreeAndNil(g9AppManager);
  FreeAndNil(g9StarterList);

end.
