unit f8TextComp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, s0TextComparer, StdCtrls, ExtCtrls, s0Grids, s0CellDecorator,
  s0BindGrid, s0CtrlGrid, s0DecoGrid, s0BaseGrid, s0ObjectGrid,
  s0CollectionGrid, s0ComponentEventWrapper, s0FormEventPublisher,
  s0ObjPropStocker, s0IniPropStocker;

type
  TForm1 = class(TForm)
    s0TextComparer1: Ts0TextComparer;
    s0CollectionGrid1: Ts0CollectionGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0IniPropStocker1: Ts0IniPropStocker;
    procedure Button1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  s0TextComparer1.Source[kskOne].LoadFromFile(Edit1.Text);
  s0TextComparer1.Source[kskTwo].LoadFromFile(Edit2.Text);
  s0TextComparer1.Compare;
  s0CollectionGrid1.Target := s0TextComparer1.CompareResult;
  s0CollectionGrid1.LoadFromTarget;
end;

end.
