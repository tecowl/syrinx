inherited s0frmEntityDBGridList: Ts0frmEntityDBGridList
  Left = 15
  Top = 36
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object grdEntities: TDBGrid [0]
    Left = 0
    Top = 0
    Width = 317
    Height = 106
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = SHIFTJIS_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'ＭＳ Ｐゴシック'
    TitleFont.Style = []
    OnDblClick = grdEntitiesDblClick
    OnKeyDown = grdEntitiesKeyDown
  end
  object StatusBar1: TStatusBar [1]
    Left = 0
    Top = 106
    Width = 317
    Height = 19
    Panels = <
      item
        Width = 200
      end>
    SimplePanel = False
  end
  object impList: Ts0EntityListImpl
    BeforeRefreshList = impListBeforeRefreshList
    Left = 56
    Top = 8
  end
  object DataSource1: TDataSource
    OnDataChange = DataSource1DataChange
    Left = 8
    Top = 48
  end
  object ActionList1: TActionList
    Left = 48
    Top = 48
    object actRefresh: TAction
      Category = 'View'
      Caption = '表示を更新(&R)'
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actNewEntity: TAction
      Category = 'File'
      Caption = '新規作成(&N)'
      OnExecute = actNewEntityExecute
    end
    object actRemoveEntity: TAction
      Category = 'File'
      Caption = '削除(&R)'
      OnExecute = actRemoveEntityExecute
    end
    object actClose: TAction
      Category = 'File'
      Caption = '閉じる(&X)'
      OnExecute = actCloseExecute
    end
    object actEditEntity: TAction
      Category = 'File'
      Caption = '編集(&E)'
      OnExecute = actEditEntityExecute
    end
    object actShowDetail: TAction
      Category = 'File'
      Caption = '詳細表示(&D)'
      OnExecute = actShowDetailExecute
    end
  end
end
