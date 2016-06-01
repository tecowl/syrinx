unit tec1DrawGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids;

type
  Ttec1DrawGrid = class(TDrawGrid)
  private
    { Private éŒ¾ }
  protected
    { Protected éŒ¾ }
  public
    { Public éŒ¾ }
  published
    { Published éŒ¾ }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Techno', [Ttec1DrawGrid]);
end;

end.
