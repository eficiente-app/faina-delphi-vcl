// Eduardo - 03/02/2021
unit project_type_controller;

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
  TProjectTypeController = class(TDataModule)
    tblProjectType: TFDMemTable;
    tblProjectTypeid: TIntegerField;
    tblProjectTypedescription: TStringField;
    tblProjectTypename: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    ProjectType: TRESTManager;
  end;

var
  ProjectTypeController: TProjectTypeController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TProjectTypeController.DataModuleCreate(Sender: TObject);
begin
  ProjectType := TRESTManager.Create('api/project/type', tblProjectType);
  ProjectType.Table.Read;
end;

procedure TProjectTypeController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(ProjectType);
end;

end.
