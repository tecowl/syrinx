inherited s0frmEntityHybrid: Ts0frmEntityHybrid
  Left = -7
  Top = 52
  Width = 427
  Height = 172
  Caption = 'frm0EntityHybrid'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter [0]
    Left = 169
    Top = 0
    Width = 3
    Height = 126
    Cursor = crHSplit
  end
  inherited grdEntities: TDBGrid
    Width = 169
    Height = 126
    Align = alLeft
  end
  inherited StatusBar1: TStatusBar
    Top = 126
    Width = 419
  end
  object pnlDetail: TPanel [3]
    Left = 172
    Top = 0
    Width = 247
    Height = 126
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
  end
  inherited impList: Ts0EntityListImpl
    Options = [k0eloLoadKeyOnMove]
    OnMoveSelected = impListMoveSelected
    OnDecide = impListDecide
  end
  inherited ActionList1: TActionList
    object actSaveEntity: TAction
      Category = 'File'
      Caption = 'ï€ë∂(&S)'
      OnExecute = actSaveEntityExecute
    end
    object actReadOnly: TAction
      Category = 'View'
      Caption = 'èëçûÇ›ã÷é~(&R)'
    end
  end
  object impDetail: Ts0EntityDetailImpl
    Left = 187
    Top = 10
  end
end
