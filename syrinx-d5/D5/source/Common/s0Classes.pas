unit s0Classes;

interface

uses
  SysUtils, Classes;

type
  Is0Identified = interface
  ['{2F7E9C4F-693C-40B4-A7B9-3D2AE0379BF8}']
    function GetIdentifier: string;
    property Identifier: string read GetIdentifier;
  end;

type
  Is0Modified = interface
  ['{9EE455A9-B7C4-4DE0-86AD-F41DD095378B}']
    function GetModified: Boolean;
    procedure SetModified(const Value: Boolean); 
    property Modified: Boolean read GetModified write SetModified;
  end;

type
  Is0Notifier = interface
  ['{A00A1A0D-09EE-45D5-937A-5E5BC9F26BC8}']
    procedure Notify;
  end;

type
  Is0Listener = interface
  ['{5D21B7A7-9BCC-46DB-B94F-723FFB0401FB}']
    procedure Notified(AObject: TObject);
  end;

type
  Is0NotifierChain = interface(Is0Notifier)
  ['{EC83CD71-FA47-4697-B5A1-58132514C5D6}']
    procedure Notified(AObject: TObject);
  end;

const
  kernel = 'kernel32.dll';

function InterlockedIncrement(var Addend: Integer): Integer; stdcall;
  external kernel name 'InterlockedIncrement';

function InterlockedDecrement(var Addend: Integer): Integer; stdcall;
  external kernel name 'InterlockedDecrement';

implementation

end.
