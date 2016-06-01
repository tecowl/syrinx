unit f8VerManMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, s0BaseGridCommand, s0BaseGrid, s0Grids, s0BindGrid,
  ComCtrls, s0ObjCtrlBuilder, s0UnifiedObjCtrl, Menus, s0MenuBar, ToolWin,
  ActnList,
  c0SXVersionManager,
  s0FileFinder, s0ObjPropStocker, s0IniPropStocker, s0FormEventPublisher,
  s0DecoGrid, s0CtrlGrid, s0GridCellControl, s0GridCellCheck;

type
  Tfrm8VerManMain = class(TForm)
    Splitter2: TSplitter;
    pnlMainSettings: TPanel;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    CoolBar1: TCoolBar;
    s0MenuBar1: Ts0MenuBar;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    actBeginMonitoring: TAction;
    actEndMonitoring: TAction;
    actFileHistory: TAction;
    File1: TMenuItem;
    Show1: TMenuItem;
    B1: TMenuItem;
    T1: TMenuItem;
    H1: TMenuItem;
    File2: TMenuItem;
    actClose: TAction;
    Close1: TMenuItem;
    pnlVerManProps: TPanel;
    Splitter3: TSplitter;
    pnlFinderProps: TPanel;
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    s0UnifiedObjCtrl2: Ts0UnifiedObjCtrl;
    PageControl1: TPageControl;
    tabFileNames: TTabSheet;
    lstFileNames: TListBox;
    tabSavePoints: TTabSheet;
    grdVerCheck: Ts0CtrlGrid;
    Panel1: TPanel;
    s0GridCellCheck1: Ts0GridCellCheck;
    actRefreshVerFiles: TAction;
    actFindModify: TAction;
    N1: TMenuItem;
    F1: TMenuItem;
    N2: TMenuItem;
    Refresh1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actBeginMonitoringExecute(Sender: TObject);
    procedure actEndMonitoringExecute(Sender: TObject);
    procedure lstFileNamesDblClick(Sender: TObject);
    procedure actBeginMonitoringUpdate(Sender: TObject);
    procedure actEndMonitoringUpdate(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure grdVerCheckDblClick(Sender: TObject);
    procedure actRefreshVerFilesExecute(Sender: TObject);
    procedure actFindModifyExecute(Sender: TObject);
    procedure actFileHistoryExecute(Sender: TObject);
  private
    FVerMan: Tc0SXVersionManager;
    FFinder: Ts0FileFinder;
    procedure ShowHistory(AFileName: string);
    procedure PrepareUnified(AUnified: Ts0UnifiedObjCtrl; ATarget: TObject;
      AInvisibles: array of string; ALongSize: array of string);
    procedure VerManAfterNewVersions(Sender: TObject);
    procedure RefreshViews;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frm8VerManMain: Tfrm8VerManMain;

implementation

uses
  u0CellDecorator,
  s0TypeConvertor,
  f8VersionHistory;

{$R *.DFM}

{ Tfrm8VerManMain }

constructor Tfrm8VerManMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFinder := Ts0FileFinder.Create(nil);
  FFinder.Name := 'Finder';
  FVerMan := Tc0SXVersionManager.Create(nil);
  FVerMan.Name := 'VersionMan';
  FVerMan.NewFileFinder := FFinder;
  FVerMan.AfterMakeNewVersions := VerManAfterNewVersions;
  s0IniPropStocker1.Items.AddAllProp(FFinder, k0ialInstance);
  s0IniPropStocker1.Items.AddAllProp(FVerMan, k0ialInstance);
end;

procedure Tfrm8VerManMain.FormCreate(Sender: TObject);
begin
//
end;

procedure Tfrm8VerManMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FVerMan);
  FreeAndNil(FFinder);
end;

procedure Tfrm8VerManMain.FormShow(Sender: TObject);
begin
  PrepareUnified(s0UnifiedObjCtrl1, FVerMan, ['Tag'],
    ['BaseDir', 'WorkDir', 'MonitorDir']);
  PrepareUnified(s0UnifiedObjCtrl2, FFinder, ['Tag', 'Active', 'SearchDir'],
    ['', '']);
end;

procedure Tfrm8VerManMain.actBeginMonitoringExecute(Sender: TObject);
begin
  FVerMan.BeginMonitoring;
end;

procedure Tfrm8VerManMain.actEndMonitoringExecute(Sender: TObject);
begin
  FVerMan.EndMonitoring;
end;

procedure Tfrm8VerManMain.VerManAfterNewVersions(Sender: TObject);
begin
  RefreshViews;
end;

procedure Tfrm8VerManMain.PrepareUnified(AUnified: Ts0UnifiedObjCtrl;
  ATarget: TObject; AInvisibles: array of string; ALongSize: array of string);
var
  tmp: Ts0ProtoTypeCtrl;
  i: Integer;
begin
  AUnified.Target := ATarget;
  for i := Low(AInvisibles) to High(AInvisibles) do
  begin
    tmp := AUnified.ProtoTypes.FindPropCtrls(AInvisibles[i]);
    if tmp <> nil then
      tmp.WithoutCtrl := True;
  end;
  for i := Low(ALongSize) to High(ALongSize) do
  begin
    tmp := AUnified.ProtoTypes.FindPropCtrls(ALongSize[i]);
    if tmp <> nil then
      tmp.Size := 150;
  end;
  AUnified.BuildCtrls;
  AUnified.LoadFromTarget;
end;

procedure Tfrm8VerManMain.lstFileNamesDblClick(Sender: TObject);
begin
  if lstFileNames.ItemIndex < 0 then Exit;
  ShowHistory(lstFileNames.Items.Strings[lstFileNames.ItemIndex]);
end;

procedure Tfrm8VerManMain.actBeginMonitoringUpdate(Sender: TObject);
begin
  actBeginMonitoring.Enabled := not FVerMan.Monitoring;
end;

procedure Tfrm8VerManMain.actEndMonitoringUpdate(Sender: TObject);
begin
  actEndMonitoring.Enabled := FVerMan.Monitoring;
end;

procedure Tfrm8VerManMain.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure Tfrm8VerManMain.RefreshViews;
  procedure RefreshVerChecks;
    procedure RefreshColTitles(AFileNames: TStrings);
    var
      curDir: string;
      bindStartCol: Integer;
      i: Integer;
    begin
      curDir := '';
      bindStartCol := 1;
      for i := 0 to AFileNames.Count -1 do
      begin
        grdVerCheck.Cells[i +1, 0] := '';
        if curDir <> ExtractFileDir(AFileNames.Strings[i]) then
        begin
          if i <> 0 then
          begin
            grdVerCheck.BindSeals.AddDeco(bindStartCol, 0, i, 0, );
            bindStartCol :=  i + 1;
          end;
          curDir := ExtractFileDir(AFileNames.Strings[i]);
          grdVerCheck.Cells[i +1, 0] := curDir;
        end;
        grdVerCheck.Cells[i +1, 1] := ExtractFileName(AFileNames.Strings[i]);
      end;
      if bindStartCol < AFileNames.Count then
        grdVerCheck.BindSeals.AddDeco(bindStartCol, 0, AFileNames.Count, 0, );
    end;
    procedure SpreadDeco(ADeco: Ts0CellDecorator);
    begin
      ADeco.Right  := grdVerCheck.ColCount -1;
      ADeco.Bottom := grdVerCheck.RowCount -1;
    end;
  var
    i, j: Integer;
    spNames: TStringList;
    fileNames: TStringList;
    sl: TStringList;
    rfn: string;
  begin
    grdVerCheck.ColCount := FVerMan.Items.Count +1;
    grdVerCheck.ColWidths[0] := 40;
      fileNames := TStringList.Create;
    spNames := TStringList.Create.Create;
    try
      FVerMan.GetSavePointDirs(spNames);
      grdVerCheck.RowCount := spNames.Count +2;
      SpreadDeco(grdVerCheck.CtrlDecos[0]);
      SpreadDeco(grdVerCheck.ReadOnlySeals[0]);
      try
        FVerMan.Items.GetFileNames(fileNames);
        fileNames.Sort;
        RefreshColTitles(fileNames);
        sl := TStringList.Create;
        try
          for i := 0 to spNames.Count -1 do
          begin
            sl.Clear;
            grdVerCheck.Cells[0, i +2] := ExtractFileName(spNames.Strings[i]);
            FVerMan.GetRelFileNamesBySP(i, sl);
            for j := 0 to fileNames.Count -1 do
            begin
              rfn := FVerMan.Items.FindItem(fileNames.Strings[j]).GetRelFileName;
              grdVerCheck.Cells[j +1, i +2] :=
                UpperCase( Ts0TypeConv.BoolToStr(sl.IndexOf(rfn) > -1));
            end;
          end;
        finally
          FreeAndNil(sl);
        end;
      finally
        FreeAndNil(fileNames);
      end;
    finally
      FreeAndNil(spNames);
    end;
  end;
var
  sl: TStringList;
begin
  lstFileNames.Items.Clear;
  sl := TStringList.Create;
  try
    FVerMan.Items.GetFileNames(sl);
    //
    lstFileNames.Items.Assign(sl);
    RefreshVerChecks;    
  finally
    FreeAndNil(sl);
  end;
end;

procedure Tfrm8VerManMain.grdVerCheckDblClick(Sender: TObject);
  function GetDirName(ACol: Integer): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := ACol downto 1 do
    begin
      Result := grdVerCheck.Cells[i, 0];
      if Result <> '' then Exit;
    end;
  end;
var
  s: string;
begin
  s := GetDirName(grdVerCheck.Col);
  if s = '' then Exit;
  s := IncludeTrailingBackslash(s) + grdVerCheck.Cells[grdVerCheck.Col, 1];
  ShowHistory(s);
end;

procedure Tfrm8VerManMain.ShowHistory(AFileName: string);
var
  frm: Tfrm8VersionHistory;
begin
  frm := Tfrm8VersionHistory.Create(nil);
  try
    frm.TargetItem := FVerMan.Items.FindItem(AFileName);
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;
end;

procedure Tfrm8VerManMain.actRefreshVerFilesExecute(Sender: TObject);
begin
  FVerMan.FindItems;
  RefreshViews;
end;

procedure Tfrm8VerManMain.actFindModifyExecute(Sender: TObject);
begin
  FVerMan.MakeNewVersions;
  RefreshViews;
end;

procedure Tfrm8VerManMain.actFileHistoryExecute(Sender: TObject);
begin
  if PageControl1.ActivePage = tabFileNames then
    lstFileNamesDblClick(nil)
  else
  if PageControl1.ActivePage = tabSavePoints then
    grdVerCheckDblClick(nil);
end;

end.
