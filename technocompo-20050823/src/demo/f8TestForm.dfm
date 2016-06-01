object Form2: TForm2
  Left = 287
  Top = 147
  Width = 734
  Height = 517
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object tec1xDate1: Ttec1xDate
    Left = 8
    Top = 8
    Width = 73
    Height = 25
    Accessor.Year = 17
    Accessor.Month = 8
    Accessor.Day = 20
    Accessor.Hour = 0
    Accessor.Minute = 0
    Accessor.Second = 0
    Accessor.MiliSec = 0
    InputStyle.Alignment = taLeftJustify
    InputStyle.CharCase = ecUpperCase
    InputStyle.Font.Charset = SHIFTJIS_CHARSET
    InputStyle.Font.Color = clWindowText
    InputStyle.Font.Height = -16
    InputStyle.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    InputStyle.Font.Style = []
    InputStyle.ImeMode = imClose
    InputStyle.MaxLength = 0
    InputStyle.Modified = False
    InputStyle.ReadOnly = False
    InputStyle.AcceptCharType = [k1ctAlpha, k1ctDigit, k1ctSign, k1ctKana, k1ctKanji]
    JapaneseEra = k0jeHeisei
    MarginTop = 0
    MarginBottom = 0
    BorderStyle = bsSingle
    BorderStyleOfParts = bsNone
    Color = clWindow
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    Font.Style = []
    TabOrder = 0
    EditYear.Font.Charset = SHIFTJIS_CHARSET
    EditYear.Font.Color = clWindowText
    EditYear.Font.Height = -16
    EditYear.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    EditYear.Font.Style = []
    EditYear.Left = 0
    EditYear.TabOrder = 0
    EditYear.Visible = True
    EditYear.Width = 30
    EditMonth.Font.Charset = SHIFTJIS_CHARSET
    EditMonth.Font.Color = clWindowText
    EditMonth.Font.Height = -16
    EditMonth.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    EditMonth.Font.Style = []
    EditMonth.Left = 30
    EditMonth.TabOrder = 1
    EditMonth.Visible = True
    EditMonth.Width = 18
    EditDay.Font.Charset = SHIFTJIS_CHARSET
    EditDay.Font.Color = clWindowText
    EditDay.Font.Height = -16
    EditDay.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    EditDay.Font.Style = []
    EditDay.Left = 48
    EditDay.TabOrder = 2
    EditDay.Visible = True
    EditDay.Width = 18
    EditHour.Font.Charset = SHIFTJIS_CHARSET
    EditHour.Font.Color = clWindowText
    EditHour.Font.Height = -16
    EditHour.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    EditHour.Font.Style = []
    EditHour.Left = 72
    EditHour.TabOrder = 3
    EditHour.Visible = False
    EditHour.Width = 18
    EditMinute.Font.Charset = SHIFTJIS_CHARSET
    EditMinute.Font.Color = clWindowText
    EditMinute.Font.Height = -16
    EditMinute.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    EditMinute.Font.Style = []
    EditMinute.Left = 92
    EditMinute.TabOrder = 4
    EditMinute.Visible = False
    EditMinute.Width = 18
    EditSecond.Font.Charset = SHIFTJIS_CHARSET
    EditSecond.Font.Color = clWindowText
    EditSecond.Font.Height = -16
    EditSecond.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    EditSecond.Font.Style = []
    EditSecond.Left = 112
    EditSecond.TabOrder = 5
    EditSecond.Visible = False
    EditSecond.Width = 18
    EditMiliSec.Font.Charset = SHIFTJIS_CHARSET
    EditMiliSec.Font.Color = clWindowText
    EditMiliSec.Font.Height = -16
    EditMiliSec.Font.Name = 'ÇlÇr ÉSÉVÉbÉN'
    EditMiliSec.Font.Style = []
    EditMiliSec.Left = 132
    EditMiliSec.TabOrder = 6
    EditMiliSec.Visible = False
    EditMiliSec.Width = 27
    ParentColor = False
    ParentFont = False
    BackColor = clWindow
    DayValue = 20
    InputMode = 0
    InputArea3D = True
    InputAreaColor = clWindow
    MonthValue = 8
    SpinButton = False
    YearValue = 2005
  end
  object tec1DBGrid1: Ttec1DBGrid
    Left = 8
    Top = 40
    Width = 713
    Height = 433
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = SHIFTJIS_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
    TitleFont.Style = []
    TitleArrow = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 16
    TitleRowHeight = 16
    PopupMenuItems = [kt1dbgpmSortMode, kt1dbgpmColumnSelectMode]
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'orders.db'
    Left = 272
    Top = 32
    object Table1OrderNo: TFloatField
      DisplayLabel = 'éÛíçNo'
      FieldName = 'OrderNo'
    end
    object Table1CustNo: TFloatField
      DisplayLabel = 'å⁄ãqNo'
      FieldName = 'CustNo'
      Required = True
    end
    object Table1CustCompany: TStringField
      DisplayLabel = 'å⁄ãq'
      FieldKind = fkLookup
      FieldName = 'CustCompany'
      LookupDataSet = Table2
      LookupKeyFields = 'CustNo'
      LookupResultField = 'Company'
      KeyFields = 'CustNo'
      Size = 50
      Lookup = True
    end
    object Table1SaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object Table1ShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object Table1EmpNo: TIntegerField
      FieldName = 'EmpNo'
      Required = True
    end
    object Table1ShipToContact: TStringField
      FieldName = 'ShipToContact'
    end
    object Table1ShipToAddr1: TStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object Table1ShipToAddr2: TStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object Table1ShipToCity: TStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object Table1ShipToState: TStringField
      FieldName = 'ShipToState'
    end
    object Table1ShipToZip: TStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object Table1ShipToCountry: TStringField
      FieldName = 'ShipToCountry'
    end
    object Table1ShipToPhone: TStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object Table1ShipVIA: TStringField
      FieldName = 'ShipVIA'
      Size = 10
    end
    object Table1PO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object Table1Terms: TStringField
      FieldName = 'Terms'
      Size = 6
    end
    object Table1PaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 8
    end
    object Table1ItemsTotal: TCurrencyField
      FieldName = 'ItemsTotal'
    end
    object Table1TaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object Table1Freight: TCurrencyField
      FieldName = 'Freight'
    end
    object Table1AmountPaid: TCurrencyField
      FieldName = 'AmountPaid'
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 232
    Top = 32
  end
  object Table2: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'customer.db'
    Left = 304
    Top = 32
  end
end
