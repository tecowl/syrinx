unit s0CtrlDragger;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0VCLClasses,
  s0Collection,
  s0CtrlEventSnatcher;

type
  Ts0CtrlDraggerItem = class(Ts0VCLCollectionItem)
  private
    FControl: TControl;
    FListener: Ts0CtrlEventListener;
    FOrgpoint: TPoint;
    FDragging: Boolean;
    FEnabled: Boolean;
    procedure SetControl(const Value: TControl);
    procedure SetEnabled(const Value: Boolean);
    function GetEnabled: Boolean;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Control: TControl read FControl write SetControl;
    property Enabled: Boolean read GetEnabled write SetEnabled;
  end;

type
  Ts0CtrlDraggerItems = class(Ts0VCLCollection)
  private
    function GetItems(const Index: Integer): Ts0CtrlDraggerItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0CtrlDraggerItem);
  public
    function Add(AControl: TControl; AEnabled: Boolean = True): Ts0CtrlDraggerItem;
    property Items[const Index: Integer]: Ts0CtrlDraggerItem read GetItems write SetItems;
  end;

type
  Ts0CtrlDragger = class(Ts0VCLComponent)
  private
    FItems: Ts0CtrlDraggerItems;
    procedure SetItems(const Value: Ts0CtrlDraggerItems);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginDragging;
    procedure EndDragging;
  published
    property Items: Ts0CtrlDraggerItems read FItems write SetItems;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Form', [Ts0CtrlDragger]);
end;

type
  T9CtrlDraggerListener = class(Ts0CtrlEventListener)
  private
    FItem: Ts0CtrlDraggerItem;
  public
    constructor Create(AItem: Ts0CtrlDraggerItem);
    destructor Destroy; override;
    procedure CtrlOnCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean); override;
    //procedure CtrlOnChange(Sender: TObject); override;
    procedure CtrlOnClick(Sender: TObject); override;
    procedure CtrlOnDblClick(Sender: TObject); override;
    procedure CtrlOnEnter(Sender: TObject); override;
    procedure CtrlOnExit(Sender: TObject); override;
    //procedure CtrlOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    //procedure CtrlOnKeyPress(Sender: TObject; var Key: Char); override;
    //procedure CtrlOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure CtrlOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure CtrlOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CtrlOnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure CtrlOnResize(Sender: TObject); override;
  end;

{ T9CtrlDraggerListener }

constructor T9CtrlDraggerListener.Create(AItem: Ts0CtrlDraggerItem);
begin
  inherited Create;
  FItem := AItem;
end;

procedure T9CtrlDraggerListener.CtrlOnCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  inherited;

end;

procedure T9CtrlDraggerListener.CtrlOnClick(Sender: TObject);
begin
  inherited;

end;

procedure T9CtrlDraggerListener.CtrlOnDblClick(Sender: TObject);
begin
  inherited;

end;

procedure T9CtrlDraggerListener.CtrlOnEnter(Sender: TObject);
begin
  inherited;

end;

procedure T9CtrlDraggerListener.CtrlOnExit(Sender: TObject);
begin
  inherited;

end;

procedure T9CtrlDraggerListener.CtrlOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FItem.FDragging := True;
  FItem.FOrgpoint := Point(X, Y);
end;

procedure T9CtrlDraggerListener.CtrlOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
  ctrl: TControl;
begin
  if not FItem.FDragging then Exit;
  if not(Sender is TControl) then Exit;
  ctrl := TControl(Sender);
  p :=
    ctrl.Parent.ScreenToClient(
      ctrl.ClientToScreen(Point(X, Y))
    );
  ctrl.Left := p.x - FItem.FOrgpoint.x;
  ctrl.Top  := p.y - FItem.FOrgpoint.y;
end;

procedure T9CtrlDraggerListener.CtrlOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FItem.FDragging := False;
end;

procedure T9CtrlDraggerListener.CtrlOnResize(Sender: TObject);
begin
  inherited;

end;

destructor T9CtrlDraggerListener.Destroy;
begin
  inherited;
end;

{ Ts0CtrlDraggerItem }

constructor Ts0CtrlDraggerItem.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := False;
  FDragging := False;
  FListener := T9CtrlDraggerListener.Create(Self);
end;

destructor Ts0CtrlDraggerItem.Destroy;
begin
  FreeAndNil(FListener);
  inherited;
end;

function Ts0CtrlDraggerItem.GetEnabled: Boolean;
begin
  Result := FListener <> nil;
end;

procedure Ts0CtrlDraggerItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FControl = AComponent then
    FControl := nil;
end;

procedure Ts0CtrlDraggerItem.SetControl(const Value: TControl);
begin
  if FControl = Value then Exit;
  if FControl <> nil then
    FControl.RemoveFreeNotification(OwnerComponent);
  FControl := Value;
  if FControl <> nil then
    FControl.FreeNotification(OwnerComponent);
end;

procedure Ts0CtrlDraggerItem.SetEnabled(const Value: Boolean);
begin
  if FControl = nil then Exit;
  //if FEnabled = Value then Exit;
  //
  FEnabled := Value;
  if [csLoading, csReading, csDesigning] * OwnerComponent.ComponentState <> [] then Exit;
  if FEnabled then
  begin
    Ts0CtrlEventSnatcher.Instance.RegisterListener(FControl, FListener, True);
  end
  else
  begin
    Ts0CtrlEventSnatcher.Instance.UnRegisterListener(nil, FListener);
  end;
end;

{ Ts0CtrlDraggerItems }

function Ts0CtrlDraggerItems.Add(AControl: TControl; AEnabled: Boolean): Ts0CtrlDraggerItem;
begin
  Result := Ts0CtrlDraggerItem(inherited Add);
  Result.Control := AControl;
  Result.Enabled := AEnabled;
end;

function Ts0CtrlDraggerItems.GetItems(
  const Index: Integer): Ts0CtrlDraggerItem;
begin
  Result := Ts0CtrlDraggerItem(inherited Items[Index]);
end;

procedure Ts0CtrlDraggerItems.SetItems(const Index: Integer;
  const Value: Ts0CtrlDraggerItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CtrlDragger }

procedure Ts0CtrlDragger.BeginDragging;
var
  i: Integer;
begin
  for i := 0 to Items.Count -1 do
    Items.Items[i].Enabled := True;
end;

constructor Ts0CtrlDragger.Create(AOwner: TComponent);
begin
  inherited;
  FItems := Ts0CtrlDraggerItems.Create(Self, Ts0CtrlDraggerItem);
end;

destructor Ts0CtrlDragger.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure Ts0CtrlDragger.EndDragging;
var
  i: Integer;
begin
  for i := 0 to Items.Count -1 do
    Items.Items[i].Enabled := False;
end;

procedure Ts0CtrlDragger.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if FItems <> nil then
    FItems.Notification(AComponent, Operation);
end;

procedure Ts0CtrlDragger.SetItems(const Value: Ts0CtrlDraggerItems);
begin
  FItems.Assign(Value);
end;


end.
