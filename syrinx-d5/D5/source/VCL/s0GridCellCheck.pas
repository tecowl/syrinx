unit s0GridCellCheck;
{
$History: s0GridCellCheck.pas $
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 18  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 02/02/25   Time: 12:39
 * Updated in $/source/D5Integrated
 * チェックの描画を他のクラスに委譲
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 02/02/05   Time: 4:33
 * Updated in $/source/D5Integrated
 * KeyDownではなくKeyPressでClickするように修正
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/01/10   Time: 3:12
 * Updated in $/source/D5Integrated
 * CreateParamsの処理をTs0GridCellControlに移行
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/01/06   Time: 0:20
 * Updated in $/source/D5Integrated
 * DrawToCanvasの引数にAStateを追加
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/10/01   Time: 9:11
 * Updated in $/source/D5Integrated
 * AccessorにAsIntegerKindを追加
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/30   Time: 1:49
 * Updated in $/source/D5Integrated
 * Ts0DataAccessor.AsIntegerKindの廃止に伴い、変更。
 * AccessorはT9XXXXではなく、T0XXXXにクラス名を変更した。
 * またコンロトールのプロパティの型は宣言したクラスを使用するようにした。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/06   Time: 21:21
 * Updated in $/source/D5Integrated
 * DistillerにKeyDown、MouseDownメソッドを追加した
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/17   Time: 18:32
 * Updated in $/source/D5/p0grid
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/08   Time: 19:29
 * Updated in $/source/p0control/p0grid
 * k0cetClick ->  k0cetOnClick
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/08   Time: 18:37
 * Updated in $/source/p0control/p0grid
 * R0KeyEvents.FOnChange追加対応
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/07   Time: 21:38
 * Updated in $/source/p0control/p0grid
 * Ts0CheckBoxのクラスメソッドを廃止したのでそれに対応。
 * Accessorに対応した。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/30   Time: 21:35
 * Updated in $/source/p0control/p0grid
 * Ts0GridCellControlを継承するように変更
 * 
 * *****************  Version 15  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマンド追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls,
  s0Grids,
  s0DataAccessor,
  s0GridCellControl,
  s0CtrlDistiller;

type
  K0GridCellCheckAsStringKind = (k0gccaskBoolean, k0gccaskCheckState);

type
  Ts0GridCellCheck = class;

  Ts0GridCellCheckAccessor = class(Ts0DataAccessor)
  private
    FAsIntegerKind: K0GridCellCheckAsStringKind;
    function GetOwnerCheck: Ts0GridCellCheck;
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
    property AsIntegerKind: K0GridCellCheckAsStringKind read FAsIntegerKind write FAsIntegerKind default k0gccaskBoolean;
  end;

  Ts0GridCellCheck = class(Ts0GridCellControl)
  private
    FCheckColor: TColor;
    FOnChange: TNotifyEvent;
    FState: TCheckBoxState;
    FAllowGrayed: Boolean;
    FAccessor: Ts0GridCellCheckAccessor;
    FWithBoxFrame: Boolean;
    procedure SetChecked(Value: Boolean);
    procedure SetCheckColor(Value: TColor);
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CNKeyDown(var Message: TMessage); message CN_KEYDOWN;
    procedure SetState(const Value: TCheckBoxState);
    procedure SetAllowGrayed(const Value: Boolean);
    function GetChecked: Boolean;
    procedure SetAccessor(const Value: Ts0GridCellCheckAccessor);
    procedure SetWithBoxFrame(const Value: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoChange;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure DrawTo(ACanvas: TCanvas; ARect: TRect; AChecked: TCheckBoxState);
  protected
    procedure SetCtrlValue(const Value: string); override;
    function GetCtrlValue: string; override;
  public
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRect; AState: TGridDrawState; CellValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    property Caption;
    procedure SetCellStr(Value: string);
    function GetCellStr: string;
    class function StrToState(const Value: string; AAllowGrayed: Boolean = False): TCheckBoxState;
    class function StateToStr(const Value: TCheckBoxState; AAllowGrayed: Boolean = False): string;
  published
    property Accessor: Ts0GridCellCheckAccessor read FAccessor write SetAccessor;
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default False;
    property Checked: Boolean read GetChecked write SetChecked stored False;
    property CheckColor: TColor read FCheckColor write SetCheckColor default clBlack;
    property Color default clWindow;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    //property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State: TCheckBoxState read FState write SetState default cbUnchecked;
    property TabOrder;
    property TabStop;
    property Visible;
    property WithBox: Boolean read FWithBoxFrame write SetWithBoxFrame default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

type
  Ts0GridCellCheckDistiller = class(Ts0CtrlDistiller)
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
    class function GetColor(AControl: TObject): TColor; override;
    class procedure SetColor(AControl: TObject; AColor: TColor); override;
  end;

implementation

uses
  s0CheckDrawer,
  s0TypeConvertor,
  s0CheckBoxHelper;


{ Ts0GridCellCheckAccessor }

constructor Ts0GridCellCheckAccessor.Create(AOwner: TComponent);
begin
  inherited;
  FAsIntegerKind := k0gccaskBoolean;
end;

function Ts0GridCellCheckAccessor.GetAsBoolean: Boolean;
begin
  Result := GetOwnerCheck.Checked;
end;

function Ts0GridCellCheckAccessor.GetAsInteger: Integer;
begin
  Result := Ts0CheckBoxHelper.StateToInt( GetOwnerCheck.State );
end;

function Ts0GridCellCheckAccessor.GetAsString: String;
begin
  Result := '';
  case FAsIntegerKind of
    k0gccaskBoolean: Result := Ts0TypeConv.BoolToStr( GetOwnerCheck.Checked );
    k0gccaskCheckState: Result := Ts0CheckBoxHelper.StateToStr( GetOwnerCheck.State );
  end;
end;

function Ts0GridCellCheckAccessor.GetOwnerCheck: Ts0GridCellCheck;
begin
  Result := Ts0GridCellCheck(Owner);
end;

procedure Ts0GridCellCheckAccessor.SetAsBoolean(const Value: Boolean);
begin
  GetOwnerCheck.Checked := Value;
end;

procedure Ts0GridCellCheckAccessor.SetAsInteger(const Value: Integer);
begin
  GetOwnerCheck.State :=Ts0CheckBoxHelper.IntToState(Value);
end;

procedure Ts0GridCellCheckAccessor.SetAsString(const Value: String);
begin
  case FAsIntegerKind of
    k0gccaskBoolean: GetOwnerCheck.Checked :=Ts0TypeConv.StrToBool( UpperCase(Value) );
    k0gccaskCheckState: GetOwnerCheck.State :=Ts0CheckBoxHelper.StrToState( UpperCase(Value) );
  end;                                
end;

{ Ts0GridCellCheck }

constructor Ts0GridCellCheck.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FState := cbUnchecked;
  ControlStyle := [csCaptureMouse, csOpaque, csClickEvents];
  FCheckColor := clBlack;
  Color := clWindow;
  ParentColor := False;
  TabStop := True;
  FWithBoxFrame := True;
  SetBounds(Left, Top, 16, 16);
  FAccessor := Ts0GridCellCheckAccessor.Create(Self);
end;

procedure Ts0GridCellCheck.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  CreateSubClass(Params, 'BUTTON');
end;

procedure Ts0GridCellCheck.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure Ts0GridCellCheck.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure Ts0GridCellCheck.CMTextChanged(var Message: TMessage);
begin
  Checked := (Caption = '1');
  Invalidate;
end;

procedure Ts0GridCellCheck.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure Ts0GridCellCheck.CNKeyDown(var Message: TMessage);
begin
  if not(Message.WParam in [VK_Left, VK_Right, VK_Up, VK_Down]) then
    inherited;
end;

procedure Ts0GridCellCheck.DrawTo(ACanvas: TCanvas; ARect: TRect; AChecked: TCheckBoxState);
begin
  Ts0CheckDrawer.DrawTo(ACanvas, ARect, AChecked, FAllowGrayed, FWithBoxFrame);
end;

procedure Ts0GridCellCheck.Click;
begin
  if AllowGrayed then
    case FState of
      cbUnchecked: State := cbGrayed   ;
      cbChecked  : State := cbUnchecked;
      cbGrayed   : State := cbChecked  ;
    end
  else
    Checked := not Checked;
  inherited Click;
  DoChange;
end;

procedure Ts0GridCellCheck.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
end;

procedure Ts0GridCellCheck.KeyPress(var Key: Char);
begin
  if Key = ' ' then
  begin
    Click;
    //Key := #0;
  end
  else
    inherited KeyPress(Key);
end;

procedure Ts0GridCellCheck.SetChecked(Value: Boolean);
const
  c9CheckedCaptions: array[False..True] of string = ('0', '1');
begin
  if Caption <> c9CheckedCaptions[Value] then
    Caption := c9CheckedCaptions[Value];
  if Value then FState := cbChecked
           else FState := cbUnchecked;
  Invalidate;
end;

procedure Ts0GridCellCheck.SetCheckColor(Value: TColor);
begin
  FCheckColor := Value;
  Invalidate;
end;

procedure Ts0GridCellCheck.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure Ts0GridCellCheck.SetState(const Value: TCheckBoxState);
begin
  if FAllowGrayed then
    FState := Value
  else
    if Value <> cbGrayed then
      FState := Value;
  Invalidate;
end;

procedure Ts0GridCellCheck.SetAllowGrayed(const Value: Boolean);
begin
  FAllowGrayed := Value;
  SetState(FState);
end;

function Ts0GridCellCheck.GetCellStr: string;
begin
  Result := Ts0CheckBoxHelper.StateToStr(FState, FAllowGrayed);
end;

function Ts0GridCellCheck.GetChecked: Boolean;
begin
  Result := (FState = cbChecked);
end;

procedure Ts0GridCellCheck.SetCellStr(Value: string);
begin
  State := Ts0CheckBoxHelper.StrToState(Value, AllowGrayed);
end;

function Ts0GridCellCheck.GetCtrlValue: string;
begin
  Result := Ts0CheckBoxHelper.StateToStr(State);
end;

procedure Ts0GridCellCheck.SetCtrlValue(const Value: string);
begin
  State := Ts0CheckBoxHelper.StrToState(Value);
end;

procedure Ts0GridCellCheck.DrawToCanvas(ACanvas: TCanvas; ARect: TRect;
  AState: TGridDrawState; CellValue: string);
begin
  DrawTo(ACanvas, ARect, Ts0CheckBoxHelper.StrToState( UpperCase(CellValue) ) )
end;

class function Ts0GridCellCheck.StateToStr(const Value: TCheckBoxState;
  AAllowGrayed: Boolean): string;
begin
  Result := Ts0CheckBoxHelper.StateToStr(Value, AAllowGrayed);
end;

class function Ts0GridCellCheck.StrToState(const Value: string;
  AAllowGrayed: Boolean): TCheckBoxState;
begin
  Result := Ts0CheckBoxHelper.StrToState(Value, AAllowGrayed);
end;

procedure Ts0GridCellCheck.SetAccessor(const Value: Ts0GridCellCheckAccessor);
begin
  FAccessor.Assign(Value);
end;

destructor Ts0GridCellCheck.Destroy;
begin
  FreeAndNil(FAccessor);
  inherited;
end;

procedure Ts0GridCellCheck.SetWithBoxFrame(const Value: Boolean);
begin
  FWithBoxFrame := Value;
  Invalidate;
end;

procedure Ts0GridCellCheck.DoExit;
begin
  inherited DoExit;
end;

{ Ts0GridCellCheckDistiller }

class procedure Ts0GridCellCheckDistiller.Click(AControl: TObject);
begin
  Ts0GridCellCheck(AControl).Click;
end;

class function Ts0GridCellCheckDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0GridCellCheck(AControl).Accessor;
end;

class function Ts0GridCellCheckDistiller.GetColor(
  AControl: TObject): TColor;
begin
	Result := Ts0GridCellCheck(AControl).Color;
end;

class function Ts0GridCellCheckDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0GridCellCheck(ACOntrol).OnEnter;
  Result.FOnExit  := Ts0GridCellCheck(ACOntrol).OnExit;
end;

class function Ts0GridCellCheckDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0GridCellCheck(ACOntrol).OnKeyDown ;
  Result.FOnKeyPress := Ts0GridCellCheck(ACOntrol).OnKeyPress;
  Result.FOnKeyUp    := Ts0GridCellCheck(ACOntrol).OnKeyUp   ;
  Result.FOnChange   := Ts0GridCellCheck(ACOntrol).OnChange  ;
end;

class function Ts0GridCellCheckDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0GridCellCheck(ACOntrol).OnClick;
  Result.FOnDblClick  := Ts0GridCellCheck(AControl).OnDblClick;
  Result.FOnMouseDown := Ts0GridCellCheck(ACOntrol).OnMouseDown;
  Result.FOnMouseMove := Ts0GridCellCheck(ACOntrol).OnMouseMove;
  Result.FOnMouseUp   := Ts0GridCellCheck(ACOntrol).OnMouseUp;
end;

class function Ts0GridCellCheckDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0GridCellCheck(ACOntrol).OnCanResize;
  Result.FOnResize    := Ts0GridCellCheck(ACOntrol).OnResize;
end;

class function Ts0GridCellCheckDistiller.GetTitle(
  AControl: TObject): string;
begin
  Result := Ts0GridCellCheck(AControl).Caption;
end;

class function Ts0GridCellCheckDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnClick];
end;

class function Ts0GridCellCheckDistiller.GetValue(
  AControl: TObject): string;
begin
  Result := Ts0GridCellCheck(AControl).CtrlValue;
end;

class function Ts0GridCellCheckDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := (AControl is Ts0GridCellCheck);
end;

class procedure Ts0GridCellCheckDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0GridCellCheck(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0GridCellCheckDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0GridCellCheck(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0GridCellCheckDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0GridCellCheck(AControl).Color := AColor;
end;

class procedure Ts0GridCellCheckDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  Ts0GridCellCheck(AControl).OnEnter := Value.FOnEnter;
  Ts0GridCellCheck(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0GridCellCheckDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0GridCellCheck(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0GridCellCheck(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0GridCellCheck(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  Ts0GridCellCheck(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0GridCellCheckDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  Ts0GridCellCheck(AControl).OnClick     := Value.FOnClick    ;
  Ts0GridCellCheck(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0GridCellCheck(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0GridCellCheck(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0GridCellCheck(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0GridCellCheckDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0GridCellCheck(AControl).OnCanResize := Value.FOnCanResize;
  Ts0GridCellCheck(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0GridCellCheckDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
  Ts0GridCellCheck(AControl).Caption := Value;
end;

class procedure Ts0GridCellCheckDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  Ts0GridCellCheck(AControl).CtrlValue := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0GridCellCheckDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0GridCellCheckDistiller);

end.
