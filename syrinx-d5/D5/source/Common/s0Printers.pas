unit s0Printers;

interface

uses
	SysUtils, Classes, Printers, Graphics, Windows;

type
	Ts0CustomPrinterDelegate = class(TObject)
  private
  	FDelegate: TPrinter;
    FFreeDelegateOnDestroy: Boolean;
    procedure SetTitle(const Value: string);
    function GetCopies: Integer;
    procedure SetCopies(const Value: Integer);
  protected
  	property Delegate: TPrinter read FDelegate;
  	property FreeDelegateOnDestroy: Boolean read FFreeDelegateOnDestroy;
  protected
    function GetAborted: Boolean; virtual;
    function GetCanvas: TCanvas; virtual;
    function GetCapabilities: TPrinterCapabilities; virtual;
    function GetFonts: TStrings; virtual;
    function GetHandle: HDC; virtual;
    function GetOrientation: TPrinterOrientation; virtual;
    function GetPageHeight: Integer; virtual;
    function GetPageNumber: Integer; virtual;
    function GetPageWidth: Integer; virtual;
    function GetPrinterIndex: Integer; virtual;
    function GetPrinters: TStrings; virtual;
    function GetPrinting: Boolean; virtual;
    function GetTitle: string; virtual;
    procedure SetOrientation(const Value: TPrinterOrientation); virtual;
    procedure SetPrinterIndex(const Value: Integer); virtual;
  public
    constructor Create; overload; virtual;
    constructor Create(APrinter: TPrinter); overload; virtual;
    destructor Destroy; override;
    procedure Abort; virtual;
    procedure BeginDoc; virtual;
    procedure EndDoc; virtual;
    procedure NewPage; virtual;
    procedure GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle); virtual;
    procedure SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle); virtual;
    procedure Refresh; virtual;
  protected
    property Aborted: Boolean read GetAborted;
    property Canvas: TCanvas read GetCanvas;
    property Capabilities: TPrinterCapabilities read GetCapabilities;
    property Copies: Integer read GetCopies write SetCopies;
    property Fonts: TStrings read GetFonts;
    property Handle: HDC read GetHandle;
    property Orientation: TPrinterOrientation read GetOrientation write SetOrientation;
    property PageHeight: Integer read GetPageHeight;
    property PageWidth: Integer read GetPageWidth;
    property PageNumber: Integer read GetPageNumber;
    property PrinterIndex: Integer read GetPrinterIndex write SetPrinterIndex;
    property Printing: Boolean read GetPrinting;
    property Printers: TStrings read GetPrinters;
    property Title: string read GetTitle write SetTitle;
  end;

type
	Ts0PrinterDelegate = class(Ts0CustomPrinterDelegate)
  public
    property Aborted;
    property Canvas;
    property Capabilities;
    property Copies;
    property Fonts;
    property Handle;
    property Orientation;
    property PageHeight;
    property PageWidth;
    property PageNumber;
    property PrinterIndex;
    property Printing;
    property Printers;
    property Title;
  end;

implementation

{ Ts0CustomPrinterDelegate }

procedure Ts0CustomPrinterDelegate.Abort;
begin
  FDelegate.Abort;
end;

procedure Ts0CustomPrinterDelegate.BeginDoc;
begin
	FDelegate.BeginDoc;
end;

constructor Ts0CustomPrinterDelegate.Create;
begin
  FFreeDelegateOnDestroy := True;
	FDelegate := TPrinter.Create;
end;

constructor Ts0CustomPrinterDelegate.Create(APrinter: TPrinter);
begin
  FFreeDelegateOnDestroy := False;
  FDelegate := APrinter;
end;

destructor Ts0CustomPrinterDelegate.Destroy;
begin
	if FFreeDelegateOnDestroy then
		FreeAndNil(FDelegate);
  inherited;
end;

procedure Ts0CustomPrinterDelegate.EndDoc;
begin
	FDelegate.EndDoc;
end;

function Ts0CustomPrinterDelegate.GetAborted: Boolean;
begin
	Result := FDelegate.Aborted;
end;

function Ts0CustomPrinterDelegate.GetCanvas: TCanvas;
begin
	Result := FDelegate.Canvas;
end;

function Ts0CustomPrinterDelegate.GetCapabilities: TPrinterCapabilities;
begin
	Result := FDelegate.Capabilities;
end;

function Ts0CustomPrinterDelegate.GetCopies: Integer;
begin
	Result := FDelegate.Copies;
end;

function Ts0CustomPrinterDelegate.GetFonts: TStrings;
begin
	Result := FDelegate.Fonts;
end;

function Ts0CustomPrinterDelegate.GetHandle: HDC;
begin
	Result := FDelegate.Handle;
end;

function Ts0CustomPrinterDelegate.GetOrientation: TPrinterOrientation;
begin
	Result := FDelegate.Orientation;
end;

function Ts0CustomPrinterDelegate.GetPageHeight: Integer;
begin
	Result := FDelegate.PageHeight;
end;

function Ts0CustomPrinterDelegate.GetPageNumber: Integer;
begin
	Result := FDelegate.PageNumber;
end;

function Ts0CustomPrinterDelegate.GetPageWidth: Integer;
begin
	Result := FDelegate.PageWidth;
end;

procedure Ts0CustomPrinterDelegate.GetPrinter(ADevice, ADriver, APort: PChar;
  var ADeviceMode: THandle);
begin
	FDelegate.GetPrinter(ADevice, ADriver, APort, ADeviceMode);
end;

function Ts0CustomPrinterDelegate.GetPrinterIndex: Integer;
begin
	Result := FDelegate.PrinterIndex;
end;

function Ts0CustomPrinterDelegate.GetPrinters: TStrings;
begin
	Result := FDelegate.Printers;
end;

function Ts0CustomPrinterDelegate.GetPrinting: Boolean;
begin
  Result := FDelegate.Printing;
end;

function Ts0CustomPrinterDelegate.GetTitle: string;
begin
	Result := FDelegate.Title;
end;

procedure Ts0CustomPrinterDelegate.NewPage;
begin
  FDelegate.NewPage;
end;

procedure Ts0CustomPrinterDelegate.Refresh;
begin
	FDelegate.Refresh;
end;

procedure Ts0CustomPrinterDelegate.SetCopies(const Value: Integer);
begin
  FDelegate.Copies := Value;
end;

procedure Ts0CustomPrinterDelegate.SetOrientation(const Value: TPrinterOrientation);
begin
	FDelegate.Orientation := Value; 
end;

procedure Ts0CustomPrinterDelegate.SetPrinter(ADevice, ADriver, APort: PChar;
  ADeviceMode: THandle);
begin
  FDelegate.SetPrinter(ADevice, ADriver, APort, ADeviceMode);
end;

procedure Ts0CustomPrinterDelegate.SetPrinterIndex(const Value: Integer);
begin
	FDelegate.PrinterIndex := Value;
end;

procedure Ts0CustomPrinterDelegate.SetTitle(const Value: string);
begin
  FDelegate.Title := Value; 
end;

end.
