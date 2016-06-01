unit s0CommonTypes;
{
$History: s0CommonTypes.pas $
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/07   Time: 23:39
 * Updated in $/source/D6VCLIntegrated
 * K0HorizontalAlignment型を追加
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/08/09   Time: 11:28
 * Updated in $/source/p0common
 * u0GUITypeとu0GUIViewTypeをリファクタリングした結果、それらを廃止し、
 * s0CommonTypesとしてまとめたので、それに対応した。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/09   Time: 11:20
 * Updated in $/source/p0common
 * u0GUIViewTypeと統合していらない定義を削除した
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/07/30   Time: 10:04
 * Updated in $/source/p0common
 * K0VerticalAlignment型や、チェックボックス用の定数を追加
 * 
 * *****************  Version 8  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

type
  K0FieldType = (k0ftUnknown, k0ftString, k0ftSmallint, k0ftInteger, k0ftWord,
    k0ftBoolean, k0ftFloat, k0ftCurrency, k0ftBCD, k0ftDate, k0ftTime, k0ftDateTime,
    k0ftBytes, k0ftVarBytes, k0ftAutoInc, k0ftBlob, k0ftMemo, k0ftGraphic, k0ftFmtMemo,
    k0ftParadoxOle, k0ftDBaseOle, k0ftTypedBinary, k0ftCursor, k0ftFixedChar, k0ftWideString,
    k0ftLargeint, k0ftADT, k0ftArray, k0ftReference, k0ftDataSet, k0ftOraBlob, k0ftOraClob,
    k0ftVariant, k0ftInterface, k0ftIDispatch, k0ftGuid
{$IFNDEF VER130}
    , k0ftTimeStamp, k0ftFMTBcd
{$ENDIF}
  );

type
  K0ImeMode = (k0imDisable, k0imClose, k0imOpen, k0imDontCare,
              k0imSAlpha, k0imAlpha, k0imHira, k0imSKata, k0imKata,
              k0imChinese, k0imSHanguel, k0imHanguel);

type
  K1InpCharType = (k1ctAlpha,k1ctDigit, k1ctSign ,{$IFNDEF NOIMEPROP} k1ctKana ,k1ctKanji {$ENDIF} );
  K1InpCharSet = set of K1InpCharType;

type
  K0VerticalAlignment = ( k0vaTop, k0vaCenter, k0vaBottom  );
  K0HorizontalAlignment = ( k0haLeft, k0haCenter, k0haRight  );

type
  K0GUIPosition = (k0posTop, k0posBottom, k0posLeft, k0posRight);
  K0GUIPositionSet = set of K0GUIPosition;

type
  K0GUIOrientation = (k0goHorizontal, k0goVertical);

implementation

end.
