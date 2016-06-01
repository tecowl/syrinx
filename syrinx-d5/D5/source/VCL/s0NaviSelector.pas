unit s0NaviSelector;
{
$History: s0NaviSelector.pas $
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/03/25   Time: 16:39
 * Updated in $/D5/source/VCL
 * EntityListImplOptionEnabledプロパティのデフォルト値をTrueに変更
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/03/25   Time: 14:45
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/03/19   Time: 0:32
 * Updated in $/D5/source/VCL
 * ShowListメソッドで、フォームを表示できないときに例外を生成するようにし
 * た。
 * Destroyで、 Ts0CtrlEventSnatcherのUnRegisterListenerを行うようにした。
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/03/18   Time: 16:05
 * Updated in $/D5/source/VCL
 * BtnOnClickをvirtualにした
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/03/18   Time: 13:59
 * Updated in $/D5/source/VCL
 * s0CtrlEventSnatcherを使用して、ボタンのイベントを取得するようにした
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/03/14   Time: 4:23
 * Updated in $/D5/source/VCL
 * s0f0EntityDisplayユニットをusesから削除。代わりに、s0EntityDispImplユニ
 * ットを追加。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/01/21   Time: 22:43
 * Updated in $/source/D6VCLIntegrated
 * Ts0EntityManagerなどの仕様変更(Ts0EntityFormManagerの廃止)に対応。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/12/12   Time: 18:30
 * Updated in $/source/D5Integrated
 * BtnShowListに関連付けられたTButtonのOnClickイベント関係の修正
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/11/13   Time: 21:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/23   Time: 15:51
 * Updated in $/source/D5Integrated
 * 一覧のフォームを開くときに、入力されているIDでレコードを検索するように
 * した
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/09   Time: 9:09
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/05   Time: 13:04
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/09/23   Time: 1:08
 * Updated in $/source/D5Integrated
 * Ts0EntityFormManagerの表示系メソッドの引数の変更に伴い変更
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/03   Time: 4:59
 * Updated in $/source/D5Integrated
 * f0EntityDisplayなどのユニット名がs0f0EntityDisplayというように
 * 名称変更されたのでそれに対応した。
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0entity
 * p0entityひとまずOK。
 * しかし、汎用的なフォームのためにリファクタリングを思案中・・・
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/28   Time: 8:22
 * Updated in $/source/D5/p0entity
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/27   Time: 20:03
 * Created in $/source/D5/p0entity
 * 新規作成
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  s0VCLClasses,
  s0CtrlEventSnatcher,
  s0Entity,
  s0EntityDispImpl,
  s0EntityListImpl;

type
  {
    EntityのIDとCaptionをリストから選択するための非表示コンポーネント。
    表示/入力のためにID、CaptionそれぞれにTCustomEditを、
    リスト表示を行うためにTButtonを割り当てることができる。    
  }
  Ts0NaviSelector = class(Ts0VCLComponent)
  private
    FModalList: Boolean;
    FNaviCaption: string;
    FNaviID: Integer;
    FTargetNavi: Ts0EntityNavi;
    FNaviEntityClassName: string;
    FNaviEntityClass: Ts0EntityClass;
    FBtnShowList: TButton;
    FCtrlCaption: TCustomEdit;
    FCtrlID: TCustomEdit;
    FNotFoundOptionOnList: K0NotFoundOnListOption;
    FBtnListener: Ts0CtrlEventListener;
    FEntityListImplOption: K0EntityListOptionSet;
    FEntityListImplOptionEnabled: Boolean;
    function GetNaviCaption: string;
    function GetNaviID: Integer;
    procedure SetNaviCaption(const Value: string);
    procedure SetNaviID(const Value: Integer);
    procedure SetTargetNavi(const Value: Ts0EntityNavi);
    procedure SetNaviEntityClassName(const Value: string);
    procedure SetNaviEntityClass(const Value: Ts0EntityClass);
    procedure SetBtnShowList(const Value: TButton);
    procedure SetCtrlCaption(const Value: TCustomEdit);
    procedure SetCtrlID(const Value: TCustomEdit);
    procedure SetEntityListImplOption(const Value: K0EntityListOptionSet);
    procedure SetEntityListImplOptionEnabled(const Value: Boolean);
  protected
    function FindImpList(ACompo: TComponent): Ts0EntityListImpl;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure ListFormOnCreate(Sender: TObject; ADisplay: TCustomForm);
    procedure ListFormOnShow(Sender: TObject; ADisplay: TCustomForm);
    procedure ListFormOnDecide(Sender: TObject);
    procedure BtnOnClick(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowList(ACurrentID: Integer = 0): Integer;
    //表示しているエンティティのIDを表す。
    property NaviID: Integer read GetNaviID write SetNaviID;
    //表示しているキャプションを表す。
    property NaviCaption: string read GetNaviCaption write SetNaviCaption;
    //対象となるエンティティのナビゲータへの参照。
    property TargetNavi: Ts0EntityNavi read FTargetNavi write SetTargetNavi;
    //対象となるエンティティのクラス参照
    property NaviEntityClass: Ts0EntityClass read FNaviEntityClass write SetNaviEntityClass;
    //対象となるエンティティのナビゲータにIDとキャプションを設定するメソッド
    procedure SaveToTarget;
  published
    //リストを表示するアクションを受け付けるボタンへの参照。
    property BtnShowList: TButton read FBtnShowList write SetBtnShowList;
    //IDを表示/入力するアクションを受け付けるエディットへの参照。
    property CtrlID: TCustomEdit read FCtrlID write SetCtrlID;
    //Captionを表示/入力するアクションを受け付けるエディットへの参照。
    property CtrlCaption: TCustomEdit read FCtrlCaption write SetCtrlCaption;
    //リストをモード付きで表示するかどうかを指定する
    property ModalList: Boolean read FModalList write FModalList default False;
    {
      対象となるエンティティのクラスの名称を指定する。
      このプロパティを設計時に指定しておくと、実行時にNaviEntityClassが自動的に
      設定される。
    }
    property NaviEntityClassName: string read FNaviEntityClassName write SetNaviEntityClassName;
    {
       K0NotFoundOnListOption = (k0leoNone, k0leoFirst, k0leoLast);
       リストを表示するときに、IDで指定されたレコードが見つからなかった場合に、
       どのレコードをカーソルを合わせるのかを指定する。
       k0leoNone : 何もしない
       k0leoFirst: 最初のレコード
       k0leoLast : 最後のレコード
    }
    property NotFoundOptionOnList: K0NotFoundOnListOption
      read FNotFoundOptionOnList write FNotFoundOptionOnList default k0leoNone;
    {
      K0EntityListOption = (
        k0eloCloseFormOnDecide,  // Decide(通常ダブルクリック)した時に一覧フォームを閉じる
        k0eloShowDetailOnDecide, // Decide(通常ダブルクリック)した時にSelectedプロパティで示されるエンティティの詳細フォームを開く
        k0eloLoadKeyOnMove,      // レコードを移動したときにSelectedプロパティで示されるエンティティのLoadKeyメソッドを行う
        k0eloLoadOnMove,         // レコードを移動したときにSelectedプロパティで示されるエンティティのLoadメソッドを行う
        k0eloRefreshOnDetailSave // 詳細フォームでエンティティが保存されたときに一覧フォームを更新する。
      );
      K0EntityListOptionSet = set of K0EntityListOption;
      表示するリストのTs0EntityListImplのOptionプロパティを指定する。
    }
    property EntityListImplOption: K0EntityListOptionSet read FEntityListImplOption write SetEntityListImplOption
      default [k0eloCloseFormOnDecide, k0eloLoadKeyOnMove, k0eloRefreshOnDetailSave];
    {
      EntityListImplOptionプロパティが有効かどうかを指定できるプロパティ
    }
    property EntityListImplOptionEnabled: Boolean read FEntityListImplOptionEnabled
      write SetEntityListImplOptionEnabled default True;
  end;

type
  Es0NaviSelector = class(Exception);

implementation

uses
  s0EntityFormManager;

type
  Ts9NaviBtnListener = class(Ts0CtrlEventListener)
  private
    FOwner: Ts0NaviSelector;
  public
    constructor Create(AOwner: Ts0NaviSelector);
    procedure CtrlOnClick(Sender: TObject); override;
  end;

{ Ts9NaviBtnListener }

constructor Ts9NaviBtnListener.Create(AOwner: Ts0NaviSelector);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure Ts9NaviBtnListener.CtrlOnClick(Sender: TObject);
begin
  FOwner.BtnOnClick(Sender);
end;

{ Ts0NaviSelector }

procedure Ts0NaviSelector.BtnOnClick(Sender: TObject);
begin      
  ShowList;
end;

constructor Ts0NaviSelector.Create(AOwner: TComponent);
begin
  inherited;
  FModalList := False;
  if csDesigning in Self.ComponentState then Exit;
  FBtnListener := Ts9NaviBtnListener.Create(Self);
  FEntityListImplOption := [k0eloCloseFormOnDecide, k0eloLoadKeyOnMove, k0eloRefreshOnDetailSave];
  FEntityListImplOptionEnabled := True;
end;

destructor Ts0NaviSelector.Destroy;
begin
  if FBtnListener <> nil then
    Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FBtnListener);
  FreeAndNil(FBtnListener);
  BtnShowList := nil;
  CtrlID := nil;
  CtrlCaption := nil;
  inherited;
end;

function Ts0NaviSelector.FindImpList(ACompo: TComponent): Ts0EntityListImpl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ACompo.ComponentCount -1 do
    if ACompo.Components[i] is Ts0EntityListImpl then
    begin
      Result := Ts0EntityListImpl(ACompo.Components[i]);
      Exit;
    end;
end;

function Ts0NaviSelector.GetNaviCaption: string;
begin
  Result := FNaviCaption;
  if FCtrlCaption = nil then Exit;
  Result := FCtrlCaption.Text;
end;

function Ts0NaviSelector.GetNaviID: Integer;
begin
  Result := FNaviID;
  if FCtrlID = nil then Exit;
  Result := StrToIntDef(FCtrlID.Text, -1);
end;

procedure Ts0NaviSelector.ListFormOnCreate(Sender: TObject;
  ADisplay: TCustomForm);
var
  impl: Ts0EntityListImpl;
begin
  impl := FindImpList(ADisplay);
  if impl = nil then Exit;
  if FEntityListImplOptionEnabled then
    impl.Options := FEntityListImplOption;
  impl.OnDecide := ListFormOnDecide;
end;

procedure Ts0NaviSelector.ListFormOnDecide(Sender: TObject);
begin
  if not(Sender is Ts0EntityListImpl) then Exit;
  NaviID := Ts0EntityListImpl(Sender).Selected.ID;
  NaviCaption := Ts0EntityListImpl(Sender).Selected.Caption;
end;

procedure Ts0NaviSelector.ListFormOnShow(Sender: TObject;
  ADisplay: TCustomForm);
  function GetListImpl(ACompo: TComponent): Ts0EntityListImpl;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to ACompo.ComponentCount -1 do
      if ACompo.Components[i] is Ts0EntityListImpl then
      begin
        Result := Ts0EntityListImpl( ACompo.Components[i] );
        Exit;
      end;
  end;
var
  listDisp: Ts0EntityListImpl;
begin
  if ADisplay = nil then Exit;
  listDisp := GetListImpl( ADisplay );
  if listDisp = nil then Exit;
  listDisp.LocateEntityByID( Self.NaviID, FNotFoundOptionOnList );
end;

procedure Ts0NaviSelector.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FCtrlCaption = AComponent then FCtrlCaption := nil;
  if FCtrlID = AComponent then FCtrlID := nil;
  if FBtnShowList = AComponent then FBtnShowList := nil;
end;

procedure Ts0NaviSelector.SaveToTarget;
begin
  if FTargetNavi = nil then Exit;
  FTargetNavi.TargetID := Self.NaviID;
  FTargetNavi.TargetCaption := Self.NaviCaption;
end;

procedure Ts0NaviSelector.SetBtnShowList(const Value: TButton);
begin
  if FBtnShowList = Value then Exit;
  if csDesigning in Self.ComponentState then
  begin
    FBtnShowList := Value;
  end
  else
  begin
    if FBtnShowList <> nil then
      Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FBtnListener);
    FBtnShowList := Value;
    if FBtnShowList <> nil then
      Ts0CtrlEventSnatcher.Instance.RegisterListener(FBtnShowList, FBtnListener);
  end;
end;

procedure Ts0NaviSelector.SetCtrlCaption(const Value: TCustomEdit);
begin
  FCtrlCaption := Value;
end;

procedure Ts0NaviSelector.SetCtrlID(const Value: TCustomEdit);
begin
  FCtrlID := Value;
end;

procedure Ts0NaviSelector.SetEntityListImplOption(
  const Value: K0EntityListOptionSet);
begin
  FEntityListImplOption := Value;
end;

procedure Ts0NaviSelector.SetEntityListImplOptionEnabled(
  const Value: Boolean);
begin
  FEntityListImplOptionEnabled := Value;
end;

procedure Ts0NaviSelector.SetNaviCaption(const Value: string);
begin
  FNaviCaption := Value;
  if FCtrlCaption = nil then Exit;
  FCtrlCaption.Text := Value;
end;

procedure Ts0NaviSelector.SetNaviEntityClass(const Value: Ts0EntityClass);
begin
  FNaviEntityClass := Value;
  if FNaviEntityClass <> nil then
    FNaviEntityClassName := FNaviEntityClass.ClassName
  else
    FNaviEntityClassName := '';
end;

procedure Ts0NaviSelector.SetNaviEntityClassName(const Value: string);
begin
  FNaviEntityClassName := Value;
  if csDesigning in Self.ComponentState then Exit;
  FNaviEntityClass := Ts0EntityRegister.GetEntityClassByName(Value);
end;

procedure Ts0NaviSelector.SetNaviID(const Value: Integer);
begin
  FNaviID := Value;
  if FCtrlID = nil then Exit;
  FCtrlID.Text := IntToStr(Value);
end;

procedure Ts0NaviSelector.SetTargetNavi(const Value: Ts0EntityNavi);
begin
  FTargetNavi := Value;
  if FTargetNavi = nil then
  begin
    if FCtrlID <> nil then FCtrlID.Text := '';
    if FCtrlCaption <> nil then FCtrlCaption.Text := '';
  end
  else
  begin
    Self.NaviID := FTargetNavi.TargetID;
    Self.NaviCaption := FTargetNavi.TargetCaption;
  end;
end;

resourcestring
  c9ErrMsg_NaviEntityClassIsNil =
    'NaviEntityClassがnilです。' +
    'NaviEntityClassあるいはNaviEntityClassNameを正しく設定してください。';
  c9ErrMsg_FormManagerNotFound = 'Ts0EntityFormManagerが登録されていません。';
  c9ErrMsg_NoFormMatched = '%sを表示できる適切なフォームが見つかりませんでした。';

function Ts0NaviSelector.ShowList(ACurrentID: Integer): Integer;
var
  disp: Ts0EntityFormManager;
  frm: TCustomForm;
  item: Ts0EntityDisplayItem;
begin
  Result := mrCancel;
  if NaviEntityClass = nil then
    raise Es0NaviSelector.Create(c9ErrMsg_NaviEntityClassIsNil);

  if not(Ts0EntityDisplay.Instance is Ts0EntityFormManager) then Exit;
  disp := Ts0EntityFormManager(Ts0EntityDisplay.Instance);
  if disp = nil then
    raise Es0NaviSelector.Create(c9ErrMsg_FormManagerNotFound);

  if Self.Owner is TCustomForm then
    frm := TCustomForm(Self.Owner)
  else
    frm := nil;

  item := disp.NeedDispItem(NaviEntityClass, k0dtList);
  if item = nil then 
    raise Es0NaviSelector.CreateFmt(c9ErrMsg_NoFormMatched, [NaviEntityClass.GetClassCaption]);
  if not ModalList then
    item.Show(nil, frm, k0ddmEdit, ListFormOnCreate, ListFormOnShow, NaviEntityClass)
  else
    Result := item.ShowModal(nil, frm, k0ddmEdit, ListFormOnCreate, ListFormOnShow, NaviEntityClass);
end;

end.
