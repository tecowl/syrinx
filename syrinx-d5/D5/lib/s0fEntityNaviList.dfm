object s0frmEntityNaviList: Ts0frmEntityNaviList
  Left = 9
  Top = 34
  Width = 340
  Height = 204
  Caption = 's0frmEntityNaviList'
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
  object grdNavis: TStringGrid
    Left = 0
    Top = 0
    Width = 332
    Height = 177
    Align = alClient
    ColCount = 4
    DefaultColWidth = 95
    DefaultRowHeight = 16
    FixedCols = 0
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 0
    OnDblClick = grdNavisDblClick
    OnKeyDown = grdNavisKeyDown
    ColWidths = (
      88
      80
      46
      95)
  end
  object s0FormRelation1: Ts0FormRelation
    Left = 8
    Top = 48
  end
end
