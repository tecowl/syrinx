unit s0pe_fStrings;
{
$History: s0pe_fStrings.pas $
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 02/03/26   Time: 1:27
 * Created in $/D5/source/Designer
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated/Designer
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/21   Time: 23:34
 * Updated in $/source/D5Integrated/Designer
 * 正しくObjectｓが設定されない不具合の修正
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/08   Time: 23:04
 * Updated in $/source/p0common
 * コメントマクロを追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, ExtCtrls, Buttons;

type
  Ts0pe_frmStrings = class(TForm)
    PageControl1: TPageControl;
    tshPlianText: TTabSheet;
    tshObjects: TTabSheet;
    dspPlianText: TMemo;
    grdObjectsAsInt: TStringGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure grdObjectsAsIntSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FStrings: TStrings;
    procedure SetStrings(const Value: TStrings);
    procedure CopyToGrid;
    procedure CopyToMemo;
    procedure CopyTextToStrings;
    procedure CopyObjectsToStrings;
  public
    property Strings: TStrings read FStrings write SetStrings;
  end;

var
  frm0peStrings: Ts0pe_frmStrings;

implementation

{$R *.DFM}

{ Ts0pe_frmStrings }

procedure Ts0pe_frmStrings.grdObjectsAsIntSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (ACol = 1);
end;

procedure Ts0pe_frmStrings.SetStrings(const Value: TStrings);
begin
  FStrings := Value;
end;

procedure Ts0pe_frmStrings.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = tshPlianText then
  begin
    CopyObjectsToStrings;
    CopyToMemo;
  end
  else
  begin
    CopyTextToStrings;
    CopyToGrid;
  end;
end;

procedure Ts0pe_frmStrings.CopyToGrid;
var
  i: Integer;
begin
  if FStrings = nil then Exit;
  if FStrings.Count < 1 then
    grdObjectsAsInt.RowCount := grdObjectsAsInt.FixedRows + 1
  else
    grdObjectsAsInt.RowCount := FStrings.Count + grdObjectsAsInt.FixedRows;
  for i := 0 to FStrings.Count -1 do
  begin
    grdObjectsAsInt.Cells[0, i + grdObjectsAsInt.FixedRows] := FStrings.Strings[i];
    grdObjectsAsInt.Cells[1, i + grdObjectsAsInt.FixedRows] := IntToStr( Integer(FStrings.Objects[i]));
  end;
end;

procedure Ts0pe_frmStrings.FormShow(Sender: TObject);
begin
  grdObjectsAsInt.Cells[0, 0] := 'Strings';
  grdObjectsAsInt.Cells[1, 0] := 'Objects';
  if PageControl1.ActivePage = tshPlianText then
    CopyToMemo
  else
    CopyToGrid;
end;

procedure Ts0pe_frmStrings.CopyToMemo;
begin
  if FStrings = nil then Exit;
  dspPlianText.Lines.Assign(FStrings);
end;

procedure Ts0pe_frmStrings.CopyObjectsToStrings;
var
  i: Integer;
begin
  if FStrings = nil then Exit;
  FStrings.Clear;
  for i := 0 to grdObjectsAsInt.RowCount - grdObjectsAsInt.FixedRows -1 do
    FStrings.AddObject(
      grdObjectsAsInt.Cells[0, i + grdObjectsAsInt.FixedRows],
      TObject(StrToIntDef(grdObjectsAsInt.Cells[1, i + grdObjectsAsInt.FixedRows], 0))
    );
end;

procedure Ts0pe_frmStrings.CopyTextToStrings;
  procedure CopyFromMemo;
  var
    buf: TStringList;
    i: Integer;
  begin
    if FStrings = nil then Exit;
    buf := TStringList.Create;
    try
      buf.Assign(FStrings);
      FStrings.Assign(dspPlianText.Lines);
      for i := 0 to buf.Count -1 do
      begin
        if FStrings.Count < i + 1 then Exit;
        FStrings.Objects[i] := buf.Objects[i];
      end;
    finally
      FreeAndNil(buf);
    end;
  end;
begin
  if FStrings = nil then Exit;
  CopyFromMemo;
{
  for i := 0 to FStrings.Count -1 do
  begin
    if i + grdObjectsAsInt.FixedRows > grdObjectsAsInt.RowCount -1 then Exit;
    if FStrings.Count < i + 1 then Exit;
    FStrings.Objects[i] :=
      TObject( StrToIntDef(grdObjectsAsInt.Cells[1, i + grdObjectsAsInt.FixedRows], 0) );
  end;
}
end;

procedure Ts0pe_frmStrings.BitBtn1Click(Sender: TObject);
begin
  if PageControl1.ActivePage = tshPlianText then
  begin
    CopyTextToStrings;
  end
  else
  if PageControl1.ActivePage = tshObjects then
  begin
    CopyObjectsToStrings;
  end;
end;

end.
