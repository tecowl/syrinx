{-----------------------------------------------------------------------------
 Unit Name: s0File
 Author:    akima
 Purpose:
 TestCase: tc_s0File
 $History: s0File.pas $
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 02/03/09   Time: 17:39
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * ê⁄ì™é´ÇïœçXÅBxxSXÅ`Ç…ÇµÇΩÅB
 * 
 * *****************  Version 1  *****************
 * User: Akima        Date: 01/12/01   Time: 0:18
 * Created in $/source/D5Integrated
-----------------------------------------------------------------------------}

unit s0File;

interface

uses
  SysUtils, Classes;
{

type
  Ts0File = class(TPersistent)
  private
    FFileName: string;
    FParentDir: Ts0File;
    function GetFullPathFileName: string;
    procedure SetParentDir(const Value: Ts0File);
  protected
    procedure SetFileName(const Value: string); virtual;
  public
    constructor Create(AFileName: string); virtual;
  published
    property FileName: string read FFileName write SetFileName;
  end;
}


implementation

end.
