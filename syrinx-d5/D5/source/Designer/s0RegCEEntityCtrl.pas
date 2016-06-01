unit s0RegCEEntityCtrl;

interface

uses
  SysUtils, Classes,
{$IFDEF VER130}
  DsgnIntf;
{$ELSE}
  DesignIntf,DesignEditors, VCLEditors, RTLConsts;
{$ENDIF}

procedure Register;

implementation

procedure Register;
begin
  { Component Editors }

  { Property Editors }
end;

end.
