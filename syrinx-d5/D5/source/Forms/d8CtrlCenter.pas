unit d8CtrlCenter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0Entity, s0EntityFormManager, Db, DBTables, s0Database;

type
  Tdm8CtrlCenter = class(TDataModule)
    s0Database1: Ts0Database;
  private
  public
  end;

var
  dm8CtrlCenter: Tdm8CtrlCenter;

implementation

{$R *.DFM}

end.
