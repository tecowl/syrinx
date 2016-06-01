unit f8VersionHistory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0BaseGridCommand, s0BaseGrid, s0Grids, s0BindGrid, ExtCtrls, ComCtrls,
  StdCtrls, ActnList,
  c0SXVersionManager,
  s0TextComparer, s0DecoGrid;

type
  Tfrm8VersionHistory = class(TForm)
    Panel3: TPanel;
    Panel4: TPanel;
    btnShowDiff: TButton;
    ListView1: TListView;
    Splitter3: TSplitter;
    ActionList1: TActionList;
    actShowDiff: TAction;
    s0DecoGrid1: Ts0DecoGrid;
    c0GridCmd_CopyToClipBoard1: Ts0GridCmd_CopyToClipBoard;
    c0ShowAllColumns1: Ts0ShowAllColumns;
    chkTrimedCompare: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure actShowDiffUpdate(Sender: TObject);
    procedure actShowDiffExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FTargetItem: T0SXVersionManItem;
    FComparer: Ts0TextComparer;
    procedure SetTargetItem(const Value: T0SXVersionManItem);
  public
    property TargetItem: T0SXVersionManItem read FTargetItem write SetTargetItem;
  end;

var
  frm8VersionHistory: Tfrm8VersionHistory;

implementation

{$R *.DFM}

uses
  s0FileHelper,
  u0GridCellRect;

{ Tfrm8VersionHistory }

procedure Tfrm8VersionHistory.FormCreate(Sender: TObject);
begin
  FComparer := Ts0TextComparer.Create(nil);
end;

procedure Tfrm8VersionHistory.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FComparer);
end;

procedure Tfrm8VersionHistory.FormShow(Sender: TObject);
var
  i: Integer;
  vCount: Integer;
  item: TListItem;
  s: string;
begin
  ListView1.Items.Clear;
  if FTargetItem = nil then Exit;
  vCount := FTargetItem.GetVersionCount;
  for i := 0 to vCount -1 do
  begin
    item := ListView1.Items.Add;
    item.Caption := IntToStr(i);
    s := FTargetItem.GetVersionFileName(i);
    item.SubItems.Add( ExtractFileName(FTargetItem.GetSavePointDir(i)) );
    item.SubItems.Add( DateTimeToStr(Ts0FileHelper.GetFileDate(s)) );
  end;
end;

procedure Tfrm8VersionHistory.actShowDiffUpdate(Sender: TObject);
begin
  actShowDiff.Enabled := ListView1.SelCount in [1, 2];
end;

procedure Tfrm8VersionHistory.actShowDiffExecute(Sender: TObject);
  procedure NewColorDeco(ARow: Integer; AFontColor, AColor: TColor);
  var
    colDeco: Ts0ColorDecorator;
  begin
    colDeco := Ts0ColorDecorator(s0DecoGrid1.ColorDecos.Add);
    colDeco.Color := AColor;
    colDeco.FontColor := AFontColor;
    colDeco.RegionKind := k0gcrRows;
    colDeco.Top := ARow;
    colDeco.Bottom := ARow;
  end;
  procedure ShowResult(ACompared: Ts0CompareResultItems; ATitleA, ATitleB: string);
  var
    i: Integer;
  begin
    s0DecoGrid1.BeginUpdate;
    try
      s0DecoGrid1.ColorDecos.Clear;
      s0DecoGrid1.RowCount := ACompared.Count + 1;
      s0DecoGrid1.ReadOnlySeals[0].Bottom := s0DecoGrid1.RowCount -1;
      s0DecoGrid1.Cells[0, 0] := ATitleA;
      s0DecoGrid1.Cells[1, 0] := ATitleB;
      for i := 0 to ACompared.Count -1 do
      begin
        s0DecoGrid1.Cells[0, i+ 1] := ACompared.Items[i].Str1;
        s0DecoGrid1.Cells[1, i+ 1] := ACompared.Items[i].Str2;
        case ACompared.Items[i].ComparedType of
          kcrDifferent: NewColorDeco(i +1, clFuchsia, clLtGray);
          kcrEqual    : ;
          kcrLike     : NewColorDeco(i +1, clGreen, clLtGray);
        end;
      end;
    finally
      s0DecoGrid1.EndUpdate;
    end;
  end;
var
  verA, verB: Integer;
  i: Integer;
  tA, tB: string;
begin
  verA := -1;
  verB := -1;
  for i := 0 to ListView1.Items.Count -1 do
    if ListView1.Items[i].Selected then
    begin
      if verA < 0 then
        verA := i
      else
      if verB < 0 then
        verB := i;
    end;
  if verA < 0 then Exit;
  FComparer.Source[kskOne].LoadFromFile(FTargetItem.GetVersionFileName(verA));
  tA := IntToStr(verA);
  if verB > -1 then
  begin
    tB := IntToStr(verB);
    FComparer.Source[kskTwo].LoadFromFile(FTargetItem.GetVersionFileName(verB))
  end
  else
  begin
    tB := FTargetItem.Original;
    FComparer.Source[kskTwo].LoadFromFile(FTargetItem.Original);
  end;
  FComparer.TrimedCompare := chkTrimedCompare.Checked;
  FComparer.Compare;
  ShowResult(FComparer.CompareResult, tA, tB);
end;

procedure Tfrm8VersionHistory.SetTargetItem(const Value: T0SXVersionManItem);
begin
  FTargetItem := Value;
  if FTargetItem <> nil then
    Self.Caption := '[History] ' + FTargetItem.Original;
end;

end.
