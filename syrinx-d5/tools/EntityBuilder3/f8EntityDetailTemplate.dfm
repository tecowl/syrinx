inherited frm8EntityDetailTemplate: Tfrm8EntityDetailTemplate
  Height = 170
  Caption = 'frm8EntityDetailTemplate'
  Menu = MainMenu1
  PixelsPerInch = 96
  TextHeight = 12
  inherited StatusBar1: TStatusBar
    Top = 105
  end
  object ScrollBox1: TScrollBox [1]
    Left = 0
    Top = 0
    Width = 317
    Height = 105
    Align = alClient
    TabOrder = 1
  end
  inherited impDetail: Ts0EntityDetailImpl
    OnDetailLoad = impDetailDetailLoad
    OnDetailSave = impDetailDetailSave
    OnSetTarget = impDetailSetTarget
  end
  object MainMenu1: TMainMenu
    Left = 146
    Top = 10
    object File1: TMenuItem
      Caption = 'ファイル(&F)'
      object New1: TMenuItem
        Action = actNewEntity
      end
      object Save1: TMenuItem
        Action = actSaveEntity
      end
      object Delete1: TMenuItem
        Action = actRemoveEntity
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object Show1: TMenuItem
      Caption = '表示(&V)'
      object ShowNavigators1: TMenuItem
        Action = actShowNaviList
      end
      object R1: TMenuItem
        Action = actReadOnly
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Delete2: TMenuItem
        Action = actRefresh
      end
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
    Builder.CtrlOfTypeClassName = 'Ts0COTEtyCtrls'
    DisabledProps.Strings = (
      'Name'
      'Tag')
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 16
    Top = 48
  end
end
