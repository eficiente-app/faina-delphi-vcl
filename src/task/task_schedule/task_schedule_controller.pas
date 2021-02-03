// Eduardo - 03/02/2021
unit task_schedule_controller;

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
  TTaskScheduleController = class(TDataModule)
    tblTaskSchedule: TFDMemTable;
    tblTaskScheduleid: TIntegerField;
    tblTaskScheduletask_id: TIntegerField;
    tblTaskScheduleuser_id: TIntegerField;
    tblTaskScheduletype_id: TIntegerField;
    tblTaskSchedulestart: TDateTimeField;
    tblTaskScheduleend: TDateTimeField;
    tblTaskScheduleprior_id: TIntegerField;
    tblTaskSchedulenext_id: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    TaskSchedule: TRESTManager;
  end;

var
  TaskScheduleController: TTaskScheduleController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTaskScheduleController.DataModuleCreate(Sender: TObject);
begin
  TaskSchedule := TRESTManager.Create('api/task/schedule', tblTaskSchedule);
  TaskSchedule.Table.Read;
end;

procedure TTaskScheduleController.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(TaskSchedule);
end;

end.
