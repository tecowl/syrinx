unit s0ListBox;
{
$History: s0ListBox.pas $
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/02/25   Time: 12:38
 * Updated in $/source/D5Integrated
 * Items.Objectsの保存方法を変更
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/02/21   Time: 23:19
 * Updated in $/source/D5Integrated
 * Items.Objectsのストリームへの書き込みを変更
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/12/11   Time: 17:32
 * Updated in $/source/D5Integrated
 * Loadedで、Accessor.LoadEnumを呼び出すようにした。
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessorを作成。
 * Ts0StringsAccessorはTs0EnumCollectionを使用する。
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
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/18   Time: 17:39
 * Updated in $/source/D5Integrated
 * AccessorにAsStringKindを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
 * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
 * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/08   Time: 23:17
 * Updated in $/source/p0control
 * Items.Objectsをストリームに数値として保存できるように
 * SaveObjectsAsIntプロパティを追加。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/08   Time: 18:42
 * Updated in $/source/p0control
 * K0CtrlEventTypeの要素の名前が変わったのでそれに対応
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/08   Time: 18:36
 * Updated in $/source/p0control
 * R0KeyEvents.FOnChange追加対応
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/08   Time: 15:35
 * Updated in $/source/p0control
 * DistillerとAccessorを実装。
 * OnChangeイベントを削除
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/07   Time: 21:57
 * Updated in $/source/p0control
 * コメントマクロを追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  s0DataAccessor,
  s0CtrlDistiller;

type
  Ts0CustomListBox = class;

  Ts0ListBoxAccessor = class(Ts0StringsAccessor)
  protected
    function GetItemIndex: Integer; override;
    function GetSource: TStrings; override;
    procedure SetItemIndex(const Value: Integer); override;
  end;

  Ts0CustomListBox = class(TListBox)
  private
    FAccessor: Ts0ListBoxAccessor;
    procedure SetAccessor(const Value: Ts0ListBoxAccessor);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    property Accessor: Ts0ListBoxAccessor read FAccessor write SetAccessor;
  end;

type
  Ts0ListBox = class(Ts0CustomListBox)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Items;
    property MultiSelect;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  published
    property Accessor;
  end;

type
  Ts0ListBoxDistiller = class(Ts0CtrlDistiller)
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
  s0TypeConvertor;

{ Ts0ListBoxAccessor }

function Ts0ListBoxAccessor.GetItemIndex: Integer;
begin
  Result := Ts0CustomListBox(Owner).ItemIndex;
end;

function Ts0ListBoxAccessor.GetSource: TStrings;
begin
  Result := Ts0CustomListBox(Owner).Items;
end;

procedure Ts0ListBoxAccessor.SetItemIndex(const Value: Integer);
begin
  Ts0CustomListBox(Owner).ItemIndex := Value;
end;

{ Ts0CustomListBox }

constructor Ts0CustomListBox.Create(AOwner: TComponent);
begin
  FAccessor := Ts0ListBoxAccessor.Create(Self);
  inherited;
end;

procedure Ts0CustomListBox.DefineProperties(Filer: TFiler);
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

destructor Ts0CustomListBox.Destroy;
begin
  FreeAndNil(FAccessor);
  inherited;            
end;

procedure Ts0CustomListBox.Loaded;
begin
  inherited Loaded;
  if csDesigning in Self.ComponentState then Exit;
  Accessor.LoadEnum;
end;

procedure Ts0CustomListBox.SetAccessor(const Value: Ts0ListBoxAccessor);
begin
  FAccessor.Assign( Value );
end;

{ Ts0ListBoxDistiller }

class procedure Ts0ListBoxDistiller.Click(AControl: TObject);
begin
  Ts0CustomListBox(AControl).Click;
end;

class function Ts0ListBoxDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CustomListBox(AControl).Accessor;
end;

class function Ts0ListBoxDistiller.GetColor(AControl: TObject): TColor;
begin
	Result := Ts0CustomListBox(AControl).Color;
end;

class function Ts0ListBoxDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0CustomListBox(AControl).OnEnter;
  Result.FOnExit  := Ts0CustomListBox(AControl).OnExit ;
end;

class function Ts0ListBoxDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0CustomListBox(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0CustomListBox(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0CustomListBox(AControl).OnKeyUp   ;
  Result.FOnChange   := nil; //Ts0CustomListBox(AControl).OnChange  ;
end;

class function Ts0ListBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0CustomListBox(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0CustomListBox(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0CustomListBox(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0CustomListBox(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0CustomListBox(AControl).OnMouseUp  ;
end;

class function Ts0ListBoxDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CustomListBox(AControl).OnCanResize;
  Result.FOnResize    := Ts0CustomListBox(AControl).OnResize   ;
end;

class function Ts0ListBoxDistiller.GetTitle(AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0ListBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnClick];
end;

class function Ts0ListBoxDistiller.IsTarget(AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CustomListBox;
end;

class procedure Ts0ListBoxDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0CustomListBox(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0ListBoxDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CustomListBox(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0ListBoxDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0CustomListBox(AControl).Color := AColor;
end;

class procedure Ts0ListBoxDistiller.SetFocusEvents(Value: R0FocusEvents;
  AControl: TObject);
begin
  Ts0CustomListBox(AControl).OnEnter := Value.FOnEnter;
  Ts0CustomListBox(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0ListBoxDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CustomListBox(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CustomListBox(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CustomListBox(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  //Ts0CustomListBox(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0ListBoxDistiller.SetMouseEvents(Value: R0MouseEvents;
  AControl: TObject);
begin
  Ts0CustomListBox(AControl).OnClick     := Value.FOnClick    ;
  Ts0CustomListBox(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0CustomListBox(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0CustomListBox(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0CustomListBox(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0ListBoxDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CustomListBox(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CustomListBox(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0ListBoxDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0ListBoxDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0ListBoxDistiller);

end.
