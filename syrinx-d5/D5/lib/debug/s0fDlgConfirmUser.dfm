object s0frmDlgConfirmUser: Ts0frmDlgConfirmUser
  Left = 345
  Top = 100
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'ユーザ認証'
  ClientHeight = 103
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ＭＳ Ｐゴシック'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object lblUserName: TLabel
    Left = 46
    Top = 8
    Width = 48
    Height = 12
    Caption = 'ユーザ名'
    FocusControl = edtUserName
  end
  object lblPassword: TLabel
    Left = 40
    Top = 32
    Width = 54
    Height = 12
    Caption = 'パスワード'
    FocusControl = edtPassword
  end
  object lblConfirmPW: TLabel
    Left = 8
    Top = 56
    Width = 86
    Height = 12
    Caption = 'パスワード(確認)'
    FocusControl = edtConfirmPW
  end
  object edtUserName: TEdit
    Left = 104
    Top = 4
    Width = 145
    Height = 20
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 104
    Top = 28
    Width = 145
    Height = 20
    PasswordChar = '*'
    TabOrder = 1
    OnChange = edtPasswordChange
  end
  object btnOK: TButton
    Left = 54
    Top = 76
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 139
    Top = 76
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object edtConfirmPW: TEdit
    Left = 104
    Top = 52
    Width = 145
    Height = 20
    PasswordChar = '*'
    TabOrder = 2
    OnChange = edtPasswordChange
  end
end
