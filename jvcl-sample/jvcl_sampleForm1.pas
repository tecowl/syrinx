unit jvcl_sampleForm1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, ExtCtrls,
  s0Panel, s0VCLClasses, s0CtrlDragger, s0ComponentEventWrapper,
  s0FormEventPublisher, s0ObjPropStocker, s0IniPropStocker, JvToolEdit,
  Mask, JvExMask, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit,
  ComCtrls, JvgGridHeaderControl, JvComponent, JvgJump, JvExComCtrls,
  JvDateTimePicker, JvMonthCalendar, JvExControls, JvCalendar, JvBaseEdits,
  JvEditorCommon, JvUnicodeEditor, JvUnicodeHLEditor, JvButton,
  JvNavigationPane, JvPageList, JvDBGridFooter, JvDBLookup, JvSpin,
  JvDBSpinEdit, JvDBDateTimePicker, JvDBUltimGrid;

type
  TForm1 = class(TForm)
    Table1: TTable;
    Database1: TDatabase;
    DataSource1: TDataSource;
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0CtrlDragger1: Ts0CtrlDragger;
    s0Panel1: Ts0Panel;
    Button1: TButton;
    Button2: TButton;
    JvDatePickerEdit1: TJvDatePickerEdit;
    JvDateEdit1: TJvDateEdit;
    JvDateTimePicker1: TJvDateTimePicker;
    JvCalcEdit1: TJvCalcEdit;
    JvDBUltimGrid1: TJvDBUltimGrid;
    JvDBDateTimePicker1: TJvDBDateTimePicker;
    JvDBSpinEdit1: TJvDBSpinEdit;
    JvDBLookupCombo1: TJvDBLookupCombo;
    JvDBLookupList1: TJvDBLookupList;
    JvDBGridFooter1: TJvDBGridFooter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  s0CtrlDragger1.BeginDragging;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  s0CtrlDragger1.EndDragging;
end;

end.

