unit s0CheckBoxHelper;
{
$History: s0CheckBoxHelper.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/08   Time: 18:14
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/01   Time: 9:13
 * Updated in $/source/D5Integrated
 * StrToBoolメソッドを追加
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes, StdCtrls;

const
  c0Value_Str_Checked = 'CHECKED';
  c0Value_Str_Unchecked = 'UNCHECKED';
  c0Value_Str_Grayed = 'GRAYED';

type
  Ts0CheckBoxHelper = class
  public
    class function StateToInt(AState: TCheckBoxState): Integer;
    class function IntToState(Value: Integer): TCheckBoxState;
    class function StrToState(Value: string; AAllowGrayed: Boolean = False): TCheckBoxState;
    class function StateToStr(AState: TCheckBoxState; AAllowGrayed: Boolean = False): string;
    class function BoolToState(Value: Boolean): TCheckBoxState;
    class function SateToBool(AState: TCheckBoxState; AGrayIsTrue: Boolean = False): Boolean;
    class function StrToBool(Value: String): Boolean;
  end;

implementation

uses
  s0TypeConvertor;

{ Ts0CheckBoxHelper }

class function Ts0CheckBoxHelper.BoolToState(
  Value: Boolean): TCheckBoxState;
begin
  if Value then
    Result := cbChecked
  else
    Result := cbUnchecked;
end;

class function Ts0CheckBoxHelper.IntToState(Value: Integer): TCheckBoxState;
begin
  Result := cbUnchecked;
  case Value of
    c0Value_Int_False : Result := cbUnchecked;
    c0Value_Int_True  : Result := cbChecked;
    c0Value_Int_Grayed: Result := cbGrayed;
  end;
end;

class function Ts0CheckBoxHelper.SateToBool(AState: TCheckBoxState;
  AGrayIsTrue: Boolean): Boolean;
begin
  Result := False;
  case AState of
    cbUnchecked: Result := False;
    cbChecked  : Result := True;
    cbGrayed   : Result := AGrayIsTrue;
  end;
end;

class function Ts0CheckBoxHelper.StateToInt(
  AState: TCheckBoxState): Integer;
const
  c9StateVal: array[TCheckBoxState] of Integer = (
    c0Value_Int_False, c0Value_Int_True, c0Value_Int_Grayed
  );
begin
  Result := c9StateVal[AState];
end;

class function Ts0CheckBoxHelper.StateToStr(AState: TCheckBoxState; AAllowGrayed: Boolean): string;
const
  c9StateStr: array[TCheckBoxState] of string = (
    c0Value_Str_Unchecked, c0Value_Str_Checked, c0Value_Str_Grayed
  );
begin
  Result := c9StateStr[AState];
  if (not AAllowGrayed) and (AState = cbGrayed) then
    Result := c9StateStr[cbUnchecked];
end;

class function Ts0CheckBoxHelper.StrToBool(Value: String): Boolean;
begin
  Value := Trim(Value);
  if SameText(Ts0TypeConv.BoolToStr(True), Value) then
    Result := True
  else
  if SameText(Ts0TypeConv.BoolToStr(False), Value) then
    Result := False
  else
    Result := not SameText(StateToStr(cbUnchecked), Value);
end;

class function Ts0CheckBoxHelper.StrToState(Value: string; AAllowGrayed: Boolean): TCheckBoxState;
var
  i: TCheckBoxState;
begin
  Result := cbUnchecked;
  Value := Trim(Value);
  if SameText(Value, Ts0TypeConv.BoolToStr(True)) then
    Result := cbChecked
  else
  if SameText(Value, Ts0TypeConv.BoolToStr(False)) then
    Result := cbUnchecked
  else
  begin
    for i := Low(TCheckBoxState) to High(TCheckBoxState) do
    begin
      if (not AAllowGrayed) and (i = cbGrayed) then Continue;
      if SameText(Value, StateToStr(i)) then
      begin
        Result := i;
        Exit;
      end;
    end;
  end;
end;

end.
