object Form1: TForm1
  Left = 142
  Top = 119
  Width = 831
  Height = 318
  HorzScrollBar.Range = 221
  AutoScroll = False
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 217
    Top = 0
    Width = 4
    Height = 272
    Cursor = crHSplit
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 217
    Height = 272
    Align = alLeft
    Indent = 19
    TabOrder = 0
    OnChange = TreeView1Change
  end
  object ScrollBox1: TScrollBox
    Left = 221
    Top = 0
    Width = 602
    Height = 272
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <>
    ApplicationName = 'dofChang'
    IniFileName = 'dofChang.ini'
    Left = 144
    Top = 88
  end
  object ActionList1: TActionList
    Left = 40
    Top = 8
    object actNewProj: TAction
      Category = 'File'
      Caption = '&New Project'
      OnExecute = actNewProjExecute
    end
    object actOpenProj: TAction
      Category = 'File'
      Caption = '&Open'
      ShortCut = 16463
      OnExecute = actOpenProjExecute
    end
    object actSaveProj: TAction
      Category = 'File'
      Caption = '&Save'
      ShortCut = 16467
      OnExecute = actSaveProjExecute
    end
    object actRemoveProj: TAction
      Category = 'File'
      Caption = '&Remove Proj'
      OnExecute = actRemoveProjExecute
    end
    object actExit: TAction
      Category = 'File'
      Caption = 'E&xit'
    end
    object actAddDof: TAction
      Category = 'Edit'
      Caption = '&Add Dof'
      ShortCut = 20486
    end
    object actRemoveDof: TAction
      Category = 'Edit'
      Caption = '&Remove Dof'
    end
    object actCreateAction: TAction
      Category = 'Edit'
      Caption = '&Create Action'
    end
    object actDeleteAction: TAction
      Category = 'Edit'
      Caption = '&Delete Action'
    end
    object actExecute: TAction
      Category = 'Run'
      Caption = '&Execute'
      ShortCut = 4152
    end
  end
  object OpenDialog1: TOpenDialog
    Title = #38283#12367
    Left = 56
    Top = 64
  end
  object SaveDialog1: TSaveDialog
    Title = #21517#21069#12434#20184#12369#12390#20445#23384
    Left = 40
    Top = 152
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 24
    object File1: TMenuItem
      Caption = '&File'
      object NewProject1: TMenuItem
        Action = actNewProj
      end
      object Open1: TMenuItem
        Action = actOpenProj
      end
      object Save1: TMenuItem
        Action = actSaveProj
      end
      object RemoveProj1: TMenuItem
        Action = actRemoveProj
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = actExit
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object AddDof1: TMenuItem
        Action = actAddDof
      end
      object RemoveDof1: TMenuItem
        Action = actRemoveDof
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object CreateAction1: TMenuItem
        Action = actCreateAction
      end
      object DeleteAction1: TMenuItem
        Action = actDeleteAction
      end
    end
    object Run1: TMenuItem
      Caption = '&Run'
      object Execute1: TMenuItem
        Action = actExecute
      end
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
    Builder.CtrlOfTypeClassName = 'Ts0COTStdCtrls'
    DisabledProps.Strings = (
      'Name'
      'Tag')
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 256
    Top = 24
  end
  object s0ObjTreeMapMenu1: Ts0ObjTreeMapMenu
    TreeView = TreeView1
    OnNeedRefresh = s0ObjTreeMapMenu1NeedRefresh
    Left = 168
    Top = 192
  end
  object s0ObjTreeMapper1: Ts0ObjTreeMapper
    MapTargetAsRoot = False
    MapCollection = True
    TreeView = TreeView1
    Left = 120
    Top = 192
  end
end
