unit <ListUnitName>

interface

uses
  SysUtils, Classes, Contnrs, <TargetUnitName>;

type
  <ListClassName> = class(TObjectList)
  private
  protected
    function GetItems(Index: Integer): <TargetClassName>;
    procedure SetItems(Index: Integer; AItem: <TargetClassName>);
  public
    function Add(AItem: <TargetClassName>): Integer;
    function Remove(AItem: <TargetClassName>): Integer;
    function IndexOf(AItem: <TargetClassName>): Integer;
    procedure Insert(Index: Integer; AItem: <TargetClassName>);
    property Items[Index: Integer]: <TargetClassName> read GetItems write SetItems; default;
    function First: <TargetClassName>;
    function Last: <TargetClassName>;
  end;

implementation

{ <ListClassName> }

function <ListClassName>.Add(AItem: <TargetClassName>): Integer;
begin
  Result := inherited Add(AItem);
end;

function <ListClassName>.First: <TargetClassName>;
begin
  Result := <TargetClassName>( inherited First );
end;

function <ListClassName>.GetItems(Index: Integer): <TargetClassName>;
begin
  Result := <TargetClassName>( inherited Items[Index] );
end;

function <ListClassName>.IndexOf(AItem: <TargetClassName>): Integer;
begin
  Result := inherited IndexOf(AItem);
end;

procedure <ListClassName>.Insert(Index: Integer;
  AItem: <TargetClassName>);
begin
  inherited Insert(Index, AItem);
end;

function <ListClassName>.Last: <TargetClassName>;
begin
  Result := <TargetClassName>( inherited Last );
end;

function <ListClassName>.Remove(AItem: <TargetClassName>): Integer;
begin
  Result := inherited Remove(AItem);
end;

procedure <ListClassName>.SetItems(Index: Integer; AItem: <TargetClassName>);
begin
  inherited Items[Index] := AItem;
end;

end.
