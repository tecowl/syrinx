unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0TaggedPage, s0TagReader, StdCtrls, ComCtrls, s0TreeViewController,
  ExtCtrls, ImgList, s0VCLClasses;

type
  T8Tag = class(Ts0Tag)
  private
    FSelected: Boolean;
  public
    constructor Create(ACollection: TCollection); override;
  published
    property Selected: Boolean read FSelected write FSelected default True;
  end;

type
  T8Page = class(Ts0TaggedPage)
  protected
    function NewTags: Ts0Tags; override;
  end;

type
  TForm3 = class(TForm)
    TreeView1: TTreeView;
    Edit1: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    s0TreeViewController1: Ts0TreeViewController;
    Image1: TImage;
    TreeView2: TTreeView;
    Image2: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    TreeView3: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private êÈåæ }
    FPage: Ts0TaggedPage;
    FReader: Ts0TagReader;
  public
    { Public êÈåæ }
  end;

var
  Form3: TForm3;

implementation

uses
  s0CheckDrawer;

{$R *.DFM}

procedure TForm3.FormCreate(Sender: TObject);
var
  bmp: TBitmap;
  r: TRect;
begin
  FPage := T8Page.Create(nil);
  FReader := Ts0TagReader.Create(nil);

  //
  bmp := TBitmap.Create;
  try
    bmp.Height := 16;
    bmp.Width := 16;
    r := Rect(0, 0, 15, 15);
    bmp.Canvas.Pen.Color := clBlack;
    bmp.Canvas.Brush.Color := clWindow;
    Ts0CheckDrawer.DrawTo(bmp.Canvas, r, cbUnchecked);
    Image1.Picture.Assign(bmp);

    Ts0CheckDrawer.DrawTo(bmp.Canvas, r, cbChecked);
    Image2.Picture.Assign(bmp);

    Ts0CheckDrawer.DrawTo(bmp.Canvas, r, cbGrayed);
    Image3.Picture.Assign(bmp);

    ImageList1.Add(Image1.Picture.Bitmap, nil);
    ImageList1.Add(Image2.Picture.Bitmap, nil);
    ImageList1.Add(Image3.Picture.Bitmap, nil);




    Self.Canvas.BrushCopy(r, bmp, r, clBlack);
//    bmp.Canvas.CopyRect( r, Self.Canvas, r);
  finally
    FreeAndNil(bmp);
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then Exit;
  Edit1.Text := OpenDialog1.FileName;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  FPage.FileName := Edit1.Text;
  FReader.Page := FPage;
  FReader.PolicyName := 'HTML';
  FReader.Execute;
  TreeView1.Items.BeginUpdate;
  try
    TreeView1.Items.Clear;
    s0TreeViewController1.Model := FPage.Contents;
    s0TreeViewController1.RefreshView;
  finally
    TreeView1.Items.EndUpdate;
  end;
  //
  if TreeView1.StateImages <> nil then
    TreeView2.StateImages := TreeView1.StateImages;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FPage);
  FreeAndNil(FReader);
end;

{ T8Page }

function T8Page.NewTags: Ts0Tags;
begin
  Result := Ts0Tags.Create(Self, T8Tag);
end;

{ T8Tag }

constructor T8Tag.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FSelected := True;
end;

initialization
  RegisterClass(T8Tag);

end.
