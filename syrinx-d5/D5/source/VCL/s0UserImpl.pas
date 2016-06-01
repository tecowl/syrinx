{-----------------------------------------------------------------------------
 Unit Name: s0UserImpl
 Author:    akima
 Purpose:
 TestCase:
 See:
 $History: s0UserImpl.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
-----------------------------------------------------------------------------}

unit s0UserImpl;

interface

uses
  SysUtils, Classes,
  s0User;

type
  Ts0GUIUserManager = class(Ts0CustomGUIUserManager)
  protected
    function ShowCertifyDlg(AMode: K0ConfirmItemKindSet; AUser: Ts0User): Boolean; override;
  end;

implementation

uses
  Controls,
  s0fDlgConfirmUser;

{ Ts0GUIUserManager }

function Ts0GUIUserManager.ShowCertifyDlg(AMode: K0ConfirmItemKindSet;
  AUser: Ts0User): Boolean;

  function NewCertifyDlg: Ts0frmCustomDlgConfirmUser;
  begin
    Result := Ts0frmDlgConfirmUser.Create(nil);
  end;
var
  frm: Ts0frmCustomDlgConfirmUser;
begin
  Result := False;
  frm := NewCertifyDlg;
  try
    frm.UserName := AUser.UserName;
    frm.Password := AUser.Password;
    if frm.ShowModal(AMode) <> mrOK then Exit;
    AUser.UserName := frm.UserName;
    AUser.Password := frm.Password;
    Result := True;
  finally
    FreeAndNil(frm);
  end;
end;

initialization
{$IFNDEF VER130}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(Ts0GUIUserManager, TControl);
{$ENDIF}

end.

