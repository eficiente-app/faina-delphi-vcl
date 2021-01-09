// Eduardo - 07/01/2021
unit pasta_tipo.dados;

interface

uses
  System.SysUtils,
  System.Classes,
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

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TPastaTipoDados.DataModuleCreate(Sender: TObject);
begin
  PastaTipo := TRESTManager.Create('http://18.230.153.64:3000/api/pasta/tipo', tblPastaTipo);
end;

procedure TPastaTipoDados.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(PastaTipo);
end;

end.
