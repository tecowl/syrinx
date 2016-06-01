unit s0fFusen;
{
$History: s0fFusen.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマンド追加
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  Ts0frmFusen = class(TForm)
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
  end;

var
  frm0Fusen: Ts0frmFusen;

implementation

{$R *.DFM}

procedure Ts0frmFusen.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := WS_POPUP or WS_THICKFRAME;
end;

procedure Ts0frmFusen.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
  begin
    ReleaseCapture;
    SendMessage(Handle,WM_SYSCOMMAND, SC_MOVE or 2, MakeLong(X, Y));
  end;
end;

end.
 
