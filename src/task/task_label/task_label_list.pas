// Eduardo - 31/01/2021
unit task_label_list;

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
  task_label_controller,
  task_label_view,
  Extend.DBGrids,
  REST.Table;

type
  TTaskLabelList = class(TBaseFormView)
    dbgridTaskLabel: TDBGrid;
    srcTaskLabel: TDataSource;
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
    procedure dbgridTaskLabelCellClick(Column: TColumn);
    procedure btnRemoveClick(Sender: TObject);
  private
    TTD: TTaskLabelController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TTaskLabelList.FormCreate(Sender: TObject);
begin
  TTD := TaskLabelController;
  srcTaskLabel.DataSet := TTD.tblTaskLabel;
end;

procedure TTaskLabelList.btnRemoveClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) <> mrOk then
    Exit;
  TTD.tblTaskLabel.Delete;
  TTD.TaskLabel.Table.Write;
end;

procedure TTaskLabelList.btnIncluirClick(Sender: TObject);
begin
  TTaskLabelView.New(Self, TTD, rtaInsert);
end;

procedure TTaskLabelList.dbgridTaskLabelCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TTaskLabelView.New(Self, TTD, rtaEdit);
end;

procedure TTaskLabelList.btnSearchClick(Sender: TObject);
begin
  TTD.TaskLabel.Query.Add('id', 1);
  TTD.TaskLabel.Table.Read;
end;

end.
