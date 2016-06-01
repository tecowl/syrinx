unit s0CtrlProxy;

interface

uses
  SysUtils, Classes, Controls;

type
  Is0CtrlProxy = interface(IUnknown)
    function GetControl: TControl;
    procedure SetControl(Value: TControl);
    property Control: TControl read GetControl write SetControl;
  end;

implementation

end.
