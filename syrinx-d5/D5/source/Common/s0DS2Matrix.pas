unit s0DS2Matrix;
{
$History: s0DS2Matrix.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/30   Time: 17:09
 * Created in $/source/D5/p0db
 * 新規作成
 * 
 * *****************  Version 6  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:39
 * Updated in $/GUI/Source/Doc
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes, DB,
  s0Matrix;

type
  Ts0DS2Matrix = class(TComponent)
  private
    FSourceDS: TDataSet;
    FCopyFromFirst: Boolean;
    procedure SetSourceDS(const Value: TDataSet);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecCopyAll(Dest: Ts0Matrix); virtual;
    procedure ExecCopy(Dest: Ts0Matrix; AFieldOrder: array of TField); virtual;
  published
    property CopyFromFirst: Boolean read FCopyFromFirst write FCopyFromFirst default True;
    property SourceDS: TDataSet read FSourceDS write SetSourceDS;
  end;

implementation

uses
  s0IteratorMatrix;


{ Ts0DS2Matrix }

constructor Ts0DS2Matrix.Create(AOwner: TComponent);
begin
  inherited;
  FCopyFromFirst := True;
end;

destructor Ts0DS2Matrix.Destroy;
begin

  inherited;
end;

procedure Ts0DS2Matrix.ExecCopy(Dest: Ts0Matrix;
  AFieldOrder: array of TField);
var
  sl: TStringList;
  i: Integer;
begin
  if FSourceDS = nil then Exit;
  if FCopyFromFirst then FSourceDS.First;

//  if Dest is Ts0IteMatrix then
//    Ts0IteMatrix(Dest).Insert;

  sl := TStringList.Create;
  try
    while not FSourceDS.Eof do
    begin
      sl.Clear;
      for i := Low(AFieldOrder) to High(AFieldOrder) do
      begin
        sl.Add(AFieldOrder[i].AsString);
      end;
      Dest.AddRow(sl);
      FSourceDS.Next;
    end;
  finally
    FreeAndNil(sl);
  end;

end;

procedure Ts0DS2Matrix.ExecCopyAll(Dest: Ts0Matrix);
var
  flds: array of TField;
  i: Integer;
begin
  if FSourceDS = nil then Exit;
  SetLength(flds, FSourceDS.Fields.Count);
  for i := 0 to FSourceDS.Fields.Count -1 do
    flds[i] := FSourceDS.Fields[i];
  ExecCopy(Dest, flds);
end;

procedure Ts0DS2Matrix.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FSourceDS = AComponent then
    FSourceDS := nil;
end;

procedure Ts0DS2Matrix.SetSourceDS(const Value: TDataSet);
begin
  FSourceDS := Value;
end;

end.
 
