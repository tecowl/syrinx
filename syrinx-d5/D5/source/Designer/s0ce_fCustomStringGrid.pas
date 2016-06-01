{-----------------------------------------------------------------------------
 Unit Name: s0ce_fCustomStringGrid
 Author:    Akima
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit s0ce_fCustomStringGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ce_fGrid_Abstract, StdCtrls, Buttons, ExtCtrls, s0Grids, s0CellDecorator,
  s0BindGrid, s0CtrlGrid, s0DecoGrid, s0BaseGrid;

type
  Ts0ce_frmCustomStringGrid = class(Ts0ce_frmGrid_Abstract)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FDispGrid: Ts0BaseGrid;
  public
    function GetDispGrid: Ts0CustomDecoStringGrid; override;
  end;

var
  frm0ceCustomStringGrid: Ts0ce_frmCustomStringGrid;

implementation

{$R *.DFM}

uses
  s0BaseGridCommand;

{ Ts0ce_frmGrid_Abstract3 }

function Ts0ce_frmCustomStringGrid.GetDispGrid: Ts0CustomDecoStringGrid;
begin
  Result := FDispGrid;
end;

procedure Ts0ce_frmCustomStringGrid.FormCreate(Sender: TObject);
begin
  inherited FormCreate(Sender);
  FDispGrid := Ts0BaseGrid.Create(Self);
  FDispGrid.Parent := Self;
  FDispGrid.Align := alClient;
  FDispGrid.FixedCols := 0;
  FDispGrid.FixedRows := 0;
  //
//  FDispGrid.AutoEditingMode := True;
  FDispGrid.Commands.AddItem(Ts0GridCmd_CopyToClipBoard);
  FDispGrid.Commands.AddItem(Ts0GridCmd_CutToClipBoard);
  FDispGrid.Commands.AddItem(Ts0GridCmd_PasteFromClipBoard);
  FDispGrid.Commands.AddItem(Ts0GridCmd_DeleteSelection);
  FDispGrid.Commands.AddItem(Ts0GridCmd_SelectAll);
  FDispGrid.Commands.AddItem(Ts0GridCmd_InsertCol);
  FDispGrid.Commands.AddItem(Ts0GridCmd_InsertRow);
  FDispGrid.Commands.AddItem(Ts0GridCmd_RemoveCol);
  FDispGrid.Commands.AddItem(Ts0GridCmd_RemoveRow);
  FDispGrid.CreateCmdMenu;

//  FDispGrid.Options := FDispGrid.Options + [goRowSizing, goColSizing, goEditing];
end;

procedure Ts0ce_frmCustomStringGrid.FormShow(Sender: TObject);
var
  chk: TCheckBox;
begin
  chk := CheckBoxes['FixedCols'];
  chk.Checked := False;
  chk.Enabled := False;
  chk := CheckBoxes['FixedRows'];
  chk.Checked := False;
  chk.Enabled := False;
  inherited FormShow(Sender);
end;

procedure Ts0ce_frmCustomStringGrid.BitBtn1Click(Sender: TObject);
begin
  inherited BitBtn1Click(Sender);
  CopyCellsValue(FDispGrid, TargetGrid);
end;

end.
