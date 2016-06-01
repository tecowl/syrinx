unit f8TagTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CustomComplexCtrl, s0ObjTreeView, ExtCtrls, s0TagPolicy, s0TaggedPage,
  StdCtrls;

type
  TForm1 = class(TForm)
    s0ObjTreeView1: Ts0ObjTreeView;
    Panel1: TPanel;
    Button1: TButton;
    s0TaggedPage1: Ts0TaggedPage;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  if not OpenDialog1.Execute then Exit;
  s0TaggedPage1.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  s0ObjTreeView1.Target := s0TaggedPage1;
end;

end.
