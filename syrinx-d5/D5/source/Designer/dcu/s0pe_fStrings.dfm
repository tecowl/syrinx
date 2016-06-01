object frm0peStrings: Ts0pe_frmStrings
  Left = 273
  Top = 108
  Width = 494
  Height = 362
  Caption = 'Strings Editor'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 486
    Height = 294
    ActivePage = tshPlianText
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object tshPlianText: TTabSheet
      Caption = 'Plian Text'
      object dspPlianText: TMemo
        Left = 0
        Top = 0
        Width = 478
        Height = 267
        Align = alClient
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tshObjects: TTabSheet
      Caption = 'Objects As Integer'
      ImageIndex = 1
      object grdObjectsAsInt: TStringGrid
        Left = 0
        Top = 0
        Width = 478
        Height = 267
        Align = alClient
        ColCount = 2
        DefaultRowHeight = 16
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goAlwaysShowEditor]
        TabOrder = 0
        OnSelectCell = grdObjectsAsIntSelectCell
        ColWidths = (
          218
          142)
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 294
    Width = 486
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 296
      Top = 8
      Width = 85
      Height = 25
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 392
      Top = 8
      Width = 85
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
