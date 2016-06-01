object dm8CtrlCenter: Tdm8CtrlCenter
  OldCreateOrder = False
  Left = 187
  Top = 342
  Height = 272
  Width = 505
  object c0EntityAltFormManager1: Tc0EntityAltFormManager
    Items = <
      item
        FormClassName = 'Ts0frmAltDispDBGrid'
      end
      item
        FormClassName = 'Ts0frmAltMemoDisp'
      end
      item
        FormClassName = 'Ts0frmAltEntityDetail'
      end>
    Left = 72
    Top = 16
  end
  object s0Database1: Ts0Database
    AliasName = 'HKZ_ER'
    DatabaseName = 'EBW'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey')
    SessionName = 'Default'
    LoginUserName = 'SYSDBA'
    LoginPassword = 'masterkey'
    Left = 72
    Top = 80
  end
end
