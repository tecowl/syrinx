object frm8EntityBuilder: Tfrm8EntityBuilder
  Left = 232
  Top = 99
  Width = 818
  Height = 482
  Caption = 'Entity Builder ver 3.0'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '�l�r �o�S�V�b�N'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 0
    Top = 397
    Width = 810
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 810
    Height = 78
    AutoSize = True
    Bands = <
      item
        Control = s0MenuBar1
        ImageIndex = -1
        MinHeight = 20
        Width = 806
      end
      item
        Control = Panel1
        ImageIndex = -1
        Width = 582
      end
      item
        Break = False
        Control = Panel3
        ImageIndex = -1
        Width = 222
      end
      item
        Control = Panel2
        ImageIndex = -1
        Width = 478
      end
      item
        Break = False
        Control = Panel4
        ImageIndex = -1
        Width = 326
      end>
    object s0MenuBar1: Ts0MenuBar
      Left = 9
      Top = 0
      Width = 793
      Height = 20
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
      Top = 22
      Width = 569
      Height = 25
      BevelOuter = bvNone
      Constraints.MinWidth = 569
      TabOrder = 1
      object s0Button2: Ts0Button
        Left = 330
        Top = 0
        Width = 120
        Height = 25
        Action = actSaveIDConstUnit
        TabOrder = 0
        Align = alLeft
      end
      object s0Button3: Ts0Button
        Left = 130
        Top = 0
        Width = 100
        Height = 25
        Action = actLoadProject
        TabOrder = 1
        Align = alLeft
      end
      object s0Button4: Ts0Button
        Left = 230
        Top = 0
        Width = 100
        Height = 25
        Action = actSaveProject
        TabOrder = 2
        Align = alLeft
      end
      object s0Button11: Ts0Button
        Left = 0
        Top = 0
        Width = 130
        Height = 25
        Action = actAddProject
        TabOrder = 3
        Align = alLeft
      end
      object s0Button12: Ts0Button
        Left = 450
        Top = 0
        Width = 120
        Height = 25
        Action = actRemoveProject
        TabOrder = 4
        Align = alLeft
      end
    end
    object Panel2: TPanel
      Left = 9
      Top = 49
      Width = 465
      Height = 25
      BevelOuter = bvNone
      Constraints.MinWidth = 400
      TabOrder = 2
      object s0Button5: Ts0Button
        Left = 200
        Top = 0
        Width = 130
        Height = 25
        Action = actGenerateFiles
        TabOrder = 0
        Align = alLeft
      end
      object s0Button9: Ts0Button
        Left = 100
        Top = 0
        Width = 100
        Height = 25
        Action = actGenerateSQLs
        TabOrder = 1
        Align = alLeft
      end
      object s0Button10: Ts0Button
        Left = 330
        Top = 0
        Width = 130
        Height = 25
        Action = actSaveToFiles
        TabOrder = 2
        Align = alLeft
      end
      object s0Button1: Ts0Button
        Left = 0
        Top = 0
        Width = 100
        Height = 25
        Action = actSelectFromBDE
        TabOrder = 3
        Align = alLeft
      end
    end
    object Panel4: TPanel
      Left = 489
      Top = 49
      Width = 313
      Height = 25
      BevelOuter = bvNone
      Constraints.MinWidth = 265
      TabOrder = 3
      object s0Button7: Ts0Button
        Left = 0
        Top = 0
        Width = 110
        Height = 25
        Action = actExportToTable
        TabOrder = 0
        Align = alLeft
      end
      object s0Button8: Ts0Button
        Left = 110
        Top = 0
        Width = 110
        Height = 25
        Action = actCreateTable
        TabOrder = 1
        Align = alLeft
      end
    end
    object Panel3: TPanel
      Left = 593
      Top = 22
      Width = 209
      Height = 25
      BevelOuter = bvNone
      Constraints.MinWidth = 100
      TabOrder = 4
      object s0Button6: Ts0Button
        Left = 0
        Top = 0
        Width = 66
        Height = 25
        Action = actClose
        TabOrder = 0
        Align = alLeft
      end
    end
  end
  object s0ObjTreeView1: Ts0ObjTreeView
    Left = 0
    Top = 78
    Width = 810
    Height = 319
    TreeViewWidth = 150
    TreeViewProps.Font.Charset = SHIFTJIS_CHARSET
    TreeViewProps.Font.Color = clWindowText
    TreeViewProps.Font.Height = -12
    TreeViewProps.Font.Name = '�l�r �o�S�V�b�N'
    TreeViewProps.Font.Style = []
    TreeViewProps.ParentFont = True
    TreeViewProps.TabOrder = 0
    TreeViewProps.AutoExpand = False
    TreeViewProps.ChangeDelay = 50
    TreeViewProps.HideSelection = False
    TreeViewProps.HotTrack = False
    TreeViewProps.Indent = 19
    TreeViewProps.RightClickSelect = True
    TreeViewProps.RowSelect = False
    TreeViewProps.ShowButtons = True
    TreeViewProps.ShowHint = False
    TreeViewProps.ShowLines = True
    TreeViewProps.ShowRoot = True
    TreeViewProps.ToolTips = True
    TreeViewProps.MapTargetAsRoot = False
    TreeViewProps.MapClasses = [k0otmckComponent, k0otmckCollection, k0otmckPersistent, k0otmckObjectList, k0otmckObject]
    TreeViewProps.VisibleClasses = [k0otmckComponent, k0otmckCollection, k0otmckPersistent, k0otmckObjectList, k0otmckObject]
    Layouts = s0LayoutSet1
    Align = alClient
    Color = clWhite
    TabOrder = 1
    BeforeMenuItemClick = s0ObjTreeView1BeforeMenuItemClick
  end
  object dspValidation: TMemo
    Left = 0
    Top = 400
    Width = 810
    Height = 55
    Align = alBottom
    ParentColor = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 88
    object File1: TMenuItem
      Caption = '�t�@�C��(&F)'
      object N6: TMenuItem
        Action = actAddProject
      end
      object Open1: TMenuItem
        Action = actLoadProject
      end
      object Save1: TMenuItem
        Action = actSaveProject
      end
      object N7: TMenuItem
        Action = actRemoveProject
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ID1: TMenuItem
        Action = actSaveIDConstUnit
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object Edit1: TMenuItem
      Caption = '�ҏW(&E)'
      object N3: TMenuItem
        Action = actSelectFromBDE
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object SQLQ1: TMenuItem
        Action = actGenerateSQLs
      end
      object C1: TMenuItem
        Action = actGenerateFiles
      end
      object S1: TMenuItem
        Action = actSaveToFiles
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object I1: TMenuItem
        Action = actExportToTable
      end
      object T1: TMenuItem
        Action = actCreateTable
      end
    end
    object Show1: TMenuItem
      Caption = '�\��(&V)'
      object SQLQ2: TMenuItem
        Action = actRefresh
      end
    end
  end
  object ActionList1: TActionList
    OnExecute = ActionList1Execute
    Left = 40
    Top = 85
    object actSelectFromBDE: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = 'BDE����I��'
      TargetMethodName = 'SelectFromBDE'
    end
    object actSaveToFile: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = '�t�@�C���ɕۑ�'
      TargetMethodName = 'SaveToFile'
    end
    object actSaveToFiles: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = '�t�@�C���ɕۑ�(&S)'
      TargetMethodName = 'SaveToFiles'
    end
    object actGenerateFiles: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = '���j�b�g�𐶐�(&G)'
      TargetMethodName = 'GenerateFiles'
    end
    object actClose: TAction
      Category = 'File'
      Caption = '����'
      OnExecute = actCloseExecute
    end
    object actRefresh: TAction
      Category = 'View'
      Caption = '�ŐV�̏��ɍX�V(&R)'
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actGenerateSQL: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = 'SQL�𐶐�(&Q)'
      TargetMethodName = 'GenerateSQL'
    end
    object actGenerateSQLs: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = 'SQL�𐶐�(&Q)'
      TargetMethodName = 'GenerateSQLs'
    end
    object actExportToTable: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = '�e�[�u����Export'
      TargetMethodName = 'ExportToTable'
    end
    object actCreateTable: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = '�e�[�u���𐶐�(&T)'
      TargetMethodName = 'CreateTable'
    end
    object actDeleteTable: Ts0ObjTreeMapAction
      Category = 'Edit'
      Caption = '�e�[�u�����폜(&D)'
      TargetMethodName = 'DeleteTable'
    end
    object actSaveIDConstUnit: Ts0ObjTreeMapAction
      Category = 'File'
      Caption = 'ID�錾���j�b�g��ۑ�'
      TargetMethodName = 'SaveIDConstUnit'
    end
    object actAddProject: Ts0ObjTreeMapAction
      Category = 'File'
      Caption = '�v���W�F�N�g�̐V�K�쐬'
      TargetMethodName = 'AddProject'
    end
    object actLoadProject: Ts0ObjTreeMapAction
      Category = 'File'
      Caption = '�v���W�F�N�g���J��'
      TargetMethodName = 'LoadProject'
    end
    object actSaveProject: Ts0ObjTreeMapAction
      Category = 'File'
      Caption = '�v���W�F�N�g��ۑ�'
      TargetMethodName = 'SaveProject'
    end
    object actRemoveProject: Ts0ObjTreeMapAction
      Category = 'File'
      Caption = '�v���W�F�N�g�����'
      TargetMethodName = 'RemoveProject'
    end
  end
  object s0LayoutSet1: Ts0LayoutSet
    Items = <
      item
        Items = <>
      end>
    Left = 8
    Top = 120
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 56
    Top = 128
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        AccessLevel = k0ialForm
        DefaultValue = '74'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '114'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '482'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '818'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end>
    ApplicationName = 'EB3'
    IniFileName = 'EntityBuilder.ini'
    Left = 96
    Top = 128
  end
end
