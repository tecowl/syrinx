{-----------------------------------------------------------------------------
 Unit Name: s0ObjCSVReader
 Author:    akima
 Purpose:
 TestCase: tc_u0ObjCSVMaker
 $History: s0ObjCSVReader.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/25   Time: 5:37
 * Updated in $/source/D5Integrated
 * ReadTilesプロパティを追加。
 * Ts0CollectionCSVReaderを追加。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/21   Time: 3:48
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0ObjCSVReader;

interface

uses
  SysUtils, Classes;

type
  Ts0ObjCSVReaderNewObjEvent = procedure(Sender: TObject; var AObj: TObject) of object;

type
  Ts0ObjCSVReader = class
  private
    FSource: TStream;
    FTargetProps: TStrings;
    FOnNeedNewObj: Ts0ObjCSVReaderNewObjEvent;
    FReadTitles: Boolean;
    procedure SetSource(const Value: TStream);
    procedure SetTargetProps(const Value: TStrings);
  protected
    function NeedNewObj: TObject; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddAllPropsOf(AClass: TClass);
    procedure Execute; virtual;
    property Source: TStream read FSource write SetSource;
    property TargetProps: TStrings read FTargetProps write SetTargetProps;
    property OnNeedNewObj: Ts0ObjCSVReaderNewObjEvent read FOnNeedNewObj write FOnNeedNewObj;
    property ReadTitles: Boolean read FReadTitles write FReadTitles default True;
  end;

type
  Ts0CollectionCSVReader = class(Ts0ObjCSVReader)
  private
    FTargetCollection: TCollection;
  protected
    function NeedNewObj: TObject; override;
  public
    procedure Execute; override;
    property TargetCollection: TCollection read FTargetCollection write FTargetCollection;
  end;

type
  Es0ObjCSVReader = class(Exception);

implementation

uses
  s0TypInfoWrapper,
  s0Matrix;

{ Ts0ObjCSVReader }

procedure Ts0ObjCSVReader.AddAllPropsOf(AClass: TClass);
var
  ti: Ts0RTTITypeInfo;
begin
  ti := Ts0RTTIPublishedBroker.Instance.GetTypeInfoByClass(AClass);
  if ti = nil then Exit;
  ti.PublishedProps.Props.CopyNamesTo(FTargetProps);
end;

constructor Ts0ObjCSVReader.Create;
begin
  inherited Create;
  FReadTitles := True;
  FTargetProps := TStringList.Create;
end;

destructor Ts0ObjCSVReader.Destroy;
begin
  FreeAndNil(FTargetProps);
  inherited;
end;

resourcestring
  c9ErrMsg_SourceIsNil = 'Sourceプロパティにnilが設定さています。';

procedure Ts0ObjCSVReader.Execute;
var
  mtrx: Ts0RowBaseMatrix;
  i, j: Integer;
  acsr: Ts0RTTIPublishedAccessor;
begin
  { 事前条件 }
  if FSource = nil then
    raise Es0ObjCSVReader.Create(c9ErrMsg_SourceIsNil);
  //
  mtrx := Ts0RowBaseMatrix.Create;
  try
    mtrx.LoadFromStream(FSource);
    for i := 0 to mtrx.RowCount -1 do
    begin
      if (i = 0) and FReadTitles then
      begin
        FTargetProps.Assign(mtrx.Rows[0]);
        Continue;
      end;
      acsr := Ts0RTTIPublishedAccessor.Create(NeedNewObj);
      try
        for j := 0 to FTargetProps.Count -1 do
        begin
          if not acsr.PropertyExists(FTargetProps.Strings[j]) then Continue;
          acsr.PropAsString[ FTargetProps.Strings[j] ] := mtrx.Cells[j, i];
        end;
      finally
        FreeAndNil(acsr);
      end;
    end;
  finally
    FreeAndNil(mtrx);
  end;
end;

function Ts0ObjCSVReader.NeedNewObj: TObject;
begin
  Result := nil;
  if Assigned(FOnNeedNewObj) then
    FOnNeedNewObj(Self, Result);
end;

procedure Ts0ObjCSVReader.SetSource(const Value: TStream);
begin
  FSource := Value;
end;

procedure Ts0ObjCSVReader.SetTargetProps(const Value: TStrings);
begin
  FTargetProps.Assign(Value);
end;

{ Ts0CollectionCSVReader }

resourcestring
  c9ErrMsg_TargetCollectionIsNil = 'TargetCollectionプロパティにnilが設定さています。';

procedure Ts0CollectionCSVReader.Execute;
begin
  if TargetCollection = nil then
    raise Es0ObjCSVReader.Create(c9ErrMsg_TargetCollectionIsNil);
  inherited;    
end;

function Ts0CollectionCSVReader.NeedNewObj: TObject;
begin
  Result := TargetCollection.Add;
end;

end.
