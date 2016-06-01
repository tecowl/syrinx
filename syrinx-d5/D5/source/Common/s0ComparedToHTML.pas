unit s0ComparedToHTML;

interface

uses
  SysUtils, Classes,
  s0Persistent,
  s0TextComparer,
  s0TaggedPage;

type
  Ts0ParserProps = class(Ts0Persistent)
  private
    FStringMark: Char;
    FWordDelimiters: string;
    FLineCommnetMark: string;
    FReservedWords: TStrings;
    FCommentMarkSet1Bgn: string;
    FCommentMarkSet1End: string;
    FCommentMarkSet2Bgn: string;
    FCommentMarkSet2End: string;
    procedure SetReservedWords(const Value: TStrings);
    procedure SetLineCommnetMark(const Value: string);
    procedure SetStringMark(const Value: Char);
    procedure SetWordDelimiters(const Value: string);
    procedure SetCommentMarkSet1Bgn(const Value: string);
    procedure SetCommentMarkSet1End(const Value: string);
    procedure SetCommentMarkSet2Bgn(const Value: string);
    procedure SetCommentMarkSet2End(const Value: string);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WordDelimiters : string    read FWordDelimiters  write SetWordDelimiters ;
    property ReservedWords  : TStrings  read FReservedWords   write SetReservedWords  ;
    property StringMark     : Char      read FStringMark      write SetStringMark     ;
    property LineCommnetMark: string    read FLineCommnetMark write SetLineCommnetMark;
    property CommentMarkSet1Bgn: string read FCommentMarkSet1Bgn write SetCommentMarkSet1Bgn;
    property CommentMarkSet1End: string read FCommentMarkSet1End write SetCommentMarkSet1End;
    property CommentMarkSet2Bgn: string read FCommentMarkSet2Bgn write SetCommentMarkSet2Bgn;
    property CommentMarkSet2End: string read FCommentMarkSet2End write SetCommentMarkSet2End;
  end;

type
  Ks0HTMLColor = type string;

type
  Ks0C2HColorKind = (k0hckCellEqual, k0hckCellDifferent, k0hckCellLike,
    k0hckFontComment, k0hckFontString);
  Ks0C2HColorKindSet = set of Ks0C2HColorKind;

type
  Ts0C2HColors = class(Ts0Persistent)
  private
    FColors: array[Ks0C2HColorKind] of Ks0HTMLColor;
    function GetColors(AKind: Ks0C2HColorKind): Ks0HTMLColor;
    procedure SetColors(AKind: Ks0C2HColorKind; const Value: Ks0HTMLColor);
    function GetPblColors(Index: Integer): Ks0HTMLColor;
    procedure SetPblColors(Index: Integer; const Value: Ks0HTMLColor);
  public
    constructor Create(AOwner: TPersistent); override;
    property Colors[AKind: Ks0C2HColorKind]: Ks0HTMLColor read GetColors write SetColors;
  published
    property CellEqual    : Ks0HTMLColor index 0 read GetPblColors write SetPblColors;
    property CellDifferent: Ks0HTMLColor index 1 read GetPblColors write SetPblColors;
    property CellLike     : Ks0HTMLColor index 2 read GetPblColors write SetPblColors;
    property FontComment  : Ks0HTMLColor index 3 read GetPblColors write SetPblColors;
    property FontString   : Ks0HTMLColor index 4 read GetPblColors write SetPblColors;
  end;

type
  Ts0ComparedToHTML = class(TComponent)
  private
    FTarget: Ts0TextComparer;
    FDest: Ts0TaggedPage;
    FParserProps: Ts0ParserProps;
    FParserPropsName: string;
    FColors: Ts0C2HColors;
    procedure SetTarget(const Value: Ts0TextComparer);
    procedure SetDest(const Value: Ts0TaggedPage);
    procedure SetParserProps(const Value: Ts0ParserProps);
    procedure SetParserPropsName(const Value: string);
    procedure SetColors(const Value: Ts0C2HColors);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    class function HTMLQuoted(AStr: string): string;
    class function ReplaceHTMLSpace(AStr: string): string;
  published
    property Target: Ts0TextComparer read FTarget write SetTarget;
    property Dest: Ts0TaggedPage read FDest write SetDest;
    property Colors: Ts0C2HColors read FColors write SetColors;
    property ParserProps: Ts0ParserProps read FParserProps write SetParserProps;
    property ParserPropsName: string read FParserPropsName write SetParserPropsName;
  end;

type
  Es0ComparedToHTML = class(Exception);

type
  Ts0ParserPropsMan = class
  private
    FPropsList: TStrings;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function PropsByName(AName: string): Ts0ParserProps;
    procedure RegisterProps(AProps: Ts0ParserProps; AName: string);
    procedure UnRegisterProps(AProps: Ts0ParserProps);
    procedure GetPropsNames(Proc: TGetStrProc);
    class function Instance: Ts0ParserPropsMan;
  end;

procedure Register;

implementation

uses
  s0StringsHelper;

procedure Register;
begin
  RegisterComponents('P DM', [Ts0ComparedToHTML]);
end;

{ Ts0ParserProps }

procedure Ts0ParserProps.Assign(Source: TPersistent);
var
  src: Ts0ParserProps;
begin
  inherited;
  if not(Source is Ts0ParserProps) then Exit;
  src := Ts0ParserProps(Source);
  FStringMark      := src.FStringMark     ;
  FCommentMarkSet1Bgn := src.FCommentMarkSet1Bgn;
  FCommentMarkSet1End := src.FCommentMarkSet1End;
  FCommentMarkSet2Bgn := src.FCommentMarkSet2Bgn;
  FCommentMarkSet2End := src.FCommentMarkSet2End;
  FWordDelimiters  := src.FWordDelimiters ;
  FLineCommnetMark := src.FLineCommnetMark;
  FReservedWords.Assign( src.FReservedWords );
end;

constructor Ts0ParserProps.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FReservedWords := TStringList.Create;
end;

destructor Ts0ParserProps.Destroy;
begin
  FreeAndNil(FReservedWords);
  inherited;  
end;

procedure Ts0ParserProps.SetCommentMarkSet1Bgn(const Value: string);
begin
  FCommentMarkSet1Bgn := Value;
end;

procedure Ts0ParserProps.SetCommentMarkSet1End(const Value: string);
begin
  FCommentMarkSet1End := Value;
end;

procedure Ts0ParserProps.SetCommentMarkSet2Bgn(const Value: string);
begin
  FCommentMarkSet2Bgn := Value;
end;

procedure Ts0ParserProps.SetCommentMarkSet2End(const Value: string);
begin
  FCommentMarkSet2End := Value;
end;

procedure Ts0ParserProps.SetLineCommnetMark(const Value: string);
begin
  FLineCommnetMark := Value;
end;

procedure Ts0ParserProps.SetReservedWords(const Value: TStrings);
begin
  FReservedWords.Assign(Value);
end;

procedure Ts0ParserProps.SetStringMark(const Value: Char);
begin
  FStringMark := Value;
end;

procedure Ts0ParserProps.SetWordDelimiters(const Value: string);
begin
  FWordDelimiters := Value;
end;

{ Ts0C2HColors }

const
  c9DefaultColors: array[Ks0C2HColorKind] of Ks0HTMLColor = (
    '', 'pink', 'orange', 'blue', 'DarkGreen'
  );

constructor Ts0C2HColors.Create(AOwner: TPersistent);
var
  i: Ks0C2HColorKind;
begin
  inherited;
  for i := Low(Ks0C2HColorKind) to High(Ks0C2HColorKind) do
    FColors[i] := c9DefaultColors[i];
end;

function Ts0C2HColors.GetColors(AKind: Ks0C2HColorKind): Ks0HTMLColor;
begin
  Result := FColors[AKind];
end;

function Ts0C2HColors.GetPblColors(Index: Integer): Ks0HTMLColor;
begin
  Result := FColors[ Ks0C2HColorKind(Index) ];
end;

procedure Ts0C2HColors.SetColors(AKind: Ks0C2HColorKind;
  const Value: Ks0HTMLColor);
begin
  FColors[AKind] := Value;
end;

procedure Ts0C2HColors.SetPblColors(Index: Integer;
  const Value: Ks0HTMLColor);
begin
  FColors[ Ks0C2HColorKind(Index) ] := Value;
end;

{ Ts0ComparedToHTML }

constructor Ts0ComparedToHTML.Create(AOwner: TComponent);
begin
  inherited;
  FParserProps := Ts0ParserProps.Create(Self);
  FColors := Ts0C2HColors.Create(Self);
end;

destructor Ts0ComparedToHTML.Destroy;
begin
  FreeAndNil(FColors);
  FreeAndNil(FParserProps);
  inherited;
end;

class function Ts0ComparedToHTML.HTMLQuoted(AStr: string): string;
begin
  Result := AnsiQuotedStr(AStr, '"');
end;

class function Ts0ComparedToHTML.ReplaceHTMLSpace(AStr: string): string;
begin
  Result := StringReplace(AStr, ' ', '&nbsp;', [rfReplaceAll, rfIgnoreCase]);
end;

resourcestring
  c9ErrMsg_DestIsNil = 'Dest‚ªnil‚Å‚·';
  c9ErrMsg_TargetIsNil = 'Target‚ªnil‚Å‚·';

procedure Ts0ComparedToHTML.Execute;
  function PrepareTable: Ts0Tag;
    function NewDecorateWithTag(AParent: Ts0Tag; AKind: K0ComparedType): Ts0Tag;
    var
      colorStr: string;
    begin
      Result := AParent.Contents.AddTag('td');
      Result.Params.Values['valign'] := HTMLQuoted('top');
      Result.Params.Values['align'] := HTMLQuoted('left');
      case AKind of
        kcrDifferent: colorStr := HTMLQuoted( Colors.CellDifferent ) ;
        kcrEqual    : ; //colorStr := HTMLQuoted( Colors.CellEqual );
        kcrLike     : colorStr := HTMLQuoted( Colors.CellLike );
      end;
      if colorStr <> '' then
        Result.Params.Values['bgcolor'] := colorStr;
    end;
  var
    i: Integer;
    row: Ts0Tag;
    resItem: Ts0CompareResultItem;
  begin
    Result := FDest.Contents.AddTag('table');
    Result.Params.Values['border'] := HTMLQuoted( '0' );
    for i := 0 to FTarget.CompareResult.Count -1 do
    begin
      resItem := FTarget.CompareResult[i];
      row := Result.Contents.AddTag('tr');
      NewDecorateWithTag(row, resItem.ComparedType);
      NewDecorateWithTag(row, resItem.ComparedType);
    end;
    if Colors.CellEqual <> '' then
      Result.Params.Values['bgcolor'] := Colors.CellEqual;
  end;
  procedure DecorateWithTag(ATable: Ts0Tag; ACol: Integer);
    function AddColored(AParent: Ts0Tag; AStr: string; AColor: string): Ts0Tag;
    begin
      Result := AParent.Contents.AddTagWithParam(
        'font', [Format('color=%s', [HTMLQuoted(AColor)]) ]);
      Result.Contents.AddDescription(ReplaceHTMLSpace(AStr));
    end;
    function AddBold(AParent: Ts0Tag; AStr: string): Ts0Tag;
    begin
      Result := AParent.Contents.AddTag('b');
      Result.Contents.AddDescription(ReplaceHTMLSpace(AStr));
    end;
  type
    K9StrMode = (k9smNormal, k9smString, k9smComment1, k9smComment2);
  var
    i: Integer;
    cell: Ts0Tag;
    mode: K9StrMode;
    line, wordBuf, buf: string;
  begin
    mode := k9smNormal;
    for i := 0 to FTarget.CompareResult.Count -1 do
    begin
      cell := ATable.Contents[i * 2].Contents[ACol * 2];
      line := FTarget.CompareResult[i].Strings[ACol + 1];
      buf := '';
      wordBuf := '';
      while line <> '' do
      begin
        case mode of
          k9smNormal:
          begin
            if Pos(ParserProps.LineCommnetMark, line) = 1 then
            begin
              if buf <> '' then cell.Contents.AddDescription(ReplaceHTMLSpace(buf));
              AddColored(cell, line, Colors.FontComment);
              line := '';
              buf := '';
              mode := k9smNormal;
              Continue;
            end
            else
            if Pos(ParserProps.CommentMarkSet1Bgn, line) = 1 then
            begin
              if buf <> '' then cell.Contents.AddDescription(ReplaceHTMLSpace(buf));
              buf := '';
              mode := k9smComment1;
            end
            else
            if Pos(ParserProps.CommentMarkSet2Bgn, line) = 1 then
            begin
              if buf <> '' then cell.Contents.AddDescription(ReplaceHTMLSpace(buf));
              buf := '';
              mode := k9smComment2;
            end
            else
            if Pos(ParserProps.StringMark, line) = 1 then
            begin
              if buf <> '' then cell.Contents.AddDescription(ReplaceHTMLSpace(buf));
              buf := '';
              mode := k9smString;
            end
            else
            if Pos(line[1], ParserProps.WordDelimiters) > 0 then
            begin
              if (wordBuf <> '') and (ParserProps.ReservedWords.IndexOf(LowerCase(wordBuf)) > -1) then
              begin
                if buf <> '' then
                  cell.Contents.AddDescription(ReplaceHTMLSpace(buf));
                buf := '';
                AddBold(cell, wordBuf);
              end
              else
              begin
                buf := buf + wordBuf;
              end;
              buf := buf + line[1];
              wordBuf := '';
              Delete(line, 1, 1);
              Continue;
            end
            else
            begin
              wordBuf := wordBuf + line[1];
              Delete(line, 1, 1);
              Continue;
            end;
          end;

          k9smString:
            if Pos(ParserProps.StringMark, line) = 1 then
            begin
              buf := buf + ParserProps.StringMark;
              AddColored(cell, buf, Colors.FontString);
              buf := '';
              Delete(line, 1, Length(ParserProps.StringMark));
              mode := k9smNormal;
            end;

          k9smComment1:
            if Pos(ParserProps.CommentMarkSet1End, line) = 1 then
            begin
              buf := buf + ParserProps.CommentMarkSet1End;
              AddColored(cell, buf, Colors.FontComment);
              buf := '';
              Delete(line, 1, Length(ParserProps.CommentMarkSet1End));
              mode := k9smNormal;
            end;

          k9smComment2:
            if Pos(ParserProps.CommentMarkSet2End, line) = 1 then
            begin
              buf := buf + ParserProps.CommentMarkSet2End;
              AddColored(cell, buf, Colors.FontComment);
              buf := '';
              Delete(line, 1, Length(ParserProps.CommentMarkSet1End));
              mode := k9smNormal;
            end;
        end;
        if line = '' then Continue;
        buf := buf + line[1];
        Delete(line, 1, 1);
      end; //while
      //
      case mode of
        k9smNormal  :
          if ParserProps.ReservedWords.IndexOf(LowerCase(wordBuf)) > -1 then
          begin
            if buf <> '' then cell.Contents.AddDescription(ReplaceHTMLSpace(buf));
            AddBold(cell, wordBuf)
          end
          else
          if (buf + wordBuf <> '') then
            cell.Contents.AddDescription(ReplaceHTMLSpace(buf + wordBuf));
        k9smString  :
          if buf <> '' then
            AddColored(cell, buf, Colors.FontString);
        k9smComment1,
        k9smComment2:
          if buf <> '' then
            AddColored(cell, buf, Colors.FontComment);
      end;
      //
      if cell.AllDescriptions = '' then
        cell.Contents.AddDescription(ReplaceHTMLSpace(' '));
    end;
  end;
var
  i: Integer;
  tbl: Ts0Tag;
begin
  if FTarget = nil then raise Es0ComparedToHTML.Create(c9ErrMsg_TargetIsNil);
  if FDest = nil then raise Es0ComparedToHTML.Create(c9ErrMsg_DestIsNil);
  FDest.Contents.BeginUpdate;
  try
    tbl := PrepareTable;
    for i := 0 to 1 do
      DecorateWithTag(tbl, i);
  finally
    FDest.Contents.EndUpdate;
  end;
end;

procedure Ts0ComparedToHTML.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation <> opRemove then Exit;
  if FTarget = AComponent then FTarget := nil;
  if FDest = AComponent then FDest := nil;
end;                  

procedure Ts0ComparedToHTML.SetColors(const Value: Ts0C2HColors);
begin
  FColors.Assign(Value);
end;

procedure Ts0ComparedToHTML.SetDest(const Value: Ts0TaggedPage);
begin
  FDest := Value;
end;

procedure Ts0ComparedToHTML.SetParserProps(const Value: Ts0ParserProps);
begin
  FParserProps.Assign( Value );
end;

procedure Ts0ComparedToHTML.SetParserPropsName(const Value: string);
var
  p: Ts0ParserProps;
begin
  FParserPropsName := Value;
  p := Ts0ParserPropsMan.Instance.PropsByName(FParserPropsName);
  if p = nil then Exit;
  FParserProps.Assign(p);
end;

procedure Ts0ComparedToHTML.SetTarget(const Value: Ts0TextComparer);
begin
  FTarget := Value;
end;

{ Ts0ParserPropsMan }

procedure Ts0ParserPropsMan.Clear;
var
  i: Integer;
begin
  for i := FPropsList.Count -1 downto 0 do
    FPropsList.Objects[i].Free;
  FPropsList.Clear;
end;

constructor Ts0ParserPropsMan.Create;
begin
  inherited Create;
  FPropsList := TStringList.Create;
end;

destructor Ts0ParserPropsMan.Destroy;
begin
  Clear;
  FreeAndNil(FPropsList);
  inherited;           
end;

procedure Ts0ParserPropsMan.GetPropsNames(Proc: TGetStrProc);
var
  i: Integer;
begin
  for i := 0 to FPropsList.Count -1 do
    Proc(FPropsList.Strings[i]);
end;

var
  g9PropsMan: Ts0ParserPropsMan = nil;

class function Ts0ParserPropsMan.Instance: Ts0ParserPropsMan;
begin
  if g9PropsMan = nil then
    g9PropsMan := Ts0ParserPropsMan.Create;
  Result := g9PropsMan;
end;

function Ts0ParserPropsMan.PropsByName(AName: string): Ts0ParserProps;
begin
  Result := Ts0ParserProps( Ts0StringsHelper.ObjectByStr(FPropsList, AName) );
end;

procedure Ts0ParserPropsMan.RegisterProps(AProps: Ts0ParserProps; AName: string);
begin
  if FPropsList.IndexOf(AName) > -1 then Exit;
  FPropsList.AddObject(AName, AProps);
end;

procedure Ts0ParserPropsMan.UnRegisterProps(AProps: Ts0ParserProps);
begin
  Ts0StringsHelper.DeleteByObj(FPropsList, AProps);
end;


{ NewNormalProps }

function NewNormalProps: Ts0ParserProps;
begin
  Result := Ts0ParserProps.Create(nil);
  Result.StringMark := '''';
  Result.LineCommnetMark := '';
  Result.CommentMarkSet1Bgn := '';
  Result.CommentMarkSet1Bgn := '';
  Result.CommentMarkSet2Bgn := '';
  Result.CommentMarkSet2End := '';
  Result.WordDelimiters := ' ,.;:#$()[]+-*/=<>_';
  Result.ReservedWords.Clear;
end;

{ RegisterPasProps }

function NewPasProps: Ts0ParserProps;
begin
  Result := Ts0ParserProps.Create(nil);
  Result.StringMark := '''';
  Result.LineCommnetMark := '//';
  Result.CommentMarkSet1Bgn := '{';
  Result.CommentMarkSet1End := '}';
  Result.CommentMarkSet2Bgn := '(*';
  Result.CommentMarkSet2End := '*)';
  Result.WordDelimiters := ' ,.;:#$()[]+-*/=<>';
  Ts0StringsHelper.CopyToStrings(
    Result.ReservedWords,
    [
    //Order
      'absolute'   , 'abstract'   , 'assembler'  , 'automated'  , 'cdecl'      ,
      'contains'   , 'default'    , 'dispid'     , 'dynamic'    , 'export'     ,
      'external'   , 'far'        , 'forward'    , 'implements' , 'index'      ,
      'message'    , 'name'       , 'near'       , 'nodefault'  , 'overload'   ,
      'override'   , 'package'    , 'pascal'     , 'private'    , 'protected'  ,
      'public'     , 'published'  , 'read'       , 'readonly'   , 'register'   ,
      'reintroduce', 'requires'   , 'resident'   , 'safecall'   , 'stdcall'    ,
      'stored'     , 'virtual'    , 'write'      ,
      'writeonly',
    //Reserved
      'and'           ,    'array'         ,    'as'            ,    'asm'           ,    'begin'         ,
      'case'     	    ,    'class'         ,    'const'         ,    'constructor'   ,    'destructor'    ,    'dispinterface' ,
      'div'           ,    'do'            ,    'downto'        ,    'else'          ,    'end'           ,    'except'        ,
      'exports'       ,    'file'          ,    'finalization'  ,    'finally'       ,    'for'           ,    'function'      ,
      'goto'          ,    'if'            ,    'implementation',    'in'            ,    'inherited'     ,    'initialization',
      'inline'        ,    'interface'     ,    'is'            ,    'label'         ,    'library'       ,    'mod'           ,
      'nil'           ,    'not'           ,    'object'        ,    'of'            ,    'or'            ,    'out'           ,
      'packed'        ,    'procedure'     ,    'program'       ,    'property'      ,    'raise'         ,    'record'        ,
      'repeat'        ,    'resourcestring',    'set'           ,    'shl'           ,    'shr'           ,    'string'        ,
      'then'          ,    'threadvar'     ,    'to'            ,    'try'           ,    'type'          ,    'unit'          ,
      'until'         ,    'uses'          ,    'var'           ,    'while'         ,    'with'          ,    'xor'
    ]
  );
end;     

initialization
  Ts0ParserPropsMan.Instance.RegisterProps(NewNormalProps, 'Normal');
  Ts0ParserPropsMan.Instance.RegisterProps(NewPasProps, 'Object Pascal');

finalization
  FreeAndNil( g9PropsMan );

end.
