object Form1: TForm1
  Left = 1
  Top = 11
  Width = 1036
  Height = 780
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1028
    Height = 753
    ActivePage = TabSheet5
    Align = alClient
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object tec1Label1: Ttec1Label
        Left = 8
        Top = 32
        Width = 55
        Height = 12
        Caption = 'tec1Label1'
      end
      object tec1Edit1: Ttec1Edit
        Left = 40
        Top = 80
        Width = 180
        Height = 18
        MaxLength = 40
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        Text = 'tec1Edit1'
        AcceptCharType = [k1ctAlpha, k1ctDigit]
        Alignment = taLeftJustify
        NumericOnly = False
        TitleDisplay = tec1Label1
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 40
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit]
        InputStyle.AutoWidth = False
        InputStyle.TitleDisplay = tec1Label1
      end
      object tec1Memo1: Ttec1Memo
        Left = 40
        Top = 112
        Width = 185
        Height = 89
        ParentCtl3D = False
        TabOrder = 1
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      end
      object tec1Button1: Ttec1Button
        Left = 120
        Top = 16
        Width = 75
        Height = 25
        Caption = 'tec1Button1'
        TabOrder = 2
      end
      object tec1CheckBox1: Ttec1CheckBox
        Left = 16
        Top = 8
        Width = 97
        Height = 17
        Caption = 'tec1CheckBox1'
        ParentCtl3D = False
        TabOrder = 3
      end
      object tec1ListBox1: Ttec1ListBox
        Left = 240
        Top = 104
        Width = 121
        Height = 97
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 4
        ItemObjVersion = 100
        ItemObjectsAsInt = ()
      end
      object tec1ComboBox1: Ttec1ComboBox
        Left = 208
        Top = 16
        Width = 145
        Height = 20
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 5
        Text = 'tec1ComboBox1'
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        Alignment = taLeftJustify
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        ItemIndex = -1
        ReadOnly = False
        ItemObjVersion = 100
        ItemObjectsAsInt = ()
      end
      object tec1GroupBox1: Ttec1GroupBox
        Left = 224
        Top = 208
        Width = 185
        Height = 105
        Caption = 'tec1GroupBox1'
        ParentCtl3D = False
        TabOrder = 6
      end
      object tec1GroupBox2: Ttec1GroupBox
        Left = 32
        Top = 208
        Width = 185
        Height = 105
        Caption = 'tec1GroupBox2'
        ParentCtl3D = False
        TabOrder = 7
      end
      object tec1Panel1: Ttec1Panel
        Left = 384
        Top = 16
        Width = 185
        Height = 41
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Caption = 'tec1Panel1'
        ParentCtl3D = False
        TabOrder = 8
      end
      object tec1StringGrid1: Ttec1StringGrid
        Left = 416
        Top = 72
        Width = 409
        Height = 145
        CellDrawer.Font.Charset = SHIFTJIS_CHARSET
        CellDrawer.Font.Color = clWindowText
        CellDrawer.Font.Height = -12
        CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        CellDrawer.Font.Style = []
        DoubleBuffered = False
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 9
        BindSeals = <>
        Columns = <>
        ReadOnlySeals = <>
        CtrlDecos = <>
        AlignmentDecos = <>
        ColorDecos = <
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = clBlack
            FontColor = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = clBlack
            FontColor = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = clBlack
            ColorIdentifier = 'stripe row'
          end>
        AlternateRowColor = clBlack
        AlternateRowFontColor = clBlack
        RowHeights = (
          16
          18
          16
          16
          16)
        CellData = (
          0
          0
          ''
          1
          0
          ''
          2
          0
          ''
          3
          0
          ''
          4
          0
          ''
          0
          1
          ''
          1
          1
          ''
          2
          1
          ''
          3
          1
          ''
          4
          1
          ''
          0
          2
          ''
          1
          2
          ''
          2
          2
          ''
          3
          2
          ''
          4
          2
          ''
          0
          3
          ''
          1
          3
          ''
          2
          3
          ''
          3
          3
          ''
          4
          3
          ''
          0
          4
          ''
          1
          4
          ''
          2
          4
          ''
          3
          4
          ''
          4
          4
          '')
      end
      object tec1CheckListBox1: Ttec1CheckListBox
        Left = 416
        Top = 224
        Width = 257
        Height = 73
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 10
      end
      object tec1StaticText1: Ttec1StaticText
        Left = 8
        Top = 48
        Width = 85
        Height = 16
        Caption = 'tec1StaticText1'
        TabOrder = 11
      end
      object tec1RadioButton1: Ttec1RadioButton
        Left = 112
        Top = 48
        Width = 113
        Height = 17
        Caption = 'tec1RadioButton1'
        ParentCtl3D = False
        TabOrder = 12
      end
      object tec1DateEdit1: Ttec1DateEdit
        Left = 32
        Top = 328
        Width = 118
        Height = 17
        Accessor.Year = 99
        Accessor.Month = 10
        Accessor.Day = 6
        Accessor.Hour = 1
        Accessor.Minute = 5
        Accessor.Second = 59
        Accessor.MiliSec = 797
        EraType = k0ekJapanese
        InputStyle.Alignment = taLeftJustify
        InputStyle.CharCase = ecUpperCase
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -15
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        JapaneseEra = k0jeHeisei
        MarginTop = 0
        MarginBottom = 0
        BorderStyle = bsSingle
        BorderStyleOfParts = bsNone
        Color = clWhite
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        Font.Style = []
        TabOrder = 13
        EditYear.Anchors = [akLeft]
        EditYear.Color = clWhite
        EditYear.Font.Charset = SHIFTJIS_CHARSET
        EditYear.Font.Color = clWindowText
        EditYear.Font.Height = -12
        EditYear.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditYear.Font.Style = []
        EditYear.Left = 0
        EditYear.TabOrder = 0
        EditYear.Visible = True
        EditYear.Width = 27
        EditMonth.Anchors = [akLeft, akTop, akBottom]
        EditMonth.Color = clWhite
        EditMonth.Font.Charset = SHIFTJIS_CHARSET
        EditMonth.Font.Color = clWindowText
        EditMonth.Font.Height = -12
        EditMonth.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMonth.Font.Style = []
        EditMonth.Left = 27
        EditMonth.TabOrder = 1
        EditMonth.Visible = True
        EditMonth.Width = 18
        EditDay.Anchors = [akLeft]
        EditDay.Color = clWhite
        EditDay.Font.Charset = SHIFTJIS_CHARSET
        EditDay.Font.Color = clWindowText
        EditDay.Font.Height = -12
        EditDay.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditDay.Font.Style = []
        EditDay.Left = 45
        EditDay.TabOrder = 2
        EditDay.Visible = True
        EditDay.Width = 18
        EditHour.Anchors = [akLeft, akTop, akBottom]
        EditHour.Color = clWhite
        EditHour.Font.Charset = SHIFTJIS_CHARSET
        EditHour.Font.Color = clWindowText
        EditHour.Font.Height = -12
        EditHour.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditHour.Font.Style = []
        EditHour.Left = 63
        EditHour.TabOrder = 3
        EditHour.Visible = True
        EditHour.Width = 18
        EditMinute.Anchors = [akLeft, akTop, akBottom]
        EditMinute.Color = clWhite
        EditMinute.Font.Charset = SHIFTJIS_CHARSET
        EditMinute.Font.Color = clWindowText
        EditMinute.Font.Height = -12
        EditMinute.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMinute.Font.Style = []
        EditMinute.Left = 81
        EditMinute.TabOrder = 4
        EditMinute.Visible = True
        EditMinute.Width = 18
        EditSecond.Anchors = [akLeft, akTop, akBottom]
        EditSecond.Color = clWhite
        EditSecond.Font.Charset = SHIFTJIS_CHARSET
        EditSecond.Font.Color = clWindowText
        EditSecond.Font.Height = -12
        EditSecond.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditSecond.Font.Style = []
        EditSecond.Left = 99
        EditSecond.TabOrder = 5
        EditSecond.Visible = True
        EditSecond.Width = 18
        EditMiliSec.Anchors = [akLeft, akTop, akBottom]
        EditMiliSec.Color = clWhite
        EditMiliSec.Font.Charset = SHIFTJIS_CHARSET
        EditMiliSec.Font.Color = clWindowText
        EditMiliSec.Font.Height = -12
        EditMiliSec.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMiliSec.Font.Style = []
        EditMiliSec.Left = 117
        EditMiliSec.TabOrder = 6
        EditMiliSec.Visible = False
        EditMiliSec.Width = 24
      end
      object TecNum1: TTecNum
        Left = 528
        Top = 392
        Width = 121
        Height = 18
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 14
        Text = '1'
        LimitMin = -2147483647
        LimitMax = 2147483647
      end
      object Tec4SelCombo1: TTec4SelCombo
        Left = 184
        Top = 472
        Width = 145
        Height = 20
        ItemHeight = 12
        TabOrder = 15
      end
      object TecDBSelCombo1: TTecDBSelCombo
        Left = 184
        Top = 440
        Width = 145
        Height = 20
        Ctl3D = False
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 16
        Text = 'TecDBSelCombo1'
        DBParams.Strings = (
          'User Name=SYSDBA'
          'Password=masterkey'
          'SQLQRYMODE=SERVER'
          'LANGDRIVER=japan')
      end
      object Edit1: TEdit
        Left = 40
        Top = 384
        Width = 121
        Height = 20
        TabOrder = 17
        Text = 'Edit1'
      end
      object TecNum2: TTecNum
        Left = 40
        Top = 432
        Width = 121
        Height = 20
        TabOrder = 18
        Text = '2.0'
        CountFraction = 1
        LimitMin = -2147483647
        LimitMax = 2147483647
      end
      object tec1xNum1: Ttec1xNum
        Left = 232
        Top = 336
        Width = 48
        Height = 18
        AutoSelect = False
        ImeMode = imClose
        ParentCtl3D = False
        TabOrder = 19
        Text = '0'
        Alignment = taRightJustify
        InputStyle.Alignment = taRightJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctDigit]
        InputStyle.ExclusiveAcceptChar = '-.'
        BackColor = clWindow
        KeyInput = True
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object TecNum3: TTecNum
        Left = 16
        Top = 32
        Width = 121
        Height = 20
        TabOrder = 0
        Text = '3'
        LimitMin = -2147483647
        LimitMax = 2147483647
      end
      object tec1DigitEdit1: Ttec1DigitEdit
        Left = 16
        Top = 64
        Width = 209
        Height = 18
        ImeMode = imClose
        ParentCtl3D = False
        TabOrder = 1
        Text = '00000.00000'
        Alignment = taRightJustify
        DecimalMinLength = 5
        IntegerMinLength = 5
        InputStyle.Alignment = taRightJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctDigit]
        InputStyle.ExclusiveAcceptChar = '-.'
      end
      object xDate2: TxDate
        Left = 16
        Top = 88
        Width = 100
        Height = 50
        TabOrder = 2
        ControlData = {
          00000100560A00002B0500004D000000080000800F000080000352E30B918FCE
          119DE300AA004BB851018000009001905F01000F826C827220826F8353835683
          62834E01000452E30B918FCE119DE300AA004BB8516C74000000000000000000
          00010004000000000000000000000020D6E240D50708000D0007000000000009
          4831372E20382E313301010000010101010080808000FFFFFF00010001000100
          0A323031392F31322F333108313932302F312F31}
      end
      object tec1Edit2: Ttec1Edit
        Left = 128
        Top = 96
        Width = 121
        Height = 18
        ParentCtl3D = False
        TabOrder = 3
        Text = 'tec1Edit2'
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        Alignment = taLeftJustify
        NumericOnly = False
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        InputStyle.AutoWidth = False
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'CCC2'
      ImageIndex = 2
      object xDate1: TxDate
        Left = 32
        Top = 24
        Width = 209
        Height = 50
        TabOrder = 0
        ControlData = {
          000001009A1500002B0500004D000000080000800F000080000352E30B918FCE
          119DE300AA004BB851018000009001905F01000F826C827220826F8353835683
          62834E01000452E30B918FCE119DE300AA004BB8516C74000000000000000000
          000100040000000000000000000000E0D5E240D50708000B0005000000000009
          4831372E20382E313101010000010101010080808000FFFFFF00010001000100
          0A323031392F31322F333108313932302F312F31}
      end
      object xNum1: TxNum
        Left = 32
        Top = 80
        Width = 100
        Height = 50
        TabOrder = 1
        ControlData = {
          00000100560A00002B0500004D000000080000800F000080000352E30B918FCE
          119DE300AA004BB851018000009001905F01000F826C827220826F8353835683
          62834E01FF000001000000080000000000040000000000000000000000000080
          E03779C341430080E03779C341C300000000000000000000012D000000000001
          010100010820202020202020308080800000000000}
      end
      object xTime1: TxTime
        Left = 248
        Top = 24
        Width = 153
        Height = 50
        TabOrder = 2
        ControlData = {
          00000100D00F00002B0500004D000000080000800F000080000352E30B918FCE
          119DE300AA004BB851018000009001905F01000F826C827220826F8353835683
          62834E01000452E30B918FCE119DE300AA004BB8516C74000000000000000000
          0001000400000000000000D5DA35E6EB46EA3F13002A001C0000000000108CDF
          8CE330378E9E343295AA3238956201010000010101010080808000FFFFFF0001
          00010001000830303A30303A30300832333A35393A3539}
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'TabSheet4'
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
      Font.Style = []
      ImageIndex = 3
      ParentFont = False
      object tec1DBGrid1: Ttec1DBGrid
        Left = 0
        Top = 0
        Width = 1020
        Height = 726
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = SHIFTJIS_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        TitleFont.Style = []
        TitleButtons = True
        TitleArrow = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 16
        TitleRowHeight = 16
        PopupMenuItems = [kt1dbgpmSortMode, kt1dbgpmColumnSelectMode, kt1dbgpmCopuToClipboard, kt1dbgpmSaveToCsvFile]
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'TabSheet5'
      ImageIndex = 4
      object tec1Label2: Ttec1Label
        Left = 0
        Top = 16
        Width = 55
        Height = 12
        Caption = 'tec1Label2'
      end
      object tec1Bevel1: Ttec1Bevel
        Left = 344
        Top = 160
        Width = 169
        Height = 113
      end
      object tec1Edit3: Ttec1Edit
        Left = 0
        Top = 32
        Width = 121
        Height = 18
        ParentCtl3D = False
        TabOrder = 0
        Text = 'tec1Edit3'
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        Alignment = taLeftJustify
        NumericOnly = False
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        InputStyle.AutoWidth = False
      end
      object tec1Memo2: Ttec1Memo
        Left = 0
        Top = 56
        Width = 185
        Height = 89
        ParentCtl3D = False
        TabOrder = 1
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      end
      object tec1Button2: Ttec1Button
        Left = 8
        Top = 152
        Width = 75
        Height = 25
        Caption = 'tec1Button2'
        TabOrder = 2
      end
      object tec1CheckBox2: Ttec1CheckBox
        Left = 8
        Top = 184
        Width = 97
        Height = 17
        Caption = 'tec1CheckBox2'
        ParentCtl3D = False
        TabOrder = 3
      end
      object tec1ListBox2: Ttec1ListBox
        Left = 0
        Top = 208
        Width = 121
        Height = 97
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 4
        ItemObjVersion = 100
        ItemObjectsAsInt = ()
      end
      object tec1ComboBox2: Ttec1ComboBox
        Left = 0
        Top = 312
        Width = 145
        Height = 20
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 5
        Text = 'tec1ComboBox2'
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        Alignment = taLeftJustify
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        ItemIndex = -1
        ReadOnly = False
        ItemObjVersion = 100
        ItemObjectsAsInt = ()
      end
      object tec1GroupBox3: Ttec1GroupBox
        Left = 0
        Top = 344
        Width = 185
        Height = 105
        Caption = 'tec1GroupBox3'
        ParentCtl3D = False
        TabOrder = 6
      end
      object tec1Panel2: Ttec1Panel
        Left = 8
        Top = 576
        Width = 185
        Height = 41
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Caption = 'tec1Panel2'
        ParentCtl3D = False
        TabOrder = 7
      end
      object tec1StringGrid2: Ttec1StringGrid
        Left = 192
        Top = 16
        Width = 320
        Height = 120
        CellDrawer.Font.Charset = SHIFTJIS_CHARSET
        CellDrawer.Font.Color = clWindowText
        CellDrawer.Font.Height = -12
        CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        CellDrawer.Font.Style = []
        DoubleBuffered = False
        TabOrder = 8
        BindSeals = <>
        Columns = <>
        ReadOnlySeals = <>
        CtrlDecos = <>
        AlignmentDecos = <>
        ColorDecos = <
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            FontColor = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            FontColor = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            FontColor = clBlack
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            ColorIdentifier = 'stripe row'
          end
          item
            Top = 0
            Left = 0
            Right = 4
            Bottom = 4
            RegionKind = k0gcrWhole
            StripeRow = True
            Color = 12572411
            ColorIdentifier = 'stripe row'
          end>
        AlternateRowColor = 12572411
        AlternateRowFontColor = clBlack
        ColWidths = (
          100
          83
          91
          100
          100)
        RowHeights = (
          16
          15
          16
          16
          16)
        CellData = (
          0
          0
          ''
          1
          0
          ''
          2
          0
          ''
          3
          0
          ''
          4
          0
          ''
          0
          1
          ''
          1
          1
          ''
          2
          1
          ''
          3
          1
          ''
          4
          1
          ''
          0
          2
          ''
          1
          2
          ''
          2
          2
          ''
          3
          2
          ''
          4
          2
          ''
          0
          3
          ''
          1
          3
          ''
          2
          3
          ''
          3
          3
          ''
          4
          3
          ''
          0
          4
          ''
          1
          4
          ''
          2
          4
          ''
          3
          4
          ''
          4
          4
          '')
      end
      object tec1CheckListBox2: Ttec1CheckListBox
        Left = 192
        Top = 144
        Width = 121
        Height = 97
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 9
      end
      object tec1RadioButton2: Ttec1RadioButton
        Left = 192
        Top = 248
        Width = 113
        Height = 17
        Caption = 'tec1RadioButton2'
        ParentCtl3D = False
        TabOrder = 10
      end
      object tec1DateEdit2: Ttec1DateEdit
        Left = 192
        Top = 280
        Width = 67
        Height = 14
        Accessor.Year = 2005
        Accessor.Month = 8
        Accessor.Day = 19
        Accessor.Hour = 14
        Accessor.Minute = 23
        Accessor.Second = 45
        Accessor.MiliSec = 750
        InputStyle.Alignment = taLeftJustify
        InputStyle.CharCase = ecUpperCase
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        JapaneseEra = k0jeHeisei
        MarginTop = 0
        MarginBottom = 0
        Color = clWhite
        TabOrder = 11
        EditYear.Anchors = [akLeft, akTop, akBottom]
        EditYear.Color = clWhite
        EditYear.Font.Charset = SHIFTJIS_CHARSET
        EditYear.Font.Color = clWindowText
        EditYear.Font.Height = -12
        EditYear.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditYear.Font.Style = []
        EditYear.Left = 0
        EditYear.TabOrder = 0
        EditYear.Visible = True
        EditYear.Width = 30
        EditMonth.Anchors = [akLeft, akTop, akBottom]
        EditMonth.Color = clWhite
        EditMonth.Font.Charset = SHIFTJIS_CHARSET
        EditMonth.Font.Color = clWindowText
        EditMonth.Font.Height = -12
        EditMonth.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMonth.Font.Style = []
        EditMonth.Left = 30
        EditMonth.TabOrder = 1
        EditMonth.Visible = True
        EditMonth.Width = 18
        EditDay.Anchors = [akLeft, akTop, akBottom]
        EditDay.Color = clWhite
        EditDay.Font.Charset = SHIFTJIS_CHARSET
        EditDay.Font.Color = clWindowText
        EditDay.Font.Height = -12
        EditDay.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditDay.Font.Style = []
        EditDay.Left = 48
        EditDay.TabOrder = 2
        EditDay.Visible = True
        EditDay.Width = 18
        EditHour.Anchors = [akLeft, akTop, akBottom]
        EditHour.Color = clWhite
        EditHour.Font.Charset = SHIFTJIS_CHARSET
        EditHour.Font.Color = clWindowText
        EditHour.Font.Height = -12
        EditHour.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditHour.Font.Style = []
        EditHour.Left = 66
        EditHour.TabOrder = 3
        EditHour.Visible = False
        EditHour.Width = 18
        EditMinute.Anchors = [akLeft, akTop, akBottom]
        EditMinute.Color = clWhite
        EditMinute.Font.Charset = SHIFTJIS_CHARSET
        EditMinute.Font.Color = clWindowText
        EditMinute.Font.Height = -12
        EditMinute.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMinute.Font.Style = []
        EditMinute.Left = 84
        EditMinute.TabOrder = 4
        EditMinute.Visible = False
        EditMinute.Width = 18
        EditSecond.Anchors = [akLeft, akTop, akBottom]
        EditSecond.Color = clWhite
        EditSecond.Font.Charset = SHIFTJIS_CHARSET
        EditSecond.Font.Color = clWindowText
        EditSecond.Font.Height = -12
        EditSecond.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditSecond.Font.Style = []
        EditSecond.Left = 102
        EditSecond.TabOrder = 5
        EditSecond.Visible = False
        EditSecond.Width = 18
        EditMiliSec.Anchors = [akLeft, akTop, akBottom]
        EditMiliSec.Color = clWhite
        EditMiliSec.Font.Charset = SHIFTJIS_CHARSET
        EditMiliSec.Font.Color = clWindowText
        EditMiliSec.Font.Height = -12
        EditMiliSec.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMiliSec.Font.Style = []
        EditMiliSec.Left = 120
        EditMiliSec.TabOrder = 6
        EditMiliSec.Visible = False
        EditMiliSec.Width = 24
      end
      object tec1DigitEdit2: Ttec1DigitEdit
        Left = 192
        Top = 304
        Width = 48
        Height = 18
        ImeMode = imClose
        ParentCtl3D = False
        TabOrder = 12
        Text = '0'
        Alignment = taRightJustify
        InputStyle.Alignment = taRightJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctDigit]
        InputStyle.ExclusiveAcceptChar = '-.'
      end
      object tec1BitBtn1: Ttec1BitBtn
        Left = 256
        Top = 304
        Width = 75
        Height = 25
        Caption = 'tec1BitBtn1'
        TabOrder = 13
      end
      object tec1DateTimePicker1: Ttec1DateTimePicker
        Left = 352
        Top = 304
        Width = 186
        Height = 20
        CalAlignment = dtaLeft
        Date = 38583.6001276736
        Time = 38583.6001276736
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 14
      end
      object tec1DBCheckBox1: Ttec1DBCheckBox
        Left = 232
        Top = 352
        Width = 169
        Height = 17
        Caption = 'tec1DBCheckBox1'
        ParentCtl3D = False
        TabOrder = 15
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object tec1DBComboBox1: Ttec1DBComboBox
        Left = 232
        Top = 376
        Width = 145
        Height = 20
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 16
      end
      object tec1DBEdit1: Ttec1DBEdit
        Left = 232
        Top = 400
        Width = 121
        Height = 18
        ParentCtl3D = False
        TabOrder = 17
      end
      object tec1DBListBox1: Ttec1DBListBox
        Left = 232
        Top = 424
        Width = 121
        Height = 97
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 18
      end
      object tec1DBLookupComboBox1: Ttec1DBLookupComboBox
        Left = 232
        Top = 528
        Width = 145
        Height = 18
        ParentCtl3D = False
        TabOrder = 19
      end
      object tec1DBLookupListBox1: Ttec1DBLookupListBox
        Left = 232
        Top = 552
        Width = 121
        Height = 14
        ParentCtl3D = False
        TabOrder = 20
      end
      object tec1DBMemo1: Ttec1DBMemo
        Left = 232
        Top = 576
        Width = 185
        Height = 89
        ParentCtl3D = False
        TabOrder = 21
      end
      object tec1DBRadioGroup1: Ttec1DBRadioGroup
        Left = 560
        Top = 16
        Width = 185
        Height = 105
        Caption = 'tec1DBRadioGroup1'
        ParentCtl3D = False
        TabOrder = 22
      end
      object tec1DBRichEdit1: Ttec1DBRichEdit
        Left = 560
        Top = 136
        Width = 185
        Height = 89
        ParentCtl3D = False
        TabOrder = 23
      end
      object tec1ListView1: Ttec1ListView
        Left = 560
        Top = 248
        Width = 250
        Height = 150
        Columns = <>
        TabOrder = 24
      end
      object tec1MaskEdit1: Ttec1MaskEdit
        Left = 560
        Top = 408
        Width = 121
        Height = 18
        ParentCtl3D = False
        TabOrder = 25
        Text = 'tec1MaskEdit1'
      end
      object tec1RichEdit1: Ttec1RichEdit
        Left = 560
        Top = 440
        Width = 185
        Height = 89
        Lines.Strings = (
          'tec1RichEdit1')
        ParentCtl3D = False
        TabOrder = 26
      end
      object tec1TecDBSelCombo1: Ttec1TecDBSelCombo
        Left = 568
        Top = 544
        Width = 145
        Height = 20
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 27
        Text = 'tec1TecDBSelCombo1'
        DBParams.Strings = (
          'User Name=SYSDBA'
          'Password=masterkey'
          'SQLQRYMODE=SERVER'
          'LANGDRIVER=japan')
      end
      object tec1Tec4SelCombo1: Ttec1Tec4SelCombo
        Left = 568
        Top = 576
        Width = 145
        Height = 20
        ItemHeight = 12
        ParentCtl3D = False
        TabOrder = 28
      end
      object tec1xNum2: Ttec1xNum
        Left = 568
        Top = 608
        Width = 48
        Height = 18
        TabStop = False
        AutoSelect = False
        ImeMode = imClose
        ParentCtl3D = False
        TabOrder = 29
        Text = '0'
        Alignment = taRightJustify
        InputStyle.Alignment = taRightJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = True
        InputStyle.AcceptCharType = [k1ctDigit]
        InputStyle.ExclusiveAcceptChar = '-.'
        BackColor = clWindow
        KeyInput = True
      end
      object tec1TecNum1: Ttec1TecNum
        Left = 568
        Top = 640
        Width = 121
        Height = 18
        ParentCtl3D = False
        TabOrder = 30
        Text = '11'
        LimitMin = -2147483647
        LimitMax = 2147483647
      end
      object tec1xDate1: Ttec1xDate
        Left = 728
        Top = 552
        Width = 75
        Height = 18
        Accessor.Year = 99
        Accessor.Month = 8
        Accessor.Day = 19
        Accessor.Hour = 0
        Accessor.Minute = 0
        Accessor.Second = 0
        Accessor.MiliSec = 0
        InputStyle.Alignment = taLeftJustify
        InputStyle.CharCase = ecUpperCase
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -16
        InputStyle.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        JapaneseEra = k0jeHeisei
        MarginTop = 0
        MarginBottom = 0
        BorderStyle = bsSingle
        BorderStyleOfParts = bsNone
        Color = clWhite
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        Font.Style = []
        TabOrder = 31
        EditYear.Anchors = [akLeft, akTop, akBottom]
        EditYear.Font.Charset = SHIFTJIS_CHARSET
        EditYear.Font.Color = clWindowText
        EditYear.Font.Height = -16
        EditYear.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditYear.Font.Style = []
        EditYear.Left = 0
        EditYear.TabOrder = 0
        EditYear.Visible = True
        EditYear.Width = 30
        EditMonth.Anchors = [akLeft, akTop, akBottom]
        EditMonth.Font.Charset = SHIFTJIS_CHARSET
        EditMonth.Font.Color = clWindowText
        EditMonth.Font.Height = -16
        EditMonth.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditMonth.Font.Style = []
        EditMonth.Left = 30
        EditMonth.TabOrder = 1
        EditMonth.Visible = True
        EditMonth.Width = 22
        EditDay.Anchors = [akLeft, akTop, akBottom]
        EditDay.Font.Charset = SHIFTJIS_CHARSET
        EditDay.Font.Color = clWindowText
        EditDay.Font.Height = -16
        EditDay.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditDay.Font.Style = []
        EditDay.Left = 52
        EditDay.TabOrder = 2
        EditDay.Visible = True
        EditDay.Width = 22
        EditHour.Anchors = [akLeft, akTop, akBottom]
        EditHour.Font.Charset = SHIFTJIS_CHARSET
        EditHour.Font.Color = clWindowText
        EditHour.Font.Height = -16
        EditHour.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditHour.Font.Style = []
        EditHour.Left = 74
        EditHour.TabOrder = 3
        EditHour.Visible = False
        EditHour.Width = 22
        EditMinute.Anchors = [akLeft, akTop, akBottom]
        EditMinute.Font.Charset = SHIFTJIS_CHARSET
        EditMinute.Font.Color = clWindowText
        EditMinute.Font.Height = -16
        EditMinute.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditMinute.Font.Style = []
        EditMinute.Left = 96
        EditMinute.TabOrder = 4
        EditMinute.Visible = False
        EditMinute.Width = 22
        EditSecond.Anchors = [akLeft, akTop, akBottom]
        EditSecond.Font.Charset = SHIFTJIS_CHARSET
        EditSecond.Font.Color = clWindowText
        EditSecond.Font.Height = -16
        EditSecond.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditSecond.Font.Style = []
        EditSecond.Left = 118
        EditSecond.TabOrder = 5
        EditSecond.Visible = False
        EditSecond.Width = 22
        EditMiliSec.Anchors = [akLeft, akTop, akBottom]
        EditMiliSec.Font.Charset = SHIFTJIS_CHARSET
        EditMiliSec.Font.Color = clWindowText
        EditMiliSec.Font.Height = -16
        EditMiliSec.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditMiliSec.Font.Style = []
        EditMiliSec.Left = 140
        EditMiliSec.TabOrder = 6
        EditMiliSec.Visible = False
        EditMiliSec.Width = 30
        ParentColor = False
        ParentFont = False
        BackColor = clWhite
        DayValue = 19
        InputMode = 0
        InputArea3D = True
        InputAreaColor = clWindow
        MonthValue = 8
        SpinButton = False
        YearValue = 2087
      end
      object tec1xTime1: Ttec1xTime
        Left = 728
        Top = 584
        Width = 67
        Height = 14
        Accessor.Year = 2005
        Accessor.Month = 8
        Accessor.Day = 19
        Accessor.Hour = 14
        Accessor.Minute = 26
        Accessor.Second = 16
        Accessor.MiliSec = 546
        InputStyle.Alignment = taLeftJustify
        InputStyle.CharCase = ecUpperCase
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        JapaneseEra = k0jeHeisei
        MarginTop = 0
        MarginBottom = 0
        BorderStyle = bsSingle
        BorderStyleOfParts = bsNone
        Color = clWhite
        TabOrder = 32
        EditYear.Anchors = [akLeft, akTop, akBottom]
        EditYear.Color = clWhite
        EditYear.Font.Charset = SHIFTJIS_CHARSET
        EditYear.Font.Color = clWindowText
        EditYear.Font.Height = -12
        EditYear.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditYear.Font.Style = []
        EditYear.Left = 0
        EditYear.TabOrder = 0
        EditYear.Visible = True
        EditYear.Width = 30
        EditMonth.Anchors = [akLeft, akTop, akBottom]
        EditMonth.Color = clWhite
        EditMonth.Font.Charset = SHIFTJIS_CHARSET
        EditMonth.Font.Color = clWindowText
        EditMonth.Font.Height = -12
        EditMonth.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMonth.Font.Style = []
        EditMonth.Left = 30
        EditMonth.TabOrder = 1
        EditMonth.Visible = True
        EditMonth.Width = 18
        EditDay.Anchors = [akLeft, akTop, akBottom]
        EditDay.Color = clWhite
        EditDay.Font.Charset = SHIFTJIS_CHARSET
        EditDay.Font.Color = clWindowText
        EditDay.Font.Height = -12
        EditDay.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditDay.Font.Style = []
        EditDay.Left = 48
        EditDay.TabOrder = 2
        EditDay.Visible = True
        EditDay.Width = 18
        EditHour.Anchors = [akLeft, akTop, akBottom]
        EditHour.Color = clWhite
        EditHour.Font.Charset = SHIFTJIS_CHARSET
        EditHour.Font.Color = clWindowText
        EditHour.Font.Height = -12
        EditHour.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditHour.Font.Style = []
        EditHour.Left = 66
        EditHour.TabOrder = 3
        EditHour.Visible = False
        EditHour.Width = 18
        EditMinute.Anchors = [akLeft, akTop, akBottom]
        EditMinute.Color = clWhite
        EditMinute.Font.Charset = SHIFTJIS_CHARSET
        EditMinute.Font.Color = clWindowText
        EditMinute.Font.Height = -12
        EditMinute.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMinute.Font.Style = []
        EditMinute.Left = 84
        EditMinute.TabOrder = 4
        EditMinute.Visible = False
        EditMinute.Width = 18
        EditSecond.Anchors = [akLeft, akTop, akBottom]
        EditSecond.Color = clWhite
        EditSecond.Font.Charset = SHIFTJIS_CHARSET
        EditSecond.Font.Color = clWindowText
        EditSecond.Font.Height = -12
        EditSecond.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditSecond.Font.Style = []
        EditSecond.Left = 102
        EditSecond.TabOrder = 5
        EditSecond.Visible = False
        EditSecond.Width = 18
        EditMiliSec.Anchors = [akLeft, akTop, akBottom]
        EditMiliSec.Color = clWhite
        EditMiliSec.Font.Charset = SHIFTJIS_CHARSET
        EditMiliSec.Font.Color = clWindowText
        EditMiliSec.Font.Height = -12
        EditMiliSec.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        EditMiliSec.Font.Style = []
        EditMiliSec.Left = 120
        EditMiliSec.TabOrder = 6
        EditMiliSec.Visible = False
        EditMiliSec.Width = 24
      end
      object tec1xDate2: Ttec1xDate
        Left = 696
        Top = 616
        Width = 97
        Height = 41
        Accessor.Year = 15
        Accessor.Month = 8
        Accessor.Day = 19
        Accessor.Hour = 0
        Accessor.Minute = 0
        Accessor.Second = 0
        Accessor.MiliSec = 0
        InputStyle.Alignment = taLeftJustify
        InputStyle.CharCase = ecUpperCase
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -16
        InputStyle.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        InputStyle.Font.Style = []
        InputStyle.ImeMode = imClose
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        JapaneseEra = k0jeHeisei
        MarginTop = 0
        MarginBottom = 0
        BorderStyle = bsSingle
        BorderStyleOfParts = bsNone
        Color = clWindow
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        Font.Style = []
        TabOrder = 33
        EditYear.Anchors = [akLeft, akTop, akBottom]
        EditYear.Font.Charset = SHIFTJIS_CHARSET
        EditYear.Font.Color = clWindowText
        EditYear.Font.Height = -16
        EditYear.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditYear.Font.Style = []
        EditYear.Left = 0
        EditYear.TabOrder = 0
        EditYear.Visible = True
        EditYear.Width = 30
        EditMonth.Anchors = [akLeft, akTop, akBottom]
        EditMonth.Font.Charset = SHIFTJIS_CHARSET
        EditMonth.Font.Color = clWindowText
        EditMonth.Font.Height = -16
        EditMonth.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditMonth.Font.Style = []
        EditMonth.Left = 30
        EditMonth.TabOrder = 1
        EditMonth.Visible = True
        EditMonth.Width = 22
        EditDay.Font.Charset = SHIFTJIS_CHARSET
        EditDay.Font.Color = clWindowText
        EditDay.Font.Height = -16
        EditDay.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditDay.Font.Style = []
        EditDay.Left = 52
        EditDay.TabOrder = 2
        EditDay.Visible = True
        EditDay.Width = 22
        EditHour.Font.Charset = SHIFTJIS_CHARSET
        EditHour.Font.Color = clWindowText
        EditHour.Font.Height = -16
        EditHour.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditHour.Font.Style = []
        EditHour.Left = 52
        EditHour.TabOrder = 3
        EditHour.Visible = False
        EditHour.Width = 22
        EditMinute.Anchors = [akLeft, akTop, akBottom]
        EditMinute.Font.Charset = SHIFTJIS_CHARSET
        EditMinute.Font.Color = clWindowText
        EditMinute.Font.Height = -16
        EditMinute.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditMinute.Font.Style = []
        EditMinute.Left = 52
        EditMinute.TabOrder = 4
        EditMinute.Visible = False
        EditMinute.Width = 22
        EditSecond.Anchors = [akLeft, akTop, akBottom]
        EditSecond.Font.Charset = SHIFTJIS_CHARSET
        EditSecond.Font.Color = clWindowText
        EditSecond.Font.Height = -16
        EditSecond.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditSecond.Font.Style = []
        EditSecond.Left = 74
        EditSecond.TabOrder = 5
        EditSecond.Visible = False
        EditSecond.Width = 22
        EditMiliSec.Anchors = [akLeft, akTop, akBottom]
        EditMiliSec.Font.Charset = SHIFTJIS_CHARSET
        EditMiliSec.Font.Color = clWindowText
        EditMiliSec.Font.Height = -16
        EditMiliSec.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
        EditMiliSec.Font.Style = []
        EditMiliSec.Left = 96
        EditMiliSec.TabOrder = 6
        EditMiliSec.Visible = False
        EditMiliSec.Width = 30
        ParentColor = False
        ParentFont = False
        BackColor = clWindow
        DayValue = 19
        InputMode = 0
        InputArea3D = True
        InputAreaColor = clWindow
        MonthValue = 8
        SpinButton = False
        YearValue = 2003
      end
      object tec1Button3: Ttec1Button
        Left = 616
        Top = 608
        Width = 75
        Height = 25
        Caption = 'tec1Button2'
        TabOrder = 34
        OnClick = tec1Button2Click
      end
      object tec1RadioGroup1: Ttec1RadioGroup
        Left = 8
        Top = 456
        Width = 185
        Height = 105
        Caption = 'tec1RadioGroup1'
        ParentCtl3D = False
        TabOrder = 35
        ItemObjVersion = 100
        ItemObjectsAsInt = ()
      end
    end
  end
  object s0Table1: Ts0Table
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'country.db'
    Left = 36
    Top = 7
    object s0Table1Name: TStringField
      DisplayLabel = 'çëñº'
      FieldName = 'Name'
      Size = 24
    end
    object s0Table1Capital: TStringField
      DisplayLabel = 'éÒìs'
      FieldName = 'Capital'
      Size = 24
    end
    object s0Table1Continent: TStringField
      FieldName = 'Continent'
      Size = 24
    end
    object s0Table1Area: TFloatField
      FieldName = 'Area'
    end
    object s0Table1Population: TFloatField
      FieldName = 'Population'
    end
  end
  object DataSource1: TDataSource
    DataSet = s0Table1
    Left = 56
    Top = 8
  end
  object tec1FocusColor1: Ttec1FocusColor
    Controllers = <>
    Left = 92
    Top = 7
  end
  object tec1FocusColor2: Ttec1FocusColor
    Controllers = <>
    Left = 116
    Top = 7
  end
  object tec1FocusColor3: Ttec1FocusColor
    Controllers = <>
    Left = 140
    Top = 7
  end
end
