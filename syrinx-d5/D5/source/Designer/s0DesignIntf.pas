unit s0DesignIntf;

interface

uses
{$IFDEF VER130}
  DsgnIntf,
  Menus;
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
  Menus,
  DesignMenus;
{$ENDIF}

type
{$IFDEF VER130}
   I0Designer = IFormDesigner;
{$ELSE}
   I0Designer = IDesigner;
{$ENDIF}

type
{$IFDEF VER130}
   T0DesignMenu = TMenuItem;
{$ELSE}
   T0DesignMenu = IMenuItem;
{$ENDIF}

implementation

end.

