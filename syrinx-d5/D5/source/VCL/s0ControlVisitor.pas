unit s0ControlVisitor;
{
$History: s0ControlVisitor.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/30   Time: 21:37
 * Updated in $/source/p0control
 * nilチェックを入れておいた。
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/07/30   Time: 10:26
 * Created in $/source/p0control
 * 新規作成
}

interface

uses
  SysUtils, Classes,
  Controls;

type
  Ts0ControlVisitor = class
  protected
    procedure VisitChildren(AControl: TWinControl); 
    procedure VisitControl(AControl: TControl); virtual;
    procedure VisitWinControl(AControl: TWinControl); virtual;
  public
  end;

implementation

{ Ts0ControlVisitor }

procedure Ts0ControlVisitor.VisitChildren(AControl: TWinControl);
var
  i: Integer;
begin
  if AControl = nil then Exit;
  for i := 0 to AControl.ControlCount -1 do
    if AControl.Controls[i] is TWinControl then
      VisitWinControl( TWinControl(AControl.Controls[i]) )
    else
      VisitControl( AControl.Controls[i] );
end;

procedure Ts0ControlVisitor.VisitControl(AControl: TControl);
begin

end;

procedure Ts0ControlVisitor.VisitWinControl(AControl: TWinControl);
begin
  if AControl = nil then Exit;
  VisitControl(AControl);
  VisitChildren(AControl);
end;

end.
