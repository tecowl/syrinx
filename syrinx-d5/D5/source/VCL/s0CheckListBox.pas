unit s0CheckListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst,
  s0DataAccessor,
  s0CtrlDistiller;

type
  K0CheckListBoxAsStringKind = (k0clbasItems, k0clbasAlias);

type
  Ts0CheckListBox = class;

  Ts0CheckListBoxAccessor = class(Ts0StringsAccessor)
  private
    FAliasBased: Boolean;
    FCheckedString: Boolean;
    function GetOwnerCheckListBox: Ts0CheckListBox;
  protected
    function GetItemIndex: Integer; override;
    function GetSource: TStrings; override;
    procedure SetItemIndex(const Value: Integer); override;
    //
    function GetAsString: String; override;
    procedure SetAsString(const Value: String); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AliasBased: Boolean read FAliasBased write FAliasBased default False;
    property CheckedString: Boolean read FCheckedString write FCheckedString default True;
  end;

  Ts0CheckListBox = class(TCheckListBox)
  private
    FAccessor: Ts0CheckListBoxAccessor;
    FItemAlias: TStrings;
    procedure SetAccessor(const Value: Ts0CheckListBoxAccessor);
    procedure SetItemAlias(const Value: TStrings);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AliasToItem(Alias: string): string;
    function ItemToAlias(AItem: string): string;
    property Accessor: Ts0CheckListBoxAccessor read FAccessor write SetAccessor;
  published
    property ItemAlias: TStrings read FItemAlias write SetItemAlias;
  end;

type
  Ts0CheckListBoxDistiller = class(Ts0CtrlDistiller)
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
  s0StringsHelper;

{ Ts0CheckListBoxAccessor }

constructor Ts0CheckListBoxAccessor.Create(AOwner: TComponent);
begin
  inherited;
  FAliasBased := False;
  FCheckedString := True;
end;

function Ts0CheckListBoxAccessor.GetAsString: String;
var
  sl: TStringList;
  i: Integer;
  s: string;
begin
  if CheckedString then
  begin
    sl := TStringList.Create;
    try
      for i := 0 to GetOwnerCheckListBox.Items.Count -1 do
      begin
        if GetOwnerCheckListBox.Checked[i] then
        begin
          s := GetOwnerCheckListBox.Items.Strings[i];
          if FAliasBased then
            s := GetOwnerCheckListBox.ItemToAlias(s);
          sl.Add( s );
        end;
      end;
      Result := sl.CommaText;
    finally
      FreeAndNil(sl);
    end;
  end
  else
  begin
    Result := inherited GetAsString;
  end;
end;

function Ts0CheckListBoxAccessor.GetItemIndex: Integer;
begin
  Result := GetOwnerCheckListBox.ItemIndex;
end;

function Ts0CheckListBoxAccessor.GetOwnerCheckListBox: Ts0CheckListBox;
begin
  Result := Ts0CheckListBox(Owner);
end;

function Ts0CheckListBoxAccessor.GetSource: TStrings;
begin
  Result := GetOwnerCheckListBox.Items;
end;

procedure Ts0CheckListBoxAccessor.SetAsString(const Value: String);
var
  sl: TStringList;
  i: Integer;
  s: string;
begin
  if CheckedString then
  begin
    sl := TStringList.Create;
    try
      sl.CommaText := Value;
      for i := 0 to GetOwnerCheckListBox.Items.Count -1 do
      begin
        s := GetOwnerCheckListBox.Items.Strings[i];
        if FAliasBased then
          s := GetOwnerCheckListBox.ItemToAlias(s);
        GetOwnerCheckListBox.Checked[i] := (sl.IndexOf( s ) > -1);
      end;
    finally
      FreeAndNil(sl);
    end;
  end
  else
  begin
    inherited SetAsString(Value);
  end;
end;

procedure Ts0CheckListBoxAccessor.SetItemIndex(const Value: Integer);
begin
  GetOwnerCheckListBox.ItemIndex := Value;
end;

{ Ts0CheckListBox }

function Ts0CheckListBox.AliasToItem(Alias: string): string;
var
  idx: Integer;
begin
  Result := '';
  idx := Ts0StringsHelper.IndexOfValue(ItemAlias, Alias);
  if idx < 0 then Exit;
  Result := ItemAlias.Names[ idx ];
end;

constructor Ts0CheckListBox.Create(AOwner: TComponent);
begin
  inherited;
  FAccessor := Ts0CheckListBoxAccessor.Create(Self);
  FItemAlias := TStringList.Create;
end;

destructor Ts0CheckListBox.Destroy;
begin
  FreeAndNil(FItemAlias);
  FreeAndNil(FAccessor);
  inherited Destroy;
end;

function Ts0CheckListBox.ItemToAlias(AItem: string): string;
begin
  Result := ItemAlias.Values[ AItem ];
end;

procedure Ts0CheckListBox.SetAccessor(const Value: Ts0CheckListBoxAccessor);
begin
  FAccessor.Assign(Value);
end;

procedure Ts0CheckListBox.SetItemAlias(const Value: TStrings);
begin
  FItemAlias.Assign(Value);
end;

{ Ts0CheckListBoxDistiller }

class procedure Ts0CheckListBoxDistiller.Click(AControl: TObject);
begin
  Ts0CheckListBox(AControl).ClickCheck;
end;

class function Ts0CheckListBoxDistiller.GetAccessor(
  AControl: TObject): Ts0DataAccessor;
begin
  Result := Ts0CheckListBox(AControl).Accessor;
end;

class function Ts0CheckListBoxDistiller.GetFocusEvents(
  AControl: TObject): R0FocusEvents;
begin
  Result.FOnEnter := Ts0CheckListBox(AControl).OnEnter;
  Result.FOnExit  := Ts0CheckListBox(AControl).OnExit ;
end;

class function Ts0CheckListBoxDistiller.GetKeyEvents(
  AControl: TObject): R0KeyEvents;
begin
  Result.FOnKeyDown  := Ts0CheckListBox(AControl).OnKeyDown;
  Result.FOnKeyPress := Ts0CheckListBox(AControl).OnKeyPress ;
  Result.FOnKeyUp    := Ts0CheckListBox(AControl).OnKeyUp;
  Result.FOnChange   := nil;
end;

class function Ts0CheckListBoxDistiller.GetMouseEvents(
  AControl: TObject): R0MouseEvents;
begin
  Result.FOnClick     := Ts0CheckListBox(AControl).OnClickCheck;
  Result.FOnDblClick  := Ts0CheckListBox(AControl).OnDblClick  ;
  Result.FOnMouseDown := Ts0CheckListBox(AControl).OnMouseDown ;
  Result.FOnMouseMove := Ts0CheckListBox(AControl).OnMouseMove ;
  Result.FOnMouseUp   := Ts0CheckListBox(AControl).OnMouseUp   ;
end;

class function Ts0CheckListBoxDistiller.GetSizeEvents(
  AControl: TObject): R0SizeEvents;
begin
  Result.FOnCanResize := Ts0CheckListBox(AControl).OnCanResize;
  Result.FOnResize    := Ts0CheckListBox(AControl).OnResize   ;
end;

class function Ts0CheckListBoxDistiller.GetTitle(AControl: TObject): string;
begin
  Result := '';
end;

class function Ts0CheckListBoxDistiller.GetUpdateEvents(
  AControl: TObject): K0CtrlEventTypeSet;
begin
  Result := [k0cetOnClick, k0cetOnPressEnter];
end;

class function Ts0CheckListBoxDistiller.GetValue(AControl: TObject): string;
begin
  Result := GetAccessor(AControl).AsString;
end;

class function Ts0CheckListBoxDistiller.IsTarget(
  AControl: TObject): Boolean;
begin
  Result := AControl is Ts0CheckListBox;
end;

class procedure Ts0CheckListBoxDistiller.KeyDown(AControl: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Ts0CheckListBox(AControl).KeyDown(Key, Shift);
end;

class procedure Ts0CheckListBoxDistiller.MouseDown(AControl: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Ts0CheckListBox(AControl).MouseDown(Button, Shift, X, Y);
end;

class procedure Ts0CheckListBoxDistiller.SetFocusEvents(
  Value: R0FocusEvents; AControl: TObject);
begin
  Ts0CheckListBox(AControl).OnEnter := Value.FOnEnter;
  Ts0CheckListBox(AControl).OnExit  := Value.FOnExit ;
end;

class procedure Ts0CheckListBoxDistiller.SetKeyEvents(Value: R0KeyEvents;
  AControl: TObject);
begin
  Ts0CheckListBox(AControl).OnKeyDown  := Value.FOnKeyDown ;
  Ts0CheckListBox(AControl).OnKeyPress := Value.FOnKeyPress;
  Ts0CheckListBox(AControl).OnKeyUp    := Value.FOnKeyUp   ;
end;

class procedure Ts0CheckListBoxDistiller.SetMouseEvents(
  Value: R0MouseEvents; AControl: TObject);
begin
  Ts0CheckListBox(AControl).OnClickCheck := Value.FOnClick    ;
  Ts0CheckListBox(AControl).OnDblClick   := Value.FOnDblClick ;
  Ts0CheckListBox(AControl).OnMouseDown  := Value.FOnMouseDown;
  Ts0CheckListBox(AControl).OnMouseMove  := Value.FOnMouseMove;
  Ts0CheckListBox(AControl).OnMouseUp    := Value.FOnMouseUp  ;
end;

class procedure Ts0CheckListBoxDistiller.SetSizeEvents(Value: R0SizeEvents;
  AControl: TObject);
begin
  Ts0CheckListBox(AControl).OnCanResize := Value.FOnCanResize;
  Ts0CheckListBox(AControl).OnResize    := Value.FOnResize   ;
end;

class procedure Ts0CheckListBoxDistiller.SetTitle(Value: string;
  AControl: TObject);
begin
end;

class procedure Ts0CheckListBoxDistiller.SetValue(Value: string;
  AControl: TObject);
begin
  GetAccessor(AControl).AsString := Value;
end;

initialization
  Ts0CtrlDistillBroker.RegisterDistiller(Ts0CheckListBoxDistiller);

finalization
  Ts0CtrlDistillBroker.UnRegisterDistiller(Ts0CheckListBoxDistiller);

end.
