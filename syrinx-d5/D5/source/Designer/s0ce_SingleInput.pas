unit s0ce_SingleInput;

interface

procedure Register;

implementation

uses
  s0SingleInput,
{$IFDEF VER130}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, RTLConsts,
{$ENDIF}
  s0pe_EscapeSequenceString;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(String), Ts0SingleInput, 'Terminators', Ts0pe_EscapeSequenceString);
end;

end.
