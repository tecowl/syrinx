unit s0fDlgConfirmUser;
{
$History: s0fDlgConfirmUser.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * ê⁄ì™é´ÇïœçXÅBxxSXÅ`Ç…ÇµÇΩÅB
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/06   Time: 14:15
 * Created in $/source/p0common
 * êVãKçÏê¨
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  s0User;

type
  Ts0frmCustomDlgConfirmUser = class(TForm)
  private
    FMode: K0ConfirmItemKindSet;
  protected
    function GetPassword: string; virtual;
    function GetUserName: string; virtual;
    procedure SetPassword(const Value: string); virtual;
    procedure SetUserName(const Value: string); virtual;
    procedure Initialize; virtual;
  public
    function ShowModal(AMode: K0ConfirmItemKindSet): Integer; reintroduce; virtual;
    property Mode: K0ConfirmItemKindSet read FMode;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
  end;

type
  Ts0frmDlgConfirmUser = class(Ts0frmCustomDlgConfirmUser)
    lblUserName: TLabel;
    edtUserName: TEdit;
    edtPassword: TEdit;
    lblPassword: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    lblConfirmPW: TLabel;
    edtConfirmPW: TEdit;
    procedure edtPasswordChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    function GetPassword: string; override;
    function GetUserName: string; override;
    procedure SetPassword(const Value: string); override;
    procedure SetUserName(const Value: string); override;
    procedure Initialize; override;
  end;

var
  s0frmDlgConfirmUser: Ts0frmDlgConfirmUser;

implementation

{$R *.DFM}

{ Ts0frmCustomDlgConfirmUser }

function Ts0frmCustomDlgConfirmUser.GetPassword: string;
begin
  Result := '';
end;

function Ts0frmCustomDlgConfirmUser.GetUserName: string;
begin
  Result := '';
end;

procedure Ts0frmCustomDlgConfirmUser.Initialize;
begin
end;

procedure Ts0frmCustomDlgConfirmUser.SetPassword(const Value: string);
begin
end;

procedure Ts0frmCustomDlgConfirmUser.SetUserName(const Value: string);
begin
end;

function Ts0frmCustomDlgConfirmUser.ShowModal(
  AMode: K0ConfirmItemKindSet): Integer;
begin
  FMode := AMode;
  Initialize;
  Result := inherited ShowModal;
end;

{ Ts0frmDlgConfirmUser }

function Ts0frmDlgConfirmUser.GetPassword: string;
begin
  Result := edtPassword.Text;
end;

function Ts0frmDlgConfirmUser.GetUserName: string;
begin
  Result := edtUserName.Text;
end;

procedure Ts0frmDlgConfirmUser.Initialize;
  procedure SetEditColor(AEdit: TEdit);
  begin
    if AEdit.ReadOnly then
      AEdit.Color := Self.Color
    else
      AEdit.Color := clWindow;
  end;
const
  c9FormHeight_Full = 132;
  c9FormHeight_Half = 104;
begin
  edtUserName.ReadOnly := not (k0cikUserName in FMode);
  edtPassword.ReadOnly := not (k0cikPassword in FMode);
  edtConfirmPW.Visible := (k0cikConfirmPW in FMode);
  lblConfirmPW.Visible := edtConfirmPW.Visible;
  if (k0cikConfirmPW in FMode) then
    Self.Height := c9FormHeight_Full
  else
    Self.Height := c9FormHeight_Half;
end;

procedure Ts0frmDlgConfirmUser.SetPassword(const Value: string);
begin
  edtPassword.Text := Value;
end;

procedure Ts0frmDlgConfirmUser.SetUserName(const Value: string);
begin
  edtUserName.Text := Value;
end;

procedure Ts0frmDlgConfirmUser.edtPasswordChange(Sender: TObject);
begin
  if not (k0cikConfirmPW in FMode) then Exit;
  btnOK.Enabled := (edtPassword.Text = edtConfirmPW.Text);
end;

procedure Ts0frmDlgConfirmUser.FormShow(Sender: TObject);
begin
  if k0cikUserName in FMode then edtUserName.SetFocus
  else
  if k0cikPassword in FMode then edtPassword.SetFocus;
  //
  if k0cikConfirmPW in FMode then
    btnOK.Enabled := False;
end;

end.
