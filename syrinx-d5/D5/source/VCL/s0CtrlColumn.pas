unit s0CtrlColumn;
{
$History: s0CtrlColumn.pas $
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0control
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 *
 * *****************  Version 9  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマ ンド追加
}

interface

uses
  SysUtils, Classes, s0Collection,
  Controls,
  s0VCLClasses;

type
  Ts0CtrlColumn = class(Ts0VCLCollectionItem)
  private
    FTitle: string;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyUp: TKeyEvent;
    FOnKeyPress: TKeyPressEvent;
    function GetOwnerControl: TWinControl;
  protected
    procedure SetTitle(const Value: string); virtual;
    procedure DoClick; virtual;
    procedure DoDblClick; virtual;
    procedure DoEnter; virtual;
    procedure DoExit; virtual;
    procedure DoKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure DoKeyPress(var Key: Char); virtual;
    procedure DoKeyUp(var Key: Word; Shift: TShiftState); virtual;
  public
    procedure Assign(Source: TPersistent); override;
    property OwnerControl: TWinControl read GetOwnerControl;
    function CanEnter: Boolean; virtual;
    function CanExit: Boolean; virtual;
  published
    property Title: string read FTitle write SetTitle;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
  end;

type
  Ts0CtrlColumns = class(Ts0VCLCollection)
  private
    FHasError: Boolean;
    FPosition: Integer;
    function GetColumns(const Index: Integer): Ts0CtrlColumn;
    procedure SetColumns(const Index: Integer; const Value: Ts0CtrlColumn);
    procedure SetPosition(const Value: Integer);
  protected
    function GetCurrent: Ts0CtrlColumn; virtual;
    procedure SetCurrent(const Value: Ts0CtrlColumn); virtual;
    procedure PrepareColCout(AColCount: Integer);
  public
    constructor Create(AOwner: TPersistent; ItemClass: Ts0CollectionItemClass);
      reintroduce; virtual;
    procedure Assign(Source: TPersistent); override;
    property HasError: Boolean read FHasError write FHasError;
    property Current: Ts0CtrlColumn read GetCurrent write SetCurrent;
    property Columns[const Index: Integer]: Ts0CtrlColumn read GetColumns write
      SetColumns;
    property Position: Integer read FPosition write SetPosition;
  end;

implementation

{ Ts0CtrlColumn }

procedure Ts0CtrlColumn.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is Ts0CtrlColumn) then
    Exit;
  Self.Title := Ts0CtrlColumn(Source).Title;
  Self.OnClick := Ts0CtrlColumn(Source).OnClick;
  Self.OnDblClick := Ts0CtrlColumn(Source).OnDblClick;
  Self.OnEnter := Ts0CtrlColumn(Source).OnEnter;
  Self.OnExit := Ts0CtrlColumn(Source).OnExit;
  Self.OnKeyDown := Ts0CtrlColumn(Source).OnKeyDown;
  Self.OnKeyPress := Ts0CtrlColumn(Source).OnKeyPress;
  Self.OnKeyUp := Ts0CtrlColumn(Source).OnKeyUp;
end;

function Ts0CtrlColumn.CanEnter: Boolean;
begin
  Result := True;
end;

function Ts0CtrlColumn.CanExit: Boolean;
begin
  Result := True;
end;

procedure Ts0CtrlColumn.DoClick;
begin
  if csDesigning in GetOwnerComponent.ComponentState then
    Exit;
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure Ts0CtrlColumn.DoDblClick;
begin
  if csDesigning in GetOwnerComponent.ComponentState then
    Exit;
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

procedure Ts0CtrlColumn.DoEnter;
begin
  if csDesigning in GetOwnerComponent.ComponentState then
    Exit;
  if Assigned(FOnEnter) then
    FOnEnter(Self);
end;

procedure Ts0CtrlColumn.DoExit;
begin
  if csDesigning in GetOwnerComponent.ComponentState then
    Exit;
  if Assigned(FOnExit) then
    FOnExit(Self);
end;

procedure Ts0CtrlColumn.DoKeyDown(var Key: Word; Shift: TShiftState);
begin
  if csDesigning in GetOwnerComponent.ComponentState then
    Exit;
  if Assigned(FOnKeyDown) then
    FOnKeyDown(Self, Key, Shift);
end;

procedure Ts0CtrlColumn.DoKeyPress(var Key: Char);
begin
  if csDesigning in GetOwnerComponent.ComponentState then
    Exit;
  if Assigned(FOnKeyPress) then
    FOnKeyPress(Self, Key);
end;

procedure Ts0CtrlColumn.DoKeyUp(var Key: Word; Shift: TShiftState);
begin
  if csDesigning in GetOwnerComponent.ComponentState then
    Exit;
  if Assigned(FOnKeyUp) then
    FOnKeyUp(Self, Key, Shift);
end;

function Ts0CtrlColumn.GetOwnerControl: TWinControl;
begin
  Result := nil;
  if GetOwnerComponent is TWinControl then
    Result := TWinControl(GetOwnerComponent);
end;

procedure Ts0CtrlColumn.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

{ Ts0CtrlColumns }

procedure Ts0CtrlColumns.Assign(Source: TPersistent);
begin
  inherited;
  if not (Source is Ts0CtrlColumns) then
    Exit;
end;

constructor Ts0CtrlColumns.Create(AOwner: TPersistent;
  ItemClass: Ts0CollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
end;

function Ts0CtrlColumns.GetColumns(const Index: Integer): Ts0CtrlColumn;
begin
  Result := Ts0CtrlColumn(Items[Index]);
end;

function Ts0CtrlColumns.GetCurrent: Ts0CtrlColumn;
begin
  Result := nil;
end;

{
function Ts0CtrlColumns.GetPosition: Integer;
begin
  Result := FPosition;
end;
}

procedure Ts0CtrlColumns.PrepareColCout(AColCount: Integer);
var
  i: Integer;
  d: Integer;
begin
  d := AColCount - Self.Count;
  if d = 0 then
    Exit;
  if d > 0 then
  begin
    for i := 0 to d - 1 do
      Add;
  end
  else
  begin
    d := Abs(d);
    for i := 0 to d - 1 do
      Self.Delete(Self.Count - 1);
  end;
end;

procedure Ts0CtrlColumns.SetColumns(const Index: Integer;
  const Value: Ts0CtrlColumn);
begin
  Items[Index] := Value;
end;

procedure Ts0CtrlColumns.SetCurrent(const Value: Ts0CtrlColumn);
begin
  //FCurrent := Value;
end;

procedure Ts0CtrlColumns.SetPosition(const Value: Integer);
begin
  FPosition := Value;
end;

end.
