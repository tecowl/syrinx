object Form1: TForm1
  Left = 398
  Top = 118
  Width = 608
  Height = 386
  Caption = 'HTMLDiff'
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'ＭＳ Ｐゴシック'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Memo1: TMemo
    Left = 0
    Top = 81
    Width = 600
    Height = 278
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 142
      Height = 60
      Caption = 
        '下のメモに比較するファイル名を入力してください。前後のファイルを' +
        '比較して、それぞれについてHTMLファイルを出力します。'
      WordWrap = True
    end
    object Label2: TLabel
      Left = 168
      Top = 8
      Width = 146
      Height = 12
      Caption = '出力ファイル名プレフィックス'
    end
    object Label3: TLabel
      Left = 168
      Top = 32
      Width = 93
      Height = 12
      Caption = '出力先ディレクトリ'
    end
    object Edit1: TEdit
      Left = 320
      Top = 4
      Width = 278
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'diff'
    end
    object Button1: TButton
      Left = 168
      Top = 52
      Width = 75
      Height = 25
      Caption = '実行'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 272
      Top = 28
      Width = 326
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
  end
  object s0ComparedToHTML1: Ts0ComparedToHTML
    Target = s0TextComparer1
    Dest = s0TaggedPage1
    Colors.CellDifferent = 'pink'
    Colors.CellLike = 'orange'
    Colors.FontComment = 'blue'
    Colors.FontString = 'DarkGreen'
    ParserProps.WordDelimiters = ' ,.;:#$()[]+-*/=<>'
    ParserProps.ReservedWords.Strings = (
      'absolute'
      'abstract'
      'assembler'
      'automated'
      'cdecl'
      'contains'
      'default'
      'dispid'
      'dynamic'
      'export'
      'external'
      'far'
      'forward'
      'implements'
      'index'
      'message'
      'name'
      'near'
      'nodefault'
      'overload'
      'override'
      'package'
      'pascal'
      'private'
      'protected'
      'public'
      'published'
      'read'
      'readonly'
      'register'
      'reintroduce'
      'requires'
      'resident'
      'safecall'
      'stdcall'
      'stored'
      'virtual'
      'write'
      'writeonly'
      'and'
      'array'
      'as'
      'asm'
      'begin'
      'case'
      'class'
      'const'
      'constructor'
      'destructor'
      'dispinterface'
      'div'
      'do'
      'downto'
      'else'
      'end'
      'except'
      'exports'
      'file'
      'finalization'
      'finally'
      'for'
      'function'
      'goto'
      'if'
      'implementation'
      'in'
      'inherited'
      'initialization'
      'inline'
      'interface'
      'is'
      'label'
      'library'
      'mod'
      'nil'
      'not'
      'object'
      'of'
      'or'
      'out'
      'packed'
      'procedure'
      'program'
      'property'
      'raise'
      'record'
      'repeat'
      'resourcestring'
      'set'
      'shl'
      'shr'
      'string'
      'then'
      'threadvar'
      'to'
      'try'
      'type'
      'unit'
      'until'
      'uses'
      'var'
      'while'
      'with'
      'xor')
    ParserProps.StringMark = #39
    ParserProps.LineCommnetMark = '//'
    ParserProps.CommentMarkSet1Bgn = '{'
    ParserProps.CommentMarkSet1End = '}'
    ParserProps.CommentMarkSet2Bgn = '(*'
    ParserProps.CommentMarkSet2End = '*)'
    ParserPropsName = 'Object Pascal'
    Left = 72
    Top = 88
  end
  object s0TagWriter1: Ts0TagWriter
    PolicyName = 'HTML'
    Page = s0TaggedPage1
    DoIndent = True
    ReturnAfterTag = True
    Left = 16
    Top = 144
  end
  object s0TaggedPage1: Ts0TaggedPage
    PolicyName = 'HTML'
    Contents = <>
    Left = 56
    Top = 120
  end
  object s0TextComparer1: Ts0TextComparer
    Left = 32
    Top = 88
  end
  object s0IniPropStocker1: Ts0IniPropStocker
    Items = <
      item
        DefaultValue = '0'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Top'
      end
      item
        DefaultValue = '0'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Left'
      end
      item
        DefaultValue = '600'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Width'
      end
      item
        DefaultValue = '400'
        TargetComponent = Owner
        TargetIsOwner = True
        TargetProperty = 'Height'
      end
      item
        DefaultValue = 'diff'
        TargetComponent = Edit1
        TargetIsOwner = False
        TargetProperty = 'Text'
      end
      item
        TargetComponent = Edit2
        TargetIsOwner = False
        TargetProperty = 'Text'
      end>
    ApplicationName = 'HTMLDiff'
    IniFileName = 'HTMLDiff.ini'
    Left = 128
    Top = 88
  end
  object s0FormEventPublisher1: Ts0FormEventPublisher
    Left = 120
    Top = 120
  end
end
