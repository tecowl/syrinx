unit s0GridCtrlOfType_Default;

interface

uses
  SysUtils, Classes, Controls,
  s0CtrlOfType,
  s0TypInfoWrapper,
  s0ObjectGrid;

type
  Ts0GridCOTItemStdCtrls = class(Ts0CtrlOfTypeItem)
  public
    procedure InitCtrl(AProp: Ts0RTTIProp; AControl: TControl); override;
  end;

type
  Ts0GridCOTItemComboBox = class(Ts0GridCOTItemStdCtrls)
  public
    constructor Create(ACollection: TCollection); override;
    procedure InitCtrl(AProp: Ts0RTTIProp; AControl: TControl); override;
  end;

type
  Ts0GridCOTItemCheckListBox = class(Ts0GridCOTItemStdCtrls)
  public
    constructor Create(ACollection: TCollection); override;
    procedure InitCtrl(AProp: Ts0RTTIProp; AControl: TControl); override;
  end;

type
  Ts0DefaultGridCtrlOfType = class(Ts0GridCtrlOfType)
  protected
    procedure DoInitItems; override;
    function DataTypeKindToCtrlClassName(ADataTypeKind: K0WrappedTypeKind): string; override;
  public
    constructor Create(AOwner: TPersistent); override;
  end;

implementation

uses
  Forms,
  StdCtrls,
  s0Edit,
  s0Memo,
  s0ComboBox,
  s0CheckListBox,
  s0GridCellCheck,
  s0DigitEdit;

{ Ts0GridCOTItemStdCtrls }

procedure Ts0GridCOTItemStdCtrls.InitCtrl(AProp: Ts0RTTIProp;
  AControl: TControl);
var
  acsr: Ts0RTTIPublishedAccessor;
begin
  inherited InitCtrl(AProp, AControl);
  acsr := Ts0RTTIPublishedAccessor.Create(AControl);
  try
    if not acsr.PropertyExists('BorderStyle') then Exit;
    acsr.OrdProp['BorderStyle'] := Ord(bsNone);
  finally
    FreeAndNil(acsr);
  end;
end;

{ Ts0GridCOTItemComboBox }

constructor Ts0GridCOTItemComboBox.Create(ACollection: TCollection);
begin
  inherited;
  CtrlClassName := Ts0ComboBox.ClassName;
end;

procedure Ts0GridCOTItemComboBox.InitCtrl(AProp: Ts0RTTIProp;
  AControl: TControl);
begin
  inherited InitCtrl(AProp, AControl);
  if AControl is Ts0ComboBox then
    Ts0ComboBox(AControl).Style := csDropDownList;
end;

{ Ts0GridCOTItemCheckListBox }

constructor Ts0GridCOTItemCheckListBox.Create(ACollection: TCollection);
begin
  inherited;
  CtrlClassName := Ts0CheckListBox.ClassName;
end;

procedure Ts0GridCOTItemCheckListBox.InitCtrl(AProp: Ts0RTTIProp;
  AControl: TControl);
begin
  inherited;

end;

{ Ts0DefaultGridCtrlOfType }

constructor Ts0DefaultGridCtrlOfType.Create(AOwner: TPersistent);
begin
  inherited;
  FAllowAddItem := False;
end;

function Ts0DefaultGridCtrlOfType.DataTypeKindToCtrlClassName(
  ADataTypeKind: K0WrappedTypeKind): string;
begin
  Result := '';
  case ADataTypeKind of
    wtk0Unknown    : ;
    wtk0Integer    : Result := Ts0DigitEdit.ClassName;
    wtk0Char       : Result := Ts0DigitEdit.ClassName;
    wtk0Enumeration: Result := CtrlClassNameOfEnum;
    wtk0Boolean    : Result := Ts0GridCellCheck.ClassName;
    wtk0Float      : Result := Ts0DigitEdit.ClassName;
    wtk0String     : Result := Ts0Edit.ClassName;
    wtk0Set        : Result := CtrlClassNameOfSet;
    wtk0Class      : ;
    wtk0Persistent : ;
    wtk0Strings    : Result := Ts0Memo.ClassName;
  end;
end;

procedure Ts0DefaultGridCtrlOfType.DoInitItems;
begin
  RegisterClass(Ts0GridCellCheck);
  RegisterClass(Ts0DigitEdit);
  RegisterClass(Ts0Edit);
  RegisterClass(Ts0Memo);
  RegisterClass(Ts0ComboBox);
  RegisterClass(Ts0CheckListBox);
  Ts0GridCOTItemStdCtrls.CreateItem(Items, 'Ts0GridCellCheck' , ['Boolean']    , False);
  Ts0GridCOTItemStdCtrls.CreateItem(Items, 'Ts0DigitEdit', ['Char', 'Integer', 'Word', 'Currency', 'Single', 'Double', 'Extended']  , False);
  Ts0GridCOTItemStdCtrls.CreateItem(Items, 'Ts0Edit'     , ['String' ]    , False);
  Ts0GridCOTItemStdCtrls.CreateItem(Items, 'Ts0Memo'     , ['TStrings', 'TStringList'], True );
  Ts0GridCOTItemComboBox.Create(Items);
  Ts0GridCOTItemCheckListBox.Create(Items);
  CtrlClassNameOfEnum := 'Ts0ComboBox';
  CtrlClassNameOfSet := 'Ts0CheckListBox';
end;

initialization
  Ts0GridCtrlOfType.RegisterGridCOT(Ts0DefaultGridCtrlOfType);

finalization
  Ts0GridCtrlOfType.UnRegisterGridCOT(Ts0DefaultGridCtrlOfType);

end.
