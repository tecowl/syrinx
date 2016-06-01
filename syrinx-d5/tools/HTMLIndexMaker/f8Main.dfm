object frm8Main: Tfrm8Main
  Left = 1
  Top = 1
  Width = 798
  Height = 598
  Caption = 'HTML Index Maker'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 0
    Top = 177
    Width = 790
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 790
    Height = 177
    Align = alTop
    TabOrder = 0
    object lblMasks1: Ts0Label
      Left = 12
      Top = 50
      Width = 33
      Height = 12
      Caption = 'Masks'
      FocusControl = mmoMasks1
    end
    object lblSearchDir1: Ts0Label
      Left = 4
      Top = 7
      Width = 50
      Height = 12
      Caption = 'SearchDir'
      FocusControl = edtSearchDir1
    end
    object Label1: TLabel
      Left = 280
      Top = 62
      Width = 58
      Height = 12
      Caption = 'base target'
    end
    object Label2: TLabel
      Left = 280
      Top = 84
      Width = 44
      Height = 12
      Caption = 'index dir'
    end
    object mmoMasks1: Ts0Memo
      Left = 10
      Top = 64
      Width = 119
      Height = 95
      Lines.Strings = (
        '*.htm*')
      TabOrder = 0
      AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      InputStyle.Alignment = taLeftJustify
      InputStyle.Font.Charset = SHIFTJIS_CHARSET
      InputStyle.Font.Color = clWindowText
      InputStyle.Font.Height = -12
      InputStyle.Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
      InputStyle.Font.Style = []
      InputStyle.MaxLength = 0
      InputStyle.Modified = False
      InputStyle.ReadOnly = False
      InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      InputStyle.TitleDisplay = lblMasks1
      TitleDisplay = lblMasks1
    end
    object edtSearchDir1: Ts0Edit
      Left = 2
      Top = 19
      Width = 780
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 
        'C:\Documents and Settings\akima\My Documents\My Webs\myweb3\comp' +
        'onents'
      AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      Alignment = taLeftJustify
      NumericOnly = False
      TitleDisplay = lblSearchDir1
      InputStyle.Alignment = taLeftJustify
      InputStyle.Font.Charset = SHIFTJIS_CHARSET
      InputStyle.Font.Color = clWindowText
      InputStyle.Font.Height = -12
      InputStyle.Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
      InputStyle.Font.Style = []
      InputStyle.MaxLength = 0
      InputStyle.Modified = False
      InputStyle.ReadOnly = False
      InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      InputStyle.TitleDisplay = lblSearchDir1
    end
    object chkSubDir1: Ts0CheckBox
      Left = 90
      Top = 3
      Width = 97
      Height = 17
      Caption = 'SubDir'
      TabOrder = 2
    end
    object Memo1: TMemo
      Left = 136
      Top = 64
      Width = 129
      Height = 95
      Lines.Strings = (
        'h?')
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 344
      Top = 56
      Width = 121
      Height = 20
      TabOrder = 4
      Text = 'content'
    end
    object Edit2: TEdit
      Left = 344
      Top = 80
      Width = 449
      Height = 20
      TabOrder = 5
      Text = 
        'C:\Documents and Settings\akima\My Documents\My Webs\myweb3\comp' +
        'onents'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 531
    Width = 790
    Height = 40
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 169
      Height = 25
      Caption = 'search files'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 184
      Top = 8
      Width = 169
      Height = 25
      Caption = 'insert "<a name=>"'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 360
      Top = 8
      Width = 169
      Height = 25
      Caption = 'write index file'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 182
    Width = 790
    Height = 349
    Align = alClient
    ItemHeight = 12
    TabOrder = 2
  end
  object s0FileFinder1: Ts0FileFinder
    Active = False
    Masks.Strings = (
      '*.htm*')
    SearchDir = 
      'C:\Documents and Settings\akima\My Documents\My Webs\myweb3\comp' +
      'onents'
    SubDir = False
    Left = 16
    Top = 136
  end
  object s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl
    Builder.CtrlOwner = Owner
    Builder.CtrlParent = ScrollBox1
    Builder.CtrlPrefixes = <
      item
        PartOfCtrlClassName = 'CheckBox'
        Prefix = 'chk'
      end
      item
        PartOfCtrlClassName = 'DigitEdit'
        Prefix = 'dged'
      end
      item
        PartOfCtrlClassName = 'DateEdit'
        Prefix = 'dted'
      end
      item
        PartOfCtrlClassName = 'Edit'
        Prefix = 'edt'
      end
      item
        PartOfCtrlClassName = 'Memo'
        Prefix = 'mmo'
      end
      item
        PartOfCtrlClassName = 'ComboBox'
        Prefix = 'cmb'
      end
      item
        PartOfCtrlClassName = 'RadioGroup'
        Prefix = 'rgp'
      end
      item
        PartOfCtrlClassName = 'CheckListBox'
        Prefix = 'clb'
      end
      item
        PartOfCtrlClassName = 'Label'
        Prefix = 'lbl'
      end
      item
        PartOfCtrlClassName = 'Button'
        Prefix = 'btn'
      end
      item
        PartOfCtrlClassName = 'ListBox'
        Prefix = 'lst'
      end
      item
        PartOfCtrlClassName = 'Grid'
        Prefix = 'grd'
      end>
    Builder.CtrlOfTypeClassName = 'Ts0COTEtyCtrls'
    DisabledProps.Strings = (
      'Name'
      'Tag')
    ProtoTypes = <
      item
        PropertyName = 'Active'
        TypeName = 'Boolean'
        JPName = 'Active'
        Size = 0
        ImeMode = imDisable
        AutoUpdateKinds = [k0cetOnClick]
        CtrlClassName = 'Ts0CheckBox'
        EnumAsString = False
      end
      item
        PropertyName = 'AttrMask'
        TypeName = 'K0FileAttrSet'
        JPName = 'AttrMask'
        Size = 0
        ImeMode = imDisable
        IsSet = True
        EnumMember.Strings = (
          'k0faReadOnly'
          'k0faHidden'
          'k0faSysFile'
          'k0faVolumeID'
          'k0faDirectory'
          'k0faArchive')
        AutoUpdateKinds = [k0cetOnClick, k0cetOnPressEnter]
        CtrlClassName = 'Ts0CheckListBox'
        EnumAsString = False
      end
      item
        PropertyName = 'Masks'
        TypeName = 'TStrings'
        JPName = 'Masks'
        Size = 0
        ImeMode = imDisable
        AutoUpdateKinds = [k0cetOnChange]
        CtrlClassName = 'Ts0Memo'
        Ctrl = mmoMasks1
        CtrlLabel = lblMasks1
        EnumAsString = False
      end
      item
        PropertyName = 'SearchDir'
        TypeName = 'String'
        JPName = 'SearchDir'
        Size = 0
        ImeMode = imDisable
        AutoUpdateKinds = [k0cetOnChange]
        CtrlClassName = 'Ts0Edit'
        Ctrl = edtSearchDir1
        CtrlLabel = lblSearchDir1
        EnumAsString = False
      end
      item
        PropertyName = 'SubDir'
        TypeName = 'Boolean'
        JPName = 'SubDir'
        Size = 0
        ImeMode = imDisable
        AutoUpdateKinds = [k0cetOnClick]
        CtrlClassName = 'Ts0CheckBox'
        Ctrl = chkSubDir1
        EnumAsString = False
      end
      item
        PropertyName = 'OnFindFile'
        TypeName = 'K0FindFileMatchEvent'
        JPName = 'OnFindFile'
        Size = 0
        ImeMode = imDisable
        EnumAsString = False
      end>
    TargetComponent = s0FileFinder1
    ProtoSourcePropName = 'ProtoTypes'
    Left = 50
    Top = 130
  end
end
