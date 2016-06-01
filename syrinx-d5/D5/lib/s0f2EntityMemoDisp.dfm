inherited frm0EntityMemoDisp: Ts0frmEntityMemoDisp
  Left = 332
  Top = 104
  Width = 397
  Height = 257
  Caption = 'frm0EntityMemoDisp'
  PixelsPerInch = 96
  TextHeight = 12
  object edtEntity: TMemo [0]
    Left = 0
    Top = 0
    Width = 389
    Height = 230
    Align = alClient
    Lines.Strings = (
      'edtEntity')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  inherited impDetail: Ts0EntityDetailImpl
    OnChangeTarget = impDetailChangeTarget
    OnChangeTargetID = impDetailChangeTargetID
    OnDetailLoad = impDetailDetailLoad
  end
end
