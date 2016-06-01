unit s0PageControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  Ts0PageControl = class(TPageControl)
  private
  	FLoadedIndex: Integer;
    function GetDefaultPageIndex: Integer;
    procedure SetDefaultPageIndex(const Value: Integer);
  protected
    procedure Loaded; override;
  public
  published
    property DefaultPageIndex: Integer read GetDefaultPageIndex write SetDefaultPageIndex;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('P Form', [Ts0PageControl]);
end;

{ Ts0PageControl }

function Ts0PageControl.GetDefaultPageIndex: Integer;
begin
	Result := inherited ActivePageIndex;
end;

procedure Ts0PageControl.Loaded;
begin
  inherited;
	if FLoadedIndex <> ActivePageIndex then
  	ActivePageIndex := FLoadedIndex;
end;

procedure Ts0PageControl.SetDefaultPageIndex(const Value: Integer);
begin
	if csLoading in Self.ComponentState then
  begin
		FLoadedIndex := Value;		
  end
  else
  begin
  	inherited ActivePageIndex := Value;
  end;
end;

end.
