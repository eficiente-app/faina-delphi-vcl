// Eduardo - 07/12/2020
unit REST.Manager;

interface

uses
  FireDAC.Comp.Client,
  REST.Connection,
  REST.Table,
  REST.Query;

type
  TRESTManager = class
  private
    FURL: String;
    FConnection: TRESTConnection;
    FTable: TRESTTable;
    FQuery: TRESTQuery;
  public
    constructor Create(URL: String; ATable: TFDMemTable);
    destructor Destroy; override;
    property Connection: TRESTConnection read FConnection;
    property Table: TRESTTable read FTable;
    property Query: TRESTQuery read FQuery;
  end;

implementation

uses
  System.SysUtils,
  System.JSON,
  System.Net.HttpClient;

{ TRESTManager }

constructor TRESTManager.Create(URL: String; ATable: TFDMemTable);
begin
  FURL := URL;
  FConnection := TRESTConnection.Create;
  FTable := TRESTTable.Create(ATable);
  FQuery := TRESTQuery.Create;

  FTable.RESTGet(
    function: TJSONArray
    begin
      Result := FConnection.Execute(sHTTPMethodGet, FURL + FQuery.Text).GetValue<TJSONArray>('sql');
    end
  );

  FTable.RESTPut(
    procedure(Data: TJSONArray)
    begin
      FConnection.Execute(sHTTPMethodPut, FURL, Data);
    end
  );

  FTable.RESTPost(
    procedure(Data: TJSONArray)
    begin
      FConnection.Execute(sHTTPMethodPost, FURL, Data);
    end
  );

  FTable.RESTDelete(
    procedure(Data: TJSONArray)
    begin
      FConnection.Execute(sHTTPMethodDelete, FURL, Data);
    end
  );
end;

destructor TRESTManager.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FTable);
  FreeAndNil(FConnection);
  inherited;
end;

end.
