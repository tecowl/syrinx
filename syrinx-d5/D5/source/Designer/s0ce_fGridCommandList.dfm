object frm0ceGridCommandList: Ts0ce_frmGridCommandList
  Left = 187
  Top = 106
  Width = 224
  Height = 200
  Caption = 'frm0ceGridCommandList'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ÇlÇr ÇoÉSÉVÉbÉN'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object grdCommands: TStringGrid
    Left = 0
    Top = 20
    Width = 216
    Height = 153
    Align = alClient
    ColCount = 2
    DefaultRowHeight = 16
    FixedCols = 0
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect, goColSizing, goRowSelect]
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = grdCommandsClick
    OnKeyDown = grdCommandsKeyDown
    ColWidths = (
      104
      152)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 216
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cmbCommandClasses: TComboBox
      Left = 0
      Top = 0
      Width = 166
      Height = 20
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 12
      TabOrder = 0
    end
    object Button1: TButton
      Left = 166
      Top = 0
      Width = 49
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'í«â¡(&A)'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 8
    Top = 48
    object Delete1: TMenuItem
      Caption = 'çÌèú(&D)'
      OnClick = Delete1Click
    end
  end
end
