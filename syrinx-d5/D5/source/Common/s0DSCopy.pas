unit s0DSCopy;

interface

uses
  SysUtils, Classes, DB, Dialogs;

type
  Ks0DSCopyActionType = (k0dscatToCSV, k0dscatToClipboard);

type
  Ts0DSCopy = class(TComponent)
  private
    FDataSet: TDataSet;
    FActionType: Ks0DSCopyActionType;
    FCsvSaveDialog: TSaveDialog;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetActionType(const Value: Ks0DSCopyActionType);
    procedure SetCsvSaveDialog(const Value: TSaveDialog);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    procedure DoAction;
  published
    property ActionType: Ks0DSCopyActionType read FActionType write
      SetActionType;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property CsvSaveDialog: TSaveDialog read FCsvSaveDialog write SetCsvSaveDialog;
  end;

procedure Register;

implementation

uses
  Clipbrd,
  s0DataSetCSVWriter;

procedure Register;
begin
  RegisterComponents('P DM', [Ts0DSCopy]);
end;

type
  T9ActionImplementorClass = class of T9ActionImplementor;
  T9ActionImplementor = class
  private
    FDest: TDataSet;
  protected
  	FOwner: Ts0DSCopy;
  	FDelimiter: Char;
    FQuote: Char;
    function CreateDestStream: TStream; virtual; abstract;
    function CreateDSSVWriter: Ts0DataSetCSVWriter; virtual;
    procedure DoAfterWrite(ADest: TStream); virtual;
  public
    constructor Create(AOwner: Ts0DSCopy; ADest: TDataSet); virtual;
    procedure Execute; virtual;
  end;

type
  T9ActionToCSV = class(T9ActionImplementor)
  protected
    function CreateDestStream: TStream; override;
  public
    constructor Create(AOwner: Ts0DSCopy; ADest: TDataSet); override;
  end;

type
  T9ActionToClipboard = class(T9ActionImplementor)
  protected
    function CreateDestStream: TStream; override;
    procedure DoAfterWrite(ADest: TStream); override;
  public
    constructor Create(AOwner: Ts0DSCopy; ADest: TDataSet); override;
  end;

{ T9ActionImplementor }

constructor T9ActionImplementor.Create(AOwner: Ts0DSCopy; ADest: TDataSet);
begin
	FOwner := AOwner;
  FDest := ADest;
end;

function T9ActionImplementor.CreateDSSVWriter: Ts0DataSetCSVWriter;
begin
  Result := Ts0DataSetCSVWriter.Create(nil);
  Result.Source := FDest;
  Result.Delimiter := Self.FDelimiter;
	Result.Quote := Self.FQuote;
  Result.IncludeTitles := True;
end;

procedure T9ActionImplementor.doAfterWrite(ADest: TStream);
begin
end;

procedure T9ActionImplementor.execute;
var
  dest: TStream;
  writer: Ts0DataSetCSVWriter;
begin
  dest := CreateDestStream;
  if dest = nil then
    Exit;
  try
    writer := CreateDSSVWriter;
    try
      writer.CopyToStream(dest);
    finally
      FreeAndNil(writer);
    end;
    doAfterWrite(dest);
  finally
    FreeAndNil(dest);
  end;
end;


{ T9ActionToCSV }

constructor T9ActionToCSV.Create(AOwner: Ts0DSCopy; ADest: TDataSet);
begin
  inherited;
	FDelimiter := ',';
  FQuote := '"';
end;

function T9ActionToCSV.CreateDestStream: TStream;
	function CreateSaveDialog: TSaveDialog;
  begin
    Result := TSaveDialog.Create(nil);
    Result.DefaultExt := 'csv';
    Result.Filter := 'CSV files (*.csv)|*.csv|all files (*.*)|*.*';
  end;
var
  dlg: TSaveDialog;
begin
  Result := nil;
  if FOwner.CsvSaveDialog = nil then
    dlg := CreateSaveDialog
  else
    dlg := FOwner.CsvSaveDialog;
  try
    if not dlg.Execute then
      Exit;
    Result := TFileStream.Create(dlg.FileName, fmCreate	or fmShareDenyWrite);
  finally
    if FOwner.CsvSaveDialog = nil then
      FreeAndNil(dlg);
  end;
end;

{ T9ActionToClipboard }

constructor T9ActionToClipboard.Create(AOwner: Ts0DSCopy; ADest: TDataSet);
begin
  inherited;
	FDelimiter := #9;
  FQuote := '"';
end;

function T9ActionToClipboard.CreateDestStream: TStream;
begin
  Result := TStringStream.Create('');
end;

procedure T9ActionToClipboard.doAfterWrite(ADest: TStream);
var
	clp: TClipboard;
  ss: TStringStream;
begin
  clp := Clipboard;
  ss := TStringStream.Create('');
  try
		ss.CopyFrom(ADest, 0);
	  clp.AsText := ss.DataString;
  finally
 		FreeAndNil(ss);
  end;
end;

{ Ts0DSCopy }

procedure Ts0DSCopy.DoAction;
const
	implClasses: array[Ks0DSCopyActionType] of T9ActionImplementorClass =
  	(T9ActionToCSV, T9ActionToClipboard);
var
	impl: T9ActionImplementor;
begin
	impl := implClasses[FActionType].Create(Self, FDataSet);
  try
  	impl.execute;
  finally
    FreeAndNil(impl);
  end;
end;

procedure Ts0DSCopy.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then
    Exit;
  if FDataSet = AComponent then
    FDataSet := nil;
  if FCsvSaveDialog = AComponent then
    FCsvSaveDialog := nil;
end;

procedure Ts0DSCopy.SetActionType(const Value: Ks0DSCopyActionType);
begin
  FActionType := Value;
end;

procedure Ts0DSCopy.SetCsvSaveDialog(const Value: TSaveDialog);
begin
  FCsvSaveDialog := Value;
end;

procedure Ts0DSCopy.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

end.

