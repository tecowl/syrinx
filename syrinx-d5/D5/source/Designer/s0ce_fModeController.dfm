object s0ce_frmModeController: Ts0ce_frmModeController
  Left = 323
  Top = 119
  Width = 534
  Height = 211
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object s0ControlImage1: Ts0ControlImage
    Left = 0
    Top = 0
    Width = 145
    Height = 155
    Align = alLeft
    MarkerName = 'Ts0CIVMarker'
  end
  object s0Splitter1: Ts0Splitter
    Left = 145
    Top = 0
    Width = 3
    Height = 155
    Cursor = crHSplit
  end
  object grdCtrlItems: Ts0CtrlGrid
    Left = 148
    Top = 0
    Width = 378
    Height = 155
    CellDrawer.Font.Charset = SHIFTJIS_CHARSET
    CellDrawer.Font.Color = clWindowText
    CellDrawer.Font.Height = -12
    CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
    CellDrawer.Font.Style = []
    FixedRows = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    Align = alClient
    TabOrder = 0
    OnSelectCell = grdCtrlItemsSelectCell
    BindSeals = <>
    Columns = <>
    ReadOnlySeals = <>
    CtrlDecos = <
      item
        Top = 0
        Left = 0
        Right = 0
        Bottom = 0
        Control = s0GridCellCheck1
        UpdateEventKinds = [k0cetOnClick]
      end>
    ColWidths = (
      124
      64
      64
      64
      64)
    RowHeights = (
      16
      16
      16
      16
      16)
  end
  object s0GridCellCheck1: Ts0GridCellCheck
    Left = 384
    Top = 48
    Width = 16
    Height = 16
    ParentColor = False
    TabOrder = 1
    TabStop = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 155
    Width = 526
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 438
      Top = 2
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 342
      Top = 2
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkOK
    end
    object btnNewMode: TButton
      Left = 8
      Top = 2
      Width = 75
      Height = 25
      Caption = 'êVãKçÏê¨(&N)'
      TabOrder = 2
      OnClick = btnNewModeClick
    end
  end
end
