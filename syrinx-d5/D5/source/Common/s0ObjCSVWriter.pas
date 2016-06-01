{-----------------------------------------------------------------------------
 Unit Name: s0ObjCSVWriter
 Author:    akima
 Purpose:
 TestCase: tc_u0ObjCSVMaker
 $History: s0ObjCSVWriter.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/06   Time: 1:09
 * Updated in $/source/D5Integrated
 * 余計にNextItemを使用していたので修正
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/01/28   Time: 17:14
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/01/17   Time: 23:57
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/11/25   Time: 5:38
 * Updated in $/source/D5Integrated
 * IncludeTitlesプロパティを追加。
 *
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/11/21   Time: 3:48
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}


unit s0ObjCSVWriter;

interface

uses
  SysUtils, Classes,
  s0Iterator;

type
  Ts0ObjCSVWriter = class
  private
    FSource: Ts0AbstractObjectListIterator;
    FDest: TStream;
    FTargetProps: TStrings;
    FIncludeTitles: Boolean;
    procedure SetDest(const Value: TStream);
    procedure SetSource(const Value: Ts0AbstractObjectListIterator);
    procedure SetTargetProps(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddAllPropsOf(AClass: TClass);
    procedure Execute;
    property Dest: TStream read FDest write SetDest;
    property Source: Ts0AbstractObjectListIterator read FSource write SetSource;
    property TargetProps: TStrings read FTargetProps write SetTargetProps;
    property IncludeTitles: Boolean read FIncludeTitles write FIncludeTitles default True;
  end;

type
  Es0ObjCSVWriter = class(Exception);

implementation

uses
  s0TypInfoWrapper;

{ Ts0ObjCSVWriter }

procedure Ts0ObjCSVWriter.AddAllPropsOf(AClass: TClass);
var
  ti: Ts0RTTITypeInfo;
begin
  ti := Ts0RTTIPublishedBroker.Instance.GetTypeInfoByClass(AClass);
  if ti = nil then Exit;
  ti.PublishedProps.Props.CopyNamesTo(FTargetProps);
end;

constructor Ts0ObjCSVWriter.Create;
begin
  inherited Create;
  FIncludeTitles := True;
  FTargetProps := TStringList.Create;
end;

destructor Ts0ObjCSVWriter.Destroy;
begin
  FreeAndNil(FTargetProps);
  inherited;               
end;

resourcestring
  c9ErrMsg_SourceIsNil = 'Sourceプロパティにnilが設定さています。';
  c9ErrMsg_DestIsNil = 'Destプロパティにnilが設定さています。';

procedure Ts0ObjCSVWriter.Execute;
  procedure WriteString(AStr: string);
  var
    ss: TStringStream;
  begin
    ss := TStringStream.Create(AStr +#13#10);
    try
      Dest.CopyFrom(ss, 0);
    finally
      FreeAndNil(ss);
    end;
  end;
var
  i: Integer;
  sl: TStringList;
  acsr: Ts0RTTIPublishedAccessor;
begin
  { 事前条件 }
  if FSource = nil then
    raise Es0ObjCSVWriter.Create(c9ErrMsg_SourceIsNil);
  if FDest = nil then
    raise Es0ObjCSVWriter.Create(c9ErrMsg_DestIsNil);
  //
  sl := TStringList.Create;
  try
    if FIncludeTitles then
      WriteString(FTargetProps.CommaText);
    while FSource.HasNext do
    begin
      acsr := Ts0RTTIPublishedAccessor.Create(FSource.CurrentItem);
      try
        sl.Clear;
        for i := 0 to FTargetProps.Count -1 do
        begin
          if acsr.PropertyExists(FTargetProps.Strings[i]) then
            sl.Add(acsr.PropAsString[ FTargetProps.Strings[i] ] )
          else
            sl.Add('');
        end;
        WriteString(sl.CommaText);
        FSource.Next;
      finally
        FreeAndNil(acsr);
      end;
    end;
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0ObjCSVWriter.SetDest(const Value: TStream);
begin
  FDest := Value;
end;

procedure Ts0ObjCSVWriter.SetSource(
  const Value: Ts0AbstractObjectListIterator);
begin
  FSource := Value;
end;

procedure Ts0ObjCSVWriter.SetTargetProps(const Value: TStrings);
begin
  FTargetProps.Assign(Value);
end;

end.
