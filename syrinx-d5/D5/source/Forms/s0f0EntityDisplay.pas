 unit s0f0EntityDisplay;
{
$History: s0f0EntityDisplay.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/14   Time: 4:27
 * Updated in $/D5/source/Forms
 * s0EntityFormManagerで使用する部分は、s0EntityDispImplユニットに移行。
 * s0f0EntityDisplayユニットは完全にFormディレクトリにのみ存在するものとな
 * った。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/13   Time: 10:54
 * Updated in $/D6/source/VCL
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/21   Time: 22:46
 * Updated in $/source/D6VCLIntegrated/Forms
 * 各Entity用のDMには、Ts0EntityFormManagerを置かないように変更。
 * Ts0EntityFormManagerはコンポーネントとして廃止したことに対応。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/22   Time: 22:39
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/23   Time: 1:12
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/03   Time: 5:07
 * Updated in $/source/D5Integrated/Forms
 * ユニット名変更完了
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/29   Time: 18:42
 * Updated in $/source/D5/p0entity
 * 汎用フォームが実現できそう。一時チェックイン。
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0entity
 * p0entityひとまずOK。
 * しかし、汎用的なフォームのためにリファクタリングを思案中・・・
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/27   Time: 20:04
 * Updated in $/source/D5/p0entity
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Contnrs,
  s0Observer,
  s0Entity,
  s0EntityDispImpl,
  s0ComponentEventWrapper,
  s0FormEventPublisher,
  s0FormRelation;

type
  Ts0frmEntityDisplayClass = class of Ts0frmEntityDisplay;
  Ts0frmEntityDisplay = class(TForm)
    s0FormRelation1: Ts0FormRelation;
  private
    FChangeTargetClassListener: Ts0Observer;
  protected
    function GetTargetClass: Ts0EntityClass; virtual;
    procedure SetTargetClass(Value: Ts0EntityClass); virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetCreationMode: K0FormCreationMode; virtual;
    class function GetTargetClassBeforeCreate: Ts0EntityClass; virtual; abstract;
    class function GetEnableMode: K0DisplayType; virtual; abstract;
    class function IsAlternative: Boolean; virtual;
    property TargetClass: Ts0EntityClass read GetTargetClass write SetTargetClass;
  end;

type
  Es0EntityDisplayException = class(Exception);

type
  Ts0EntityDisplayList = class(TObjectList)
  private
  protected
    function GetItems(Index: Integer): Ts0frmEntityDisplay;
    procedure SetItems(Index: Integer; AItem: Ts0frmEntityDisplay);
  public
    function Add(AItem: Ts0frmEntityDisplay): Integer;
    function Remove(AItem: Ts0frmEntityDisplay): Integer;
    function IndexOf(AItem: Ts0frmEntityDisplay): Integer;
    procedure Insert(Index: Integer; AItem: Ts0frmEntityDisplay);
    property Items[Index: Integer]: Ts0frmEntityDisplay read GetItems write
      SetItems; default;
    function First: Ts0frmEntityDisplay;
    function Last: Ts0frmEntityDisplay;
  end;

var
  s0frmEntityDisplay: Ts0frmEntityDisplay;

procedure RegisterDispClass(ADispClass: Ts0frmEntityDisplayClass);
procedure UnRegisterDispClass(ADispClass: Ts0frmEntityDisplayClass);

implementation

uses
  s0EntityFormManager;

{$R *.DFM}

procedure RegisterDispClass(ADispClass: Ts0frmEntityDisplayClass);
begin
  Ts0EntityFormDispRegister.RegisterDisply(
    ADispClass,
    ADispClass.GetTargetClassBeforeCreate,
    ADispClass.GetEnableMode,
    ADispClass.IsAlternative
  );
end;

procedure UnRegisterDispClass(ADispClass: Ts0frmEntityDisplayClass);
begin
  Ts0EntityFormDispRegister.UnRegisterDisply(ADispClass);
end;

{ Ts0EntityDisplayList }

function Ts0EntityDisplayList.Add(AItem: Ts0frmEntityDisplay): Integer;
begin
  Result := inherited Add(AItem);
end;

function Ts0EntityDisplayList.First: Ts0frmEntityDisplay;
begin
  Result := Ts0frmEntityDisplay(inherited First);
end;

function Ts0EntityDisplayList.GetItems(Index: Integer): Ts0frmEntityDisplay;
begin
  Result := Ts0frmEntityDisplay(inherited Items[Index]);
end;

function Ts0EntityDisplayList.IndexOf(AItem: Ts0frmEntityDisplay): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure Ts0EntityDisplayList.Insert(Index: Integer;
  AItem: Ts0frmEntityDisplay);
begin
  inherited Insert(Index, AItem);
end;

function Ts0EntityDisplayList.Last: Ts0frmEntityDisplay;
begin
  Result := Ts0frmEntityDisplay(inherited Last);
end;

function Ts0EntityDisplayList.Remove(AItem: Ts0frmEntityDisplay): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure Ts0EntityDisplayList.SetItems(Index: Integer; AItem:
  Ts0frmEntityDisplay);
begin
  inherited Items[Index] := AItem;
end;

type
  Ts9ChangeTargetClassEventListener = class(Ts0Observer)
  private
    FOwner: Ts0frmEntityDisplay;
  public
    procedure Update(ASubj: Ts0Subject); override;
  end;


{ Ts0frmEntityDisplay }

constructor Ts0frmEntityDisplay.Create(AOwner: TComponent);
begin
  FChangeTargetClassListener := Ts9ChangeTargetClassEventListener.Create;
  Ts9ChangeTargetClassEventListener(FChangeTargetClassListener).FOwner := Self;
  inherited Create(AOwner);
end;

destructor Ts0frmEntityDisplay.Destroy;
begin
  FreeAndNil(FChangeTargetClassListener);
  inherited Destroy;
end;

class function Ts0frmEntityDisplay.GetCreationMode: K0FormCreationMode;
begin
  Result := k0fcmByEntityAndOrigin;
end;

function Ts0frmEntityDisplay.GetTargetClass: Ts0EntityClass;
begin
  Result := Self.GetTargetClassBeforeCreate;
end;

class function Ts0frmEntityDisplay.IsAlternative: Boolean;
begin
  Result := False;
end;

resourcestring
  c9ErrMsg_CannotSetTargetEntity = '通常のフォームではTargetClassプロパティに'
    + '値を設定することはできません。';

procedure Ts0frmEntityDisplay.Loaded;
var
  i: Integer;
begin
  inherited;
  if csDesigning in Self.ComponentState then Exit;
  for i := 0 to Self.ComponentCount -1 do
    if Components[i] is Ts0EntityDispImpl then
      Ts0EntityDispImpl(Components[i]).OnSetDispEntityClass.Attach(FChangeTargetClassListener);
end;

procedure Ts0frmEntityDisplay.SetTargetClass(Value: Ts0EntityClass);
begin
  if IsAlternative then Exit;
  raise Es0EntityDisplayException.Create(c9ErrMsg_CannotSetTargetEntity);
end;

{ Ts9ChangeTargetClassEventListener }

procedure Ts9ChangeTargetClassEventListener.Update(ASubj: Ts0Subject);
begin
  if not(ASubj is Ts0SetDispEntityClassEvent) then Exit;
  FOwner.SetTargetClass( Ts0SetDispEntityClassEvent(ASubj).TargetClass );
end;

end.

