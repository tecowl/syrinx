unit s0IteratorMatrix;
{
$History: s0IteratorMatrix.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 8  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
	SysUtils, Classes, s0Matrix;

type
	Ts0IteMatrix = class(Ts0RowBaseMatrix)
  private
  	FPosition: Integer;
    function GetBof: Boolean;
    function GetEof: Boolean;
    procedure SetPosition(const Value: Integer);
    function GetCurrent(Index: Integer): string;
    procedure SetCurrent(Index: Integer; const Value: string);
    function GetIsLastRecord: Boolean;
  protected
    procedure DoPositionChanged; virtual;
  public
    procedure Assign(Source: TPersistent); override;
    //ITERATOR - Iterator
    property Position: Integer read FPosition write SetPosition;
    property Bof: Boolean read GetBof;
    property Eof: Boolean read GetEof;
    property IsLastRecord: Boolean read GetIsLastRecord;
    procedure Delete;
    procedure First;
    procedure Insert;
    procedure Last;
    procedure Next;
    procedure Prior;
    property Current[Index: Integer]: string read GetCurrent write SetCurrent;
  end;

implementation

{ Ts0IteMatrix }

procedure Ts0IteMatrix.First;
begin
  Position := 0;
end;

function Ts0IteMatrix.GetBof: Boolean;
begin
  Result := (Position = 0);
end;

function Ts0IteMatrix.GetEof: Boolean;
begin
  Result := (Position > Self.RowCount -1);
end;

procedure Ts0IteMatrix.SetPosition(const Value: Integer);
begin
  FPosition := Value;
	if Value > Self.RowCount -1 then FPosition := Self.RowCount;
	if Value < 0 then FPosition := 0;
  DoPositionChanged;
end;

procedure Ts0IteMatrix.Last;
begin
  Position := Self.RowCount -1;
end;

procedure Ts0IteMatrix.Next;
begin
	if Eof then Exit;
  Position := Position + 1;
end;

procedure Ts0IteMatrix.Prior;
begin
	if Bof then Exit;
  Position := Position - 1;
end;

function Ts0IteMatrix.GetCurrent(Index: Integer): string;
begin
  if Position < Self.RowCount then Result := Cells[Index, Position]
                              else Result := '';
end;

procedure Ts0IteMatrix.SetCurrent(Index: Integer; const Value: string);
begin
  Cells[Index, Position] := Value;
end;

procedure Ts0IteMatrix.Assign(Source: TPersistent);
begin
  inherited;
  if FPosition < 1 then FPosition := 0;
  if Self.RowCount -1 < FPosition then FPosition := Self.RowCount -1;
end;

procedure Ts0IteMatrix.Delete;
begin
  DelRow(FPosition);
end;

procedure Ts0IteMatrix.Insert;
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    for i := 0 to Self.ColCount -1 do
      sl.Add('');
    if Position > Self.RowCount -1 then
      Position := AddRow(sl)
    else
      Position := InsertRow(FPosition, sl);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0IteMatrix.DoPositionChanged;
begin

end;

function Ts0IteMatrix.GetIsLastRecord: Boolean;
begin
  Result := (FPosition = Self.RowCount -1);
end;

end.
