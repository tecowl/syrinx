inherited frm0AltDispDBGrid: Ts0frmAltDispDBGrid
  Left = 8
  Top = -1
  Width = 437
  Height = 251
  Caption = 'frm0AltDispDBGrid'
  Menu = MainMenu1
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter [0]
    Left = 185
    Top = 0
    Width = 3
    Height = 186
    Cursor = crHSplit
  end
  inherited grdEntities: TDBGrid
    Left = 188
    Width = 241
    Height = 186
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
  end
  object pnlFilters: TPanel [2]
    Left = 0
    Top = 0
    Width = 185
    Height = 186
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 0
      Top = 94
      Width = 185
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object dspFilters: TMemo
      Left = 0
      Top = 97
      Width = 185
      Height = 89
      Align = alBottom
      Lines.Strings = (
        'dspFilters')
      TabOrder = 0
    end
    object TreeView1: TTreeView
      Left = 0
      Top = 0
      Width = 185
      Height = 94
      Align = alClient
      Indent = 19
      TabOrder = 1
    end
  end
  inherited StatusBar1: TStatusBar
    Top = 186
    Width = 429
  end
  inherited ActionList1: TActionList
    inherited actNewEntity: TAction
      Enabled = False
    end
    inherited actRemoveEntity: TAction
      Enabled = False
    end
    inherited actEditEntity: TAction
      Enabled = False
    end
  end
  object s0TreeViewController1: Ts0TreeViewController
    TreeView = TreeView1
    OnRefreshView = s0TreeViewController1RefreshView
    Left = 144
    Top = 96
  end
  object c0DSFilter1: Ts0DSFilter
    Enabled = False
    Items = <>
    DefaultQuote = #39
    Left = 104
    Top = 96
  end
  object MainMenu1: TMainMenu
    Left = 88
    Top = 48
    object File1: TMenuItem
      Caption = 'ファイル(&F)'
      object New1: TMenuItem
        Action = actNewEntity
      end
      object Delete1: TMenuItem
        Action = actRemoveEntity
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object Show1: TMenuItem
      Caption = '表示(&V)'
      object Refresh1: TMenuItem
        Action = actRefresh
      end
    end
  end
end
