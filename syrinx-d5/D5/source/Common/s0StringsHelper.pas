unit s0StringsHelper;
{
$History: s0StringsHelper.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/04/19   Time: 11:26
 * Updated in $/D5/source/Common
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
 * User: Akima        Date: 01/09/20   Time: 18:39
 * Updated in $/source/D5Integrated
 * IndexOfValueメソッドを追加
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/08   Time: 15:44
 * Created in $/source/p0common
 * 新規作成
 * s0ExStringListから抽出した。
}

interface

uses
  SysUtils, Classes;

type
  Ts0StringsHelper = class
  public
    class function IndexOfHeader(Source: TStrings; AHeader: string; ADelim: Char = ':'): Integer;
    class function IndexOfValue(Source: TStrings; Value: string): Integer;
    class function IndexOfHeaderAsInt(Source: TStrings; AHeader: Integer; ADelim: Char = ':'): Integer;
    class function ObjectByName(Source: TStrings; AName: string): TObject;
    class function ObjectByStr(Source: TStrings; AStr: string): TObject;
    class function StringByObj(Source: TStrings; AObj: TObject): string;
    class procedure DeleteByObj(Source: TStrings; AObj: TObject);
    class procedure CopyToStrings(Dest: TStrings; Source: array of string);
    class function NewStringList(Source: array of string; AClass: TClass = nil): TStrings;
    class function ToSVString(Source: TStrings; Delimiter: Char = ','; Quote: Char = '"'): String;
		class procedure FromSVString(Dest: TStrings; const Value: string; Delimiter: Char = ','; Quote: Char = '"');
  end;


implementation

uses
	Windows,
  s0StringHelper;

{ Ts0StringsHelper }

class procedure Ts0StringsHelper.CopyToStrings(Dest: TStrings;
  Source: array of string);
var
  i: Integer;
begin
  for i := Low(Source) to High(Source) do
    Dest.Add(Source[i]);
end;

class procedure Ts0StringsHelper.DeleteByObj(Source: TStrings;
  AObj: TObject);
var
  idx: Integer;
begin
  repeat
    idx := Source.IndexOfObject(AObj);
    if idx > -1 then
      Source.Delete(idx);
  until idx < 0;
end;

class function Ts0StringsHelper.IndexOfHeader(Source: TStrings;
  AHeader: string; ADelim: Char): Integer;
begin
  Result := IndexOfHeaderAsInt(Source, StrToIntDef(AHeader, -1), ADelim);
end;

class function Ts0StringsHelper.IndexOfHeaderAsInt(Source: TStrings;
  AHeader: Integer; ADelim: Char): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Source.Count -1 do
    if AHeader = StrToIntDef(Ts0StringHelper.GetNameSliced(Source.Strings[i], ADelim), -1) then
    begin
       Result := i;
       Exit;
    end;
end;

class function Ts0StringsHelper.IndexOfValue(Source: TStrings;
  Value: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Source.Count -1 do
  begin
    if Source.Values[ Source.Names[i] ] = Value then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

class function Ts0StringsHelper.NewStringList(Source: array of string;
  AClass: TClass): TStrings;
begin
  if (AClass <> nil) and AClass.InheritsFrom(TStrings) then
    Result := TStrings( AClass.Create )
  else
    Result := TStringList.Create;
  CopyToStrings(Result, Source);
end;

class function Ts0StringsHelper.ObjectByName(Source: TStrings;
  AName: string): TObject;
var
  idx: Integer;
begin
  Result := nil;
  idx := Source.IndexOfName(AName);
  if idx < 0 then Exit;
  Result := Source.Objects[idx];
end;

class function Ts0StringsHelper.ObjectByStr(Source: TStrings; AStr: string): TObject;
var
  idx: Integer;
begin
  Result := nil;
  idx := Source.IndexOf(AStr);
  if idx < 0 then Exit;
  Result := Source.Objects[idx];
end;

class function Ts0StringsHelper.StringByObj(Source: TStrings; AObj: TObject): string;
var
  idx: Integer;
begin
  Result := '';
  idx := Source.IndexOfObject(AObj);
  if idx < 0 then Exit;
  Result := Source.Strings[idx];
end;

class function Ts0StringsHelper.ToSVString(Source: TStrings; Delimiter,
  Quote: Char): String;
var
  S: string;
  P: PChar;
  I, Count: Integer;
begin
  Count := Source.Count;
  if (Count = 1) and (Source.Strings[0] = '') then
  begin
    Result := Quote + Quote;
  end
  else
  begin
    Result := '';
    for I := 0 to Count - 1 do
    begin
      S := Source.Strings[I];
      P := PChar(S);
      while not (P^ in [#0..' ',Quote, Delimiter]) do
      	P := CharNext(P);
      if (P^ <> #0) then
      	S := AnsiQuotedStr(S, Quote);
      Result := Result + S + Delimiter;
    end;
    System.Delete(Result, Length(Result), 1);
  end;
end;

class procedure Ts0StringsHelper.FromSVString(Dest: TStrings; const Value: string; Delimiter,
  Quote: Char);
var
  P, P1: PChar;
  S: string;
begin
  Dest.BeginUpdate;
  try
    Dest.Clear;
    P := PChar(Value);
    while P^ in [#1..' '] do
    	P := CharNext(P);
    while P^ <> #0 do
    begin
      if P^ = Quote then
        S := AnsiExtractQuotedStr(P, Quote)
      else
      begin
        P1 := P;
        while (P^ > ' ') and (P^ <> Delimiter) do
        	P := CharNext(P);
        SetString(S, P1, P - P1);
      end;
      Dest.Add(S);
      while P^ in [#1..' '] do
      	P := CharNext(P);
      if P^ = Delimiter then
        repeat
          P := CharNext(P);
        until not (P^ in [#1..' ']);
    end;
  finally
    Dest.EndUpdate;
  end;
end;

end.
