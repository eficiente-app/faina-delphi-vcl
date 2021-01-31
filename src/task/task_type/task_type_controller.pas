// Eduardo - 08/01/2021
unit task_type_controller;

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
  TTaskTypeController = class(TDataModule)
    tblTaskType: TFDMemTable;
    tblTaskTypeid: TIntegerField;
    tblTaskTypedescription: TStringField;
    tblTaskTypename: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    TaskType: TRESTManager;
  end;

var
  TaskTypeController: TTaskTypeController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTaskTypeController.DataModuleCreate(Sender: TObject);
begin
  TaskType := TRESTManager.Create('api/task/type', tblTaskType);
  TaskType.Table.Read;
end;

procedure TTaskTypeController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(TaskType);
end;

end.
