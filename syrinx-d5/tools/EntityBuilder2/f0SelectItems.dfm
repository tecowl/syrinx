object frm0SelectItems: Tfrm0SelectItems
  Left = 200
  Top = 101
  Width = 437
  Height = 293
  Caption = 'frm0SelectItems'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object lstSource: TListBox
    Left = 0
    Top = 0
    Width = 201
    Height = 236
    Align = alLeft
    DragMode = dmAutomatic
    ItemHeight = 12
    MultiSelect = True
    TabOrder = 0
    OnDblClick = lstSourceDblClick
    OnDragDrop = lstDestDragDrop
    OnDragOver = lstDestDragOver
  end
  object Panel2: TPanel
    Left = 201
    Top = 0
    Width = 48
    Height = 236
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 2
      Top = 64
      Width = 43
      Height = 25
      Caption = '>'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 2
      Top = 96
      Width = 43
      Height = 25
      Caption = '>>'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 2
      Top = 128
      Width = 43
      Height = 25
      Caption = '<'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 2
      Top = 160
      Width = 43
      Height = 25
      Caption = '<<'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object lstDest: TListBox
    Left = 249
    Top = 0
    Width = 180
    Height = 236
    Align = alClient
    DragMode = dmAutomatic
    ItemHeight = 12
    MultiSelect = True
    TabOrder = 2
    OnDblClick = lstDestDblClick
    OnDragDrop = lstDestDragDrop
    OnDragOver = lstDestDragOver
  end
  object Panel3: TPanel
    Left = 0
    Top = 236
    Width = 429
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 222
      Top = 4
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 327
      Top = 4
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
