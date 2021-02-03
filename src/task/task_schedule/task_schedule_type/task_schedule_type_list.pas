// Eduardo - 03/02/2021
unit task_schedule_type_list;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Menus,
  base_form_view,
  task_schedule_type_controller,
  task_schedule_type_view,
  Extend.DBGrids,
  REST.Table;

type
  TTaskScheduleTypeList = class(TBaseFormView)
    dbgridTaskScheduleType: TDBGrid;
    srcTaskScheduleType: TDataSource;
    pnlTop: TPanel;
    btnIncluir: TButton;
    pnlSearch: TPanel;
    pnlGrupSearch: TPanel;
    btnSearch: TButton;
    btnClear: TButton;
    gbxSearch: TGroupBox;
    popAction: TPopupMenu;
    btnRemove: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure dbgridTaskScheduleTypeCellClick(Column: TColumn);
    procedure btnRemoveClick(Sender: TObject);
  private
    Controller: TTaskScheduleTypeController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TTaskScheduleTypeList.FormCreate(Sender: TObject);
begin
  Controller := TaskScheduleTypeController;
  srcTaskScheduleType.DataSet := Controller.tblTaskScheduleType;
end;

procedure TTaskScheduleTypeList.btnRemoveClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) <> mrOk then
    Exit;
  Controller.tblTaskScheduleType.Delete;
  Controller.TaskScheduleType.Table.Write;
end;

procedure TTaskScheduleTypeList.btnIncluirClick(Sender: TObject);
begin
  TTaskScheduleTypeView.New(Self, Controller, rtaInsert);
end;

procedure TTaskScheduleTypeList.dbgridTaskScheduleTypeCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TTaskScheduleTypeView.New(Self, Controller, rtaEdit);
end;

procedure TTaskScheduleTypeList.btnSearchClick(Sender: TObject);
begin
  Controller.TaskScheduleType.Query.Add('id', 1);
  Controller.TaskScheduleType.Table.Read;
end;

end.
