inherited frm0AltEntityDetail: Ts0frmAltEntityDetail
  Left = 30
  Top = -10
  Width = 363
  Height = 364
  Caption = ''
  Menu = MainMenu1
  PixelsPerInch = 96
  TextHeight = 12
  object pnlCtrls: TScrollBox [0]
    Left = 0
    Top = 0
    Width = 355
    Height = 299
    Align = alClient
    TabOrder = 0
  end
  inherited StatusBar1: TStatusBar
    Top = 299
    Width = 355
  end
  inherited s0FormRelation1: Ts0FormRelation
    Left = 8
    Top = 40
  end
  inherited impDetail: Ts0EntityDetailImpl
    OnDetailLoad = impDetailDetailLoad
    OnDetailSave = impDetailDetailSave
    OnSetTarget = impDetailSetTarget
    Left = 56
    Top = 40
  end
  inherited ActionList1: TActionList
    Left = 104
    Top = 40
  end
  object s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl
    Builder.CtrlOwner = Owner
    Builder.CtrlParent = pnlCtrls
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
    Left = 8
    Top = 80
  end
  object MainMenu1: TMainMenu
    Left = 130
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
        Caption = '最新に更新(&R)'
      end
    end
  end
end
