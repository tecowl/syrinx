unit tec1DrawGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids;

type
  Ttec1DrawGrid = class(TDrawGrid)
  private
    { Private �錾 }
  protected
    { Protected �錾 }
  public
    { Public �錾 }
  published
    { Published �錾 }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1DrawGrid]);
end;

end.
