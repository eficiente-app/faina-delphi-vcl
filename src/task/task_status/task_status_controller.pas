// Eduardo - 31/01/2021
unit task_status_controller;

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
  TTaskStatusController = class(TDataModule)
    tblTaskStatus: TFDMemTable;
    tblTaskStatusid: TIntegerField;
    tblTaskStatusdescription: TStringField;
    tblTaskStatusname: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    TaskStatus: TRESTManager;
  end;

var
  TaskStatusController: TTaskStatusController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTaskStatusController.DataModuleCreate(Sender: TObject);
begin
  TaskStatus := TRESTManager.Create('api/task/status', tblTaskStatus);
  TaskStatus.Table.Read;
end;

procedure TTaskStatusController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(TaskStatus);
end;

end.
