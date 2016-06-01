unit f8Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Tfrm8Main = class(TForm)
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure ShowList;
  public
  end;

var
  frm8Main: Tfrm8Main;

implementation

{$R *.DFM}

uses
  s0Entity;

procedure Tfrm8Main.FormShow(Sender: TObject);
begin
  Ts0EntityRegister.GetEntityNameList(ListBox1.Items);
end;

procedure Tfrm8Main.ListBox1DblClick(Sender: TObject);
begin
  ShowList;
end;

procedure Tfrm8Main.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ShowList;
end;

procedure Tfrm8Main.ShowList;
var
  etyClass: Ts0EntityClass;
begin
  if ListBox1.ItemIndex < 0 then Exit;
  etyClass := Ts0EntityRegister.GetEntityClassByName( ListBox1.Items[ListBox1.ItemIndex] );
  if etyClass = nil then Exit;
  Ts0Entity.ShowList(etyClass, False);
end;

end.
