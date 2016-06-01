unit f8EntityListTemplate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0f1EntityDBGridList, ActnList, Db, s0f0EntityDisplay, s0EntityListImpl,
  s0FormEventPublisher, s0FormRelation, ComCtrls, Grids, DBGrids,
  s0Entity;

type
  Tfrm8EntityListTemplate = class(Ts0frmEntityDBGridList)
  private
  public
    class function GetTargetClassBeforeCreate: Ts0EntityClass; override;
  end;

var
  frm8EntityListTemplate: Tfrm8EntityListTemplate;

implementation

{$R *.DFM}

{ Tfrm8EntityListTemplate }

class function Tfrm8EntityListTemplate.GetTargetClassBeforeCreate: Ts0EntityClass;
begin
  Result := nil;
end;

end.
