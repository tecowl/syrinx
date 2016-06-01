object Form1: TForm1
  Left = 264
  Top = 138
  Width = 675
  Height = 313
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object s0Panel1: Ts0Panel
    Left = 16
    Top = 16
    Width = 257
    Height = 57
    TabOrder = 0
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 100
      Height = 25
      Caption = 'beginDragging'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 120
      Top = 8
      Width = 100
      Height = 25
      Caption = 'finishDragging'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        AccessLevel = k0ialForm
        DefaultValue = '281'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '116'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '643'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '925'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end
      item
        TargetComponent = s0Panel1
        TargetIsOwner = False
        TargetProperty = 'Left'
      end
      item
        TargetComponent = s0Panel1
        TargetIsOwner = False
        TargetProperty = 'Top'
      end>
    ApplicationName = 'sampleApp1'
    IniFileName = 'sampleApp1.ini'
    Left = 16
    Top = 8
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 56
    Top = 8
  end
  object s0AppInstance1: Ts0AppInstance
    AppInstName = 'AppIdentifier'
    Left = 144
    Top = 8
  end
  object s0CtrlDragger1: Ts0CtrlDragger
    Items = <
      item
        Control = s0Panel1
        Enabled = True
      end>
    Left = 104
    Top = 8
  end
end
