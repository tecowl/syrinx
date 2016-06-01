unit s0Win32APIHelper;
{
$History: s0Win32APIHelper.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * �R�����g�\���R�}���h�ǉ�
}

interface

uses
  Windows, Messages, SysUtils, Classes;

type
  Ts0Win32APIHelper = class
  private
  public
    class function GetLastErrorStr(ErrorCode: Integer): String;
    class function CheckSingleInstanceVer(const aVer: integer; aName: string): THandle;
  end;

implementation

uses
  s0StringHelper;

{--------------------------------------------------------------------
�����FWin32��GetLastError�̖߂�l�𕶎���ɕϊ�����֐�
�����FErrorCode��
���ʁFWin32�̃G���[���b�Z�[�W���߂�
���l�F
---------------------------------------------------------------------}
class function Ts0Win32APIHelper.GetLastErrorStr(ErrorCode: Integer): string;
const
  MAX_MES = 512;
var
  Buf: PChar;
begin
  Buf := AllocMem(MAX_MES);
  try
    FormatMessage(Format_Message_From_System, Nil, ErrorCode,
                  (SubLang_Default shl 10) + Lang_Neutral,
                  Buf, MAX_MES, Nil);
  finally
    Result := Buf;
    FreeMem(Buf);
  end;
end;

{------------------------------------------------------------
�����F�w�肵�����O��Mutex���o�[�W�����ԍ����l�����Ă��邩�ǂ������ׂ�
�����FaName�ɂ̓v���O����ID�ȂǃV�X�e���Ń��j�[�N�ȕ������n��
      aVer�ɂ̓Z�L�����e�B�N���X������ŐV�̃o�[�W����NO���擾���ēn��
���ʁF���ʂɂ̓I�[�v������Mutex���Ԃ�B0�������ꍇ�A���ɃC���X�^���X������
���l�F���ʂŖ߂���Mutex�̓A�v���P�[�V�����I�����܂łɕK���N���[�Y���邱��
------------------------------------------------------------}
class function Ts0Win32APIHelper.CheckSingleInstanceVer(const aVer: integer;aName: string):THandle;
var
  hMutex: THandle;
begin
  hMutex := OpenMutex(
    MUTEX_ALL_ACCESS,
    False,
    PChar(AnsiUpperCase( Ts0StringHelper.GetExeNameFromVer(aVer, aName) ))
  );
  if hMutex <> 0 then
  begin
    CloseHandle(hMutex);
    Result := 0;
  end
  else
    Result := CreateMutex(
                nil,
                False,
                PChar(AnsiUpperCase( Ts0StringHelper.GetExeNameFromVer(aVer, aName) ))
              );
end;

end.
