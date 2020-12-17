// Eduardo - 07/12/2020
unit REST.Connection;

interface

uses
  System.JSON,
  System.Net.HttpClientComponent;

type
  TRESTConnection = class
  private
    NetHTTPClient: TNetHTTPClient;
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(sMetodo, sURL: String; jvParams: TJSONValue = nil): TJSONValue;
  end;

implementation

uses
  System.Classes,
  System.SysUtils,
  System.Net.URLClient;

{ TRESTConnection }

constructor TRESTConnection.Create;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
end;

destructor TRESTConnection.Destroy;
begin
  FreeAndNil(NetHTTPClient);
end;

function TRESTConnection.Execute(sMetodo, sURL: String; jvParams: TJSONValue = nil): TJSONValue;
var
  ssIn: TStringStream;
  ssOut: TStringStream;
begin
  if Assigned(jvParams) then
    ssIn := TStringStream.Create(jvParams.ToJSON);
  ssOut := TStringStream.Create;
  try
    NetHTTPClient.Execute(sMetodo, TURI.Create(sURL), ssIn, ssOut, [TNameValuePair.Create('Content-Type', 'application/json')]);
    Result := TJSONObject.ParseJSONValue(ssOut.DataString);
  finally
    FreeAndNil(ssIn);
    FreeAndNil(ssOut);
  end;
end;

end.
