unit s0DateHelper;
{
$History: s0DateHelper.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/12/05   Time: 18:49
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/11/08   Time: 14:35
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/20   Time: 0:00
 * Updated in $/source/D5Integrated
 * DateToKanjiStr、KanjiStrToDateメソッドを追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/19   Time: 20:47
 * Updated in $/source/D5Integrated
 * GetJPEraKanji、GetJPEraFromKanjiメソッドを追加
 *
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/06/28   Time: 18:28
 * Created in $/Projects/SDRFrameWork/src/lib0
 * 新規追加
 * \Usr\takima\Lecture\StaffDailyReport\Sourceから移動しました。
 * VSSでは共有してません。
}

interface

uses
  SysUtils, Classes;

type
  //年号のことを英語では"era"と言う
  K0JapaneseEra = (k0jeMeiji, k0jeTaisho, k0jeShowa, k0jeHeisei);
  K0DateTimeUnitKind = (k0dtukYear, k0dtukMonth, k0dtukDay, k0dtukHour, k0dtukMinute, k0dtukSecond, k0dtukMiliSecond);
  //K0DateTimeUnitKindSet = set of K0DateTimeUnitKind;
  K0TimeUnitKind = k0dtukHour..k0dtukMiliSecond;

type
  Ts0DateHelper = class
  public
    class function CheckStr8Format(AStr: string): Boolean;
    class function DateToStr8(ADate: TDateTime): string;
    class function Str8ToDate(Date8: string): TDateTime;
    class function Str8ToDateDef(Date8: string; ADef: TDateTime): TDateTime;
    //
    class function GetJapaneseEra(ADate: TDateTime): K0JapaneseEra;
    class function GetBeginDate(aEra: K0JapaneseEra): TDateTime;
    class function GetLastYaer(aEra: K0JapaneseEra): Integer;
    class procedure ToJapaneseEra(ADate: TDateTime;
      var AEra: K0JapaneseEra; var jy, m, d: Word);
    class function ToChristianEra(AEra: K0JapaneseEra; jy, m, d: Word):
      TDateTime;
    class function DayCountOfMonth(const yy, mm: Word): Word;
    //
    class function IncYear(ADate: TDateTime; ANumberOfYear: Integer): TDateTime;
    class function IncMonth(ADate: TDateTime; ANumberOfMonth: Integer): TDateTime;
    class function IncDay(ADate: TDateTime; ANumberOfDay: Integer): TDateTime;
    //
    class function GetJPEraKanji(AJPEra: K0JapaneseEra): String;
    class function GetJPEraFromKanji(AKanjiStr: string): K0JapaneseEra;
    //
    class function DateToKanjiStr(ADate: TDateTime): string;
    class function KanjiStrToDate(AStr: string): TDateTime;
  end;

type
  Ts0DateTimeHelper = class
  public
    class function TimeToStrWithMiliSec(pDateTime: TDateTime): string;
    class function DateTimeToStrWithMiliSec(pDateTime: TDateTime): string;
    class function TimeToFloat(AValue: TDateTime; AUnit: K0TimeUnitKind): Extended;
    class function FloatToTime(AValue: Extended; AUnit: K0TimeUnitKind): TDateTime;
  end;

const
  c0TimeUnitValue: array[K0TimeUnitKind] of Single =
  (
    1/24, 1/24/60, 1/24/60/60, 1/24/60/60/1000
  );

type
  Es0Str8FormatException = class(Exception);

implementation

{ Ts0DateHelper }

class function Ts0DateHelper.CheckStr8Format(AStr: string): Boolean;
var
  yy, mm, dd: Integer;
begin
  Result := False;
  if Length(AStr) < 8 then
    Exit;
  yy := StrToInt(Copy(AStr, 1, 4));
  mm := StrToInt(Copy(AStr, 5, 2));
  dd := StrToInt(Copy(AStr, 7, 2));
  if mm < 1 then
    Exit;
  if dd < 1 then
    Exit;
  if mm > 12 then
    Exit;
  if dd > DayCountOfMonth(yy, mm) then
    Exit;
  Result := True;
end;

class function Ts0DateHelper.DateToKanjiStr(ADate: TDateTime): string;
var
  e: K0JapaneseEra;
  y, m, d: Word;
begin
  ToJapaneseEra(ADate, e, y, m, d);
  Result := GetJPEraKanji(e);
  if Result = '' then
    Result := '？？';
  Result := Format('%s%d年%d月%d日', [Result, y, m, d]);
end;

class function Ts0DateHelper.DateToStr8(ADate: TDateTime): string;
begin
  Result := FormatDateTime('yyyymmdd', ADate);
end;

{
  明治は改元日が元号の最初の日付ではない。
  また、明治6年から太陰暦から太陽暦に変わっているので、話がややこしい。
  M 1868/01/01
  T 1912/07/30
  S 1926/12/25
  H 1989/01/08
}

type
  R9ConvertEraTable = packed record
    FChristianEra: Integer;
    FMonth: Word;
    FDay: Word;
  end;

const
  c9EraBeginDate: array[K0JapaneseEra] of R9ConvertEraTable = (
    (FChristianEra: 1868; FMonth: 1; FDay: 1),
    (FChristianEra: 1912; FMonth: 7; FDay: 30),
    (FChristianEra: 1926; FMonth: 12; FDay: 25),
    (FChristianEra: 1989; FMonth: 1; FDay: 8)
    );

class function Ts0DateHelper.DayCountOfMonth(const yy, mm: Word): Word;
const
  c9DayCountOfMonth: array[1..12] of Integer = (
    31, 28, 31, 30,
    31, 30, 31, 31,
    30, 31, 30, 31
    );
begin
  if IsLeapYear(yy) and (mm = 2) then
  begin
    Result := 29;
  end
  else
  begin
    Result := c9DayCountOfMonth[mm];
  end;
end;

class function Ts0DateHelper.GetBeginDate(aEra: K0JapaneseEra): TDateTime;
begin
  Result := EncodeDate(
    c9EraBeginDate[aEra].FChristianEra,
    c9EraBeginDate[aEra].FMonth,
    c9EraBeginDate[aEra].FDay
    );
end;

class function Ts0DateHelper.GetJapaneseEra(
  ADate: TDateTime): K0JapaneseEra;
var
  i: K0JapaneseEra;
  yy, mm, dd: Word;
begin
  Result := k0jeHeisei;
  DecodeDate(ADate, yy, mm, dd);
  for i := High(K0JapaneseEra) downto Low(K0JapaneseEra) do
    if yy > c9EraBeginDate[i].FChristianEra then
    begin
      Result := i;
      Exit;
    end
    else if yy = c9EraBeginDate[i].FChristianEra then
    begin
      if mm > c9EraBeginDate[i].FMonth then
      begin
        Result := i;
        Exit;
      end
      else if mm = c9EraBeginDate[i].FMonth then
      begin
        if dd >= c9EraBeginDate[i].FDay then
        begin
          Result := i;
          Exit;
        end;
      end;
    end;
end;

resourcestring
  c9KnjJPEra_Meiji  = '明治';
  c9KnjJPEra_Taisho = '大正';
  c9KnjJPEra_Showa  = '昭和';
  c9KnjJPEra_Heisei = '平成';

const
  c9KanjiEraArray: array[K0JapaneseEra] of string = (
    c9KnjJPEra_Meiji ,
    c9KnjJPEra_Taisho,
    c9KnjJPEra_Showa ,
    c9KnjJPEra_Heisei 
  );

class function Ts0DateHelper.GetJPEraFromKanji(
  AKanjiStr: string): K0JapaneseEra;
var
  i: K0JapaneseEra;
begin
  Result := High(K0JapaneseEra);
  for i := Low(K0JapaneseEra) to High(K0JapaneseEra) do
    if Pos(c9KanjiEraArray[i], AKanjiStr) > 0 then
    begin
      Result := i;
      Exit;
    end;
end;

class function Ts0DateHelper.GetJPEraKanji(AJPEra: K0JapaneseEra): String;
begin
  Result := c9KanjiEraArray[AJPEra];
end;

class function Ts0DateHelper.GetLastYaer(aEra: K0JapaneseEra): Integer;
var
  nxt: K0JapaneseEra;
begin
  if aEra = k0jeHeisei then
  begin
    Result := 99;
    Exit;
  end;
  nxt := aEra;
  Inc(nxt);
  Result := c9EraBeginDate[nxt].FChristianEra
          - c9EraBeginDate[aEra].FChristianEra + 1;
end;

resourcestring
  c9ErrMsg_Str8Convert = 'Str8を日付に変換できません。(%s)';

class function Ts0DateHelper.IncDay(ADate: TDateTime;
  ANumberOfDay: Integer): TDateTime;
begin
  Result := ADate + ANumberOfDay;
end;

class function Ts0DateHelper.IncMonth(ADate: TDateTime;
  ANumberOfMonth: Integer): TDateTime;
begin
  Result := SysUtils.IncMonth(ADate, ANumberOfMonth);
end;

class function Ts0DateHelper.IncYear(ADate: TDateTime;
  ANumberOfYear: Integer): TDateTime;
begin
  Result := SysUtils.IncMonth(ADate, ANumberOfYear * 12);
end;

class function Ts0DateHelper.KanjiStrToDate(AStr: string): TDateTime;
var
  e: K0JapaneseEra;
  y, m, d: Word;
  pe, py, pm, pd: Integer;
begin
  Result := 0;
  e := GetJPEraFromKanji(AStr);
  pe := AnsiPos(GetJPEraKanji(e), AStr);
  py := AnsiPos('年', AStr);
  pm := AnsiPos('月', AStr);
  pd := AnsiPos('日', AStr);
  if pe < 1 then Exit;
  if py < 1 then Exit;
  if pm < 1 then Exit;
  if pd < 1 then Exit;
  if pe >= py then Exit;
  if py >= pm then Exit;
  if pm >= pd then Exit;
  pe := pe + Length( GetJPEraKanji(e) );
  y := StrToIntDef( Copy(AStr, pe    , py - pe), 1);
  m := StrToIntDef( Copy(AStr, py + 2, pm - py), 1);
  d := StrToIntDef( Copy(AStr, pm + 2, pd - pm), 1);
  Result := ToChristianEra(e, y, m, d);
end;

class function Ts0DateHelper.Str8ToDate(Date8: string): TDateTime;
var
  yy, mm, dd: Integer;
begin
  if not CheckStr8Format(Date8) then
    raise Es0Str8FormatException.CreateFmt(c9ErrMsg_Str8Convert, [Date8]);
  yy := StrToInt(Copy(Date8, 1, 4));
  mm := StrToInt(Copy(Date8, 5, 2));
  dd := StrToInt(Copy(Date8, 7, 2));
  Result := EncodeDate(yy, mm, dd);
end;

class function Ts0DateHelper.Str8ToDateDef(Date8: string;
  ADef: TDateTime): TDateTime;
begin
  if not CheckStr8Format(Date8) then
  begin
    Result := ADef;
    Exit;
  end;
  Result := Str8ToDate(Date8);
end;

class function Ts0DateHelper.ToChristianEra(AEra: K0JapaneseEra; jy, m,
  d: Word): TDateTime;
var
  yy, mm, dd: Word;
begin
  yy := c9EraBeginDate[AEra].FChristianEra + jy - 1;
  mm := m;
  dd := d;
  Result := EncodeDate(yy, mm, dd);
end;

class procedure Ts0DateHelper.ToJapaneseEra(ADate: TDateTime;
  var AEra: K0JapaneseEra; var jy, m, d: Word);
var
  yy, mm, dd: Word;
begin
  AEra := GetJapaneseEra(ADate);
  DecodeDate(ADate, yy, mm, dd);
  jy := yy - c9EraBeginDate[AEra].FChristianEra + 1;
  m := mm;
  d := dd;
end;

{ Ts0DateTimeHelper }

class function Ts0DateTimeHelper.TimeToFloat(AValue: TDateTime;
  AUnit: K0TimeUnitKind): Extended;
begin
  Result := AValue / c0TimeUnitValue[AUnit];
end;

class function Ts0DateTimeHelper.DateTimeToStrWithMiliSec(
  pDateTime: TDateTime): string;
begin
  Result := DateToStr(pDateTime) +' '+ TimeToStrWithMiliSec(pDateTime);
end;

class function Ts0DateTimeHelper.FloatToTime(AValue: Extended;
  AUnit: K0TimeUnitKind): TDateTime;
begin
  Result := AValue * c0TimeUnitValue[AUnit];
end;

class function Ts0DateTimeHelper.TimeToStrWithMiliSec(pDateTime: TDateTime): string;
var
  h, m, s, ms: Word;
begin
  DecodeTime(pDateTime, h, m, s, ms);
  Result := Format('%d:%d:%d:%d', [ h, m, s, ms ]);
end;

end.

