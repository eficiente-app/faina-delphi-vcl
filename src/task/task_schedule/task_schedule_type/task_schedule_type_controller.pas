// Eduardo - 03/02/2021
unit task_schedule_type_controller;

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
  TTaskScheduleTypeController = class(TDataModule)
    tblTaskScheduleType: TFDMemTable;
    tblTaskScheduleTypeid: TIntegerField;
    tblTaskScheduleTypedescription: TStringField;
    tblTaskScheduleTypename: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    TaskScheduleType: TRESTManager;
  end;

var
  TaskScheduleTypeController: TTaskScheduleTypeController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTaskScheduleTypeController.DataModuleCreate(Sender: TObject);
begin
  TaskScheduleType := TRESTManager.Create('api/task/schedule/type', tblTaskScheduleType);
  TaskScheduleType.Table.Read;
end;

procedure TTaskScheduleTypeController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(TaskScheduleType);
end;

end.
