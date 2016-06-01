unit s0InputStyle;
{
$History: s0InputStyle.pas $
 * 
 * *****************  Version 15  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 14  *****************
 * User: Akima        Date: 02/03/15   Time: 4:41
 * Updated in $/D5/source/VCL
 * フォントが変更されたときに、サイズが不正に変更されてしまう不具合を修正
 * 
 * *****************  Version 13  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 * 
 * *****************  Version 12  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 * 
 * *****************  Version 11  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 10  *****************
 * User: Akima        Date: 02/02/08   Time: 2:35
 * Updated in $/source/D6VCLIntegrated
 * Ts0InputStyleにFontプロパティを追加。
 * また、Fontの変更にともなって自動的にWidthを変更するAutoWidth関連も修正
 * 。
 * 
 * *****************  Version 9  *****************
 * User: Akima        Date: 01/12/12   Time: 18:57
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 8  *****************
 * User: Akima        Date: 01/12/12   Time: 18:56
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 7  *****************
 * User: Akima        Date: 01/11/28   Time: 1:59
 * Updated in $/source/D5Integrated
 * GetTile、SetTitleを実装
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 01/11/22   Time: 18:51
 * Updated in $/source/D5Integrated
 * [変更] Textプロパティを外部から使用できないように、Protectedに。
 * [変更] Ｔｅｘｔプロパティにwriteアクセサを用意して、値を設定できるよう
 * にした。
 * [変更] Ts0InputStyle.ChangeText;でMaxLength以上の長さの文字列が入力されて
 * いた場合には、MaxLengthの長さに切り取るように変更
 * [変更] AcceptCharTypeのデフォルト値を変更
 * [修正] SetAcceptCharTypeメソッドでImeModeを操作してしまっていたので、や
 * めた。
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 01/10/05   Time: 14:19
 * Updated in $/source/D5Integrated
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 01/09/21   Time: 13:15
 * Updated in $/source/D5Integrated
 * SetAutoWidthの実装を行った。
 * AutoWidthMarginプロパティを追加
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/08/08   Time: 15:39
 * Updated in $/source/p0control
 * EditMaskプロパティを削除
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/08   Time: 10:05
 * Updated in $/source/p0control
 * abstractメソッドをちょっと変更
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/08/07   Time: 22:00
 * Created in $/source/p0control
 * 新規作成
 * T0InputStrategyを元にちょっと変更した。
}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms, StdCtrls,
  s0CommonTypes,
  s0VCLClasses,
  s0StringValidater;

type
  Ts0InputStyleClass = class of Ts0InputStyle;
  Ts0InputStyle = class(Ts0VCLPersistent)
  private
    FOnFilledUp: TNotifyEvent;
    FControl: TWinControl;
    FAutoTab: Boolean;
    FAcceptCharType: k1InpCharSet;
    FExclusiveAcceptChar: string;
    FCancelAutoTab: Boolean;
    FMoveFocusOnFilledUp: Boolean;
    FAutoWidth: Boolean;
    FTitleDisplay: TCustomLabel;
    FAutoWidthMargin: Integer;
    FResizingCtrl: Boolean;
  protected
    function GetAlignment: TAlignment; virtual; abstract;
    function GetCharCase: TEditCharCase; virtual; abstract;
    function GetFont: TFont; virtual; abstract;
    function GetImeMode: TImeMode; virtual; abstract;
    function GetImeName: TImeName; virtual; abstract;
    function GetMaxLength: Integer; virtual; abstract;
    function GetModified: Boolean; virtual; abstract;
    function GetReadOnly: Boolean; virtual; abstract;
    procedure SetAlignment(const Value: TAlignment); virtual; abstract;
    procedure SetCharCase(const Value: TEditCharCase); virtual; abstract;
    procedure SetFont(const Value: TFont); virtual; abstract;
    procedure SetImeMode(const Value: TImeMode); virtual; abstract;
    procedure SetImeName(const Value: TImeName); virtual; abstract;
    procedure SetMaxLength(const Value: Integer); virtual; abstract;
    procedure SetModified(const Value: Boolean); virtual; abstract;
  protected
    function GetText: string; virtual; abstract;
    procedure SetText(const Value: string); virtual; abstract;
  protected
    function GetControl: TWinControl; virtual;
    function GetTitle: string; virtual;
    procedure SetAcceptCharType(const Value: k1InpCharSet); virtual;
    procedure SetAutoWidth(const Value: Boolean); virtual;
    procedure SetReadOnly(const Value: Boolean); virtual;
    procedure SetTitle(const Value: string); virtual;
    procedure SetTitleDisplay(const Value: TCustomLabel); virtual;
  protected
    procedure DoFilledUp;
    procedure FilledUp;
    procedure FontChanged;
    function GetCtrlAutoWidth: Integer;
    property AutoWidthMargin: Integer read FAutoWidthMargin write FAutoWidthMargin default 0;
    property Text: string read GetText write SetText;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ChangeText; virtual;
    procedure CMSetReadOnly(var AColor, AFontColor: TColor); virtual;
    function KeyPress(var Key: Char): Boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property Control: TWinControl read GetControl;
    property CancelAutoTab: Boolean read FCancelAutoTab write FCancelAutoTab;
    property ResizingCtrl: Boolean read FResizingCtrl write FResizingCtrl;
    property OnFilledUp: TNotifyEvent read FOnFilledUp write FOnFilledUp;
  public
    procedure SelectAll; virtual; //abstract;
    procedure Deselect; virtual; //abstract;
  published
    { Control's Property }
    property Alignment: TAlignment read GetAlignment write SetAlignment;
    property CharCase: TEditCharCase read GetCharCase write SetCharCase default
      ecNormal;
    property Font: TFont read GetFont write SetFont;
    property ImeMode: TImeMode read GetImeMode write SetImeMode default
      imDontCare;
    property ImeName: TImeName read GetImeName write SetImeName;
    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    property Modified: Boolean read GetModified write SetModified;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
  published
    { Original Property }
    property AcceptCharType: k1InpCharSet read FAcceptCharType write
      SetAcceptCharType default [k1ctalpha..k1ctkana];
    property AutoTab: Boolean read FAutoTab write FAutoTab default True;
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default True;
    property ExclusiveAcceptChar: string read FExclusiveAcceptChar write
      FExclusiveAcceptChar;
    property Title: string read GetTitle write SetTitle;
    property TitleDisplay: TCustomLabel read FTitleDisplay write SetTitleDisplay;
  end;

implementation

uses
{$IFDEF VER130}
  s0CtrlDistiller,
{$ENDIF}
  s0Ctype,
  s0ControlHelper;

type
  T9FontChageNotifier = class(TInterfacedObject, IChangeNotifier)
  private
    FOwner: Ts0InputStyle;
  public
    constructor Create(AOwner: Ts0InputStyle); reintroduce;
    procedure Changed;
  end;

{ T9FontChageNotifier }

procedure T9FontChageNotifier.Changed;
begin
  FOwner.FontChanged;
end;

constructor T9FontChageNotifier.Create(AOwner: Ts0InputStyle);
begin
  inherited Create;
  FOwner := AOwner;
end;

{ Ts0InputStyle }

procedure Ts0InputStyle.Assign(Source: TPersistent);
var
  src: Ts0InputStyle;
begin
  if not(Source is Ts0InputStyle) then Exit;
  src := Ts0InputStyle(Source);
  Self.AcceptCharType := src.AcceptCharType;
  Self.Alignment := src.Alignment;
  Self.AutoTab := src.AutoTab;
  Self.CharCase := src.CharCase;
  Self.Font := src.Font;
  Self.ExclusiveAcceptChar := src.ExclusiveAcceptChar;
  Self.ImeMode := src.ImeMode;
  Self.ImeName := src.ImeName;
  Self.MaxLength := src.MaxLength;
  Self.ReadOnly := src.ReadOnly;
  Self.FMoveFocusOnFilledUp := src.FMoveFocusOnFilledUp;
  Self.FOnFilledUp := src.FOnFilledUp;
end;

procedure Ts0InputStyle.ChangeText;
begin
  if not AutoTab then
    Exit;
  if MaxLength = 0 then
    Exit;
  if Control = nil then
    Exit;
  if not Modified then
    Exit;
  if Length(Text) > MaxLength then
   Text := Copy(Text, 1, MaxLength);
  if Length(Text) >= MaxLength then
    FilledUp;
end;

procedure Ts0InputStyle.CMSetReadOnly(var AColor, AFontColor: TColor);
begin

end;

constructor Ts0InputStyle.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FAutoWidth := True;
  if AOwner is TWinControl then
    FControl := TWinControl(AOwner);
  FAutoTab := True;
  FAcceptCharType := [k1ctAlpha,k1ctDigit, k1ctSign ,{$IFNDEF NOIMEPROP} k1ctKana ,k1ctKanji {$ENDIF}];
  FExclusiveAcceptChar := '';
  FMoveFocusOnFilledUp := True;
  FAutoWidthMargin := 0;
  FResizingCtrl := False;
  if Font <> nil then
    Font.FontAdapter := T9FontChageNotifier.Create(Self);
end;

procedure Ts0InputStyle.Deselect;
begin
end;

destructor Ts0InputStyle.Destroy;
begin
  if Font <> nil then
    Font.FontAdapter := nil;
  inherited;
end;

procedure Ts0InputStyle.DoFilledUp;
begin
  if Assigned(FOnFilledUp) then
    FOnFilledUp(Control);
end;

procedure Ts0InputStyle.FilledUp;
begin
  if FMoveFocusOnFilledUp then
  begin
    if not Control.Focused then
      Exit;
    if FCancelAutoTab then
      Exit;
    Ts0ControlHelper.SetFocusNextControl(GetParentForm(Control));
  end
  else
    DoFilledUp;
end;

procedure Ts0InputStyle.FontChanged;
begin
  if AutoWidth and (MaxLength > 0) then
    Control.Width := GetCtrlAutoWidth;  
end;

function Ts0InputStyle.GetControl: TWinControl;
begin
  Result := FControl;
end;

function Ts0InputStyle.GetTitle: string;
begin
  Result := '';
  if FTitleDisplay <> nil then
  begin
{$IFDEF VER130}
    Result := Ts0CtrlDistillBroker.GetValue(FTitleDisplay);
{$ELSE}
    Result := FTitleDisplay.Caption;
{$ENDIF}
  end;
end;

function Ts0InputStyle.KeyPress(var Key: Char): Boolean;
begin
  Result := False;
  {選ばれた列挙型ﾌﾟﾛﾊﾟﾃｨに対応した関数で入力文字の有効性をﾁｪｯｸ}
  if Ts0StringValidater.validateChartype(AcceptCharType, [Key], True) then
    Result := True
  else if ExclusiveAcceptChar <> '' then
    {特別に入力可能とする文字列を検査}
    if Ts0StringValidater.validateExclusiveChar(ExclusiveAcceptChar, [Key]) then
      Result := True;

{$IFNDEF NOIMEPROP}
  if k1ctkanji in AcceptCharType then
    Result := Ts0Ctype.iscntrl(Key) or Result {制御キーはﾁｪｯｸ対象外}
  else
{$ENDIF}
    Result := Ts0Ctype.iscntrl(Key) or Result; {制御キーはﾁｪｯｸ対象外}
  //
  if not Result then
    Key := #0;
end;

procedure Ts0InputStyle.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation <> opRemove then Exit;
  if FTitleDisplay = AComponent then
    FTitleDisplay := nil;
end;

procedure Ts0InputStyle.SelectAll;
begin
end;

procedure Ts0InputStyle.SetAcceptCharType(const Value: k1InpCharSet);
begin
  FAcceptCharType := Value;
end;

procedure Ts0InputStyle.SetAutoWidth(const Value: Boolean);
begin
  FAutoWidth := Value;
  if MaxLength < 1 then Exit;
  if not FAutoWidth then Exit;
  Control.Width := GetCtrlAutoWidth;
end;

function Ts0InputStyle.GetCtrlAutoWidth: Integer;
  function GetWidthByVirtualCanvas: Integer;
  const
    c9TestStrs: array[Boolean] of string = ('_', 'ん');
    c9TestValue: array[Boolean] of Integer = (1, 2);
  var
    cnvs: TCanvas;
    hDCDsp: HDC;
    inMBCS: Boolean;
  begin
    inMBCS := k1ctkanji in AcceptCharType;
    hDCDsp := CreateDC('DISPLAY', nil, nil, nil);
    try
      cnvs := TCanvas.Create;
      try
        cnvs.Handle := hDCDsp;
        cnvs.Font.Assign(Font);
        Result := cnvs.TextWidth(c9TestStrs[inMBCS]) * MaxLength div c9TestValue[inMBCS];
        Result := Result + 20 + (cnvs.Font.Size -10) div 2 + FAutoWidthMargin;
      finally
        FreeAndNil(cnvs);
      end;
    finally
      DeleteDC(hDCDsp);
    end;
  end;
begin
  Result := Control.Width;
  if FResizingCtrl then Exit;
  if [csLoading, csReading] * Control.ComponentState <> [] then Exit;
  Result := GetWidthByVirtualCanvas;
end;

procedure Ts0InputStyle.SetReadOnly(const Value: Boolean);
begin
  if Control = nil then Exit;
  if Control.HandleAllocated then
    SendMessage(Control.Handle, EM_SETREADONLY, Ord(Value), 0);
end;

procedure Ts0InputStyle.SetTitle(const Value: string);
begin
  if FTitleDisplay <> nil then
  begin
{$IFDEF VER130}
    Ts0CtrlDistillBroker.SetValue(Value, FTitleDisplay);
{$ELSE}
    FTitleDisplay.Caption := Value;
{$ENDIF}
  end;

end;

procedure Ts0InputStyle.SetTitleDisplay(const Value: TCustomLabel);
begin
  FTitleDisplay := Value;
end;

end.
