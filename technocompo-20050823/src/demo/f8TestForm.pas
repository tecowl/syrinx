unit f8TestForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  s0CustomComplexCtrl, s0DateEdit, tec1DateEdit, tec1xDate, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, tec1DBGrid, Db, DBTables, StdCtrls;

type
  TForm2 = class(TForm)
    tec1xDate1: Ttec1xDate;
    tec1DBGrid1: Ttec1DBGrid;
    Table1: TTable;
    DataSource1: TDataSource;
    Table2: TTable;
    Table1OrderNo: TFloatField;
    Table1CustNo: TFloatField;
    Table1SaleDate: TDateTimeField;
    Table1ShipDate: TDateTimeField;
    Table1EmpNo: TIntegerField;
    Table1ShipToContact: TStringField;
    Table1ShipToAddr1: TStringField;
    Table1ShipToAddr2: TStringField;
    Table1ShipToCity: TStringField;
    Table1ShipToState: TStringField;
    Table1ShipToZip: TStringField;
    Table1ShipToCountry: TStringField;
    Table1ShipToPhone: TStringField;
    Table1ShipVIA: TStringField;
    Table1PO: TStringField;
    Table1Terms: TStringField;
    Table1PaymentMethod: TStringField;
    Table1ItemsTotal: TCurrencyField;
    Table1TaxRate: TFloatField;
    Table1Freight: TCurrencyField;
    Table1AmountPaid: TCurrencyField;
    Table1CustCompany: TStringField;
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

end.
