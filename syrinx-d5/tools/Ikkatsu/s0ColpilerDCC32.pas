unit s0ColpilerDCC32;
{
コマンドラインコンパイラオプション一覧

A          |  |unit=alias|ユニットのエリアス設定
B          |  |          |すべてのユニットの構築
CC         |  |          |コンソールアプリケーションの作成
CG         |  |          |GUI アプリケーションの作成
D          |  |defines   |条件シンボルの定義
E          |  |path      |EXE のディレクトリ
F          |  |address   |実行時エラーの検出
GS         |  |          |セグメント付きマップファイル
GP         |  |          |パブリック付きマップファイル
GD         |  |          |詳細マップファイル
H          |  |          |ヒントメッセージの表示
I          |  |paths     |インクルードディレクトリ
J          |  |          |OBJ ファイルの作成
JP         |  |          |C++ OBJ ファイルの作成
K          |  |address   |イメージベースアドレスの設定
LE         |  |path      |パッケージの BPL ディレクトリ
LN         |  |path      |パッケージの DCP ディレクトリ
LU         |  |package   |アプリケーションで使用する追加の実行時パッケージの指定
M          |  |          |メイク（変更ユニットのみ再コンパイル）
N          |  |path      |DCU ディレクトリ
O          |  |paths     |オブジェクトファイルディレクトリ
P          |  |          |8.3 ファイル名を検索
Q          |  |          |Quiet モードコンパイル
R          |  |paths     |リソースファイルディレクトリ
TX         |  |ext       |ターゲットファイル拡張子
U          |  |paths     |ユニットファイルディレクトリ
V          |  |          |Turbo Debugger デバッグ情報
VN         |  |          |名前空間のデバッグ情報を，C++Builder で使われる Giant 形式で生成
VR         |  |          |リモートデバッグ用の rsm ファイルの生成
W          |  |          |警告メッセージの出力
Z          |  |          |暗黙のコンパイルの抑止
--Help     |D6|          |［ヘルプ］画面の表示オプションの表示。また，コマンドラインに dcc32 だけを入力すると，コマンドラインコンパイラの構文とオプションの一覧が表示されます。
--version  |D6|          |プロジェクトの名前とバージョンの表示

$directive |  |          |コンパイラ指令

$A |  |+/-  |+|フィールドのアラインメント
$B |  |+/-  |-|論理式の評価
$C |  |+/-  |+|アサート
$D |  |+/-  |+|デバッグ情報
$G |  |+/-  |+|インポートデータ
$H |  |+/-  |+|長い文字列
$I |  |+/-  |+|入出力チェック
$J |  |+/-  |+|書き込み可能な型付き定数
$L |  |+/-  |+|ローカルシンボル情報
$M |  |+/-  |-|実行時型情報
$O |  |+/-  |+|最適化
$P |  |+/-  |+|オープン文字列パラメータ
$Q |  |+/-  |-|数値演算オーバーフローチェック
$R |  |+/-  |-|範囲チェック
$T |  |+/-  |-|型チェックポインタ
$U |  |+/-  |-|Pentiumの安全なFDIV演算
$V |  |+/-  |+|変数文字列チェック
$W |  |+/-  |-|Windowsスタックフレーム
$X |  |+/-  |+|拡張構文
$Y |  |+/-/D|D|シンボル参照情報
$Z |  |1/2/4|1|列挙型サイズ
}

{
コンパイラ指令の一覧
# 上の$A～$Z以外は使わないけど、せっかく調べてもったいないから残しておく。

$A                 |  |+/-               |+             |フィールドのアラインメント
$ALIGN             |  |ON/OFF            |ON            |フィールドのアラインメント
$APPTYPE           |  |GUI/CONSOLE       |GUI           |アプリケーションの種類
$B                 |  |+/-               |-             |論理式の評価
$BOOLEVAL          |  |ON/OFF            |OFF           |論理式の評価
$C                 |  |+/-               |+             |アサート
$ASSERTIONS        |  |ON/OFF            |ON            |アサート
$D                 |  |+/-               |+             |デバッグ情報
$DEBUGINFO         |  |ON/OFF            |ON            |デバッグ情報
$D                 |  |param             |              |記述説明
$DESCRIPTION       |  |param             |              |記述説明
$DENYPACKAGEUNIT   |  |ON/OFF            |OFF           |ユニットがパッケージに含まれることを防ぐ
$DESIGNONLY        |  |ON/OFF            |OFF           |IDEへのインストール用パッケージ
$E                 |  |extension         |              |実行形式ファイルの拡張子
$EXTENSION         |D6|extension         |              |実行形式ファイルの拡張子
$EXTERNALSYM       |  |param             |              |外部シンボル
$G                 |  |+/-               |+             |インポートデータ
$H                 |  |+/-               |+             |長い文字列
$LONGSTRINGS       |  |ON/OFF            |ON            |長い文字列
$HINTS             |  |ON/OFF            |ON            |コンパイラヒント
$HPPEMIT           |  |param             |              |C++Builder用追加シンボル
$I                 |  |+/-               |+             |入出力チェック
$IOCHECKS          |  |ON/OFF            |ON            |入出力チェック
$I                 |  |filename          |              |インクルードファイル
$INCLUDE           |  |filename          |              |インクルードファイル
$IMAGEBASE         |  |number            |$00400000     |イメージベースアドレス
$IMPLICITBUILD     |  |ON/OFF            |ON            |暗黙の構築
$IMPORTEDDATA      |  |ON/OFF            |ON            |インポートデータ
$P                 |  |+/-               |+             |オープン文字列パラメータ
$J                 |  |+/-               |+             |書き込み可能な型付き定数
$WRITABLECONST     |  |ON/OFF            |ON            |書き込み可能な型付き定数
$L                 |  |+/-               |+             |ローカルシンボル情報
$LOCALSYMBOLS      |  |ON/OFF            |ON            |ローカルシンボル情報
$L                 |  |filename          |              |リンクオブジェクトファイル
$LINK              |  |filename          |              |リンクオブジェクトファイル
$LIBPREFIX         |D6|param             |              |ライブラリ用コンパイラ指令
$LIBSUFFIX         |D6|param             |              |ライブラリ用コンパイラ指令
$LIBVERSION        |D6|param             |              |ライブラリ用コンパイラ指令
$M                 |  |+/-               |-             |実行時型情報
$TYPEINFO          |  |ON/OFF            |OFF           |実行時型情報
$M                 |  |min,max           |16384,1048576 |スタック割り当てサイズ
$MINSTACKSIZE      |  |number            |16384         |スタックサイズ<最小>
$MAXSTACKSIZE      |  |number            |1048576       |スタックサイズ<最大>
$MESSAGE           |D6|identifier msg    |              |メッセージ [HINT/WARN/ERROR/FATAL]
$NODEFINE          |  |identifier        |              |プライベートシンボル
$NOINCLUDE         |  |filename          |              |プライベートユニット
$O                 |  |+/-               |+             |最適化
$OPTIMIZATION      |  |ON/OFF            |ON            |最適化
$ObjExportAll      |  |On/Off            |Off           |シンボルのエクスポート
$OPENSTRINGS       |  |ON/OFF            |ON            |オープン文字列パラメータ
$Q                 |  |+/-               |-             |数値演算オーバーフローチェック
$OVERFLOWCHECKS    |  |ON/OFF            |OFF           |数値演算オーバーフローチェック
$R                 |  |+/-               |-             |範囲チェック
$RANGECHECKS       |  |ON/OFF            |OFF           |範囲チェック
$R                 |  |filename          |              |リソースファイル
$RESOURCE          |  |filename          |              |リソースファイル
$REALCOMPATIBILITY |  |ON/OFF            |OFF           |Real48 との互換性
$RUNONLY           |  |ON/OFF            |OFF           |実行時専用パッケージ
$SetPEFlags        |D6|                  |              |PEヘッダーフラグ
$SetPEOptFlags     |D6|                  |              |PEヘッダーフラグ
$T                 |  |+/-               |-             |型チェックポインタ
$TYPEDADDRESS      |  |ON/OFF            |OFF           |型チェックポインタ
$U                 |  |+/-               |-             |Pentiumの安全な FDIV 演算
$SAVEDIVIDE        |  |ON/OFF            |OFF           |Pentiumの安全な FDIV 演算
$V                 |  |+/-               |+             |変数文字列チェック
$VARSTRINGCHECKS   |  |ON/OFF            |ON            |変数文字列チェック
$W                 |  |+/-               |-             |Windows スタックフレーム
$STACKFRAMES       |  |ON/OFF            |OFF           |Windows スタックフレーム
$W                 |D6|+/-               |+             |警告メッセージ
$WARN              |D6|identifier ON/OFF |              |警告メッセージ
$WARNINGS          |  |ON/OFF            |ON            |コンパイラ警告
$WEAKPACKAGEUNIT   |  |ON/OFF            |OFF           |弱いパッケージ化
$X                 |  |+/-               |+             |拡張構文
$EXTENDSYNTAX      |  |ON/OFF            |ON            |拡張構文
$Y                 |  |+/-/D             |D             |シンボル参照情報
$DEFINITIONINFO    |  |ON/OFF            |ON            |シンボル参照情報
$REFERENCEINFO     |  |ON/OFF            |OFF           |シンボル参照情報
$Z                 |  |1/2/4             |1             |列挙型サイズ
$MINENUMSIZE       |  |1/2/4             |1             |列挙型サイズ

WARN identifier
SYMBOL_PLATFORM	現在のユニット内のシンボルについて，platform 指令に関するすべての警告を有効または無効にします。
SYMBOL_LIBRARY	現在のユニット内のシンボルについて，library 指令に関するすべての警告を有効または無効にします。
SYMBOL_DEPRECATED	現在のユニット内のシンボルについて，deprecated 指令に関するすべての警告を有効または無効にします。
UNIT_DEPRECATED	ユニット宣言に適用された deprecated 指令に関するすべての警告を有効または無効にします。
UNIT_LIBRARY	library 指令が指定されているユニット内で，library 指令に関するすべての警告を有効または無効にします。
UNIT_PLATFORM	platform 指令が指定されているユニット内で，platform 指令に関するすべての警告を有効または無効にします。

$ELSEIF            //D6//                    //条件コンパイル
$IF                //D6//                    //条件コンパイル
$IFEND             //D6//                    //条件コンパイル
$DEFINE            //  //name                //条件コンパイル
$ELSE              //  //                    //条件コンパイル
$ENDIF             //  //                    //条件コンパイル
$IFDEF             //  //name                //条件コンパイル
$IFNDEF            //  //name                //条件コンパイル
$IFOPT             //  //switch              //条件コンパイル
$UNDEF             //  //name                //条件コンパイル
}

interface

uses
  SysUtils, Classes,
  s0Persistent,
  s0Collection;

type
  K0CLCParamTypeKind = (
    k0cokNone,
    k0cokSwitch,
    k0cokSelection,
    k0cokNameAndValue,
    k0cokDefines,
    k0cokPath,
    k0cokPaths,
    k0cokAddress,
    k0cokPackage,
    k0cokExt
  );

type
  //CLC: Command Line Compiler
  Ts0CLCParamType = class(Ts0CollectionItem)
  private
    FTypeKind: K0CLCParamTypeKind;
    FDefaultValue: string;
    FParamTypeName: string;
    FDescription: string;
    FSelections: TStrings;
    procedure SetDefaultValue(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetParamTypeName(const Value: string);
    procedure SetSelections(const Value: TStrings);
    procedure SetTypeKind(const Value: K0CLCParamTypeKind);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ParamTypeName: string read FParamTypeName write SetParamTypeName;
    property Description: string read FDescription write SetDescription;
    property TypeKind: K0CLCParamTypeKind read FTypeKind write SetTypeKind;
    property Selections: TStrings read FSelections write SetSelections;
    property DefaultValue: string read FDefaultValue write SetDefaultValue;
  end;

type
  Ts0CLCParamTypes = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0CLCParamType;
    procedure SetItems(const Index: Integer; const Value: Ts0CLCParamType);
  public
    function Add(AName: string; AKind: K0CLCParamTypeKind; ADesc: string ='';
      ADefault: string = ''): Ts0CLCParamType;
    function AddWith(AName: string; 
      ASelection: array of string; ADefault: string = ''; ADesc: string =''
      ): Ts0CLCParamType;
    function ItemByName(AName: string): Ts0CLCParamType;
    property Items[const Index: Integer]: Ts0CLCParamType read GetItems write SetItems;
  end;

type
  K0CLCVersion = (k0clcv130, k0clcv140);

type
  Ts0CLCParamTypeSet = class(TComponent)
  private
    FVersion: K0CLCVersion;
    FParamTypes: Ts0CLCParamTypes;
    procedure SetParamTypes(const Value: Ts0CLCParamTypes);
    procedure SetVersion(const Value: K0CLCVersion);
  protected
    procedure InitParamTypes; virtual;
    class procedure ClearInstances;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function Instance: Ts0CLCParamTypeSet;
  published
    property Version: K0CLCVersion read FVersion write SetVersion;
    property ParamTypes: Ts0CLCParamTypes read FParamTypes write SetParamTypes;
  end;



type
  Ts0CLCParam = class(Ts0CollectionItem)
  private
    FParamName: string;
    FParamValue: string;
    FEnabled: Boolean;
    procedure SetParamName(const Value: string);
    procedure SetParamValue(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    function GetLineStr: string;
    procedure SetLineStr(Value: string);
  protected
    function GetParamType: Ts0CLCParamType;
    function GetParamTypes: Ts0CLCParamTypes; virtual;
  public
    constructor Create(ACollection: TCollection); override;
    property ParamType: Ts0CLCParamType read GetParamType;
    property LineStr: string read GetLineStr write SetLineStr;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property ParamName: string read FParamName write SetParamName;
    property ParamValue: string read FParamValue write SetParamValue;
  end;

type
  Ts0CLCParams = class(Ts0Collection)
  private
    function GetItems(const Index: Integer): Ts0CLCParam;
    procedure SetItems(const Index: Integer;
      const Value: Ts0CLCParam);
  public
    function Add(AParam: string = ''; AEnabled: Boolean = True): Ts0CLCParam;
    function AddLine(ALine: string): Ts0CLCParam;
    property Items[const Index: Integer]: Ts0CLCParam read GetItems write SetItems;
  end;

type
  Ts0CLCOption = class(Ts0Persistent)
  private
    FParams: Ts0CLCParams;
    procedure SetParams(const Value: Ts0CLCParams);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    function GetParamStr: string;
    procedure GetParamList(Dest: TStrings);
  published
    property Params: Ts0CLCParams read FParams write SetParams;
  end;

type
  Ts0CommandLineCompiler = class(TComponent)
  private
    FCLCConfig: Ts0CLCOption;
    FExeFileName: TFileName;
    FCLCVersion: K0CLCVersion;
    FExecResult: TStrings;
    procedure SetCLCConfig(const Value: Ts0CLCOption);
    procedure SetCLCVersion(const Value: K0CLCVersion);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute(ASourceFile: string);
    property ExecResult: TStrings read FExecResult;
  published
    property ExeFileName: TFileName read FExeFileName write FExeFileName;
    property CLCVersion: K0CLCVersion read FCLCVersion write SetCLCVersion;
    property CLCConfig: Ts0CLCOption read FCLCConfig write SetCLCConfig;
  end;

implementation

uses
  ShellAPI, Forms,
  s0ExecFile,
  s0StringHelper;           

{ Ts0CLCParamType }

procedure Ts0CLCParamType.Assign(Source: TPersistent);
begin
  inherited;

end;

constructor Ts0CLCParamType.Create(ACollection: TCollection);
begin
  inherited;
  FSelections := TStringList.Create;
end;

destructor Ts0CLCParamType.Destroy;
begin
  FreeAndNil(FSelections);
  inherited;              
end;

procedure Ts0CLCParamType.SetDefaultValue(const Value: string);
begin
  FDefaultValue := Value;
end;

procedure Ts0CLCParamType.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure Ts0CLCParamType.SetParamTypeName(const Value: string);
begin
  FParamTypeName := Value;
end;

procedure Ts0CLCParamType.SetSelections(const Value: TStrings);
begin
  FSelections.Assign(Value);
end;

procedure Ts0CLCParamType.SetTypeKind(const Value: K0CLCParamTypeKind);
begin
  FTypeKind := Value;
end;

{ Ts0CLCParamTypes }

function Ts0CLCParamTypes.Add(AName: string; AKind: K0CLCParamTypeKind;
  ADesc, ADefault: string): Ts0CLCParamType;
begin
  Result := Ts0CLCParamType(inherited Add);
  Result.ParamTypeName := AName;
  Result.TypeKind := AKind;
  Result.Description := ADesc;
  Result.DefaultValue := ADefault;
end;

function Ts0CLCParamTypes.AddWith(AName: string; 
  ASelection: array of string; ADefault, ADesc: string): Ts0CLCParamType;
var
  i: Integer;
begin
  Result := Add(AName, k0cokSelection, ADesc, ADefault);
  for i := Low(ASelection) to High(ASelection) do
    Result.Selections.Add(ASelection[i]);
end;

function Ts0CLCParamTypes.GetItems(const Index: Integer): Ts0CLCParamType;
begin
  Result := Ts0CLCParamType(inherited Items[Index]);
end;

function Ts0CLCParamTypes.ItemByName(AName: string): Ts0CLCParamType;
var
  i: Integer;
begin
  for i := 0 to Self.Count -1 do
  begin
    Result := Items[i];
    if Result.ParamTypeName = AName then Exit;
  end;
  Result := nil;
end;

procedure Ts0CLCParamTypes.SetItems(const Index: Integer;
  const Value: Ts0CLCParamType);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CLCParamTypeSet }

var
  g9ParamTypeSet: Ts0CLCParamTypeSet;

class procedure Ts0CLCParamTypeSet.ClearInstances;
begin
  FreeAndNil(g9ParamTypeSet);
end;

constructor Ts0CLCParamTypeSet.Create(AOwner: TComponent);
begin
  inherited;
  FParamTypes := Ts0CLCParamTypes.Create(Self, Ts0CLCParamType); 
end;

destructor Ts0CLCParamTypeSet.Destroy;
begin
  FreeAndNil(FParamTypes);
  inherited;              
end;

procedure Ts0CLCParamTypeSet.InitParamTypes;
var
  p: Ts0CLCParamTypes;
begin
//コマンドラインコンパイラオプション
  p := Self.ParamTypes;
  p.Add('A' , {unit=alias}k0cokNameAndValue, 'ユニットのエリアス設定');
  p.Add('B' , {          }k0cokNone        , 'すべてのユニットの構築');
  p.Add('CC', {          }k0cokNone        , 'コンソールアプリケーションの作成');
  p.Add('CG', {          }k0cokNone        , 'GUI アプリケーションの作成');
  p.Add('D' , {defines   }k0cokDefines     , '条件シンボルの定義');
  p.Add('E' , {path      }k0cokPath        , 'EXE のディレクトリ');
  p.Add('F' , {address   }k0cokAddress     , '実行時エラーの検出');
  p.Add('GS', {          }k0cokNone        , 'セグメント付きマップファイル');
  p.Add('GP', {          }k0cokNone        , 'パブリック付きマップファイル');
  p.Add('GD', {          }k0cokNone        , '詳細マップファイル');
  p.Add('H' , {          }k0cokNone        , 'ヒントメッセージの表示');
  p.Add('I' , {paths     }k0cokPaths       , 'インクルードディレクトリ');
  p.Add('J' , {          }k0cokNone        , 'OBJ ファイルの作成');
  p.Add('JP', {          }k0cokNone        , 'C++ OBJ ファイルの作成');
  p.Add('K' , {address   }k0cokAddress     , 'イメージベースアドレスの設定');
  p.Add('LE', {path      }k0cokPath        , 'パッケージの BPL ディレクトリ');
  p.Add('LN', {path      }k0cokPath        , 'パッケージの DCP ディレクトリ');
  p.Add('LU', {package   }k0cokPackage     , 'アプリケーションで使用する追加の実行時パッケージの指定');
  p.Add('M' , {          }k0cokNone        , 'メイク（変更ユニットのみ再コンパイル）');
  p.Add('N' , {path      }k0cokPath        , 'DCU ディレクトリ');
  p.Add('O' , {paths     }k0cokPaths       , 'オブジェクトファイルディレクトリ');
  p.Add('P' , {          }k0cokNone        , '8.3 ファイル名を検索');
  p.Add('Q' , {          }k0cokNone        , 'Quiet モードコンパイル');
  p.Add('R' , {paths     }k0cokPaths       , 'リソースファイルディレクトリ');
  p.Add('TX', {ext       }k0cokExt         , 'ターゲットファイル拡張子');
  p.Add('U' , {paths     }k0cokPaths       , 'ユニットファイルディレクトリ');
  p.Add('V' , {          }k0cokNone        , 'Turbo Debugger デバッグ情報');
  p.Add('VN', {          }k0cokNone        , '名前空間のデバッグ情報を，C++Builder で使われる Giant 形式で生成');
  p.Add('VR', {          }k0cokNone        , 'リモートデバッグ用の rsm ファイルの生成');
  p.Add('W' , {          }k0cokNone        , '警告メッセージの出力');
  p.Add('Z' , {          }k0cokNone        , '暗黙のコンパイルの抑止');

//コンパイラ指令
  p.AddWith('$A', ['+', '-'     ], '+', 'フィールドのアラインメント');
  p.AddWith('$B', ['+', '-'     ], '+', '論理式の評価');
  p.AddWith('$C', ['+', '-'     ], '+', 'アサート');
  p.AddWith('$D', ['+', '-'     ], '+', 'デバッグ情報');
  p.AddWith('$G', ['+', '-'     ], '+', 'インポートデータ');
  p.AddWith('$H', ['+', '-'     ], '+', '長い文字列');
  p.AddWith('$I', ['+', '-'     ], '+', '入出力チェック');
  p.AddWith('$J', ['+', '-'     ], '+', '書き込み可能な型付き定数');
  p.AddWith('$L', ['+', '-'     ], '+', 'ローカルシンボル情報');
  p.AddWith('$M', ['+', '-'     ], '+', '実行時型情報');
  p.AddWith('$O', ['+', '-'     ], '+', '最適化');
  p.AddWith('$P', ['+', '-'     ], '+', 'オープン文字列パラメータ');
  p.AddWith('$Q', ['+', '-'     ], '+', '数値演算オーバーフローチェック');
  p.AddWith('$R', ['+', '-'     ], '+', '範囲チェック');
  p.AddWith('$T', ['+', '-'     ], '+', '型チェックポインタ');
  p.AddWith('$U', ['+', '-'     ], '+', 'Pentiumの安全なFDIV演算');
  p.AddWith('$V', ['+', '-'     ], '+', '変数文字列チェック');
  p.AddWith('$W', ['+', '-'     ], '+', 'Windowsスタックフレーム');
  p.AddWith('$X', ['+', '-'     ], '+', '拡張構文');
  p.AddWith('$Y', ['+', '-', 'D'], 'D', 'シンボル参照情報');
  p.AddWith('$Z', ['1', '2', '4'], '1', '列挙型サイズ');
end;

class function Ts0CLCParamTypeSet.Instance: Ts0CLCParamTypeSet;
begin
  if g9ParamTypeSet = nil then
    g9ParamTypeSet := Ts0CLCParamTypeSet.Create(nil);
  Result := g9ParamTypeSet;  
end;

procedure Ts0CLCParamTypeSet.SetParamTypes(const Value: Ts0CLCParamTypes);
begin
  FParamTypes.Assign(Value);
end;

procedure Ts0CLCParamTypeSet.SetVersion(const Value: K0CLCVersion);
begin
  FVersion := Value;
end;

{ Ts0CLCParam }

constructor Ts0CLCParam.Create(ACollection: TCollection);
begin
  inherited;
  FEnabled := True;
end;

function Ts0CLCParam.GetLineStr: string;
begin
  Result := '-' + FParamName + FParamValue;
end;

function Ts0CLCParam.GetParamType: Ts0CLCParamType;
begin
  Result := Ts0CLCParamTypeSet.Instance.ParamTypes.ItemByName(FParamName);
end;

function Ts0CLCParam.GetParamTypes: Ts0CLCParamTypes;
begin
  Result := Ts0CLCParamTypeSet.Instance.ParamTypes;
end;

procedure Ts0CLCParam.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure Ts0CLCParam.SetLineStr(Value: string);
var
  s: string;
  pt: Ts0CLCParamType;
begin
  FParamName := '';
  FParamValue := '';
  if Value = '' then Exit;
  //
  if Value[1] in ['-', '/'] then
    System.Delete(Value, 1, 1);
  //
  if Value = '' then Exit;
  s := Copy(Value, 1, 1);
  pt := Ts0CLCParamTypeSet.Instance.ParamTypes.ItemByName(s);
  if (s <> '$') and (pt <> nil) then
  begin
    FParamName := s;
    if Length(Value) > 1 then
      FParamValue := Copy(Value, 2,  Length(Value) -1)
    else
      FParamValue := '';
    Exit;
  end;
  //
  if Length(Value) < 2 then Exit;
  s := Copy(Value, 1, 2);
  pt := Ts0CLCParamTypeSet.Instance.ParamTypes.ItemByName(s);
  if pt <> nil then
  begin
    FParamName := s;
    if Length(Value) > 2 then
      FParamValue := Copy(Value, 3, Length(Value) -2)
    else
      FParamValue := '';
  end;
end;

procedure Ts0CLCParam.SetParamName(const Value: string);
begin
  FParamName := Value;
end;

procedure Ts0CLCParam.SetParamValue(const Value: string);
begin
  FParamValue := Value;
end;

{ Ts0CLCParams }

function Ts0CLCParams.Add(AParam: string; AEnabled: Boolean): Ts0CLCParam;
begin
  Result := Ts0CLCParam(inherited Add);
  Result.ParamName := AParam;
  Result.Enabled := AEnabled;
end;

function Ts0CLCParams.AddLine(ALine: string): Ts0CLCParam;
begin
  Result := Ts0CLCParam(inherited Add);
  Result.LineStr := ALine;
end;

function Ts0CLCParams.GetItems(const Index: Integer): Ts0CLCParam;
begin
  Result := Ts0CLCParam(inherited Items[Index]);
end;

procedure Ts0CLCParams.SetItems(const Index: Integer;
  const Value: Ts0CLCParam);
begin
  inherited Items[Index] := Value;
end;

{ Ts0CLCOption }

constructor Ts0CLCOption.Create(AOwner: TPersistent);
begin
  inherited;
  FParams := Ts0CLCParams.Create(Self, Ts0CLCParam);
end;

destructor Ts0CLCOption.Destroy;
begin
  FreeAndNil(FParams);
  inherited;          
end;

procedure Ts0CLCOption.GetParamList(Dest: TStrings);
var
  i: Integer;
begin
  Dest.Clear;
  for i := 0 to Params.Count -1 do
    Dest.Add( Params.Items[i].LineStr );
end;

function Ts0CLCOption.GetParamStr: string;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    GetParamList(sl);
    Result := Ts0StringHelper.ConcatStrings(sl, ' ');
  finally
    FreeAndNil(sl);
  end;
end;

procedure Ts0CLCOption.SetParams(const Value: Ts0CLCParams);
begin
  FParams.Assign(Value);
end;

{ Ts0CommandLineCompiler }

constructor Ts0CommandLineCompiler.Create(AOwner: TComponent);
begin
  inherited;
  FExecResult := TStringList.Create;
end;

destructor Ts0CommandLineCompiler.Destroy;
begin
  FreeAndNil(FExecResult);
  inherited;
end;

procedure Ts0CommandLineCompiler.Execute(ASourceFile: string);
begin
  FExecResult.Clear;
  Ts0ExecFile.ExecuteFile(FExeFileName, CLCConfig.GetParamStr, FExecResult);
end;

procedure Ts0CommandLineCompiler.SetCLCConfig(const Value: Ts0CLCOption);
begin
  FCLCConfig.Assign(Value);
end;

procedure Ts0CommandLineCompiler.SetCLCVersion(const Value: K0CLCVersion);
begin
  FCLCVersion := Value;
end;

initialization

finalization
  Ts0CLCParamTypeSet.ClearInstances;
  
end.
