unit s0fCustomWizard;
{
$History: s0fCustomWizard.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Forms
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:26
 * Updated in $/source/D5Integrated/Forms
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/09/06   Time: 21:25
 * Updated in $/source/D5Integrated
 * ひとまずOK
 * 
 * *****************  Version 1  *****************
 * User: Takima       Date: 01/09/03   Time: 9:42
 * Created in $/Projects/Pleiades/source/D5Integrated
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/03   Time: 2:31
 * Updated in $/source/D5/p0ctrl
 * エンティティ生成関係とりあえずOKできました
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/09/01   Time: 2:52
 * Created in $/source/D5/p0ctrl
 * 新規作成
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, AppEvnts, c0SXWizardPages;

type
  Ts0frmCustomWizard = class(TForm)
    Panel1: TPanel;
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    ApplicationEvents1: TApplicationEvents;
    lblPagePosition: TLabel;
    btnFinished: TButton;
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure pgcWizardChange(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
  private
    procedure InvalidateBtnEnabled;
    procedure ShowPagePosition;
    function GetNextPageEnabled: Boolean;
    procedure SetNextPageEnabled(const Value: Boolean);
    procedure InitPages;
  public
    property NextPageEnabled: Boolean read GetNextPageEnabled write SetNextPageEnabled;
  end;

var
  frm0CustomWizard: Ts0frmCustomWizard;

implementation

{$R *.DFM}

procedure Ts0frmCustomWizard.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  ShowPagePosition;
  InvalidateBtnEnabled;
end;

procedure Ts0frmCustomWizard.InvalidateBtnEnabled;
begin
  if  pgcMain.CurrentPage = nil then Exit;
  btnBack.Enabled := (pgcMain.CurrentPage.OriginPage <> nil) and pgcMain.CurrentPage.OriginPage.Usable;
  btnNext.Enabled := (pgcMain.CurrentPage.NextPage <> nil) and pgcMain.CurrentPage.NextPage.Usable;
end;

procedure Ts0frmCustomWizard.FormCreate(Sender: TObject);
begin
  InitPages;
end;

resourcestring
  c9Fmt_PagePosition = 'Page %d / %d';

procedure Ts0frmCustomWizard.ShowPagePosition;
begin
  btnFinished.Visible := (pgcMain.ActivePageIndex = pgcMain.PageCount -1);
  lblPagePosition.Caption :=
    Format(c9Fmt_PagePosition,
      [pgcMain.ActivePageIndex +1, pgcMain.PageCount]); 
end;

procedure Ts0frmCustomWizard.pgcWizardChange(Sender: TObject);
begin
  ShowPagePosition;
  InvalidateBtnEnabled;
end;

procedure Ts0frmCustomWizard.btnBackClick(Sender: TObject);
begin
  pgcMain.GoBack;
end;

procedure Ts0frmCustomWizard.btnNextClick(Sender: TObject);
begin
  pgcMain.GoNext;
end;

procedure Ts0frmCustomWizard.pgcMainChange(Sender: TObject);
begin
  ShowPagePosition;
  InvalidateBtnEnabled;
end;

function Ts0frmCustomWizard.GetNextPageEnabled: Boolean;
begin
  Result := False;
  if pgcMain.CurrentPage = nil then Exit;
  if pgcMain.CurrentPage.NextPage = nil then Exit;
  Result := pgcMain.CurrentPage.NextPage.Usable;
end;

procedure Ts0frmCustomWizard.SetNextPageEnabled(const Value: Boolean);
begin
  if pgcMain.CurrentPage = nil then Exit;
  if pgcMain.CurrentPage.NextPage = nil then Exit;
  pgcMain.CurrentPage.NextPage.Usable := Value;
end;

procedure Ts0frmCustomWizard.InitPages;
var
  i: Integer;
begin
  for i := 0 to pgcMain.PageCount -1 do
  begin
    //pgcMain.Pages[i].Enabled := False;
    pgcMain.Pages[i].TabVisible := False;
  end;
  if pgcMain.PageCount > 0 then
  begin
    pgcMain.ActivePageIndex := 0;
  end;
end;

end.
