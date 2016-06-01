unit s0EntityDetailImpl;
{
$History: s0EntityDetailImpl.pas $
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/03/25   Time: 14:45
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/14   Time: 4:23
 * Updated in $/D5/source/VCL
 * s0f0EntityDisplayユニットをusesから削除。代わりに、s0EntityDispImplユニ
 * ットを追加。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/01/10   Time: 16:54
 * Updated in $/source/D5Integrated
 * SaveToTargetの実装を変更
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/23   Time: 15:47
 * Updated in $/source/D5Integrated
 * RemoveTarget,NotifyUpdateToListメソッドを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/22   Time: 22:38
 * Updated in $/source/D5Integrated
 * 更新後に、Ts0EntityListImplのDetailSavedメソッドを呼び出すようにした。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/23   Time: 1:07
 * Updated in $/source/D5Integrated
 * EditingModeプロパティを追加
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/21   Time: 18:30
 * Updated in $/source/D5Integrated
 * ClearCtrlsメソッド、OnClearCtrlsイベントを追加
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/20   Time: 0:10
 * Updated in $/source/D5Integrated
 * DispTargetプロパティが設定されたときに発生するOnSetTargetイベントを追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 4:59
 * Updated in $/source/D5Integrated
 * f0EntityDisplayなどのユニット名がs0f0EntityDisplayというように
 * 名称変更されたのでそれに対応した。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/29   Time: 17:22
 * Created in $/source/D5/p0entity
 * 新規作成
}

interface

uses
  SysUtils, Classes, Forms,
  s0Observer,
  s0Entity,
  //s0f0EntityDisplay;
  s0EntityDispImpl;

type
  Ts0EntityDetailImpl = class(Ts0EntityDispImpl)
  private
    FDispTarget: Ts0Entity;
    FTargetChangeListener: Ts0EventListener;
    FTargetChangeIDListener: Ts0EventListener;
    FOnChangeTarget: TNotifyEvent;
    FOnChangeTargetID: TNotifyEvent;
    FOnDetailSave: TNotifyEvent;
    FOnDetailLoad: TNotifyEvent;
    FOnSetTarget: TNotifyEvent;
    FOnClearCtrls: TNotifyEvent;
    FEditingMode: K0DetailDisplayMode;
    FOnChangeEditingMode: TNotifyEvent;
    FOnDetailRemove: TNotifyEvent;
    function GetDispTarget: Ts0Entity;
    procedure SetDispTarget(const Value: Ts0Entity);
    procedure SetEditingMode(const Value: K0DetailDisplayMode);
  protected
    procedure DoChangeEditingMode;
    procedure DoDetailLoad;
    procedure DoDetailSave;
    procedure DoDetailRemove;
    procedure DoChangeTarget;
    procedure DoChangeTargetID;
    procedure DoClearCtrls;
    procedure DoSetTarget;
    function GetManager: Ts0EntityManager; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure TargetOnChange(Sender: TObject); virtual;
    procedure TargetOnChangeID(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearCtrls;
    procedure LoadFromTarget;
    procedure SaveToTarget;
    procedure RemoveTarget;
    procedure NotifyUpdateToList;
    property DispTarget: Ts0Entity read GetDispTarget write SetDispTarget;
    property EditingMode: K0DetailDisplayMode read FEditingMode write SetEditingMode;
  published
    property OnChangeEditingMode: TNotifyEvent read FOnChangeEditingMode write FOnChangeEditingMode;
    property OnChangeTarget: TNotifyEvent read FOnChangeTarget write FOnChangeTarget;
    property OnChangeTargetID: TNotifyEvent read FOnChangeTargetID write FOnChangeTargetID;
    property OnClearCtrls: TNotifyEvent read FOnClearCtrls write FOnClearCtrls;
    property OnDetailRemove: TNotifyEvent read FOnDetailRemove write FOnDetailRemove;
    property OnDetailLoad: TNotifyEvent read FOnDetailLoad write FOnDetailLoad;
    property OnDetailSave: TNotifyEvent read FOnDetailSave write FOnDetailSave;
    property OnSetTarget: TNotifyEvent read FOnSetTarget write FOnSetTarget;
  end;

type
  Es0EntityDetailImpl = class(Exception);

implementation

uses
  s0EntityListImpl;

{ Ts0EntityDetailImpl }

procedure Ts0EntityDetailImpl.ClearCtrls;
begin
  DoClearCtrls;
end;

constructor Ts0EntityDetailImpl.Create(AOwner: TComponent);
begin
  inherited;
  FTargetChangeListener := Ts0EventListener.Create(TargetOnChange);
  FTargetChangeIDListener := Ts0EventListener.Create(TargetOnChangeID);
end;

destructor Ts0EntityDetailImpl.Destroy;
begin
  if FDispTarget <> nil then
    RemoveFreeNotification(FDispTarget);
  FreeAndNil(FTargetChangeListener);
  FreeAndNil(FTargetChangeIDListener);
  inherited;
end;

procedure Ts0EntityDetailImpl.DoChangeEditingMode;
begin
  if Assigned(FOnChangeEditingMode) then
    FOnChangeEditingMode(Self);
end;

procedure Ts0EntityDetailImpl.DoChangeTarget;
begin
  if Assigned(FOnChangeTarget) then
    FOnChangeTarget(Self);
end;

procedure Ts0EntityDetailImpl.DoChangeTargetID;
begin
  if Assigned(FOnChangeTargetID) then
    FOnChangeTargetID(Self);
end;

procedure Ts0EntityDetailImpl.DoClearCtrls;
begin
  if Assigned(FOnClearCtrls) then
    FOnClearCtrls(Self);
end;

procedure Ts0EntityDetailImpl.DoDetailLoad;
begin
  if Assigned(FOnDetailLoad) then
    FOnDetailLoad(Self);
end;

procedure Ts0EntityDetailImpl.DoDetailRemove;
begin
  if Assigned(FOnDetailRemove) then
    FOnDetailRemove(Self);
end;

procedure Ts0EntityDetailImpl.DoDetailSave;
begin
  if Assigned(FOnDetailSave) then
    FOnDetailSave(Self);
end;

procedure Ts0EntityDetailImpl.DoSetTarget;
begin
  if Assigned(FOnSetTarget) then
    FOnSetTarget(Self);
end;

function Ts0EntityDetailImpl.GetDispTarget: Ts0Entity;
begin
  Result := FDispTarget;
end;

function Ts0EntityDetailImpl.GetManager: Ts0EntityManager;
begin
  if FDispTarget <> nil then
    Result := FDispTarget.Manager
  else
    Result := inherited GetManager;
end;

procedure Ts0EntityDetailImpl.LoadFromTarget;
begin
  DoDetailLoad;
end;

procedure Ts0EntityDetailImpl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FDispTarget = AComponent then
  begin
    FDispTarget := nil;
    if csDesigning in Self.ComponentState then Exit;
    if OwnerForm <> nil then
      OwnerForm.Close;
  end;
end;

procedure Ts0EntityDetailImpl.NotifyUpdateToList;
  function getDispImpl(ACompo: TComponent): Ts0EntityDispImpl;
  var
    i: Integer;
  begin
    Result := nil;
    if ACompo = nil then Exit;
    for i := 0 to ACompo.ComponentCount -1 do
      if ACompo.Components[i] is Ts0EntityDispImpl then
      begin
        Result := Ts0EntityDispImpl(ACompo.Components[i]);
        Exit;
      end;
  end;
  //
  function getListImpl(ACompo: TComponent): Ts0EntityListImpl;
  var
    i: Integer;
  begin
    Result := nil;
    if ACompo = nil then Exit;
    for i := 0 to ACompo.ComponentCount -1 do
      if ACompo.Components[i] is Ts0EntityListImpl then
      begin
        Result := Ts0EntityListImpl(ACompo.Components[i]);
        Exit;
      end;
  end;
var
  dispImpl: Ts0EntityDispImpl;
  listImpl: Ts0EntityListImpl;
begin
  if OriginForm = nil then Exit;
  dispImpl := getDispImpl(OriginForm);
  if dispImpl = nil then Exit;
  if dispImpl is Ts0EntityDetailImpl then
  begin
    Ts0EntityDetailImpl(dispImpl).NotifyUpdateToList;
    Exit;
  end;
  listImpl := getListImpl(OriginForm);
  if listImpl = nil then Exit;
  listImpl.DetailSaved(DispTarget);
end;

procedure Ts0EntityDetailImpl.RemoveTarget;
begin
  if DispTarget = nil then Exit;
  DispTarget.Remove;
  NotifyUpdateToList;
end;

resourcestring
  c9ErrMsg_DispTargetIsNil = 'DispTargetプロパティがnilです';

procedure Ts0EntityDetailImpl.SaveToTarget;
begin
  if FDispTarget = nil then
    raise Es0EntityDetailImpl.Create(c9ErrMsg_DispTargetIsNil);
  FDispTarget.BeginUpdate;
  try
    DoDetailSave;
  finally
    FDispTarget.EndUpdate;
  end;
  FDispTarget.Save;
  NotifyUpdateToList;
end;

procedure Ts0EntityDetailImpl.SetDispTarget(const Value: Ts0Entity);
begin
  if FDispTarget <> nil then
  begin
    RemoveFreeNotification(FDispTarget);
    FDispTarget.OnChange.Detach(FTargetChangeListener);
    FDispTarget.OnChangeID.Detach(FTargetChangeIDListener);
  end;
  FDispTarget := Value;
  if FDispTarget <> nil then
  begin
    FreeNotification(FDispTarget);
    FDispTarget.OnChange.Attach(FTargetChangeListener);
    FDispTarget.OnChangeID.Attach(FTargetChangeIDListener);
  end;
//  LoadFromTarget;
  DoSetTarget;
end;

procedure Ts0EntityDetailImpl.SetEditingMode(
  const Value: K0DetailDisplayMode);
begin
  FEditingMode := Value;
  DoChangeEditingMode;
end;

procedure Ts0EntityDetailImpl.TargetOnChange(Sender: TObject);
begin
  DoChangeTarget;
end;

procedure Ts0EntityDetailImpl.TargetOnChangeID(Sender: TObject);
begin
  DoChangeTargetID;
end;

end.
 
