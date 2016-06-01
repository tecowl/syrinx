unit s0GridCellImage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  s0Grids,
  s0GridCellControl, s0CtrlDistiller, s0DataAccessor;

type
  Ts0GridCellImage = class;

  Ts0GridCellImageAccessor = class(Ts0DataAccessor)
  protected
    function GetOwnerCellImage: Ts0GridCellImage;
    function GetAsFloat: Double; override;
    function GetAsInteger: Integer; override;
    function GetAsString: String; override;
    procedure SetAsFloat(const Value: Double); override;
    procedure SetAsInteger(const Value: Integer); override;
    procedure SetAsString(const Value: String); override;
  end;

  Ts0GridCellImage = class(Ts0GridCellControl)
  private
    FImageList: TImageList;
    FImageIndex: Integer;
    FAccessor: Ts0GridCellImageAccessor;
    FOnChange: TNotifyEvent;
    procedure SetImageList(const Value: TImageList);
    procedure SetImageIndex(const Value: Integer);
    procedure SetAccessor(const Value: Ts0GridCellImageAccessor);
  protected
    procedure DoChange;
    function GetCtrlValue: string; override;
    procedure SetCtrlValue(const Value: string); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Change;
    procedure DrawToCanvas(ACanvas: TCanvas; ARect: TRect; AState: TGridDrawState; CellValue: string); override;
  published
    property Accessor: Ts0GridCellImageAccessor read FAccessor write SetAccessor;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property ImageList: TImageList read FImageList write SetImageList;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property DrawFixedCells default True;
  end;

type
  Ts0GridCellImageDistiller = class(Ts0CtrlDistiller)
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

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Grid', [Ts0GridCellImage]);
end;

{ Ts0GridCellImageAccessor }

function Ts0GridCellImageAccessor.GetAsFloat: Double;
begin
  Result := GetAsInteger;
end;

function Ts0GridCellImageAccessor.GetAsInteger: Integer;
begin
  Result := GetOwnerCellImage.ImageIndex;
end;

function Ts0GridCellImageAccessor.GetAsString: String;
begin
  Result := IntToStr(GetAsInteger);
end;

function Ts0GridCellImageAccessor.GetOwnerCellImage: Ts0GridCellImage;
begin
  Result := nil;
  if Owner is Ts0GridCellImage then
    Result := Ts0GridCellImage(Owner);
end;

procedure Ts0GridCellImageAccessor.SetAsFloat(const Value: Double);
begin
  SetAsInteger(Trunc(Value));
end;

procedure Ts0GridCellImageAccessor.SetAsInteger(const Value: Integer);
begin
  GetOwnerCellImage.ImageIndex := Value;
end;

procedure Ts0GridCellImageAccessor.SetAsString(const Value: String);
begin
  SetAsInteger(StrToIntDef(Value, -1));
end;

{ Ts0GridCellImage }

procedure Ts0GridCellImage.Change;
begin
  DoChange;
end;

constructor Ts0GridCellImage.Create(AOwner: TComponent);
begin
  inherited;
  DrawFixedCells := True;
  FAccessor := Ts0GridCellImageAccessor.Create(Self);
end;

destructor Ts0GridCellImage.Destroy;
begin
  FreeAndNil(FAccessor);
  inherited;            
end;

procedure Ts0GridCellImage.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure Ts0GridCellImage.DrawToCanvas(ACanvas: TCanvas; ARect: TRect;
  AState: TGridDrawState; CellValue: string);
var
  imgIdx: Integer;
begin
  if FImageList = nil then Exit;
  imgIdx := StrToIntDef(CellValue, -1);
  if imgIdx < 0 then Exit;
  FImageList.Draw(ACanvas, ARect.Left, ARect.Top, imgIdx, not(gdFixed in AState));
end;

function Ts0GridCellImage.GetCtrlValue: string;
begin
  Result := IntToStr(FImageIndex);
end;

procedure Ts0GridCellImage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FImageList = AComponent then
    FImageList := nil;
end;

procedure Ts0GridCellImage.SetAccessor(
  const Value: Ts0GridCellImageAccessor);
begin
  FAccessor.Assign(Value);
end;

procedure Ts0GridCellImage.SetCtrlValue(const Value: string);
begin
  FImageIndex := StrToIntDef(Value, -1);
end;

procedure Ts0GridCellImage.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  Change;
  Invalidate;
end;

procedure Ts0GridCellImage.SetImageList(const Value: TImageList);
begin
  FImageList := Value;
  Invalidate;
end;

{ Ts0GridCellImageDistiller }

class procedure Ts0GridCellImageDistiller.Click(AControl: TObject);
begin
  Ts0GridCellImage(AControl).Click;
end;

class function Ts0GridCellImageDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0GridCellImage(AControl).Accessor;
end;

class function Ts0GridCellImageDistiller.GetColor(
  AControl: TObject): TColor;
begin
	Result := Ts0GridCellImage(AControl).Color;
end;

class function Ts0GridCellImageDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0GridCellImage(AControl).OnEnter;
  Result.FOnExit  := Ts0GridCellImage(AControl).OnExit ;
end;

class function Ts0GridCellImageDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0GridCellImage(AControl).OnKeyDown ;
  Result.FOnKeyPress := Ts0GridCellImage(AControl).OnKeyPress;
  Result.FOnKeyUp    := Ts0GridCellImage(AControl).OnKeyUp   ;
  Result.FOnChange   := Ts0GridCellImage(AControl).OnChange  ;
end;

class function Ts0GridCellImageDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0GridCellImage(AControl).OnClick    ;
  Result.FOnDblClick  := Ts0GridCellImage(AControl).OnDblClick ;
  Result.FOnMouseDown := Ts0GridCellImage(AControl).OnMouseDown;
  Result.FOnMouseMove := Ts0GridCellImage(AControl).OnMouseMove;
  Result.FOnMouseUp   := Ts0GridCellImage(AControl).OnMouseUp  ;
end;

class function Ts0GridCellImageDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0GridCellImage(AControl).OnCanResize;
  Result.FOnResize    := Ts0GridCellImage(AControl).OnResize   ;
end;

class function Ts0GridCellImageDistiller.GetTitle(
  AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0GridCellImageDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [];
end;

class function Ts0GridCellImageDistiller.GetValue(
  AControl: TObject): string;
begin
  Result := Ts0GridCellImage(AControl).Accessor.AsString;
end;

class function Ts0GridCellImageDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := AControl is Ts0GridCellImage;
end;

class procedure Ts0GridCellImageDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0GridCellImage(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0GridCellImageDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0GridCellImage(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0GridCellImageDistiller.SetColor(AControl: TObject;
  AColor: TColor);
begin
  Ts0GridCellImage(AControl).Color := AColor;
end;

class procedure Ts0GridCellImageDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  Ts0GridCellImage(AControl).OnEnter := Value.FOnEnter;
  Ts0GridCellImage(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0GridCellImageDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0GridCellImage(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0GridCellImage(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0GridCellImage(AControl).OnKeyUp    := Value.FOnKeyUp   ;
  Ts0GridCellImage(AControl).OnChange   := Value.FOnChange  ;
end;

class procedure Ts0GridCellImageDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  Ts0GridCellImage(AControl).OnClick     := Value.FOnClick    ;
  Ts0GridCellImage(AControl).OnDblClick  := Value.FOnDblClick ;
  Ts0GridCellImage(AControl).OnMouseDown := Value.FOnMouseDown;
  Ts0GridCellImage(AControl).OnMouseMove := Value.FOnMouseMove;
  Ts0GridCellImage(AControl).OnMouseUp   := Value.FOnMouseUp  ;
end;

class procedure Ts0GridCellImageDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0GridCellImage(AControl).OnCanResize := Value.FOnCanResize;
  Ts0GridCellImage(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0GridCellImageDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
end;

class procedure Ts0GridCellImageDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  Ts0GridCellImage(AControl).Accessor.AsString := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0GridCellImageDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0GridCellImageDistiller);

end.
