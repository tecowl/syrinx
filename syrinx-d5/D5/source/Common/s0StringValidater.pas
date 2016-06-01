unit s0StringValidater;
{
$History: s0StringValidater.pas $
 * 
 * *****************  Version 6  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/04   Time: 21:53
 * Updated in $/source/D6VCLIntegrated
 * CLX�Ή����Ă܂��E�E�E�E
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/01/15   Time: 18:36
 * Updated in $/source/D6VCLIntegrated
 * 
 * *****************  Version 4  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * �R�����g�\���R�}���h�ǉ�
}

interface

uses
  Classes,
  s0CommonTypes,
  s0CType;

type
  K1InpCharFunc =	function(c: Char): ByteBool of object;
  K1CharactorSet =  set of Char;

type
	Ts0StringValidater = class
  public
		class function isSpecialKey(const key: word): Boolean;
		class function validateChartype(ACharType: K1InpCharSet; AChars: array of Char;
      AResetDBCS: Boolean = False): Boolean;
		class function validateExclusiveChar(exclusivechar: K1CharactorSet;
      AChars: array of char): Boolean; overload;
		class function validateExclusiveChar(ExclusiveAcceptString: string;
      AChars: array of char): Boolean; overload;
		class procedure uppercaseChartype(ACharType: K1InpCharSet; var value: String);
    class function StringToCharSet(Source: string): K1CharactorSet;
  end;

implementation

uses
	windows, sysutils
  ;

{--------------------------------------------------------------------
�����FPC��̓���L�[(�������͂Ƃ݂Ȃ������Ȃ��L�[)�𔻒肷��
�����Fkey : ���͂��ꂽ�L�[�R�[�h���Z�b�g
���ʁFPC�̓���L�[�̏ꍇ��True��Ԃ�
���l�F
---------------------------------------------------------------------}
class function Ts0StringValidater.isSpecialKey (const key: word):Boolean;
begin
  result := Ts0Ctype.IsSpecialKey(key);
end;


{--------------------------------------------------------------------
�����F����ȃL�[�R�[�h�����𔻒肵�����ꍇ�Ɏg�p���郁�\�b�h
�����FexclusiveChars[] : �`�F�b�NOK�Ƃ����̕����̔z��
      AChars[] : ���肷�镶���̔z��
���ʁF�S�Ă����͉\�ȕ����������ꍇ��True��Ԃ�
���l�F
---------------------------------------------------------------------}
class function Ts0StringValidater.validateExclusiveChar(exclusivechar: K1CharactorSet; AChars: array of char):Boolean;
var
	i:integer;
begin
	Result := True;
  for i := low(AChars) to high(AChars) do
  begin
    Result := ( AChars[i] in exclusivechar ) or ( UpCase(AChars[i]) in exclusivechar );
    if not Result then Break;
	end;
end;


class function Ts0StringValidater.validateExclusiveChar(
  ExclusiveAcceptString: string; AChars: array of char): Boolean;
begin
  Result := validateExclusiveChar(StringToCharSet(ExclusiveAcceptString), AChars);
end;



var
	//�������r�ׂ̈̊֐��z��
	g9CharTypeAry:	array[K1InpCharType] of K1InpCharFunc;

var
	DBCSFirst: Boolean = False;

{--------------------------------------------------------------------
�����F�L�[�R�[�h������̃^�C�v�ɍ��v���邩�𔻒肷�郁�\�b�h
�����FcharType : �e����̓R���|�[�l���g�ŃZ�b�g���ꂽ���͕����^�C�v (u1ConstCompo)
      AChars[] : ���肷�镶���̔z��
���ʁF���͉\�ȕ����������ꍇ��True��Ԃ�
���l�F
---------------------------------------------------------------------}
class function Ts0StringValidater.validateChartype(ACharType: K1InpCharSet; AChars: array of Char;
  AResetDBCS: Boolean = False): Boolean;
var
	i: integer;
  j: K1InpCharType;
begin
  {�I�΂ꂽ�񋓌^�����è�ɑΉ������֐��œ��͕����̗L����������}
	if AResetDBCS then DBCSFirst := False; //DBCS��������Z�b�g����
  Result := False;
  for i := low(AChars) to high(AChars) do
    for j := Low(K1InpCharType) to High(K1InpCharType) do
      if j in ACharType then
        if j = k1ctKanji then
        begin
          //DBCS��1�o�C�g�ڂ������ꍇ�̓`�F�b�N�����Ȃ�
          if DBCSFirst then begin
            DBCSFirst := False;
            Result := Result or Ts0Ctype.iskanji2(AChars[i]);
          end
          else
          begin
            //DBCS��2�o�C�g�ڂ������ꍇ�͓��ʂȃ`�F�b�N���s��
            DBCSFirst := Ts0Ctype.iskanji(AChars[i]);
            if DBCSFirst then Result := true;
          end;
        end
        else
          Result := Result or g9CharTypeAry[j](AChars[i]);
end;


{--------------------------------------------------------------------
�����FCharType���l������UpperCase������s��
�����FexclusiveChars[] : �`�F�b�NOK�Ƃ����̕����̔z��
      AChars[] : ���肷�镶���̔z��
���ʁF�S�Ă����͉\�ȕ����������ꍇ��True��Ԃ�
���l�F
---------------------------------------------------------------------}
class procedure Ts0StringValidater.uppercaseChartype(ACharType: K1InpCharSet; var value:String);
var
	DBCSFirst: Boolean;
var
	i: integer;
begin
  DBCSFirst := False;
  {�I�΂ꂽ�񋓌^�����è���ŉp��������UpperCase���삷��}
  for i := 1 to Length(value) do
  begin
		if DBCSFirst then
       DBCSFirst := False
		else
    begin
    	DBCSFirst := Ts0Ctype.iskanji(value[i]);
			if not DBCSFirst then
      begin
        {�p����?}
        if ( k1ctAlpha in ACharType ) then
        begin
          if g9CharTypeAry[k1ctAlpha](value[i]) then
            value[i] := AnsiUpperCase(copy(value[i], 1, 1))[1];
        end;
			end;
		end;
	end;
end;

class function Ts0StringValidater.StringToCharSet(Source: string): K1CharactorSet;
var
  i: Integer;
begin
  Result := [];
  for i := 1 to Length(Source) do
    Include(Result, Source[i]);
end;

initialization
begin
	//������o���f�[�V�����p�̊֐���z��ɃZ�b�g (�ʂȊ֐��ɍ����ւ����\)
  g9CharTypeAry[k1ctAlpha] := Ts0Ctype.isalpha;
  g9CharTypeAry[k1ctDigit] := Ts0Ctype.isdigit;
  g9CharTypeAry[k1ctSign ] := Ts0Ctype.issign;
  {DBCS}
{$IFNDEF NOIMEPROP}
  g9CharTypeAry[k1ctKana ] := Ts0Ctype.iskana;
  g9CharTypeAry[k1ctKanji] := Ts0Ctype.iskanji;
{$ENDIF}
end;

end.

