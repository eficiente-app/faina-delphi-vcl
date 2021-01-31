// Eduardo - 08/01/2021
unit task_type_list;

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
  task_type_controller,
  task_type_view,
  Extend.DBGrids,
  REST.Table;

type
  TTaskTypeList = class(TBaseFormView)
    dbgridTaskType: TDBGrid;
    srcTaskType: TDataSource;
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
    procedure dbgridTaskTypeCellClick(Column: TColumn);
    procedure btnRemoveClick(Sender: TObject);
  private
    TTD: TTaskTypeController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TTaskTypeList.FormCreate(Sender: TObject);
begin
  TTD := TaskTypeController;
  srcTaskType.DataSet := TTD.tblTaskType;
end;

procedure TTaskTypeList.btnRemoveClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) <> mrOk then
    Exit;
  TTD.tblTaskType.Delete;
  TTD.TaskType.Table.Write;
end;

procedure TTaskTypeList.btnIncluirClick(Sender: TObject);
begin
  TTaskTypeView.New(Self, TTD, rtaInsert);
end;

procedure TTaskTypeList.dbgridTaskTypeCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TTaskTypeView.New(Self, TTD, rtaEdit);
end;

procedure TTaskTypeList.btnSearchClick(Sender: TObject);
begin
  TTD.TaskType.Query.Add('id', 1);
  TTD.TaskType.Table.Read;
end;

end.
