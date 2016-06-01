object Form1: TForm1
  Left = 477
  Top = 180
  Width = 1078
  Height = 521
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object s0Panel1: Ts0Panel
    Left = 360
    Top = 56
    Width = 345
    Height = 41
    TabOrder = 0
    object Button1: TButton
      Left = 72
      Top = 8
      Width = 75
      Height = 25
      Caption = 'ÉhÉâÉbÉOäJén'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      Caption = 'ÉhÉâÉbÉOèIóπ'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object JvDatePickerEdit1: TJvDatePickerEdit
    Left = 272
    Top = 104
    Width = 121
    Height = 21
    AllowNoDate = True
    Checked = True
    DateFormat = 'yyyy/MM/dd'
    DateSeparator = '/'
    StoreDateFormat = True
    TabOrder = 1
  end
  object JvDateEdit1: TJvDateEdit
    Left = 408
    Top = 104
    Width = 121
    Height = 20
    TabOrder = 2
  end
  object JvDateTimePicker1: TJvDateTimePicker
    Left = 760
    Top = 56
    Width = 186
    Height = 20
    CalAlignment = dtaLeft
    Date = 38546.6431155903
    Time = 38546.6431155903
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
    Format = 'yyyy/MM/dd hh:mm:ss'
    DropDownDate = 38546
  end
  object JvCalcEdit1: TJvCalcEdit
    Left = 552
    Top = 16
    Width = 121
    Height = 20
    TabOrder = 4
    DecimalPlacesAlwaysShown = False
  end
  object JvDBUltimGrid1: TJvDBUltimGrid
    Left = 8
    Top = 144
    Width = 1001
    Height = 321
    DataSource = DataSource1
    TabOrder = 5
    TitleFont.Charset = SHIFTJIS_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
    TitleFont.Style = []
    AlternateRowColor = 8776670
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <
      item
        FieldName = 'F000'
        FitCell = fcCellSize
      end>
    RowsHeight = 16
    TitleRowHeight = 16
  end
  object JvDBDateTimePicker1: TJvDBDateTimePicker
    Left = 8
    Top = 120
    Width = 186
    Height = 20
    CalAlignment = dtaLeft
    Date = 38546.6598318056
    Time = 38546.6598318056
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 6
    DropDownDate = 38546
  end
  object JvDBSpinEdit1: TJvDBSpinEdit
    Left = 16
    Top = 96
    Width = 121
    Height = 20
    TabOrder = 7
  end
  object JvDBLookupCombo1: TJvDBLookupCombo
    Left = 0
    Top = 64
    Width = 145
    Height = 21
    TabOrder = 8
  end
  object JvDBLookupList1: TJvDBLookupList
    Left = 176
    Top = 8
    Width = 121
    Height = 88
    TabOrder = 9
  end
  object JvDBGridFooter1: TJvDBGridFooter
    Left = 0
    Top = 468
    Width = 1070
    Height = 19
    SimplePanel = False
    Columns = <
      item
      end>
    DataSource = DataSource1
    DBGrid = JvDBUltimGrid1
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'aaa'
    TableName = 'GKHYUM'
    Left = 104
    Top = 48
  end
  object Database1: TDatabase
    AliasName = 'GKH_IB'
    Connected = True
    DatabaseName = 'aaa'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey')
    SessionName = 'Default'
    Left = 72
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 160
    Top = 80
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        AccessLevel = k0ialForm
        DefaultValue = '305'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '154'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '521'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        AccessLevel = k0ialForm
        DefaultValue = '1078'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end
      item
        TargetComponent = s0Panel1
        TargetIsOwner = False
        TargetProperty = 'Left'
      end
      item
        TargetComponent = s0Panel1
        TargetIsOwner = False
        TargetProperty = 'Top'
      end>
    ApplicationName = 'jedisample1'
    IniFileName = 'jediSample.ini'
    Left = 184
    Top = 40
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 192
    Top = 40
  end
  object s0CtrlDragger1: Ts0CtrlDragger
    Items = <
      item
        Control = s0Panel1
        Enabled = True
      end>
    Left = 280
    Top = 24
  end
end
