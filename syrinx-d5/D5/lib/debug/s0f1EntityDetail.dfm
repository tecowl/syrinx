inherited s0frmEntityDetail: Ts0frmEntityDetail
  Left = 20
  Top = 23
  Caption = 's0frmEntityDetail'
  OldCreateOrder = True
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar1: TStatusBar [0]
    Left = 0
    Top = 106
    Width = 317
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  inherited s0FormRelation1: Ts0FormRelation
    OnSubFormDestroy = s0FormRelation1SubFormDestroy
  end
  object impDetail: Ts0EntityDetailImpl
    OnChangeEditingMode = impDetailChangeEditingMode
    OnChangeTargetID = impDetailChangeTargetID
    Left = 64
    Top = 8
  end
  object ActionList1: TActionList
    Left = 112
    Top = 8
    object actShowNaviList: TAction
      Category = 'View'
      Caption = '�i�r�Q�[�^(&N)'
      ShortCut = 122
      OnExecute = actShowNaviListExecute
    end
    object actRefresh: TAction
      Category = 'View'
      Caption = '�\�����X�V(&R)'
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actNewEntity: TAction
      Category = 'File'
      Caption = '�V�K�쐬(&N)'
      OnExecute = actNewEntityExecute
      OnUpdate = actNewEntityUpdate
    end
    object actSaveEntity: TAction
      Category = 'File'
      Caption = '�ۑ�(&S)'
      OnExecute = actSaveEntityExecute
      OnUpdate = actSaveEntityUpdate
    end
    object actRemoveEntity: TAction
      Category = 'File'
      Caption = '�폜(&R)'
      OnExecute = actRemoveEntityExecute
      OnUpdate = actRemoveEntityUpdate
    end
    object actClose: TAction
      Category = 'File'
      Caption = '����(&X)'
      OnExecute = actCloseExecute
    end
    object actReadOnly: TAction
      Category = 'View'
      Caption = '�����݋֎~(&R)'
      OnExecute = actReadOnlyExecute
      OnUpdate = actReadOnlyUpdate
    end
  end
end
