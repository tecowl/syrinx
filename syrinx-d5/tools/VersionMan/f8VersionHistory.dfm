object frm8VersionHistory: Tfrm8VersionHistory
  Left = 272
  Top = 114
  Width = 773
  Height = 340
  Caption = 'frm8VersionHistory'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ＭＳ Ｐゴシック'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter3: TSplitter
    Left = 225
    Top = 0
    Width = 3
    Height = 313
    Cursor = crHSplit
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 313
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel3'
    TabOrder = 0
    object Panel4: TPanel
      Left = 0
      Top = 248
      Width = 225
      Height = 65
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
      object btnShowDiff: TButton
        Left = 60
        Top = 36
        Width = 159
        Height = 25
        Action = actShowDiff
        Anchors = [akRight, akBottom]
        Caption = 'Show Difference >>'
        TabOrder = 0
      end
      object chkTrimedCompare: TCheckBox
        Left = 8
        Top = 8
        Width = 113
        Height = 17
        Caption = 'Trimed Compare'
        TabOrder = 1
      end
    end
    object ListView1: TListView
      Left = 0
      Top = 0
      Width = 225
      Height = 248
      Align = alClient
      Columns = <
        item
          Caption = 'Version'
          Width = 60
        end
        item
          Caption = 'SavePoint'
          Width = 75
        end
        item
          Caption = 'TimeStamp'
          Width = 150
        end>
      ColumnClick = False
      HideSelection = False
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object s0DecoGrid1: Ts0DecoGrid
    Left = 228
    Top = 0
    Width = 537
    Height = 313
    FixedCols = 0
    ColCount = 2
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect, goColSizing]
    Align = alClient
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS UI Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    BindSeals = <>
    Columns = <
      item
        TitleRow = 0
        Width = 211
      end
      item
        TitleRow = 0
        Width = 203
      end>
    ReadOnlySeals = <
      item
        Top = 0
        Left = 0
        Right = 1
        Bottom = 1
      end>
    AlignmentDecos = <>
    ColorDecos = <>
    ColWidths = (
      211
      203)
    CellData = (
      0
      0
      ''
      1
      0
      ''
      0
      1
      ''
      1
      1
      ''
      0
      2
      ''
      1
      2
      ''
      0
      3
      ''
      1
      3
      ''
      0
      4
      ''
      1
      4
      '')
    object c0GridCmd_CopyToClipBoard1: Ts0GridCmd_CopyToClipBoard
      Caption = 'コピー(&C)'
      ShortCut = 16451
      Target = s0DecoGrid1
    end
    object c0ShowAllColumns1: Ts0ShowAllColumns
      Caption = '全ての列を表示'
      ShortCut = 0
      Target = s0DecoGrid1
    end
  end
  object ActionList1: TActionList
    Left = 16
    Top = 40
    object actShowDiff: TAction
      Caption = 'Show Difference'
      OnExecute = actShowDiffExecute
      OnUpdate = actShowDiffUpdate
    end
  end
end
