object frm8Main: Tfrm8Main
  Left = 34
  Top = 162
  Width = 939
  Height = 502
  Caption = 'TaskTracker'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 209
    Top = 29
    Width = 3
    Height = 304
    Cursor = crHSplit
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 333
    Width = 931
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 931
    Height = 29
    AutoSize = True
    Bands = <
      item
        Control = s0MenuBar1
        ImageIndex = -1
        Width = 927
      end>
    object s0MenuBar1: Ts0MenuBar
      Left = 9
      Top = 0
      Width = 914
      Height = 25
      ButtonHeight = 20
      ButtonWidth = 39
      Caption = 's0MenuBar1'
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      Menu = MainMenu1
      ShowText = False
    end
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 29
    Width = 209
    Height = 304
    Align = alLeft
    Indent = 19
    TabOrder = 1
    OnChange = TreeView1Change
  end
  object ScrollBox1: TScrollBox
    Left = 212
    Top = 29
    Width = 719
    Height = 304
    Align = alClient
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 336
    Width = 931
    Height = 139
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 3
    object grdSchedules: Ts0CollectionGrid
      Left = 0
      Top = 0
      Width = 931
      Height = 139
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      Align = alClient
      TabOrder = 0
      BindSeals = <>
      Columns = <>
      ReadOnlySeals = <>
      CtrlDecos = <>
      AlignmentDecos = <>
      ColorDecos = <>
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
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 40
    object File1: TMenuItem
      Caption = '&File'
      object actLoad1: TMenuItem
        Action = actLoad
      end
      object actSave1: TMenuItem
        Action = actSave
      end
      object actSaveAs1: TMenuItem
        Action = actSaveAs
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object CloseX1: TMenuItem
        Action = actClose
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object NewSchedule1: TMenuItem
        Action = actNewStory
      end
      object NewTask1: TMenuItem
        Action = actNewTask
      end
      object NewSchedule2: TMenuItem
        Action = actNewSchedule
      end
    end
    object View1: TMenuItem
      Caption = '&View'
      object RefreshSchedule1: TMenuItem
        Action = actRecalcSchedule
      end
      object RefreshSchedule2: TMenuItem
        Action = actRefreshSchedule
      end
    end
  end
  object ActionList1: TActionList
    Left = 48
    Top = 40
    object actLoad: TAction
      Category = '&File'
      Caption = '&Load'
      ShortCut = 16463
      OnExecute = actLoadExecute
    end
    object actSave: TAction
      Category = '&File'
      Caption = '&Save'
      ShortCut = 16467
      OnExecute = actSaveExecute
    end
    object actNewStory: TAction
      Category = '&Edit'
      Caption = 'New&Story'
      OnExecute = actNewStoryExecute
    end
    object actSaveAs: TAction
      Category = '&File'
      Caption = 'Save&As'
      OnExecute = actSaveAsExecute
    end
    object actNewTask: TAction
      Category = '&Edit'
      Caption = 'New&Task'
    end
    object actNewSchedule: TAction
      Category = '&Edit'
      Caption = 'NewS&chedule'
    end
    object actClose: TAction
      Category = '&File'
      Caption = 'Close(&X)'
    end
    object actRefreshSchedule: TAction
      Category = '&View'
      Caption = '&RefreshSchedule'
      OnExecute = actRefreshScheduleExecute
    end
    object actRecalcSchedule: TAction
      Category = '&Edit'
      Caption = 'Re&calcSchedule'
      OnExecute = actRecalcScheduleExecute
    end
  end
  object s0TreeViewController1: Ts0TreeViewController
    TreeView = TreeView1
    Left = 144
    Top = 164
  end
  object OpenDialog1: TOpenDialog
    Left = 72
    Top = 96
  end
  object SaveDialog1: TSaveDialog
    Left = 112
    Top = 96
  end
  object s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl
    AutoUpdate = True
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
    Builder.CtrlOfType.Items = <
      item
        CtrlClassName = 'Ts0CheckBox'
        TypeName = 'Boolean'
      end
      item
        CtrlClassName = 'Ts0Edit'
        TypeName = 'String'
      end
      item
        CtrlClassName = 'Ts0DateEdit'
        TypeName = 'TDate'
      end
      item
        CtrlClassName = 'Ts0DateEdit'
        TypeName = 'TTime'
      end
      item
        CtrlClassName = 'Ts0DateEdit'
        TypeName = 'TDateTime'
      end
      item
        CtrlClassName = 'Ts0DigitEdit'
        TypeName = 'Char'
      end
      item
        CtrlClassName = 'Ts0DigitEdit'
        TypeName = 'Integer'
      end
      item
        CtrlClassName = 'Ts0DigitEdit'
        TypeName = 'Word'
      end
      item
        CtrlClassName = 'Ts0DigitEdit'
        TypeName = 'Currency'
      end
      item
        CtrlClassName = 'Ts0DigitEdit'
        TypeName = 'Single'
      end
      item
        CtrlClassName = 'Ts0DigitEdit'
        TypeName = 'Double'
      end
      item
        CtrlClassName = 'Ts0DigitEdit'
        TypeName = 'Extended'#9
      end
      item
        CtrlClassName = 'Ts0Memo'
        IsObject = True
        TypeName = 'TStrings'
      end
      item
        CtrlClassName = 'Ts0Memo'
        IsObject = True
        TypeName = 'TStringList'
      end>
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    OnInitCtrl = s0UnifiedObjCtrl1InitCtrl
    OnStandInCtrls = s0UnifiedObjCtrl1StandInCtrls
    Left = 222
    Top = 39
  end
end
