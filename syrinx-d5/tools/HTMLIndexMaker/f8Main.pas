unit f8Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, s0TreeViewController, StdCtrls, ExtCtrls,
  s0TaggedPage,
  s0TagBookMarker,
  s0TagWriter,
  s0TagReader, s0FileFinder, s0ObjCtrlBuilder, s0UnifiedObjCtrl, s0Edit,
  s0Memo, s0Label, CheckLst, s0CheckListBox, s0CheckBox, s0VCLClasses;

type
  Tfrm8Main = class(TForm)
    s0FileFinder1: Ts0FileFinder;
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    Splitter1: TSplitter;
    s0UnifiedObjCtrl1: Ts0UnifiedObjCtrl;
    mmoMasks1: Ts0Memo;
    lblMasks1: Ts0Label;
    edtSearchDir1: Ts0Edit;
    lblSearchDir1: Ts0Label;
    chkSubDir1: Ts0CheckBox;
    CheckListBox1: TCheckListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private êÈåæ }
    FReader: Ts0TagReader;
    FWriter: Ts0TagWriter;
    FPage: Ts0TaggedPage;
    FMarker: Ts0TagBookMarker;
  public
    { Public êÈåæ }
  end;

var
  frm8Main: Tfrm8Main;

implementation

uses
  s0CType,
  s0StringHelper,
  s0FileNameHelper,
  s0Collection;

{$R *.DFM}

procedure Tfrm8Main.FormCreate(Sender: TObject);
begin
  FPage := Ts0TaggedPage.Create(nil);
  FReader := Ts0TagReader.Create(nil);
  FReader.Page := FPage;
  FWriter := Ts0TagWriter.Create(nil);
  FWriter.Page := FPage;
  FMarker := Ts0TagBookMarker.Create(nil);
  FMarker.Target := FPage;
end;

procedure Tfrm8Main.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMarker);
  FreeAndNil(FWriter);
  FreeAndNil(FReader);
  FreeAndNil(FPage);
end;

procedure Tfrm8Main.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  s0FileFinder1.Search;
  if s0FileFinder1.ResultList is TStringList then
    TStringList(s0FileFinder1.ResultList).Sort;
  CheckListBox1.Items.Clear;
  CheckListBox1.Items.Assign(s0FileFinder1.ResultList);
  for i := 0 to CheckListBox1.Items.Count -1 do
    CheckListBox1.Checked[i] := (Pos('_index.htm', CheckListBox1.Items.Strings[i]) < 1);
end;

procedure Tfrm8Main.Button2Click(Sender: TObject);
  procedure ClearMarkTags(APage: Ts0TaggedPage);
  var
    lst: Ts0CollectionItemList;
    i: Integer;
    t: Ts0Tag;
  begin
    lst := Ts0CollectionItemList.Create(False);
    try
      FPage.Contents.FindByTagName(lst, 'a');
      for i := 0 to lst.Count -1 do
      begin
        Assert(lst.Items[i] is Ts0Tag);
        t := Ts0Tag(lst.Items[i]);
        if t.Params.IndexOfName('name') < 0 then Continue;
        Assert(t.Collection is Ts0Tags);
        Ts0Tags(t.Collection).RemoveTag(t);
      end;
    finally
      FreeAndNil(lst);
    end;
  end;
var
  i: Integer;
begin
  FWriter.Page := FPage;
  FMarker.FindTags.Assign(Memo1.Lines);
  for i := 0 to CheckListBox1.Items.Count -1 do
  begin
    if not CheckListBox1.Checked[i] then Continue;
    FPage.FileName := CheckListBox1.Items.Strings[i];
    FReader.Execute;
    ClearMarkTags(FPage);
    FMarker.Execute;
    FWriter.Execute;
  end;
end;

procedure Tfrm8Main.Button3Click(Sender: TObject);
  function GetPageTitle(APage: Ts0TaggedPage): string;
  var
    t: Ts0Tag;
  begin
    Result := '';
    t := APage.Contents.FindTag('title');
    if t = nil then Exit;
    Result := t.FindDescription;
    if Result <> '' then
      Result := Result + ' Index';
  end;
  procedure FindMarks(Dest: Ts0CollectionItemList; APage: Ts0TaggedPage);
  var
    i: Integer;
    t: Ts0Tag;
  begin
    APage.Contents.FindByTagName(Dest, 'a');
    for i := Dest.Count -1 downto 0 do
    begin
      Assert(Dest.Items[i] is Ts0Tag);
      t := Ts0Tag(Dest.Items[i]);
      if t.Params.IndexOfName('name') <> 0 then
        Dest.Remove(t);
    end;
  end;
  function GetRefParamValue(APage, ANewPage: Ts0TaggedPage; AMark: Ts0Tag): string;
  begin
    Result := '';
    if AMark.Params.Values['name'] = '' then Exit;
    Result := ExtractRelativePath(ExtractFilePath(ANewPage.FileName), APage.FileName);
    Result := Result +'#'+ Ts0StringHelper.ExtractQuotedStr(AMark.Params.Values['name'], '"');
  end;
  function GetNewPageFileName(AOriginal: string): string;
  var
    base, ext: string;
  begin
    base := ChangeFileExt(ExtractFileName(AOriginal), '');
    ext := ExtractFileExt(AOriginal);
    Result := IncludeTrailingPathDelimiter(Edit2.Text) + base + '_index' + ext;
  end;
  function BuildHTMLTemplate(APage, ANewPage: Ts0TaggedPage): Ts0Tag; //Result is "body"
  var
    html, head, title: Ts0Tag;
  begin
    ANewPage.FileName := GetNewPageFileName(APage.FileName);
    html := ANewPage.Contents.AddTag('html');
      head := html.Contents.AddTag('head');
        title := head.Contents.AddTag('title');
          title.Contents.AddDescription( GetPageTitle(APage) );
        head.Contents.AddTagWithParam('base', [ Format('target="%s"', [Edit1.Text]) ]);
      Result := html.Contents.AddTag('body');
  end;

  function GetOriginalH(AMark: Ts0Tag): Integer;
  var
    originalH: Ts0Tag;
  begin
    Result := 5;
    originalH := AMark.Contents.FindTag('h?', [k0tfoUseMask, k0tfoIgnoreCase]);
    if originalH <> nil then
      Result := StrToIntDef(originalH.TagName[2], 0);
  end;

  function GetSpace(ACount: Integer): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := 2 to ACount do
      Result := Result + '&nbsp;&nbsp;';
  end;

  procedure AddLink(ABody: Ts0Tag; APage, ANewPage: Ts0TaggedPage);
  var
    lst: Ts0CollectionItemList;
    i: Integer;
    mrk: Ts0Tag;
    link: Ts0Tag;
    indent: Integer;
  begin
    lst := Ts0CollectionItemList.Create(False);
    try
      FindMarks(lst, APage);
      for i := 0 to lst.Count -1 do
      begin
        mrk := Ts0Tag(lst.Items[i]);
        indent := GetOriginalH(mrk); 
        ABody.Contents.AddDescription( GetSpace(indent) );
        link := ABody.Contents.AddTagWithParam('a',
          [ Format('href="%s"', [GetRefParamValue(APage, ANewPage, mrk)]) ]);
        //h := link.Contents.AddTag( 'h'+ IntToStr(indent) );
        //h.Contents.AddDescription(Trim(mrk.FindDescription));
        link.Contents.AddDescription( Trim(mrk.FindDescription));
        ABody.Contents.AddTag('br');
      end;
    finally
      FreeAndNil(lst);
    end;
  end;
  procedure SaveIndexPage(APage: Ts0TaggedPage);
  var
    newPage: Ts0TaggedPage;
  begin
    newPage := Ts0TaggedPage.Create(nil);
    try
      AddLink( BuildHTMLTemplate(APage, newPage), APage, newPage);
      FWriter.Page := newPage;
      FWriter.Execute;
      FWriter.Page := nil;
    finally
      FreeAndNil(newPage);
    end;
  end;
var
  i: Integer;
begin
  for i := 0 to CheckListBox1.Items.Count -1 do
  begin
    if not CheckListBox1.Checked[i] then Continue;
    FPage.FileName := CheckListBox1.Items.Strings[i];
    FReader.Execute;
    SaveIndexPage(FPage);
  end;
end;

end.
