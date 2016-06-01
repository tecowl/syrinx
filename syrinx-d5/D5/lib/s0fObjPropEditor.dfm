object frm0ObjPropEditor: Ts0frmObjPropEditor
  Left = 121
  Top = 100
  Width = 488
  Height = 342
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object pnlActions: TPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnLoad: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Load'
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnSave: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Save'
      Default = True
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnClose: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Close'
      TabOrder = 2
      OnClick = btnCloseClick
    end
  end
  object pnlCtrls: TScrollBox
    Left = 0
    Top = 41
    Width = 480
    Height = 274
    Align = alClient
    TabOrder = 1
  end
end
