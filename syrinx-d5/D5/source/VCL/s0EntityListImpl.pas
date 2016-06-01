unit s0EntityListImpl;
{
$History: s0EntityListImpl.pas $
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/03/25   Time: 16:39
 * Updated in $/D5/source/VCL
 * K0EntityListOptionにコメントを追加
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/03/14   Time: 4:23
 * Updated in $/D5/source/VCL
 * s0f0EntityDisplayユニットをusesから削除。代わりに、s0EntityDispImplユニ
 * ットを追加。
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/11/13   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/23   Time: 15:48
 * Updated in $/source/D5Integrated
 * FindEntityByIDメソッドを追加
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/23   Time: 1:20
 * Updated in $/source/D5Integrated
 * FindEntityを実装
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/22   Time: 22:38
 * Updated in $/source/D5Integrated
 * DetailSaved、FindEntityメソッドを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/17   Time: 12:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/15   Time: 11:30
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/09   Time: 9:08
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/02   Time: 3:18
 * Updated in $/source/D5Integrated
 * ShowSelectedDetailに引数を追加。
 * ModalやEditingModeを指定できる。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/03   Time: 4:59
 * Updated in $/source/D5Integrated
 * f0EntityDisplayなどのユニット名がs0f0EntityDisplayというように
 * 名称変更されたのでそれに対応した。
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 12:52
 * Updated in $/source/D5/p0entity
 * Entity関係の作成を一時中断。
 * パッケージの再構築時にエラーが出ることが多いので、そっちを先に対応予定
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
  K0EntityListOption = (
    k0eloCloseFormOnDecide,  // Decide(通常ダブルクリック)した時に一覧フォームを閉じる
    k0eloShowDetailOnDecide, // Decide(通常ダブルクリック)した時にSelectedプロパティで示されるエンティティの詳細フォームを開く
    k0eloLoadKeyOnMove,      // レコードを移動したときにSelectedプロパティで示されるエンティティのLoadKeyメソッドを行う
    k0eloLoadOnMove,         // レコードを移動したときにSelectedプロパティで示されるエンティティのLoadメソッドを行う
    k0eloRefreshOnDetailSave // 詳細フォームでエンティティが保存されたときに一覧フォームを更新する。
  );
  K0EntityListOptionSet = set of K0EntityListOption;

type
  Ts0EntityListImpl = class(Ts0EntityDispImpl)
  private
    FAfterRefreshList: TNotifyEvent;
    FBeforeRefreshList: TNotifyEvent;
    FOnDecide: TNotifyEvent;
    FOnMoveSelected: TNotifyEvent;
    FSelected: Ts0Entity;
    FOptions: K0EntityListOptionSet;
    FModeOfShowSelected: K0DetailDisplayMode;
    function GetSelected: Ts0Entity;
    procedure SetOptions(const Value: K0EntityListOptionSet);
  protected
    procedure DoAfterRefreshList;
    procedure DoBeforeRefreshList;
    procedure DoDecide;
    procedure DoMoveSelected;
    function GetManager: Ts0EntityManager; override;
  public
    procedure Decide; virtual;
    procedure MoveSelected; virtual;
    procedure RefreshList; virtual;
    procedure CloseForm;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DetailSaved(AEntity: Ts0Entity);
    function LocateEntity(AEntity: Ts0Entity;
      AOption: K0NotFoundOnListOption = k0leoNone): Boolean;
    function LocateEntityByID(AEntityID: Integer;
      AOption: K0NotFoundOnListOption = k0leoNone): Boolean;
    procedure ShowSelectedDetail(AMode: K0DetailDisplayMode = k0ddmReadOnly; AModal: Boolean = False); virtual;
    property Selected: Ts0Entity read GetSelected;
  published
    property Options: K0EntityListOptionSet read FOptions write SetOptions
      default [k0eloShowDetailOnDecide, k0eloLoadKeyOnMove, k0eloRefreshOnDetailSave];
    property AfterRefreshList: TNotifyEvent read FAfterRefreshList write FAfterRefreshList;
    property BeforeRefreshList: TNotifyEvent read FBeforeRefreshList write FBeforeRefreshList;
    property ModeOfShowSelected: K0DetailDisplayMode read FModeOfShowSelected write FModeOfShowSelected default k0ddmReadOnly;
    property OnMoveSelected: TNotifyEvent read FOnMoveSelected write FOnMoveSelected;
    property OnDecide: TNotifyEvent read FOnDecide write FOnDecide;
  end;

implementation

{ Ts0EntityListImpl }

procedure Ts0EntityListImpl.CloseForm;
begin
  if OwnerForm <> nil then
    OwnerForm.Close;
end;

constructor Ts0EntityListImpl.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [k0eloShowDetailOnDecide, k0eloLoadKeyOnMove, k0eloRefreshOnDetailSave];
  FModeOfShowSelected := k0ddmReadOnly;
end;

procedure Ts0EntityListImpl.Decide;
begin
  DoDecide;
  if k0eloShowDetailOnDecide in FOptions then
    ShowSelectedDetail(FModeOfShowSelected);
  if k0eloCloseFormOnDecide in FOptions then
     CloseForm;
end;

procedure Ts0EntityListImpl.DetailSaved(AEntity: Ts0Entity);
var
  budID: Integer;
begin
  if k0eloRefreshOnDetailSave in FOptions then
  begin
    if AEntity = nil then
    begin
      RefreshList;
      Exit;
    end;
    //
    AEntity.BeginUpdate;
    try
      budID := AEntity.ID;
      try
        RefreshList;
      finally
        AEntity.ID := budID;
      end;
    finally
      AEntity.EndUpdate;
    end;
    if AEntity <> nil then
      LocateEntity(AEntity);
  end;
end;

procedure Ts0EntityListImpl.DoAfterRefreshList;
begin
  if Assigned(FAfterRefreshList) then
    FAfterRefreshList(Self);
end;

procedure Ts0EntityListImpl.DoBeforeRefreshList;
begin
  if Assigned(FBeforeRefreshList) then
    FBeforeRefreshList(Self);
end;

procedure Ts0EntityListImpl.DoDecide;
begin
  if Assigned(FOnDecide) then
    FOnDecide(Self);
end;

procedure Ts0EntityListImpl.DoMoveSelected;
begin
  if Assigned(FOnMoveSelected) then
    FOnMoveSelected(Self);
end;

function Ts0EntityListImpl.GetManager: Ts0EntityManager;
begin
  Result := inherited GetManager;
end;

function Ts0EntityListImpl.GetSelected: Ts0Entity;
begin
  if FSelected = nil then
    FSelected := Manager.NewEntity(Self);
  Result := FSelected;
end;

function Ts0EntityListImpl.LocateEntity(AEntity: Ts0Entity;
  AOption: K0NotFoundOnListOption): Boolean;
begin
  Result := False;
  if AEntity = nil then Exit;
//  if not(AEntity.Manager is Ts0DBEntityManager) then Exit;
//  Result := Ts0DBEntityManager(AEntity.Manager).LocateEntityOnList(AEntity.ID, AOption);
  Result := AEntity.Manager.LocateEntityOnList(AEntity.ID, AOption);
end;

function Ts0EntityListImpl.LocateEntityByID(AEntityID: Integer;
  AOption: K0NotFoundOnListOption): Boolean;
begin
//  Result := False;
//  if not(Manager is Ts0DBEntityManager) then Exit;
//  Result := Ts0DBEntityManager(Manager).LocateEntityOnList(AEntityID, AOption);
  Result := Manager.LocateEntityOnList(AEntityID, AOption);
end;

procedure Ts0EntityListImpl.MoveSelected;
begin
  if k0eloLoadKeyOnMove in FOptions then
    Selected.LoadKey;
  if k0eloLoadOnMove in FOptions then
    Selected.Load;
  DoMoveSelected;
end;

procedure Ts0EntityListImpl.RefreshList;
begin
  DoBeforeRefreshList;
  Manager.RefreshList;
  DoAfterRefreshList;
end;

procedure Ts0EntityListImpl.SetOptions(const Value: K0EntityListOptionSet);
begin
  FOptions := Value;
end;

procedure Ts0EntityListImpl.ShowSelectedDetail(AMode: K0DetailDisplayMode; AModal: Boolean);
begin
  Selected.LoadKey;
  if AMode = k0ddmNewEntity then
    Selected.Clear
  else
    Selected.Load;
  Selected.ShowDetail(AModal, OwnerForm, AMode);
end;

end.
 
