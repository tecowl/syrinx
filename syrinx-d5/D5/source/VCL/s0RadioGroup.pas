unit s0RadioGroup;
{
$History: s0RadioGroup.pas $
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
 * User: Akima        Date: 02/02/25   Time: 12:38
 * Updated in $/source/D5Integrated
 * Items.Objectsの保存方法を変更
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/02/21   Time: 23:20
 * Updated in $/source/D5Integrated
 * Items.Objectsのストリームへの書き込みを変更
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/02/05   Time: 4:34
 * Updated in $/source/D5Integrated
 * TabOrderControllerの処理をKeyUp時にも呼び出すようにした。
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/12/11   Time: 17:32
 * Updated in $/source/D5Integrated
 * Loadedで、Accessor.LoadEnumを呼び出すようにした。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessorを作成。
 * Ts0StringsAccessorはTs0EnumCollectionを使用する。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
 * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
 * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
 *
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  s0DataAccessor,
  s0CtrlDistiller;

type
  Ts0CustomRadioGroup = class;

  Ts0RadioGroupAccessor = class(Ts0StringsAccessor)
  protected
    function GetItemIndex: Integer; override;
    function GetSource: TStrings; override;
    procedure SetItemIndex(const Value: Integer); override;
  end;

  Ts0CustomRadioGroup = class(TRadioGroup)
  private
    FAccessor: Ts0RadioGroupAccessor;
    procedure SetAccessor(const Value: Ts0RadioGroupAccessor);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    property Accessor: Ts0RadioGroupAccessor read FAccessor write SetAccessor;
  end;


type
  Ts0RadioGroup = class(Ts0CustomRadioGroup)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ItemIndex;
    property Items;
    property Constraints;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
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
    property OnStartDock;
    property OnStartDrag;
  published
    property Accessor;
  end;

type
  Ts0RadioGroupDistiller = class(Ts0CtrlDistiller)
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
    class function GetTitle(AControl: TObject): string; override;
    class procedure SetTitle(Value: string; AControl: TObject); override;
    class function GetAccessor(AControl: TObject): Ts0DataAccessor; override;
    class procedure Click(AControl: TObject); override;
    class procedure KeyDown(AControl: TObject; var Key: Word; Shift: TShiftState); override;
    class procedure MouseDown(AControl: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

uses
  s0StringsObjFiler,
  s0TypeConvertor,
  s0TabOrderController;

{ Ts0RadioGroupAccessor }

function Ts0RadioGroupAccessor.GetItemIndex: Integer;
begin
  Result := Ts0CustomRadioGroup(Owner).ItemIndex;
end;

function Ts0RadioGroupAccessor.GetSource: TStrings;
begin
  Result := Ts0CustomRadioGroup(Owner).Items;
end;

procedure Ts0RadioGroupAccessor.SetItemIndex(const Value: Integer);
begin
  Ts0CustomRadioGroup(Owner).ItemIndex := Value;
end;

{ Ts0CustomRadioGroup }

constructor Ts0CustomRadioGroup.Create(AOwner: TComponent);
begin
  FAccessor := Ts0RadioGroupAccessor.Create(Self);
  inherited;
end;

procedure Ts0CustomRadioGroup.DefineProperties(Filer: TFiler);
var
  sof: Ts0StringsObjFiler;
begin
  inherited DefineProperties(Filer);
  sof := Ts0StringsObjFiler.Create(Items);
  try
    sof.DefineProperties(Filer);
  finally
    FreeAndNil(sof);
  end;
end;

destructor Ts0CustomRadioGroup.Destroy;
begin
  FreeAndNil(FAccessor);
  inherited;
end;

procedure Ts0CustomRadioGroup.KeyDown(var Key: Word; Shift: TShiftState);
begin
  Ts0TabOrderController.Instance.KeyDown(Self, Key, Shift);
  inherited;
end;

procedure Ts0CustomRadioGroup.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Ts0TabOrderController.Instance.KeyUp(Self, Key, Shift);
end;

procedure Ts0CustomRadioGroup.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then Exit;
  Accessor.LoadEnum;
end;

procedure Ts0CustomRadioGroup.SetAccessor(const Value: Ts0RadioGroupAccessor);
begin
  FAccessor.Assign( Value );
end;

{ Ts0RadioGroupDistiller }

class procedure Ts0RadioGroupDistiller.Click(AControl: TObject);
begin
  Ts0CustomRadioGroup(AControl).Click;
end;

class function Ts0RadioGroupDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomRadioGroup(AControl).Accessor;
end;

class function Ts0RadioGroupDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0CustomRadioGroup(AControl).Color;
end;

class function Ts0RadioGroupDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0CustomRadioGroup(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomRadioGroup(AControl).OnExit ;
end;

class function Ts0RadioGroupDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0CustomRadioGroup(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomRadioGroup(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomRadioGroup(AControl).OnKeyUp   ;
  Result.FOnChange   := nil; //Ts0CustomRadioGroup(AControl).OnChange   ;
end;

class function Ts0RadioGroupDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0CustomRadioGroup(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0CustomRadioGroup(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0CustomRadioGroup(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomRadioGroup(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomRadioGroup(AControl).OnMouseUp  ;
end;

class function Ts0RadioGroupDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CustomRadioGroup(AControl).OnCanResize;
  Result.FOnResize    := Ts0CustomRadioGroup(AControl).OnResize   ;
end;

class function Ts0RadioGroupDistiller.GetTitle(AControl: TObject): string;
begin
  Result := Ts0CustomRadioGroup(AControl).Caption;
end;

class function Ts0RadioGroupDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnClick];
end;

class function Ts0RadioGroupDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CustomRadioGroup;
end;

class procedure Ts0RadioGroupDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0CustomRadioGroup(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0RadioGroupDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomRadioGroup(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0RadioGroupDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomRadioGroup(AControl).Color := AColor;
end;

class procedure Ts0RadioGroupDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomRadioGroup(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomRadioGroup(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0RadioGroupDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomRadioGroup(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomRadioGroup(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomRadioGroup(AControl).OnKeyUp    := Value.FOnKeyUp   ;
//  Ts0CustomRadioGroup(AControl).OnChange    := Value.FOnChange   ;
end;

class procedure Ts0RadioGroupDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomRadioGroup(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomRadioGroup(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomRadioGroup(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomRadioGroup(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomRadioGroup(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0RadioGroupDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomRadioGroup(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomRadioGroup(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0RadioGroupDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  Ts0CustomRadioGroup(AControl).Caption := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0RadioGroupDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0RadioGroupDistiller);

end.
