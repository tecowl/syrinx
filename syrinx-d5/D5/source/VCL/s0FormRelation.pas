unit s0FormRelation;
{
$History: s0FormRelation.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/18   Time: 13:58
 * Updated in $/D5/source/VCL
 * Origin�Ɏ��g��ێ�����t�H�[����ݒ肷�邱�Ƃ͏o���Ȃ��悤�ɂ����B
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/15   Time: 18:20
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/23   Time: 15:50
 * Updated in $/source/D5Integrated
 * Ts0FormEventPublisher��DoEvent���\�b�h�̈������ύX�ɂȂ�������ɑΉ�
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/29   Time: 17:24
 * Updated in $/source/D5/p0comctrl
 * p0entity�ЂƂ܂�OK�B
 * �������A�ėp�I�ȃt�H�[���̂��߂Ƀ��t�@�N�^�����O���v�Ē��E�E�E
}

interface

uses
  SysUtils, Classes,
  Forms,
  s0FormEventPublisher,
  s0Observer,
  Contnrs;

type
  K0CustomFormEvent = procedure(Sender: TObject; AForm: TCustomForm) of object;

type
  K0RelationType = (k0rtOrigin, k0rtSubForm);
  K0FormRelativeAction = (k0fraNone, k0fraClose, k0fraRelease);

type
  K0FormEventType = (k0fetCreate, k0fetShow, k0fetClose, k0fetDestroy);

type
  K0FormRelationEvents = array[K0RelationType] of array[K0FormEventType] of K0CustomFormEvent;


type
  {
    Ts0FormRelation
    ���@�F
    ��̃t�H�[���N���X�����̃t�H�[���N���X�ƁA�l�X�Ȋ֌W�����ꍇ�ɁA
    �ǂ̃t�H�[���i�C���X�^���X�j���ǂ̃t�H�[���i�C���X�^���X�j��
    �Ăяo���Ă���̂��𖾊m�ɂ������B

    �g�����F
    �Ăяo�����́A�Ăяo�����Ƃ��ɁA�Ăяo�����t�H�[����Add����B
    �Ăяo�����I�������Delete���邢��Remove����B

    OnOriginXXXX  �C�x���g�͌Ăяo�����̃t�H�[���Ɋւ���C�x���g�A
    OnSubFormXXXX �C�x���g�͌Ăяo����̃t�H�[���Ɋւ���C�x���g�ł��B
  }
  Ts0FormRelation = class(Ts0FormEventPublisher)
  private
    FActionOnOriginClose: K0FormRelativeAction;
    FActionOnOriginDestroy: K0FormRelativeAction;
    FEvents: K0FormRelationEvents;
    FFormList: TComponentList;
    FOrigin: TCustomForm;
    function GetSubForms(const Index: Integer): TCustomForm;
    procedure SetOrigin(const Value: TCustomForm);
    function FindRelation(ACompo: TComponent): Ts0FormRelation;
    function GetOwnerForm: TCustomForm;
    function GetEvents(const Index: Integer): K0CustomFormEvent;
    procedure SetEvents(const Index: Integer;
      const Value: K0CustomFormEvent);
    procedure NotifyEventToOrigin(AType: K0FormEventType);
    procedure NotifyEventToSubForms(AType: K0FormEventType);
  protected
    procedure OwnerCreate(Sender: TObject); override;
    procedure OwnerDestroy(Sender: TObject); override;
    procedure OwnerClose(Sender: TObject; var Action: TCloseAction); override;
    procedure OwnerShow(Sender: TObject); override;
    procedure DoRelativeEvent(AType: K0FormEventType; AForm: TCustomForm); virtual;
    procedure ExecRelativeAction(AAction: K0FormRelativeAction);
    procedure RelationOnCreate(Sender: TObject);
    procedure RelationOnShow(Sender: TObject);
    procedure RelationOnClose(Sender: TObject);
    procedure RelationOnDestroy(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Add(AForm: TCustomForm): Integer;
    procedure Clear;
    procedure Delete(const Index: Integer);
    function Remove(AForm: TCustomForm): Integer;
    property OwnerForm: TCustomForm read GetOwnerForm;
    property Origin: TCustomForm read FOrigin write SetOrigin;
    property SubForms[const Index: Integer]: TCustomForm read GetSubForms; default;
  published
    property ActionOnOriginClose: K0FormRelativeAction read FActionOnOriginClose write FActionOnOriginClose default k0fraClose;
    property ActionOnOriginDestroy: K0FormRelativeAction read FActionOnOriginDestroy write FActionOnOriginDestroy default k0fraNone;
  published
    property OnOriginCreate  : K0CustomFormEvent index  0 read GetEvents write SetEvents;
    property OnOriginShow    : K0CustomFormEvent index  1 read GetEvents write SetEvents;
    property OnOriginClose   : K0CustomFormEvent index  2 read GetEvents write SetEvents;
    property OnOriginDestroy : K0CustomFormEvent index  3 read GetEvents write SetEvents;
    property OnSubFormCreate : K0CustomFormEvent index 10 read GetEvents write SetEvents;
    property OnSubFormShow   : K0CustomFormEvent index 11 read GetEvents write SetEvents;
    property OnSubFormClose  : K0CustomFormEvent index 12 read GetEvents write SetEvents;
    property OnSubFormDestroy: K0CustomFormEvent index 13 read GetEvents write SetEvents;
  end;

type
  Es0FormRelation = class(Exception);

implementation

{ Ts0FormRelation }

function Ts0FormRelation.Add(AForm: TCustomForm): Integer;
begin
  if FFormList = nil then
    FFormList := TComponentList.Create(False);
  Result := FFormList.IndexOf(AForm);
  if Result > -1 then Exit;
  Result := FFormList.Add(AForm);
end;

procedure Ts0FormRelation.Clear;
begin
  if FFormList = nil then Exit;
  FFormList.Clear;
end;

constructor Ts0FormRelation.Create(AOwner: TComponent);
begin
  inherited;
  FActionOnOriginClose := k0fraClose;
  FActionOnOriginDestroy := k0fraNone;
end;

procedure Ts0FormRelation.Delete(const Index: Integer);
begin
  if FFormList = nil then Exit;
  FFormList.Delete(Index);
end;

destructor Ts0FormRelation.Destroy;
begin
  FreeAndNil(FFormList);
  inherited;
end;

procedure Ts0FormRelation.DoRelativeEvent(AType: K0FormEventType; AForm: TCustomForm);
begin
  if FOrigin = AForm then
    if Assigned(FEvents[k0rtOrigin][AType]) then
      FEvents[k0rtOrigin][AType](Self, AForm);
  if FFormList <> nil then
  begin
    if FFormList.IndexOf( AForm ) > -1 then
      if Assigned(FEvents[k0rtSubForm][AType]) then
        FEvents[k0rtSubForm][AType](Self, AForm);
  end;
  //
  case AType of
    k0fetCreate : RelationOnCreate(AForm);
    k0fetShow   : RelationOnShow(AForm);
    k0fetClose  : RelationOnClose(AForm);
    k0fetDestroy: RelationOnDestroy(AForm);
  end;
end;

function Ts0FormRelation.FindRelation(ACompo: TComponent): Ts0FormRelation;
var
  i: Integer;
begin
  Result := nil;
  if ACompo = nil then Exit;
  for i := 0 to ACompo.ComponentCount -1 do
    if ACompo.Components[i] is Ts0FormRelation then
    begin
      Result := Ts0FormRelation(ACompo.Components[i]);
      Exit;
    end;
end;

procedure Ts0FormRelation.RelationOnClose(Sender: TObject);
begin
  if FOrigin = Sender then
    ExecRelativeAction(FActionOnOriginClose);
end;

procedure Ts0FormRelation.RelationOnCreate(Sender: TObject);
begin
end;

procedure Ts0FormRelation.RelationOnDestroy(Sender: TObject);
begin
  if FOrigin = Sender then
  begin
    ExecRelativeAction(FActionOnOriginDestroy);
    FOrigin := nil;
  end;
  if Sender is TCustomForm then
    while Self.Remove( TCustomForm(Sender) ) > -1 do
end;

procedure Ts0FormRelation.RelationOnShow(Sender: TObject);
begin
end;

function Ts0FormRelation.GetEvents(const Index: Integer): K0CustomFormEvent;
begin
  Result := nil;
  case Index of
     0: Result := FEvents[k0rtOrigin ][k0fetCreate ];
     1: Result := FEvents[k0rtOrigin ][k0fetShow   ];
     2: Result := FEvents[k0rtOrigin ][k0fetClose  ];
     3: Result := FEvents[k0rtOrigin ][k0fetDestroy];
    10: Result := FEvents[k0rtSubForm][k0fetCreate ];
    11: Result := FEvents[k0rtSubForm][k0fetShow   ];
    12: Result := FEvents[k0rtSubForm][k0fetClose  ];
    13: Result := FEvents[k0rtSubForm][k0fetDestroy];
  end;
end;

function Ts0FormRelation.GetOwnerForm: TCustomForm;
begin
  Result := nil;
  if Self.Owner is TCustomForm then
    Result := TCustomForm(Self.Owner);
end;

function Ts0FormRelation.GetSubForms(const Index: Integer): TCustomForm;
begin
  Result := nil;
  if FFormList = nil then Exit;
  Result := TCustomForm( FFormList.Items[Index] );
end;

function Ts0FormRelation.Remove(AForm: TCustomForm): Integer;
begin
  Result := -1;
  if FFormList = nil then Exit;
  Result := FFormList.Remove(AForm);
end;

procedure Ts0FormRelation.SetEvents(const Index: Integer;
  const Value: K0CustomFormEvent);
begin
  case Index of
     0: FEvents[k0rtOrigin ][k0fetCreate ] := Value;
     1: FEvents[k0rtOrigin ][k0fetShow   ] := Value;
     2: FEvents[k0rtOrigin ][k0fetClose  ] := Value;
     3: FEvents[k0rtOrigin ][k0fetDestroy] := Value;
    10: FEvents[k0rtSubForm][k0fetCreate ] := Value;
    11: FEvents[k0rtSubForm][k0fetShow   ] := Value;
    12: FEvents[k0rtSubForm][k0fetClose  ] := Value;
    13: FEvents[k0rtSubForm][k0fetDestroy] := Value;
  end;
end;

resourcestring
  c9ErrMsg_CannotSetOwnerFormAsOrigin =
    '�I�[�i�[�t�H�[����Origin�Ƃ��ăZ�b�g���邱�Ƃ͂ł��܂���';

procedure Ts0FormRelation.SetOrigin(const Value: TCustomForm);
var
  rl: Ts0FormRelation;
begin
  if FOrigin = Value then Exit;
  if FOrigin = OwnerForm then
    raise Es0FormRelation.Create(c9ErrMsg_CannotSetOwnerFormAsOrigin);
  //
  if FOrigin <> nil then
  begin
    rl := FindRelation(FOrigin);
    if rl <> nil then
      rl.Remove(OwnerForm);
  end;
  FOrigin := Value;
  if FOrigin <> nil then
  begin
    rl := FindRelation(FOrigin);
    if (rl <> nil) and (rl <> Self) then
      rl.Add(OwnerForm);
  end;
end;

procedure Ts0FormRelation.ExecRelativeAction(
  AAction: K0FormRelativeAction);
begin
  case AAction of
    k0fraNone    : ;
    k0fraClose   : OwnerForm.Close;
    k0fraRelease : OwnerForm.Release;
  end;
end;

procedure Ts0FormRelation.NotifyEventToOrigin(AType: K0FormEventType);
var
  frl: Ts0FormRelation;
begin
  frl := FindRelation(FOrigin);
  if (frl <> nil) and (frl <> Self) then
    frl.DoRelativeEvent(AType, OwnerForm);
end;

procedure Ts0FormRelation.NotifyEventToSubForms(AType: K0FormEventType);
var
  frl: Ts0FormRelation;
  i: Integer;
begin
  if FFormList = nil then Exit;
  for i := 0 to FFormList.Count -1 do
  begin
    frl := FindRelation(FFormList.Items[i]);
    if frl = nil then Continue;
    frl.DoRelativeEvent(AType, OwnerForm);
  end;
end;

procedure Ts0FormRelation.OwnerClose(Sender: TObject;
  var Action: TCloseAction);
begin
  NotifyEventToOrigin(k0fetClose);
  NotifyEventToSubForms(k0fetClose);
  inherited;
end;

procedure Ts0FormRelation.OwnerCreate(Sender: TObject);
begin
  NotifyEventToOrigin(k0fetCreate);
  NotifyEventToSubForms(k0fetCreate);
  inherited;
end;

procedure Ts0FormRelation.OwnerDestroy(Sender: TObject);
begin
  NotifyEventToOrigin(k0fetDestroy);
  NotifyEventToSubForms(k0fetDestroy);
  inherited;
end;

procedure Ts0FormRelation.OwnerShow(Sender: TObject);
begin
  NotifyEventToOrigin(k0fetShow);
  NotifyEventToSubForms(k0fetShow);
  inherited;
end;

end.
