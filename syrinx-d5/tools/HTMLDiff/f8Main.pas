unit f8Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, s0TextComparer, s0TaggedPage, s0TagPolicy,
  s0TagWriter, s0ComparedToHTML, s0ObjPropStocker, s0IniPropStocker,
  s0ComponentEventWrapper, s0FormEventPublisher;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    s0ComparedToHTML1: Ts0ComparedToHTML;
    s0TagWriter1: Ts0TagWriter;
    s0TaggedPage1: Ts0TaggedPage;
    s0TextComparer1: Ts0TextComparer;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Edit2: TEdit;
    s0IniPropStocker1: Ts0IniPropStocker;
    s0FormEventPublisher1: Ts0FormEventPublisher;
    procedure Button1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

uses
  s0FileNameHelper;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
  html, body: Ts0Tag;
  table: Ts0Tag;
begin
  for i := 0 to Memo1.Lines.Count -2 do
  begin
    s0TextComparer1.CompareResult.BeginUpdate;
    try
      if Trim(Memo1.Lines[i   ]) = '' then Continue; 
      if Trim(Memo1.Lines[i +1]) = '' then Continue;
      s0TextComparer1.Source[kskOne].LoadFromFile(Memo1.Lines[i   ]);
      s0TextComparer1.Source[kskTwo].LoadFromFile(Memo1.Lines[i +1]);
      s0TextComparer1.Compare;
    finally
      s0TextComparer1.CompareResult.EndUpdate;
    end;
    //
    s0TaggedPage1.Contents.BeginUpdate;
    try
      s0TaggedPage1.Contents.Clear;
      s0ComparedToHTML1.Execute;
      table := s0TaggedPage1.Contents[0];
      html := s0TaggedPage1.Contents.InsertTag(0, 'html');
      html.Contents.AddTag('head');
      body := html.Contents.AddTag('body');
      table.MoveWithPair(body);
    finally
      s0TaggedPage1.Contents.EndUpdate;
    end;
    s0TaggedPage1.FileName := Edit1.Text + IntToStr(i +1) + '.html';
    if Edit2.Text <> '' then
      s0TaggedPage1.FileName := IncludeTrailingPathDelimiter(Edit2.Text) + s0TaggedPage1.FileName;
    //
    s0TagWriter1.Execute;  
  end;
end;

end.
