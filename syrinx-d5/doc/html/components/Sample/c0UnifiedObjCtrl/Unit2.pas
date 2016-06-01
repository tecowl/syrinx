unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  c0ObjCtrlBuilder, c0UnifiedObjCtrl, StdCtrls, c0Button;

type
  (*
    サンプル用のクラス
    このようなクラスは、本来、フォームと同じユニットに宣言するべきでは
    ありませんが、これはサンプルということで便宜上同じユニットに宣言しています。
    ご了承ください。

    TSampleObjはTComponentから派生していますが、これはTc0UnifiedObjCtrlが
    読み書きできるpublishedのプロパティを宣言できるのが、TPersistentクラスの
    派生クラスだからです（正確には{M+}状態でコンパイルされたクラスの派生クラス
    ならば良い）。

    TPersistentから派生しないのは、サンプル中で簡単にその内容をストリームへ
    出力するためで、それを行わないのならばTPersistentから派生する
    方がよいでしょう。

    TComponent以下、コンポーネントパレットにあるコンポーネントはすべて、
    TPersistentから派生しており、設計時にオブジェクトインスペクタで値を変更
    できるのも、publishedで宣言されているためです。
  *)
  TSampleObj = class(TComponent)
  private
    FValue: Integer;
    FText: string;
    procedure SetText(const Value: string);
    procedure SetValue(const Value: Integer);
  published
    property Value: Integer read FValue write SetValue;
    property Text: string read FText write SetText;
  end;

type
  TForm2 = class(TForm)
    ScrollBox1: TScrollBox;
    c0UnifiedObjCtrl1: Tc0UnifiedObjCtrl;
    c0Button1: Tc0Button;
    c0Button2: Tc0Button;
    c0Button3: Tc0Button;
    c0Button4: Tc0Button;
    c0Button5: Tc0Button;
    Memo1: TMemo;
    procedure c0Button1Click(Sender: TObject);
    procedure c0Button2Click(Sender: TObject);
    procedure c0Button3Click(Sender: TObject);
    procedure c0Button4Click(Sender: TObject);
    procedure c0Button5Click(Sender: TObject);
  private
    { Private 宣言 }
    FObj: TSampleObj;
  public
    { Public 宣言 }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

{ TSampleObj }

procedure TSampleObj.SetText(const Value: string);
begin
  FText := Value;
end;

procedure TSampleObj.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

{ TForm2 }

procedure TForm2.c0Button1Click(Sender: TObject);
begin
  if FObj = nil then
    FObj := TSampleObj.Create(nil);
end;

procedure TForm2.c0Button2Click(Sender: TObject);
begin
  FreeAndNil(FObj);
end;

procedure TForm2.c0Button3Click(Sender: TObject);
begin
  c0UnifiedObjCtrl1.Builder.CtrlParent := ScrollBox1;
  c0UnifiedObjCtrl1.Target := FObj;
  c0UnifiedObjCtrl1.BuildCtrls;
end;

procedure TForm2.c0Button4Click(Sender: TObject);
begin
  c0UnifiedObjCtrl1.ClearCtrls;
  c0UnifiedObjCtrl1.ProtoTypes.Clear;
  c0UnifiedObjCtrl1.Target := nil;
end;

procedure TForm2.c0Button5Click(Sender: TObject);
var
  ms1, ms2: TMemoryStream;
begin
  ms1 := TMemoryStream.Create;
  try
    ms1.WriteComponent(FObj);
    ms2 := TMemoryStream.Create;
    try
      ms1.Position := 0;
      ObjectBinaryToText(ms1, ms2);
      ms2.Position := 0;
      Memo1.Lines.LoadFromStream(ms2);
    finally
      FreeAndNil(ms2);
    end;            
  finally
    FreeAndNil(ms1);
  end;
end;

end.
