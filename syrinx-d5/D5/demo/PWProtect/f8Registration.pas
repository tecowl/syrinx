unit f8Registration;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  c8PWController;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
  	FController: T8PWController;
  public
  	constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


constructor TForm1.Create(AOwner: TComponent);
begin
  inherited;
	FController := T8PWControllerFactory.GetSingletonOfForm(False);
end;

destructor TForm1.Destroy;
begin
	FreeAndNil(FController);
  inherited;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
	Label2.Caption := '';
	if FController.CheckPW(Edit1.Text) then
  begin
  	FController.SavePW(Edit1.Text);
    Label2.Font.Color := clWindowText;
		Label2.Caption := 'パスワードの登録が完了しました。';
  end
  else
  begin
  	Label2.Font.Color := clRed;
		Label2.Caption := 'パスワードが正しくありません。';
  end;
end;

end.
