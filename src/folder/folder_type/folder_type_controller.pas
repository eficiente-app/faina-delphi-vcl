// Eduardo - 07/01/2021
unit folder_type_controller;

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
  TFolderTypeController = class(TDataModule)
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
    FolderType: TRESTManager;
  end;

var
  FolderTypeController: TFolderTypeController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TFolderTypeController.DataModuleCreate(Sender: TObject);
begin
  FolderType := TRESTManager.Create('api/pasta/tipo', tblPastaTipo);
  FolderType.Table.Read;
end;

procedure TFolderTypeController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FolderType);
end;

end.
