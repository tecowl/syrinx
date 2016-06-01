unit s0CheckBox;
{
$History: s0CheckBox.pas $
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
 * User: Akima        Date: 02/02/05   Time: 4:34
 * Updated in $/source/D5Integrated
 * TabOrderControllerの処理をKeyUp時にも呼び出すようにした。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
 * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
 * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/08/16   Time: 18:04
 * Updated in $/source/D5/p0comctrl
 * Ts0CheckBoxのAccessorをpublishedに変更。
 * AsBooleanを実装した。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/08   Time: 18:42
 * Updated in $/source/p0control
 * K0CtrlEventTypeの要素の名前が変わったのでそれに対応
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/08   Time: 18:35
 * Updated in $/source/p0control
 * R0KeyEvents.FOnChange追加対応
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/08   Time: 15:31
 * Updated in $/source/p0control
 * Ts0CheckBoxDistillerを追加
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/08   Time: 2:41
 * Updated in $/source/p0control
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/07   Time: 17:30
 * Updated in $/source/p0control
 * IntToState等のクラスメソッドを削除。これらはTs0CheckBoxHelperに移動した
 * 。
 * AsIntegerメソッドを実装した。
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/01   Time: 13:22
 * Updated in $/source/p0control
 * コメントを追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  s0CtrlDistiller,
  s0DataAccessor;

type
  K0CheckBoxAsStringKind = (k0cbaskBoolean, k0cbaskCheckState);

type
  Ts0CustomCheckBox = class;
  
  Ts0CheckBoxAccessor = class(Ts0DataAccessor)
  private
    FAsStringKind: K0CheckBoxAsStringKind;
    function GetOwnerCheckBox: Ts0CustomCheckBox;
  protected
    function GetAsBoolean: Boolean; override;
    function GetAsInteger: Integer; override;
    function GetAsString: String; override;
    procedure SetAsBoolean(const Value: Boolean); override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: String); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AsStringKind: K0CheckBoxAsStringKind read FAsStringKind write FAsStringKind default k0cbaskBoolean;
  end;

  {
    Ts0CustomCheckBox
    特に変わったことはできませんが、AsIntegerプロパティが追加されています。
    AsIntegerで取得/設定できる値を指定するにはStateValuesプロパティに値を設定します。
    AsIntegerKindプロパティは、必要がないために実装されていません。
  }
  Ts0CustomCheckBox = class(TCheckBox)
  private
    FStateValues: array[TCheckBoxState] of Integer;
    FAccessor: Ts0CheckBoxAccessor;
    function GetAsInteger: Integer;
    procedure SetAsInteger(const Value: Integer);
    function GetStateValues(const AState: TCheckBoxState): Integer;
    procedure SetStateValues(const AState: TCheckBoxState;
      const Value: Integer);
    procedure SetAccessor(const Value: Ts0CheckBoxAccessor);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    property Accessor: Ts0CheckBoxAccessor read FAccessor write SetAccessor;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property StateValues[const AState: TCheckBoxState]: Integer read
      GetStateValues write SetStateValues;
  end;

type
  Ts0CheckBox = class(Ts0CustomCheckBox)
  published
    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  public
    property AsInteger;
    property StateValues;
  published
    property Accessor;
  end;

type
  Ts0CheckBoxDistiller = class(Ts0CtrlDistiller)
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
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetAccessor(AControl: TObject): Ts0DataAccessor; override;
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

implementation

uses
  s0TypeConvertor,
  s0CheckBoxHelper,
  s0TabOrderController;

{ Ts0CheckBoxAccessor }

constructor Ts0CheckBoxAccessor.Create(AOwner: TComponent);
begin
  inherited;
  FAsStringKind := k0cbaskBoolean;
end;

function Ts0CheckBoxAccessor.GetAsBoolean: Boolean;
begin
  Result := GetOwnerCheckBox.Checked;
end;

function Ts0CheckBoxAccessor.GetAsInteger: Integer;
begin
  Result := GetOwnerCheckBox.AsInteger;
end;

function Ts0CheckBoxAccessor.GetAsString: String;
begin
  Result := '';
  case FAsStringKind of
    k0cbaskBoolean: Result := Ts0TypeConv.BoolToStr( GetOwnerCheckBox.Checked );
    k0cbaskCheckState: Result := Ts0CheckBoxHelper.StateToStr( GetOwnerCheckBox.State );
  end;
end;

function Ts0CheckBoxAccessor.GetOwnerCheckBox: Ts0CustomCheckBox;
begin
  Result := Ts0CustomCheckBox(Owner);
end;

procedure Ts0CheckBoxAccessor.SetAsBoolean(const Value: Boolean);
begin
  GetOwnerCheckBox.Checked := Value;
end;

procedure Ts0CheckBoxAccessor.SetAsInteger(const Value: Integer);
begin
  GetOwnerCheckBox.AsInteger := Value;
end;

procedure Ts0CheckBoxAccessor.SetAsString(const Value: String);
begin
  case FAsStringKind of
    k0cbaskBoolean: GetOwnerCheckBox.Checked := Ts0TypeConv.StrToBool( UpperCase(Value) );
    k0cbaskCheckState: GetOwnerCheckBox.State := Ts0CheckBoxHelper.StrToState( UpperCase(Value) );
  end;
end;

{ Ts0CustomCheckBox }

constructor Ts0CustomCheckBox.Create(AOwner: TComponent);
  procedure InitStateValue;
  var
    i: TCheckBoxState;
  begin
    for i := Low(TCheckBoxState) to High(TCheckBoxState) do
      FStateValues[i] := Ts0CheckBoxHelper.StateToInt(i);
  end;
begin
  FAccessor := Ts0CheckBoxAccessor.Create(Self);
  inherited;
  InitStateValue;
end;

destructor Ts0CustomCheckBox.Destroy;
begin
  FreeAndNil(FAccessor);
  inherited;            
end;

function Ts0CustomCheckBox.GetAsInteger: Integer;
begin
  Result := FStateValues[Self.State];
end;

function Ts0CustomCheckBox.GetStateValues(
  const AState: TCheckBoxState): Integer;
begin
  Result := FStateValues[AState];
end;

procedure Ts0CustomCheckBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Ts0TabOrderController.Instance.KeyDown(Self, Key, Shift);
end;

procedure Ts0CustomCheckBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Ts0TabOrderController.Instance.KeyUp(Self, Key, Shift);
end;

procedure Ts0CustomCheckBox.SetAccessor(const Value: Ts0CheckBoxAccessor);
begin
  FAccessor.Assign(Value);
end;

procedure Ts0CustomCheckBox.SetAsInteger(const Value: Integer);
var
  i: TCheckBoxState;
begin
  for i := Low(TCheckBoxState) to High(TCheckBoxState) do
    if FStateValues[i] = Value then
    begin
      Self.State := i;
      Exit;
    end;
end;

procedure Ts0CustomCheckBox.SetStateValues(const AState: TCheckBoxState;
  const Value: Integer);
begin
  FStateValues[AState] := Value;
end;

{ Ts0CheckBoxDistiller }

class procedure Ts0CheckBoxDistiller.Click(AControl: TObject);
begin
  Ts0CustomCheckBox(AControl).Click;
end;

class function Ts0CheckBoxDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomCheckBox(AControl).Accessor;
end;

class function Ts0CheckBoxDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0CustomCheckBox(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomCheckBox(AControl).OnExit ;
end;

class function Ts0CheckBoxDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0CustomCheckBox(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomCheckBox(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomCheckBox(AControl).OnKeyUp   ;
  Result.FOnChange   := nil; //Ts0CustomCheckBox(AControl).OnChane   ;
end;

class function Ts0CheckBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0CustomCheckBox(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0CustomCheckBox(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0CustomCheckBox(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomCheckBox(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomCheckBox(AControl).OnMouseUp  ;
end;

class function Ts0CheckBoxDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CustomCheckBox(AControl).OnCanResize;
  Result.FOnResize    := Ts0CustomCheckBox(AControl).OnResize   ;
end;

class function Ts0CheckBoxDistiller.GetTitle(AControl: TObject): string;
begin
  Result := Ts0CustomCheckBox(AControl).Caption;
end;

class function Ts0CheckBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnClick];
end;

class function Ts0CheckBoxDistiller.GetValue(AControl: TObject): string;
begin
  Result := Ts0CheckBoxHelper.StateToStr( Ts0CustomCheckBox(AControl).State );
end;

class function Ts0CheckBoxDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CustomCheckBox;
end;

class procedure Ts0CheckBoxDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0CustomCheckBox(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0CheckBoxDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomCheckBox(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0CheckBoxDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomCheckBox(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomCheckBox(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0CheckBoxDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomCheckBox(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomCheckBox(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomCheckBox(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  //Ts0CustomCheckBox(AControl).OnChange   := Value.FOnChange   ;
end;

class procedure Ts0CheckBoxDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomCheckBox(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomCheckBox(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomCheckBox(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomCheckBox(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomCheckBox(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0CheckBoxDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomCheckBox(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomCheckBox(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0CheckBoxDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  Ts0CustomCheckBox(AControl).Caption := Value;
end;

class procedure Ts0CheckBoxDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  Ts0CustomCheckBox(AControl).State := Ts0CheckBoxHelper.StrToState(Value);
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0CheckBoxDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0CheckBoxDistiller);

end.

