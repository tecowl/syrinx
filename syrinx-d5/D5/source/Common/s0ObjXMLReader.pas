{-----------------------------------------------------------------------------
 Unit Name: s0ObjXMLReader
 Author:    akima
 Ser: s0ObjXMLWriter
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit s0ObjXMLReader;

interface

uses
  SysUtils, Classes,
  Contnrs,
  s0TaggedPage,
  s0TypInfoWrapper;

type
  Ks0NeedInstanceEvent = procedure(Sender: TObject; AObjectTag: Ts0Tag;
    AContainer: TObject; var AInstance: TObject) of object;

type
  Ts0ObjectStack = class(TObjectStack)
  public
    function GetLastObj(ACount: Integer): TObject;
  end;

type
  Ts0ObjXMLReader = class(Ts0TaggedPageObjectCommand)
  private
    FOnNeedInstance: Ks0NeedInstanceEvent;
    function IsNamedTag(ATag: Ts0Tag; AName: string): Boolean;
  protected
    function FindPropObj(AAccessor: Ts0RTTIPublishedAccessor; APropTag, AObjectTag: Ts0Tag): TObject;
    function NewObjByTag(AObjTag: Ts0Tag; AContiner: TObject): TObject;
    procedure LoadObjects(AObjectsContents: Ts0Tags; AContiner: TObject);
    procedure LoadObjProps(AObj: TObject; AObjTag: Ts0Tag);
    procedure LoadProperty(AAccessor: Ts0RTTIPublishedAccessor; APropTag: Ts0Tag);
    procedure ReadObjects(AObjectsTags: Ts0Tags; AContainer: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Execute; override;
  published
    property OnNeedInstance: Ks0NeedInstanceEvent read FOnNeedInstance write FOnNeedInstance;
  end;

implementation

uses
  TypInfo,
  s0StringHelper;

{ Ts0ObjectStack }

function Ts0ObjectStack.GetLastObj(ACount: Integer): TObject;
begin
  if (ACount < 0) or (ACount > List.Count -1) then
    Result := nil
  else
    Result := TObject( List.Items[ List.Count - ACount -1] );
end;

{ Ts0ObjXMLReader }

constructor Ts0ObjXMLReader.Create(AOwner: TComponent);
begin
  inherited;
  Objects.OwnsObjects := True;
end;

procedure Ts0ObjXMLReader.Execute;
begin
  Objects.Clear;
  ReadObjects(Page.Contents, Objects);
end;

function Ts0ObjXMLReader.FindPropObj(AAccessor: Ts0RTTIPublishedAccessor;
  APropTag, AObjectTag: Ts0Tag): TObject;
var
  p: Ts0RTTIProp;
begin
  Result := nil;
  p := AAccessor.RTTINavigator.Props.PropByName(APropTag.ParamValues['name']);
  if p = nil then Exit;
  if p.TypeInfo.TypeName <> APropTag.ParamValues['type'] then Exit;
  Result := AAccessor.ObjectProp[p.PropName];
end;

function Ts0ObjXMLReader.IsNamedTag(ATag: Ts0Tag; AName: string): Boolean;
begin
  Result := SameText(ATag.TagName, AName) and (ATag.Header = #0);
end;

procedure Ts0ObjXMLReader.LoadObjects(AObjectsContents: Ts0Tags;
  AContiner: TObject);
  procedure AddToContainer(AObj: TObject);
  begin
    if (AContiner is TCollection) and (AObj is TCollectionItem) then
    begin
      //NewObjByTagÇ≈ä÷òAïtÇØÇÁÇÍÇƒÇ¢ÇÈÇÕÇ∏Ç»ÇÃÇ≈ÅAâΩÇ‡ÇµÇ»Ç¢
    end
    else
    if AContiner is TObjectList then
      TObjectList(AContiner).Add(AObj);
  end;
var
  i: Integer;
  t: Ts0Tag;
  obj: TObject;
begin
  for i := 0 to AObjectsContents.Count -1 do
  begin
    t := AObjectsContents.Items[i];
    if not IsNamedTag(t, 'object')then Continue;
    obj := NewObjByTag(t, AContiner);
    if obj = nil then Continue;
    LoadObjProps(obj, t);
    AddToContainer(obj);
  end;
end;

procedure Ts0ObjXMLReader.LoadObjProps(AObj: TObject; AObjTag: Ts0Tag);
  procedure ReadByRTTI;
  var
    i: Integer;
    t: Ts0Tag;
    acsr: Ts0RTTIPublishedAccessor;
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AObj);
    try
      for i := 0 to AObjTag.Contents.Count -1 do
      begin
        t := AObjTag.Contents[i];
        if IsNamedTag(t, 'property')then
          LoadProperty(acsr, t);
      end;
    finally
      FreeAndNil(acsr);
    end;
  end;
  procedure ReadAsStrings(AStrings: TStrings);
  var
    i: Integer;
    t: Ts0Tag;
  begin
    AStrings.Clear;
    for i := 0 to AObjTag.Contents.Count -1 do
    begin
      t := AObjTag.Contents[i];
      if IsNamedTag(t, 'Strings') then
        AStrings.Add(t.ParamValues['value']);
    end;
  end;
  procedure ReadAsCollection(ACollection: TCollection);
  begin
    ACollection.Clear;
    ReadObjects(AObjTag.Contents, ACollection);
  end;
  procedure ReadAsObjectList(AList: TObjectList);
  begin
    AList.Clear;
    ReadObjects(AObjTag.Contents, AList);
  end;  
begin
  if AObj = nil then Exit;
  ReadByRTTI;
  if AObj is TStrings then
    ReadAsStrings(TStrings(AObj))
  else
  if AObj is TCollection then
    ReadAsCollection(TCollection(AObj))
  else
  if AObj is TObjectList then
    ReadAsObjectList(TObjectList(AObj));
end;

procedure Ts0ObjXMLReader.LoadProperty(AAccessor: Ts0RTTIPublishedAccessor;
  APropTag: Ts0Tag);
  function FindObjTag(APropContent: Ts0Tags): Ts0Tag;
  var
    i: Integer;
  begin
    for i := 0 to APropContent.Count -1 do
    begin
      Result := APropContent[i];
      if Result.TagName = 'object' then Exit;
    end;
    Result := nil;
  end;
var
  p: Ts0RTTIProp;
  obj: TObject;
  objTag: Ts0Tag;
begin
  p := AAccessor.RTTINavigator.Props.PropByName(APropTag.ParamValues['name']);
  if p = nil then Exit;
  if not SameText(p.TypeInfo.TypeName, APropTag.ParamValues['type']) then Exit;
  if p.TypeInfo.TypeKind = tkClass then
  begin
    if APropTag.ParamValues['value'] = 'sub_object' then
    begin
      objTag := FindObjTag(APropTag.Contents);
      if objTag <> nil then
      begin
        obj := FindPropObj(AAccessor, APropTag, objTag);
        if obj = nil then
        begin
          obj := NewObjByTag(objTag, AAccessor.Instance);
          AAccessor.ObjectProp[APropTag.ParamValues['name']] := obj;
        end;
        LoadObjProps(obj, objTag)
      end;
    end
    else
    if APropTag.ParamValues['value'] = 'nil' then
    begin   
    end;
  end
  else
  begin
    AAccessor.PropAsString[p.PropName] := APropTag.ParamValues['value'];
  end;
end;

function Ts0ObjXMLReader.NewObjByTag(AObjTag: Ts0Tag;
  AContiner: TObject): TObject;
var
  cls: TPersistentClass;
begin
  Result := nil;
  if Assigned(FOnNeedInstance) then
    FOnNeedInstance(Self, AObjTag, AContiner, Result);
  if Result <> nil then Exit;
  cls := GetClass( AObjTag.ParamValues['class'] );
  if cls = nil then Exit;
  if cls.InheritsFrom(TComponent) then
  begin
    if AContiner is TComponent then
      Result := TComponentClass(cls).Create( TComponent(AContiner) )
    else
      Result := TComponentClass(cls).Create(nil);
  end
  else
  if cls.InheritsFrom(TCollectionItem) then
  begin
    if AContiner is TCollection then
      Result := TCollectionItemClass(cls).Create(TCollection(AContiner))
    else
      Result := TCollectionItemClass(cls).Create(nil);
  end
  else
    Result := cls.Create;
end;

procedure Ts0ObjXMLReader.ReadObjects(AObjectsTags: Ts0Tags; 
  AContainer: TObject);
var
  i: Integer;
  t: Ts0Tag;
begin
  for i := 0 to AObjectsTags.Count -1 do
  begin
    t := AObjectsTags[i];
    if IsNamedTag(t, 'objects')then 
      LoadObjects(t.Contents, AContainer);
  end;
end;

end.
