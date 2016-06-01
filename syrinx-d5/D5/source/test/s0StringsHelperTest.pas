unit s0StringsHelperTest;

interface

uses
	SysUtils, Classes, TestFrameWork;

type
  Ts0StringsHelperTest = class(TTestCase)
  published
  	procedure TestToSVString;
  	procedure TestFromSVString;
  end;

implementation

uses
	s0StringsHelper;

{ Ts0StringsHelperTest }

procedure Ts0StringsHelperTest.TestFromSVString;
  procedure CheckStrings(Expected: array of String; Actual: TStrings);
  begin

  end;
const
  svString_1: string = '"Stri,ng 1","Stri""ng 2","String 3",String4';
	expected_1: array[0..3] of String = ('Stri,ng 1', 'Stri"ng 2', 'String 3', 'String4');
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
  	Ts0StringsHelper.FromSVString(sl, svString_1);
		CheckStrings(expected_1, sl);
  finally
    FreeAndNil(sl);
  end;
end;


procedure Ts0StringsHelperTest.TestToSVString;
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
  	CheckEquals('', Ts0StringsHelper.ToSVString(sl));
    sl.Add('');
  	CheckEquals('""', Ts0StringsHelper.ToSVString(sl));
  	CheckEquals('''''', Ts0StringsHelper.ToSVString(sl, ',', ''''));
    sl.Clear;
    //
  	sl.Add('Stri,ng 1');
		sl.Add('Stri"ng 2');
		sl.Add('String 3');
		sl.Add('String4');
    CheckEquals('"Stri,ng 1","Stri""ng 2","String 3",String4', Ts0StringsHelper.ToSVString(sl));
    CheckEquals('''Stri,ng 1'',''Stri"ng 2'',''String 3'',String4', Ts0StringsHelper.ToSVString(sl, ',', ''''));
    CheckEquals('"Stri,ng 1";"Stri""ng 2";"String 3";String4', Ts0StringsHelper.ToSVString(sl, ';'));
  finally
    FreeAndNil(sl);
  end;
end;

initialization
	TestFramework.RegisterTest(Ts0StringsHelperTest.Suite);
  
end.
