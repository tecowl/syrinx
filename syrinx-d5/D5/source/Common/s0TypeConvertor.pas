unit s0TypeConvertor;
{
$History: s0TypeConvertor.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/11/21   Time: 20:55
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/11/21   Time: 3:50
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0common
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 * 
 * *****************  Version 6  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes; 

const
  {
    Ord(False) = 0
    Ord(True) = 1
  }
  c0Value_Int_False  = Ord(False);
  c0Value_Int_True   = Ord(True);
  c0Value_Int_Grayed = 2;

const
  c0Value_String_True  = 'TRUE';
  c0Value_String_False = 'FALSE';

type
  {
    this Class is convert a value of a type to a value of other type.
    Bool    Boolean
    DT      TDateTime
    Float   Double
    Int     Integer
    Str     string
  }
  Ts0TypeConv = class
  public
    // from Boolean...
    class function BoolToFloat(Value: Boolean): Double   ;
    class function BoolToInt  (Value: Boolean): Integer  ;
    class function BoolToDT   (Value: Boolean): TDateTime;
    class function BoolToStr  (Value: Boolean): string   ;
    // from TDateTime...
    class function DTToBool (Value: TDateTime): Boolean;
    class function DTToFloat(Value: TDateTime): Double ;
    class function DTToInt  (Value: TDateTime): Integer;
    class function DTToStr  (Value: TDateTime): string ;
    // from Double...
    class function FloatToBool(Value: Double): Boolean  ;
    class function FloatToInt (Value: Double): Integer  ;
    class function FloatToDT  (Value: Double): TDateTime;
    class function FloatToStr (Value: Double): string   ;
    // from Integer...
    class function IntToBool (Value: Integer): Boolean  ;
    class function IntToFloat(Value: Integer): Double   ;
    class function IntToDT   (Value: Integer): TDateTime;
    class function IntToStr  (Value: Integer): string   ;
    // from string...
    class function StrToBool (Value: string): Boolean  ;
    class function StrToFloat(Value: string): Double   ;
    class function StrToInt  (Value: string): Integer  ;
    class function StrToDT   (Value: string): TDateTime;
  end;



implementation


{ Ts0TypeConv }


class function Ts0TypeConv.BoolToDT(Value: Boolean): TDateTime;
begin
  if Value then Result := IntToDT( c0Value_Int_True )
           else Result := IntToDT( c0Value_Int_False );
end;

class function Ts0TypeConv.BoolToFloat(Value: Boolean): Double;
begin
  if Value then Result := IntToFloat( c0Value_Int_True )
           else Result := IntToFloat( c0Value_Int_False );
end;

class function Ts0TypeConv.BoolToInt(Value: Boolean): Integer;
begin
  if Value then Result := c0Value_Int_True
           else Result := c0Value_Int_False;
end;

class function Ts0TypeConv.BoolToStr(Value: Boolean): string;
begin
  if Value then
    Result := c0Value_String_True
  else
    Result := c0Value_String_False;
end;




class function Ts0TypeConv.DTToBool(Value: TDateTime): Boolean;
begin
  Result := DTToInt(Value) <> c0Value_Int_False;
end;

class function Ts0TypeConv.DTToFloat(Value: TDateTime): Double;
begin
  Result := Double( Value );
end;

class function Ts0TypeConv.DTToInt(Value: TDateTime): Integer;
begin
  Result := FloatToInt( DTToFloat(Value) );
end;

class function Ts0TypeConv.DTToStr(Value: TDateTime): string;
begin
  //Result := SysUtils.DateTimeToStr(Value);
  Result := SysUtils.FormatDateTime('yyyy/mm/dd hh:nn:ss:zzz', Value);
end;





class function Ts0TypeConv.FloatToBool(Value: Double): Boolean;
begin
  Result := FloatToInt(Value) <> c0Value_Int_False;
end;

class function Ts0TypeConv.FloatToDT(Value: Double): TDateTime;
begin
  Result := TDateTime( Value );
end;

class function Ts0TypeConv.FloatToInt(Value: Double): Integer;
begin
  Result := Trunc( Value );
end;

class function Ts0TypeConv.FloatToStr(Value: Double): string;
begin
  Result := SysUtils.FloatToStr( Value );
end;




class function Ts0TypeConv.IntToBool(Value: Integer): Boolean;
begin
  Result := Value <> c0Value_Int_False;
end;

class function Ts0TypeConv.IntToDT(Value: Integer): TDateTime;
begin
  Result := FloatToDT( IntToFloat(Value) );
end;

class function Ts0TypeConv.IntToFloat(Value: Integer): Double;
begin
  Result := Value;
end;

class function Ts0TypeConv.IntToStr(Value: Integer): string;
begin
  Result := SysUtils.IntToStr(Value);
end;





class function Ts0TypeConv.StrToBool(Value: string): Boolean;
begin
  Result := (CompareText(Value, c0Value_String_True) = 0);
end;

class function Ts0TypeConv.StrToDT(Value: string): TDateTime;
begin
  try
    Result := SysUtils.StrToDateTime( Value );
  except
    on E1: EConvertError do
    begin
      try
        Result := SysUtils.StrToDate( Value );
      except
        on E2: EConvertError do
        begin
          try
            Result := SysUtils.StrToTime( Value );
          except
            on E3: EConvertError do
              Result := 0;
          end;
        end;
      end;
    end;
  end;
end;

class function Ts0TypeConv.StrToFloat(Value: string): Double;
begin
  try
    Result := SysUtils.StrToFloat( Value );
  except
    on E: EConvertError do
      Result := 0;
  end;
end;

class function Ts0TypeConv.StrToInt(Value: string): Integer;
begin
  Result := SysUtils.StrToIntDef( Value, 0);
end;

end.
