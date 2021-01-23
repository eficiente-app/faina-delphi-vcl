// Eduardo - 06/12/2020
unit folder_controller;

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
  TFolderController = class(TDataModule)
    tblPasta: TFDMemTable;
    tblPastaid: TIntegerField;
    tblPastatipo_id: TIntegerField;
    tblPastaprojeto_id: TIntegerField;
    tblPastanome: TStringField;
    tblPastadescricao: TStringField;
    tblPastaincluido_id: TIntegerField;
    tblPastaincluido_em: TDateTimeField;
    tblPastaalterado_id: TIntegerField;
    tblPastaalterado_em: TDateTimeField;
    tblPastaexcluido_id: TIntegerField;
    tblPastaexcluido_em: TDateTimeField;
    tblPastatipo_nome: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    Pasta: TRESTManager;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  folder_type_controller;

procedure TFolderController.DataModuleCreate(Sender: TObject);
begin
  Pasta := TRESTManager.Create('api/pasta', tblPasta);
end;

procedure TFolderController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(Pasta);
end;

end.
