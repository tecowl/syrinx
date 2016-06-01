unit f0SelectTables;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  f0SelectItems, StdCtrls, Buttons, ExtCtrls, DBTables, Db, s0Database;

type
  Tfrm0SelectTables = class(Tfrm0SelectItems)
    Panel1: TPanel;
    Label1: TLabel;
    cmbAliases: TComboBox;
    chkParadoxDB: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cmbAliasesChange(Sender: TObject);
  private
    FBDEAliasName: string;
    FSession: TSession;
    FDataBase: TDatabase;
    function GetBDEAliasName: string;
  public
    property Session: TSession read FSession write FSession;
    property DataBase: TDatabase read FDataBase write FDataBase;
    property BDEAliasName: string read GetBDEAliasName write FBDEAliasName;
  end;

var
  frm0SelectTables: Tfrm0SelectTables;

implementation

{$R *.DFM}

{ Tfrm0SelectTables }

procedure Tfrm0SelectTables.FormShow(Sender: TObject);
var
  aliasBuf: string;
begin
  aliasBuf := cmbAliases.Text;
  if aliasBuf = '' then
    aliasBuf := FBDEAliasName;
  try
    FSession.GetAliasNames(cmbAliases.Items);
  finally
    cmbAliases.ItemIndex := cmbAliases.Items.IndexOf(aliasBuf);
  end;
  if cmbAliases.ItemIndex < 0 then
    lstSource.Items.Clear
  else
    cmbAliasesChange(nil);
end;

procedure Tfrm0SelectTables.cmbAliasesChange(Sender: TObject);
begin
  if cmbAliases.Text = '' then Exit;
  FSession.Active := False;
  FDatabase.Connected := False;
  FDatabase.SessionName := FSession.SessionName;
  FDatabase.DatabaseName := cmbAliases.Text;
  FSession.GetTableNames(
    cmbAliases.Text, '*', False, chkParadoxDB.Checked, lstSource.Items);
end;

function Tfrm0SelectTables.GetBDEAliasName: string;
begin
  Result := cmbAliases.Text;
end;

end.
