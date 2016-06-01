unit f8DemoForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComboBox, Tec4SelCombo, ExtCtrls, TecLog, TecNum,
  s0CustomComplexCtrl, s0DateEdit, tec1DateEdit, s0RadioButton,
  tec1RadioButton, s0StaticText, tec1StaticText, CheckLst, s0CheckListBox,
  tec1CheckListBox, s0Grids, s0CellDecorator, s0BindGrid, s0CtrlGrid,
  s0DecoGrid, s0BaseGrid, tec1StringGrid, s0Panel, tec1Panel, s0GroupBox,
  tec1GroupBox, s0ComboBox, tec1ComboBox, s0ListBox, tec1ListBox,
  s0CheckBox, tec1CheckBox, s0Button, tec1Button, s0Memo, tec1Memo, s0Edit,
  tec1Edit, s0Label, tec1Label, s0DigitEdit, tec1DigitEdit, ComCtrls,
  XTIME32, XNUM32, OleCtrls, XDATE32, Menus, Grids, DBGrids, JvExDBGrids,
  JvDBGrid, JvDBUltimGrid, tec1DBGrid, Db, DBTables, s0Table, s0DSCopy,
  s0VCLClasses, s0CtrlEventSnatcher, tec1FocusColor, tec1xNum, tec1xTime,
  tec1xDate, tec1TecNum, tec1Tec4SelCombo, tec1TecDBSelCombo, tec1RichEdit,
  Mask, tec1MaskEdit, tec1ListView, DBCtrls, tec1DBRichEdit,
  tec1DBRadioGroup, tec1DBMemo, tec1DBLookupListBox, tec1DBLookupComboBox,
  tec1DBListBox, tec1DBEdit, tec1DBComboBox, tec1DBCheckBox,
  tec1DateTimePicker, Buttons, tec1BitBtn, tec1Bevel, s0RadioGroup,
  tec1RadioGroup, JvMemoryDataset;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    tec1Label1: Ttec1Label;
    tec1Edit1: Ttec1Edit;
    tec1Memo1: Ttec1Memo;
    tec1Button1: Ttec1Button;
    tec1CheckBox1: Ttec1CheckBox;
    tec1ListBox1: Ttec1ListBox;
    tec1ComboBox1: Ttec1ComboBox;
    tec1GroupBox1: Ttec1GroupBox;
    tec1GroupBox2: Ttec1GroupBox;
    tec1Panel1: Ttec1Panel;
    tec1StringGrid1: Ttec1StringGrid;
    tec1CheckListBox1: Ttec1CheckListBox;
    tec1StaticText1: Ttec1StaticText;
    tec1RadioButton1: Ttec1RadioButton;
    tec1DateEdit1: Ttec1DateEdit;
    TecNum1: TTecNum;
    Tec4SelCombo1: TTec4SelCombo;
    TecDBSelCombo1: TTecDBSelCombo;
    Edit1: TEdit;
    TecNum2: TTecNum;
    TabSheet2: TTabSheet;
    TecNum3: TTecNum;
    TabSheet3: TTabSheet;
    xDate1: TxDate;
    xNum1: TxNum;
    xTime1: TxTime;
    tec1DigitEdit1: Ttec1DigitEdit;
    xDate2: TxDate;
    TabSheet4: TTabSheet;
    s0Table1: Ts0Table;
    DataSource1: TDataSource;
    tec1DBGrid1: Ttec1DBGrid;
    tec1FocusColor1: Ttec1FocusColor;
    tec1xNum1: Ttec1xNum;
    tec1FocusColor2: Ttec1FocusColor;
    tec1FocusColor3: Ttec1FocusColor;
    tec1Edit2: Ttec1Edit;
    TabSheet5: TTabSheet;
    tec1Label2: Ttec1Label;
    tec1Edit3: Ttec1Edit;
    tec1Memo2: Ttec1Memo;
    tec1Button2: Ttec1Button;
    tec1CheckBox2: Ttec1CheckBox;
    tec1ListBox2: Ttec1ListBox;
    tec1ComboBox2: Ttec1ComboBox;
    tec1GroupBox3: Ttec1GroupBox;
    tec1Panel2: Ttec1Panel;
    tec1StringGrid2: Ttec1StringGrid;
    tec1CheckListBox2: Ttec1CheckListBox;
    tec1RadioButton2: Ttec1RadioButton;
    tec1DateEdit2: Ttec1DateEdit;
    tec1DigitEdit2: Ttec1DigitEdit;
    tec1Bevel1: Ttec1Bevel;
    tec1BitBtn1: Ttec1BitBtn;
    tec1DateTimePicker1: Ttec1DateTimePicker;
    tec1DBCheckBox1: Ttec1DBCheckBox;
    tec1DBComboBox1: Ttec1DBComboBox;
    tec1DBEdit1: Ttec1DBEdit;
    tec1DBListBox1: Ttec1DBListBox;
    tec1DBLookupComboBox1: Ttec1DBLookupComboBox;
    tec1DBLookupListBox1: Ttec1DBLookupListBox;
    tec1DBMemo1: Ttec1DBMemo;
    tec1DBRadioGroup1: Ttec1DBRadioGroup;
    tec1DBRichEdit1: Ttec1DBRichEdit;
    tec1ListView1: Ttec1ListView;
    tec1MaskEdit1: Ttec1MaskEdit;
    tec1RichEdit1: Ttec1RichEdit;
    tec1TecDBSelCombo1: Ttec1TecDBSelCombo;
    tec1Tec4SelCombo1: Ttec1Tec4SelCombo;
    tec1xNum2: Ttec1xNum;
    tec1TecNum1: Ttec1TecNum;
    tec1xDate1: Ttec1xDate;
    tec1xTime1: Ttec1xTime;
    tec1xDate2: Ttec1xDate;
    tec1Button3: Ttec1Button;
    tec1RadioGroup1: Ttec1RadioGroup;
    s0Table1Name: TStringField;
    s0Table1Capital: TStringField;
    s0Table1Continent: TStringField;
    s0Table1Area: TFloatField;
    s0Table1Population: TFloatField;
    procedure tec1Button2Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.tec1Button2Click(Sender: TObject);
begin
	tec1xDate2.YearValue := tec1xNum2.AsInteger;
end;

end.

