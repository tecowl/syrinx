unit s0Observer;
{
$History: s0Observer.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/06   Time: 18:27
 * Updated in $/source/p0common
 * Ts0Subject.Create�̑�o�O���C���B
 * TObjectList��Create�̈����ɖ����I��False���w�肵�Ȃ��ƁA
 * Destroy����Items��Free���Ă��܂���ł��B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/06   Time: 14:04
 * Updated in $/source/p0common
 * Ts0Event�̃R���X�g���N�^�̒�`��ύX�B
 * Ts0QueryEvent��ǉ��B
}

interface

uses
  SysUtils, Classes, Contnrs;

type
  {
    Ts0Event��T0Listener

    OBSERVER�p�^�[��[GoF95]�̎����ł��B

    Q.�Ȃ��AOBSERVER�p�^�[�����K�v����̂��H
    A.Delphi�̃��\�b�h�|�C���^�ɂ��ʒm�́A�ʒm�����Ώۂ���Ɍ����Ă��܂��B
      �{�t���[�����[�N�ł́A�����̑Ώۂɒʒm�𑗂肽���ꍇ�������B
      ���̏ꍇ�A���\�b�h�|�C���^�i�C�x���g�j�ł̎����͓���̂ŁA
      ���ۓI��Ts0Event��T0Listener��p�ӂ��Ă����A������p�r�ɍ��킹�Ĕh�����邱�Ƃɂ����B

    �ʏ�̃C�x���g�ƑΉ��t������悤�ɁATs0Event�̓v���p�e�B�Ƃ���Sender��
    �����A�����TNotifyEvent�C�x���g�Ȃǂ̈���Sender�ɑΉ�������̂ł���B

    �܂��ATNotifyEvent�̂悤�Ɂu����Sender�����ŉ�������̒ʒm���s���v�Ƃ���
    �C�x���g�̃n���h�����ȒP�ɌĂяo����悤�ɁAT0NotifyListener��\�ߎ��������B
    ���̃N���X�́AAttach����Ts0Event��Publish�����ƁATNotifyEvent�^��
    OnNotify�C�x���g�Ɏw�肳�ꂽ���\�b�h���Ăяo���B


    OBSERVER�p�^�[���Ƃ͕ʂɕt�������@�\�Ƃ��āAT0Listener.DetachAll���\�b�h������B
    �����Attach���Ă���Ts0Event���ׂĂɑ΂���Detach���s�����̂ŁA
    T0Listener��Free���ȂǂɎg�p����Ă���B
  }
  Ts0Subject = class;

  Ts0Observer = class
  public
    destructor Destroy; override;
    procedure Update(ASubj: Ts0Subject); virtual;
  end;

  Ts0Subject = class
  private
    FObservers: TObjectList;
  protected
    function GetObserverCount: Integer;
    function GetObservers(const Index: Integer): Ts0Observer;
    procedure Notify(AObs: Ts0Observer);
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure NotifyAll;
    procedure Attach(AObs: Ts0Observer);
    procedure Detach(AObs: Ts0Observer);
    class procedure NotifyObsDestruction(AObs: Ts0Observer);
  end;

type
  Ts0Event = class(Ts0Subject)
  private
    FSender: TObject;
  public
    constructor Create(ASender: TObject); reintroduce; virtual;
    property Sender: TObject read FSender write FSender;
  end;

type
  Ts0EventListener = class(Ts0Observer)
  private
    FOnEvent: TNotifyEvent;
  public
    constructor Create(AHandler: TNotifyEvent); reintroduce; overload; virtual;
    procedure Update(ASubj: Ts0Subject); override;
    property OnEvent: TNotifyEvent read FOnEvent write FOnEvent;
  end;

type
  Ts0QueryEvent = class(Ts0Event)
  private
    FResultFlag: Boolean;
    FDefaultValue: Boolean;
  public
    constructor Create(ASender: TObject); override;
    function Query: Boolean; virtual; abstract;
    property ResultFlag: Boolean read FResultFlag write FResultFlag;
    property DefaultValue: Boolean read FDefaultValue write FDefaultValue default True;
  end;

type
  K0QueryEvent = procedure(Sender: TObject; var ResultFlag: Boolean) of object;

type
  Ts0QueryEventListener = class(Ts0Observer)
  private
    FOnEvent: K0QueryEvent;
  public
    constructor Create(AHandler: K0QueryEvent); reintroduce; overload; virtual;
    procedure Update(ASubj: Ts0Subject); override;
    property OnEvent: K0QueryEvent read FOnEvent write FOnEvent;
  end;

type
  Ts0AllMatchEvent = class(Ts0QueryEvent)
  public
    function Query: Boolean; override;
  end;

type
  Ts0OneMatchEvent = class(Ts0QueryEvent)
  public
    function Query: Boolean; override;
  end;



implementation

{ Ts0Observer }

destructor Ts0Observer.Destroy;
begin
  Ts0Subject.NotifyObsDestruction(Self);
  inherited;
end;

procedure Ts0Observer.Update(ASubj: Ts0Subject);
begin
end;

{ Ts0Subject }

procedure Ts0Subject.Attach(AObs: Ts0Observer);
begin
  if FObservers.IndexOf(AObs) > -1 then
    Exit;
  FObservers.Add(AObs);
end;

procedure Ts0Subject.Detach(AObs: Ts0Observer);
begin
  while FObservers.Remove(AObs) > -1 do ;
end;

procedure Ts0Subject.Notify(AObs: Ts0Observer);
begin
  AObs.Update(Self);
end;

procedure Ts0Subject.NotifyAll;
var
  i: Integer;
begin
  for i := 0 to FObservers.Count - 1 do
    Notify(Ts0Observer(FObservers.Items[i]));
end;

var
  g9SubjectList: TObjectList = nil;

constructor Ts0Subject.Create;
begin
  inherited Create;
  FObservers := TObjectList.Create(False);
  if g9SubjectList = nil then
    g9SubjectList := TObjectList.Create(False);
  g9SubjectList.Add(Self);
end;

destructor Ts0Subject.Destroy;
begin
  if g9SubjectList <> nil then
    g9SubjectList.Remove(Self);
  FreeAndNil(FObservers);
  inherited;
end;

class procedure Ts0Subject.NotifyObsDestruction(AObs: Ts0Observer);
var
  i: Integer;
begin
  if g9SubjectList = nil then Exit;
  for i := 0 to g9SubjectList.Count - 1 do
    Ts0Subject(g9SubjectList.Items[i]).Detach(AObs);
end;

function Ts0Subject.GetObserverCount: Integer;
begin
  Result := FObservers.Count;
end;

function Ts0Subject.GetObservers(const Index: Integer): Ts0Observer;
begin
  Result := Ts0Observer( FObservers.Items[Index] );
end;

{ Ts0Event }

constructor Ts0Event.Create(ASender: TObject);
begin
  inherited Create;
  FSender := ASender;
end;

{ Ts0EventListener }

constructor Ts0EventListener.Create(AHandler: TNotifyEvent);
begin
  inherited Create;
  FOnEvent := AHandler;
end;

procedure Ts0EventListener.Update(ASubj: Ts0Subject);
var
  s: TObject;
begin
  s := nil;
  if ASubj is Ts0Event then
    s := Ts0Event(ASubj).Sender;
  if Assigned(FOnEvent) then
    FOnEvent(s);
end;

{ Ts0QueryEvent }

constructor Ts0QueryEvent.Create(ASender: TObject);
begin
  FDefaultValue := True;
  inherited Create(ASender);
end;

{ Ts0QueryEventListener }

constructor Ts0QueryEventListener.Create(AHandler: K0QueryEvent);
begin
  inherited Create;
  FOnEvent := AHandler;
end;

procedure Ts0QueryEventListener.Update(ASubj: Ts0Subject);
var
  s: TObject;
  f: Boolean;
begin
  if not(ASubj is Ts0QueryEvent) then Exit;
  s := Ts0QueryEvent(ASubj).Sender;
  f := Ts0QueryEvent(ASubj).ResultFlag;
  if Assigned(FOnEvent) then FOnEvent(s, f);
  Ts0QueryEvent(ASubj).ResultFlag := f;
end;

{ Ts0AllMatchEvent }

function Ts0AllMatchEvent.Query: Boolean;
var
  i, c: Integer;
begin
  Result := False;
  ResultFlag := FDefaultValue;
  c := GetObserverCount;
  for i := 0 to c -1 do
  begin
    Notify(GetObservers(i));
    if not Self.ResultFlag then Exit;
  end;
  Result := True;
end;

{ Ts0OneMatchEvent }

function Ts0OneMatchEvent.Query: Boolean;
var
  i, c: Integer;
begin
  Result := True;
  ResultFlag := FDefaultValue;
  c := GetObserverCount;
  for i := 0 to c -1 do
  begin
    Notify(GetObservers(i));
    if Self.ResultFlag then Exit;
  end;
  Result := False;
end;

initialization

finalization
  FreeAndNil(g9SubjectList);

end.

