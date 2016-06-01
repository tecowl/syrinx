object Form1: TForm1
  Left = 202
  Top = 144
  Width = 704
  Height = 358
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object s0ObjTreeView1: Ts0ObjTreeView
    Left = 0
    Top = 41
    Width = 696
    Height = 290
    TreeViewWidth = 200
    TreeViewProps.Font.Charset = SHIFTJIS_CHARSET
    TreeViewProps.Font.Color = clWindowText
    TreeViewProps.Font.Height = -12
    TreeViewProps.Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
    TreeViewProps.Font.Style = []
    TreeViewProps.ParentFont = True
    TreeViewProps.TabOrder = 0
    TreeViewProps.AutoExpand = False
    TreeViewProps.ChangeDelay = 0
    TreeViewProps.HideSelection = True
    TreeViewProps.HotTrack = False
    TreeViewProps.Indent = 19
    TreeViewProps.RightClickSelect = False
    TreeViewProps.RowSelect = False
    TreeViewProps.ShowButtons = True
    TreeViewProps.ShowHint = False
    TreeViewProps.ShowLines = True
    TreeViewProps.ShowRoot = True
    TreeViewProps.ToolTips = True
    TreeViewProps.VisibleClasses = [k0otmckPersistent, k0otmckObject]
    Align = alClient
    Color = clWhite
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 696
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object s0TaggedPage1: Ts0TaggedPage
    PolicyName = 'XML'
    Contents = <>
    Left = 104
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Left = 144
    Top = 8
  end
end
