{-----------------------------------------------------------------------------
 Unit Name: s0DigitEdit
 Author:    Akima
 Purpose: 数値入力のためのコンポーネント。
 TestCase: tc_s0DigitEdit
$History: s0DigitEdit.pas $
 *
 * *****************  Version 27  *****************
 * User: Akima        Date: 02/03/15   Time: 4:40
 * Updated in $/D5/source/VCL
 * 入力時の不具合を修正
 *
 * *****************  Version 26  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
 *
 * *****************  Version 25  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX対応してます・・・・
 *
 * *****************  Version 24  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 *
 * *****************  Version 23  *****************
 * User: Akima        Date: 02/02/18   Time: 21:04
 * Updated in $/source/D5Integrated
 * IgnoreZeroOfHeadをpublishedにするのをわすれてた
 *
 * *****************  Version 22  *****************
 * User: Akima        Date: 02/02/14   Time: 22:06
 * Updated in $/source/D5Integrated
 * IgnoreZeroOfHeadプロパティを追加。
 * Trueの場合、先頭に0が付く0以外の数字が入力された場合、それを削除する。
 *
 * *****************  Version 21  *****************
 * User: Akima        Date: 02/02/13   Time: 12:32
 * Updated in $/source/D5Integrated
 * SetAsFloatメソッドで、単にFloatToStrを使用するように変更
 *
 * *****************  Version 20  *****************
 * User: Akima        Date: 01/12/19   Time: 21:46
 * Updated in $/source/D5Integrated
 * Ts0DigitEditAccessorを新たに定義した。
 * GetAsFloatがカンマを考慮してなかったので修正。
*
* * * * * * * * * * * * * * * * * * Version 19 * * * * * * * * * * * * * * * * *
* User: Akima Date: 01 / 12 / 19 Time: 18: 30
* Updated in $ / source / D5Integrated
*
* * * * * * * * * * * * * * * * * * Version 18 * * * * * * * * * * * * * * * * *
* User: Akima Date: 01 / 12 / 19 Time: 17: 47
* Updated in $ / source / D5Integrated
* IntegerMaxLength、DecimalMaxLength設定時のKeyPress以降の動作がおかしかったの
* で修正した
*
* * * * * * * * * * * * * * * * * * Version 17 * * * * * * * * * * * * * * * * *
* User: Akima Date: 01 / 12 / 18 Time: 16: 10
* Updated in $ / source / D5Integrated
* 上下キーでの数値の増減がうまくいってなかったので修正。
  *
  * * * * * * * * * * * * * * * * * * Version 16 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 18 Time: 11: 50
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 15 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 15 Time: 2: 04
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 14 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 13 Time: 12: 23
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 13 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 12 Time: 20: 55
* Updated in $ / source / D5Integrated
  * InputController - > InputStyle
  *
  * * * * * * * * * * * * * * * * * * Version 12 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 11 Time: 17: 33
* Updated in $ / source / D5Integrated
  * KeyDown時に、ReadOnlyを判断して値を変更しないようにした。
  *
  * * * * * * * * * * * * * * * * * * Version 11 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 11 Time: 17: 14
* Updated in $ / source / D5Integrated
  * Optionsが設定されていなかったので、BS、Delなどの削除キーが無効になって
  * いた。
  * ModifyUpDownのデフォルト値を変更。
  *
  * * * * * * * * * * * * * * * * * * Version 10 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 12 / 05 Time: 18: 49
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 9 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 11 / 26 Time: 18: 45
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 8 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 11 / 06 Time: 13: 38
* Updated in $ / source / D5Integrated
  *
  * * * * * * * * * * * * * * * * * * Version 7 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 09 / 21 Time: 13: 12
* Updated in $ / source / D5Integrated
  * Widthのデフォルト値を設定
  *
  * * * * * * * * * * * * * * * * * * Version 6 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 30 Time: 17: 40
* Updated in $ / source / D5 / p0comctrl
  * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
  * VSSの履歴マクロの書かれていないファイルにマクロを追加、
  * 要らないファイルの削除を行った。
  *
  * * * * * * * * * * * * * * * * * * Version 5 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 08 Time: 15: 33
* Updated in $ / source / p0control
  * プロパティの可視性を変更
  *
  * * * * * * * * * * * * * * * * * * Version 4 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 07 Time: 21: 36
* Updated in $ / source / p0control
  * c0StdCtrlsユニットを廃止したのでそれに対応
  * AsIntegerプロパティを余計に定義していたので削除
  *
  * * * * * * * * * * * * * * * * * * Version 3 * * * * * * * * * * * * * * * *
  *
  * User: Akima Date: 01 / 08 / 01 Time: 13: 22
* Updated in $ / source / p0control
  * コメントを追加
  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}

unit s0DigitEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  s0CommonTypes,
  s0Edit, s0StringValidater;

type
  Ts0DigitEditInputStyle = class(Ts0CustomEditInputStyle)
  published
    { Control's Property }
    property Alignment;
    property CharCase;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property Modified;
    property ReadOnly;
  published
    { Original Property }
    property AutoTab;
    property AutoWidth;
    property Title;
    property TitleDisplay;
  end;

type
  Ts0DigitEditAccessor = class(Ts0EditAccessor)
  protected
    function GetAsFloat: Double; override;
  end;

type
  Ts0CustomDigitEdit = class(Ts0CustomEdit)
  private
    FAcceptHyphen: Boolean;
    FDecimalMaxLength: Integer;
    FIntegerMaxLength: Integer;
    FModifyUpDown: Boolean;
    FExpoCommaWithDecimal: Boolean;
    FExpoCommaChar: Char;
    FExpoCommaCount: Integer;
    FExpoCommaWithInteger: Boolean;
    FDontKeepCurrentExponent: Boolean;
    FIgnoreZeroOfHead: Boolean;
    FIntegerMinLength: Integer;
    FDecimalMinLength: Integer;
    FAllowNullString: Boolean;
    function GetCharIsNull: Boolean;
    function GetTextLength: Integer;
    procedure SetDecimalMaxLength(const Value: Integer);
    procedure SetDecimalMinLength(const Value: Integer);
    procedure SetIntegerMaxLength(const Value: Integer);
    procedure SetIntegerMinLength(const Value: Integer);
    procedure SetModifyUpDown(const Value: Boolean);
    procedure SetExpoCommaWithDecimal(const Value: Boolean);
    procedure SetExpoCommaChar(const Value: Char);
    procedure SetExpoCommaCount(const Value: Integer);
    procedure SetExpoCommaWithInteger(const Value: Boolean);
    procedure SetIgnoreZeroOfHead(const Value: Boolean);
    procedure SetAllowNullString(const Value: Boolean);
  protected
    function ExpoToSelStart(AExpo, ASelLength: Integer): Integer;
    function SelStartToExpo(ASelStart, ASelLength: Integer): Integer;
    function GetCurrentExponent: Integer; virtual;
    procedure SetCurrentExponent(const Value: Integer); virtual;
  protected
    function GetValidDigitText(Value: string): string;
    procedure GetIntAndDeciStrs(AOriginal: string; var AInt,
      ADecimal: string);
  protected
    function GetAsFloat: Double; virtual;
    procedure SetAsFloat(const Value: Double); virtual;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(const Value: Integer); override;
  protected
    procedure SetAcceptCharType(const Value: K1InpCharSet); override;
    procedure SetExclusiveAcceptChar(const Value: string); override;
  protected
    procedure CheckOnChange; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure IncSelValue(Plus: Boolean = True); virtual;
    function NewAccessor: Ts0EditAccessor; override;
    procedure DecSelValue;
    property Text;
  public
    constructor Create(AOwner: TComponent); override;
    property CharIsNull: Boolean read GetCharIsNull;
    property CurrentExponent: Integer read GetCurrentExponent write
      SetCurrentExponent;
    property TextLength: Integer read GetTextLength;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
  protected
    property AllowNullString: Boolean read FAllowNullString write SetAllowNullString default False;
    property AcceptHyphen: Boolean read FAcceptHyphen write FAcceptHyphen default True;
    property IgnoreZeroOfHead: Boolean read FIgnoreZeroOfHead write SetIgnoreZeroOfHead default True;
    //
    property DecimalMaxLength: Integer read FDecimalMaxLength write SetDecimalMaxLength default -1;
    property DecimalMinLength: Integer read FDecimalMinLength write SetDecimalMinLength default -1;
    property IntegerMaxLength: Integer read FIntegerMaxLength write SetIntegerMaxLength default -1;
    property IntegerMinLength: Integer read FIntegerMinLength write SetIntegerMinLength default -1;
    {
      ModifyUpDown
      上下キーにて値の変更を行うかどうかを指定できるプロパティ。
    }
    property ModifyUpDown: Boolean read FModifyUpDown write SetModifyUpDown
      default True;
    property ExpoCommaCount: Integer read FExpoCommaCount write SetExpoCommaCount
      default 3;
    property ExpoCommaChar: Char read FExpoCommaChar write SetExpoCommaChar
      default ',';
    property ExpoCommaWithDecimal: Boolean read FExpoCommaWithDecimal write
      SetExpoCommaWithDecimal default False;
    property ExpoCommaWithInteger: Boolean read FExpoCommaWithInteger write
      SetExpoCommaWithInteger default False;
  end;

type
  Ts0DigitEdit = class(Ts0CustomDigitEdit)
  private
    function GetInputStyle: Ts0DigitEditInputStyle;
    procedure SetInputStyle(const Value: Ts0DigitEditInputStyle);
  protected
    function NewInputStyle: Ts0CustomEditInputStyle; override;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  published
    ///property AcceptCharType;
    property Accessor;
    property Alignment;
    property AutoTab;
    property AutoWidth;
    //property ExclusiveAcceptChar;
    //property NumericOnly;
    property ReadOnly;
    property Title;
    property TitleDisplay;
    property CheckMin;
    property CheckMax;
    //property FillZero;
    property MaxValue;
    property MinValue;
  published
    property AllowNullString;
    //property AsFloat;
    //property AsInteger;
    property AcceptHyphen;
    property DecimalMaxLength;
    property DecimalMinLength;
    property IntegerMaxLength;
    property IntegerMinLength;
    property ModifyUpDown;
    property ExpoCommaCount;
    property ExpoCommaChar;
    property ExpoCommaWithDecimal;
    property ExpoCommaWithInteger;
  published
    property IgnoreZeroOfHead;
    property InputStyle: Ts0DigitEditInputStyle read GetInputStyle write
      SetInputStyle;
  end;

implementation

uses
  Math,
  s0StringHelper;

{ Ts0DigitEditAccessor }

function Ts0DigitEditAccessor.GetAsFloat: Double;
begin
  if Owner is Ts0CustomDigitEdit then
    Result := Ts0CustomDigitEdit(Owner).AsFloat
  else
    if Owner is TCustomEdit then
      Result := StrToFloat(Ts0StringHelper.DeleteChar(TCustomEdit(Owner).Text,
        ','))
    else
      Result := 0;
end;

{ Ts0CustomDigitEdit }

procedure Ts0CustomDigitEdit.CheckOnChange;
var
  bufExpo: Integer;
begin
  inherited CheckOnChange;
  bufExpo := CurrentExponent;
  try
    Text := GetValidDigitText(Self.Text);
  finally
    if not FDontKeepCurrentExponent then
      CurrentExponent := bufExpo;
  end;
end;

constructor Ts0CustomDigitEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAllowNullString := False;
  FAcceptHyphen := True;
  FDecimalMaxLength := -1;
  FIntegerMaxLength := -1;
  FDecimalMinLength := -1;
  FIntegerMinLength := -1;
  FIgnoreZeroOfHead := True;
  FExpoCommaWithDecimal := False;
  FExpoCommaChar := ',';
  FExpoCommaCount := 3;
  FModifyUpDown := True;
  Alignment := taRightJustify;
  InputStyle.AcceptCharType := [k1ctDigit];
  InputStyle.ExclusiveAcceptChar := '-.';
  ImeMode := imClose;
  Text := '0';
  Width := 48;
//  FixedSelLength := 0;
//  Options := [k0sceoCustomMoveCursur];
end;

procedure Ts0CustomDigitEdit.DecSelValue;
begin
  IncSelValue(False);
end;

function Ts0CustomDigitEdit.ExpoToSelStart(AExpo, ASelLength: Integer): Integer;
var
  dotPos: Integer;
  curText: string;
  curLen: Integer;
  i, cnt: Integer;
begin
  curText := Self.Text;
  curLen := Length(curText);
  dotPos := Pos('.', curText);
  if dotPos < 1 then
  begin
    curText := curText + '.';
    curLen := curLen + 1;
    dotPos := curLen;
  end;
  Result := dotPos - ASelLength;
  cnt := 0;
  if AExpo >= 0 then
  begin
    for i := dotPos - 1 downto 1 do
      if Ts0CharHelper.IsDigit(curText[i]) then
      begin
        if cnt = AExpo then
        begin
          Result := i - ASelLength;
          Exit;
        end;
        Inc(cnt);
      end
  end
  else
    if AExpo < 0 then
    begin
      for i := dotPos + 1 to curLen do
        if Ts0CharHelper.IsDigit(curText[i]) then
        begin
          Dec(cnt);
          if cnt = AExpo then
          begin
            Result := i - ASelLength;
            Exit;
          end;
        end;
      Result := curLen - ASelLength;
    end;
end;

function Ts0CustomDigitEdit.GetAsFloat: Double;
var
  s: string;
begin
  Result := 0;
  s := Ts0StringHelper.DeleteChar(Self.Text, ',');
  try
    Result := StrToFloat(s);
  except
    on E: Exception do
      if not (E is EConvertError) then
        raise;
  end;
end;

function Ts0CustomDigitEdit.GetAsInteger: Integer;
begin
  Result := Trunc(Self.GetAsFloat);
end;

function Ts0CustomDigitEdit.GetCharIsNull: Boolean;
begin
  Result := False;
  if (Self.Text = '-') or (Self.Text = '') then Result := True;
end;

function Ts0CustomDigitEdit.GetCurrentExponent: Integer;
begin
  if HandleAllocated then
    Result := SelStartToExpo(SelStart, SelLength)
  else
    Result := 0;
end;

procedure Ts0CustomDigitEdit.GetIntAndDeciStrs(AOriginal: string; var AInt,
  ADecimal: string);
  procedure DeleteZeroOfHead;
  var
    p: Integer;
  begin
    if not IgnoreZeroOfHead then Exit;
    p := 0;
    if (Length(AInt) > 1) and (AInt[1] = '0') then
      p := 1
    else
      if (Length(AInt) > 2) and (AInt[1] = '-') and (AInt[2] = '0') then
        p := 2;
    if p > 0 then
      Delete(AInt, p, 1);
  end;
var
  dotPos: Integer;
  lText: Integer;
  lenDiff: Integer;
begin
  AInt := '';
  ADecimal := '';
  lText := Length(AOriginal);
  dotPos := Pos('.', AOriginal);
  if dotPos > 0 then
  begin
    if dotPos > 1 then
      AInt := Copy(AOriginal, 1, dotPos - 1);
    if dotPos < lText then
      ADecimal := Copy(AOriginal, dotPos + 1, lText - dotPos);
  end
  else
    AInt := AOriginal;
  //
  DeleteZeroOfHead;
  //
  if FIntegerMinLength > -1 then
  begin
    lenDiff := FIntegerMinLength - Length(AInt);
    if lenDiff > 0 then
      AInt := Ts0StringHelper.RepeatString('0', lenDiff) + AInt;
  end;
  if FDecimalMinLength > -1 then
  begin
    lenDiff := FDecimalMinLength - Length(ADecimal);
    if lenDiff > 0 then
      ADecimal := ADecimal + Ts0StringHelper.RepeatString('0', lenDiff);
  end;
end;

function Ts0CustomDigitEdit.GetTextLength: Integer;
begin
  Result := Length(Self.Text);
end;


function Ts0CustomDigitEdit.GetValidDigitText(Value: string): string;
  procedure ValidateLength(var AInt, ADecimal: string);
  begin
    if (IntegerMaxLength > -1) and (Length(AInt) > IntegerMaxLength) then
      AInt := Copy(AInt, Length(AInt) - IntegerMaxLength + 1, IntegerMaxLength);
    if (DecimalMaxLength > -1) and (Length(ADecimal) > DecimalMaxLength) then
      ADecimal := Copy(ADecimal, 1, DecimalMaxLength);
  end;
  function GetIntegerWithComma(AInt: string): string;
  var
    i, l: Integer;
  begin
    if ExpoCommaWithInteger then
    begin
      Result := '';
      l := Length(AInt);
      for i := l downto 1 do
      begin
        Result := AInt[i] + Result;
        if ((l - i + 1) mod ExpoCommaCount) <> 0 then Continue;
        if (i = 2) and (AInt[1] = '-') then Continue;
        if i = 1 then Continue;
        Result := ExpoCommaChar + Result;
      end;
    end
    else
    begin
      Result := AInt;
    end;
  end;
  function GetDecimalWithComma(ADecimal: string): string;
  var
    i, l: Integer;
  begin
    if ExpoCommaWithDecimal then
    begin
      Result := '';
      l := Length(ADecimal);
      for i := 1 to l do
      begin
        Result := Result + ADecimal[i];
        if (i mod ExpoCommaCount) <> 0 then Continue;
        if i = l then Continue;
        Result := Result + ExpoCommaChar;
      end;
    end
    else
    begin
      Result := ADecimal;
    end;
  end;
var
  intStr, decimalStr: string;
  hadDot: Boolean;
begin
  Result := Ts0StringHelper.DeleteChar(Value, ExpoCommaChar);
  if Result = '' then
  begin
  	if not AllowNullString then
    	Result := '0';
    Exit;
  end;
  hadDot := Pos('.', Result) > 0;
  GetIntAndDeciStrs(Result, intStr, decimalStr);
  ValidateLength(intStr, decimalStr);
  Result := '';
  if decimalStr <> '' then
  begin
    Result := '.' + GetDecimalWithComma(decimalStr)
  end
  else
    if hadDot then
      Result := '.';
  Result := GetIntegerWithComma(intStr) + Result
end;

procedure Ts0CustomDigitEdit.IncSelValue(Plus: Boolean);
var
  bufDeciLen: Integer;
  bufWithPeriod: Boolean;
  bufWithExpoComma: Boolean;
  procedure SaveDeciLen;
  var
    periodIdx: Integer;
  begin
    periodIdx := Pos('.', Self.Text);
    bufWithPeriod := periodIdx > 0;
    if bufWithPeriod then
      bufDeciLen := Length(Ts0StringHelper.DeleteChar(Self.Text, FExpoCommaChar))
        -
        periodIdx
    else
      bufDeciLen := 0;
    bufWithExpoComma := Pos(FExpoCommaChar, Self.Text) > 0;
  end;
  procedure LoadDeciLen;
  var
    intStr, deciStr: string;
    d: Double;
  begin
    if not bufWithPeriod then Exit;
    GetIntAndDeciStrs(Self.Text, intStr, deciStr);
    deciStr := Ts0StringHelper.DeleteChar(deciStr, FExpoCommaChar);
    if bufDeciLen < 1 then
    begin
      Text := intStr + '.';
      Exit;
    end;
    d := StrToFloat('0.' + deciStr);
    deciStr := Format('%.*f', [bufDeciLen + 1, d]);
    if not bufWithExpoComma then
      Delete(deciStr, Length(deciStr), 1);
    Delete(deciStr, 1, 1);
    Text := intStr + deciStr;
  end;
var
  bufLen: Integer;
  bufExpo: Integer;
begin
  if SelLength <> 1 then Exit;
  if SelStart >= Self.TextLength then Exit;
  if not Ts0CharHelper.IsDigit(Copy(Self.Text, SelStart + 1, 1)[1]) then Exit;
  FDontKeepCurrentExponent := False;
  bufLen := SelLength;
  bufExpo := CurrentExponent;
  SaveDeciLen;
  try
    if Plus then
      Self.AsFloat := Self.AsFloat + Power(10, GetCurrentExponent)
    else
      Self.AsFloat := Self.AsFloat - Power(10, GetCurrentExponent);
  finally
    LoadDeciLen;
    SelStart := ExpoToSelStart(bufExpo, bufLen);
    // SetCurrentExponentはSelLengthもセットしてくれるからSelLengthを先に設定する。
    SelLength := bufLen;
    CurrentExponent := bufExpo;
    SelLength := bufLen;
  end;
end;

procedure Ts0CustomDigitEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if ReadOnly then
  begin
    inherited KeyDown(Key, Shift);
    Exit;
  end;
  if ModifyUpDown then
  begin
    case Key of
      VK_UP:
        begin
          IncSelValue;
          Key := 0;
          Exit;
        end;
      VK_DOWN:
        begin
          DecSelValue;
          Key := 0;
          Exit;
        end;
    end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure Ts0CustomDigitEdit.KeyPress(var Key: Char);
var
  idx: Integer;
begin
  //既に入力されてたら受け付けちゃダメっす。
  case Key of
    '-',
      '.':
      begin
        idx := Pos(Key, Self.SelText);
        if idx > 0 then
        begin
          inherited KeyPress(Key);
          Exit;
        end;
        idx := Pos(Key, Self.Text);
        if (idx > 0) or ((key = '-') and (not AcceptHyphen)) then
        begin
          Key := #0;
          inherited KeyPress(Key);
          Exit;
        end;
      end;
  end;
  //変な場所には入力できないよチェック。
  case Key of
    #8: ;

    '-':
      begin
        if SelStart <> 0 then
          Key := #0;
      end;

    '.':
      begin
        if DecimalMaxLength = 0 then Key := #0;
      end;
  else
    begin
      //'-'の前には入力できない
      if (Copy(Self.Text, 1, 1) = '-') and (SelStart = 0) and (SelLength = 0)
        then key := #0;
    end;
  end;
  //
  FDontKeepCurrentExponent := False;
  case Key of
    '-',
      '.': FDontKeepCurrentExponent := True;
  end;
  inherited KeyPress(Key);
end;

function Ts0CustomDigitEdit.NewAccessor: Ts0EditAccessor;
begin
  Result := Ts0DigitEditAccessor.Create(Self);
end;

function Ts0CustomDigitEdit.SelStartToExpo(ASelStart, ASelLength: Integer):
  Integer;
var
  dotPos: Integer;
  curText: string;
  curLen: Integer;
  i: Integer;
  p: Integer;
begin
  Result := 0;
  curText := Self.Text;
  curLen := Length(curText);
  //
  if ASelStart < 0 then
    ASelStart := 0
  else
    if ASelStart > curLen then
      ASelStart := curLen;
  //
  p := ASelStart + ASelLength;
  //
  dotPos := Pos('.', curText);
  if dotPos < 1 then
  begin
    curText := curText + '.';
    curLen := curLen + 1;
    dotPos := curLen;
  end;
  if p < dotPos then
  begin
    for i := dotPos - 1 downto p do
    begin
      if i = dotPos - 1 then Continue;
      if Ts0CharHelper.IsDigit(curText[i]) then
        Inc(Result);
    end;
  end
  else
    if p >= dotPos then
    begin
      for i := dotPos + 1 to p do
      begin
        if Ts0CharHelper.IsDigit(curText[i]) then
          Dec(Result);
      end;
    end;
end;

procedure Ts0CustomDigitEdit.SetAcceptCharType(const Value: K1InpCharSet);
begin
end;

procedure Ts0CustomDigitEdit.SetAsFloat(const Value: Double);
{
var
  intPart: Integer;
  decPart: Double;
  r, s: string;
}
begin
{
  intPart := Trunc(Value);
  decPart := Frac(Value);
  r := IntToStr(intPart);
  if decPart <> 0 then
  begin
    s := FloatToStr(decPart); //Format('%.15f', [decPart]);
    if s <> '' then
      Delete(s, 1, 1);
    r := r + s;
  end;
  inherited Text := r;
}
  Text := GetValidDigitText(FloatToStr(Value));
end;

procedure Ts0CustomDigitEdit.SetAsInteger(const Value: Integer);
begin
  SetAsFloat(Value);
end;

procedure Ts0CustomDigitEdit.SetCurrentExponent(const Value: Integer);
var
  bufLen: Integer;
  newPos: Integer;
begin
  if not HandleAllocated then Exit;
//  if SelStart = newPos then Exit;
  bufLen := SelLength;
  newPos := ExpoToSelStart(Value, bufLen);
  SendMessage(Handle, EM_SETSEL, newPos, newPos + bufLen);
end;

procedure Ts0CustomDigitEdit.SetDecimalMaxLength(const Value: Integer);
begin
  FDecimalMaxLength := Value;
  Change;
end;

procedure Ts0CustomDigitEdit.SetExclusiveAcceptChar(const Value: string);
begin
end;

procedure Ts0CustomDigitEdit.SetExpoCommaChar(const Value: Char);
begin
  FExpoCommaChar := Value;
  Change;
end;

procedure Ts0CustomDigitEdit.SetExpoCommaCount(const Value: Integer);
begin
  FExpoCommaCount := Value;
  Change;
end;

procedure Ts0CustomDigitEdit.SetExpoCommaWithDecimal(const Value: Boolean);
begin
  FExpoCommaWithDecimal := Value;
  Change;
end;

procedure Ts0CustomDigitEdit.SetExpoCommaWithInteger(const Value: Boolean);
begin
  FExpoCommaWithInteger := Value;
  Change;
end;

procedure Ts0CustomDigitEdit.SetIgnoreZeroOfHead(const Value: Boolean);
begin
  FIgnoreZeroOfHead := Value;
end;

procedure Ts0CustomDigitEdit.SetIntegerMaxLength(const Value: Integer);
begin
  FIntegerMaxLength := Value;
  Change;
end;

procedure Ts0CustomDigitEdit.SetModifyUpDown(const Value: Boolean);
begin
  FModifyUpDown := Value;
end;

procedure Ts0CustomDigitEdit.SetDecimalMinLength(const Value: Integer);
begin
  FDecimalMinLength := Value;
  if FDecimalMinLength > -1 then
  	FAllowNullString := False;
  Change;
end;

procedure Ts0CustomDigitEdit.SetIntegerMinLength(const Value: Integer);
begin
  FIntegerMinLength := Value;
  if FIntegerMinLength > -1 then
  	FAllowNullString := False;
  Change;
end;

procedure Ts0CustomDigitEdit.SetAllowNullString(const Value: Boolean);
begin
  FAllowNullString := Value;
  if FAllowNullString then
  begin
    FIntegerMinLength := -1;
    FDecimalMinLength := -1;
  end;
  Change;
end;

{ Ts0DigitEdit }

function Ts0DigitEdit.GetInputStyle: Ts0DigitEditInputStyle;
begin
  Result := Ts0DigitEditInputStyle(inherited InputStyle);
end;

function Ts0DigitEdit.NewInputStyle: Ts0CustomEditInputStyle;
begin
  Result := Ts0DigitEditInputStyle.Create(Self);
end;

procedure Ts0DigitEdit.SetInputStyle(const Value: Ts0DigitEditInputStyle);
begin
  inherited InputStyle := Value;
end;

end.

