unit s0DBGridAction;

interface

uses
  SysUtils, Classes, Windows, Graphics, Controls,
  Grids, DB, DBGrids;

type
  K0DBGridActionType = (k0dgatInsert, k0dgatDelete);
  K0DBGridActionTypeSet = set of K0DBGridActionType;

type
  K0ActionQuery = procedure(Sender: TObject; var AExecuteAction: Boolean) of
    object;

type
  Ts0DBGridAction = class(TComponent)
  private
    FGrid: TDBGrid;
    FDummyField: TField;
    FPicture: TPicture;
    FOnGridCellClick: TDBGridClickEvent;
    FOnGridKeyPress: TKeyPressEvent;
    FOnGridDrawColumnCell: TDrawColumnCellEvent;
    FPictureStretch: Boolean;
    FEnabled: Boolean;
    FActionType: K0DBGridActionType;
    FOnActionQuery: K0ActionQuery;
    procedure SetGrid(const Value: TDBGrid);
    procedure SetDummyField(const Value: TField);
    procedure SetPicture(const Value: TPicture);
    procedure GridCellClick(Column: TColumn);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure SetPictureStretch(const Value: Boolean);
    procedure SetEnabled(const Value: Boolean);
    procedure SetActionType(const Value: K0DBGridActionType);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure CheckProperties();
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoAction();
  published
    property ActionType: K0DBGridActionType read FActionType write
      SetActionType;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Grid: TDBGrid read FGrid write SetGrid;
    property DummyField: TField read FDummyField write SetDummyField;
    property Picture: TPicture read FPicture write SetPicture;
    property PictureStretch: Boolean read FPictureStretch write SetPictureStretch
      default False;
    property OnActionQuery: K0ActionQuery read FOnActionQuery write
      FOnActionQuery;
  end;

implementation

uses
  s0Exception;

{ Ts0DBGridAction }

constructor Ts0DBGridAction.Create(AOwner: TComponent);
begin
  inherited;
  FPicture := TPicture.Create();
  FPictureStretch := False;
  FEnabled := true;
end;

destructor Ts0DBGridAction.Destroy;
begin
  FreeAndNil(FPicture);
  inherited;
end;

procedure Ts0DBGridAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation <> opRemove) then
    Exit;
  if (FGrid = AComponent) then
  begin
    FGrid := nil;
    FOnGridCellClick := nil;
    FOnGridKeyPress := nil;
    FOnGridDrawColumnCell := nil;
  end;
  if (FDummyField = AComponent) then
    FDummyField := nil;
  inherited;
end;

procedure Ts0DBGridAction.Loaded;
begin
  inherited;
  if csDesigning in Self.ComponentState then
    Exit;
  CheckProperties;
end;

procedure Ts0DBGridAction.CheckProperties;
begin
  if not FEnabled then
    Exit;
  if FGrid = nil then
    raise Es0RequiredComponentException.Create('Grid');
  if FDummyField = nil then
    raise Es0RequiredComponentException.Create('DummyField');
  FOnGridCellClick := FGrid.OnCellClick;
  FOnGridKeyPress := FGrid.OnKeyPress;
  FOnGridDrawColumnCell := FGrid.OnDrawColumnCell;
  FGrid.OnCellClick := self.GridCellClick;
  FGrid.OnKeyPress := self.GridKeyPress;
  FGrid.OnDrawColumnCell := self.GridDrawColumnCell;
end;

procedure Ts0DBGridAction.GridCellClick(Column: TColumn);
begin
  if csDesigning in Self.ComponentState then
    Exit;
  if csLoading in Self.ComponentState then
    Exit;
  if Column.Field = FDummyField then
  begin
    DoAction;
  end;
  if Assigned(FOnGridCellClick) then
    FOnGridCellClick(Column);
end;

procedure Ts0DBGridAction.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if csDesigning in Self.ComponentState then
    Exit;
  if csLoading in Self.ComponentState then
    Exit;
  if FGrid.SelectedField = FDummyField then
  begin
    if (Key = Char(VK_RETURN)) or (Key = Char(VK_SPACE)) then
      DoAction;
  end;
  if Assigned(FOnGridKeyPress) then
    FOnGridKeyPress(Sender, key);
end;

procedure Ts0DBGridAction.DoAction;
var
	executable: Boolean;
begin
  if Assigned(FOnActionQuery) then
  	FOnActionQuery(Self, executable);
  if not executable then
  	Exit;
  case FActionType of
    k0dgatInsert:
      begin
        FGrid.DataSource.DataSet.Insert;
      end;
    k0dgatDelete:
      begin
        FGrid.DataSource.DataSet.Delete;
      end;
  end;
end;

procedure Ts0DBGridAction.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  x, y: Integer;
begin
  if csDesigning in Self.ComponentState then
    Exit;
  if csLoading in Self.ComponentState then
    Exit;
  if Column.Field = FDummyField then
  begin
    if self.PictureStretch then
    begin
      FGrid.Canvas.StretchDraw(Rect, FPicture.Graphic);
    end
    else
    begin
      x := Rect.Left + (Rect.Right - Rect.Left - FPicture.Width) div 2;
      y := Rect.Top + (Rect.Bottom - Rect.Top - FPicture.Height) div 2;
      FGrid.Canvas.Draw(x, y, FPicture.Graphic);
    end;
  end;
  if Assigned(FOnGridDrawColumnCell) then
    FOnGridDrawColumnCell(Sender, Rect, DataCol, Column, State);
end;

procedure Ts0DBGridAction.SetDummyField(const Value: TField);
begin
  FDummyField := Value;
  if FDummyField <> nil then
  begin
    if FDummyField.Owner <> Self.Owner then
      FDummyField.InsertComponent(Self);
    if csDesigning in Self.ComponentState then
      FDummyField.ReadOnly := True;
  end;
end;

procedure Ts0DBGridAction.SetGrid(const Value: TDBGrid);
begin
  FGrid := Value;
  if FGrid <> nil then
  begin
    if FGrid.Owner <> Self.Owner then
      FGrid.InsertComponent(Self);
  end;
end;

procedure Ts0DBGridAction.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure Ts0DBGridAction.SetPictureStretch(const Value: Boolean);
begin
  FPictureStretch := Value;
end;

procedure Ts0DBGridAction.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  CheckProperties;
end;

procedure Ts0DBGridAction.SetActionType(const Value: K0DBGridActionType);
begin
  FActionType := Value;
end;

end.

