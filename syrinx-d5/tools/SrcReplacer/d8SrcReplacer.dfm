object dm8SrcReplacer: Tdm8SrcReplacer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 223
  Top = 107
  Height = 215
  Width = 580
  object s0FileFinder1: Ts0FileFinder
    Active = False
    AttrMask = [k0faReadOnly, k0faHidden, k0faSysFile, k0faVolumeID, k0faArchive]
    Masks.Strings = (
      '*.pas'
      '*.dfm'
      '*.dpr')
    SearchDir = 'C:\Program Files\Borland\Delphi5\Bin'
    Left = 40
    Top = 24
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 132
    Top = 5
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        DefaultValue = '235'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        DefaultValue = '106'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        DefaultValue = '445'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        DefaultValue = '555'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end>
    SystemName = 'tools'
    ApplicationName = 'SrcReplacer'
    IniFileName = 'SrcRplcr.ini'
    Left = 188
    Top = 21
  end
end
