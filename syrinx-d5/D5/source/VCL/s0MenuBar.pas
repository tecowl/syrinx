
{*******************************************************}
{                                                       }
{  Implements a TToolbar descendant that has a Menu to  }
{  make IDE like Toolbar menus very easy.  This works   }
{  only in Delphi 4.0                                   }
{                                                       }
{       Copyright (c) 1995,98 Inprise Corporation       }
{                                                       }
{*******************************************************}

unit s0MenuBar;
{
$History: s0MenuBar.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0comctrl
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
 * 
 * *****************  Version 5  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:46
 * Updated in $/GUI/Source/View
 * コメント表示コマンド追加
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, Menus;

type
  Ts0MenuBar = class(TToolBar)
  private
    FMenu: TMainMenu;
    FShowText: Boolean;
    FComment: string;
    procedure SetMenu(const Value: TMainMenu);
    procedure SetShowText(const Value: Boolean);
    procedure SetComment(const Value: string);
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
  published
    property EdgeBorders default [];
    property Menu: TMainMenu read FMenu write SetMenu;
    property ShowText: Boolean read FShowText write SetShowText;
    property Comment: string read FComment write SetComment;
  end;

implementation

uses
  s0GraphHelper;

{ Ts0MenuBar }

procedure Ts0MenuBar.CNNotify(var Message: TWMNotify);
const
  c9Margin = 4;

  function CanDrawTextRight(r: TRect): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to ButtonCount -1 do
      if s0GraphHelper.IsIntersect(r, Buttons[i].BoundsRect) then Exit;
    Result := True;
  end;
  function GetRestRect(ABottom: Integer): TRect;
  var
    i: Integer;
  begin
    Result.Top := c9Margin;
    Result.Bottom := ABottom;
    Result.Left := 0;
    Result.Right := ClientWidth;
    for i := 0 to Self.ButtonCount -1 do
    begin
      if Buttons[i].Top > ABottom then Exit;
      if Result.Left < Buttons[i].BoundsRect.Right then
        Result.Left := Buttons[i].BoundsRect.Right +1;
    end;
  end;
var
  r: TRect;
  h: Integer;
begin
  try
    if not FShowText then Exit;
    h := Canvas.TextHeight(FComment);
    r := Rect(
           ClientWidth - Canvas.TextWidth(FComment) -c9Margin,
           c9Margin,
           ClientWidth - c9Margin,
           h + c9Margin
         );
    if not CanDrawTextRight(r) then
    begin
      r := GetRestRect(r.Bottom);
    end;
    Canvas.Brush.Color := Color;
    Canvas.TextRect(r, r.Left, r.Top, FComment);
  finally
    inherited;
  end;
end;

constructor Ts0MenuBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Flat := True;
  ShowCaptions := True;
  EdgeBorders := [];
  ControlStyle := [csCaptureMouse, csClickEvents,
    csDoubleClicks, csMenuEvents, csSetCaption];
end;


procedure Ts0MenuBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WindowClass.style := Params.WindowClass.style or (CS_HREDRAW or CS_VREDRAW);
end;

procedure Ts0MenuBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;


procedure Ts0MenuBar.Loaded;
begin
  inherited;
  Menu := FMenu;
end;

procedure Ts0MenuBar.SetComment(const Value: string);
begin
  FComment := Value;
  Invalidate;
end;

procedure Ts0MenuBar.SetMenu(const Value: TMainMenu);
var
  i: Integer;
  Button: TToolButton;
begin
  //if FMenu = Value then exit;
  if Assigned(FMenu) then
    for i := ButtonCount - 1 downto 0 do
      Buttons[i].Free;
  FMenu := Value;
  if not Assigned(FMenu) then exit;
  for i := ButtonCount to FMenu.Items.Count - 1 do
  begin
    Button := TToolButton.Create(Self);
    try
      Button.AutoSize := True;
      Button.Grouped := True;
      Button.Parent := Self;
      Buttons[i].MenuItem := FMenu.Items[i];
    except
      Button.Free;
      raise;
    end;
  end;
  { Copy attributes from each menu item }
  for i := 0 to FMenu.Items.Count - 1 do
    Buttons[i].MenuItem := FMenu.Items[i];
end;

procedure Ts0MenuBar.SetShowText(const Value: Boolean);
begin
  FShowText := Value;
  Invalidate;
end;

end.
