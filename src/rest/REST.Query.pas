// Eduardo - 07/12/2020
unit REST.Query;

interface

uses
  System.Generics.Collections;

type
  TRESTQuery = class
  private
    FNotAdd: Integer;
    FParams: TArray<TPair<String, String>>;
  public
    function AddIf(bCondicao: Boolean; iLenAdd: Integer = 1): TRESTQuery;
    function Add(sParam, sValor: String): TRESTQuery; overload;
    function Add(sParam: String;  bValor: Boolean): TRESTQuery; overload;
    function Add(sParam: String; dValor: Extended): TRESTQuery; overload;
    function Clear: TRESTQuery;
    function Text: String;
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  IdURI;

{ TRESTQuery }

function TRESTQuery.AddIf(bCondicao: Boolean; iLenAdd: Integer): TRESTQuery;
begin
  Result := Self;
end;

function TRESTQuery.Clear: TRESTQuery;
begin
  Finalize(FParams);
  Result := Self;
end;

function TRESTQuery.Add(sParam, sValor: String): TRESTQuery;
var
  I: Integer;
begin
  Result := Self;

  if FNotAdd > 0 then
  begin
    Dec(FNotAdd);
    Exit;
  end;

  // Não adiciona parâmetro nem valor vazio
  if sParam.Trim.IsEmpty or sValor.Trim.IsEmpty then
    Exit;

  for I := 0 to Pred(Length(FParams)) do
  begin
    if FParams[I].Key = sParam then
    begin
      FParams[I].Value := sValor;
      Exit;
    end;
  end;

  // Adiciona parâmetros a lista
  SetLength(FParams, Succ(Length(FParams)));
  FParams[Pred(Length(FParams))] := TPair<String, String>.Create(sParam, sValor);
end;

function TRESTQuery.Add(sParam: String; bValor: Boolean): TRESTQuery;
begin
  if FNotAdd > 0 then
  begin
    Dec(FNotAdd);
    Exit(Self);
  end;

  Result := Add(sParam, BoolToStr(bValor));
end;

function TRESTQuery.Add(sParam: String; dValor: Extended): TRESTQuery;
begin
  if FNotAdd > 0 then
  begin
    Dec(FNotAdd);
    Exit(Self);
  end;

  Result := Add(sParam, FloatToStr(dValor));
end;

function TRESTQuery.Text: String;
var
  sPar: TPair<String, String>;
  sKey: String;
  sValue: String;
begin
  for sPar in FParams do
  begin
    sKey   := TIdURI.ParamsEncode(sPar.Key);
    sValue := TIdURI.ParamsEncode(sPar.Value);
    
    if Result.Trim.IsEmpty then
      Result := '?'+ sKey +'='+ sValue
    else
      Result := Result +'&'+ sKey +'='+ sValue;
  end;
end;

end.
