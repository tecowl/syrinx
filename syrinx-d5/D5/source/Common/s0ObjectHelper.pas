unit s0ObjectHelper;
{
$History: s0ObjectHelper.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/01   Time: 9:17
 * Updated in $/source/D5Integrated
 * GetObjectCaptionWithClassでnilに対しては、クラス名を含まないようにした
 * 。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/09/28   Time: 15:58
 * Updated in $/source/D5Integrated
 * GetObjectCaptionメソッドで、Ts0CollectionItemの名前についてはFullNameで
 * はなく、Identifierを使用するようにした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/20   Time: 18:36
 * Updated in $/source/D5Integrated
 * GetObjectCaptionメソッドでTs0CollectionItemを考慮するように変更
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/10   Time: 19:46
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/10   Time: 18:22
 * Updated in $/source/D5Integrated
 * GetObjectCaptionの実装の変更
 * TPersistentならGetNamePathが使えるんだよね。
 * 
 * *****************  Version 3  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes;

type
  Ts0ObjectHelper = class
  public
    class function GetObjectCaption(AObj: TObject): string;
    class function GetObjectCaptionWithClass(AObj: TObject): string;
    class procedure GetComponentData(ACompo: TComponent; Dest: TStream);
    class function StateToStr(AState: TComponentState): string;
    class function ItemByDisplayName(ACollection: TCollection; ADisplayName: string): TCollectionItem;
    class function ItemByNamePath(ACollection: TCollection; ANamePath: string): TCollectionItem;
    class function ComponentByName(AOwner: TComponent; AName: string): TComponent;
    class function ClassInheritesFrom(ASubClass: TClass; ASuperClassName: string): Boolean;
    class function ClassInherites(ASuperClass: TClass; ASubClassName: string): Boolean;
    class function ClassInheritesByStr(ASuperClassName, ASubClassName: string): Boolean;
  end;

implementation

uses
  s0Collection,
  s0StringHelper;

{ Ts0ObjectHelper }

class function Ts0ObjectHelper.StateToStr(AState: TComponentState): string;
const
  c9StateArray: array[csLoading..csDesignInstance] of string = (
    'csLoading',
    'csReading',
    'csWriting',
    'csDestroying',
    'csDesigning',
    'csAncestor',
    'csUpdating',
    'csFixups',
    'csFreeNotification',
    'csInline',
    'csDesignInstance'
  );
var
  i: csLoading..csDesignInstance;
begin
  for i := csLoading to csDesignInstance do
    if i in AState then
      Ts0StringHelper.AddStrWithDelim(Result, c9StateArray[i]);
end;

class procedure Ts0ObjectHelper.GetComponentData(ACompo: TComponent; Dest: TStream);
var
  ms: TMemoryStream;
  p: Integer;
begin
  if ACompo = nil then Exit;
  if Dest = nil then Exit;
  ms := TMemoryStream.Create;
  try
    p := Dest.Position;
    ms.WriteComponent(ACompo);
    ms.Seek(0, soFromBeginning);
    ObjectBinaryToText(ms, Dest);
    Dest.Position := p;
  finally
    FreeAndNil(ms);
  end;
end;

class function Ts0ObjectHelper.GetObjectCaption(AObj: TObject): string;
begin
  Result := 'unknown';
  if AObj = nil then
    Result := '(nil)'
  else
  if AObj is TComponent then
    Result := TComponent(AObj).Name
  else
  if AObj is Ts0CollectionItem then
    Result := Ts0CollectionItem(AObj).Identifier
  else
  if AObj is TPersistent then
    Result := TPersistent(AObj).GetNamePath;
end;

class function Ts0ObjectHelper.GetObjectCaptionWithClass(AObj: TObject): string;
var
  clsName: string;
begin
  Result := GetObjectCaption(AObj);
  if AObj = nil then
    clsName :=  ''
  else
    clsName := '('+ AObj.ClassName +')';
  Result := Format('%s %s', [Result, clsName]);
end;


class function Ts0ObjectHelper.ItemByDisplayName(ACollection: TCollection; ADisplayName: string): TCollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ACollection.Count -1 do
    if ACollection.Items[i].DisplayName = ADisplayName then
    begin
      Result := ACollection.Items[i];
      Exit;
    end;
end;

class function Ts0ObjectHelper.ItemByNamePath(ACollection: TCollection;
  ANamePath: string): TCollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ACollection.Count -1 do
    if ACollection.Items[i].GetNamePath = ANamePath then
    begin
      Result := ACollection.Items[i];
      Exit;
    end;
end;

class function Ts0ObjectHelper.ComponentByName(AOwner: TComponent; AName: string): TComponent;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AOwner.ComponentCount -1 do
    if AOwner.Components[i].Name = AName then
    begin
      Result := AOwner.Components[i];
      Exit;
    end;   
end;

class function Ts0ObjectHelper.ClassInheritesFrom(ASubClass: TClass;
  ASuperClassName: string): Boolean;
var
  cls: TClass;
begin
  Result := False;
  if ASubClass = nil then Exit;
  cls := GetClass(ASuperClassName);
  if cls = nil then Exit;
  Result := ASubClass.InheritsFrom(cls);
end;

class function Ts0ObjectHelper.ClassInherites(
  ASuperClass: TClass; ASubClassName: string): Boolean;
var
  cls: TClass;
begin
  Result := False;
  if ASuperClass = nil then Exit;
  cls := GetClass(ASubClassName);
  if cls = nil then Exit;
  Result := cls.InheritsFrom(ASuperClass);  
end;

class function Ts0ObjectHelper.ClassInheritesByStr(ASuperClassName,
  ASubClassName: string): Boolean;
var
  cls: TClass;
begin
  cls := GetClass(ASubClassName);
  Result := ClassInheritesFrom(cls, ASuperClassName);
end;

end.
