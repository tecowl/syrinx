unit s0fObjEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  Ts0frmObjEditorClass = class of Ts0frmObjEditor;
  Ts0frmObjEditor = class(TForm)
  private
  public
    procedure ShowObjProp(AObj: TObject); virtual; abstract;
    function ShowObjPropModal(AObj: TObject): Integer; virtual; abstract;
  public
    class function GetRegisteredEditor: Ts0frmObjEditorClass;
    class procedure RegisterObjEditor(AEditor: Ts0frmObjEditorClass);
    class procedure UnRegisterObjEditor(AEditor: Ts0frmObjEditorClass);
    class procedure ShowEditor(AObj: TObject; AClass: Ts0frmObjEditorClass = nil);
    class function ShowEditorModal(AObj: TObject; AClass: Ts0frmObjEditorClass = nil): Integer;
  end;

var
  frm0ObjEditor: Ts0frmObjEditor;

implementation

{$R *.DFM}

uses
  s0ObjectHelper;

{ Ts0frmObjEditor }

var
  g9ObjEditorClass: Ts0frmObjEditorClass = nil;

class function Ts0frmObjEditor.GetRegisteredEditor: Ts0frmObjEditorClass;
begin
  Result := g9ObjEditorClass;
end;

class procedure Ts0frmObjEditor.RegisterObjEditor(
  AEditor: Ts0frmObjEditorClass);
begin
  g9ObjEditorClass := AEditor;
end;

class procedure Ts0frmObjEditor.ShowEditor(AObj: TObject; AClass: Ts0frmObjEditorClass);
var
  frm: Ts0frmObjEditor;
begin
  if AClass = nil then AClass := g9ObjEditorClass;
  if AClass = nil then Exit;
  frm := AClass.Create(nil);
  try
    frm.Caption := Ts0ObjectHelper.GetObjectCaptionWithClass( AObj );
    frm.ShowObjProp(AObj);
  finally
    FreeAndNil(frm);
  end;
end;

class function Ts0frmObjEditor.ShowEditorModal(AObj: TObject; AClass: Ts0frmObjEditorClass): Integer;
var
  frm: Ts0frmObjEditor;
begin
  Result := mrCancel;
  if AClass = nil then AClass := g9ObjEditorClass;
  if AClass = nil then Exit;
  frm := AClass.Create(nil);
  try
    frm.Caption := Ts0ObjectHelper.GetObjectCaptionWithClass( AObj );
    Result := frm.ShowObjPropModal(AObj);
  finally
    FreeAndNil(frm);
  end;
end;

class procedure Ts0frmObjEditor.UnRegisterObjEditor(
  AEditor: Ts0frmObjEditorClass);
begin
  if g9ObjEditorClass = AEditor then
    g9ObjEditorClass := nil;
end;

end.
