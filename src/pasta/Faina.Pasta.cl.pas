// Eduardo - 06/12/2020
unit Faina.Pasta.cl;

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
  TPastaController = class(TDataModule)
    tblPasta: TFDMemTable;
    tblPastaid: TIntegerField;
    tblPastatipo: TIntegerField;
    tblPastaprojeto_id: TIntegerField;
    tblPastanome: TStringField;
    tblPastadescricao: TStringField;
    tblPastaincluido_id: TIntegerField;
    tblPastaincluido_em: TDateTimeField;
    tblPastaalterado_id: TIntegerField;
    tblPastaalterado_em: TDateTimeField;
    tblPastaexcluido_id: TIntegerField;
    tblPastaexcluido_em: TDateTimeField;
    tblTipo: TFDMemTable;
    tblPastatipo_descricao: TStringField;
    tblPastaprojeto_descricao: TStringField;
    tblTipoid: TIntegerField;
    tblTipodescricao: TStringField;
    tblTipoincluido_id: TIntegerField;
    tblTipoincluido_em: TDateTimeField;
    tblTipoalterado_id: TIntegerField;
    tblTipoalterado_em: TDateTimeField;
    tblTipoexcluido_id: TIntegerField;
    tblTipoexcluido_em: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    Pasta: TRESTManager;
    Tipo: TRESTManager;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TPastaController.DataModuleCreate(Sender: TObject);
begin
  Pasta := TRESTManager.Create('http://18.230.153.64:3000/api/pasta', tblPasta);
  Tipo  := TRESTManager.Create('http://18.230.153.64:3000/api/pasta/tipo', tblTipo);
end;

procedure TPastaController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(Pasta);
  FreeAndNil(Tipo);
end;

end.
