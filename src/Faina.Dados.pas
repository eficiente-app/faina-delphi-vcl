// Eduardo - 08/11/2020
unit Faina.Dados;

interface

uses
  System.SysUtils,
  System.Classes,
  Faina.Configuracoes;

type
  TDados = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Conf: TConfiguracoes;
  public
    { Public declarations }
  end;

var
  Dados: TDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDados.DataModuleCreate(Sender: TObject);
begin
  Conf := TConfiguracoes.Create;
end;

procedure TDados.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(Conf);
end;

end.
