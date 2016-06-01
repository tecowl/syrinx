object frm0ceBaseGrid: Ts0ce_frmBaseGrid
  Left = 222
  Top = 69
  Width = 578
  Height = 381
  Caption = 'frm0ceBaseGrid'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '‚l‚r ‚oƒSƒVƒbƒN'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 322
    Width = 570
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 476
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 372
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkOK
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 570
    Height = 322
    ActivePage = pgDecorators
    Align = alClient
    TabOrder = 1
    object pgCells: TTabSheet
      Caption = 'Cells'
      object Panel3: TPanel
        Left = 0
        Top = 280
        Width = 562
        Height = 15
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object chkAlwaysShowEditor: TCheckBox
          Left = 0
          Top = 0
          Width = 129
          Height = 17
          Caption = 'AlwaysShowEditor'
          TabOrder = 0
          OnClick = chkAlwaysShowEditorClick
        end
      end
    end
    object pgDecorators: TTabSheet
      Caption = 'Decorators'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 257
        Top = 0
        Width = 3
        Height = 295
        Cursor = crHSplit
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 257
        Height = 295
        Align = alLeft
        Caption = 'Panel2'
        TabOrder = 0
        object Splitter2: TSplitter
          Left = 1
          Top = 73
          Width = 255
          Height = 3
          Cursor = crVSplit
          Align = alTop
        end
        object dspDecos: TListBox
          Left = 1
          Top = 1
          Width = 255
          Height = 72
          Align = alTop
          ItemHeight = 12
          TabOrder = 0
          OnClick = dspDecosClick
        end
        object pnlProps: TScrollBox
          Left = 1
          Top = 76
          Width = 255
          Height = 218
          Align = alClient
          TabOrder = 1
          object Panel4: TPanel
            Left = 0
            Top = 190
            Width = 251
            Height = 24
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 0
            object Button1: TButton
              Left = 0
              Top = 0
              Width = 75
              Height = 25
              Caption = '&Save'
              TabOrder = 0
              OnClick = Button1Click
            end
          end
        end
      end
    end
  end
  object c0ObjCtrlBridge1: Ts0ObjCtrlBridge
    Builder.CtrlOwner = Owner
    Builder.CtrlPrefixes = <
      item
        PartOfCtrlClassName = 'CheckBox'
        Prefix = 'chk'
      end
      item
        PartOfCtrlClassName = 'DigitEdit'
        Prefix = 'dged'
      end
      item
        PartOfCtrlClassName = 'DateEdit'
        Prefix = 'dted'
      end
      item
        PartOfCtrlClassName = 'Edit'
        Prefix = 'edt'
      end
      item
        PartOfCtrlClassName = 'Memo'
        Prefix = 'mmo'
      end
      item
        PartOfCtrlClassName = 'ComboBox'
        Prefix = 'cmb'
      end
      item
        PartOfCtrlClassName = 'RadioGroup'
        Prefix = 'rgp'
      end
      item
        PartOfCtrlClassName = 'CheckListBox'
        Prefix = 'clb'
      end
      item
        PartOfCtrlClassName = 'Label'
        Prefix = 'lbl'
      end
      item
        PartOfCtrlClassName = 'Button'
        Prefix = 'btn'
      end
      item
        PartOfCtrlClassName = 'ListBox'
        Prefix = 'lst'
      end
      item
        PartOfCtrlClassName = 'Grid'
        Prefix = 'grd'
      end>
    Builder.CtrlOfTypeClassName = 'Ts0COTEtyCtrls'
    DisabledProps.Strings = (
      'Name'
      'Tag')
    ProtoTypes = <>
    ProtoSourcePropName = 'ProtoTypes'
    Left = 15
    Top = 85
  end
end
