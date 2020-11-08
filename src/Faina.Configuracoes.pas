// Eduardo - 08/11/2020
unit Faina.Configuracoes;

interface

uses
  System.JSON,
  System.SysUtils,
  System.Classes;

type
  TConfiguracoes = class
  private
    FJSON: TJSONObject;
  public
    property JSON: TJSONObject read FJSON;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TConfiguracoes }

constructor TConfiguracoes.Create;
var
  ss: TStringStream;
begin
  if not FileExists(ChangeFileExt(ParamStr(0), '.json')) then
  begin
    FJSON := TJSONObject.Create;
    Exit;
  end;
  ss := TStringStream.Create;
  try
    ss.LoadFromFile(ChangeFileExt(ParamStr(0), '.json'));
    FJSON := TJSONObject(TJSONObject.ParseJSONValue(ss.DataString));
    if not Assigned(FJSON) then
      FJSON := TJSONObject.Create;
  finally
    FreeAndNil(ss);
  end;
end;

destructor TConfiguracoes.Destroy;
var
  ss: TStringStream;
begin
  ss := TStringStream.Create(FJSON.ToJSON);
  try
    ss.SaveToFile(ChangeFileExt(ParamStr(0), '.json'));
  finally
    FreeAndNil(ss);
  end;
  FreeAndNil(FJSON);
end;

end.
