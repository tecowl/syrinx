object frm0ceGrid_Abstract: Ts0ce_frmGrid_Abstract
  Left = 110
  Top = 103
  Width = 540
  Height = 287
  Caption = 'frm0ceGrid_Abstract'
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
  object Panel1: TPanel
    Left = 0
    Top = 235
    Width = 532
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 344
      Top = 0
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 440
      Top = 0
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object pnlChecks: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 235
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
  end
end
