object Form1: TForm1
  Left = 386
  Top = 159
  Width = 317
  Height = 106
  Caption = 'パスワード登録'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ＭＳ Ｐゴシック'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 202
    Height = 12
    Caption = '送付されたパスワードを入力してください'
    FocusControl = Edit1
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 297
    Height = 12
    AutoSize = False
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clMenuText
    Font.Height = -12
    Font.Name = 'ＭＳ Ｐゴシック'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 209
    Height = 20
    TabOrder = 0
  end
  object Button1: TButton
    Left = 224
    Top = 32
    Width = 75
    Height = 21
    Caption = '登録'
    TabOrder = 1
    OnClick = Button1Click
  end
end
