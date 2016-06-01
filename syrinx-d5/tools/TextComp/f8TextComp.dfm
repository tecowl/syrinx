object Form1: TForm1
  Left = 278
  Top = 121
  Width = 593
  Height = 349
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object s0CollectionGrid1: Ts0CollectionGrid
    Left = 0
    Top = 73
    Width = 585
    Height = 249
    CellDrawer.Font.Charset = SHIFTJIS_CHARSET
    CellDrawer.Font.Color = clWindowText
    CellDrawer.Font.Height = -12
    CellDrawer.Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    CellDrawer.Font.Style = []
    DoubleBuffered = False
    ColCount = 4
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
    Align = alClient
    TabOrder = 0
    BindSeals = <>
    ReadOnlySeals = <>
    CtrlDecos = <>
    AlignmentDecos = <>
    ColorDecos = <>
    CtrlOfTypeClassName = 'Ts0DefaultGridCtrlOfType'
    CtrlOfType.CtrlClassNameOfEnum = 'Ts0ComboBox'
    CtrlOfType.CtrlClassNameOfSet = 'Ts0CheckListBox'
    Columns = <
      item
        TitleRow = 0
        Width = 20
        UpdateIndex = 1
      end
      item
        TitleRow = 0
        Width = 248
        UpdateIndex = 0
      end
      item
        TitleRow = 0
        Width = 237
        UpdateIndex = 2
      end
      item
        TitleRow = 0
        Width = 62
        UpdateIndex = 3
      end>
    ColWidths = (
      20
      248
      237
      62)
    CellData = (
      0
      0
      ''
      1
      0
      ''
      2
      0
      ''
      3
      0
      ''
      0
      1
      ''
      1
      1
      ''
      2
      1
      ''
      3
      1
      '')
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      585
      73)
    object Label1: TLabel
      Left = 16
      Top = 4
      Width = 36
      Height = 12
      Caption = #27604#36611#20803
    end
    object Label2: TLabel
      Left = 16
      Top = 28
      Width = 36
      Height = 12
      Caption = #27604#36611#20808
    end
    object Edit1: TEdit
      Left = 64
      Top = 0
      Width = 514
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 63
      Top = 24
      Width = 514
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'Edit1'
    end
    object Button1: TButton
      Left = 8
      Top = 48
      Width = 75
      Height = 25
      Caption = #27604#36611#23455#34892
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object s0TextComparer1: Ts0TextComparer
    Left = 56
    Top = 104
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 152
    Top = 128
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end
      item
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        TargetComponent = Edit1
        TargetIsOwner = False
        TargetProperty = 'Text'
      end
      item
        TargetComponent = Edit2
        TargetIsOwner = False
        TargetProperty = 'Text'
      end>
    ApplicationName = 'TextComp'
    IniFileName = 'TextComp.ini'
    Left = 160
    Top = 72
  end
end
