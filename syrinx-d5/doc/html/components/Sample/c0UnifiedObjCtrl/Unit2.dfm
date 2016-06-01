object Form2: TForm2
  Left = 110
  Top = 116
  Width = 735
  Height = 366
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ＭＳ Ｐゴシック'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 72
    Width = 417
    Height = 265
    TabOrder = 0
  end
  object c0Button1: Tc0Button
    Left = 16
    Top = 8
    Width = 200
    Height = 25
    Caption = 'インスタンスの生成'
    TabOrder = 1
    OnClick = c0Button1Click
  end
  object c0Button2: Tc0Button
    Left = 224
    Top = 8
    Width = 200
    Height = 25
    Caption = 'インスタンスの破棄'
    TabOrder = 2
    OnClick = c0Button2Click
  end
  object c0Button3: Tc0Button
    Left = 16
    Top = 40
    Width = 200
    Height = 25
    Caption = 'c0UnifiedObjCtrl1への設定'
    TabOrder = 3
    OnClick = c0Button3Click
  end
  object c0Button4: Tc0Button
    Left = 224
    Top = 40
    Width = 200
    Height = 25
    Caption = 'c0UnifiedObjCtrl1への設定解除'
    TabOrder = 4
    OnClick = c0Button4Click
  end
  object c0Button5: Tc0Button
    Left = 496
    Top = 48
    Width = 153
    Height = 25
    Caption = 'インスタンスの内容を表示'
    TabOrder = 5
    OnClick = c0Button5Click
  end
  object Memo1: TMemo
    Left = 440
    Top = 80
    Width = 281
    Height = 249
    ScrollBars = ssBoth
    TabOrder = 6
  end
  object c0UnifiedObjCtrl1: Tc0UnifiedObjCtrl
    Builder.CtrlOwner = Owner
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
    Builder.CtrlOfTypeClassName = 'T0COTEtyCtrls'
    Builder.CtrlOfType.CtrlClassNameOfEnum = 'Tc0ComboBox'
    Builder.CtrlOfType.CtrlClassNameOfSet = 'Tc0CheckListBox'
    DisabledProps.Strings = (
      'Name'
      'Tag')
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 24
  end
end
