object Form1: TForm1
  Left = 191
  Top = 292
  Width = 815
  Height = 446
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object s0PageControl1: Ts0PageControl
    Left = 0
    Top = 0
    Width = 807
    Height = 419
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 0
    DefaultPageIndex = 0
    object TabSheet4: TTabSheet
      Caption = 's0BarGraph'
      object s0BarGraph1: Ts0BarGraph
        Left = 0
        Top = 0
        Width = 799
        Height = 229
        Items = <
          item
            BarLength = 60
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
            Font.Style = []
            RenderText = True
            Hint = 'aaaa'
          end
          item
            BarLength = 80
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
            Font.Style = []
            RenderText = True
            Hint = 'bbbb'
          end
          item
            BarLength = 60
            Color = clOlive
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
            Font.Style = []
            RenderText = True
            Hint = 'cccc'
          end
          item
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
            Font.Style = []
            RenderText = True
            Hint = 'dddd'
          end
          item
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
            Font.Style = []
            RenderText = True
            Hint = 'eeee'
          end>
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 229
        Width = 799
        Height = 163
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel1'
        ParentColor = True
        TabOrder = 1
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 305
          Height = 163
          Align = alLeft
          TabOrder = 0
          object s0Label1: Ts0Label
            Left = 64
            Top = 16
            Width = 46
            Height = 12
            Caption = 'Direction'
          end
          object s0Label2: Ts0Label
            Left = 8
            Top = 64
            Width = 104
            Height = 12
            Caption = 'Denominator4Length'
          end
          object s0Label3: Ts0Label
            Left = 14
            Top = 88
            Width = 98
            Height = 12
            Caption = 'Denominator4Width'
          end
          object s0Label4: Ts0Label
            Left = 60
            Top = 41
            Width = 50
            Height = 12
            Caption = 'ValueUnit'
          end
          object Button1: TButton
            Left = 224
            Top = 80
            Width = 75
            Height = 25
            Caption = 'Apply'
            TabOrder = 0
            OnClick = Button1Click
          end
          object ComboBox1: TComboBox
            Left = 117
            Top = 10
            Width = 97
            Height = 20
            Style = csDropDownList
            ItemHeight = 12
            TabOrder = 1
            OnChange = ComboBox1Change
          end
          object s0DigitEdit1: Ts0DigitEdit
            Left = 118
            Top = 60
            Width = 48
            Height = 20
            ImeMode = imClose
            TabOrder = 2
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
          object s0DigitEdit2: Ts0DigitEdit
            Left = 118
            Top = 84
            Width = 48
            Height = 20
            ImeMode = imClose
            TabOrder = 3
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
          object ComboBox2: TComboBox
            Left = 118
            Top = 36
            Width = 145
            Height = 20
            Style = csDropDownList
            ItemHeight = 12
            TabOrder = 4
            OnChange = ComboBox2Change
          end
        end
        object s0BaseGrid1: Ts0BaseGrid
          Left = 305
          Top = 0
          Width = 494
          Height = 163
          CellDrawer.Font.Charset = SHIFTJIS_CHARSET
          CellDrawer.Font.Color = clWindowText
          CellDrawer.Font.Height = -12
          CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
          CellDrawer.Font.Style = []
          DoubleBuffered = False
          ColCount = 7
          Align = alClient
          TabOrder = 1
          BindSeals = <>
          Columns = <
            item
              TitleRow = 0
              Width = 14
            end
            item
              Title = 'BarLength'
              TitleRow = 0
              Width = 100
            end
            item
              Title = 'BarWidth'
              TitleRow = 0
              Width = 100
            end
            item
              Title = 'RenderText'
              TitleRow = 0
              Width = 100
            end
            item
              Title = 'ShowHint'
              TitleRow = 0
              Width = 100
            end
            item
              Title = 'Hint'
              TitleRow = 0
              Width = 100
            end
            item
              Title = 'Color'
              TitleRow = 0
              Width = 100
            end>
          ReadOnlySeals = <>
          CtrlDecos = <
            item
              Top = 0
              Left = 3
              Right = 4
              Bottom = 4
              RegionKind = k0gcrCols
              StripeRow = False
              Control = s0GridCellCheck1
              UpdateEventKinds = [k0cetOnClick]
            end>
          AlignmentDecos = <>
          ColorDecos = <>
          FontDecos = <>
          ColWidths = (
            14
            100
            100
            100
            100
            100
            100)
          RowHeights = (
            16
            16
            16
            16
            16)
          CellData = (
            0
            0
            ''
            1
            0
            'BarLength'
            2
            0
            'BarWidth'
            3
            0
            'RenderText'
            4
            0
            'ShowHint'
            5
            0
            'Hint'
            6
            0
            'Color'
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
            5
            1
            ''
            6
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
            5
            2
            ''
            6
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
            5
            3
            ''
            6
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
            ''
            5
            4
            ''
            6
            4
            '')
          object s0GridCmd_AddRow2: Ts0GridCmd_AddRow
            Caption = 'çsí«â¡'
            ShortCut = 16429
            Target = s0BaseGrid1
          end
          object s0GridCmd_InsertRow2: Ts0GridCmd_InsertRow
            Caption = 'çsë}ì¸'
            ShortCut = 49197
            Target = s0BaseGrid1
          end
          object s0GridCmd_RemoveRow3: Ts0GridCmd_RemoveRow
            Caption = 'çsçÌèú'
            ShortCut = 16430
            Target = s0BaseGrid1
          end
        end
        object s0GridCellCheck1: Ts0GridCellCheck
          Left = 544
          Top = 56
          Width = 16
          Height = 16
          ParentColor = False
          TabOrder = 2
          TabStop = True
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'JvDBUltimGrid'
      ImageIndex = 1
      object JvDBUltimGrid1: TJvDBUltimGrid
        Left = 145
        Top = 0
        Width = 654
        Height = 392
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = SHIFTJIS_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        TitleFont.Style = []
        AutoAppend = False
        AlternateRowColor = 14351601
        TitleArrow = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 16
        TitleRowHeight = 16
        MultiColSort = False
        OnIndexNotFound = JvDBUltimGrid1IndexNotFound
        Columns = <
          item
            Expanded = False
            FieldName = 'F001'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F002'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F003'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F004'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F005'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F006'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F007'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F008'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F009'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F010'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F011'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F012'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F013'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F014'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F015'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F016'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F017'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F018'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F019'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F020'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F021'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F022'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F023'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F024'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F025'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F026'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F027'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F028'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F029'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F030'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F031'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F032'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F033'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F034'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F035'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F036'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F037'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F038'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F039'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F040'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F041'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F042'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F043'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F044'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F045'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F046'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F047'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F048'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F049'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F050'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F051'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F052'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F053'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F054'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F055'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F056'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F057'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F058'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F059'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F060'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STUDENTCODE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INSURANCEKINDID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USERNAME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STUDENTMEMO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMPORTANCETELCOLORS'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HIRANAME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PETNAME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HOMEGUIDE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HISTORY'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLASSDATASTR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SIBLINGSID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONNECTIONGRPID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRIPARENTID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GRADEID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AREAID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EXCARECD1'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EXCAREDEM1'
            Visible = True
          end>
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 392
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object ListBox1: TListBox
          Left = 0
          Top = 0
          Width = 145
          Height = 392
          Align = alClient
          ItemHeight = 12
          TabOrder = 0
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'CalendarGrid'
      ImageIndex = 2
      object s0BaseGrid2: Ts0BaseGrid
        Left = 0
        Top = 0
        Width = 799
        Height = 392
        CellDrawer.Font.Charset = SHIFTJIS_CHARSET
        CellDrawer.Font.Color = clWindowText
        CellDrawer.Font.Height = -12
        CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        CellDrawer.Font.Style = []
        DefaultRowHeight = 100
        DoubleBuffered = False
        FixedCols = 0
        ColCount = 7
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goEditing]
        Align = alClient
        TabOrder = 0
        BindSeals = <>
        Columns = <
          item
            TitleRow = 0
            Width = 106
          end
          item
            TitleRow = 0
            Width = 100
          end
          item
            TitleRow = 0
            Width = 100
          end
          item
            TitleRow = 0
            Width = 100
          end
          item
            TitleRow = 0
            Width = 100
          end
          item
            TitleRow = 0
            Width = 100
          end
          item
            TitleRow = 0
            Width = 100
          end>
        ReadOnlySeals = <>
        CtrlDecos = <
          item
            Top = 0
            Left = 0
            Right = 0
            Bottom = 0
            StripeRow = True
          end>
        AlignmentDecos = <>
        ColorDecos = <>
        FontDecos = <>
        ColWidths = (
          106
          100
          100
          100
          100
          100
          100)
        RowHeights = (
          18
          100
          100
          100
          100)
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
          5
          0
          ''
          6
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
          5
          1
          ''
          6
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
          5
          2
          ''
          6
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
          5
          3
          ''
          6
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
          ''
          5
          4
          ''
          6
          4
          '')
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ImageIndex = 3
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 799
        Height = 392
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = SHIFTJIS_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'F003'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F007'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F002'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F008'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F010'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F011'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F012'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F013'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F014'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F015'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F001'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F004'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F005'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F006'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F016'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F009'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F017'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F018'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F019'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F020'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F021'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F022'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F023'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F024'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F025'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F026'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F027'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F028'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F029'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F030'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F031'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F032'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F033'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F034'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F035'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F036'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F037'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F038'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F039'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F040'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F041'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F042'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F043'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F044'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F045'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F046'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F047'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F048'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F049'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F050'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F051'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F052'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F053'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F054'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F055'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F056'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F057'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F058'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F059'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'F060'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STUDENTCODE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INSURANCEKINDID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USERNAME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STUDENTMEMO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMPORTANCETELCOLORS'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HIRANAME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PETNAME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HOMEGUIDE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HISTORY'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLASSDATASTR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SIBLINGSID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONNECTIONGRPID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRIPARENTID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GRADEID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AREAID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EXCARECD1'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EXCAREDEM1'
            Visible = True
          end>
      end
    end
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'AAA'
    ReadOnly = True
    TableName = 'GKHSTM'
    Left = 152
    Top = 32
    object Table1F001: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'F001'
    end
    object Table1F002: TStringField
      DisplayLabel = 'Date'
      FieldName = 'F002'
      Size = 16
    end
    object Table1F003: TStringField
      DisplayLabel = 'ÉJÉiñº'
      FieldName = 'F003'
      Size = 16
    end
    object Table1F004: TStringField
      DisplayLabel = 'ñºëO'
      FieldName = 'F004'
    end
    object Table1F005: TStringField
      FieldName = 'F005'
      Size = 10
    end
    object Table1F006: TStringField
      FieldName = 'F006'
      Size = 10
    end
    object Table1F007: TStringField
      FieldName = 'F007'
      Size = 10
    end
    object Table1F008: TStringField
      FieldName = 'F008'
      Size = 10
    end
    object Table1F009: TStringField
      FieldName = 'F009'
      Size = 30
    end
    object Table1F010: TStringField
      FieldName = 'F010'
      Size = 10
    end
    object Table1F011: TStringField
      FieldName = 'F011'
      Size = 30
    end
    object Table1F012: TSmallintField
      FieldName = 'F012'
    end
    object Table1F013: TIntegerField
      FieldName = 'F013'
    end
    object Table1F014: TSmallintField
      FieldName = 'F014'
    end
    object Table1F015: TIntegerField
      FieldName = 'F015'
    end
    object Table1F016: TIntegerField
      FieldName = 'F016'
    end
    object Table1F017: TIntegerField
      FieldName = 'F017'
    end
    object Table1F018: TIntegerField
      FieldName = 'F018'
    end
    object Table1F019: TSmallintField
      FieldName = 'F019'
    end
    object Table1F020: TIntegerField
      FieldName = 'F020'
    end
    object Table1F021: TSmallintField
      FieldName = 'F021'
    end
    object Table1F022: TIntegerField
      FieldName = 'F022'
    end
    object Table1F023: TIntegerField
      FieldName = 'F023'
    end
    object Table1F024: TStringField
      FieldName = 'F024'
    end
    object Table1F025: TStringField
      FieldName = 'F025'
      Size = 10
    end
    object Table1F026: TSmallintField
      FieldName = 'F026'
    end
    object Table1F027: TStringField
      FieldName = 'F027'
      Size = 13
    end
    object Table1F028: TStringField
      FieldName = 'F028'
      Size = 13
    end
    object Table1F029: TStringField
      FieldName = 'F029'
      Size = 13
    end
    object Table1F030: TStringField
      FieldName = 'F030'
      Size = 64
    end
    object Table1F031: TStringField
      FieldName = 'F031'
      Size = 8
    end
    object Table1F032: TStringField
      FieldName = 'F032'
      Size = 40
    end
    object Table1F033: TStringField
      FieldName = 'F033'
      Size = 30
    end
    object Table1F034: TStringField
      FieldName = 'F034'
      Size = 40
    end
    object Table1F035: TStringField
      FieldName = 'F035'
      Size = 13
    end
    object Table1F036: TSmallintField
      FieldName = 'F036'
    end
    object Table1F037: TIntegerField
      FieldName = 'F037'
    end
    object Table1F038: TSmallintField
      FieldName = 'F038'
    end
    object Table1F039: TStringField
      FieldName = 'F039'
    end
    object Table1F040: TStringField
      FieldName = 'F040'
      Size = 30
    end
    object Table1F041: TStringField
      FieldName = 'F041'
      Size = 30
    end
    object Table1F042: TStringField
      FieldName = 'F042'
      Size = 90
    end
    object Table1F043: TStringField
      FieldName = 'F043'
      Size = 255
    end
    object Table1F044: TStringField
      FieldName = 'F044'
      Size = 255
    end
    object Table1F045: TStringField
      FieldName = 'F045'
      Size = 255
    end
    object Table1F046: TSmallintField
      FieldName = 'F046'
    end
    object Table1F047: TSmallintField
      FieldName = 'F047'
    end
    object Table1F048: TStringField
      FieldName = 'F048'
      Size = 30
    end
    object Table1F049: TStringField
      FieldName = 'F049'
      Size = 30
    end
    object Table1F050: TStringField
      FieldName = 'F050'
    end
    object Table1F051: TStringField
      FieldName = 'F051'
    end
    object Table1F052: TStringField
      FieldName = 'F052'
      Size = 30
    end
    object Table1F053: TStringField
      FieldName = 'F053'
      Size = 30
    end
    object Table1F054: TStringField
      FieldName = 'F054'
      Size = 5
    end
    object Table1F055: TStringField
      FieldName = 'F055'
      Size = 8
    end
    object Table1F056: TStringField
      FieldName = 'F056'
      Size = 16
    end
    object Table1F057: TStringField
      FieldName = 'F057'
      Size = 64
    end
    object Table1F058: TStringField
      FieldName = 'F058'
      Size = 13
    end
    object Table1F059: TIntegerField
      FieldName = 'F059'
    end
    object Table1F060: TSmallintField
      FieldName = 'F060'
    end
    object Table1STUDENTCODE: TStringField
      FieldName = 'STUDENTCODE'
      Size = 10
    end
    object Table1INSURANCEKINDID: TIntegerField
      FieldName = 'INSURANCEKINDID'
    end
    object Table1USERNAME: TStringField
      FieldName = 'USERNAME'
    end
    object Table1STUDENTMEMO: TMemoField
      FieldName = 'STUDENTMEMO'
      BlobType = ftMemo
      Size = 1
    end
    object Table1IMPORTANCETELCOLORS: TMemoField
      FieldName = 'IMPORTANCETELCOLORS'
      BlobType = ftMemo
      Size = 1
    end
    object Table1HIRANAME: TStringField
      FieldName = 'HIRANAME'
      Size = 30
    end
    object Table1PETNAME: TStringField
      FieldName = 'PETNAME'
      Size = 16
    end
    object Table1HOMEGUIDE: TMemoField
      FieldName = 'HOMEGUIDE'
      BlobType = ftMemo
      Size = 1
    end
    object Table1NOTE: TMemoField
      FieldName = 'NOTE'
      BlobType = ftMemo
      Size = 1
    end
    object Table1HISTORY: TMemoField
      FieldName = 'HISTORY'
      BlobType = ftMemo
      Size = 1
    end
    object Table1CLASSDATASTR: TMemoField
      FieldName = 'CLASSDATASTR'
      BlobType = ftMemo
      Size = 1
    end
    object Table1SIBLINGSID: TIntegerField
      FieldName = 'SIBLINGSID'
    end
    object Table1CONNECTIONGRPID: TIntegerField
      FieldName = 'CONNECTIONGRPID'
    end
    object Table1PRIPARENTID: TIntegerField
      FieldName = 'PRIPARENTID'
    end
    object Table1GRADEID: TIntegerField
      FieldName = 'GRADEID'
    end
    object Table1AREAID: TIntegerField
      FieldName = 'AREAID'
    end
    object Table1EXCARECD1: TIntegerField
      FieldName = 'EXCARECD1'
    end
    object Table1EXCAREDEM1: TFloatField
      FieldName = 'EXCAREDEM1'
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 184
    Top = 32
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    LoadEvent = [k0femShow]
    SaveEvent = [k0femClose]
    Items = <
      item
        AccessLevel = k0ialForm
        DefaultValue = '242'
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '514'
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '446'
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '815'
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end
      item
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = JvDBUltimGrid1
        TargetIsOwner = False
        TargetProperty = 'Columns'
        TargetItemProperty = 'Width'
      end
      item
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = JvDBUltimGrid1
        TargetIsOwner = False
        TargetProperty = 'Columns'
        TargetItemProperty = 'FieldName'
      end
      item
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = JvDBUltimGrid1
        TargetIsOwner = False
        TargetProperty = 'Columns'
        TargetItemProperty = 'Visible'
      end
      item
        Keys = [k0iktLoginUserName, k0iktSystem, k0iktApplication, k0iktForm, k0iktInstance]
        TargetComponent = s0PageControl1
        TargetIsOwner = False
        TargetProperty = 'DefaultPageIndex'
      end>
    IniFileName = 'sampleApp1.ini'
    Left = 224
    Top = 32
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 264
    Top = 32
  end
  object s0Database1: Ts0Database
    AliasName = 'GKH_IB'
    Connected = True
    DatabaseName = 'AAA'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey')
    SessionName = 'Default'
    LoginUserName = 'SYSDBA'
    LoginPassword = 'masterkey'
    Left = 124
    Top = 31
  end
end
