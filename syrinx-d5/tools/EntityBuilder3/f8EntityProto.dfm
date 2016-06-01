object frm8EntityProto: Tfrm8EntityProto
  Left = 1
  Top = 663
  Width = 1574
  Height = 480
  Caption = 'frm8EntityProto'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter2: TSplitter
    Left = 0
    Top = 414
    Width = 1566
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 53
    Width = 1566
    Height = 361
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Properties'
      ImageIndex = 3
      object grdFields: Ts0CollectionGrid
        Left = 0
        Top = 0
        Width = 1558
        Height = 334
        CellDrawer.Font.Charset = SHIFTJIS_CHARSET
        CellDrawer.Font.Color = clWindowText
        CellDrawer.Font.Height = -12
        CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        CellDrawer.Font.Style = []
        DoubleBuffered = False
        ColCount = 21
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        Align = alClient
        TabOrder = 0
        OnDblClick = grdFieldsDblClick
        BindSeals = <>
        ReadOnlySeals = <>
        CtrlDecos = <
          item
            Top = 0
            Left = 0
            Right = 19
            Bottom = 4
          end
          item
            Top = 0
            Left = 0
            Right = 19
            Bottom = 4
          end
          item
            Top = 0
            Left = 0
            Right = 19
            Bottom = 4
          end
          item
            Top = 0
            Left = 0
            Right = 20
            Bottom = 4
          end
          item
            Top = 0
            Left = 0
            Right = 20
            Bottom = 4
          end>
        AlignmentDecos = <>
        ColorDecos = <>
        CtrlOfTypeClassName = 'Ts0DefaultGridCtrlOfType'
        CtrlOfType.CtrlClassNameOfEnum = 'Ts0ComboBox'
        CtrlOfType.CtrlClassNameOfSet = 'Ts0CheckListBox'
        MappingColumnBase = True
        Columns = <
          item
            TitleRow = 0
            Width = 16
            UpdateIndex = 1
          end
          item
            Title = 'FieldName'
            TitleRow = 0
            Width = 76
            PropName = 'FieldName'
            UpdateIndex = 19
          end
          item
            Title = 'FieldType'
            TitleRow = 0
            Width = 92
            PropName = 'FieldType'
            UpdateIndex = 0
          end
          item
            Title = 'FieldSize'
            TitleRow = 0
            Width = 54
            PropName = 'FieldSize'
            UpdateIndex = 2
          end
          item
            Title = 'PropertyName'
            TitleRow = 0
            Width = 100
            PropName = 'PropertyName'
            UpdateIndex = 3
          end
          item
            Title = 'TypeName'
            TitleRow = 0
            Width = 100
            PropName = 'TypeName'
            UpdateIndex = 4
          end
          item
            Title = 'JPName'
            TitleRow = 0
            Width = 100
            PropName = 'JPName'
            UpdateIndex = 5
          end
          item
            Title = 'Size'
            TitleRow = 0
            Width = 34
            PropName = 'Size'
            UpdateIndex = 6
          end
          item
            Title = 'IsID'
            TitleRow = 0
            Width = 25
            PropName = 'IsID'
            UpdateIndex = 7
          end
          item
            Title = 'IsCaption'
            TitleRow = 0
            Width = 54
            PropName = 'IsCaption'
            UpdateIndex = 8
          end
          item
            Title = 'IsPersistent'
            TitleRow = 0
            Width = 67
            PropName = 'IsPersistent'
            UpdateIndex = 9
          end
          item
            Title = 'IsRequired'
            TitleRow = 0
            Width = 58
            PropName = 'IsRequired'
            UpdateIndex = 10
          end
          item
            Title = 'IsEnum'
            TitleRow = 0
            Width = 41
            PropName = 'IsEnum'
            UpdateIndex = 11
          end
          item
            Title = 'IsSet'
            TitleRow = 0
            Width = 32
            PropName = 'IsSet'
            UpdateIndex = 12
          end
          item
            Title = 'WithoutCtrl'
            TitleRow = 0
            Width = 62
            PropName = 'WithoutCtrl'
            UpdateIndex = 13
          end
          item
            Title = 'EnumMember'
            TitleRow = 0
            Width = 107
            CanShowObjEditor = False
            PropName = 'EnumMember'
            UpdateIndex = 14
          end
          item
            Title = 'ImeMode'
            TitleRow = 0
            Width = 100
            PropName = 'ImeMode'
            UpdateIndex = 15
          end
          item
            Title = 'AcceptCharTypes'
            TitleRow = 0
            Width = 100
            PropName = 'AcceptCharTypes'
            UpdateIndex = 16
          end
          item
            Title = 'IsNavigator'
            TitleRow = 0
            Width = 62
            PropName = 'IsNavigator'
            UpdateIndex = 17
          end
          item
            Title = 'NaviClassName'
            TitleRow = 0
            Width = 100
            PropName = 'NaviClassName'
            UpdateIndex = 18
          end
          item
            Title = 'EnumName'
            TitleRow = 0
            Width = 100
            PropName = 'EnumName'
            UpdateIndex = 20
          end>
        ColWidths = (
          16
          76
          92
          54
          100
          100
          100
          34
          25
          54
          67
          58
          41
          32
          62
          107
          100
          100
          62
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
          'FieldName'
          2
          0
          'FieldType'
          3
          0
          'FieldSize'
          4
          0
          'PropertyName'
          5
          0
          'TypeName'
          6
          0
          'JPName'
          7
          0
          'Size'
          8
          0
          'IsID'
          9
          0
          'IsCaption'
          10
          0
          'IsPersistent'
          11
          0
          'IsRequired'
          12
          0
          'IsEnum'
          13
          0
          'IsSet'
          14
          0
          'WithoutCtrl'
          15
          0
          'EnumMember'
          16
          0
          'ImeMode'
          17
          0
          'AcceptCharTypes'
          18
          0
          'IsNavigator'
          19
          0
          'NaviClassName'
          20
          0
          'EnumName'
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
          7
          1
          ''
          8
          1
          ''
          9
          1
          ''
          10
          1
          ''
          11
          1
          ''
          12
          1
          ''
          13
          1
          ''
          14
          1
          ''
          15
          1
          ''
          16
          1
          ''
          17
          1
          ''
          18
          1
          ''
          19
          1
          ''
          20
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
          7
          2
          ''
          8
          2
          ''
          9
          2
          ''
          10
          2
          ''
          11
          2
          ''
          12
          2
          ''
          13
          2
          ''
          14
          2
          ''
          15
          2
          ''
          16
          2
          ''
          17
          2
          ''
          18
          2
          ''
          19
          2
          ''
          20
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
          7
          3
          ''
          8
          3
          ''
          9
          3
          ''
          10
          3
          ''
          11
          3
          ''
          12
          3
          ''
          13
          3
          ''
          14
          3
          ''
          15
          3
          ''
          16
          3
          ''
          17
          3
          ''
          18
          3
          ''
          19
          3
          ''
          20
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
          ''
          7
          4
          ''
          8
          4
          ''
          9
          4
          ''
          10
          4
          ''
          11
          4
          ''
          12
          4
          ''
          13
          4
          ''
          14
          4
          ''
          15
          4
          ''
          16
          4
          ''
          17
          4
          ''
          18
          4
          ''
          19
          4
          ''
          20
          4
          '')
        object c0GridCmd_CopyToClipBoard2: Ts0GridCmd_CopyToClipBoard
          Caption = 'ÉRÉsÅ[(&C)'
          ShortCut = 16451
          Target = grdFields
        end
        object c0GridCmd_CutToClipBoard2: Ts0GridCmd_CutToClipBoard
          Caption = 'êÿÇËéÊÇË(&T)'
          ShortCut = 16472
          Target = grdFields
        end
        object c0GridCmd_DeleteSelection2: Ts0GridCmd_DeleteSelection
          Caption = 'çÌèú(&D)'
          ShortCut = 46
          Target = grdFields
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'EnumValue'
      ImageIndex = 3
      OnShow = TabSheet9Show
      object grdEnumValue: Ts0CollectionGrid
        Left = 0
        Top = 0
        Width = 1558
        Height = 334
        CellDrawer.Font.Charset = SHIFTJIS_CHARSET
        CellDrawer.Font.Color = clWindowText
        CellDrawer.Font.Height = -12
        CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
        CellDrawer.Font.Style = []
        DoubleBuffered = False
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
        Align = alClient
        TabOrder = 0
        BindSeals = <>
        ReadOnlySeals = <>
        CtrlDecos = <
          item
            Top = 0
            Left = 2
            Right = 2
            Bottom = 4
            RegionKind = k0gcrCols
            Control = cmbTables
            UpdateEventKinds = [k0cetOnChange]
          end
          item
            Top = 0
            Left = 3
            Right = 4
            Bottom = 4
            RegionKind = k0gcrCols
            Control = cmbFields
            UpdateEventKinds = [k0cetOnChange]
          end>
        AlignmentDecos = <>
        ColorDecos = <>
        CtrlOfTypeClassName = 'Ts0DefaultGridCtrlOfType'
        CtrlOfType.CtrlClassNameOfEnum = 'Ts0ComboBox'
        CtrlOfType.CtrlClassNameOfSet = 'Ts0CheckListBox'
        Columns = <
          item
            TitleRow = 0
            Width = 20
            UpdateIndex = 0
          end
          item
            Title = 'EnumName'
            TitleRow = 0
            Width = 100
            CanShowObjEditor = False
            PropName = 'EnumName'
            UpdateIndex = 1
          end
          item
            Title = 'TanbleName'
            TitleRow = 0
            Width = 100
            CanShowObjEditor = False
            CustomCtrl = True
            PropName = 'TanbleName'
            UpdateIndex = 2
          end
          item
            Title = 'ItemIDField'
            TitleRow = 0
            Width = 100
            CanShowObjEditor = False
            CustomCtrl = True
            PropName = 'ItemIDField'
            UpdateIndex = 3
          end
          item
            Title = 'TextField'
            TitleRow = 0
            Width = 100
            CanShowObjEditor = False
            CustomCtrl = True
            PropName = 'TextField'
            UpdateIndex = 4
          end>
        ColWidths = (
          20
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
          'EnumName'
          2
          0
          'TanbleName'
          3
          0
          'ItemIDField'
          4
          0
          'TextField'
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
      object cmbTables: Ts0ComboBox
        Left = 88
        Top = 40
        Width = 145
        Height = 20
        ItemHeight = 12
        TabOrder = 1
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
      object cmbFields: Ts0ComboBox
        Left = 240
        Top = 40
        Width = 145
        Height = 20
        ItemHeight = 12
        TabOrder = 2
        OnDropDown = cmbFieldsDropDown
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
    end
    object TabSheet3: TTabSheet
      Caption = 'SQL'
      ImageIndex = 2
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 1558
        Height = 334
        ActivePage = TabSheet4
        Align = alClient
        MultiLine = True
        TabOrder = 0
        object TabSheet4: TTabSheet
          Caption = 'selEntities'
          object edtSelEntities: TMemo
            Left = 0
            Top = 0
            Width = 1550
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'selEntity'
          ImageIndex = 1
          object edtSelEntity: TMemo
            Left = 0
            Top = 0
            Width = 1330
            Height = 202
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'insEntity'
          ImageIndex = 2
          object edtInsEntity: TMemo
            Left = 0
            Top = 0
            Width = 1330
            Height = 202
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'updEntity'
          ImageIndex = 3
          object edtUpdEntity: TMemo
            Left = 0
            Top = 0
            Width = 1532
            Height = 324
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'delEntity'
          ImageIndex = 4
          object edtDelEntity: TMemo
            Left = 0
            Top = 0
            Width = 1330
            Height = 202
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'SourceCode'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 169
        Top = 0
        Width = 3
        Height = 334
        Cursor = crHSplit
      end
      object pgSourceCodes: TPageControl
        Left = 172
        Top = 0
        Width = 1386
        Height = 334
        ActivePage = pageListFormDfm
        Align = alClient
        MultiLine = True
        TabOrder = 0
        object pageEntityPas: TTabSheet
          Caption = 'pageEntityPas'
          object dspEntityPas: TMemo
            Left = 0
            Top = 0
            Width = 1378
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object pageDMPas: TTabSheet
          Caption = 'pageDMPas'
          ImageIndex = 1
          object dspDMPas: TMemo
            Left = 0
            Top = 0
            Width = 1378
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object pageDMDfm: TTabSheet
          Caption = 'pageDMDfm'
          ImageIndex = 2
          object dspDMDfm: TMemo
            Left = 0
            Top = 0
            Width = 1378
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object pageDetailFormPas: TTabSheet
          Caption = 'pageDetailFormPas'
          ImageIndex = 3
          object dspDetailFormPas: TMemo
            Left = 0
            Top = 0
            Width = 1378
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object pageDetailFormDfm: TTabSheet
          Caption = 'pageDetailFormDfm'
          ImageIndex = 4
          object dspDetailFormDfm: TMemo
            Left = 0
            Top = 0
            Width = 1378
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object pageListFormPas: TTabSheet
          Caption = 'pageListFormPas'
          ImageIndex = 5
          object dspListFormPas: TMemo
            Left = 0
            Top = 0
            Width = 1378
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object pageListFormDfm: TTabSheet
          Caption = 'pageListFormDfm'
          ImageIndex = 6
          object dspListFormDfm: TMemo
            Left = 0
            Top = 0
            Width = 1378
            Height = 307
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS UI Gothic'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
      end
      object CheckListBox1: TCheckListBox
        Left = 0
        Top = 0
        Width = 169
        Height = 334
        Align = alLeft
        ItemHeight = 12
        TabOrder = 1
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Table'
      ImageIndex = 4
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 1558
        Height = 334
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        object lblFieldDefs1: Ts0Label
          Left = 12
          Top = 9
          Width = 49
          Height = 12
          Caption = 'FieldDefs'
          FocusControl = grdFieldDefs1
        end
        object lblIndexDefs1: Ts0Label
          Left = 12
          Top = 194
          Width = 51
          Height = 12
          Anchors = [akLeft, akBottom]
          Caption = 'IndexDefs'
          FocusControl = grdIndexDefs1
        end
        object lblTableType1: Ts0Label
          Left = 12
          Top = 317
          Width = 53
          Height = 12
          Anchors = [akLeft, akBottom]
          Caption = 'TableType'
          FocusControl = cmbTableType1
        end
        object chkDefaultIndex1: Ts0CheckBox
          Left = 100
          Top = 0
          Width = -100
          Height = 0
          Anchors = [akLeft, akBottom]
          Caption = 'DefaultIndex'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object chkExclusive1: Ts0CheckBox
          Left = 100
          Top = 0
          Width = -100
          Height = 0
          Anchors = [akLeft, akBottom]
          Caption = 'Exclusive'
          TabOrder = 4
        end
        object grdFieldDefs1: Ts0CollectionGrid
          Left = 100
          Top = 0
          Width = -100
          Height = 0
          CellDrawer.Font.Charset = SHIFTJIS_CHARSET
          CellDrawer.Font.Color = clWindowText
          CellDrawer.Font.Height = -12
          CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
          CellDrawer.Font.Style = []
          DoubleBuffered = False
          ColCount = 7
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          BindSeals = <>
          ReadOnlySeals = <>
          CtrlDecos = <
            item
              Top = 0
              Left = 1
              Right = 1
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0Edit64
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 2
              Right = 2
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0CheckListBox19
              UpdateEventKinds = [k0cetOnClick, k0cetOnPressEnter]
            end
            item
              Top = 0
              Left = 3
              Right = 3
              Bottom = 1
              RegionKind = k0gcrCols
            end
            item
              Top = 0
              Left = 4
              Right = 4
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0ComboBox10
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 5
              Right = 5
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0DigitEdit28
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 6
              Right = 6
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0DigitEdit29
              UpdateEventKinds = [k0cetOnChange]
            end>
          AlignmentDecos = <>
          ColorDecos = <>
          CtrlOfTypeClassName = 'Ts0DefaultGridCtrlOfType'
          CtrlOfType.CtrlClassNameOfEnum = 'Ts0ComboBox'
          CtrlOfType.CtrlClassNameOfSet = 'Ts0CheckListBox'
          Columns = <
            item
              TitleRow = 0
              Width = 20
              UpdateIndex = 1
            end
            item
              Title = 'Name'
              TitleRow = 0
              Width = 100
              PropName = 'Name'
              UpdateIndex = 0
            end
            item
              Title = 'Attributes'
              TitleRow = 0
              Width = 100
              PropName = 'Attributes'
              UpdateIndex = 2
            end
            item
              DefaultValue = '(nil)'
              Title = 'ChildDefs'
              TitleRow = 0
              Width = 100
              PropName = 'ChildDefs'
              UpdateIndex = 3
            end
            item
              DefaultValue = 'ftUnknown'
              Title = 'DataType'
              TitleRow = 0
              Width = 100
              PropName = 'DataType'
              UpdateIndex = 4
            end
            item
              DefaultValue = '0'
              Title = 'Precision'
              TitleRow = 0
              Width = 100
              PropName = 'Precision'
              UpdateIndex = 5
            end
            item
              DefaultValue = '0'
              Title = 'Size'
              TitleRow = 0
              Width = 100
              PropName = 'Size'
              UpdateIndex = 6
            end>
          ColWidths = (
            20
            100
            100
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
            'Name'
            2
            0
            'Attributes'
            3
            0
            'ChildDefs'
            4
            0
            'DataType'
            5
            0
            'Precision'
            6
            0
            'Size'
            0
            1
            ''
            1
            1
            's0Table1Field1'
            2
            1
            ''
            3
            1
            ''
            4
            1
            'ftUnknown'
            5
            1
            '0'
            6
            1
            '0')
        end
        object grdIndexDefs1: Ts0CollectionGrid
          Left = 100
          Top = 0
          Width = -100
          Height = 0
          CellDrawer.Font.Charset = SHIFTJIS_CHARSET
          CellDrawer.Font.Color = clWindowText
          CellDrawer.Font.Height = -12
          CellDrawer.Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
          CellDrawer.Font.Style = []
          DoubleBuffered = False
          ColCount = 9
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 1
          BindSeals = <>
          ReadOnlySeals = <>
          CtrlDecos = <
            item
              Top = 0
              Left = 1
              Right = 1
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0Edit65
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 2
              Right = 2
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0Edit66
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 3
              Right = 3
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0Edit67
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 4
              Right = 4
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0Edit68
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 5
              Right = 5
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0Edit69
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 6
              Right = 6
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0CheckListBox20
              UpdateEventKinds = [k0cetOnClick, k0cetOnPressEnter]
            end
            item
              Top = 0
              Left = 7
              Right = 7
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0Edit70
              UpdateEventKinds = [k0cetOnChange]
            end
            item
              Top = 0
              Left = 8
              Right = 8
              Bottom = 1
              RegionKind = k0gcrCols
              Control = s0DigitEdit30
              UpdateEventKinds = [k0cetOnChange]
            end>
          AlignmentDecos = <>
          ColorDecos = <>
          CtrlOfTypeClassName = 'Ts0DefaultGridCtrlOfType'
          CtrlOfType.CtrlClassNameOfEnum = 'Ts0ComboBox'
          CtrlOfType.CtrlClassNameOfSet = 'Ts0CheckListBox'
          Columns = <
            item
              TitleRow = 0
              Width = 20
              UpdateIndex = 1
            end
            item
              Title = 'Name'
              TitleRow = 0
              Width = 100
              PropName = 'Name'
              UpdateIndex = 0
            end
            item
              Title = 'CaseInsFields'
              TitleRow = 0
              Width = 100
              PropName = 'CaseInsFields'
              UpdateIndex = 2
            end
            item
              Title = 'DescFields'
              TitleRow = 0
              Width = 100
              PropName = 'DescFields'
              UpdateIndex = 3
            end
            item
              Title = 'Expression'
              TitleRow = 0
              Width = 100
              PropName = 'Expression'
              UpdateIndex = 4
            end
            item
              Title = 'Fields'
              TitleRow = 0
              Width = 100
              PropName = 'Fields'
              UpdateIndex = 5
            end
            item
              Title = 'Options'
              TitleRow = 0
              Width = 100
              PropName = 'Options'
              UpdateIndex = 6
            end
            item
              Title = 'Source'
              TitleRow = 0
              Width = 100
              PropName = 'Source'
              UpdateIndex = 7
            end
            item
              DefaultValue = '0'
              Title = 'GroupingLevel'
              TitleRow = 0
              Width = 100
              PropName = 'GroupingLevel'
              UpdateIndex = 8
            end>
          ColWidths = (
            20
            100
            100
            100
            100
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
            'Name'
            2
            0
            'CaseInsFields'
            3
            0
            'DescFields'
            4
            0
            'Expression'
            5
            0
            'Fields'
            6
            0
            'Options'
            7
            0
            'Source'
            8
            0
            'GroupingLevel'
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
            7
            1
            ''
            8
            1
            '0')
        end
        object cmbTableType1: Ts0ComboBox
          Left = 100
          Top = 0
          Width = 0
          Height = 0
          Style = csDropDownList
          Anchors = [akLeft, akBottom]
          ItemHeight = 12
          TabOrder = 2
          Items.Strings = (
            'ttDefault'
            'ttParadox'
            'ttDBase'
            'ttFoxPro'
            'ttASCII')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          InputStyle.TitleDisplay = lblTableType1
          ItemIndex = -1
          ReadOnly = False
          TitleDisplay = lblTableType1
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            0
            2
            0
            3
            0
            4
            0)
        end
        object s0Edit1: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 5
          Text = 's0Edit1'
          Visible = False
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
        end
        object s0CheckListBox1: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 6
          Visible = False
        end
        object s0ComboBox1: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 7
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit1: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 8
          Text = '0'
          Visible = False
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
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 9
          Text = '0'
          Visible = False
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
        object s0Edit2: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 10
          Text = 's0Edit2'
          Visible = False
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
        end
        object s0Edit3: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 11
          Text = 's0Edit3'
          Visible = False
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
        end
        object s0Edit4: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 12
          Text = 's0Edit4'
          Visible = False
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
        end
        object s0Edit5: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 13
          Text = 's0Edit5'
          Visible = False
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
        end
        object s0Edit6: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 14
          Text = 's0Edit6'
          Visible = False
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
        end
        object s0CheckListBox2: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 15
          Visible = False
        end
        object s0Edit7: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 16
          Text = 's0Edit7'
          Visible = False
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
        end
        object s0DigitEdit3: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 17
          Text = '0'
          Visible = False
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
        object s0Edit8: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 18
          Text = 's0Edit8'
          Visible = False
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
        end
        object s0CheckListBox3: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 19
          Visible = False
        end
        object s0ComboBox2: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 20
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit4: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 21
          Text = '0'
          Visible = False
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
        object s0DigitEdit5: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 22
          Text = '0'
          Visible = False
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
        object s0Edit9: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 23
          Text = 's0Edit9'
          Visible = False
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
        end
        object s0Edit10: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 24
          Text = 's0Edit10'
          Visible = False
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
        end
        object s0Edit11: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 25
          Text = 's0Edit11'
          Visible = False
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
        end
        object s0Edit12: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 26
          Text = 's0Edit12'
          Visible = False
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
        end
        object s0Edit13: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 27
          Text = 's0Edit13'
          Visible = False
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
        end
        object s0CheckListBox4: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 28
          Visible = False
        end
        object s0Edit14: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 29
          Text = 's0Edit14'
          Visible = False
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
        end
        object s0DigitEdit6: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 30
          Text = '0'
          Visible = False
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
        object s0Edit15: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 31
          Text = 's0Edit15'
          Visible = False
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
        end
        object s0CheckListBox5: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 32
          Visible = False
        end
        object s0ComboBox3: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 33
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit7: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 34
          Text = '0'
          Visible = False
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
        object s0DigitEdit8: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 35
          Text = '0'
          Visible = False
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
        object s0Edit16: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 36
          Text = 's0Edit16'
          Visible = False
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
        end
        object s0Edit17: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 37
          Text = 's0Edit17'
          Visible = False
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
        end
        object s0Edit18: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 38
          Text = 's0Edit18'
          Visible = False
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
        end
        object s0Edit19: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 39
          Text = 's0Edit19'
          Visible = False
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
        end
        object s0Edit20: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 40
          Text = 's0Edit20'
          Visible = False
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
        end
        object s0CheckListBox6: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 41
          Visible = False
        end
        object s0Edit21: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 42
          Text = 's0Edit21'
          Visible = False
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
        end
        object s0DigitEdit9: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 43
          Text = '0'
          Visible = False
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
        object s0Edit22: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 44
          Text = 's0Edit22'
          Visible = False
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
        end
        object s0CheckListBox7: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 45
          Visible = False
        end
        object s0ComboBox4: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 46
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit10: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 47
          Text = '0'
          Visible = False
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
        object s0DigitEdit11: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 48
          Text = '0'
          Visible = False
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
        object s0Edit23: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 49
          Text = 's0Edit23'
          Visible = False
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
        end
        object s0Edit24: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 50
          Text = 's0Edit24'
          Visible = False
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
        end
        object s0Edit25: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 51
          Text = 's0Edit25'
          Visible = False
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
        end
        object s0Edit26: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 52
          Text = 's0Edit26'
          Visible = False
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
        end
        object s0Edit27: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 53
          Text = 's0Edit27'
          Visible = False
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
        end
        object s0CheckListBox8: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 54
          Visible = False
        end
        object s0Edit28: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 55
          Text = 's0Edit28'
          Visible = False
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
        end
        object s0DigitEdit12: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 56
          Text = '0'
          Visible = False
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
        object s0Edit29: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 57
          Text = 's0Edit29'
          Visible = False
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
        end
        object s0CheckListBox9: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 58
          Visible = False
        end
        object s0ComboBox5: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 59
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit13: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 60
          Text = '0'
          Visible = False
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
        object s0DigitEdit14: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 61
          Text = '0'
          Visible = False
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
        object s0Edit30: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 62
          Text = 's0Edit30'
          Visible = False
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
        end
        object s0Edit31: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 63
          Text = 's0Edit31'
          Visible = False
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
        end
        object s0Edit32: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 64
          Text = 's0Edit32'
          Visible = False
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
        end
        object s0Edit33: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 65
          Text = 's0Edit33'
          Visible = False
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
        end
        object s0Edit34: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 66
          Text = 's0Edit34'
          Visible = False
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
        end
        object s0CheckListBox10: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 67
          Visible = False
        end
        object s0Edit35: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 68
          Text = 's0Edit35'
          Visible = False
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
        end
        object s0DigitEdit15: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 69
          Text = '0'
          Visible = False
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
        object s0Edit36: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 70
          Text = 's0Edit36'
          Visible = False
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
        end
        object s0CheckListBox11: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 71
          Visible = False
        end
        object s0ComboBox6: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 72
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit16: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 73
          Text = '0'
          Visible = False
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
        object s0DigitEdit17: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 74
          Text = '0'
          Visible = False
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
        object s0Edit37: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 75
          Text = 's0Edit37'
          Visible = False
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
        end
        object s0Edit38: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 76
          Text = 's0Edit38'
          Visible = False
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
        end
        object s0Edit39: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 77
          Text = 's0Edit39'
          Visible = False
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
        end
        object s0Edit40: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 78
          Text = 's0Edit40'
          Visible = False
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
        end
        object s0Edit41: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 79
          Text = 's0Edit41'
          Visible = False
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
        end
        object s0CheckListBox12: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 80
          Visible = False
        end
        object s0Edit42: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 81
          Text = 's0Edit42'
          Visible = False
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
        end
        object s0DigitEdit18: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 82
          Text = '0'
          Visible = False
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
        object s0Edit43: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 83
          Text = 's0Edit43'
          Visible = False
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
        end
        object s0CheckListBox13: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 84
          Visible = False
        end
        object s0ComboBox7: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 85
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit19: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 86
          Text = '0'
          Visible = False
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
        object s0DigitEdit20: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 87
          Text = '0'
          Visible = False
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
        object s0Edit44: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 88
          Text = 's0Edit44'
          Visible = False
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
        end
        object s0Edit45: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 89
          Text = 's0Edit45'
          Visible = False
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
        end
        object s0Edit46: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 90
          Text = 's0Edit46'
          Visible = False
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
        end
        object s0Edit47: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 91
          Text = 's0Edit47'
          Visible = False
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
        end
        object s0Edit48: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 92
          Text = 's0Edit48'
          Visible = False
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
        end
        object s0CheckListBox14: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 93
          Visible = False
        end
        object s0Edit49: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 94
          Text = 's0Edit49'
          Visible = False
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
        end
        object s0DigitEdit21: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 95
          Text = '0'
          Visible = False
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
        object s0Edit50: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 96
          Text = 's0Edit50'
          Visible = False
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
        end
        object s0CheckListBox15: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 97
          Visible = False
        end
        object s0ComboBox8: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 98
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit22: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 99
          Text = '0'
          Visible = False
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
        object s0DigitEdit23: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 100
          Text = '0'
          Visible = False
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
        object s0Edit51: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 101
          Text = 's0Edit51'
          Visible = False
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
        end
        object s0Edit52: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 102
          Text = 's0Edit52'
          Visible = False
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
        end
        object s0Edit53: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 103
          Text = 's0Edit53'
          Visible = False
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
        end
        object s0Edit54: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 104
          Text = 's0Edit54'
          Visible = False
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
        end
        object s0Edit55: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 105
          Text = 's0Edit55'
          Visible = False
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
        end
        object s0CheckListBox16: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 106
          Visible = False
        end
        object s0Edit56: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 107
          Text = 's0Edit56'
          Visible = False
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
        end
        object s0DigitEdit24: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 108
          Text = '0'
          Visible = False
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
        object s0Edit57: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 109
          Text = 's0Edit57'
          Visible = False
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
        end
        object s0CheckListBox17: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 110
          Visible = False
        end
        object s0ComboBox9: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 111
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit25: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 112
          Text = '0'
          Visible = False
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
        object s0DigitEdit26: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 113
          Text = '0'
          Visible = False
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
        object s0Edit58: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 114
          Text = 's0Edit58'
          Visible = False
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
        end
        object s0Edit59: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 115
          Text = 's0Edit59'
          Visible = False
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
        end
        object s0Edit60: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 116
          Text = 's0Edit60'
          Visible = False
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
        end
        object s0Edit61: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 117
          Text = 's0Edit61'
          Visible = False
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
        end
        object s0Edit62: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 118
          Text = 's0Edit62'
          Visible = False
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
        end
        object s0CheckListBox18: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 12
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 119
          Visible = False
        end
        object s0Edit63: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 120
          Text = 's0Edit63'
          Visible = False
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
        end
        object s0DigitEdit27: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 121
          Text = '0'
          Visible = False
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
        object s0Edit64: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 122
          Text = 's0Edit64'
          Visible = False
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
        end
        object s0CheckListBox19: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 16
          Items.Strings = (
            'faHiddenCol'
            'faReadonly'
            'faRequired'
            'faLink'
            'faUnNamed'
            'faFixed')
          TabOrder = 123
          Visible = False
        end
        object s0ComboBox10: Ts0ComboBox
          Left = 0
          Top = -100
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 124
          Text = 'ftUnknown'
          Visible = False
          Items.Strings = (
            'ftUnknown'
            'ftString'
            'ftSmallint'
            'ftInteger'
            'ftWord'
            'ftBoolean'
            'ftFloat'
            'ftCurrency'
            'ftBCD'
            'ftDate'
            'ftTime'
            'ftDateTime'
            'ftBytes'
            'ftVarBytes'
            'ftAutoInc'
            'ftBlob'
            'ftMemo'
            'ftGraphic'
            'ftFmtMemo'
            'ftParadoxOle'
            'ftDBaseOle'
            'ftTypedBinary'
            'ftCursor'
            'ftFixedChar'
            'ftWideString'
            'ftLargeint'
            'ftADT'
            'ftArray'
            'ftReference'
            'ftDataSet'
            'ftOraBlob'
            'ftOraClob'
            'ftVariant'
            'ftInterface'
            'ftIDispatch'
            'ftGuid')
          AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
          Accessor.AsIntegerKind = k0saikFromObjects
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
          ItemIndex = 0
          ReadOnly = False
          ItemObjVersion = 100
          ItemObjectsAsInt = (
            0
            0
            1
            1
            2
            2
            3
            3
            4
            4
            5
            5
            6
            6
            7
            7
            8
            8
            9
            9
            10
            10
            11
            11
            12
            12
            13
            13
            14
            14
            15
            15
            16
            16
            17
            17
            18
            18
            19
            19
            20
            20
            21
            21
            22
            22
            23
            23
            24
            24
            25
            25
            26
            26
            27
            27
            28
            28
            29
            29
            30
            30
            31
            31
            32
            32
            33
            33
            34
            34
            35
            35)
        end
        object s0DigitEdit28: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 125
          Text = '0'
          Visible = False
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
        object s0DigitEdit29: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 126
          Text = '0'
          Visible = False
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
        object s0Edit65: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 127
          Text = 's0Edit65'
          Visible = False
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
        end
        object s0Edit66: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 128
          Text = 's0Edit66'
          Visible = False
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
        end
        object s0Edit67: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 129
          Text = 's0Edit67'
          Visible = False
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
        end
        object s0Edit68: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 130
          Text = 's0Edit68'
          Visible = False
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
        end
        object s0Edit69: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 131
          Text = 's0Edit69'
          Visible = False
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
        end
        object s0CheckListBox20: Ts0CheckListBox
          Left = 0
          Top = -100
          Width = 121
          Height = 97
          BorderStyle = bsNone
          ItemHeight = 16
          Items.Strings = (
            'ixPrimary'
            'ixUnique'
            'ixDescending'
            'ixCaseInsensitive'
            'ixExpression'
            'ixNonMaintained')
          TabOrder = 132
          Visible = False
        end
        object s0Edit70: Ts0Edit
          Left = 0
          Top = -100
          Width = 121
          Height = 20
          BorderStyle = bsNone
          TabOrder = 133
          Text = 's0Edit70'
          Visible = False
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
        end
        object s0DigitEdit30: Ts0DigitEdit
          Left = 0
          Top = -100
          Width = 48
          Height = 20
          BorderStyle = bsNone
          ImeMode = imClose
          TabOrder = 134
          Text = '0'
          Visible = False
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
      end
    end
  end
  object dspMsg: TMemo
    Left = 0
    Top = 417
    Width = 1566
    Height = 36
    TabStop = False
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 1566
    Height = 53
    AutoSize = True
    Bands = <
      item
        Control = s0MenuBar1
        ImageIndex = -1
        MinHeight = 22
        Width = 1562
      end
      item
        Control = Panel1
        ImageIndex = -1
        Width = 1562
      end>
    object s0MenuBar1: Ts0MenuBar
      Left = 9
      Top = 0
      Width = 1549
      Height = 22
      ButtonHeight = 20
      ButtonWidth = 70
      Caption = 's0MenuBar1'
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      Menu = MainMenu1
      ShowText = False
    end
    object Panel1: TPanel
      Left = 9
      Top = 24
      Width = 1549
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object s0Button1: Ts0Button
        Left = 0
        Top = 0
        Width = 120
        Height = 25
        Action = actGenerateSQLs
        TabOrder = 0
        Align = alLeft
      end
      object s0Button2: Ts0Button
        Left = 120
        Top = 0
        Width = 120
        Height = 25
        Action = actGenerateSource
        TabOrder = 1
        Align = alLeft
      end
      object s0Button3: Ts0Button
        Left = 240
        Top = 0
        Width = 120
        Height = 25
        Action = actWriteFiles
        TabOrder = 2
        Align = alLeft
      end
      object s0Button4: Ts0Button
        Left = 377
        Top = 0
        Width = 144
        Height = 25
        Action = actLoadFields
        TabOrder = 4
        Align = alLeft
      end
      object s0Button5: Ts0Button
        Left = 1482
        Top = 0
        Width = 67
        Height = 25
        Action = actClose
        TabOrder = 6
        Align = alRight
      end
      object Panel2: TPanel
        Left = 360
        Top = 0
        Width = 17
        Height = 25
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
      end
      object s0Button6: Ts0Button
        Left = 521
        Top = 0
        Width = 128
        Height = 25
        Action = actCreateTable
        TabOrder = 5
        Align = alLeft
      end
    end
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 116
    Top = 71
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        DefaultValue = '45'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        DefaultValue = '106'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        DefaultValue = '393'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        DefaultValue = '1088'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end>
    SystemName = 'EB'
    ApplicationName = 'Builder'
    IniFileName = 'EtyBld.ini'
    Left = 84
    Top = 71
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 136
    object File1: TMenuItem
      Caption = 'ÉtÉ@ÉCÉã(&F)'
      object actGenerateSource1: TMenuItem
        Action = actGenerateSource
      end
      object actWriteFiles1: TMenuItem
        Action = actWriteFiles
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object DB1: TMenuItem
      Caption = '&DB'
      object actGenerateSQLs1: TMenuItem
        Action = actGenerateSQLs
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object L1: TMenuItem
        Action = actLoadFields
      end
      object actCreateTable1: TMenuItem
        Action = actCreateTable
      end
    end
  end
  object ActionList1: TActionList
    Left = 48
    Top = 136
    object actCreateTable: TAction
      Category = 'DB'
      Caption = 'ÉeÅ[ÉuÉãÇÃê∂ê¨(&T)'
      OnExecute = actCreateTableExecute
    end
    object actGenerateSQLs: TAction
      Category = 'DB'
      Caption = 'SQLÇÃê∂ê¨(&S)'
      OnExecute = actGenerateSQLsExecute
    end
    object actGenerateSource: TAction
      Category = 'File'
      Caption = 'É\Å[ÉXÉRÅ[ÉhÇÃê∂ê¨(&C)'
      OnExecute = actGenerateSourceExecute
    end
    object actWriteFiles: TAction
      Category = 'File'
      Caption = 'ÉtÉ@ÉCÉãÇÃï€ë∂(&S)'
      OnExecute = actWriteFilesExecute
    end
    object actClose: TAction
      Category = 'File'
      Caption = 'ï¬Ç∂ÇÈ(&X)'
      OnExecute = actCloseExecute
    end
    object actLoadFields: TAction
      Category = 'DB'
      Caption = 'ÉtÉBÅ[ÉãÉhÇÃì«Ç›çûÇ›Åi&L)'
      OnExecute = actLoadFieldsExecute
    end
  end
  object s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl
    Builder.CtrlOwner = Owner
    Builder.CtrlParent = ScrollBox1
    Builder.CtrlPrefixes = <
      item
        PartOfCtrlClassName = 'CheckBox'
        Prefix = 'chk'
      end
      item
        PartOfCtrlClassName = 'DigitEdit'
        Prefix = 'dged'
      end
      item
        PartOfCtrlClassName = 'DateEdit'
        Prefix = 'dted'
      end
      item
        PartOfCtrlClassName = 'Edit'
        Prefix = 'edt'
      end
      item
        PartOfCtrlClassName = 'Memo'
        Prefix = 'mmo'
      end
      item
        PartOfCtrlClassName = 'ComboBox'
        Prefix = 'cmb'
      end
      item
        PartOfCtrlClassName = 'RadioGroup'
        Prefix = 'rgp'
      end
      item
        PartOfCtrlClassName = 'CheckListBox'
        Prefix = 'clb'
      end
      item
        PartOfCtrlClassName = 'Label'
        Prefix = 'lbl'
      end
      item
        PartOfCtrlClassName = 'Button'
        Prefix = 'btn'
      end
      item
        PartOfCtrlClassName = 'ListBox'
        Prefix = 'lst'
      end
      item
        PartOfCtrlClassName = 'Grid'
        Prefix = 'grd'
      end>
    Builder.CtrlOfTypeClassName = 'Ts0COTEtyCtrls'
    DisabledProps.Strings = (
      'Name'
      'Tag')
    ProtoTypes = <
      item
        PropertyName = 'DefaultIndex'
        TypeName = 'Boolean'
        JPName = 'DefaultIndex'
        Size = 0
        ImeModeSX = k0imDisable
        ImeMode = imDisable
        IsEnum = True
        EnumMember.Strings = (
          'False'
          'True')
        AutoUpdateKinds = [k0cetOnClick]
        Ctrl = chkDefaultIndex1
        CtrlBounds.Left = 0
        CtrlBounds.Top = 0
        CtrlBounds.Width = 0
        CtrlBounds.Height = 0
        CtrlClassName = 'Ts0CheckBox'
        EnumAsString = False
      end
      item
        PropertyName = 'Exclusive'
        TypeName = 'Boolean'
        JPName = 'Exclusive'
        Size = 0
        ImeModeSX = k0imDisable
        ImeMode = imDisable
        IsEnum = True
        EnumMember.Strings = (
          'False'
          'True')
        AutoUpdateKinds = [k0cetOnClick]
        Ctrl = chkExclusive1
        CtrlBounds.Left = 0
        CtrlBounds.Top = 0
        CtrlBounds.Width = 0
        CtrlBounds.Height = 0
        CtrlClassName = 'Ts0CheckBox'
        EnumAsString = False
      end
      item
        PropertyName = 'FieldDefs'
        TypeName = 'TFieldDefs'
        JPName = 'FieldDefs'
        Size = 0
        ImeModeSX = k0imDisable
        ImeMode = imDisable
        IsPersistent = True
        AutoUpdateKinds = [k0cetOnExit, k0cetOnPressEnter]
        Ctrl = grdFieldDefs1
        CtrlBounds.Left = 0
        CtrlBounds.Top = 0
        CtrlBounds.Width = 0
        CtrlBounds.Height = 0
        CtrlClassName = 'Ts0Memo'
        CtrlLabel = lblFieldDefs1
        EnumAsString = False
      end
      item
        PropertyName = 'IndexDefs'
        TypeName = 'TIndexDefs'
        JPName = 'IndexDefs'
        Size = 0
        ImeModeSX = k0imDisable
        ImeMode = imDisable
        IsPersistent = True
        AutoUpdateKinds = [k0cetOnExit, k0cetOnPressEnter]
        Ctrl = grdIndexDefs1
        CtrlBounds.Left = 0
        CtrlBounds.Top = 0
        CtrlBounds.Width = 0
        CtrlBounds.Height = 0
        CtrlClassName = 'Ts0Memo'
        CtrlLabel = lblIndexDefs1
        EnumAsString = False
      end
      item
        PropertyName = 'TableType'
        TypeName = 'TTableType'
        JPName = 'TableType'
        Size = 0
        ImeModeSX = k0imDisable
        ImeMode = imDisable
        IsEnum = True
        EnumMember.Strings = (
          'ttDefault'
          'ttParadox'
          'ttDBase'
          'ttFoxPro'
          'ttASCII')
        AutoUpdateKinds = [k0cetOnChange]
        Ctrl = cmbTableType1
        CtrlBounds.Left = 0
        CtrlBounds.Top = 0
        CtrlBounds.Width = 0
        CtrlBounds.Height = 0
        CtrlClassName = 'Ts0ComboBox'
        CtrlLabel = lblTableType1
        EnumAsString = False
      end>
    TargetComponent = s0Table1
    ProtoSourcePropName = 'ProtoTypes'
    Left = 180
    Top = 68
  end
  object s0Table1: Ts0Table
    FieldDefs = <
      item
        Name = 's0Table1Field1'
      end>
    StoreDefs = True
    Left = 148
    Top = 68
  end
end
