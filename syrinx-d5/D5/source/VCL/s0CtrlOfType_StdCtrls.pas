{-----------------------------------------------------------------------------
 Unit Name: s0CtrlOfType_StdCtrls
 Author:    akima
 Purpose:
 See: Qs0CtrlOfType_StdCtrls
 $History: s0CtrlOfType_StdCtrls.pas $
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 02/03/11   Time: 20:27
 * Updated in $/D6/source/VCL
 * Ts0LabelÇìoò^Ç∑ÇÈÇÊÇ§Ç…ïœçX
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/10   Time: 2:08
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * ê⁄ì™é´ÇïœçXÅBxxSXÅ`Ç…ÇµÇΩÅB
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/21   Time: 23:27
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/13   Time: 21:10
 * Updated in $/source/D5Integrated
 * GetCtrlClassNameByProtoÇí«â¡ÅB
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/10   Time: 16:54
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/01/10   Time: 3:18
 * Updated in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0CtrlOfType_StdCtrls;

interface

uses
  SysUtils, Classes, Controls,
  s0TypInfoWrapper,
  s0PropertyProtoType,
  s0CtrlOfType;

type
  Ts0COTItemStdCtrls = class(Ts0CtrlOfTypeItem)
  public
    procedure InitCtrlByProto(AProto: Ts0PropertyProtoType; AControl: TControl); override;
  end;

type
  Ts0COTItemComboBox = class(Ts0COTItemStdCtrls)
  public
    constructor Create(ACollection: TCollection); override;
    procedure InitCtrlByProto(AProto: Ts0PropertyProtoType; AControl: TControl); override;
  end;

type
  Ts0COTItemCheckListBox = class(Ts0COTItemStdCtrls)
  public
    constructor Create(ACollection: TCollection); override;
    procedure InitCtrlByProto(AProto: Ts0PropertyProtoType; AControl: TControl); override;
  end;

type
  Ts0COTStdCtrls = class(Ts0CtrlOfType)
  protected
    procedure DoInitItems; override;
    function DataTypeKindToCtrlClassName(ADataTypeKind: K0WrappedTypeKind): string; override;
  public
    constructor Create(AOwner: TPersistent); override;
    function GetCtrlClassNameByProto(AProto: Ts0PropertyProtoType): string; override;
  end;

implementation

uses
  TypInfo,
  s0ObjCtrlBuilder,
  //
  StdCtrls,
  s0Label, //don't remove
  s0CheckBox,
  s0ComboBox,
  s0Edit,
  s0DateEdit,
  s0DigitEdit,
  s0Memo,
  //
  s0CheckListBox;

{ Ts0COTItemStdCtrls }

procedure Ts0COTItemStdCtrls.InitCtrlByProto(AProto: Ts0PropertyProtoType;
  AControl: TControl);
begin
  inherited InitCtrlByProto(AProto, AControl);
end;

{ Ts0COTItemComboBox }

constructor Ts0COTItemComboBox.Create(ACollection: TCollection);
begin
  inherited;
  CtrlClassName := Ts0ComboBox.ClassName;
end;

procedure Ts0COTItemComboBox.InitCtrlByProto(AProto: Ts0PropertyProtoType;
  AControl: TControl);
begin
  inherited InitCtrlByProto(AProto, AControl);
  if AControl is Ts0ComboBox then
  begin
    Ts0ComboBox(AControl).Style := csDropDownList;
  end;
end;

{ Ts0COTItemCheckListBox }

constructor Ts0COTItemCheckListBox.Create(ACollection: TCollection);
begin
  inherited;
  CtrlClassName := Ts0CheckListBox.ClassName;
end;

procedure Ts0COTItemCheckListBox.InitCtrlByProto(AProto: Ts0PropertyProtoType;
  AControl: TControl);
var
  i: Integer;
  n, v: string;
  clb: Ts0CheckListBox;
  sl: TStringList;
begin
  inherited;
  Exit;
  //
  if not(AControl is Ts0CheckListBox) then Exit;
  clb := Ts0CheckListBox(AControl);
  if AProto.RTTIProp = nil then Exit;
  case AProto.RTTIProp.TypeInfo.TypeKind of
    tkSet:
      begin
        sl := TStringList.Create;
        try
          sl.CommaText := AProto.RTTIProp.TypeInfo.GetNameList;
          clb.Items.Assign(sl);
          clb.ItemAlias.Clear;
          for i := 0 to AProto.EnumMember.Count -1 do
          begin
            n := AProto.EnumMember.Names[i];
            v := AProto.EnumMember.Values[ n ];
            clb.ItemAlias.Values[ v ]:= n;
          end;
        finally
          FreeAndNil(sl);
        end;
      end;
  end;
end;

{ Ts0COTStdCtrls }

constructor Ts0COTStdCtrls.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FAllowAddItem := False;
end;

function Ts0COTStdCtrls.DataTypeKindToCtrlClassName(
  ADataTypeKind: K0WrappedTypeKind): string;
begin
  Result := '';
  case ADataTypeKind of
    wtk0Unknown    : ;
    wtk0Integer    : Result := Ts0DigitEdit.ClassName;
    wtk0Char       : Result := Ts0DigitEdit.ClassName;
    wtk0Enumeration: Result := CtrlClassNameOfEnum;
    wtk0Boolean    : Result := Ts0CheckBox.ClassName;
    wtk0Float      : Result := Ts0DigitEdit.ClassName;
    wtk0String     : Result := Ts0Edit.ClassName;
    wtk0Set        : Result := CtrlClassNameOfSet;
    wtk0Class      : ;
    wtk0Persistent : ;
    wtk0Strings    : Result := Ts0Memo.ClassName;
  end;
end;

procedure Ts0COTStdCtrls.DoInitItems;
begin
  RegisterClass(Ts0CheckBox);
  RegisterClass(Ts0DateEdit);
  RegisterClass(Ts0DigitEdit);
  RegisterClass(Ts0Edit);
  RegisterClass(Ts0Memo);
  RegisterClass(Ts0ComboBox);
  RegisterClass(Ts0CheckListBox);
  Ts0COTItemStdCtrls.CreateItem(Items, 'Ts0CheckBox' , ['Boolean']    , False);
  Ts0COTItemStdCtrls.CreateItem(Items, 'Ts0DateEdit' , ['TDate', 'TTime', 'TDateTime'], False);
  Ts0COTItemStdCtrls.CreateItem(Items, 'Ts0DigitEdit', ['Char', 'Integer', 'Word', 'Currency', 'Single', 'Double', 'Extended']  , False);
  Ts0COTItemStdCtrls.CreateItem(Items, 'Ts0Edit'     , ['String' ]    , False);
  Ts0COTItemStdCtrls.CreateItem(Items, 'Ts0Memo'     , ['TStrings', 'TStringList'], True );
  Ts0COTItemComboBox.Create(Items);
  Ts0COTItemCheckListBox.Create(Items);
  CtrlClassNameOfEnum := 'Ts0ComboBox';
  CtrlClassNameOfSet := 'Ts0CheckListBox';
end;

var
  g9COTBuf: Ts0CtrlOfTypeClass = nil;

function Ts0COTStdCtrls.GetCtrlClassNameByProto(
  AProto: Ts0PropertyProtoType): string;
begin
  if Trim(AProto.EnumName) <> '' then
    Result := Ts0ComboBox.ClassName
  else
  if AProto.IsEnum then
    Result := Ts0ComboBox.ClassName
  else
    Result := inherited GetCtrlClassNameByProto(AProto);
end;

initialization
  RegisterClass(Ts0COTStdCtrls);
  g9COTBuf := Ts0CtrlOfType.GetDefaultClass;
  Ts0CtrlOfType.RegisterCOT(Ts0COTStdCtrls);
  Ts0CtrlOfType.SetDefaultClass(Ts0COTStdCtrls);
  RegisterClass(Ts0Label);

finalization
  UnRegisterClass(Ts0Label);
  Ts0CtrlOfType.SetDefaultClass(g9COTBuf);
  Ts0CtrlOfType.UnRegisterCOT(Ts0COTStdCtrls);
  UnRegisterClass(Ts0COTStdCtrls);

end.
