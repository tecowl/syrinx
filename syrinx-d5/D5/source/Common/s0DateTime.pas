unit s0DateTime;

interface

uses
  SysUtils, Classes,
  s0DateHelper;

type
  K0DayOfWeekKind = (
    k0dowkSunday, k0dowkMonday, k0dowkTuesday, k0dowkWednesday,
    k0dowkThursday, k0dowkFriday, k0dowkSaturday
  );
  K0DayOfWeekKindSet = set of K0DayOfWeekKind;


type
  Ts0DateTime = class(TPersistent)
  private
    FParts: array[K0DateTimeUnitKind] of Word;
    function GetPart(const Index: Integer): Word;
    procedure SetPart(const Index: Integer; const Value: Word);
    procedure SetAsDateTime(const Value: TDateTime);
    function GetAsDateTime: TDateTime;
    function GetDayOfWeek: K0DayOfWeekKind;
    function GetAsString(const AFormat: string): string;
    procedure SetAsString(const AFormat, Value: string);
  private
    function GetJPEra: K0JapaneseEra;
    function GetJPYear: Integer;
  protected
  public
    constructor Create(ADateTime: TDateTime);
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsString[const AFormat: string]: string read GetAsString write SetAsString;
    property DayOfWeek: K0DayOfWeekKind read GetDayOfWeek;
    procedure Prepare;
    class function IntToDayOfWeek(Value: Integer; Origin: Integer = 1): K0DayOfWeekKind;
    class function DayOfWeekToInt(Value: K0DayOfWeekKind; Origin: Integer = 1): Integer;
  public
    { Japanese Date }
    procedure SetJPDate(AEra: K0JapaneseEra; AYear, AMonth, ADay: Word);
    property JPEra: K0JapaneseEra read GetJPEra;
    property JPYear: Integer read GetJPYear;
  published
    { Christian Date & Time }
    property Year   : Word index 1 read GetPart write SetPart;
    property Month  : Word index 2 read GetPart write SetPart;
    property Day    : Word index 3 read GetPart write SetPart;
    property Hour   : Word index 4 read GetPart write SetPart;
    property Minute : Word index 5 read GetPart write SetPart;
    property Second : Word index 6 read GetPart write SetPart;
    property MiliSec: Word index 7 read GetPart write SetPart;
  end;

type
  Es0DateTime = class(Exception);

implementation

uses
  s0StringHelper;

resourcestring
  c9ErrMsg_IllegalIndex = '不正なインデックスです。';

function IndexToDTUnitType(AIndex: Integer): K0DateTimeUnitKind;
begin
  case AIndex of
    1: Result := k0dtukYear;
    2: Result := k0dtukMonth;
    3: Result := k0dtukDay;
    4: Result := k0dtukHour;
    5: Result := k0dtukMinute;
    6: Result := k0dtukSecond;
    7: Result := k0dtukMiliSecond;
    else
      raise Es0DateTime.Create(c9ErrMsg_IllegalIndex);
  end;
end;

{ Ts0DateTime }

constructor Ts0DateTime.Create(ADateTime: TDateTime);
begin
  inherited Create;
  FParts[k0dtukYear      ] := 0;
  FParts[k0dtukMonth     ] := 1;
  FParts[k0dtukDay       ] := 1;
  FParts[k0dtukHour      ] := 0;
  FParts[k0dtukMinute    ] := 0;
  FParts[k0dtukSecond    ] := 0;
  FParts[k0dtukMiliSecond] := 0;       
  AsDateTime := ADateTime;
end;

class function Ts0DateTime.DayOfWeekToInt(Value: K0DayOfWeekKind;
  Origin: Integer): Integer;
begin
  Result := Ord(Value) + Origin;
end;

function Ts0DateTime.GetAsDateTime: TDateTime;
var
  t: TDateTime;
begin
  Result := EncodeDate(Year, Month, Day);
  t := EncodeTime(Hour, Minute, Second, MiliSec);
  Result := Result + t - Trunc(t);
end;

function Ts0DateTime.GetAsString(const AFormat: string): string;
begin
  Result := FormatDateTime(AFormat, AsDateTime);
end;

function Ts0DateTime.GetDayOfWeek: K0DayOfWeekKind;
begin
  Result := IntToDayOfWeek( SysUtils.DayOfWeek(AsDateTime) );
end;

function Ts0DateTime.GetJPEra: K0JapaneseEra;
begin
  Result := Ts0DateHelper.GetJapaneseEra(AsDateTime);
end;

function Ts0DateTime.GetJPYear: Integer;
var
  jEra: K0JapaneseEra;
  jy, jm, jd: Word;
begin
  Ts0DateHelper.ToJapaneseEra(AsDateTime, jEra, jy, jm, jd);
  Result := jy;
end;

function Ts0DateTime.GetPart(const Index: Integer): Word;
begin
  Result := FParts[ IndexToDTUnitType(Index) ];
end;

class function Ts0DateTime.IntToDayOfWeek(Value,
  Origin: Integer): K0DayOfWeekKind;
begin
  Result := K0DayOfWeekKind(Value - Origin);
end;

procedure Ts0DateTime.Prepare;
var
  i: K0DateTimeUnitKind;
  mx: Integer;
begin
  for i := Low(K0DateTimeUnitKind) to High(K0DateTimeUnitKind) do
  begin
    case i of
      k0dtukYear : ;
      k0dtukMonth:
      begin
        if FParts[k0dtukMonth] < 13 then Continue;
        AsDateTime := IncMonth(AsDateTime, FParts[k0dtukMonth] - 12);
      end;
      k0dtukDay:
      begin
        mx := Ts0DateHelper.DayCountOfMonth(FParts[k0dtukYear], FParts[k0dtukMonth]);
        if FParts[k0dtukDay] <= mx then Continue;
        AsDateTime := AsDateTime + FParts[k0dtukDay]- mx;
      end;
      k0dtukHour, k0dtukMinute, k0dtukSecond, k0dtukMiliSecond:
      begin
        mx := Trunc(1 / c0TimeUnitValue[i]);
        AsDateTime := AsDateTime + (FParts[i] - mx) * c0TimeUnitValue[i];
      end;
    end;
  end;
end;

procedure Ts0DateTime.SetAsDateTime(const Value: TDateTime);
var
  yy, mm, dd, hh, nn, ss, ms: Word;
begin
  DecodeDate(Value, yy, mm, dd);
  DecodeTime(Value, hh, nn, ss, ms);
  FParts[k0dtukYear      ] := yy;
  FParts[k0dtukMonth     ] := mm;
  FParts[k0dtukDay       ] := dd;
  FParts[k0dtukHour      ] := hh;
  FParts[k0dtukMinute    ] := nn;
  FParts[k0dtukSecond    ] := ss;
  FParts[k0dtukMiliSecond] := ms;
end;

procedure Ts0DateTime.SetAsString(const AFormat, Value: string);
  procedure RemoveQuoted(var Fmt, Val: string; ADelim: Char);
  var
    q: string;
    p: Integer;
  begin      
    while Ts0StringHelper.GetQuotedStr(Fmt, ADelim, q) do
    begin
      p := Pos(q, Val);
      Delete(Val, p, Length(q));
      //
      p := Pos(q, Fmt);
      Delete(Fmt, p, Length(q));
    end;       
  end;
  function GetEraType(var Fmt, Val: string; var AEraType: K0JapaneseEra): Boolean;
  var
    p_ggg, p_gg, p_g: Integer;
  begin
    Result := True;
    repeat
      p_ggg := AnsiPos('ggg', Fmt);
      p_gg  := AnsiPos('gg' , Fmt);
      p_g   := AnsiPos('g'  , Fmt);
      if (p_ggg < 1) and (p_gg < 1) and (p_g < 1) then Exit;
      if p_ggg > 0 then
      begin


      end;


    until (p_ggg < 1) and (p_gg < 1) and (p_g < 1);
  end;
  function GetValueByUnit(var Fmt, Val: string; AUnit: K0DateTimeUnitKind): Integer;
  const
    c9FormatStyles: array[K0DateTimeUnitKind] of string = (
      'yyyy', 'mm', 'dd', 'hh', 'nn', 'ss',  'zzz'
    );
  var
    pos: Integer;
    s: string;
  begin
    Result := 0;
    try
      pos := AnsiPos(c9FormatStyles[AUnit], AFormat);
      if pos < 1 then Exit;
      s := Copy(Value, pos, Length(c9FormatStyles[AUnit]));
      Result := StrToIntDef(s, 0);
    finally
      if (Result < 1) and (AUnit in [k0dtukMonth, k0dtukDay]) then
        Result := 1;
    end;
  end;
var
  ps: array[K0DateTimeUnitKind] of Word;
//  hasJPEra: Boolean;
  i: K0DateTimeUnitKind;
  bufFormat, bufValue: string;
//  jpEra: K0JapaneseEra;
begin
  bufFormat := AFormat;
  bufValue := Value;
  //
  RemoveQuoted(bufFormat, bufValue, '"');
  RemoveQuoted(bufFormat, bufValue, '''');
  //
//  hasJPEra := GetEraType(bufFormat, bufValue, jpEra);
  for i := Low(K0DateTimeUnitKind) to High(K0DateTimeUnitKind) do
    ps[i] := GetValueByUnit(bufFormat, bufValue, i);

    //  if AnsiPos('')


end;

procedure Ts0DateTime.SetJPDate(AEra: K0JapaneseEra; AYear, AMonth,
  ADay: Word);
begin
  AsDateTime := Ts0DateHelper.ToChristianera(AEra, AYear, AMonth, ADay);
end;

procedure Ts0DateTime.SetPart(const Index: Integer; const Value: Word);
begin
  FParts[IndexToDTUnitType(Index)] := Value;
end;

end.
