object frm8SrcGnrtr: Tfrm8SrcGnrtr
  Left = 296
  Top = 251
  Width = 696
  Height = 484
  Caption = 'Source Generator'
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
  object Splitter1: TSplitter
    Left = 329
    Top = 0
    Width = 3
    Height = 457
    Cursor = crHSplit
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 457
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 76
      Width = 55
      Height = 12
      Caption = 'TagHeader'
    end
    object Label2: TLabel
      Left = 16
      Top = 100
      Width = 52
      Height = 12
      Caption = 'TagFooter'
    end
    object Label3: TLabel
      Left = 168
      Top = 100
      Width = 81
      Height = 12
      Caption = 'CommentFooter'
    end
    object Label4: TLabel
      Left = 168
      Top = 76
      Width = 84
      Height = 12
      Caption = 'CommentHeader'
    end
    object grdTag: TStringGrid
      Left = 8
      Top = 136
      Width = 313
      Height = 289
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 2
      DefaultRowHeight = 16
      FixedCols = 0
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
      ParentFont = False
      TabOrder = 6
      ColWidths = (
        130
        174)
    end
    object edtTagFooter: TEdit
      Left = 80
      Top = 96
      Width = 81
      Height = 20
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edtTagHeader: TEdit
      Left = 80
      Top = 72
      Width = 81
      Height = 20
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 129
      Height = 25
      Action = actOpenTemplate
      TabOrder = 0
    end
    object Button2: TButton
      Left = 8
      Top = 40
      Width = 129
      Height = 25
      Action = actSaveExpandedFile
      TabOrder = 2
    end
    object Button3: TButton
      Left = 144
      Top = 8
      Width = 129
      Height = 25
      Action = actRefreshTaggedWords
      TabOrder = 1
    end
    object Button4: TButton
      Left = 8
      Top = 428
      Width = 129
      Height = 25
      Action = actLoadTaggedWords
      Anchors = [akLeft, akBottom]
      TabOrder = 7
    end
    object Button5: TButton
      Left = 144
      Top = 428
      Width = 129
      Height = 25
      Action = actSaveTaggedWords
      Anchors = [akLeft, akBottom]
      TabOrder = 8
    end
    object Button6: TButton
      Left = 144
      Top = 40
      Width = 129
      Height = 25
      Action = actExpandTemplate
      TabOrder = 3
    end
    object edtCommentHeader: TEdit
      Left = 256
      Top = 72
      Width = 57
      Height = 20
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      Text = '{'
    end
    object edtCommentFooter: TEdit
      Left = 256
      Top = 96
      Width = 57
      Height = 20
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = '}'
    end
    object chkWithGeneratorComment: TCheckBox
      Left = 160
      Top = 120
      Width = 153
      Height = 17
      Caption = 'With Generator Commnet'
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
  end
  object PageControl1: TPageControl
    Left = 332
    Top = 0
    Width = 356
    Height = 457
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Template Source'
      object edtSource: TRichEdit
        Left = 0
        Top = 0
        Width = 348
        Height = 430
        Align = alClient
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Expanded'
      ImageIndex = 1
      object edtDest: TRichEdit
        Left = 0
        Top = 0
        Width = 348
        Height = 430
        Align = alClient
        Font.Charset = SHIFTJIS_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object ActionList1: TActionList
    Left = 224
    Top = 48
    object actOpenTemplate: TAction
      Caption = '&Open Template File'
      OnExecute = actOpenTemplateExecute
    end
    object actSaveExpandedFile: TAction
      Caption = '&Save Expanded File'
    end
    object actRefreshTaggedWords: TAction
      Caption = '&Refresh Tagged Words'
      OnExecute = actRefreshTaggedWordsExecute
    end
    object actLoadTaggedWords: TAction
      Caption = '&Load Tagged Words'
    end
    object actSaveTaggedWords: TAction
      Caption = 'Sa&ve Tagged Words'
    end
    object actExpandTemplate: TAction
      Caption = '&Expand Template'
      OnExecute = actExpandTemplateExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 24
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 56
  end
end
