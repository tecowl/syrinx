object Form3: TForm3
  Left = 195
  Top = 118
  Width = 696
  Height = 480
  Caption = 'Form3'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Image1: TImage
    Left = 8
    Top = 80
    Width = 41
    Height = 33
  end
  object Image2: TImage
    Left = 56
    Top = 80
    Width = 41
    Height = 33
  end
  object Image3: TImage
    Left = 104
    Top = 80
    Width = 41
    Height = 33
  end
  object TreeView1: TTreeView
    Left = 192
    Top = 40
    Width = 401
    Height = 393
    Indent = 19
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 72
    Top = 8
    Width = 369
    Height = 20
    TabOrder = 1
    Text = 
      'C:\Documents and Settings\akima\My Documents\My Webs\myweb3\inde' +
      'x.htm'
  end
  object Button1: TButton
    Left = 464
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 584
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object TreeView2: TTreeView
    Left = 8
    Top = 128
    Width = 121
    Height = 97
    Indent = 19
    TabOrder = 4
    Items.Data = {
      030000001F000000000000000000000000000000FFFFFFFF0000000000000000
      063131313131311F000000000000000000000001000000FFFFFFFF0000000000
      000000063232323232321F000000000000000000000002000000FFFFFFFF0000
      00000000000006333333333333}
  end
  object TreeView3: TTreeView
    Left = 8
    Top = 232
    Width = 121
    Height = 97
    Indent = 19
    StateImages = ImageList1
    TabOrder = 5
    Items.Data = {
      030000001F000000000000000000000000000000FFFFFFFF0000000000000000
      063131313131311F000000010000000000000001000000FFFFFFFF0000000000
      000000063232323232321F000000020000000000000002000000FFFFFFFF0000
      00000000000006333333333333}
  end
  object OpenDialog1: TOpenDialog
    Left = 544
  end
  object s0TreeViewController1: Ts0TreeViewController
    TreeView = TreeView1
    CheckedPropName = 'Selected'
    Options = []
    Left = 16
    Top = 40
  end
  object ImageList1: TImageList
    Left = 136
    Top = 192
  end
end
