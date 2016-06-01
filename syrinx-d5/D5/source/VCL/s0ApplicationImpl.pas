{-----------------------------------------------------------------------------
 Unit Name: s0ApplicationImpl
 Author:    akima
 Purpose:
 TestCase: tc_s0ApplicationImpl
 See: 
 $History: s0ApplicationImpl.pas $
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/VCL
-----------------------------------------------------------------------------}

unit s0ApplicationImpl;

interface

uses
  SysUtils, Classes,
  s0Application;

type
  Ts0VCLApplication = class(Ts0Application)
  protected
    function ImplGetExeName: string; override;
    procedure ImplInitialize; override;
    procedure ImplRun; override;
    procedure ImplTerminate; override;
  end;

implementation

uses
  Forms;

{ Ts0VCLApplication }

function Ts0VCLApplication.ImplGetExeName: string;
begin
  Result := Application.ExeName;
end;

procedure Ts0VCLApplication.ImplInitialize;
begin
  Application.Initialize;
end;

procedure Ts0VCLApplication.ImplRun;
begin
  Application.Run;
end;

procedure Ts0VCLApplication.ImplTerminate;
begin
  Application.Terminate;
end;

initialization
  Ts0Application.RegisterClass(Ts0VCLApplication);

end.
