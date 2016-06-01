object frm8SrcReplacer: Tfrm8SrcReplacer
  Left = 40
  Top = 199
  Width = 860
  Height = 601
  Caption = 'Source Replacer'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ＭＳ Ｐゴシック'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 233
    Top = 53
    Width = 3
    Height = 521
    Cursor = crHSplit
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 852
    Height = 53
    AutoSize = True
    Bands = <
      item
        Control = s0MenuBar1
        ImageIndex = -1
        MinHeight = 21
        Width = 848
      end
      item
        Control = Panel1
        ImageIndex = -1
        MinHeight = 26
        Width = 848
      end>
    object s0MenuBar1: Ts0MenuBar
      Left = 9
      Top = 0
      Width = 835
      Height = 21
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
      Top = 23
      Width = 835
      Height = 26
      BevelOuter = bvNone
      TabOrder = 1
      object s0Button1: Ts0Button
        Left = 0
        Top = 0
        Width = 120
        Height = 26
        Action = actOpenReplaceText
        TabOrder = 0
        Align = alLeft
      end
      object s0Button2: Ts0Button
        Left = 120
        Top = 0
        Width = 120
        Height = 26
        Action = actFindFiles
        TabOrder = 1
        Align = alLeft
      end
      object s0Button3: Ts0Button
        Left = 240
        Top = 0
        Width = 120
        Height = 26
        Action = actFindBeforeReplace
        TabOrder = 2
        Align = alLeft
      end
      object s0Button4: Ts0Button
        Left = 360
        Top = 0
        Width = 120
        Height = 26
        Action = actExecReplace
        TabOrder = 3
        Align = alLeft
      end
      object s0Button5: Ts0Button
        Left = 480
        Top = 0
        Width = 120
        Height = 26
        Action = actReplaceFileNames
        TabOrder = 4
        Align = alLeft
      end
    end
  end
  object Panel3: TPanel
    Left = 236
    Top = 53
    Width = 616
    Height = 521
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel3'
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 0
      Top = 421
      Width = 616
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object Memo1: TMemo
      Left = 0
      Top = 424
      Width = 616
      Height = 97
      TabStop = False
      Align = alBottom
      ParentColor = True
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object PageControl2: TPageControl
      Left = 0
      Top = 0
      Width = 616
      Height = 421
      ActivePage = TabSheet5
      Align = alClient
      TabOrder = 1
      object TabSheet4: TTabSheet
        Caption = '対象ファイル'
        object CheckListBox1: TCheckListBox
          Left = 0
          Top = 0
          Width = 608
          Height = 394
          OnClickCheck = CheckListBox1ClickCheck
          Align = alClient
          ItemHeight = 12
          TabOrder = 0
        end
      end
      object TabSheet5: TTabSheet
        Caption = '置換'
        ImageIndex = 1
        object grdReplaceLines: Ts0CollectionGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 394
          CellDrawer.Font.Charset = SHIFTJIS_CHARSET
          CellDrawer.Font.Color = clWindowText
          CellDrawer.Font.Height = -12
          CellDrawer.Font.Name = 'ＭＳ Ｐゴシック'
          CellDrawer.Font.Style = []
          DefaultColWidth = 30
          DoubleBuffered = False
          ColCount = 6
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
          Align = alClient
          TabOrder = 0
          BindSeals = <>
          ReadOnlySeals = <>
          CtrlDecos = <>
          AlignmentDecos = <>
          ColorDecos = <>
          CtrlOfTypeClassName = 'Ts0DefaultGridCtrlOfType'
          CtrlOfType.CtrlClassNameOfEnum = 'Ts0ComboBox'
          CtrlOfType.CtrlClassNameOfSet = 'Ts0CheckListBox'
          Columns = <
            item
              TitleRow = 0
              Width = 30
              UpdateIndex = 0
            end
            item
              Title = '置換'
              TitleRow = 0
              Width = 145
              UpdateIndex = 1
            end
            item
              Title = 'ファイル名'
              TitleRow = 0
              Width = 67
              UpdateIndex = 2
            end
            item
              Title = '行'
              TitleRow = 0
              Width = 39
              UpdateIndex = 3
            end
            item
              Title = '置換前'
              TitleRow = 0
              Width = 119
              UpdateIndex = 4
            end
            item
              Title = '置換後'
              TitleRow = 0
              Width = 159
              UpdateIndex = 5
            end>
          ColWidths = (
            30
            145
            67
            39
            119
            159)
          CellData = (
            0
            0
            ''
            1
            0
            '置換'
            2
            0
            'ファイル名'
            3
            0
            '行'
            4
            0
            '置換前'
            5
            0
            '置換後'
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
            '')
          object c0GridCmd_CopyToClipBoard3: Ts0GridCmd_CopyToClipBoard
            Caption = 'コピー(&C)'
            ShortCut = 16451
            Target = grdReplaceLines
          end
          object c0GridCmd_CutToClipBoard3: Ts0GridCmd_CutToClipBoard
            Caption = '切り取り(&T)'
            ShortCut = 16472
            Target = grdReplaceLines
          end
          object c0GridCmd_DeleteSelection3: Ts0GridCmd_DeleteSelection
            Caption = '削除(&D)'
            ShortCut = 46
            Target = grdReplaceLines
          end
          object c0GridCmd_PasteFromClipBoard3: Ts0GridCmd_PasteFromClipBoard
            Caption = '貼り付け(&P)'
            ShortCut = 16470
            Target = grdReplaceLines
          end
          object c0GridCmd_SelectAll3: Ts0GridCmd_SelectAll
            Caption = '全て選択(&A)'
            ShortCut = 16449
            Target = grdReplaceLines
          end
          object c0GridCmd_AddRow3: Ts0GridCmd_AddRow
            Caption = '行追加'
            ShortCut = 16429
            Target = grdReplaceLines
          end
          object c0GridCmd_InsertRow3: Ts0GridCmd_InsertRow
            Caption = '行挿入'
            ShortCut = 49197
            Target = grdReplaceLines
          end
          object c0GridCmd_RemoveRow3: Ts0GridCmd_RemoveRow
            Caption = '行削除'
            ShortCut = 16430
            Target = grdReplaceLines
          end
          object c0ShowAllColumns2: Ts0ShowAllColumns
            Caption = '全ての列を表示'
            ShortCut = 0
            Target = grdReplaceLines
          end
        end
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 53
    Width = 233
    Height = 521
    ActivePage = TabSheet2
    Align = alLeft
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = '置換文字列'
      object s0CollectionGrid1: Ts0CollectionGrid
        Left = 0
        Top = 0
        Width = 225
        Height = 494
        CellDrawer.Font.Charset = SHIFTJIS_CHARSET
        CellDrawer.Font.Color = clWindowText
        CellDrawer.Font.Height = -12
        CellDrawer.Font.Name = 'ＭＳ Ｐゴシック'
        CellDrawer.Font.Style = []
        DefaultColWidth = 30
        DoubleBuffered = False
        ColCount = 4
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        Align = alClient
        TabOrder = 0
        BindSeals = <>
        ReadOnlySeals = <>
        CtrlDecos = <>
        AlignmentDecos = <>
        ColorDecos = <>
        CtrlOfTypeClassName = 'Ts0DefaultGridCtrlOfType'
        CtrlOfType.CtrlClassNameOfEnum = 'Ts0ComboBox'
        CtrlOfType.CtrlClassNameOfSet = 'Ts0CheckListBox'
        Columns = <
          item
            TitleRow = 0
            Width = 30
            UpdateIndex = 0
          end
          item
            TitleRow = 0
            Width = 34
            UpdateIndex = 1
          end
          item
            TitleRow = 0
            Width = 83
            UpdateIndex = 2
          end
          item
            TitleRow = 0
            Width = 70
            UpdateIndex = 3
          end>
        ColWidths = (
          30
          34
          83
          70)
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
          '')
        object c0GridCmd_CopyToClipBoard4: Ts0GridCmd_CopyToClipBoard
          Caption = 'コピー(&C)'
          ShortCut = 16451
          Target = s0CollectionGrid1
        end
        object c0GridCmd_CutToClipBoard4: Ts0GridCmd_CutToClipBoard
          Caption = '切り取り(&T)'
          ShortCut = 16472
          Target = s0CollectionGrid1
        end
        object c0GridCmd_DeleteSelection4: Ts0GridCmd_DeleteSelection
          Caption = '削除(&D)'
          ShortCut = 46
          Target = s0CollectionGrid1
        end
        object c0GridCmd_PasteFromClipBoard4: Ts0GridCmd_PasteFromClipBoard
          Caption = '貼り付け(&P)'
          ShortCut = 16470
          Target = s0CollectionGrid1
        end
        object c0GridCmd_SelectAll4: Ts0GridCmd_SelectAll
          Caption = '全て選択(&A)'
          ShortCut = 16449
          Target = s0CollectionGrid1
        end
        object c0GridCmd_AddRow4: Ts0GridCmd_AddRow
          Caption = '行追加'
          ShortCut = 16429
          Target = s0CollectionGrid1
        end
        object c0GridCmd_InsertRow4: Ts0GridCmd_InsertRow
          Caption = '行挿入'
          ShortCut = 49197
          Target = s0CollectionGrid1
        end
        object c0GridCmd_RemoveRow4: Ts0GridCmd_RemoveRow
          Caption = '行削除'
          ShortCut = 16430
          Target = s0CollectionGrid1
        end
        object c0ShowAllColumns1: Ts0ShowAllColumns
          Caption = '全ての列を表示'
          ShortCut = 0
          Target = s0CollectionGrid1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '対象検索設定'
      ImageIndex = 1
      object s0Label1: Ts0Label
        Left = 0
        Top = 8
        Width = 81
        Height = 12
        Caption = '検索ディレクトリ'
      end
      object s0Label2: Ts0Label
        Left = 0
        Top = 88
        Width = 32
        Height = 12
        Caption = 'マスク'
      end
      object chkSubDir: Ts0CheckBox
        Left = 0
        Top = 48
        Width = 137
        Height = 17
        Caption = 'サブディレクトリも検索'
        TabOrder = 1
      end
      object edtSearchDir: Ts0Edit
        Left = 0
        Top = 24
        Width = 217
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        Alignment = taLeftJustify
        NumericOnly = False
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ＭＳ Ｐゴシック'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      end
      object edtMasks: Ts0Memo
        Left = 0
        Top = 104
        Width = 217
        Height = 278
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          '*.pas'
          '*.dfm'
          '*.dpr')
        TabOrder = 2
        AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
        InputStyle.Alignment = taLeftJustify
        InputStyle.Font.Charset = SHIFTJIS_CHARSET
        InputStyle.Font.Color = clWindowText
        InputStyle.Font.Height = -12
        InputStyle.Font.Name = 'ＭＳ Ｐゴシック'
        InputStyle.Font.Style = []
        InputStyle.MaxLength = 0
        InputStyle.Modified = False
        InputStyle.ReadOnly = False
        InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
      end
    end
  end
  object ActionList1: TActionList
    Left = 48
    Top = 40
    object actOpenFiles: TAction
      Category = '&File'
      Caption = '対象を開く(&O)'
      ShortCut = 16463
      OnExecute = actOpenFilesExecute
    end
    object actFindFiles: TAction
      Category = '&File'
      Caption = '対象を検索(&S)'
      OnExecute = actFindFilesExecute
    end
    object actExecReplace: TAction
      Category = '&Execute'
      Caption = '置換(&R)'
      OnExecute = actExecReplaceExecute
    end
    object actSaveReplaceText: TAction
      Category = '&File'
      Caption = '置換設定を保存(&S)'
      OnExecute = actSaveReplaceTextExecute
    end
    object actClose: TAction
      Category = '&File'
      Caption = '閉じる(&X)'
      OnExecute = actCloseExecute
    end
    object actOpenReplaceText: TAction
      Category = '&File'
      Caption = '置換設定を開く(&R)'
      OnExecute = actOpenReplaceTextExecute
    end
    object actFindBeforeReplace: TAction
      Category = '&Execute'
      Caption = '事前検索(&P)'
      OnExecute = actFindBeforeReplaceExecute
    end
    object actReplaceFileNames: TAction
      Category = '&Execute'
      Caption = 'ファイル名の置換(&F)'
      OnExecute = actReplaceFileNamesExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 40
    object File1: TMenuItem
      Caption = 'ファイル(&F)'
      object R1: TMenuItem
        Action = actOpenReplaceText
      end
      object S1: TMenuItem
        Action = actSaveReplaceText
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Open1: TMenuItem
        Action = actOpenFiles
      end
      object Replace1: TMenuItem
        Action = actFindFiles
        ShortCut = 16454
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object E1: TMenuItem
      Caption = '実行(&E)'
      object P1: TMenuItem
        Action = actFindBeforeReplace
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Replace2: TMenuItem
        Action = actExecReplace
        ShortCut = 120
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.txt'
    Filter = '*.txt|*.txt|*.*|*.*'
    Options = [ofReadOnly, ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 60
    Top = 125
  end
  object s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl
    Builder.CtrlOwner = Owner
    Builder.CtrlParent = TabSheet2
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
        PropertyName = 'SearchDir'
        TypeName = 'String'
        JPName = '検索ディレクトリ'
        Size = 0
        AutoUpdateKinds = [k0cetOnChange]
        CtrlClassName = 'Ts0Edit'
        Ctrl = edtSearchDir
        CtrlLabel = s0Label1
        EnumAsString = False
      end
      item
        PropertyName = 'SubDir'
        TypeName = 'Boolean'
        JPName = 'サブディレクトリも検索'
        Size = 0
        AutoUpdateKinds = [k0cetOnClick]
        CtrlClassName = 'Ts0CheckBox'
        Ctrl = chkSubDir
        EnumAsString = False
      end
      item
        PropertyName = 'Masks'
        TypeName = 'TStrings'
        JPName = 'マスク'
        Size = 0
        AutoUpdateKinds = [k0cetOnChange]
        CtrlClassName = 'Ts0Memo'
        Ctrl = edtMasks
        CtrlLabel = s0Label2
        EnumAsString = False
      end>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 132
    Top = 101
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.txt'
    Filter = '*.txt|*.txt|*.*|*.*'
    Left = 92
    Top = 125
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = '*.txt'
    Filter = '*.txt|*.txt|*.*|*.*'
    Options = [ofReadOnly, ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Left = 76
    Top = 165
  end
  object c0SXProgressDlg1: Tc0SXProgressDlg
    Caption = '進行状況'
    Left = 156
    Top = 164
  end
end
