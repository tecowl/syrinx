object frm0MemoDlg: Ts0frmMemoDlg
  Left = 192
  Top = 107
  Width = 274
  Height = 185
  Caption = 'frm0MemoDlg'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object dspText: TMemo
    Left = 0
    Top = 0
    Width = 266
    Height = 134
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 134
    Width = 266
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 95
      Top = 0
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
