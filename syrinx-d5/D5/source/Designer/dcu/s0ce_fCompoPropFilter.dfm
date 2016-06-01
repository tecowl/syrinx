object s0ce_frmCompoPropFilter: Ts0ce_frmCompoPropFilter
  Left = 198
  Top = 118
  Width = 351
  Height = 239
  Caption = 'frm0ceCompoPropFilter'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 29
    Width = 343
    Height = 183
    Align = alClient
    TabOrder = 0
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 343
    Height = 29
    AutoSize = True
    Bands = <
      item
        Control = Panel1
        ImageIndex = -1
        Width = 339
      end>
    object Panel1: TPanel
      Left = 9
      Top = 0
      Width = 326
      Height = 25
      BevelOuter = bvNone
      TabOrder = 0
      object s0Button1: Ts0Button
        Left = 0
        Top = 0
        Width = 100
        Height = 25
        Action = actRefresh
        TabOrder = 0
        Align = alLeft
      end
      object s0Button2: Ts0Button
        Left = 100
        Top = 0
        Width = 100
        Height = 25
        Action = actSaveValues
        TabOrder = 1
        Align = alLeft
      end
      object s0Button3: Ts0Button
        Left = 251
        Top = 0
        Width = 75
        Height = 25
        Action = actClose
        TabOrder = 2
        Align = alRight
      end
    end
  end
  object ActionList1: TActionList
    Left = 26
    Top = 42
    object actRefresh: TAction
      Caption = 'ï\é¶ÇÃçXêV(&R)'
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actSaveValues: TAction
      Caption = 'ílÇÃï€ë∂(&S)'
      ShortCut = 16467
      OnExecute = actSaveValuesExecute
    end
    object actClose: TAction
      Caption = 'ï¬Ç∂ÇÈ(&X)'
      OnExecute = actCloseExecute
    end
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
    Builder.CtrlOfTypeClassName = 'Ts0COTStdCtrls'
    DisabledProps.Strings = (
      'Name'
      'Tag')
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 18
    Top = 79
  end
end
