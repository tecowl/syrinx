unit s0fObjPropEditor;
{
$History: s0fObjPropEditor.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 01/12/18   Time: 11:50
 * Updated in $/source/D5Integrated/Forms
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 01/10/11   Time: 1:22
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/10/08   Time: 0:08
 * Updated in $/source/D5Integrated
 * CtrlOwnerを指定してなかったのでちゃんと表示されてなかった・・・
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/10/05   Time: 13:05
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/10/03   Time: 23:45
 * Updated in $/source/D5Integrated
 * 新たに作成されたTs0frmObjEditorから継承するように変更。
 * 使用者からはTs0frmObjEditorのインタフェースだけで使用するようにした。
 * # Ts0frmObjPropEditor自身は、Ts0frmObjEditorのクラスメソッドで登録する。
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/10/02   Time: 1:58
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/01   Time: 17:37
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/10/01   Time: 9:13
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/27   Time: 9:17
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/25   Time: 10:10
 * Updated in $/source/D5Integrated
 * Ts0CollectionGridを使用できるように変更
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/25   Time: 1:23
 * Created in $/source/D5Integrated
 * 新規作成
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0ObjCtrlBuilder, ExtCtrls, StdCtrls,
  s0fObjEditor,
  s0PropertyProtoType, s0UnifiedObjCtrl;

type
  Ts0frmObjPropEditor = class(Ts0frmObjEditor)
    pnlActions: TPanel;
    btnLoad: TButton;
    btnSave: TButton;
    btnClose: TButton;
    pnlCtrls: TScrollBox;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FBridge: Ts0UnifiedObjCtrl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowObjProp(AObj: TObject); override;
    function ShowObjPropModal(AObj: TObject): Integer; override;
  end;

var
  frm0ObjPropEditor: Ts0frmObjPropEditor;

implementation

{$R *.DFM}

{ Ts0frmObjPropEditor }

procedure Ts0frmObjPropEditor.ShowObjProp(AObj: TObject);
begin
  if AObj = nil then Exit;
  FBridge.Builder.CtrlParent := pnlCtrls;
  FBridge.Target := AObj;
  FBridge.BuildCtrls;
  FBridge.LoadFromTarget;
  inherited Show;
end;

function Ts0frmObjPropEditor.ShowObjPropModal(AObj: TObject): Integer;
begin
  Result := mrCancel;
  if AObj = nil then Exit;
  FBridge.Builder.CtrlParent := pnlCtrls;
  FBridge.Target := AObj;
  FBridge.BuildCtrls;
  FBridge.LoadFromTarget;
  Result := inherited ShowModal;
end;

procedure Ts0frmObjPropEditor.btnLoadClick(Sender: TObject);
begin
  FBridge.LoadFromTarget;
end;

procedure Ts0frmObjPropEditor.btnSaveClick(Sender: TObject);
begin
  FBridge.SaveToTarget;
end;

procedure Ts0frmObjPropEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

constructor Ts0frmObjPropEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBridge := Ts0UnifiedObjCtrl.Create(nil);
  FBridge.Builder.CtrlOwner := Self;
end;

destructor Ts0frmObjPropEditor.Destroy;
begin
  FreeAndNil(FBridge);
  inherited Destroy;          
end;

initialization
  Ts0frmObjEditor.RegisterObjEditor(Ts0frmObjPropEditor);

finalization
  Ts0frmObjEditor.UnRegisterObjEditor(Ts0frmObjPropEditor);

end.
