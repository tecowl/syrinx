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
    chkSorted: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cmbAliasesChange(Sender: TObject);
    procedure chkSortedClick(Sender: TObject);
    procedure chkParadoxDBClick(Sender: TObject);
  private
    FBDEAliasName: string;
    FSession: TSession;
    FDataBase: TDatabase;
    function GetBDEAliasName: string;
    procedure RefreshTables;
    procedure RefreshAliasList;
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
begin
  RefreshAliasList;
end;

procedure Tfrm0SelectTables.cmbAliasesChange(Sender: TObject);
begin
  RefreshTables;
end;

function Tfrm0SelectTables.GetBDEAliasName: string;
begin
  Result := cmbAliases.Text;
end;

procedure Tfrm0SelectTables.RefreshTables;
var
  sl: TStringList;
begin
  if cmbAliases.Text = '' then Exit;
  FSession.Active := False;
  FDatabase.Connected := False;
  FDatabase.SessionName := FSession.SessionName;
  FDatabase.AliasName := cmbAliases.Text;
  sl := TStringList.Create;
  try
    FSession.GetTableNames(
      cmbAliases.Text, '*', False, chkParadoxDB.Checked, sl);
    if chkSorted.Checked then
      sl.Sort;
    lstSource.Items.Assign(sl);
  finally
    FreeAndNil(sl);
  end;
end;

procedure Tfrm0SelectTables.chkSortedClick(Sender: TObject);
begin
  RefreshTables;
end;

procedure Tfrm0SelectTables.chkParadoxDBClick(Sender: TObject);
begin
  RefreshTables;
end;

procedure Tfrm0SelectTables.RefreshAliasList;
var
  aliasBuf: string;
  sl: TStringList;
begin
  aliasBuf := cmbAliases.Text;
  if aliasBuf = '' then
    aliasBuf := FBDEAliasName;
  try
    sl := TStringList.Create;
    try
      FSession.GetAliasNames(sl);
      sl.Sort;
      cmbAliases.Items.Assign(sl);
    finally
      FreeAndNil(sl);
    end;
  finally
    cmbAliases.ItemIndex := cmbAliases.Items.IndexOf(aliasBuf);
  end;
  if cmbAliases.ItemIndex < 0 then
    lstSource.Items.Clear
  else
    cmbAliasesChange(nil);
end;

end.
