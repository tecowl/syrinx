inherited frm0SelectTables: Tfrm0SelectTables
  Left = 182
  Top = 169
  Caption = 'frm0SelectTables'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  inherited lstSource: TListBox
    Top = 22
    Height = 214
  end
  inherited Panel2: TPanel
    Top = 22
    Height = 214
    inherited Button1: TButton
      Top = 32
    end
    inherited Button2: TButton
      Top = 64
    end
    inherited Button3: TButton
      Top = 96
    end
    inherited Button4: TButton
      Top = 128
    end
  end
  inherited lstDest: TListBox
    Top = 22
    Height = 214
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 0
      Top = 4
      Width = 53
      Height = 12
      Caption = 'BDE Alias'
    end
    object cmbAliases: TComboBox
      Left = 64
      Top = 0
      Width = 177
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
      OnChange = cmbAliasesChange
    end
    object chkParadoxDB: TCheckBox
      Left = 248
      Top = 2
      Width = 137
      Height = 17
      Caption = 'Is Paradox or dBase'
      TabOrder = 1
    end
  end
end
