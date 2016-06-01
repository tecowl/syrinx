unit s0StringsObjFiler;

interface

uses
  SysUtils, Classes;

type
  Ts0StringsObjFiler = class
  private
    FItems: TStrings;
    FRaiseException: Boolean;
    FCurrentVersion: Integer;
  protected
    {Items.ObjectsÇÃDFMì«Ç›èëÇ´}
    procedure ReadItemsObjectsAsInt(Reader: TReader);
    procedure ReadItemsObjVersion(Reader: TReader);
    procedure WriteItemsObjectsAsInt(Writer: TWriter);
    procedure WriteItemsObjVersion(Writer: TWriter);
  protected
    procedure ReadObjectsAsInt(Reader: TReader);
  public
    constructor Create(AItems: TStrings; ARaiseException: Boolean = False);
    procedure DefineProperties(Filer: TFiler);
    property Items: TStrings read FItems;
    property CurrentVersion: Integer read FCurrentVersion;
  end;

type
  Es0StringsObjFiler = class(Exception);

implementation

{ Ts0StringsObjFiler }

constructor Ts0StringsObjFiler.Create(AItems: TStrings; ARaiseException: Boolean);
begin
  inherited Create;
  FItems := AItems;
  FRaiseException := ARaiseException;
  FCurrentVersion := 100;
end;

procedure Ts0StringsObjFiler.DefineProperties(Filer: TFiler);
begin
  try
    filer.DefineProperty('ItemObjVersion', ReadItemsObjVersion, WriteItemsObjVersion, True);
    filer.DefineProperty('ItemObjectsAsInt', ReadItemsObjectsAsInt, WriteItemsObjectsAsInt, True);
    { å√Ç¢ÉoÅ[ÉWÉáÉìå¸ÇØ }
    filer.DefineProperty('ObjectsAsInt', ReadItemsObjectsAsInt, nil, True);
  except
    if FRaiseException then raise;
  end;
end;

resourcestring
  c9ErrMsg_VersionError = 'Filer Version error!';

procedure Ts0StringsObjFiler.ReadItemsObjectsAsInt(Reader: TReader);
  procedure ReadByVer100;
  var
    i: Integer;
  begin
    Reader.ReadListBegin;
    while not Reader.EndOfList do
    begin
      i := Reader.ReadInteger;
      Items.Objects[i] := TObject( Reader.ReadInteger );
    end;
    Reader.ReadListEnd;
  end;
begin
  case FCurrentVersion of
    100: ReadByVer100;
  else
    begin
      raise Es0StringsObjFiler.Create(c9ErrMsg_VersionError);
    end;
  end;
end;

procedure Ts0StringsObjFiler.ReadItemsObjVersion(Reader: TReader);
begin
  FCurrentVersion := Reader.ReadInteger;
end;

procedure Ts0StringsObjFiler.ReadObjectsAsInt(Reader: TReader);
  procedure ReadByOldVersion;
  begin
    Reader.ReadListBegin;
    while not Reader.EndOfList do
    begin
      Reader.ReadInteger;
    end;
    Reader.ReadListEnd;
  end;
begin
  ReadByOldVersion;
end;

procedure Ts0StringsObjFiler.WriteItemsObjectsAsInt(Writer: TWriter);
  procedure WriteByVer100;
  var
    i: Integer;
  begin
    Writer.WriteListBegin;
    for i := 0 to Items.Count - 1 do
    begin
      Writer.WriteInteger(i);
      Writer.WriteInteger( Integer(Items.Objects[i]) );
    end;
    Writer.WriteListEnd;
  end;
begin
  WriteByVer100;
end;

procedure Ts0StringsObjFiler.WriteItemsObjVersion(Writer: TWriter);
begin
  Writer.WriteInteger(FCurrentVersion);
end;

end.
