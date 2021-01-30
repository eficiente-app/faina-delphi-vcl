// Eduardo - 08/11/2020
unit Faina.Configuration;

interface

uses
  System.JSON,
  System.SysUtils,
  System.Classes,
  System.TypInfo,
  System.RTTI;

type
  TConfiguration = class
  protected
    class var Instance: TConfiguration;
  private
    JSON: TJSONObject;
    procedure Open;
    procedure Close;
  public
    class function Exists(ID: String): Boolean;
    class function Read<T>(ID: String): T;
    class procedure Write<T>(ID: String; Valor: T);
    destructor Destroy; override;
  end;

implementation

{ TConfiguracoes }

procedure TConfiguration.Open;
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

procedure TConfiguration.Close;
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

class function TConfiguration.Exists(ID: String): Boolean;
begin
  if not Assigned(TConfiguration.Instance) then
  begin
    TConfiguration.Instance := TConfiguration.Create;
    TConfiguration.Instance.Open;
  end;

  Result := Assigned(TConfiguration.Instance.JSON.FindValue(ID));
end;

class function TConfiguration.Read<T>(ID: String): T;
var
  jv: TJSONValue;
begin
  if not Assigned(TConfiguration.Instance) then
  begin
    TConfiguration.Instance := TConfiguration.Create;
    TConfiguration.Instance.Open;
  end;

  jv := TConfiguration.Instance.JSON.FindValue(ID);

  if not Assigned(jv) then
    raise Exception.Create('Parâmetro: "'+ ID +'" não configurado!');

  Result := jv.AsType<T>;
end;

class procedure TConfiguration.Write<T>(ID: String; Valor: T);
var
  jv: TJSONPair;
  LTypeInfo: PTypeInfo;
  LValue: TValue;
begin
  if not Assigned(TConfiguration.Instance) then
  begin
    TConfiguration.Instance := TConfiguration.Create;
    TConfiguration.Instance.Open;
  end;

  jv := TConfiguration.Instance.JSON.RemovePair(ID);
  if Assigned(jv) then
    jv.Free;

  LTypeInfo := System.TypeInfo(T);

  TValue.Make(@Valor, LTypeInfo, LValue);

  case LTypeInfo.Kind of
    tkEnumeration:
    begin
      TConfiguration.Instance.JSON.AddPair(ID, TJSONBool.Create(LValue.AsBoolean));
    end;

    tkInteger,
    tkInt64,
    tkFloat:
    begin
      TConfiguration.Instance.JSON.AddPair(ID, TJSONNumber.Create(LValue.AsExtended));
    end;

    tkChar,
    tkString,
    tkWChar,
    tkLString,
    tkWString,
    tkUString:
    begin
      TConfiguration.Instance.JSON.AddPair(ID, TJSONString.Create(LValue.AsString));
    end;
  end;

  TConfiguration.Instance.Close;
end;

destructor TConfiguration.Destroy;
begin
  FreeAndNil(JSON);
  inherited;
end;

initialization

finalization
  if Assigned(TConfiguration.Instance) then
    FreeAndNil(TConfiguration.Instance);

end.
