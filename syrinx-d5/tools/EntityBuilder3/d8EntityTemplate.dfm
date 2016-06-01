object dm8EntityTemplate: Tdm8EntityTemplate
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object EntityManager: Ts0DBEntityManager
    ProtoTypes = <>
    Options = []
    DSDetail = delEntity
    DSList = selEntities
    DSInsert = insEntity
    DSUpdate = updEntity
    DSRemove = delEntity
    OnExecDetail = EntityManagerExecDetail
    OnLoadKey = EntityManagerLoadKey
    OnExecInsert = EntityManagerExecInsert
    OnExecUpdate = EntityManagerExecUpdate
    OnExecRemove = EntityManagerExecRemove
    Left = 40
    Top = 24
  end
  object selEntity: Ts0Query
    SessionName = 'Default'
    Left = 72
    Top = 96
  end
  object selEntities: Ts0Query
    OnCalcFields = selEntitiesCalcFields
    SessionName = 'Default'
    Left = 152
    Top = 96
  end
  object insEntity: Ts0Query
    SessionName = 'Default'
    Left = 32
    Top = 160
  end
  object updEntity: Ts0Query
    SessionName = 'Default'
    Left = 112
    Top = 160
  end
  object delEntity: Ts0Query
    SessionName = 'Default'
    Left = 184
    Top = 160
  end
end
