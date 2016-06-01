unit s0ComponentVisitor;
{
$History: s0ComponentVisitor.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/04/24   Time: 2:44
 * Updated in $/D5/source/Common
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
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0core
 * ファイル名、クラス名の見直しと、パッケージ構造の見直し、
 * VSSの履歴マクロの書かれていないファイルにマクロを追加、
 * 要らないファイルの削除を行った。
}

interface

uses
  SysUtils, Classes, Contnrs;

type
  Ts0ComponentVisitor = class
  private
    FTarget: TComponent;
  protected
    procedure VisitComponent(ACompo: TComponent); virtual;
    procedure VisitChildren(ACompo: TComponent);
  public
    procedure Execute; virtual;
    property Target: TComponent read FTarget write FTarget;
  end;

type
  K0ComponentFinderEvent = procedure(Sender: TObject; AComponent: TComponent;
    var AMatch: Boolean) of object;

type
  Ts0ComponentFinder = class(Ts0ComponentVisitor)
  private
    FExitOnFind: Boolean;
    FOnMatch: K0ComponentFinderEvent;
    FResultList: TComponentList;
    FDuplicates: TDuplicates;
    function MustBeRunAway: Boolean;
  protected
    function DoMatch(AComponent: TComponent): Boolean; virtual;
    function AddToResult(AComponent: TComponent): Integer;
    procedure VisitComponent(ACompo: TComponent); override;
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure Execute; override;
    property ResultList: TComponentList read FResultList;
    property ExitOnFind: Boolean read FExitOnFind write FExitOnFind;
    property OnMatch: K0ComponentFinderEvent read FOnMatch write FOnMatch;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
  end;

type
  Es0ComponentFinderException = class(Exception);

implementation

{ Ts0ComponentVisitor }

procedure Ts0ComponentVisitor.Execute;
begin
  if FTarget = nil then Exit;
  VisitComponent(FTarget);
end;

procedure Ts0ComponentVisitor.VisitChildren(ACompo: TComponent);
var
  i: Integer;
begin
  for i := 0 to ACompo.ComponentCount -1 do
    VisitComponent(ACompo.Components[i]);
end;

procedure Ts0ComponentVisitor.VisitComponent(ACompo: TComponent);
begin                   
  VisitChildren(ACompo);
end;

{ Ts0ComponentFinder }

resourcestring
  c9ErrMsg_Duplicates = '同じコンポーネントが重複して見つかりました。';

function Ts0ComponentFinder.AddToResult(AComponent: TComponent): Integer;
begin
  Result := FResultList.IndexOf(AComponent);
  case Duplicates of
    dupIgnore: if Result > -1 then Exit;
    dupAccept: ;
    dupError :
      if Result > -1 then
        raise Es0ComponentFinderException.Create(c9ErrMsg_Duplicates);
  end;
  FResultList.Add(AComponent);
end;

constructor Ts0ComponentFinder.Create;
begin
  inherited Create;
  FResultList := TComponentList.Create(False);
end;

destructor Ts0ComponentFinder.Destroy;
begin
  FreeAndNil(FResultList);
  inherited;
end;

function Ts0ComponentFinder.DoMatch(AComponent: TComponent): Boolean;
begin
  Result := False;
  if Assigned(FOnMatch) then
    FOnMatch(Self, AComponent, Result);
end;

procedure Ts0ComponentFinder.Execute;
begin
  inherited Execute;
end;

function Ts0ComponentFinder.MustBeRunAway: Boolean;
begin
  Result := (FResultList.Count > 0) and FExitOnFind;
end;

procedure Ts0ComponentFinder.VisitComponent(ACompo: TComponent);
begin
  if MustBeRunAway then Exit;
  if DoMatch(ACompo) then AddToResult(ACompo);
  if MustBeRunAway then Exit;
  inherited;
end;

end.
