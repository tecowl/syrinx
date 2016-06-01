object Form1: TForm1
  Left = 264
  Top = 104
  Width = 292
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Edit1: TEdit
    Left = 16
    Top = 16
    Width = 121
    Height = 20
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 16
    Top = 72
    Width = 121
    Height = 20
    TabOrder = 1
    Text = 'Edit2'
  end
  object c0FormEventPublisher1: Tc0FormEventPublisher
    Left = 64
    Top = 40
  end
  object c0IniPropStocker1: Tc0IniPropStocker
    Items = <
      item
        DefaultValue = '9999'
        TargetComponent = Edit1
        TargetIsOwner = False
        TargetProperty = 'Text'
      end
      item
        DefaultValue = '264'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        DefaultValue = '104'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        DefaultValue = '114'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        DefaultValue = '166'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end
      item
        TargetIsOwner = False
        TargetProperty = 'LastTime'
        OnLoad = c0IniPropStocker1Items5GetValueToSave
        OnSave = c0IniPropStocker1Items5SetValueToLoad
        OnGetValueToSave = c0IniPropStocker1Items5GetValueToSave
        OnSetValueToLoad = c0IniPropStocker1Items5SetValueToLoad
      end>
    SystemName = 'TestSystem'
    ApplicationName = 'TestApp'
    IniFileName = 'test.ini'
    Left = 32
    Top = 40
  end
end
