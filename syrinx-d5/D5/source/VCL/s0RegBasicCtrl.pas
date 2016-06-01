unit s0RegBasicCtrl;

interface

uses
  SysUtils, Classes;

procedure Register;

implementation

uses
  s0DateEdit,
  s0DigitEdit,
  s0Label,
  s0Memo,
  s0MenuBar,
  s0Panel,
  s0RadioButton,
  s0CheckBox,
  s0FormRelation,
  s0ListBox,
  s0RadioGroup,
  s0ComboBox,
  s0Edit,
  s0ScrollBar,
  s0StaticText,
  s0Button,
  s0Buttons,
  s0Bevel,
  s0Splitter,
  s0GroupBox,
  s0CheckListBox;

procedure Register;
begin
  RegisterComponents('P Form', [Ts0DateEdit]);
  RegisterComponents('P Form', [Ts0DigitEdit]);
  RegisterComponents('P Form', [Ts0Label]);
  RegisterComponents('P Form', [Ts0Memo]);
  RegisterComponents('P Form', [Ts0MenuBar]);
  RegisterComponents('P Form', [Ts0Panel]);
  RegisterComponents('P Form', [Ts0RadioButton]);
  RegisterComponents('P Form', [Ts0CheckBox]);
  RegisterComponents('P Form', [Ts0FormRelation]);
  RegisterComponents('P Form', [Ts0ListBox]);
  RegisterComponents('P Form', [Ts0RadioGroup]);
  RegisterComponents('P Form', [Ts0ComboBox]);
  RegisterComponents('P Form', [Ts0Edit]);

  RegisterComponents('P Form', [Ts0ScrollBar]);
  RegisterComponents('P Form', [Ts0StaticText]);
  RegisterComponents('P Form', [Ts0Button]);
  RegisterComponents('P Form', [Ts0BitBtn]);
  RegisterComponents('P Form', [Ts0Bevel]);
  RegisterComponents('P Form', [Ts0Splitter]);
  RegisterComponents('P Form', [Ts0GroupBox]);
  RegisterComponents('P Form', [Ts0CheckListBox]);
end;

end.
