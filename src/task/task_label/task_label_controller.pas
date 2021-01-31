// Eduardo - 31/01/2021
unit task_label_controller;

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
  REST.Manager,
  task_type_controller;

type
  TTaskLabelController = class(TDataModule)
    tblTaskLabel: TFDMemTable;
    tblTaskLabelid: TIntegerField;
    tblTaskLabeldescription: TStringField;
    tblTaskLabelname: TStringField;
    tblTaskLabeltype_task_id: TIntegerField;
    tblTaskLabeltask_type_name: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    TaskLabel: TRESTManager;
  end;

var
  TaskLabelController: TTaskLabelController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTaskLabelController.DataModuleCreate(Sender: TObject);
begin
  TaskLabel := TRESTManager.Create('api/task/label', tblTaskLabel);
  TaskLabel.Table.Read;
end;

procedure TTaskLabelController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(TaskLabel);
end;

end.
