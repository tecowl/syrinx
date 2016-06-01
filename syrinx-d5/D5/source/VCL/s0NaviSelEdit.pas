{-----------------------------------------------------------------------------
 Unit Name: s0NaviSelEdit
 Author:    akima
 Purpose:
 TestCase: tc_s0NaviSelEdit
 $History: s0NaviSelEdit.pas $
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/03/25   Time: 16:39
 * Updated in $/D5/source/VCL
 * EntityListImplOptionEnabledプロパティのデフォルト値をTrueに変更
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/03/25   Time: 14:45
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/03/18   Time: 16:06
 * Updated in $/D5/source/VCL
 * Ts0NaviSelectorから派生したクラスでOnBtnClickイベントを起こすようにした
 * 。
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/03/18   Time: 13:59
 * Updated in $/D5/source/VCL
 * OnClickイベントを追加。
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/02/14   Time: 23:44
 * Updated in $/source/D5Integrated
 * ParentFontをTs0NaviEditItemEditとTs0NaviEditItemBtnに追加
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/12/12   Time: 20:55
 * Updated in $/source/D5Integrated
 * InputController -> InputStyle
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/12/12   Time: 14:11
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/12/12   Time: 3:51
 * Updated in $/source/D5Integrated
 * CCC(Ts0CustomComplexCtrl)を継承する形に修正。
 * 結構すっきりした。
-----------------------------------------------------------------------------}

unit s0NaviSelEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  s0CustomComplexCtrl,
  s0Entity,
  s0DataAccessor,
  s0CtrlDistiller,
  s0EntityListImpl,
  s0NaviSelector,
  s0DigitEdit,
  s0Edit;

type
  {
    Ts0NaviEditを構成するID/Captionのエディットコントロールのプロパティに
    アクセスするためのクラスです。
    このクラス自身はエディットではありません。
  }
  Ts0NaviEditItemEdit = class(Ts0CCCItem)
  published
    property Align;
    property Color;
    property Enabled;
    property Font;
    property Left;
    property ParentFont;
    property ReadOnly;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property Width;
  end;

  {
    Ts0NaviEditを構成するボタンコントロールのプロパティに
    アクセスするためのクラスです。
    このクラス自身はボタンではありません。
  }
  Ts0NaviEditItemBtn = class(Ts0CCCItem)
  published
    property Align;
    property Caption;
    property Enabled;
    property Font;
    property Left;
    property ParentFont;
    property TabOrder;
    property TabStop;
    property Visible;
    property Width;
  end;

type
  Ts0NaviEdit = class;

  {
    Ts0NaviEditのデータにアクセスするためのAccessor。
    AsIntegerプロパティはIDの値を、AsStringプロパティはCaptionの値を表す。
  }
  Ts0NaviEditAccessor = class(Ts0DataAccessor)
  private
    function GetOwnerNaviEdit: Ts0NaviEdit;
  protected
    function GetAsInteger: Integer; override;
    function GetAsString: String; override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: String); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  K0NaviEditCtrlKind = (k0neckID, k0neckCaption, k0neckBtn);
  K0NaviEditCtrlKindSet = set of K0NaviEditCtrlKind;

  K0NaviEditNotifyEvent = procedure(Sender: TObject; AKind: K0NaviEditCtrlKind) of object;

  Ts0NaviEdit = class(Ts0CustomComplexCtrl)
  private
    FSelector: Ts0NaviSelector;
    FEdtID: Ts0DigitEdit;
    FEdtCaption: Ts0Edit;
    FBtnShowList: TButton;
    FAccessor: Ts0NaviEditAccessor;
    FEditOfCaption: Ts0NaviEditItemEdit;
    FEditOfID: Ts0NaviEditItemEdit;
    FBtnOfList: Ts0NaviEditItemBtn;
    FActivePartKind: K0NaviEditCtrlKind;
    FOnBtnClick: TNotifyEvent;
    function GetEntityListImplOptionEnabled: Boolean;
    procedure SetEntityListImplOptionEnabled(const Value: Boolean);
    function GetEntityListImplOption: K0EntityListOptionSet;
    procedure SetEntityListImplOption(const Value: K0EntityListOptionSet);
  private
    function GetAccessor: Ts0NaviEditAccessor;
    function GetNaviCaption: String;
    function GetNaviID: Integer;
  private
    { for FSelector }
    function GetBtnShowList: TButton;
    function GetCtrlCaption: TCustomEdit;
    function GetCtrlID: TCustomEdit;
    function GetModalList: Boolean;
    function GetNaviEntityClassName: string;
    function GetNotFoundOptionOnList: K0NotFoundOnListOption;
    procedure SetModalList(const Value: Boolean);
    procedure SetNaviCaption(const Value: String);
    procedure SetNaviEntityClassName(const Value: string);
    procedure SetNaviID(const Value: Integer);
    procedure SetNotFoundOptionOnList(const Value: K0NotFoundOnListOption);
  private
    procedure SetEditOfCaption(const Value: Ts0NaviEditItemEdit);
    procedure SetEditOfID(const Value: Ts0NaviEditItemEdit);
  protected
    function CanDoCtrlEvent(AEventKind: K0CCCPartEventKind; Sender: TObject): Boolean; override;
    procedure RestoreActiveControlKind(Sender: TObject);
  protected
    function NewNaviSelector: Ts0NaviSelector; virtual;
    procedure CanvasBrushChanged(Sender: TObject);
    procedure CreateCtrls; override;
    procedure CtrlInOrder;
    procedure FontChanged;
    property Selector: Ts0NaviSelector read FSelector;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetNaviData(ANavi: Ts0EntityNavi);
    property ActivePartKind: K0NaviEditCtrlKind read FActivePartKind;
    property Accessor: Ts0NaviEditAccessor read GetAccessor;
    property BtnShowList: TButton read GetBtnShowList;
    property CtrlID: TCustomEdit read GetCtrlID;
    property CtrlCaption: TCustomEdit read GetCtrlCaption;
  published
    property ModalList: Boolean read GetModalList write SetModalList default True;
    property NaviEntityClassName: string read GetNaviEntityClassName write SetNaviEntityClassName;
    property NaviID: Integer read GetNaviID write SetNaviID stored False;
    property NaviCaption: String read GetNaviCaption write SetNaviCaption stored False;
    property NotFoundOptionOnList: K0NotFoundOnListOption
      read GetNotFoundOptionOnList write SetNotFoundOptionOnList default k0leoNone;
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
    property EntityListImplOption: K0EntityListOptionSet read GetEntityListImplOption write SetEntityListImplOption
      default [k0eloCloseFormOnDecide, k0eloLoadKeyOnMove, k0eloRefreshOnDetailSave];
    {
      EntityListImplOptionプロパティが有効かどうかを指定できるプロパティ
    }
    property EntityListImplOptionEnabled: Boolean read GetEntityListImplOptionEnabled
      write SetEntityListImplOptionEnabled default True;
  published
    property Color;
    property Enabled;
    property Font;
    property TabOrder;
    property TabStop;
  published
    property EditOfID: Ts0NaviEditItemEdit read FEditOfID write SetEditOfID;
    property EditOfCaption: Ts0NaviEditItemEdit read FEditOfCaption write SetEditOfCaption;
    property BtnOfList: Ts0NaviEditItemBtn read FBtnOfList write FBtnOfList;
    property OnBtnClick: TNotifyEvent read FOnBtnClick write FOnBtnClick;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnChange;
    property OnPartEnter;
    property OnPartExit;
  end;

type
  Ts0NaviEditDistiller = class(Ts0CtrlDistiller)
  public
    class function IsTarget(AControl: TObject): Boolean; override;
    class function GetUpdateEvents(AControl: TObject): K0CtrlEventTypeSet; override;
    class function GetFocusEvents(AControl: TObject): R0FocusEvents; override;
    class function GetMouseEvents(AControl: TObject): R0MouseEvents; override;
    class function GetKeyEvents(AControl: TObject): R0KeyEvents    ; override;
    class function GetSizeEvents(AControl: TObject): R0SizeEvents  ; override;
    class procedure SetFocusEvents(Value: R0FocusEvents; AControl: TObject); override;
    class procedure SetMouseEvents(Value: R0MouseEvents; AControl: TObject); override;
    class procedure SetKeyEvents(Value: R0KeyEvents; AControl: TObject); override;
    class procedure SetSizeEvents(Value: R0SizeEvents; AControl: TObject); override;
    class function GetValue(AControl: TObject): string; override;
    class procedure SetValue(Value: string; AControl: TObject); override;
    class function GetAccessor(AControl: TObject): Ts0DataAccessor; override;
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

procedure Register;

implementation

uses
  s0ComponentHelper;
procedure Register;
begin
  RegisterComponents('P Entity', [Ts0NaviEdit]);
end;

type
  Ts9NaviSelector = class(Ts0NaviSelector)
  private
    FOwnerEdit: Ts0NaviEdit;
  protected
    procedure BtnOnClick(Sender: TObject); override;
  end;

{ Ts9NaviSelector }

procedure Ts9NaviSelector.BtnOnClick(Sender: TObject);
begin
  if FOwnerEdit <> nil then
    if Assigned(FOwnerEdit.FOnBtnClick) then
      FOwnerEdit.FOnBtnClick(Self);
  inherited BtnOnClick(Sender);
end;

{ Ts0NaviEditAccessor }

constructor Ts0NaviEditAccessor.Create(AOwner: TComponent);
begin
  inherited;
end;

function Ts0NaviEditAccessor.GetAsInteger: Integer;
begin
  Result := GetOwnerNaviEdit.NaviID;
end;

function Ts0NaviEditAccessor.GetAsString: String;
begin
  Result := GetOwnerNaviEdit.NaviCaption;
end;

function Ts0NaviEditAccessor.GetOwnerNaviEdit: Ts0NaviEdit;
begin
  Result := Ts0NaviEdit(Owner);
end;

procedure Ts0NaviEditAccessor.SetAsInteger(const Value: Integer);
begin
  GetOwnerNaviEdit.NaviID := Value;
end;

procedure Ts0NaviEditAccessor.SetAsString(const Value: String);
begin
  GetOwnerNaviEdit.NaviCaption := Value;
end;

{ Ts0NaviEdit }

function Ts0NaviEdit.CanDoCtrlEvent(AEventKind: K0CCCPartEventKind;
  Sender: TObject): Boolean;
begin
  Result := inherited CanDoCtrlEvent(AEventKind, Sender);
  RestoreActiveControlKind(Sender);
end;

procedure Ts0NaviEdit.CanvasBrushChanged(Sender: TObject);
begin
  FEdtID.Color := Canvas.Brush.Color;
  FEdtCaption.Color := Canvas.Brush.Color;
end;

constructor Ts0NaviEdit.Create(AOwner: TComponent);
begin
  FSelector := NewNaviSelector;
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks, csReplicatable];
  Width := 200;
  Height := 25;
  ModalList := True;
end;

procedure Ts0NaviEdit.CreateCtrls;
begin
  FEdtID := Ts0DigitEdit.Create(Self);
  FEdtID.Parent := Self;
  FEdtID.Name := 'edtNaviSelID';
  FEdtID.Align := alLeft;
  FEdtID.Left := 0;
  FEdtID.Width := 36;
  FEdtID.AsInteger := 0;
  FEdtID.TabOrder := 0;
  FEditOfID := Ts0NaviEditItemEdit.Create(Self, CCCItems, FEdtID);
  //
  Self.Height := FEdtID.Height + 4;
  //
  FEdtCaption := Ts0Edit.Create(Self);
  FEdtCaption.Parent := Self;
  FEdtCaption.Name := 'edtNaviSelCaption';
  FEdtCaption.Width := 144;
  FEdtCaption.Align := alClient;
  FEdtCaption.Text := '';
  FEdtCaption.TabOrder := 1;
  FEditOfCaption := Ts0NaviEditItemEdit.Create(Self, CCCItems, FEdtCaption);
  //
  FBtnShowList := TButton.Create(Self);
  FBtnShowList.Parent := Self;
  FBtnShowList.Name := 'btnNaviSelShowList';
  FBtnShowList.Width := 20;
  FBtnShowList.Caption := '･･･';
  FBtnShowList.TabOrder := 2;
  FBtnShowList.Align := alRight;
  FBtnOfList := Ts0NaviEditItemBtn.Create(Self, CCCItems, FBtnShowList);
  FBtnOfList.Ignorance := [k0c3pkColor];
  //
  FSelector.CtrlID := FEdtID;
  FSelector.CtrlCaption := FEdtCaption;
  FSelector.BtnShowList := FBtnShowList;
end;

procedure Ts0NaviEdit.CtrlInOrder;
begin
  if FEdtID = nil then Exit;
  if FEdtCaption = nil then Exit;
  if FBtnShowList = nil then Exit;
  if FBtnShowList.Visible then FBtnShowList.Left := -1; 
  if FEdtCaption.Visible then FEdtCaption.Left := -1;
  if FEdtID.Visible then FEdtID.Left := -1;
end;

destructor Ts0NaviEdit.Destroy;
begin
  FreeAndNil(FAccessor);
  FreeAndNil( FSelector );
  inherited Destroy;
end;

procedure Ts0NaviEdit.FontChanged;
begin
  FEdtID.Font := Self.Canvas.Font;
  FEdtCaption.Font := Self.Canvas.Font;
end;

function Ts0NaviEdit.GetAccessor: Ts0NaviEditAccessor;
begin
  if FAccessor = nil then
    FAccessor := Ts0NaviEditAccessor.Create(Self);
  Result := FAccessor;
end;

function Ts0NaviEdit.GetBtnShowList: TButton;
begin
  Result := FSelector.BtnShowList;
end;

function Ts0NaviEdit.GetCtrlCaption: TCustomEdit;
begin
  Result := FSelector.CtrlCaption;
end;

function Ts0NaviEdit.GetCtrlID: TCustomEdit;
begin
  Result := FSelector.CtrlID;
end;

function Ts0NaviEdit.GetEntityListImplOption: K0EntityListOptionSet;
begin
  Result := FSelector.EntityListImplOption;
end;

function Ts0NaviEdit.GetEntityListImplOptionEnabled: Boolean;
begin
  Result := FSelector.EntityListImplOptionEnabled;
end;

function Ts0NaviEdit.GetModalList: Boolean;
begin
  Result := FSelector.ModalList;
end;

function Ts0NaviEdit.GetNaviCaption: String;
begin
  Result := FEdtCaption.Text;
end;

function Ts0NaviEdit.GetNaviEntityClassName: string;
begin
  Result := FSelector.NaviEntityClassName;
end;

function Ts0NaviEdit.GetNaviID: Integer;
begin
  Result := FEdtID.AsInteger;
end;

function Ts0NaviEdit.GetNotFoundOptionOnList: K0NotFoundOnListOption;
begin
  Result := FSelector.NotFoundOptionOnList;
end;

function Ts0NaviEdit.NewNaviSelector: Ts0NaviSelector;
begin
  Result := Ts9NaviSelector.Create(nil);
  Ts9NaviSelector(Result).FOwnerEdit := Self;
end;

procedure Ts0NaviEdit.RestoreActiveControlKind(Sender: TObject);
  function SenderToKind(ASender: TObject): K0NaviEditCtrlKind;
  begin
    Result := k0neckID;
    if ASender = FEdtID then
      Result := k0neckID
    else
    if ASender = FEdtCaption then
      Result := k0neckCaption
    else
    if ASender = FBtnShowList then
      Result := k0neckBtn;
  end;
begin
  FActivePartKind := SenderToKind(Sender);
end;

procedure Ts0NaviEdit.SetEditOfCaption(const Value: Ts0NaviEditItemEdit);
begin
  FEditOfCaption.Assign(Value);
end;

procedure Ts0NaviEdit.SetEditOfID(const Value: Ts0NaviEditItemEdit);
begin
  FEditOfID.Assign(Value);
end;

procedure Ts0NaviEdit.SetEntityListImplOption(
  const Value: K0EntityListOptionSet);
begin
  FSelector.EntityListImplOption := Value;
end;

procedure Ts0NaviEdit.SetEntityListImplOptionEnabled(const Value: Boolean);
begin
  FSelector.EntityListImplOptionEnabled := Value;
end;

procedure Ts0NaviEdit.SetModalList(const Value: Boolean);
begin
  FSelector.ModalList := Value;
end;

procedure Ts0NaviEdit.SetNaviCaption(const Value: String);
begin
  FEdtCaption.Text := Value;
end;

procedure Ts0NaviEdit.SetNaviData(ANavi: Ts0EntityNavi);
begin
  if ANavi = nil then
  begin
    FEdtID.Accessor.AsInteger := 0;
    FEdtID.Accessor.AsString := '';
  end
  else
  begin
    FEdtID.Accessor.AsInteger := ANavi.TargetID;
    FEdtID.Accessor.AsString := ANavi.TargetCaption;
  end;
end;

procedure Ts0NaviEdit.SetNaviEntityClassName(const Value: string);
begin
  FSelector.NaviEntityClassName := Value;
end;

procedure Ts0NaviEdit.SetNaviID(const Value: Integer);
begin
  FEdtID.AsInteger := Value;
end;

procedure Ts0NaviEdit.SetNotFoundOptionOnList(
  const Value: K0NotFoundOnListOption);
begin
  FSelector.NotFoundOptionOnList := Value;
end;

{ Ts0NaviEditDistiller }

class procedure Ts0NaviEditDistiller.Click(AControl: TObject);
begin
  Ts0NaviEdit(AControl).Click;
end;

class function Ts0NaviEditDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0NaviEdit(AControl).Accessor;
end;

class function Ts0NaviEditDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0NaviEdit(AControl).Color;
end;

class function Ts0NaviEditDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0NaviEdit(AControl).OnEnter;
  Result.FOnExit  := Ts0NaviEdit(AControl).OnExit ;
end;

class function Ts0NaviEditDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0NaviEdit(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0NaviEdit(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0NaviEdit(AControl).OnKeyUp   ;
  Result.FOnChange   := Ts0NaviEdit(AControl).OnChange  ;
end;

class function Ts0NaviEditDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0NaviEdit(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0NaviEdit(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0NaviEdit(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0NaviEdit(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0NaviEdit(AControl).OnMouseUp  ;
end;

class function Ts0NaviEditDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0NaviEdit(AControl).OnCanResize;
  Result.FOnResize    := Ts0NaviEdit(AControl).OnResize   ;
end;

class function Ts0NaviEditDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnChange];
end;

class function Ts0NaviEditDistiller.GetValue(AControl: TObject): string;
begin
  Result := IntToStr( Ts0NaviEdit(AControl).NaviID );
end;

class function Ts0NaviEditDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := (AControl is Ts0NaviEdit);
end;

class procedure Ts0NaviEditDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0NaviEdit(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0NaviEditDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0NaviEdit(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0NaviEditDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0NaviEdit(AControl).Color := AColor;
end;

class procedure Ts0NaviEditDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Value.FOnEnter := Ts0NaviEdit(AControl).OnEnter;
  Value.FOnExit  := Ts0NaviEdit(AControl).OnExit ;
end;

class procedure Ts0NaviEditDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0NaviEdit(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0NaviEdit(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0NaviEdit(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  Ts0NaviEdit(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0NaviEditDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0NaviEdit(AControl).OnClick     := Value.FOnClick    ;
  Ts0NaviEdit(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0NaviEdit(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0NaviEdit(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0NaviEdit(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0NaviEditDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0NaviEdit(AControl).OnCanResize := Value.FOnCanResize;
  Ts0NaviEdit(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0NaviEditDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  Ts0NaviEdit(AControl).NaviID := StrToIntDef(Value, 0);
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0NaviEditDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0NaviEditDistiller);

end.
 
