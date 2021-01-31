// Eduardo - 31/01/2021
unit task_status_list;

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
  task_status_controller,
  task_status_view,
  Extend.DBGrids,
  REST.Table;

type
  TTaskStatusList = class(TBaseFormView)
    dbgridTaskStatus: TDBGrid;
    srcTaskStatus: TDataSource;
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
    procedure dbgridTaskStatusCellClick(Column: TColumn);
    procedure btnRemoveClick(Sender: TObject);
  private
    Controller: TTaskStatusController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TTaskStatusList.FormCreate(Sender: TObject);
begin
  Controller := TaskStatusController;
  srcTaskStatus.DataSet := Controller.tblTaskStatus;
end;

procedure TTaskStatusList.btnRemoveClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) <> mrOk then
    Exit;
  Controller.tblTaskStatus.Delete;
  Controller.TaskStatus.Table.Write;
end;

procedure TTaskStatusList.btnIncluirClick(Sender: TObject);
begin
  TTaskStatusView.New(Self, Controller, rtaInsert);
end;

procedure TTaskStatusList.dbgridTaskStatusCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TTaskStatusView.New(Self, Controller, rtaEdit);
end;

procedure TTaskStatusList.btnSearchClick(Sender: TObject);
begin
  Controller.TaskStatus.Query.Add('id', 1);
  Controller.TaskStatus.Table.Read;
end;

end.
