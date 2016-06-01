unit s0CDSCopy;
//***************************************************************************
//*
//*  Name:	CDSManagerFABHH.pas
//*  Class:	Ts0CDSCopy
//*
//*
//*  目的
//*
//*  必要に応じてCDSのレイアウトやデータの内容に変更を加える。
//*  例
//*  ・フィールド名、値、型、サイズなどを変更する。
//*  ・一つのフィールドを二つのフィールドに分割する。
//*  ・条件でレコードを削除する。
//*  変更する必要のない部分はSourceと同じ値を持つことができる。
//*
//*
//*  概要
//*
//*  基本の流れ
//*  メソッドBuildLayout→メソッドCommitLayout→メソッドCopyDataを呼びだす。
//*
//*  イベントOnAddFieldDef、OnCopyRecord、OnCopyDataや基本の流れのメソッド間に
//*  必要なメソッドを付け加えることでいろいろなパターンが可能になる。
//*
//*  例１
//*  目的：フィールド名変更する
//*  方法：OnAddFieldDefイベントにイベントハンドラとなるメソッドを設定する。
//*  メソッドBuildLayoutが呼び出された時に設定されたイベントハンドラが呼び出され、
//*  その引数の値を変更することでフィールド名を変更することができる。
//*
//*  例２
//*  目的：一つのフィールドを二つのフィールドに分割する
//*  方法：メソッドAddFieldDefが呼び出し、コピー先にフィールドが追加する。
//*  OnCopyDataイベントにイベントハンドラとなるメソッドを設定する。
//*  メソッドCopyDataが呼び出された時にイベントハンドラが呼び出され、
//*  その引数を変更することで一つのフィールドを二つのフィールドに分割し、
//*  データが追加される。
//*
//*
//*  詳細
//*
//*  メソッドポインタ型
//*
//*・TCDSFieldDefEvent = procedure(Sender: TObject; pSource, pDest: TClientDataSet;
//*  	　pSourceField: TField; var pCopyField: Boolean;
//*    　var pNewDefInfo: TFieldDefineInfo) of object;
//*　引数
//*　pSource     ：コピー元
//*　pDest       ：コピー先
//*　pSourceField：コピー元のフィールド
//*　pCopyField  ：Boolean
//*　pNewDefInfo ：コピー後（変更後）のフィールド
//*
//*・TCDSRecordEvent = procedure(Sender: TObject; pSource, pDest: TClientDataSet;
//*  	var pCopyRecord: Boolean) of object;
//*　引数
//*　pSource     ：コピー元
//*　pDest       ：コピー先
//*　pCopyRecord ：Boolean
//*　
//*
//*
//****************************************************************************

{
$History: s0CDSCopy.pas $
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/09/25   Time: 17:21
 * Updated in $/source/D5Integrated
 * フィールドのコピー時にDisplayLabelとVisibleもコピーするように変更
 * 
 * *****************  Version 4  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:39
 * Updated in $/GUI/Source/Doc
 * コメント表示コマンド追加
}
interface

uses
	SysUtils, Classes, DB, DBClient;

type
	TFieldDefineInfo = packed record
    FieldName: string;
    DataType: TFieldType;
    Size: Integer;
    Required: Boolean;
  end;


type
	TCDSFieldDefEvent = procedure(Sender: TObject; pSource: TDataSet; pDest: TClientDataSet;
  	pSourceField: TField; var pCopyField: Boolean;
    var pNewDefInfo: TFieldDefineInfo) of object;

type
	TCDSRecordEvent = procedure(Sender: TObject; pSource: TDataSet; pDest: TClientDataSet;
  	var pCopyRecord: Boolean) of object;

type
	TCDSFieldValueEvent = procedure(Sender: TObject; pSource: TDataSet; pDest: TClientDataSet;
  	pDestField: TField; var pCopyData: Boolean) of object;


type
	Ts0CDSCopy = class(TComponent)
  private
    FCDSDest: TClientDataSet;
    FDSSource: TDataSet;
    FOnAddFieldDef: TCDSFieldDefEvent;
    FOnCopyData: TCDSFieldValueEvent;
    FOnCopyRecord: TCDSRecordEvent;
    FFieldPairList: TStrings;
    procedure SetCDSDest(const Value: TClientDataSet);
    procedure SetCDSSource(const Value: TDataSet);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoAddFieldDef(pSourceField: TField; var pCopyField: Boolean;
    	var pNewDefInfo: TFieldDefineInfo); virtual;
    procedure DoCopyRecord(var pCopyRecord: Boolean); virtual;
    procedure DoCopyData(pDestField: TField; var pCopyData: Boolean); virtual;
    procedure CopyFieldData(pDestField: TField);
  public
  	constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AutoExecute;
  	procedure BuildLayout(pClearDef: Boolean = True);
    procedure CommitLayout;
    procedure CopyData;
    procedure AddFieldDefInfo(pOriginal: TField; pDefInfo: TFieldDefineInfo);
    procedure AddFieldDef(pOriginal: TField; pFieldName: string; pDataType: TFieldType;
    	pSize: Integer = 0; pRequired: Boolean = False);
    procedure AddFieldPair(pDestFieldName: string; pSourceField: TField);
    procedure ClearPairList;
  published
  	property CDSDest: TClientDataSet read FCDSDest write SetCDSDest;
  	property DSSource: TDataSet read FDSSource write SetCDSSource;
    property OnAddFieldDef: TCDSFieldDefEvent read FOnAddFieldDef write FOnAddFieldDef;
    property OnCopyRecord: TCDSRecordEvent read FOnCopyRecord write FOnCopyRecord;
    property OnCopyData: TCDSFieldValueEvent read FOnCopyData write FOnCopyData;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P DM', [Ts0CDSCopy]);
end;

{ Ts0CDSCopy }

procedure Ts0CDSCopy.AddFieldDefInfo(pOriginal: TField; pDefInfo: TFieldDefineInfo);
begin
  AddFieldDef(
    pOriginal,
  	pDefInfo.FieldName,
    pDefInfo.DataType,
    pDefInfo.Size,
    pDefInfo.Required
  );
end;

procedure Ts0CDSCopy.AddFieldDef(pOriginal: TField; pFieldName: string;
  pDataType: TFieldType; pSize: Integer; pRequired: Boolean);
begin
  CDSDest.FieldDefs.Add(pFieldName, pDataType, pSize, pRequired);
  if pOriginal = nil then Exit;
  AddFieldPair(pFieldName, pOriginal);
end;

procedure Ts0CDSCopy.AddFieldPair(pDestFieldName: string; pSourceField: TField);
begin
  FFieldPairList.AddObject(pDestFieldName, pSourceField);
end;

procedure Ts0CDSCopy.AutoExecute;
begin
  BuildLayout(True);
  CommitLayout;
  CopyData;
end;

procedure Ts0CDSCopy.BuildLayout(pClearDef: Boolean);
var
	i: Integer;
  lCopyField: Boolean;
  lDef: TFieldDefineInfo;
begin
	ClearPairList;
  CDSDest.Active := False;
	if pClearDef then CDSDest.FieldDefs.Clear;
  for i := 0 to DSSource.Fields.Count -1 do
  begin
    lCopyField := True;
    lDef.FieldName := DSSource.Fields[i].FieldName;
    lDef.DataType  := DSSource.Fields[i].DataType ;
    lDef.Size      := DSSource.Fields[i].Size     ;
    lDef.Required  := DSSource.Fields[i].Required ;
  	DoAddFieldDef(DSSource.Fields[i], lCopyField, lDef);
    if not lCopyField then Continue;
    AddFieldDefInfo(DSSource.Fields[i], lDef);
  end;
end;

procedure Ts0CDSCopy.ClearPairList;
begin
  FFieldPairList.Clear;
end;

procedure Ts0CDSCopy.CommitLayout;
begin
	CDSDest.CreateDataSet;
end;

procedure Ts0CDSCopy.CopyData;
  procedure CopyFieldProps;
  var
    i: Integer;
    fld: TField;
  begin
    for i := 0 to CDSDest.Fields.Count -1 do
    begin
      fld := DSSource.FindField(CDSDest.Fields[i].FieldName);
      if fld = nil then Continue;
      CDSDest.Fields[i].DisplayLabel := fld.DisplayLabel;
      CDSDest.Fields[i].Visible := fld.Visible;
    end;
  end;
var
	i: Integer;
  lCopyRec, lCopyVal: Boolean;
begin
  DSSource.First;
  while not DSSource.Eof do
  begin
    lCopyRec := True;
    DoCopyRecord(lCopyRec);
    if lCopyRec then
    begin
      CDSDest.Insert;
      for i := 0 to CDSDest.Fields.Count -1 do
      begin
        lCopyVal := True;
        DoCopyData(CDSDest.Fields[i], lCopyVal);
        if not lCopyVal then Continue;
        CopyFieldData(CDSDest.Fields[i]);
      end;
      CDSDest.Post;
    end;
    DSSource.Next;
  end;
  //
  CopyFieldProps;
end;

procedure Ts0CDSCopy.CopyFieldData(pDestField: TField);
var
  idx: Integer;
	lSrc: TField;
begin
	idx := FFieldPairList.IndexOf(pDestField.FieldName);
  if idx < 0 then Exit;
  lSrc := TField( FFieldPairList.Objects[idx] );
  pDestField.Assign(lSrc);
end;

constructor Ts0CDSCopy.Create(AOwner: TComponent);
begin
  inherited;
  FFieldPairList := TStringList.Create;
  TStringList(FFieldPairList).Sorted := True;
  TStringList(FFieldPairList).Duplicates := dupError;
end;

destructor Ts0CDSCopy.Destroy;
begin
	FreeAndNil(FFieldPairList);
  inherited;
end;

procedure Ts0CDSCopy.DoAddFieldDef(pSourceField: TField;
  var pCopyField: Boolean; var pNewDefInfo: TFieldDefineInfo);
begin
  if Assigned(FOnAddFieldDef) then
    FOnAddFieldDef(Self, DSSource, CDSDest, pSourceField, pCopyField, pNewDefInfo);
end;

procedure Ts0CDSCopy.DoCopyData(pDestField: TField; var pCopyData: Boolean);
begin
  if Assigned(FOnCopyData) then
    FOnCopyData(Self, DSSource, CDSDest, pDestField, pCopyData);
end;

procedure Ts0CDSCopy.DoCopyRecord(var pCopyRecord: Boolean);
begin
  if Assigned(FOnCopyRecord) then
    FOnCopyRecord(Self, DSSource, CDSDest, pCopyRecord);
end;

procedure Ts0CDSCopy.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FCDSDest = AComponent then FCDSDest := nil;
  if FDSSource = AComponent then FDSSource := nil;
end;

procedure Ts0CDSCopy.SetCDSDest(const Value: TClientDataSet);
begin
  FCDSDest := Value;
end;

procedure Ts0CDSCopy.SetCDSSource(const Value: TDataSet);
begin
  FDSSource := Value;
end;


end.
