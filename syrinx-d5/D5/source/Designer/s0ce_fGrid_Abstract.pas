unit s0ce_fGrid_Abstract;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Grids, s0CellDecorator, StdCtrls, Buttons, ExtCtrls;

type
  Ts0ce_frmGrid_Abstract = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    pnlChecks: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FTargetGrid: Ts0CustomDecoStringGrid;
    function GetCheckBoxes(const APropName: string): TCheckBox;
  protected
    function GetDispGrid: Ts0CustomDecoStringGrid; virtual;
    procedure SetTargetGrid(const Value: Ts0CustomDecoStringGrid); virtual;
    procedure AssignGrid(Source, Dest: Ts0CustomDecoStringGrid); virtual;
    procedure CopyCellsValue(Source, Dest: Ts0CustomDecoStringGrid);
    property CheckBoxes[const APropName: string]: TCheckBox read GetCheckBoxes;
  public
    procedure RefreshDispGrid; virtual;
    procedure CopyToTarget; virtual;
    property TargetGrid: Ts0CustomDecoStringGrid read FTargetGrid write SetTargetGrid;
  end;

var
  frm0ceGrid_Abstract: Ts0ce_frmGrid_Abstract;

implementation

{$R *.DFM}

uses
  Contnrs,
  s0TypInfoWrapper;

{ Ts0ce_frmGrid_Abstract }

function Ts0ce_frmGrid_Abstract.GetDispGrid: Ts0CustomDecoStringGrid;
begin
  Result := nil;
end;

const
  c9IntPropNames: array[0..7] of string = (
    'ColCount',        'RowCount',
    'FixedCols',       'FixedRows',
    'DefaultColWidth', 'DefaultRowHeight',
    'GridLineWidth',
    'FixedColor'
  );

procedure Ts0ce_frmGrid_Abstract.AssignGrid(Source, Dest: Ts0CustomDecoStringGrid);
  procedure AssignIntProps(ADisp, ATarget: Ts0CustomDecoStringGrid);
  var
    dgAcsr, tgAcsr: Ts0RTTIPublishedAccessor;
    i: Integer;
    pn: string;
  begin
    dgAcsr := Ts0RTTIPublishedAccessor.Create(ADisp);
    try
      tgAcsr := Ts0RTTIPublishedAccessor.Create(ATarget);
      try
        for i := Low(c9IntPropNames) to High(c9IntPropNames) do
        begin
          pn := c9IntPropNames[i];
          if not CheckBoxes[pn].Checked then Continue;
          if not dgAcsr.PropertyExists(pn) then Continue;
          if not tgAcsr.PropertyExists(pn) then Continue;
          dgAcsr.OrdProp[pn] := tgAcsr.OrdProp[pn];
        end;
      finally
        FreeAndNil(tgAcsr);
      end;
    finally
      FreeAndNil(dgAcsr);
    end;
  end;
  procedure AssignDecos(ADisp, ATarget: Ts0CustomDecoStringGrid);
  var
    dispDecos: Ts0CellDecorators;
    decosList: TObjectList;
    i: Integer;
  begin
    decosList := TObjectList.Create(False);
    try
      ATarget.GetDecoList(decosList);
      for i := 0 to decosList.Count -1 do
      begin
        if decosList.Items[i] is Ts0CellDecorators then
        begin
          dispDecos := ADisp.GetDecorators( Ts0CellDecoratorsClass(decosList.Items[i].ClassType) );
          if dispDecos = nil then Continue;
          dispDecos.Assign( Ts0CellDecorators(decosList.Items[i]) );
        end;
      end;
    finally
      FreeAndNil(decosList);
    end;
  end;
var
  i: Integer;
begin
  AssignIntProps(Dest, Source);
  //
  if CheckBoxes['ColWidths'].Checked then
    for i := 0 to Source.ColCount -1 do Dest.ColWidths[i] := Source.ColWidths[i];
  if CheckBoxes['RowHeights'].Checked then
    for i := 0 to Source.RowCount -1 do Dest.RowHeights[i] := Source.RowHeights[i];
  //
  AssignDecos(Dest, Source);   
end;

procedure Ts0ce_frmGrid_Abstract.SetTargetGrid(const Value: Ts0CustomDecoStringGrid);
begin
  FTargetGrid := Value;
end;

procedure Ts0ce_frmGrid_Abstract.CopyToTarget;
begin
  AssignGrid(GetDispGrid, FTargetGrid);
end;

procedure Ts0ce_frmGrid_Abstract.RefreshDispGrid;
begin
  AssignGrid(FTargetGrid, GetDispGrid);
  CopyCellsValue(FTargetGrid, GetDispGrid);
end;

procedure Ts0ce_frmGrid_Abstract.BitBtn1Click(Sender: TObject);
begin
  CopyToTarget;
end;

procedure Ts0ce_frmGrid_Abstract.FormShow(Sender: TObject);
begin
  RefreshDispGrid;
end;

procedure Ts0ce_frmGrid_Abstract.FormCreate(Sender: TObject);
  function CreateNewCheckBox(ACaption: string; APosition: Integer): TCheckBox;
  const
    c9Margin = 4;
    c9CheckHeight = 22;
  begin
    Result := TCheckBox.Create(Self);
    Result.Parent := pnlChecks;
    Result.Top := APosition * c9CheckHeight + c9Margin;
    Result.Left := 6;
    Result.Width := pnlChecks.ClientWidth - Result.Left - c9Margin;
    Result.Caption := ACaption;
    Result.Checked := True;
  end;
var
  i: Integer;
begin
  for i := Low(c9IntPropNames) to High(c9IntPropNames) do
    CreateNewCheckBox(c9IntPropNames[i], i);
  CreateNewCheckBox('ColWidths', High(c9IntPropNames) + 1);
  CreateNewCheckBox('RowHeights', High(c9IntPropNames) + 2);
end;

function Ts0ce_frmGrid_Abstract.GetCheckBoxes(const APropName: string): TCheckBox;
var
  i: Integer;
begin          
  for i := 0 to pnlChecks.ControlCount -1 do
    if pnlChecks.Controls[i] is TCheckBox then
    begin
      Result := TCheckBox(pnlChecks.Controls[i]);
      if SameText(Result.Caption, APropName) then
        Exit;
    end;
  Result := nil;
end;

procedure Ts0ce_frmGrid_Abstract.CopyCellsValue(Source,
  Dest: Ts0CustomDecoStringGrid);
var
  i, j: Integer;
begin
  for i := 0 to Source.RowCount -1 do
    for j := 0 to Source.ColCount -1 do
      Dest.Cells[j, i] := Source.Cells[j, i];
end;

end.
