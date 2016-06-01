unit s0DataSetCSVWriter;

interface

uses
  SysUtils, Classes, DB;

type
  Ts0DataSetCSVWriter = class(TComponent)
  private
    FIncludeTitles: Boolean;
    FSource: TDataSet;
    FCSVFileName: String;
    FAutoFirst: boolean;
    FDelimiter: Char;
    FQuote: Char;
    procedure SetSource(const Value: TDataSet);
    procedure SetCSVFileName(const Value: String);
    procedure SetAutoFirst(const Value: boolean);
    procedure SetDelimiter(const Value: Char);
    procedure SetQuote(const Value: Char);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure CopyToStream(ADest: TStream);
    procedure Execute;
  published
  	property AutoFirst: boolean read FAutoFirst write SetAutoFirst default true;
    property CSVFileName: String read FCSVFileName write SetCSVFileName;
    property Delimiter: Char read FDelimiter write SetDelimiter;
    property Quote: Char read FQuote write SetQuote;
    property Source: TDataSet read FSource write SetSource;
    property IncludeTitles: Boolean read FIncludeTitles write FIncludeTitles default True;
  end;

type
  Es0DataSetCSVWriter = class(Exception);

procedure Register;

implementation

uses
	s0StringsHelper;

procedure Register;
begin
  RegisterComponents('P DM', [Ts0DataSetCSVWriter]);
end;

{ Ts0DataSetCSVWriter }

resourcestring
  c9ErrMsg_SourceIsNil = 'Sourceプロパティが設定されていません。';
  c9ErrMsg_DestStreamIsNil = '出力先ストリームが設定されていません。';

procedure Ts0DataSetCSVWriter.CopyToStream(ADest: TStream);
  function ToSVString(AStrings: TStrings): String;
  begin
  	Result := Ts0StringsHelper.ToSVString(AStrings, FDelimiter, FQuote);
  end;
  procedure WriteString(AStrings: TStrings);
  var
    ss: TStringStream;
  begin
    ss := TStringStream.Create(ToSVString(AStrings) +#13#10);
    try
      ADest.CopyFrom(ss, 0);
    finally
      FreeAndNil(ss);
    end;
  end;
  procedure GetTitles(dest: TStrings);
  var
  	i: Integer;
    f: TField;
  begin
  	for i := 0 to FSource.FieldCount -1 do
    begin
      f := FSource.Fields.Fields[i];
			dest.Add(f.DisplayLabel);
    end;
  end;
  procedure GetRecord(dest: TStrings);
  var
  	i: Integer;
    f: TField;
  begin
  	for i := 0 to FSource.FieldCount -1 do
    begin
      f := FSource.Fields.Fields[i];
			dest.Add(f.AsString);
    end;
  end;
var
  sl: TStringList;
  currentRecord: TBookmark;
begin
  if FSource = nil then
    raise Es0DataSetCSVWriter.Create(c9ErrMsg_SourceIsNil);
  if ADest = nil then
    raise Es0DataSetCSVWriter.Create(c9ErrMsg_DestStreamIsNil);
  currentRecord := FSource.GetBookmark;
  try
    sl := TStringList.Create;
    try
      if FIncludeTitles then
      begin
        GetTitles(sl);
        WriteString(sl);
      end;
      if AutoFirst then
        FSource.First;
      while not FSource.Eof do
      begin
        sl.Clear;
        GetRecord(sl);
        WriteString(sl);
        FSource.Next;
      end;
    finally
      FreeAndNil(sl);
    end;
  finally
    FSource.GotoBookmark(currentRecord);
    FSource.FreeBookmark(currentRecord);
  end;
end;

constructor Ts0DataSetCSVWriter.Create(Owner: TComponent);
begin
	inherited;
  FAutoFirst := True;
  FDelimiter := ',';
  FQuote := '"';
end;

destructor Ts0DataSetCSVWriter.Destroy;
begin
  inherited;
end;

procedure Ts0DataSetCSVWriter.Execute;
var
  dest: TStream;
begin
  dest := TFileStream.Create(CSVFileName, fmCreate or fmShareDenyWrite);
  try
    CopyToStream(dest);
  finally
    FreeAndNil(dest);
  end;
end;

procedure Ts0DataSetCSVWriter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then
  	Exit;
  if FSource = AComponent then
		FSource := nil;
end;

procedure Ts0DataSetCSVWriter.SetAutoFirst(const Value: boolean);
begin
  FAutoFirst := Value;
end;

procedure Ts0DataSetCSVWriter.SetCSVFileName(const Value: String);
begin
  FCSVFileName := Value;
end;

procedure Ts0DataSetCSVWriter.SetDelimiter(const Value: Char);
begin
  FDelimiter := Value;
end;

procedure Ts0DataSetCSVWriter.SetQuote(const Value: Char);
begin
  FQuote := Value;
end;

procedure Ts0DataSetCSVWriter.SetSource(const Value: TDataSet);
begin
  FSource := Value;
end;

end.
 