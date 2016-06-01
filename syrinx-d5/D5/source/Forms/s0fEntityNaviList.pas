unit s0fEntityNaviList;
{
$History: s0fEntityNaviList.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/13   Time: 3:12
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/11/15   Time: 2:52
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/11   Time: 1:20
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/03   Time: 5:00
 * Updated in $/source/D5Integrated/Forms
 * ユニットの名称変更などを行った
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
  //XXXXXXXXList,
  s0Entity, s0FormEventPublisher, s0FormRelation,
  s0Observer, Grids, s0ComponentEventWrapper;

type
  Ts0frmEntityNaviList = class(TForm)
    s0FormRelation1: Ts0FormRelation;
    grdNavis: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdNavisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdNavisDblClick(Sender: TObject);
  private
    FTarget: Ts0Entity;
    FChangeListener: Ts0EventListener;
    procedure LoadFromNavis;
    procedure RestoreAndShow(ANavi: Ts0EntityNavi);
    procedure TargetOnChange(Sender: TObject);
    procedure SetTarget(const Value: Ts0Entity);
  public
    procedure Decide;
    property Target: Ts0Entity read FTarget write SetTarget;
  end;

var
  s0frmEntityNaviList: Ts0frmEntityNaviList;

implementation

{$R *.DFM}

{ Ts0frmEntityNaviList }

procedure Ts0frmEntityNaviList.SetTarget(const Value: Ts0Entity);
begin
  if FTarget = Value then Exit;
  if FTarget <> nil then
    FTarget.OnChange.Detach(FChangeListener);
  FTarget := Value;
  if FTarget <> nil then
    FTarget.OnChange.Attach(FChangeListener);
end;

procedure Ts0frmEntityNaviList.FormShow(Sender: TObject);
begin
  LoadFromNavis;
end;

procedure Ts0frmEntityNaviList.FormCreate(Sender: TObject);
begin
  FChangeListener := Ts0EventListener.Create(TargetOnChange);
end;

procedure Ts0frmEntityNaviList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FChangeListener);
end;

procedure Ts0frmEntityNaviList.TargetOnChange(Sender: TObject);
begin
  LoadFromNavis;
end;

procedure Ts0frmEntityNaviList.Decide;
var
  obj: TObject;
begin
  obj := grdNavis.Cols[0].Objects[grdNavis.Row];
  if obj is Ts0EntityNavi then
    RestoreAndShow( Ts0EntityNavi(obj) );
end;

procedure Ts0frmEntityNaviList.LoadFromNavis;
const
  c9Col_RelationCaption = 0;
  c9Col_TargetClassName = 1;
  c9Col_TargetID        = 2;
  c9Col_TargetCaption   = 3;
var
  i: Integer;
  nv: Ts0EntityNavi;
begin
  grdNavis.Cells[c9Col_RelationCaption, 0] := 'Category';
  grdNavis.Cells[c9Col_TargetClassName, 0] := 'ClassName';
  grdNavis.Cells[c9Col_TargetID       , 0] := 'ID';
  grdNavis.Cells[c9Col_TargetCaption  , 0] := 'Caption';
  if (FTarget = nil) or (Target.Navigators.Count < 1) then
  begin
    grdNavis.RowCount := 2;
    grdNavis.Rows[1].Clear;
    Exit;
  end;
  grdNavis.RowCount := Target.Navigators.Count +1;
  for i := 0 to Target.Navigators.Count -1 do
  begin
    nv := Target.Navigators[i];
    grdNavis.Cells[c9Col_RelationCaption, i +1] := nv.Caption;
    if nv.TargetClass <> nil then
      grdNavis.Cells[c9Col_TargetClassName, i +1] := nv.TargetClass.ClassName;
    grdNavis.Cells[c9Col_TargetID       , i +1] := IntToStr(nv.TargetID);
    grdNavis.Cells[c9Col_TargetCaption  , i +1] := nv.TargetCaption;
    grdNavis.Cols[0].Objects[i +1] := nv;
  end;
end;

procedure Ts0frmEntityNaviList.RestoreAndShow(ANavi: Ts0EntityNavi);
var
  frm: TCustomForm;
begin
  if ANavi = nil then Exit;
  ANavi.RestoreTarget;
  frm := nil;
  if Self.Owner is TCustomForm then
    frm := TCustomForm(Self.Owner);
  ANavi.TargetEty.ShowDetail(False, frm);
end;

procedure Ts0frmEntityNaviList.grdNavisKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Decide;
end;

procedure Ts0frmEntityNaviList.grdNavisDblClick(Sender: TObject);
begin
  Decide;
end;

end.
