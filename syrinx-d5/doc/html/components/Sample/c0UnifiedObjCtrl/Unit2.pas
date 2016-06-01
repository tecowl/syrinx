unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  c0ObjCtrlBuilder, c0UnifiedObjCtrl, StdCtrls, c0Button;

type
  (*
    �T���v���p�̃N���X
    ���̂悤�ȃN���X�́A�{���A�t�H�[���Ɠ������j�b�g�ɐ錾����ׂ��ł�
    ����܂��񂪁A����̓T���v���Ƃ������Ƃŕ֋X�㓯�����j�b�g�ɐ錾���Ă��܂��B
    ���������������B

    TSampleObj��TComponent����h�����Ă��܂����A�����Tc0UnifiedObjCtrl��
    �ǂݏ����ł���published�̃v���p�e�B��錾�ł���̂��ATPersistent�N���X��
    �h���N���X������ł��i���m�ɂ�{M+}��ԂŃR���p�C�����ꂽ�N���X�̔h���N���X
    �Ȃ�Ηǂ��j�B

    TPersistent����h�����Ȃ��̂́A�T���v�����ŊȒP�ɂ��̓��e���X�g���[����
    �o�͂��邽�߂ŁA������s��Ȃ��̂Ȃ��TPersistent����h������
    �����悢�ł��傤�B

    TComponent�ȉ��A�R���|�[�l���g�p���b�g�ɂ���R���|�[�l���g�͂��ׂāA
    TPersistent����h�����Ă���A�݌v���ɃI�u�W�F�N�g�C���X�y�N�^�Œl��ύX
    �ł���̂��Apublished�Ő錾����Ă��邽�߂ł��B
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
    { Private �錾 }
    FObj: TSampleObj;
  public
    { Public �錾 }
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
