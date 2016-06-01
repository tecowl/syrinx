object s0frmCustomWizard: Ts0frmCustomWizard
  Left = 194
  Top = 116
  Width = 516
  Height = 330
  Caption = 'frm0CustomWizard'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 255
    Width = 508
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object lblPagePosition: TLabel
      Left = 8
      Top = 13
      Width = 145
      Height = 15
      AutoSize = False
      Caption = 'lblPagePosition'
    end
    object btnBack: TButton
      Left = 238
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '–ß‚é(&B)'
      TabOrder = 0
      OnClick = btnBackClick
    end
    object btnNext: TButton
      Left = 318
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'ŽŸ‚Ö(&N)'
      Default = True
      TabOrder = 1
      OnClick = btnNextClick
    end
    object btnCancel: TButton
      Left = 422
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'ƒLƒƒƒ“ƒZƒ‹'
      TabOrder = 2
    end
    object btnFinished: TButton
      Left = 320
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Š®—¹(&F)'
      TabOrder = 3
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 80
    Top = 8
  end
end
