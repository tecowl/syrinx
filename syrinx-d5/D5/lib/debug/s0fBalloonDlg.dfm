object frm0BalloonDlg: Ts0frmBalloonDlg
  Left = 186
  Top = 101
  Width = 387
  Height = 144
  Caption = 'frm0BalloonDlg'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseDown = rgnFromMouseDown
  OnMouseUp = rgnFromMouseUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object rgnFrom: Tc0SXFormRgn
    Left = 0
    Top = 0
    Width = 373
    Height = 112
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = True
    Transparent = True
    Visible = False
    OnMouseDown = rgnFromMouseDown
    OnMouseUp = rgnFromMouseUp
    TransparentColor = clWhite
  end
  object lblMessage: TLabel
    Left = 56
    Top = 32
    Width = 281
    Height = 17
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lblMessage'
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object btnYes: Ts0ButtonPanel
    Left = 104
    Top = 56
    Width = 81
    Height = 25
    Caption = '‚Í‚¢(&Y)'
    ModalResult = 6
    ParentColor = True
    TabOrder = 0
    TabStop = True
  end
  object btnNo: Ts0ButtonPanel
    Left = 192
    Top = 56
    Width = 81
    Height = 25
    Caption = '‚¢‚¢‚¦(&N)'
    ModalResult = 7
    ParentColor = True
    TabOrder = 1
    TabStop = True
  end
end
