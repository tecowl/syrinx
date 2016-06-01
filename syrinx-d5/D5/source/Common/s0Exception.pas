unit s0Exception;
{
$History: s0Exception.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * 接頭辞を変更。xxSX～にした。
 * 
 * *****************  Version 8  *****************
 * User: Hirakawa     Date: 01/06/19   Time: 14:35
 * Updated in $/GUI/Source/Common
 * コメント表示コマンド追加
}

interface

uses
  SysUtils, Classes;

type
  K0ErrorLevel = (
    k1elWarning,	//警告レベルのエラー
    k1elError,		//通常の（？）エラー
    k1elFatal			//致命的エラー
  );

type
  Es0Exception = class(Exception)
  private
    FLevel: K0ErrorLevel;
  public
    constructor Create(const Msg: string; pLevel: K0ErrorLevel = k1elError); reintroduce; virtual;
    constructor CreateFmt(const Msg: string; const Args: array of const; pLevel: K0ErrorLevel = k1elError); reintroduce; virtual;
    property Level: K0ErrorLevel read FLevel;
  end;

type
  Es0ProgExcept = class(Es0Exception);

type
  Es0RegisterException = class(Es0ProgExcept);

type
  Es0HardWareException = class(Es0Exception);

type
	Es0RequiredComponentException = class(Es0Exception)
  public
    constructor Create(const pPropertyName: string; pLevel: K0ErrorLevel = k1elError); reintroduce; virtual;
  end;

type
  Es0ApplicationError = class(Es0Exception)
  private
    FErrorCode: Integer;
  protected
    function GetErrorMsg: string; virtual;
  public
    constructor Create(AErrorCode: Integer; AErrorMsg: string = ''); reintroduce; overload; virtual;
    property ErrorCode: Integer read FErrorCode;
    property ErrorMsg: string read GetErrorMsg;
  end;

resourcestring
  c0ErrMsg_SingletonInstanceAlreadyExists = 'Singleton instance already exists.';


implementation

{ Es0Exception }

constructor Es0Exception.Create(const Msg: string; pLevel: K0ErrorLevel);
begin
  inherited Create(Msg);
  FLevel := pLevel;
end;

constructor Es0Exception.CreateFmt(const Msg: string;
  const Args: array of const; pLevel: K0ErrorLevel);
begin
  inherited CreateFmt(Msg, Args);
  FLevel := pLevel;
end;

{ Es0RequiredComponentException }

constructor Es0RequiredComponentException.Create(
  const pPropertyName: string; pLevel: K0ErrorLevel);
begin
	inherited Create(pPropertyName + ' is not specified but is required property.', pLevel);
end;



{ Es0ApplicationError }

constructor Es0ApplicationError.Create(AErrorCode: Integer; AErrorMsg: string);
begin
  inherited Create(AErrorMsg);
  FErrorCode := AErrorCode;
end;

function Es0ApplicationError.GetErrorMsg: string;
begin
  Result := Message;
end;

end.




