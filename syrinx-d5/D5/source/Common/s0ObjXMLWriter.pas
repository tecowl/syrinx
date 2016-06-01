{-----------------------------------------------------------------------------
 Unit Name: s0ObjXMLWriter
 Author:    akima
 See: s0ObjXMLReader
 Purpose:
 History:
-----------------------------------------------------------------------------}
unit s0ObjXMLWriter;

interface

uses
  SysUtils, Classes,
  Contnrs,
  s0TaggedPage,
  s0TypInfoWrapper;

type
  Ts0ObjXMLWriter = class(Ts0TaggedPageObjectCommand)
  protected
    function AddObject(AObj: TObject; AParent: Ts0Tags): Ts0Tag;
    function AddObjects(AObjects: TObjectList; AParent: Ts0Tags): Ts0Tag;
    function AddProperty(AAccessor: Ts0RTTIPublishedAccessor;
      AProp: Ts0RTTIProp; AParent: Ts0Tags): Ts0Tag;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Execute; override;
  end;

implementation

uses
  TypInfo;

{ Ts0ObjXMLWriter }

function Ts0ObjXMLWriter.AddObject(AObj: TObject; AParent: Ts0Tags): Ts0Tag;
  procedure AddPropByRTTI;
  var
    acsr: Ts0RTTIPublishedAccessor;
    i: Integer;
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      for i := 0 to acsr.RTTINavigator.Props.Count -1 do
        AddProperty(acsr, acsr.RTTINavigator.Props.Props[i], Result.Contents);
    finally
      FreeAndNil(acsr);
    end;
  end;
  procedure AddAsStrings(AStrings: TStrings);
  var
    i: Integer;
    t: Ts0Tag;
  begin
    for i := 0 to AStrings.Count -1 do
    begin
      t := Result.Contents.AddTag('Strings', False);
      t.ParamValues['value'] := AStrings.Strings[i];
      t.Footer := '/';
    end;
  end;
  procedure AddAsCollection(ACollection: TCollection);
  var
    list: TObjectList;
    i: Integer;
  begin
    list := TObjectList.Create(False);
    try
      for i := 0 to ACollection.Count -1 do
        list.Add(ACollection.Items[i]);
      AddObjects(list, Result.Contents);
    finally
      FreeAndNil(list);
    end;
  end;
  procedure AddAsObjectList(AObjList: TObjectList);
  begin
    if AObjList.OwnsObjects then
      AddObjects(AObjList, Result.Contents)
    else
    begin
      //Add as reference
    end;
  end;
begin
  Result := AParent.AddTag('object', True);
  if AObj <> nil then
    Result.ParamValues['class'] := AObj.ClassName
  else
    Exit;
  //
  if AObj is TStrings then
    AddAsStrings(TStrings(AObj))
  else
  if AObj is TCollection then
    AddAsCollection(TCollection(AObj))
  else
  if AObj is TObjectList then
    AddAsObjectList(TObjectList(AObj));
  //
  AddPropByRTTI;
end;

function Ts0ObjXMLWriter.AddObjects(AObjects: TObjectList;
  AParent: Ts0Tags): Ts0Tag;
var
  i: Integer;
begin
  Result := AParent.AddTag('objects', True);
  for i := 0 to AObjects.Count -1 do
    AddObject(AObjects.Items[i], Result.Contents);
end;

function Ts0ObjXMLWriter.AddProperty(AAccessor: Ts0RTTIPublishedAccessor;
  AProp: Ts0RTTIProp; AParent: Ts0Tags): Ts0Tag;
  procedure AddObjProp(AObjProp: TObject; APropTag: Ts0Tag);
  var
    trmnt: Ts0Tag;
  begin
    if AObjProp = nil then
    begin
      APropTag.ParamValues['value'] := 'nil';
      APropTag.Footer := '/';
    end
    else
    begin
      APropTag.ParamValues['value'] := 'sub_object';
      AddObject(AObjProp, APropTag.Contents);
      trmnt := AParent.AddTag('property', False);
      trmnt.Header := '/';
    end;
  end;
begin
  Result := AParent.AddTag('property', False);
  Result.ParamValues['name'] := AProp.PropName;
  Result.ParamValues['type'] := AProp.TypeInfo.TypeName;
  if AProp.TypeInfo.TypeKind = tkClass then
  begin
    AddObjProp(AAccessor.ObjectProp[AProp.PropName], Result);
  end
  else
  begin
    Result.ParamValues['value'] :=
      AAccessor.PropAsString[AProp.PropName];
    Result.Footer := '/';
  end;
end;

constructor Ts0ObjXMLWriter.Create(AOwner: TComponent);
begin
  inherited;
  Objects.OwnsObjects := False;
end;

procedure Ts0ObjXMLWriter.Execute;
  function AddHeader: Ts0Tag;
  begin
    Result := Page.Contents.AddTag('xml', False);
    Result.Header := '?';
    Result.Footer := '?';
    Result.ParamValues['version'] := '1.0';
    Result.ParamValues['encoding'] := 'Shift_JIS';
  end;
  function AddComment: Ts0Tag;
  begin
    Result :=
      Page.Contents.AddDescription(
        '<!-- Syrinx XML Format for Object Serialization  -->'
      );
  end;
begin
  Page.PolicyName := 'XML';
  Page.Contents.Clear;
  AddHeader;
  AddComment;
  AddObjects(Objects, Page.Contents);
end;

end.
