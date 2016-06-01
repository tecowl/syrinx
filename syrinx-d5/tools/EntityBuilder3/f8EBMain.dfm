object frm8EBMain: Tfrm8EBMain
  Left = 710
  Top = 290
  Width = 771
  Height = 433
  ActiveControl = s0CollectionGrid1
  Caption = 'EntityBuilder2'
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
    Left = 265
    Top = 54
    Width = 3
    Height = 352
    Cursor = crHSplit
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 54
    Width = 265
    Height = 352
    Align = alLeft
    TabOrder = 0
  end
  object s0CollectionGrid1: Ts0CollectionGrid
    Left = 268
    Top = 54
    Width = 495
    Height = 352
    CellDrawer.Font.Charset = SHIFTJIS_CHARSET
    CellDrawer.Font.Color = clWindowText
    CellDrawer.Font.Height = -12
    CellDrawer.Font.Name = 'ＭＳ Ｐゴシック'
    CellDrawer.Font.Style = []
    OnClickFixedCell = s0CollectionGrid1ClickFixedCell
    DoubleBuffered = False
    ColCount = 2
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing]
    Align = alClient
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'ＭＳ Ｐゴシック'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
        Width = 26
        UpdateIndex = 0
      end
      item
        TitleRow = 0
        Width = 100
        UpdateIndex = 1
      end>
    ColWidths = (
      26
      100)
    RowHeights = (
      16
      18)
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
      '')
    object s0GridCmd_CopyToClipBoard1: Ts0GridCmd_CopyToClipBoard
      Caption = 'コピー(&C)'
      ShortCut = 16451
      Target = s0CollectionGrid1
    end
    object s0GridCmd_CutToClipBoard1: Ts0GridCmd_CutToClipBoard
      Caption = '切り取り(&T)'
      ShortCut = 16472
      Target = s0CollectionGrid1
    end
    object s0GridCmd_PasteFromClipBoard2: Ts0GridCmd_PasteFromClipBoard
      Caption = '貼り付け(&P)'
      ShortCut = 16470
      Target = s0CollectionGrid1
    end
    object s0GridCmd_DeleteSelection2: Ts0GridCmd_DeleteSelection
      Caption = '削除(&D)'
      ShortCut = 46
      Target = s0CollectionGrid1
    end
    object s0GridCmd_InsertRow1: Ts0GridCmd_InsertRow
      Caption = '行挿入'
      ShortCut = 49197
      Target = s0CollectionGrid1
    end
    object s0GridCmd_RemoveRow1: Ts0GridCmd_RemoveRow
      Caption = '行削除'
      ShortCut = 16430
      Target = s0CollectionGrid1
    end
    object s0GridCmd_AddRow1: Ts0GridCmd_AddRow
      Caption = '行追加'
      ShortCut = 16429
      Target = s0CollectionGrid1
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 763
    Height = 54
    AutoSize = True
    Bands = <
      item
        Control = s0MenuBar1
        ImageIndex = -1
        MinHeight = 23
        Width = 759
      end
      item
        Control = Panel1
        ImageIndex = -1
        Width = 759
      end>
    object Panel1: TPanel
      Left = 9
      Top = 25
      Width = 746
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object s0Button1: Ts0Button
        Left = 441
        Top = 0
        Width = 112
        Height = 25
        Action = actEntityDetail
        TabOrder = 4
        Align = alLeft
      end
      object s0Button2: Ts0Button
        Left = 321
        Top = 0
        Width = 120
        Height = 25
        Action = actLoadAsCSV
        TabOrder = 3
        Align = alLeft
      end
      object s0Button3: Ts0Button
        Left = 209
        Top = 0
        Width = 112
        Height = 25
        Action = actSaveAsCSV
        TabOrder = 2
        Align = alLeft
      end
      object s0Button4: Ts0Button
        Left = 113
        Top = 0
        Width = 96
        Height = 25
        Action = actSaveIDDefineUnit
        TabOrder = 1
        Align = alLeft
      end
      object s0Button6: Ts0Button
        Left = 0
        Top = 0
        Width = 113
        Height = 25
        Action = actSelectTables
        TabOrder = 0
        Align = alLeft
      end
      object s0Button5: Ts0Button
        Left = 680
        Top = 0
        Width = 66
        Height = 25
        Action = actClose
        TabOrder = 5
        Align = alRight
      end
    end
    object s0MenuBar1: Ts0MenuBar
      Left = 9
      Top = 0
      Width = 746
      Height = 23
      ButtonHeight = 20
      ButtonWidth = 70
      Caption = 's0MenuBar1'
      Flat = True
      ShowCaptions = True
      TabOrder = 1
      Menu = MainMenu1
      ShowText = False
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
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 80
    Top = 96
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        DefaultValue = '258'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        DefaultValue = '91'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        DefaultValue = '417'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        DefaultValue = '1139'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end
      item
        DefaultValue = '250'
        TargetComponent = ScrollBox1
        TargetIsOwner = False
        TargetProperty = 'Width'
      end>
    SystemName = 'EB'
    ApplicationName = 'Builder'
    IniFileName = 'EtyBld.ini'
    Left = 282
    Top = 11
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 328
    Top = 8
  end
  object s0Database1: Ts0Database
    LoginPrompt = False
    SessionName = 'Default'
    StoredLoginParam = True
    Left = 4
    Top = 128
  end
  object SaveDialog1: TSaveDialog
    Left = 584
    Top = 16
  end
  object ActionList1: TActionList
    Left = 82
    Top = 59
    object actSaveIDDefineUnit: TAction
      Category = 'File'
      Caption = 'IDユニットを保存'
      ShortCut = 49225
      OnExecute = actSaveIDDefineUnitExecute
    end
    object actSaveAsCSV: TAction
      Category = 'File'
      Caption = 'CSVファイルに保存'
      ShortCut = 16467
      OnExecute = actSaveAsCSVExecute
      OnUpdate = actSaveAsCSVUpdate
    end
    object actLoadAsCSV: TAction
      Category = 'File'
      Caption = 'CSVファイルの読込み'
      ShortCut = 16463
      OnExecute = actLoadAsCSVExecute
    end
    object actClose: TAction
      Category = 'File'
      Caption = '閉じる(&X)'
      OnExecute = actCloseExecute
    end
    object actSelectTables: TAction
      Category = 'Edit'
      Caption = 'テーブルを選択(&S)'
      ShortCut = 16468
      OnExecute = actSelectTablesExecute
    end
    object actEntityDetail: TAction
      Category = 'View'
      Caption = 'エンティティの詳細'
      ShortCut = 122
      OnExecute = actEntityDetailExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 42
    Top = 96
    object File1: TMenuItem
      Caption = 'ファイル(&F)'
      object CSV1: TMenuItem
        Action = actLoadAsCSV
      end
      object CSV2: TMenuItem
        Action = actSaveAsCSV
      end
      object ID1: TMenuItem
        Action = actSaveIDDefineUnit
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object T1: TMenuItem
      Caption = '編集(&E)'
      object N2: TMenuItem
        Action = actSelectTables
      end
    end
    object Show1: TMenuItem
      Caption = '表示(&V)'
      object N6: TMenuItem
        Action = actEntityDetail
      end
    end
  end
end
