unit s0EntityFormManager;
{
$History: s0EntityFormManager.pas $
 * 
 * *****************  Version 27  *****************
 * User: Akima        Date: 02/03/18   Time: 13:57
 * Updated in $/D5/source/VCL
 * 大バグ、フォームを表示するときにTs0FormRelationのOriginの設定が間違って
 * いた。
 * 
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/03/15   Time: 18:20
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/03/14   Time: 4:23
 * Updated in $/D5/source/VCL
 * s0f0EntityDisplayユニットをusesから削除。代わりに、s0EntityDispImplユニ
 * ットを追加。
 * 
 * *****************  Version 24  *****************
 * User: Akima        Date: 02/03/13   Time: 3:08
 * Updated in $/D5/source/VCL
 * c0FormRelation1 -> s0FormRelation1
 * 
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 20  *****************
 * User: Akima        Date: 02/02/05   Time: 15:10
 * Updated in $/source/D5Integrated
 * Ts0EntityDisplayItem.IsTargetClassメソッドを追加。
 * そこでEntityのクラスのチェックを行うように修正
 * 
 * *****************  Version 19  *****************
 * User: Akima        Date: 02/01/21   Time: 22:43
 * Updated in $/source/D6VCLIntegrated
 * 各Entity用のDMには、Ts0EntityFormManagerを置かないように変更。
 * Ts0EntityFormManagerはコンポーネントとして廃止した。
 * Tc0EntityDispManagerはSingletonへ。
 *
 * *****************  Version 18  *****************
 * User: Akima        Date: 01/10/23   Time: 15:48
 * Updated in $/source/D5Integrated
 * Ts0EntityDisplayItemのShow、ShowModalメソッドに引数AOnShowを追加
 * 
 * *****************  Version 17  *****************
 * User: Akima        Date: 01/10/20   Time: 12:33
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 16  *****************
 * User: Akima        Date: 01/10/17   Time: 23:39
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 01/10/05   Time: 16:55
 * Updated in $/source/D5Integrated
 * s0f1EntityDetailのusesを削除した。
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 01/10/05   Time: 13:04
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 01/10/04   Time: 21:07
 * Updated in $/source/D5Integrated
 *
 * *****************  Version 12  *****************
 * User: Akima        Date: 01/10/04   Time: 12:25
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/09/23   Time: 1:08
 * Updated in $/source/D5Integrated
 * 表示するメソッドの引数にAModeを追加
 *
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/09/13   Time: 23:26
 * Updated in $/source/D5Integrated
 * Ts0CollectionItem.Createの引数をTCollection型に戻して、overrideするよう
 * に変更した。だってだって、それだとIDEからoverrideしているコンストラクタ
 * を呼び出してもらえないんだもん。泣。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/09/11   Time: 0:05
 * Updated in $/source/D5Integrated
 * Ts0CollectionItemのコンストラクタの引数をTCollectionからTs0Collectionに変
 * 更
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/09/03   Time: 4:59
 * Updated in $/source/D5Integrated
 * f0EntityDisplayなどのユニット名がs0f0EntityDisplayというように
 * 名称変更されたのでそれに対応した。
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/08/30   Time: 12:52
 * Updated in $/source/D5/p0entity
 * Entity関係の作成を一時中断。
 * パッケージの再構築時にエラーが出ることが多いので、そっちを先に対応予定
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/08/29   Time: 18:42
 * Updated in $/source/D5/p0entity
 * 汎用フォームが実現できそう。一時チェックイン。
 *
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0entity
 * p0entityひとまずOK。
 * しかし、汎用的なフォームのためにリファクタリングを思案中・・・
 *
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/28   Time: 8:22
 * Updated in $/source/D5/p0entity
 *
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/27   Time: 20:04
 * Updated in $/source/D5/p0entity
}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Contnrs,
  s0VCLClasses,
  s0Observer,
  s0Entity,
  s0Collection,
//  s0f0EntityDisplay,
  s0EntityDispImpl,
  s0EntityListImpl,
  s0EntityDetailImpl;

type
  Ts0DispFormList = class(TObjectList)
  private
  protected
    function GetItems(Index: Integer): TCustomForm;
    procedure SetItems(Index: Integer; AItem: TCustomForm);
  public
    function Add(AItem: TCustomForm): Integer;
    function Remove(AItem: TCustomForm): Integer;
    function IndexOf(AItem: TCustomForm): Integer;
    procedure Insert(Index: Integer; AItem: TCustomForm);
    property Items[Index: Integer]: TCustomForm read GetItems write
      SetItems; default;
    function First: TCustomForm;
    function Last: TCustomForm;
  end;

type
  Ts0EntityDisplayItem = class(Ts0VCLCollectionItem)
  private
    FEnabled: Boolean;
    FFormClass: TCustomFormClass; //Ts0frmEntityDisplayClass;
    FFormClassName: string;
    FFormList: Ts0DispFormList; //Ts0EntityDisplayList;
    FFormCloseListener: Ts0EventListener;
    FFormDestroyListener: Ts0EventListener;
    FFormShowListener: Ts0EventListener;
    FOnFormShowForClient: K0EntityDisplayEvent;
    FEntityClass: Ts0EntityClass;
    function GetFormClass: TCustomFormClass; //Ts0frmEntityDisplayClass;
    procedure SetFormClassName(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    function GetFormList: Ts0DispFormList; //Ts0EntityDisplayList;
    function GetIsAlternative: Boolean;
    procedure SetEntityClass(const Value: Ts0EntityClass);
  protected
    procedure FormClose(Sender: TObject); virtual;
    procedure FormDestroy(Sender: TObject); virtual;
    procedure FormShow(Sender: TObject); virtual;
    function GetCreationMode: K0FormCreationMode; virtual;
    function GetDetailImpl(AForm: TCustomForm): Ts0EntityDetailImpl;
    function GetForm(AEntity: Ts0Entity; AOrigin: TObject): TCustomForm; //Ts0frmEntityDisplay;
    function NewForm(AOnCreate: K0EntityDisplayEvent;
      AEntityClass: Ts0EntityClass = nil): TCustomForm {Ts0frmEntityDisplay}; virtual;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure ClearForms;
    function FindDisplay(AEntity: Ts0Entity; AOrigin: TObject = nil):
      TCustomForm {Ts0frmEntityDisplay}; 
    function IsTargetClass(AEntityClass: Ts0EntityClass; AType: K0DisplayType): Boolean;
    procedure Show(AEntity: Ts0Entity; AOrigin: TObject; AMode: K0DetailDisplayMode;
      AOnCreate: K0EntityDisplayEvent = nil; AOnShow: K0EntityDisplayEvent = nil;
      AEntityClass: Ts0EntityClass = nil); virtual;
    function ShowModal(AEntity: Ts0Entity; AOrigin: TObject; AMode: K0DetailDisplayMode;
      AOnCreate: K0EntityDisplayEvent = nil; AOnShow: K0EntityDisplayEvent = nil;
      AEntityClass: Ts0EntityClass = nil): Integer; virtual;
    property CreationMode: K0FormCreationMode read GetCreationMode;
    property EntityClass: Ts0EntityClass read FEntityClass write SetEntityClass;
    property FormClass: TCustomFormClass {Ts0frmEntityDisplayClass} read GetFormClass;
    property FormList: Ts0DispFormList {Ts0EntityDisplayList} read GetFormList;
    property IsAlternative: Boolean read GetIsAlternative;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property FormClassName: string read FFormClassName write SetFormClassName;
  end;

type
  Ts0EntityDisplayItems = class(Ts0VCLCollection)
  private
    function GetItems(const Index: Integer): Ts0EntityDisplayItem;
    procedure SetItems(const Index: Integer;
      const Value: Ts0EntityDisplayItem);
  protected
    function Add(AFormClass: TCustomFormClass {Ts0frmEntityDisplayClass}; AEntityClass: Ts0EntityClass): Ts0EntityDisplayItem;
    function FindDispItemByForm(AFromClass: TCustomFormClass {Ts0frmEntityDisplayClass}): Ts0EntityDisplayItem;
    function FindItemOfEntity(AEntityClass: Ts0EntityClass; AType: K0DisplayType; AWithAlt: Boolean = True): Ts0EntityDisplayItem;
  public
    property Items[const Index: Integer]: Ts0EntityDisplayItem read GetItems write
    SetItems; default;
  end;

type
  Ts0EntityFormManager = class(Ts0EntityDisplay)
  private
    FItems: Ts0EntityDisplayItems;
    procedure SetItems(const Value: Ts0EntityDisplayItems);
  protected
    function NewItems: Ts0EntityDisplayItems; virtual;
    procedure RaiseShowExeption(AEntity: Ts0Entity);
    function ShowForm(AEntity: Ts0Entity; AOrigin: TObject;
      AType: K0DisplayType; AModal: Boolean; AMode: K0DetailDisplayMode; AEntityClass: Ts0EntityClass): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindDispItem(AEntityClass: Ts0EntityClass; AType: K0DisplayType): Ts0EntityDisplayItem;
    function NeedDispItem(AEntityClass: Ts0EntityClass; AType: K0DisplayType): Ts0EntityDisplayItem;
    procedure ShowDetail(AEntity: Ts0Entity; AOrigin: TObject = nil; AMode: K0DetailDisplayMode = k0ddmReadOnly);
      override;
    function ShowDetailModal(AEntity: Ts0Entity; AOrigin: TObject = nil; AMode: K0DetailDisplayMode = k0ddmReadOnly):
      Integer; override;
    procedure ShowList(AEntityClass: Ts0EntityClass; AOrigin: TObject = nil); override;
    function ShowListModal(AEntityClass: Ts0EntityClass; AOrigin: TObject = nil): Integer; override;
  published
    property Items: Ts0EntityDisplayItems read FItems write SetItems;
  end;

type
  Es0EntityFormManagerException = class(Exception);

implementation

uses
  s0FormRelation;

{ Ts0DispFormList }

function Ts0DispFormList.Add(AItem: TCustomForm): Integer;
begin
  Result := inherited Add(AItem);
end;

function Ts0DispFormList.First: TCustomForm;
begin
  Result := TCustomForm(inherited First);
end;

function Ts0DispFormList.GetItems(Index: Integer): TCustomForm;
begin
  Result := TCustomForm(inherited Items[Index]);
end;

function Ts0DispFormList.IndexOf(AItem: TCustomForm): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure Ts0DispFormList.Insert(Index: Integer; AItem: TCustomForm);
begin
  inherited Insert(Index, AItem);
end;

function Ts0DispFormList.Last: TCustomForm;
begin
  Result := TCustomForm(inherited Last);
end;

function Ts0DispFormList.Remove(AItem: TCustomForm): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure Ts0DispFormList.SetItems(Index: Integer; AItem: TCustomForm);
begin
  inherited Items[Index] := AItem;
end;

{ Ts0EntityDisplayItem }

procedure Ts0EntityDisplayItem.ClearForms;
var
  frm: TCustomForm {Ts0frmEntityDisplay};
begin
  while FormList.Count > 0 do
  begin
    frm := FormList.Last;
    while FormList.Remove(frm) > -1 do ;
    FreeAndNil(frm);
  end;
end;

constructor Ts0EntityDisplayItem.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
  FFormCloseListener := Ts0EventListener.Create(FormClose);
  FFormDestroyListener := Ts0EventListener.Create(FormClose);
  FFormShowListener := Ts0EventListener.Create(FormShow);
end;

destructor Ts0EntityDisplayItem.Destroy;
begin
  ClearForms;
  FreeAndNil(FFormShowListener);
  FreeAndNil(FFormCloseListener);
  FreeAndNil(FFormDestroyListener);
  FreeAndNil(FFormList);
  inherited;
end;

function Ts0EntityDisplayItem.FindDisplay(AEntity: Ts0Entity;
  AOrigin: TObject): TCustomForm {Ts0frmEntityDisplay};
var
  i: Integer;
  detailImpl: Ts0EntityDetailImpl;
  rel: Ts0FormRelation;
begin
  Result := nil;
  if FFormList = nil then Exit;
  if AEntity = nil then Exit;
  for i := 0 to FFormList.Count - 1 do
  begin
    Result := FFormList.Items[i];
    rel := FindRelation(Result);
    if rel = nil then Continue;
    if (AOrigin <> nil) and (rel.Origin <> AOrigin) then Continue;
    detailImpl := GetDetailImpl(Result);
    if (AEntity <> nil) and (detailImpl <> nil) and
       (detailImpl.DispTarget <> AEntity) then Continue;
    Exit;
  end;
  Result := nil;
end;

procedure Ts0EntityDisplayItem.FormClose(Sender: TObject);
begin
end;

procedure Ts0EntityDisplayItem.FormDestroy(Sender: TObject);
begin
  if not (Sender is TCustomForm) then Exit;
  FormList.Remove( TCustomForm(Sender) );
end;

procedure Ts0EntityDisplayItem.FormShow(Sender: TObject);
begin
  if not Assigned(FOnFormShowForClient) then Exit;
  if Sender is TCustomForm then
    FOnFormShowForClient(Self, TCustomForm(Sender))
  else
  if Sender is Ts0FormRelation then
    FOnFormShowForClient(Self, Ts0FormRelation(Sender).OwnerForm)
  else
    FOnFormShowForClient(Self, nil);
end;

function Ts0EntityDisplayItem.GetCreationMode: K0FormCreationMode;
var
  formItem: Ts0EntityFormItem;
begin
  Result := k0fcmOnlyOne;
  if FormClass = nil then Exit;
  formItem := Ts0EntityFormDispRegister.FindDispItemByForm(FFormClass);
  if formItem = nil then Exit;
  Result := formItem.CreationMode;
end;

function Ts0EntityDisplayItem.GetDetailImpl(AForm: TCustomForm): Ts0EntityDetailImpl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AForm.ComponentCount -1 do
    if AForm.Components[i] is Ts0EntityDetailImpl then
    begin
      Result := Ts0EntityDetailImpl(AForm.Components[i]);
      Exit;
    end;
end;

function Ts0EntityDisplayItem.GetForm(AEntity: Ts0Entity; AOrigin:
  TObject): TCustomForm;
begin
  Result := nil;
  if FormList.Count < 1 then
    Exit;
  case CreationMode of
    k0fcmOnlyOne: Result := FormList.First;
    k0fcmByOrigin: Result := FindDisplay(nil, AOrigin);
    k0fcmByEntity: Result := FindDisplay(AEntity, nil);
    k0fcmByEntityAndOrigin: Result := FindDisplay(AEntity, AOrigin);
    k0fcmOnShow: Exit;
  end;
end;

function Ts0EntityDisplayItem.GetFormClass: TCustomFormClass;
begin
  if FFormClass = nil then
    FFormClass := Ts0EntityFormDispRegister.GetFormByName(FFormClassName);
  Result := FFormClass;
end;

function Ts0EntityDisplayItem.GetFormList: Ts0DispFormList;
begin
  if FFormList = nil then
    FFormList := Ts0DispFormList.Create(False);
  Result := FFormList;
end;

function Ts0EntityDisplayItem.GetIsAlternative: Boolean;
var
  formItem: Ts0EntityFormItem;
begin
  Result := False;
  if FormClass = nil then Exit;
  formItem := Ts0EntityFormDispRegister.FindDispItemByForm(FFormClass);
  if formItem = nil then Exit;
  Result := formItem.IsAlt;
end;

function Ts0EntityDisplayItem.IsTargetClass(
  AEntityClass: Ts0EntityClass; AType: K0DisplayType): Boolean;
var
  formItem: Ts0EntityFormItem;
begin
  Result := False;
  if not Enabled then Exit;
  if FormClass = nil then Exit;
  formItem := Ts0EntityFormDispRegister.FindDispItemByForm(FFormClass);
  if formItem = nil then Exit;
  if formItem.FormClass = nil then Exit;
  if formItem.DispType <> AType then Exit;
  Result := AEntityClass.InheritsFrom( formItem.Target );
end;

function Ts0EntityDisplayItem.NewForm(AOnCreate: K0EntityDisplayEvent;
  AEntityClass: Ts0EntityClass): TCustomForm; {Ts0frmEntityDisplay;}
  procedure SetTargetDispEntity(AForm: TCustomForm; AClass: Ts0EntityClass);
  var
    i: Integer;
  begin
    for i := 0 to AForm.ComponentCount -1 do
      if AForm.Components[i] is Ts0EntityDispImpl then
      begin
        Ts0EntityDispImpl(AForm.Components[i]).DispEntityClass := AClass;
        Exit;
      end;
  end;
var
  rel: Ts0FormRelation;
  formItem: Ts0EntityFormItem;
begin
  Result := nil;
  if FormClass = nil then Exit;
  Result := FormClass.Create(nil);
  rel := FindRelation(Result);
  if rel <> nil then
  begin
    rel.OnClose.Attach(FFormCloseListener);
    rel.OnDestroy.Attach(FFormDestroyListener);
    rel.OnShow.Attach(FFormShowListener);
  end;
  //
  formItem := Ts0EntityFormDispRegister.FindDispItemByForm(FFormClass);
  if (formItem <> nil) and formItem.IsAlt then
    SetTargetDispEntity(Result, FEntityClass);
  FormList.Add(Result);
  if Assigned(AOnCreate) then
    AOnCreate(Self, Result);
end;

procedure Ts0EntityDisplayItem.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure Ts0EntityDisplayItem.SetEntityClass(const Value: Ts0EntityClass);
begin
  FEntityClass := Value;
end;

procedure Ts0EntityDisplayItem.SetFormClassName(const Value: string);
begin
  FFormClassName := Value;
end;

procedure Ts0EntityDisplayItem.Show(AEntity: Ts0Entity;
  AOrigin: TObject; AMode: K0DetailDisplayMode;
  AOnCreate: K0EntityDisplayEvent; AOnShow: K0EntityDisplayEvent; AEntityClass: Ts0EntityClass);
var
  disp: TCustomForm;
  detailImpl: Ts0EntityDetailImpl;
  rel: Ts0FormRelation;
begin
  disp := GetForm(AEntity, AOrigin);
  if disp = nil then
  begin
    disp := NewForm(AOnCreate, AEntityClass);
    if AOrigin is TCustomForm then
    begin
      rel := FindRelation(disp);
      if rel <> nil then
        rel.Origin := TCustomForm(AOrigin);
    end;
  end;

  detailImpl := GetDetailImpl(disp);
  if detailImpl <> nil then
  begin
    detailImpl.DispTarget := AEntity;
    detailImpl.EditingMode := AMode;
  end;
  //
  FOnFormShowForClient := AOnShow;
  try
    disp.Show;
  finally
    FOnFormShowForClient := nil;
  end;
end;

function Ts0EntityDisplayItem.ShowModal(AEntity: Ts0Entity; AOrigin: TObject;
  AMode: K0DetailDisplayMode; AOnCreate: K0EntityDisplayEvent;
  AOnShow: K0EntityDisplayEvent; AEntityClass: Ts0EntityClass): Integer;
var
  frm: TCustomForm;
  rel: Ts0FormRelation;
  detailImpl: Ts0EntityDetailImpl;
begin
  frm := NewForm(AOnCreate, AEntityClass);
  try
    if AOrigin is TCustomForm then
    begin
      rel := FindRelation( frm );
      if rel <> nil then
        rel.Origin := TCustomForm(AOrigin);
    end;
    detailImpl := GetDetailImpl(frm);
    if detailImpl <> nil then
    begin
      detailImpl.DispTarget := AEntity;
      detailImpl.EditingMode := AMode;
    end;
    //
    FOnFormShowForClient := AOnShow;
    try
      Result := frm.ShowModal;
    finally
      FOnFormShowForClient := nil;
    end;
    FormList.Remove(frm);
  finally
    FreeAndNil(frm);
  end;
end;

{ Ts0EntityDisplayItems }

function Ts0EntityDisplayItems.Add(AFormClass: TCustomFormClass;
  AEntityClass: Ts0EntityClass): Ts0EntityDisplayItem;
begin
//  Result := FindDispItemByForm(AFormClass);
//  if Result <> nil then Exit;
  Result := Ts0EntityDisplayItem(inherited Add);
  Result.FFormClass := AFormClass;
  Result.FEntityClass := AEntityClass;
  if AFormClass <> nil then
    Result.FormClassName := AFormClass.ClassName;
end;

function Ts0EntityDisplayItems.FindDispItemByForm(
  AFromClass: TCustomFormClass): Ts0EntityDisplayItem;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if Result.FormClass = AFromClass then Exit;
  end;
  Result := nil;
end;

function Ts0EntityDisplayItems.FindItemOfEntity(AEntityClass: Ts0EntityClass;
  AType: K0DisplayType; AWithAlt: Boolean): Ts0EntityDisplayItem;
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
  begin
    Result := Items[i];
    if Result.IsAlternative and (not AWithAlt) then Continue;
    if Result.IsTargetClass(AEntityClass, AType) then Exit;
  end;
  Result := nil;
end;

function Ts0EntityDisplayItems.GetItems(
  const Index: Integer): Ts0EntityDisplayItem;
begin
  Result := Ts0EntityDisplayItem(inherited Items[Index]);
end;

procedure Ts0EntityDisplayItems.SetItems(const Index: Integer;
  const Value: Ts0EntityDisplayItem);
begin
  inherited Items[Index] := Value;
end;

{ Ts0EntityFormManager }

constructor Ts0EntityFormManager.Create(AOwner: TComponent);
begin
  inherited;
  FItems := NewItems;
end;

destructor Ts0EntityFormManager.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function Ts0EntityFormManager.FindDispItem(AEntityClass: Ts0EntityClass; AType: K0DisplayType): Ts0EntityDisplayItem;
begin
  //既に存在するItemを検索
  Result := FItems.FindItemOfEntity(AEntityClass, AType);
end;

resourcestring
  c9ErrMsg_CannotShowForm = '%s: 表示できるフォームがありません';

function Ts0EntityFormManager.NeedDispItem(AEntityClass: Ts0EntityClass;
  AType: K0DisplayType): Ts0EntityDisplayItem;
  function CreateDispItemOf(AEntityClass: Ts0EntityClass; AKind: K0DisplayType): Ts0EntityDisplayItem;
  var
    cl: TClassList;
    i: Integer;
    frmClass: TCustomFormClass;
    formItem: Ts0EntityFormItem;
  begin
    cl := TClassList.Create;
    try
      Ts0EntityFormDispRegister.GetFormsByAEntity(cl, AEntityClass);
      for i := 0 to cl.Count -1 do
      begin
        if not cl.Items[i].InheritsFrom(TCustomForm) then Continue;
        frmClass := TCustomFormClass(cl.Items[i]);
        formItem := Ts0EntityFormDispRegister.FindDispItemByForm(frmClass);
        if formItem = nil then Continue;
        if formItem.DispType <> AKind then Continue;
        if not AEntityClass.InheritsFrom(formItem.Target) then Continue;
        Result := FItems.Add(TCustomFormClass(cl.Items[i]), AEntityClass);
        Exit;
      end;
      Result := nil;
    finally
      FreeAndNil(cl);
    end;
  end;
  function CreateDispAltItem(AEntityClass: Ts0EntityClass; AKind: K0DisplayType): Ts0EntityDisplayItem;
  var
    cl: TClassList;
    i: Integer;
    frmClass: TCustomFormClass;
    formItem: Ts0EntityFormItem;
  begin
    cl := TClassList.Create;
    try
      Ts0EntityFormDispRegister.GetAltForms(cl);
      for i := 0 to cl.Count -1 do
      begin
        if not cl.Items[i].InheritsFrom(TCustomForm) then Continue;
        frmClass := TCustomFormClass(cl.Items[i]);
        formItem := Ts0EntityFormDispRegister.FindDispItemByForm(frmClass);
        if formItem = nil then Continue;
        if formItem.DispType <> AKind then Continue;
        if not formItem.IsAlt then Continue;
        Result := FItems.Add(TCustomFormClass(cl.Items[i]), AEntityClass);
        Exit;
      end;
      Result := nil;
    finally
      FreeAndNil(cl);
    end;
  end;
begin
  //まずは対応するフォームを検索
  Result := Self.FindDispItem(AEntityClass, AType);
  if Result <> nil then Exit;
  //それが見つからなかったら、対応するフォームを検索し、見つかればそのItemを生成
  Result := CreateDispItemOf(AEntityClass, AType);
  if Result <> nil then Exit;
  //それが見つからなかったら、対応できるAlt系フォームを検索し、見つかればそのItemを生成
  Result := CreateDispAltItem(AEntityClass, AType);
end;

function Ts0EntityFormManager.NewItems: Ts0EntityDisplayItems;
begin
  Result := Ts0EntityDisplayItems.Create(Self, Ts0EntityDisplayItem);
end;

procedure Ts0EntityFormManager.RaiseShowExeption(AEntity: Ts0Entity);
var
  targetName: string;
begin
  targetName := '';
  if AEntity <> nil then
    targetName := AEntity.ClassName;
  raise Es0EntityFormManagerException.CreateFmt(
    c9ErrMsg_CannotShowForm, [targetName]);
end;

procedure Ts0EntityFormManager.SetItems(const Value: Ts0EntityDisplayItems);
begin
  FItems.Assign(Value);
end;

procedure Ts0EntityFormManager.ShowDetail(AEntity: Ts0Entity; AOrigin:
  TObject; AMode: K0DetailDisplayMode);
begin
  ShowForm(AEntity, AOrigin, k0dtDetail, False, AMode, AEntity.EntityClass);
end;

function Ts0EntityFormManager.ShowDetailModal(AEntity: Ts0Entity; AOrigin:
  TObject; AMode: K0DetailDisplayMode): Integer;
begin
  Result := ShowForm(AEntity, AOrigin, k0dtDetail, True, AMode, AEntity.EntityClass);
end;

function Ts0EntityFormManager.ShowForm(AEntity: Ts0Entity;
  AOrigin: TObject; AType: K0DisplayType; AModal: Boolean;
  AMode: K0DetailDisplayMode; AEntityClass: Ts0EntityClass): Integer;
var
  item: Ts0EntityDisplayItem;
begin
  Result := mrCancel;
  if AEntityClass = nil then
    if AEntity <> nil then
      AEntityClass := AEntity.EntityClass;
  item := NeedDispItem(AEntityClass, AType);
  if item = nil then Exit;
  if AModal then
    Result := item.ShowModal(AEntity, AOrigin, AMode, nil, nil, AEntityClass)
  else
    item.Show(AEntity, AOrigin, AMode, nil, nil, AEntityClass);
end;

procedure Ts0EntityFormManager.ShowList(AEntityClass: Ts0EntityClass; AOrigin: TObject = nil);
begin
  ShowForm(nil, AOrigin, k0dtList, False, k0ddmEdit, AEntityClass);
end;

function Ts0EntityFormManager.ShowListModal(AEntityClass: Ts0EntityClass; AOrigin: TObject = nil):
  Integer;
begin
  Result := ShowForm(nil, AOrigin, k0dtList, True, k0ddmEdit, AEntityClass);
end;

initialization
{$IFNDEF VER130}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(Ts0EntityDisplayItem, TControl);
  GroupDescendentsWith(Ts0EntityDisplayItems, TControl);
  GroupDescendentsWith(Ts0EntityFormManager, TControl);
{$ENDIF}
  Ts0EntityDisplay.RegisterEntityDisplayClass(Ts0EntityFormManager);

end.

