{-----------------------------------------------------------------------------
 Unit Name: s0VCLClasses
 Author:    akima
 Purpose:
 See: 
 $History: s0VCLClasses.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
-----------------------------------------------------------------------------}

unit s0VCLClasses;

interface

uses
  SysUtils, Classes,
  Controls,
  s0Persistent,
  s0Collection;

type
  Ts0VCLPersistent = class(Ts0Persistent)
  end;

type
  Ts0VCLCollectionItem = class(Ts0CollectionItem)
  end;

type
  Ts0VCLCollection = class(Ts0Collection)
  end;

type
  Ts0VCLComponent = class(TComponent)
  end;

implementation

initialization
{$IFNDEF VER130}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(Ts0VCLPersistent, TControl);
  GroupDescendentsWith(Ts0VCLCollectionItem, TControl);
  GroupDescendentsWith(Ts0VCLCollection, TControl);
  GroupDescendentsWith(Ts0VCLComponent, TControl);
{$ENDIF}

end.
