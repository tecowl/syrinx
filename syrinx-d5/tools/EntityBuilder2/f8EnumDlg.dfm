object frm8EnumDlg: Tfrm8EnumDlg
  Left = 71
  Top = 77
  Width = 308
  Height = 301
  Caption = 'Enumeration Members'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object s0CtrlGrid1: Ts0BaseGrid
    Left = 0
    Top = 0
    Width = 300
    Height = 248
    CellDrawer.Font.Charset = SHIFTJIS_CHARSET
    CellDrawer.Font.Color = clWindowText
    CellDrawer.Font.Height = -12
    CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
    CellDrawer.Font.Style = []
    DoubleBuffered = False
    FixedCols = 0
    ColCount = 2
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
    Align = alClient
    TabOrder = 0
    BindSeals = <>
    Columns = <
      item
        Title = 'Member Name'
        TitleRow = 0
        Width = 195
      end
      item
        Title = 'JP Name'
        TitleRow = 0
        Width = 99
      end>
    ReadOnlySeals = <>
    CtrlDecos = <>
    AlignmentDecos = <>
    ColorDecos = <>
    ColWidths = (
      195
      99)
    RowHeights = (
      16
      16)
    CellData = (
      0
      0
      'Member Name'
      1
      0
      'JP Name'
      0
      1
      ''
      1
      1
      '')
    object c0GridCmd_CopyToClipBoard1: Ts0GridCmd_CopyToClipBoard
      Caption = 'ÉRÉsÅ[(&C)'
      ShortCut = 16451
      Target = s0CtrlGrid1
    end
    object c0GridCmd_CutToClipBoard1: Ts0GridCmd_CutToClipBoard
      Caption = 'êÿÇËéÊÇË(&T)'
      ShortCut = 16472
      Target = s0CtrlGrid1
    end
    object c0GridCmd_DeleteSelection1: Ts0GridCmd_DeleteSelection
      Caption = 'çÌèú(&D)'
      ShortCut = 46
      Target = s0CtrlGrid1
    end
    object c0GridCmd_PasteFromClipBoard1: Ts0GridCmd_PasteFromClipBoard
      Caption = 'ì\ÇËïtÇØ(&P)'
      ShortCut = 16470
      Target = s0CtrlGrid1
    end
    object c0GridCmd_InsertRow1: Ts0GridCmd_InsertRow
      Caption = 'çsë}ì¸'
      ShortCut = 0
      Target = s0CtrlGrid1
    end
    object c0GridCmd_RemoveRow1: Ts0GridCmd_RemoveRow
      Caption = 'çsçÌèú'
      ShortCut = 0
      Target = s0CtrlGrid1
    end
    object c0ShowAllColumns1: Ts0ShowAllColumns
      Caption = 'ëSÇƒÇÃóÒÇï\é¶'
      ShortCut = 0
      Target = s0CtrlGrid1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 248
    Width = 300
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 112
      Top = 0
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 208
      Top = 0
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
