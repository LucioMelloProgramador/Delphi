unit Routex.ValidarObjeto;

interface

type
  TValidarObjeto = class
    public
      function Validar(AObjeto: TObject; out AMensagem: string): Boolean;
  end;

implementation

uses
  System.Rtti,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections,
  System.Variants;

function TValidarObjeto.Validar(AObjeto: TObject; out AMensagem: string): Boolean;
var
  Contexto: TRttiContext;
  TipoObj: TRttiType;
  Propriedade: TRttiProperty;
  Valor: TValue;
  CamposInvalidos: TList<string>;
  EstaVazio: Boolean;
begin
  CamposInvalidos := TList<string>.Create;
  try
    Contexto := TRttiContext.Create;
    TipoObj := Contexto.GetType(AObjeto.ClassType);

    for Propriedade in TipoObj.GetProperties do
    begin

      if not Propriedade.IsReadable then
        Continue;

      if Propriedade.name = 'Token' then
        Continue;

      Valor := Propriedade.GetValue(AObjeto);
      EstaVazio := False;

      case Valor.Kind of
        tkString, tkLString, tkWString, tkUString:
          EstaVazio := Trim(Valor.AsString) = '';

        tkInteger, tkInt64:
          EstaVazio := Valor.AsInt64 = 0;

        tkFloat:
          EstaVazio := Valor.AsExtended = 0;

        tkVariant:
          EstaVazio := VarIsNull(Valor.AsVariant) or VarIsEmpty(Valor.AsVariant);
      end;

      if EstaVazio then
        CamposInvalidos.Add(Propriedade.Name);
    end;

    Result := CamposInvalidos.Count = 0;

    if not Result then
      AMensagem := 'Required fields not filled in: ' +
        string.Join(', ', CamposInvalidos.ToArray)
    else
      AMensagem := 'All fields are filled in.';

  finally
    CamposInvalidos.Free;
  end;
end;
end.
