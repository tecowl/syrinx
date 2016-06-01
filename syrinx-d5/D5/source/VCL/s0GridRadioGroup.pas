unit s0GridRadioGroup;
{
$History: s0GridRadioGroup.pas $
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
 * User: Akima        Date: 02/01/06   Time: 0:20
 * Updated in $/source/D5Integrated
 * DrawToCanvasの引数にAStateを追加
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/12/11   Time: 17:32
 * Updated in $/source/D5Integrated
 * Loadedで、Accessor.LoadEnumを呼び出すようにした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/12/08   Time: 2:06
 * Updated in $/source/D5Integrated
 * Ts0StringsAccessorを作成。
 * Ts0StringsAccessorはTs0EnumCollectionを使用する。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/07   Time: 14:50
 * Updated in $/source/D5Integrated
 * DistillerにClickメソッドを追加
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/11/28   Time: 18:18
 * Updated in $/source/D5Integrated
 * Distillerのメソッドをprotectedからpublicに変更
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/30   Time: 0:37
 * Updated in $/source/D5Integrated
 * Ｄｉｓｔｉｌｌｅｒ、Accessorを追加（今頃かよ！）
 *
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0grid
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/08   Time: 18:37
 * Updated in $/source/p0control/p0grid
 * c0StdCtrlsを削除したので対応した
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/07/30   Time: 21:35
 * Updated in $/source/p0control/p0grid
 * Ts0GridCellControlを継承するように変更
 *
 * *****************  Version 5  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマンド追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, dialogs,
  s0Grids,
  s0DataAccessor,
  s0CtrlDistiller,
  s0RadioButton,
  s0GridCellControl;

type
  Ts0GridRadioGroup = class;

  Ts0GridRadioGroupAccessor = class(Ts0StringsAccessor)
  protected
    function GetItemIndex: Integer; override;
    function GetSource: TStrings; override;
    procedure SetItemIndex(const Value: Integer); override;
  end;

  Ts0GroupButtonClass = class of TRadioButton;
  Ts0GroupButton = class(Ts0RadioButton)
  private
    FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor InternalCreate(RadioGroup: Ts0GridRadioGroup);
    destructor Destroy; override;
  end;

  Ts0GridRadioGroup = class(Ts0GridCellControl)
  private
    FButtons  : TList;
    FReading  : Boolean;
    FUpdating : Boolean;
    FItems    : TStrings;
    FItemIndex: Integer;
    FColumns  : Integer;
    FWithFrame: Boolean;
    FOnViewChange: TNotifyEvent;
    FAccessor: Ts0GridRadioGroupAccessor;
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure ItemsChange(Sender: TObject);
    procedure UpdateButtons;
    procedure ArrangeButtons; overload;
    procedure ButtonClick(Sender: TObject);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    function GetButtons(const Index: Integer): Ts0GroupButton;
    function GetButtonCount: Integer;
    procedure SetWithFrame(const Value: Boolean);
    function PosItemIndex(APos: TPoint): Integer;
    procedure SetAccessor(const Value: Ts0GridRadioGroupAccessor);
  protected
    procedure DrawFrame(ACanvas: TCanvas; ARect: TRect; ADrawSelf: Boolean); virtual;
    procedure DrawTo(ACanvas: TCanvas; ARect: TRect; ACheckIndex: Integer); virtual;
    function CanModify: Boolean; virtual;
    function GetButtonClass: Ts0GroupButtonClass; virtual;
    procedure DoViewChange;
  protected
    procedure SetCtrlValue(const Value: string); override;
    function GetCtrlValue: string; override;
  public
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRect; AState: TGridDrawState; CellValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    function GetCellStr: string;
    property Buttons[const Index: Integer]: Ts0GroupButton read GetButtons;
    property ButtonCount: Integer read GetButtonCount;
    procedure ItemClick(APos: TPoint); overload;
    procedure ItemClick(AIndex: Integer); overload;
    property OnViewChange: TNotifyEvent read FOnViewChange write FOnViewChange;
  published
    property Accessor: Ts0GridRadioGroupAccessor read FAccessor write SetAccessor;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Items: TStrings read FItems write SetItems;
    property Columns: Integer read FColumns write SetColumns default 1;
    property Caption;
    property Color default clBtnFace;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WithFrame: Boolean read FWithFrame write SetWithFrame default True;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
  end;

type
  Ts0GridRadioGroupDistiller = class(Ts0CtrlDistiller)
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
  s0TypeConvertor,
  s0GraphHelper;

{ Ts0GridRadioGroupAccessor }

function Ts0GridRadioGroupAccessor.GetItemIndex: Integer;
begin
  Result := Ts0GridRadioGroup(Owner).ItemIndex;
end;

function Ts0GridRadioGroupAccessor.GetSource: TStrings;
begin
  Result := Ts0GridRadioGroup(Owner).Items;
end;

procedure Ts0GridRadioGroupAccessor.SetItemIndex(const Value: Integer);
begin
  Ts0GridRadioGroup(Owner).ItemIndex := Value;
end;

{ Ts0GridRadioGroup }

procedure Ts0GridRadioGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
  DeferHandle: THandle;
  ALeft: Integer;
begin
  if (FButtons.Count <> 0) and not FReading then
  begin
    DC := GetDC(0);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := (Width - 10) div FColumns;
    I := Height - Metrics.tmHeight - 5;
    ButtonHeight := I div ButtonsPerCol;
    TopMargin := Metrics.tmHeight + 1 + (I mod ButtonsPerCol) div 2;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
      for I := 0 to FButtons.Count - 1 do
        with Ts0GroupButton(FButtons[I]) do
        begin
          BiDiMode := Self.BiDiMode;
          ALeft := (I div ButtonsPerCol) * ButtonWidth + 8;
          if UseRightToLeftAlignment then
            ALeft := Self.ClientWidth - ALeft - ButtonWidth;
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
            ButtonWidth, ButtonHeight,
            SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
        end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure Ts0GridRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    FItemIndex := FButtons.IndexOf(Sender);
    Changed;
    Click;
  end;
end;

function Ts0GridRadioGroup.CanModify: Boolean;
begin
  Result := True;
end;

procedure Ts0GridRadioGroup.CMCtl3DChanged(var Message: TMessage);
begin
  Invalidate;
  Realign;
  DoViewChange;
end;

procedure Ts0GridRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
    Ts0GroupButton(FButtons[I]).Enabled := Enabled;
  DoViewChange;    
end;

procedure Ts0GridRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
  DoViewChange;
end;

procedure Ts0GridRadioGroup.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  Realign;
  DoViewChange;  
end;

constructor Ts0GridRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks];
  FButtons := TList.Create;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  FColumns   :=   1;
  FItemIndex :=  -1;
  Width      := 120;
  Height     := 45;
  WithFrame  := True;
  FAccessor := Ts0GridRadioGroupAccessor.Create(Self);
end;

destructor Ts0GridRadioGroup.Destroy;
begin
  SetButtonCount(0);
  TStringList(FItems).OnChange := nil;
  FreeAndNil(FAccessor);
  FItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

procedure Ts0GridRadioGroup.DoViewChange;
begin
  if Assigned(FOnViewChange) then
    FOnViewChange(Self);
end;

procedure Ts0GridRadioGroup.DrawFrame(ACanvas: TCanvas; ARect: TRect; ADrawSelf: Boolean);
var
  H      : Integer;
  R      : TRect;
  BufFont: TFont;
  BufBC  : TColor;
  Flags  : Longint;
  R2     : TRect;
begin
  BufFont := Font;
  BufBC   := Brush.Color;
  try
    with ACanvas do
    begin
      Font := Self.Font;
      H    := TextHeight('0');
      if ADrawSelf then
      begin
        R := Rect(0, H div 2 - 1, Width, Height);
      end else
      begin
        R := ARect;
        R := Rect(ARect.Left, ARect.Top + H div 2 - 1, ARect.Right, ARect.Bottom);
      end;
      if Ctl3D then
      begin
        Inc(R.Left);
        Inc(R.Top);
        Brush.Color := clBtnHighlight;
        FrameRect(R);
        OffsetRect(R, -1, -1);
        Brush.Color := clBtnShadow;
      end else
        Brush.Color := clWindowFrame;
      FrameRect(R);
      R2 := R;
      if Self.Text <> '' then
      begin
        if not UseRightToLeftAlignment then
          if ADrawSelf then
            R := Rect(8, 0, 0, H)
          else
            R := Rect(ARect.Left + 8, ARect.Top, ARect.Right, H)
        else
          if ADrawSelf then
            R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H)
          else
            R := Rect(R.Right - ACanvas.TextWidth(Self.Text) - 8, ARect.Top, ARect.Right, H);
        Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
        DrawText(Handle, PChar(Self.Text), Length(Self.Text), R, Flags or DT_CALCRECT);
        Brush.Color := Color;
        DrawText(Handle, PChar(Self.Text), Length(Self.Text), R, Flags);
      end;
    end;
  finally
    ACanvas.Font        := BufFont;
    ACanvas.Brush.Color := BufBC
  end;
end;

procedure Ts0GridRadioGroup.DrawTo(ACanvas: TCanvas; ARect: TRect; ACheckIndex: Integer);
  procedure DrawRadioBtn(ABtnRect: TRect; AText: string; AChecked: Boolean);
    function DrawCircle(ABtnRect: TRect; AChecked: Boolean): Integer;
    const
      c9CircleRadius_In  = 2;
      c9CircleRadius_Out = 6;
    var
      HMargin: Integer;
      CircleRect: TRect;
    begin
      Result := ABtnRect.Left + c9CircleRadius_Out * 2;
      ACanvas.Brush.Style := bsClear;
      ACanvas.Pen.Color   := clBlack;
      HMargin := (ABtnRect.Bottom - ABtnRect.Top - c9CircleRadius_Out * 2) div 2;
      CircleRect := Rect(ABtnRect.Left,                         ABtnRect.Top + HMargin ,
                         ABtnRect.Left+ c9CircleRadius_Out * 2, ABtnRect.Top + HMargin + c9CircleRadius_Out * 2);
      DrawFrameControl(ACanvas.Handle, CircleRect, DFC_BUTTON, DFCS_BUTTONRADIO);
      if AChecked then
      begin
        ACanvas.Font        := Self.Font;
        ACanvas.Brush.Color := clBlack;
        CircleRect := Rect(CircleRect.Left   + c9CircleRadius_Out - c9CircleRadius_In,
                           CircleRect.Top    + c9CircleRadius_Out - c9CircleRadius_In,
                           CircleRect.Right  - c9CircleRadius_Out + c9CircleRadius_In,
                           CircleRect.Bottom - c9CircleRadius_Out + c9CircleRadius_In);
        ACanvas.Ellipse(CircleRect);
        //DrawFrameControl(ACanvas.Handle, CircleRect, DFC_BUTTON, DFCS_MENUBULLET);
      end;
    end;
  var
    Bounds: TRect;
  const
    c9LeftMargin = 5;
  begin
    Bounds := ABtnRect;
    Bounds.Left := DrawCircle(ABtnRect, AChecked);
    ACanvas.Brush.Color := Self.Color;
    Bounds.Left := Bounds.Left + c9LeftMargin;
    DrawText(ACanvas.Handle, PChar(AText), Length(AText), Bounds, DT_VCENTER or DT_SINGLELINE);
  end;

  function ButtonsRect(AIndex: Integer; ARect: TRect): TRect;
  var
    ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
    Metrics: TTextMetric;
//    DC: HDC;
  begin
//    DC := GetDC(0);
//    SaveFont := SelectObject(DC, Font.Handle);
//    GetTextMetrics(DC, Metrics);
    GetTextMetrics(GetDC(0), Metrics);
//    SelectObject(DC, SaveFont);
//    ReleaseDC(0, DC);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := (ARect.Right - ARect.Left - 10) div FColumns;
    I := (ARect.Bottom - ARect.Top) - (Metrics.tmHeight - 5);
    ButtonHeight := I div ButtonsPerCol ;
    TopMargin := Metrics.tmHeight + 1 + (I mod ButtonsPerCol) div 2;
    Result.Left   := ARect.Left + (AIndex div ButtonsPerCol) * ButtonWidth + 8;
    Result.Right  := Result.Left + ButtonWidth;
    Result.Top    := ARect.Top  + (AIndex mod ButtonsPerCol) * ButtonHeight + TopMargin div 2 +1;
    Result.Bottom := Result.Top + ButtonHeight;
  end;              
var
  i: Integer;
  BufPen  : TPen;
  BufFont : TFont;
  BufBrush: TBrush;
begin
  BufFont  := ACanvas.Font;
  BufBrush := ACanvas.Brush;
  BufPen   := ACanvas.Pen;
  try
    ACanvas.Brush.Color := Self.Color;
    ACanvas.Font        := Self.Font;
    ACanvas.FillRect(ARect);
    for i := 0 to Self.ButtonCount -1 do
      DrawRadioBtn(ButtonsRect(i, ARect), Buttons[i].Text, i = ACheckIndex);
    if WithFrame then
      DrawFrame(ACanvas, ARect, False);
  finally
    ACanvas.Pen     := BufPen;
    ACanvas.Font    := BufFont;
    ACanvas.Brush   := BufBrush;
  end;
end;

procedure Ts0GridRadioGroup.DrawToCanvas(ACanvas: TCanvas; ARect: TRect;
  AState: TGridDrawState; CellValue: string);
begin
  DrawTo(ACanvas, ARect, StrToIntDef(CellValue, -1) );
end;

function Ts0GridRadioGroup.GetButtonClass: Ts0GroupButtonClass;
begin
  Result := Ts0GroupButton;
end;

function Ts0GridRadioGroup.GetButtonCount: Integer;
begin
  Result := FButtons.Count;
end;

function Ts0GridRadioGroup.GetButtons(const Index: Integer): Ts0GroupButton;
begin
  Result := Ts0GroupButton(FButtons.Items[Index]);
end;

function Ts0GridRadioGroup.GetCellStr: string;
begin
  Result := IntToStr(ItemIndex);
end;


procedure Ts0GridRadioGroup.ItemClick(APos: TPoint);
var
  Idx: Integer;
begin
  Idx := PosItemIndex(APos);
  if Idx > -1 then ItemIndex := Idx;
end;

function Ts0GridRadioGroup.GetCtrlValue: string;
begin
  Result := IntToStr(ItemIndex);
end;

procedure Ts0GridRadioGroup.ItemClick(AIndex: Integer);
begin
  ItemIndex := AIndex;
end;

procedure Ts0GridRadioGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    if FItemIndex >= FItems.Count then FItemIndex := FItems.Count - 1;
    UpdateButtons;
    DoViewChange;
  end;
end;

procedure Ts0GridRadioGroup.Loaded;
begin
  inherited Loaded;
  ArrangeButtons;
  if csDesigning in Self.ComponentState then Exit;
  Accessor.LoadEnum;
end;

function Ts0GridRadioGroup.PosItemIndex(APos: TPoint): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.ButtonCount -1 do
    if s0GraphHelper.IsInRect(APos, Buttons[i].BoundsRect) then
    begin
      Result := i;
      Exit;
    end;
end;

procedure Ts0GridRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure Ts0GridRadioGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do Ts0GroupButton.InternalCreate(Self);
  while FButtons.Count > Value do Ts0GroupButton(FButtons.Last).Free;
end;

procedure Ts0GridRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
    DoViewChange;
  end;
end;

procedure Ts0GridRadioGroup.SetCtrlValue(const Value: string);
begin
  ItemIndex := StrToIntDef(Value, -1);
end;

procedure Ts0GridRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then FItemIndex := Value else
  begin
    if Value < -1 then Value := -1;
    if Value >= FButtons.Count then Value := FButtons.Count - 1;
    if FItemIndex <> Value then
    begin
      if FItemIndex >= 0 then
        Ts0GroupButton(FButtons[FItemIndex]).Checked := False;
      FItemIndex := Value;
      if FItemIndex >= 0 then
        Ts0GroupButton(FButtons[FItemIndex]).Checked := True;
    end;
  end;
end;

procedure Ts0GridRadioGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure Ts0GridRadioGroup.SetWithFrame(const Value: Boolean);
begin
  if FWithFrame = Value then Exit;
  FWithFrame := Value;
  Invalidate;
  DoViewChange;
end;

procedure Ts0GridRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
    Ts0GroupButton(FButtons[I]).Caption := FItems[I];
  if FItemIndex >= 0 then
  begin
    FUpdating := True;
    Ts0GroupButton(FButtons[FItemIndex]).Checked := True;
    FUpdating := False;
  end;
  ArrangeButtons;
  Invalidate;
end;

procedure Ts0GridRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
  ArrangeButtons;
end;

procedure Ts0GridRadioGroup.SetAccessor(
  const Value: Ts0GridRadioGroupAccessor);
begin
  FAccessor.Assign(Value);
end;

{ Ts0GroupButton }

constructor Ts0GroupButton.InternalCreate(RadioGroup: Ts0GridRadioGroup);
begin
  inherited Create(RadioGroup);
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  Parent := RadioGroup;
end;

destructor Ts0GroupButton.Destroy;
begin
  Ts0GridRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure Ts0GroupButton.CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      if ((Message.NotifyCode = BN_CLICKED) or
        (Message.NotifyCode = BN_DOUBLECLICKED)) and
        Ts0GridRadioGroup(Parent).CanModify then
        inherited;
    except
      Application.HandleException(Self);
    end;
    FInClick := False;
  end;
end;

procedure Ts0GroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  Ts0GridRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not Ts0GridRadioGroup(Parent).CanModify then Key := #0;
  end;
end;

procedure Ts0GroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  Ts0GridRadioGroup(Parent).KeyDown(Key, Shift);
end;

{ Ts0GridRadioGroupDistiller }

class procedure Ts0GridRadioGroupDistiller.Click(AControl: TObject);
begin
  Ts0GridRadioGroup(AControl).Click;
end;

class function Ts0GridRadioGroupDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0GridRadioGroup(AControl).Accessor;
end;

class function Ts0GridRadioGroupDistiller.GetColor(
  AControl: TObject): TColor;
begin
	Result := Ts0GridRadioGroup(AControl).Color;
end;

class function Ts0GridRadioGroupDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0GridRadioGroup(AControl).OnEnter;
  Result.FOnExit  := Ts0GridRadioGroup(AControl).OnExit ;
end;

class function Ts0GridRadioGroupDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0GridRadioGroup(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0GridRadioGroup(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0GridRadioGroup(AControl).OnKeyUp   ;
  Result.FOnChange   := nil;
end;

class function Ts0GridRadioGroupDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0GridRadioGroup(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0GridRadioGroup(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0GridRadioGroup(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0GridRadioGroup(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0GridRadioGroup(AControl).OnMouseUp  ;
end;

class function Ts0GridRadioGroupDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0GridRadioGroup(AControl).OnCanResize;
  Result.FOnResize    := Ts0GridRadioGroup(AControl).OnResize   ;
end;

class function Ts0GridRadioGroupDistiller.GetTitle(
  AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0GridRadioGroupDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnClick];
end;

class function Ts0GridRadioGroupDistiller.GetValue(
  AControl: TObject): string;
begin
  Result := GetAccessor(AControl).AsString;
end;

class function Ts0GridRadioGroupDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := AControl is Ts0GridRadioGroup;
end;

class procedure Ts0GridRadioGroupDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0GridRadioGroup(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0GridRadioGroupDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0GridRadioGroup(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0GridRadioGroupDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0GridRadioGroup(AControl).Color := AColor;
end;

class procedure Ts0GridRadioGroupDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  Ts0GridRadioGroup(AControl).OnEnter := Value.FOnEnter;
  Ts0GridRadioGroup(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0GridRadioGroupDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0GridRadioGroup(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0GridRadioGroup(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0GridRadioGroup(AControl).OnKeyUp    := Value.FOnKeyUp   ;
end;

class procedure Ts0GridRadioGroupDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  Ts0GridRadioGroup(AControl).OnClick     := Value.FOnClick    ;
  Ts0GridRadioGroup(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0GridRadioGroup(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0GridRadioGroup(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0GridRadioGroup(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0GridRadioGroupDistiller.SetSizeEvents(
  Value: R0SizeEvents; AControl: TObject);
begin
  Ts0GridRadioGroup(AControl).OnCanResize := Value.FOnCanResize;
  Ts0GridRadioGroup(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0GridRadioGroupDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
end;

class procedure Ts0GridRadioGroupDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  GetAccessor(AControl).AsString := Value; 
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0GridRadioGroupDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0GridRadioGroupDistiller);

end.

