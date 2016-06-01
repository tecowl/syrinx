object dm8EntityBuilder: Tdm8EntityBuilder
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 420
  Top = 118
  Height = 350
  Width = 538
  object s0Database1: Ts0Database
    DatabaseName = 'MainDB'
    LoginPrompt = False
    SessionName = 'Default'
    StoredLoginParam = True
    Left = 56
    Top = 16
  end
  object Session1: TSession
    SessionName = 'Session1_1'
    Left = 56
    Top = 80
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'xml'
    Filter = '*.xml|*.xml|*.*|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 192
    Top = 24
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xml'
    Filter = '*.xml|*.xml|*.*|*.*'
    Left = 192
    Top = 80
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        TargetComponent = s0Database1
        TargetIsOwner = False
        TargetProperty = 'AliasName'
      end
      item
        TargetComponent = s0Database1
        TargetIsOwner = False
        TargetProperty = 'DatabaseName'
      end
      item
        TargetComponent = s0Database1
        TargetIsOwner = False
        TargetProperty = 'LoginUserName'
      end
      item
        TargetComponent = s0Database1
        TargetIsOwner = False
        TargetProperty = 'LoginPassword'
      end>
    ApplicationName = 'EB3'
    IniFileName = 'EntityBuilder.ini'
    Left = 208
    Top = 176
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 56
    Top = 176
  end
end
