unit f8EnumDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Grids, s0BindGrid, s0BaseGrid, s0DecoGrid, s0CtrlGrid, StdCtrls,
  Buttons, ExtCtrls, s0BaseGridCommand, s0CellDecorator, s0VCLClasses;

type
  Tfrm8EnumDlg = class(TForm)
    s0CtrlGrid1: Ts0BaseGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    c0GridCmd_CopyToClipBoard1: Ts0GridCmd_CopyToClipBoard;
    c0GridCmd_CutToClipBoard1: Ts0GridCmd_CutToClipBoard;
    c0GridCmd_DeleteSelection1: Ts0GridCmd_DeleteSelection;
    c0GridCmd_PasteFromClipBoard1: Ts0GridCmd_PasteFromClipBoard;
    c0GridCmd_InsertRow1: Ts0GridCmd_InsertRow;
    c0GridCmd_RemoveRow1: Ts0GridCmd_RemoveRow;
    c0ShowAllColumns1: Ts0ShowAllColumns;
  private
    FMembers: TStrings;
    procedure SetMembers(const Value: TStrings);
    { Private êÈåæ }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromMembers;
    procedure SaveToMembers;
    function ShowModal: Integer; override;
    property Members: TStrings read FMembers write SetMembers;
  end;

var
  frm8EnumDlg: Tfrm8EnumDlg;

implementation

{$R *.DFM}

{ Tfrm8EnumDlg }

constructor Tfrm8EnumDlg.Create(AOwner: TComponent);
begin
  inherited;
  FMembers := TStringList.Create;
end;

destructor Tfrm8EnumDlg.Destroy;
begin
  FreeAndNil(FMembers);
  inherited Destroy;
end;

procedure Tfrm8EnumDlg.LoadFromMembers;
var
  i: Integer;
  n, v: string;
begin
  s0CtrlGrid1.RowCount := FMembers.Count + 1;
  s0CtrlGrid1.ClearRow(1);
  for i := 0 to FMembers.Count -1 do
  begin
    n := FMembers.Names[i];
    v := FMembers.Values[ n ];
    if n = '' then Continue;
    s0CtrlGrid1.Cells[0, i + 1] := n;
    s0CtrlGrid1.Cells[1, i + 1] := v;
  end;
end;

procedure Tfrm8EnumDlg.SaveToMembers;
var
  i: Integer;
  n, v: string;
begin
  FMembers.Clear;
  for i := 1 to  s0CtrlGrid1.RowCount -1 do
  begin
    n := Trim(s0CtrlGrid1.Cells[0, i]);
    v := Trim(s0CtrlGrid1.Cells[1, i]);
    if n = '' then Continue;  
    FMembers.Values[ n ] :=  v;
  end;
end;

procedure Tfrm8EnumDlg.SetMembers(const Value: TStrings);
begin
  FMembers.Assign(Value);
end;

function Tfrm8EnumDlg.ShowModal: Integer;
begin
  LoadFromMembers;
  Result := inherited ShowModal;
  SaveToMembers;
end;

end.
