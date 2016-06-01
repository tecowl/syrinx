object Form5: TForm5
  Left = 265
  Top = 206
  Width = 463
  Height = 82
  Caption = 'Form5'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 236
    Height = 12
    Caption = 'S/Nê∂ê¨å≥(MACÉAÉhÉåÉX xx-xx-xx-xx-xx-xx)'
  end
  object Label2: TLabel
    Left = 168
    Top = 32
    Width = 77
    Height = 12
    Caption = 'ê∂ê¨Ç≥ÇÍÇΩS/N'
  end
  object Edit1: TEdit
    Left = 256
    Top = 4
    Width = 193
    Height = 20
    TabOrder = 0
  end
  object Button1: TButton
    Left = 88
    Top = 24
    Width = 75
    Height = 25
    Caption = 'ê∂ê¨'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 256
    Top = 28
    Width = 193
    Height = 20
    TabOrder = 2
  end
  object JvXORCipher1: TJvXORCipher
    Key = '62pikaichi6010'
    Left = 48
    Top = 24
  end
end
