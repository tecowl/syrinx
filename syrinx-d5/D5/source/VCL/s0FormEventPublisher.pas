unit s0FormEventPublisher;
{
$History: s0FormEventPublisher.pas $
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/03/12   Time: 13:51
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/03/12   Time: 2:31
 * Updated in $/D6/source/VCL
 * FOnShow、FOnCloseのインスタンスを生成してなかったので修正
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/23   Time: 15:49
 * Updated in $/source/D5Integrated
 * DoEventメソッドに引数ACallBufAfterEventを追加して、
 * バッファのイベントと登録されているTs0Eventを呼び出す順番を制御できるよう
 * にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0comctrl
 * p0entityひとまずOK。
 * しかし、汎用的なフォームのためにリファクタリングを思案中・・・
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:27
 * Created in $/Projects/SDRFrameWork/src/lib0
 * 新規追加
 * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
}

interface

uses
  SysUtils, Classes,
  Forms,
  s0ComponentEventWrapper,
  s0Observer
  ;

type
  Ts0FormEventPublisher = class(Ts0ComponentEventWrapper)
  private
    FOnShow: Ts0Event;
    FOnClose: Ts0Event;
    FOnCloseQuery: Ts0Event;
  private
    FBufOnShow : TNotifyEvent;
    FBufOnClose: TCloseEvent ;
    FBufOnCloseQuery: TCloseQueryEvent;
  private
    FIgnoreCloseWhenInvisible: Boolean;
    procedure SetIgnoreCloseWhenInvisible(const Value: Boolean);
  protected
  	function IsIgnoreCloseEvent(Sender: TObject): Boolean;
    procedure OwnerClose(Sender: TObject; var Action: TCloseAction); virtual;
    procedure OwnerCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OwnerShow(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddListener(AListener: Ts0EventListener; AEventTypes: K0FormEventTypeSet); override;
    procedure ClearEventBuffer; override;
    procedure SnatchEvents; override;
    procedure PutBackEvents; override;
  public
    property OnClose: Ts0Event read FOnClose;
    property OnCloseQuery: Ts0Event read FOnCloseQuery;
    property OnShow : Ts0Event read FOnShow;
  published
  	property IgnoreCloseWhenInvisible: Boolean read FIgnoreCloseWhenInvisible
    	write SetIgnoreCloseWhenInvisible default True;
  end;

implementation

uses
  s0ApplicationImpl,
  Controls;

{ Ts0FormEventPublisher }

procedure Ts0FormEventPublisher.AddListener(AListener: Ts0EventListener;
  AEventTypes: K0FormEventTypeSet);
begin
  inherited;
	if k0femShow in AEventTypes then
  	Self.OnShow.Attach(AListener);	
	if k0femClose in AEventTypes then
  	Self.OnClose.Attach(AListener);
	if k0femCloseQuery in AEventTypes then
  	Self.OnCloseQuery.Attach(AListener);
end;

procedure Ts0FormEventPublisher.ClearEventBuffer;
begin
  FBufOnShow := nil;
  FBufOnClose := nil;
  FBufOnCloseQuery := nil;
end;

constructor Ts0FormEventPublisher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIgnoreCloseWhenInvisible := True;
  FOnShow := Ts0Event.Create(Self);
  FOnCloseQuery := Ts0Event.Create(Self);
  FOnClose := Ts0Event.Create(Self);
end;

destructor Ts0FormEventPublisher.Destroy;
begin
  FreeAndNil(FOnShow);
  FreeAndNil(FOnClose);
  FreeAndNil(FOnCloseQuery);
  inherited;
end;

function Ts0FormEventPublisher.IsIgnoreCloseEvent(
  Sender: TObject): Boolean;
begin
	Result := False;
	if not Self.IgnoreCloseWhenInvisible then
    Exit;
	if (Sender is TForm) and (not TForm(Sender).Visible) then
    	Result := True;
end;

procedure Ts0FormEventPublisher.OwnerClose(Sender: TObject;
  var Action: TCloseAction);
begin
	if IsIgnoreCloseEvent(Sender) then
  	Exit;
  if Assigned(FOnClose) then FOnClose.NotifyAll;
  if Assigned(FBufOnClose) then
    FBufOnClose(Self, Action);
end;

procedure Ts0FormEventPublisher.OwnerCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	if IsIgnoreCloseEvent(Sender) then
  	Exit;
  if Assigned(FOnCloseQuery) then FOnCloseQuery.NotifyAll;
  if Assigned(FBufOnCloseQuery) then
    FBufOnCloseQuery(Self, CanClose);
end;

procedure Ts0FormEventPublisher.OwnerShow(Sender: TObject);
begin
  if Assigned(FBufOnShow) then FBufOnShow(Self);
  if Assigned(FOnShow) then FOnShow.NotifyAll;
end;

procedure Ts0FormEventPublisher.PutBackEvents;
begin
  if csDesigning in Self.ComponentState then Exit;
  if Owner is TForm then
  begin
    TForm(Owner).OnClose := FBufOnClose;
    TForm(Owner).OnCloseQuery  := FBufOnCloseQuery ;
    TForm(Owner).OnShow  := FBufOnShow ;
  end;
  inherited PutBackEvents;
end;

procedure Ts0FormEventPublisher.SetIgnoreCloseWhenInvisible(
  const Value: Boolean);
begin
  FIgnoreCloseWhenInvisible := Value;
end;

procedure Ts0FormEventPublisher.SnatchEvents;
begin
  if csDesigning in Self.ComponentState then Exit;
  inherited SnatchEvents;
  if Owner is TForm then
  begin
    FBufOnClose := TForm(Owner).OnClose;
    FBufOnCloseQuery := TForm(Owner).OnCloseQuery;
    FBufOnShow  := TForm(Owner).OnShow ;
    TForm(Owner).OnClose := OwnerClose;
    TForm(Owner).OnCloseQuery := OwnerCloseQuery;
    TForm(Owner).OnShow  := OwnerShow ;
  end;
end;

initialization
{$IFNDEF VER130}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(Ts0FormEventPublisher, TControl);
{$ENDIF}

end.
