unit s0PropertyAccessor;

interface

uses
  SysUtils, Classes;

type
  Ts0PropertyAccessor = class
  private
  	FTargetProperty: String;
    FTargetItemProperty: String;
  public
  	constructor Create(ATargetProperty, ATargetItemProperty: String); virtual;
  	procedure SetToTarget(AComponent: TComponent; AValue: string);
    function GetFromTarget(AComponent: TComponent): string;
  end;


implementation

uses
	s0StringHelper,
	s0TypInfoWrapper;


{ Ts0PropertyAccessor }

constructor Ts0PropertyAccessor.Create(ATargetProperty,
  ATargetItemProperty: String);
begin
	Self.FTargetProperty := ATargetProperty;
  Self.FTargetItemProperty := ATargetItemProperty;
end;

function Ts0PropertyAccessor.GetFromTarget(AComponent: TComponent): string;
  function GetPropertyAsString(obj: TObject; propertyName: String): string;
  var
    acsr: Ts0RTTIPublishedAccessor;
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(obj);
    try
      Result := acsr.PropAsString[ propertyName ];
    finally
      FreeAndNil(acsr);
    end;
  end;

  function getTargetItemProperties(obj: TObject): String;
  var
  	i: Integer;
    item: TCollectionItem;
  begin
  	if obj is TCollection then
    begin
      Result := '';
    	for i := 0 to TCollection(obj).Count -1 do
      begin
    		item := TCollection(obj).Items[i];
				if i <> 0 then
        	Result := Result + ',';
       	Result := Result + GetPropertyAsString(item, FTargetItemProperty);
      end;
    end
    else
    begin
      Result := GetPropertyAsString(obj, FTargetItemProperty);
    end;
  end;
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  if FTargetItemProperty = '' then
  begin
    Result := GetPropertyAsString(AComponent, FTargetProperty);
  end
  else
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AComponent);
    try
      Result := getTargetItemProperties(acsr.ObjectProp[ FTargetProperty ]);
    finally
      FreeAndNil(acsr);
    end;
  end;
end;

procedure Ts0PropertyAccessor.SetToTarget(AComponent: TComponent;
  AValue: string);
  procedure SetStringProp(AObject: TObject; AProperty: String; AValue: string);
  var
    acsr: Ts0RTTIPublishedAccessor;
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AObject);
    try
			if not acsr.PropertyExists(AProperty) then
      	Exit;
      try
        acsr.PropAsString[ AProperty ] := AValue;
      except
        acsr.ClearValueOf(AProperty)
      end;
    finally
      FreeAndNil(acsr);
    end;
  end;
  procedure setTargetItemProperties(obj: TObject; AValue: String);
  var
  	i: Integer;
    item: TCollectionItem;
    sl: TStrings;
    collection: TCollection;
  begin
  	if obj is TCollection then
    begin
    	sl := TStringList.Create;
      try
        collection := TCollection(obj);
        Ts0StringHelper.SliceString(AValue, sl, ',');
        for i := 0 to sl.Count -1 do
        begin
          if i > collection.Count -1 then
            Exit;
          item := TCollection(obj).Items[i];
          SetStringProp(item, FTargetItemProperty, sl.Strings[i]);
        end;
      finally
      	FreeAndNil(sl);
      end;
    end
    else
    begin
      SetStringProp(obj, FTargetItemProperty, AValue);
    end;
  end;
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  if FTargetItemProperty = '' then
  begin
    SetStringProp(AComponent, FTargetProperty, AValue);
  end
  else
  begin
    acsr := Ts0RTTIPublishedAccessor.Create(AComponent);
    try
      setTargetItemProperties(acsr.ObjectProp[ FTargetProperty ], AValue);
    finally
      FreeAndNil(acsr);
    end;
  end;
end;

end.
