unit tec1DBGrid;

interface

uses
  SysUtils, Classes, Graphics, Controls,
  Grids, DB, DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  s0DSCopy;

type
  Ktec1DBGridPopupMenuItemType = (kt1dbgpmSortMode, kt1dbgpmColumnSelectMode,
    kt1dbgpmCopuToClipboard, kt1dbgpmSaveToCsvFile);
  Ktec1DBGridPopupMenuItemTypeSet = set of Ktec1DBGridPopupMenuItemType;

type
  Ttec1DBGrid = class(TJvDBUltimGrid)
  private
    FAutoPopupMenu: Boolean;
    FPopupMenuItems: Ktec1DBGridPopupMenuItemTypeSet;
    procedure SetPopupMenuItems(
      const Value: Ktec1DBGridPopupMenuItemTypeSet);
  protected
    procedure Loaded; override;
    procedure clickSortMode(Sender: TObject);
    procedure clickColSelMode(Sender: TObject);
    procedure clickCopyToClipboard(Sender: TObject);
    procedure clickSaveToCsvFile(Sender: TObject);
    procedure doDSCopyAction(ActionType: Ks0DSCopyActionType);
    function CreateGridDataSet: TDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    procedure BuildPopupMenu;
  published
    property AutoPopupMenu: Boolean read FAutoPopupMenu write FAutoPopupMenu
      default True;
    property PopupMenuItems: Ktec1DBGridPopupMenuItemTypeSet read FPopupMenuItems
      write SetPopupMenuItems;
    property AlternateRowColor default $00DAFCF1;
  end;

type
  Etec1DBGrid = class(Exception);

procedure Register;

implementation

uses
  Menus, JvMemoryDataset;

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1DBGrid]);
end;

{ Ttec1DBGrid }

procedure Ttec1DBGrid.BuildPopupMenu;
var
  countAfterSeparator: Integer;

  function CreateMenuItem(Menu: TPopupMenu; AType: Ktec1DBGridPopupMenuItemType;
    ACaption: string; AHandler: TNotifyEvent; AGroupIndex:
    Integer = 0; ARadioItem: Boolean = False): TMenuItem;
  begin
    Result := nil;
    if not (AType in FPopupMenuItems) then
      Exit;
    Inc(countAfterSeparator);
    Result := TMenuItem.Create(Self.Owner);
    Result.Caption := ACaption;
    Result.GroupIndex := AGroupIndex;
    Result.RadioItem := ARadioItem;
    Result.OnClick := AHandler;
    Menu.Items.Add(Result);
  end;
  function CreateSeparator(Menu: TPopupMenu): TMenuItem;
  begin
    Result := nil;
    if countAfterSeparator = 0 then
      Exit;
    countAfterSeparator := 0;
    Result := TMenuItem.Create(Self.Owner);
    Result.Caption := '-';
    Menu.Items.Add(Result);
  end;
const
  c9ModeGroup = 1;
var
  popup: TPopupMenu;
begin
  if FPopupMenuItems = [] then
    Exit;
  countAfterSeparator := 0;
  popup := TPopupMenu.Create(Self.Owner);
  CreateMenuItem(popup, kt1dbgpmSortMode, '並び替えモード',
    clickSortMode, c9ModeGroup, True);
  CreateMenuItem(popup, kt1dbgpmColumnSelectMode, '列選択モード',
    clickColSelMode, c9ModeGroup, True);
  CreateSeparator(popup);
  CreateMenuItem(popup, kt1dbgpmCopuToClipboard, 'クリップボードにコピー',
    clickCopyToClipboard);
  CreateMenuItem(popup, kt1dbgpmSaveToCsvFile, 'CSVファイルとして保存',
    clickSaveToCsvFile);
  Self.PopupMenu := popup;
end;

procedure Ttec1DBGrid.clickColSelMode(Sender: TObject);
begin
  Self.TitleArrow := True;
  Self.TitleButtons := False;
  if Sender is TMenuItem then
    TMenuItem(Sender).Checked := True;
end;

procedure Ttec1DBGrid.clickCopyToClipboard(Sender: TObject);
begin
  doDSCopyAction(k0dscatToClipboard);
end;

procedure Ttec1DBGrid.clickSaveToCsvFile(Sender: TObject);
begin
  doDSCopyAction(k0dscatToCSV);
end;

procedure Ttec1DBGrid.clickSortMode(Sender: TObject);
begin
  Self.TitleArrow := False;
  Self.TitleButtons := True;
  if Sender is TMenuItem then
    TMenuItem(Sender).Checked := True;
end;

constructor Ttec1DBGrid.Create(AOwner: TComponent);
begin
  inherited;
  AlternateRowColor := $00DAFCF1;
  FAutoPopupMenu := True;
  FPopupMenuItems := [kt1dbgpmSortMode, kt1dbgpmColumnSelectMode,
    kt1dbgpmCopuToClipboard, kt1dbgpmSaveToCsvFile];
end;

function Ttec1DBGrid.CreateGridDataSet: TDataSet;

type
  TFields = array of TField;

  function CopyFieldDefs(Dest: TJvMemoryData): TFields;
  var
    i, idx: Integer;
    col: TColumn;
    f: TField;
    def: TFieldDef;
  begin
    SetLength(Result, Self.ColCount);
    idx := 0;
    for i := 0 to Self.Columns.Count - 1 do
    begin
      col := Self.Columns[i];
      if not col.Visible then
        Continue;
      f := col.Field;
      def := Dest.FieldDefs.AddFieldDef;
      def.Name := f.Name;
      if f.FieldKind = fkData then
      begin
        def.DataType := f.DataType;
        def.Size := f.Size;
      end
      else
      begin
        def.DataType := ftString;
        def.Size := 255;
      end;
      def.Required := False;
      def.DisplayName := col.Title.Caption;
      Result[idx] := f;
      idx := idx + 1;
    end;
    SetLength(Result, idx);
  end;
  procedure CopyRecords(Dest: TJvMemoryData; srcFields: array of TField);
  var
    i: Integer;
    srcF, destF: TField;
    baseDS: TDataSet;
    currentRecord: TBookmark;
  begin
    Self.BeginUpdate;
    try
      baseDS := Self.DataSource.DataSet;
      currentRecord := baseDS.GetBookmark;
      try
        baseDS.First;
        while not baseDS.Eof do
        begin
          Dest.Append;
          for i := 0 to Dest.Fields.Count - 1 do
          begin
            destF := Dest.Fields[i];
            srcF := srcFields[i];
            destF.AsString := srcF.Text;
          end;
          Result.Post;
          baseDS.Next;
        end;
      finally
        baseDS.GotoBookmark(currentRecord);
        baseDS.FreeBookmark(currentRecord);
      end;
    finally
      Self.EndUpdate;
    end;
  end;
var
  srcFields: TFields;
begin
  Result := TJvMemoryData.Create(nil);
  srcFields := CopyFieldDefs(TJvMemoryData(Result));
  Result.Open;
  CopyRecords(TJvMemoryData(Result), srcFields);
end;

procedure Ttec1DBGrid.doDSCopyAction(ActionType: Ks0DSCopyActionType);
var
  copier: Ts0DSCopy;
  ds: TDataSet;
begin
  if Self.DataSource = nil then
    raise Etec1DBGrid.Create('DataSourceが指定されていません。');
  if Self.DataSource.DataSet = nil then
    raise Etec1DBGrid.Create('DataSourceのDataSetが指定されていません。');
  copier := Ts0DSCopy.Create(nil);
  try
    copier.ActionType := ActionType;
    ds := CreateGridDataSet;
    try
      copier.DataSet := ds;
      copier.DoAction;
    finally
      FreeAndNil(ds);
    end;
  finally
    FreeAndNil(copier);
  end;
end;

procedure Ttec1DBGrid.Loaded;
begin
  inherited;
  if csDesigning in Self.ComponentState then
    Exit;
  if AutoPopupMenu then
    BuildPopupMenu;
end;

procedure Ttec1DBGrid.SetPopupMenuItems(
  const Value: Ktec1DBGridPopupMenuItemTypeSet);
begin
  FPopupMenuItems := Value;
end;

end.

