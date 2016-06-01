unit s0f2EntityMemoDisp;
{
$History: s0f2EntityMemoDisp.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/19   Time: 14:36
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:07
 * Updated in $/source/D5Integrated/Forms
 * ユニット名変更完了
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:41
 * Updated in $/source/D5/p0entity
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0f1EntityDetail, s0f0EntityDisplay, s0EntityDetailImpl,
  s0FormEventPublisher, s0FormRelation, StdCtrls, ActnList;

type
  Ts0frmEntityMemoDisp = class(Ts0frmEntityDetail)
    edtEntity: TMemo;
    procedure impDetailChangeTarget(Sender: TObject);
    procedure impDetailChangeTargetID(Sender: TObject);
    procedure impDetailDetailLoad(Sender: TObject);
  private
  public
  end;

var
  frm0EntityMemoDisp: Ts0frmEntityMemoDisp;

implementation

{$R *.DFM}

procedure Ts0frmEntityMemoDisp.impDetailChangeTarget(Sender: TObject);
begin
  impDetail.LoadFromTarget;
end;

procedure Ts0frmEntityMemoDisp.impDetailChangeTargetID(Sender: TObject);
begin
  if not Self.Visible then Exit;
  DetailTarget.Load;
  impDetail.LoadFromTarget;
end;

procedure Ts0frmEntityMemoDisp.impDetailDetailLoad(Sender: TObject);
var
  ms1, ms2: TMemoryStream;
begin
  ms1 := TMemoryStream.Create;
  try
    ms1.WriteComponent(impDetail.DispTarget);
    ms1.Position := 0;
    ms2 := TMemoryStream.Create;
    try
      ObjectBinaryToText(ms1, ms2);
      ms2.Position := 0;
      edtEntity.Lines.LoadFromStream(ms2);
    finally
      FreeAndNil(ms2);
    end;
  finally
    FreeAndNil(ms1);
  end;
end;

end.
