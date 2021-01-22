// Eduardo - 07/01/2021
unit pasta_tipo.dados;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Manager;

type
  TPastaTipoDados = class(TDataModule)
    tblPastaTipo: TFDMemTable;
    tblPastaTipoid: TIntegerField;
    tblPastaTipodescricao: TStringField;
    tblPastaTiponome: TStringField;
    tblPastaTipoincluido_id: TIntegerField;
    tblPastaTipoincluido_em: TDateTimeField;
    tblPastaTipoalterado_id: TIntegerField;
    tblPastaTipoalterado_em: TDateTimeField;
    tblPastaTipoexcluido_id: TIntegerField;
    tblPastaTipoexcluido_em: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    PastaTipo: TRESTManager;
  end;

var
  pasta_tipo_dados: TPastaTipoDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TPastaTipoDados.DataModuleCreate(Sender: TObject);
begin
  PastaTipo := TRESTManager.Create('api/pasta/tipo', tblPastaTipo);
  PastaTipo.Table.Read;
end;

procedure TPastaTipoDados.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(PastaTipo);
end;

end.
