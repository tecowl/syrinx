unit s0StringReplacer;
{
$History: s0StringReplacer.pas $
 * 
 * *****************  Version 5  *****************
 * User: Akima        Date: 02/03/09   Time: 17:40
 * Updated in $/D5/source/Common
 * 
 * *****************  Version 4  *****************
 * User: Akima        Date: 02/02/28   Time: 23:25
 * Updated in $/source/D5Integrated
 * �ړ�����ύX�BxxSX�`�ɂ����B
 * 
 * *****************  Version 3  *****************
 * User: Akima        Date: 01/11/28   Time: 22:02
 * Updated in $/source/D5Integrated
 * Replace���\�b�h�ɑ啶���������𖳎����邩�ǂ������w��ł��������ǉ��B
 * 
 * *****************  Version 2  *****************
 * User: Akima        Date: 01/08/30   Time: 17:40
 * Updated in $/source/D5/p0core
 * �t�@�C�����A�N���X���̌������ƁA�p�b�P�[�W�\���̌������A
 * VSS�̗����}�N���̏�����Ă��Ȃ��t�@�C���Ƀ}�N����ǉ��A
 * �v��Ȃ��t�@�C���̍폜���s�����B
}

interface

uses
  Classes, SysUtils;

type
  Ts0StringReplacer = class
  private
    FTagHeader: string;
    FTagFooter: string;
  protected
    procedure FindTagStr(Str: string; Dest: TStrings);
  public
    constructor Create; reintroduce; virtual;
    procedure FindTaggedString(Text, Dest: TStrings);
    procedure ReplaceText(Text, Dest, StringSet: TStrings);
    function Replace(Source: string; StringSet: TStrings;
      AIgnoreCase: Boolean = True): string;
    property TagHeader: string read FTagHeader write FTagHeader;
    property TagFooter: string read FTagFooter write FTagFooter;
  end;


implementation

{ Ts0StringReplacer }
                
procedure Ts0StringReplacer.FindTagStr(Str: string; Dest: TStrings);
  function SearchTag(var AStr: string): string;
  var
    lBegin, lEnd: Integer;
  begin
    Result := '';
    lBegin := Pos(FTagHeader, AStr);
    lEnd   := Pos(FTagFooter, AStr);
    if (lBegin < 1) or (lEnd < 1) then
    begin
      AStr := '';
      Exit;
    end;
    if lBegin + 1 >= lEnd then
    begin
      Delete(AStr, 1, lEnd);
      Exit;
    end;
    Result := Copy(AStr, lBegin + 1, lEnd - (lBegin + 1) );
    Delete(AStr, 1, lEnd);
  end;
var
  temp, found: string;
begin
  temp := Str;
  while temp <> '' do
  begin
    found := SearchTag(temp);
    if found <> '' then
      Dest.Add(found);
  end;                
end;

procedure Ts0StringReplacer.FindTaggedString(Text, Dest: TStrings);
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;
  try
    for i := 0 to Text.Count -1 do
      FindTagStr(Text.Strings[i], sl);
    Dest.Assign(sl);
  finally
    sl.Free;
  end;
end;


procedure Ts0StringReplacer.ReplaceText(Text, Dest, StringSet: TStrings);
begin
  Dest.Text := Replace(Text.Text, StringSet);
end;

function Ts0StringReplacer.Replace(Source: string; StringSet: TStrings;
  AIgnoreCase: Boolean): string;
  function Tagged(AStr: string): string;
  begin
    Result := FTagHeader +AStr+ FTagFooter;
  end;
var
  i: Integer;
  flg: TReplaceFlags;
begin
  Result := Source;
  flg := [rfReplaceAll];
  if AIgnoreCase then
    Include(flg, rfIgnoreCase);
  for i := 0 to StringSet.Count -1 do
    Result := StringReplace(Result, Tagged(StringSet.Names[i]), StringSet.Values[StringSet.Names[i]], flg);
end;


constructor Ts0StringReplacer.Create;
begin
  inherited Create;
  FTagHeader := '<';
  FTagFooter := '>';
end;

end.
