// Eduardo - 08/01/2021
unit tarefa_tipo.dados;

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
  TTarefaTipoDados = class(TDataModule)
    tblTarefaTipo: TFDMemTable;
    tblTarefaTipoid: TIntegerField;
    tblTarefaTipodescricao: TStringField;
    tblTarefaTiponome: TStringField;
    tblTarefaTipoincluido_id: TIntegerField;
    tblTarefaTipoincluido_em: TDateTimeField;
    tblTarefaTipoalterado_id: TIntegerField;
    tblTarefaTipoalterado_em: TDateTimeField;
    tblTarefaTipoexcluido_id: TIntegerField;
    tblTarefaTipoexcluido_em: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    TarefaTipo: TRESTManager;
  end;

var
  tarefa_tipo_dados: TTarefaTipoDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTarefaTipoDados.DataModuleCreate(Sender: TObject);
begin
  TarefaTipo := TRESTManager.Create('api/tarefa/tipo', tblTarefaTipo);
  TarefaTipo.Table.Read;
end;

procedure TTarefaTipoDados.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(TarefaTipo);
end;

end.
