unit SimpleControlDemoForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CustomComplexCtrl, s0DateEdit, tec1DateEdit, ComCtrls;

type
  TForm1 = class(TForm)
    tec1DateEdit1: Ttec1DateEdit;
    DateTimePicker1: TDateTimePicker;
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
