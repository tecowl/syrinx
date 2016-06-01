unit f0SelectItems;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ActnList, ComCtrls, s0MenuBar, ToolWin, StdCtrls,
  s0Grids, s0BindGrid, s0BaseGrid, s0DecoGrid, s0CtrlGrid, s0CollectionGrid,
  Buttons;

type
  Tfrm0SelectItems = class(TForm)
    lstSource: TListBox;
    Panel2: TPanel;
    lstDest: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstDestDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstDestDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstSourceDblClick(Sender: TObject);
    procedure lstDestDblClick(Sender: TObject);
  private
    FAllowDuplicateSelect: Boolean;
    FMoveString: Boolean;
    FDest: TStrings;
    FSource: TStrings;
    function AddToDest(AText: string): Integer;
    function AddToSource(AText: string): Integer;
    procedure DeleteSelections(AListBox: TListBox);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AllowDuplicateSelect: Boolean read FAllowDuplicateSelect write FAllowDuplicateSelect default False;
    property MoveString: Boolean read FMoveString write FMoveString default True;
    property Dest: TStrings read FDest;
    property Source: TStrings read FSource;
  end;

var
  frm0SelectItems: Tfrm0SelectItems;

implementation

{$R *.DFM}

{ Tfrm0SelectItems }

function Tfrm0SelectItems.AddToDest(AText: string): Integer;
  function CanAddToDest(AText: string): Boolean;
  begin
    Result := True;
    if not AllowDuplicateSelect then Exit;
    Result := lstDest.Items.IndexOf(AText) < 0;
  end;
begin
  Result := -1;
  if not CanAddToDest(AText) then Exit;
  Result := lstDest.Items.Add(AText);
end;

function Tfrm0SelectItems.AddToSource(AText: string): Integer;
begin
  Result := lstSource.Items.Add(AText);
end;

constructor Tfrm0SelectItems.Create(AOwner: TComponent);
begin
  inherited;
  FDest := TStringList.Create;
  FSource:= TStringList.Create;
  FMoveString := True;
  FAllowDuplicateSelect := False;
end;

destructor Tfrm0SelectItems.Destroy;
begin
  FreeAndNil(FDest);
  FreeAndNil(FSource);
  inherited;
end;

procedure Tfrm0SelectItems.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lstSource.Items.Count -1 do
    if lstSource.Selected[i] then
      AddToDest(lstSource.Items.Strings[i]);
  if FMoveString then
    DeleteSelections(lstSource);
end;

procedure Tfrm0SelectItems.Button2Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lstSource.Items.Count -1 do
    AddToDest(lstSource.Items.Strings[i]);
  if FMoveString then
    lstSource.Items.Clear;
end;

procedure Tfrm0SelectItems.Button3Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lstDest.Items.Count -1 do
    if lstDest.Selected[i] then
      AddToSource(lstDest.Items.Strings[i]);
  if FMoveString then
    DeleteSelections(lstDest);
end;

procedure Tfrm0SelectItems.Button4Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lstDest.Items.Count -1 do
    AddToSource(lstDest.Items.Strings[i]);
  if FMoveString then
    lstDest.Items.Clear;
end;

procedure Tfrm0SelectItems.BitBtn1Click(Sender: TObject);
begin
  FDest.Assign( lstDest.Items );
end;

procedure Tfrm0SelectItems.FormShow(Sender: TObject);
begin
  lstSource.Items.Assign( FSource );
end;

procedure Tfrm0SelectItems.DeleteSelections(AListBox: TListBox);
var
  i: Integer;
begin
  for i := AListBox.Items.Count -1 downto 0 do
    if AListBox.Selected[i] then
      AListBox.Items.Delete(i);
end;

procedure Tfrm0SelectItems.lstDestDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  src, dst: TListBox;
  i: Integer;
begin
  Accept := False;
  if Sender = Source then Exit;
  src := nil;
  dst := nil;
  if Source is TListBox then src := TListBox(Source);
  if Sender is TListBox then dst := TListBox(Sender);
  if src = nil then Exit;
  if dst = nil then Exit;
  Accept := True;
  if not FMoveString then Exit;
  Accept := False;
  for i := 0 to src.Items.Count -1 do
    if src.Selected[i] then
      if dst.Items.IndexOf(src.Items.Strings[i]) > -1 then
        Exit;
  Accept := True;
end;

procedure Tfrm0SelectItems.lstDestDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  src, dst: TListBox;
  i: Integer;
begin
  src := nil;
  dst := nil;
  if Source is TListBox then src := TListBox(Source);
  if Sender is TListBox then dst := TListBox(Sender);
  if src = nil then Exit;
  if dst = nil then Exit;
  for i := 0 to src.Items.Count -1 do
    if src.Selected[i] then
      dst.Items.Add(src.Items.Strings[i]);
  if not FMoveString then Exit;
  DeleteSelections(src);
end;

procedure Tfrm0SelectItems.lstSourceDblClick(Sender: TObject);
begin
  if lstSource.ItemIndex < 0 then Exit;
  AddToDest( lstSource.Items.Strings[ lstSource.ItemIndex ] );
  if not FMoveString then Exit;
  lstSource.Items.Delete( lstSource.ItemIndex );
end;

procedure Tfrm0SelectItems.lstDestDblClick(Sender: TObject);
begin
  if lstDest.ItemIndex < 0 then Exit;
  AddToSource( lstDest.Items.Strings[ lstDest.ItemIndex ] );
  if not FMoveString then Exit;
  lstDest.Items.Delete( lstDest.ItemIndex );
end;

end.
