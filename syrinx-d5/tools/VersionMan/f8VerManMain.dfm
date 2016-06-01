object frm8VerManMain: Tfrm8VerManMain
  Left = 302
  Top = 104
  Width = 990
  Height = 558
  Caption = 'frm8VerManMain'
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
  object Splitter2: TSplitter
    Left = 297
    Top = 27
    Width = 3
    Height = 504
    Cursor = crHSplit
  end
  object pnlMainSettings: TPanel
    Left = 0
    Top = 27
    Width = 297
    Height = 504
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter3: TSplitter
      Left = 0
      Top = 97
      Width = 297
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object pnlVerManProps: TPanel
      Left = 0
      Top = 0
      Width = 297
      Height = 97
      Align = alTop
      TabOrder = 0
    end
    object pnlFinderProps: TPanel
      Left = 0
      Top = 100
      Width = 297
      Height = 404
      Align = alClient
      TabOrder = 1
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 982
    Height = 27
    AutoSize = True
    Bands = <
      item
        Control = s0MenuBar1
        ImageIndex = -1
        MinHeight = 23
        Width = 978
      end>
    object s0MenuBar1: Ts0MenuBar
      Left = 9
      Top = 0
      Width = 965
      Height = 23
      ButtonHeight = 20
      ButtonWidth = 70
      Caption = 's0MenuBar1'
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      Menu = MainMenu1
      ShowText = False
    end
  end
  object PageControl1: TPageControl
    Left = 300
    Top = 27
    Width = 682
    Height = 504
    ActivePage = tabFileNames
    Align = alClient
    TabOrder = 2
    object tabFileNames: TTabSheet
      Caption = 'Oridinal Files'
      object lstFileNames: TListBox
        Left = 0
        Top = 0
        Width = 674
        Height = 477
        Align = alClient
        ItemHeight = 12
        TabOrder = 0
        OnDblClick = lstFileNamesDblClick
      end
    end
    object tabSavePoints: TTabSheet
      Caption = 'Save Points'
      ImageIndex = 1
      object grdVerCheck: Ts0CtrlGrid
        Left = 0
        Top = 49
        Width = 674
        Height = 428
        FixedRows = 2
        ColCount = 2
        RowCount = 3
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        Align = alClient
        TabOrder = 0
        OnDblClick = grdVerCheckDblClick
        BindSeals = <>
        Columns = <
          item
            TitleRow = 0
            Width = 100
          end
          item
            TitleRow = 0
            Width = 100
          end>
        ReadOnlySeals = <
          item
            Top = 0
            Left = 0
            Right = 1
            Bottom = 1
          end>
        AlignmentDecos = <
          item
            Top = 0
            Left = 0
            Right = 0
            Bottom = 2
            RegionKind = k0gcrCols
            Horizontal = taRightJustify
            Vertical = k0vaCenter
          end>
        ColorDecos = <>
        CtrlDecos = <
          item
            Top = 1
            Left = 0
            Right = 1
            Bottom = 2
            Control = s0GridCellCheck1
          end>
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
          '')
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 674
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object s0GridCellCheck1: Ts0GridCellCheck
        Left = 48
        Top = 112
        Width = 16
        Height = 16
        ParentColor = False
        TabOrder = 2
        TabStop = True
      end
    end
  end
  object s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl
    AutoUpdate = True
    Builder.CtrlOwner = Owner
    Builder.CtrlParent = pnlVerManProps
    Builder.CtrlPrefixes.Strings = (
      'CheckBox=chk'
      'DigitEdit=dged'
      'DateEdit=dted'
      'Edit=edt'
      'Memo=mmo'
      'ComboBox=cmb'
      'RadioGroup=rgp'
      'CheckListBox=clb'
      'Label=lbl'
      'Button=btn'
      'ListBox=lst'
      'Grid=grd')
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 8
    Top = 32
  end
  object MainMenu1: TMainMenu
    Left = 82
    Top = 50
    object File2: TMenuItem
      Caption = 'ファイル(&F)'
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object File1: TMenuItem
      Caption = '実行(&E)'
      object B1: TMenuItem
        Action = actBeginMonitoring
      end
      object T1: TMenuItem
        Action = actEndMonitoring
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object F1: TMenuItem
        Action = actFindModify
      end
    end
    object Show1: TMenuItem
      Caption = '表示(&V)'
      object H1: TMenuItem
        Action = actFileHistory
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Refresh1: TMenuItem
        Action = actRefreshVerFiles
      end
    end
  end
  object ActionList1: TActionList
    Left = 26
    Top = 50
    object actBeginMonitoring: TAction
      Category = 'Execute'
      Caption = '監視開始(&B)'
      OnExecute = actBeginMonitoringExecute
      OnUpdate = actBeginMonitoringUpdate
    end
    object actEndMonitoring: TAction
      Category = 'Execute'
      Caption = '監視停止(&T)'
      OnExecute = actEndMonitoringExecute
      OnUpdate = actEndMonitoringUpdate
    end
    object actFileHistory: TAction
      Category = 'View'
      Caption = 'ファイルの履歴(&H)'
      OnExecute = actFileHistoryExecute
    end
    object actClose: TAction
      Category = 'File'
      Caption = '閉じる(&X)'
      OnExecute = actCloseExecute
    end
    object actRefreshVerFiles: TAction
      Category = 'View'
      Caption = '最新の情報に更新(&F)'
      ShortCut = 116
      OnExecute = actRefreshVerFilesExecute
    end
    object actFindModify: TAction
      Category = 'Execute'
      Caption = '変更を検索(&F)'
      OnExecute = actFindModifyExecute
    end
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        DefaultValue = '360'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        DefaultValue = '105'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        DefaultValue = '422'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        DefaultValue = '614'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end>
    SystemName = 'pleiades'
    ApplicationName = 'VM'
    IniFileName = 'vm.ini'
    Left = 128
    Top = 35
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 160
    Top = 35
  end
  object s0UnifiedObjCtrl2: Ts0UnifiedObjCtrl
    AutoUpdate = True
    Builder.CtrlOwner = Owner
    Builder.CtrlParent = pnlFinderProps
    Builder.CtrlPrefixes.Strings = (
      'CheckBox=chk'
      'DigitEdit=dged'
      'DateEdit=dted'
      'Edit=edt'
      'Memo=mmo'
      'ComboBox=cmb'
      'RadioGroup=rgp'
      'CheckListBox=clb'
      'Label=lbl'
      'Button=btn'
      'ListBox=lst'
      'Grid=grd')
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 8
    Top = 144
  end
end
