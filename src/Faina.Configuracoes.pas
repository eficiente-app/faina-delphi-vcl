// Eduardo - 08/11/2020
unit Faina.Configuracoes;

interface

uses
  System.JSON,
  System.SysUtils,
  System.Classes,
  System.TypInfo,
  System.RTTI;

type
  TConfiguracoes = class
  protected
    class var Instancia: TConfiguracoes;
  private
    JSON: TJSONObject;
    procedure Abrir;
    procedure Salvar;
  public
    class function Existe(ID: String): Boolean;
    class function Ler<T>(ID: String): T;
    class procedure Escrever<T>(ID: String; Valor: T);
    destructor Destroy; override;
  end;

implementation

{ TConfiguracoes }

procedure TConfiguracoes.Abrir;
var
  ss: TStringStream;
begin
  if not FileExists(ChangeFileExt(ParamStr(0), '.json')) then
  begin
    JSON := TJSONObject.Create;
    Exit;
  end;
  ss := TStringStream.Create;
  try
    ss.LoadFromFile(ChangeFileExt(ParamStr(0), '.json'));
    JSON := TJSONObject(TJSONObject.ParseJSONValue(ss.DataString));
    if not Assigned(JSON) then
      JSON := TJSONObject.Create;
  finally
    FreeAndNil(ss);
  end;
end;

procedure TConfiguracoes.Salvar;
var
  ss: TStringStream;
begin
  ss := TStringStream.Create(JSON.Format);
  try
    ss.SaveToFile(ChangeFileExt(ParamStr(0), '.json'));
  finally
    FreeAndNil(ss);
  end;
end;

class function TConfiguracoes.Existe(ID: String): Boolean;
begin
  if not Assigned(TConfiguracoes.Instancia) then
  begin
    TConfiguracoes.Instancia := TConfiguracoes.Create;
    TConfiguracoes.Instancia.Abrir;
  end;

  Result := Assigned(TConfiguracoes.Instancia.JSON.FindValue(ID));
end;

class function TConfiguracoes.Ler<T>(ID: String): T;
var
  jv: TJSONValue;
begin
  if not Assigned(TConfiguracoes.Instancia) then
  begin
    TConfiguracoes.Instancia := TConfiguracoes.Create;
    TConfiguracoes.Instancia.Abrir;
  end;

  jv := TConfiguracoes.Instancia.JSON.FindValue(ID);

  if not Assigned(jv) then
    raise Exception.Create('Parâmetro: "'+ ID +'" não configurado!');

  Result := jv.AsType<T>;
end;

class procedure TConfiguracoes.Escrever<T>(ID: String; Valor: T);
var
  jv: TJSONPair;
  LTypeInfo: PTypeInfo;
  LValue: TValue;
begin
  if not Assigned(TConfiguracoes.Instancia) then
  begin
    TConfiguracoes.Instancia := TConfiguracoes.Create;
    TConfiguracoes.Instancia.Abrir;
  end;

  jv := TConfiguracoes.Instancia.JSON.RemovePair(ID);
  if Assigned(jv) then
    jv.Free;

  LTypeInfo := System.TypeInfo(T);

  TValue.Make(@Valor, LTypeInfo, LValue);

  case LTypeInfo.Kind of
    tkEnumeration:
    begin
      TConfiguracoes.Instancia.JSON.AddPair(ID, TJSONBool.Create(LValue.AsBoolean));
    end;

    tkInteger,
    tkInt64,
    tkFloat:
    begin
      TConfiguracoes.Instancia.JSON.AddPair(ID, TJSONNumber.Create(LValue.AsExtended));
    end;

    tkChar,
    tkString,
    tkWChar,
    tkLString,
    tkWString,
    tkUString:
    begin
      TConfiguracoes.Instancia.JSON.AddPair(ID, TJSONString.Create(LValue.AsString));
    end;
  end;

  TConfiguracoes.Instancia.Salvar;
end;

destructor TConfiguracoes.Destroy;
begin
  FreeAndNil(JSON);
  inherited;
end;

initialization

finalization
  if Assigned(TConfiguracoes.Instancia) then
    FreeAndNil(TConfiguracoes.Instancia);

end.
