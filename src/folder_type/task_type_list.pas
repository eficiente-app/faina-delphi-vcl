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
  Formulario.Base.Visual,
  task_type_controller,
  task_type_view,
  Extend.DBGrids;

type
  TTaskTypeList = class(TFormularioBaseVisual)
    dbgridPasta: TDBGrid;
    srcTarefaTipo: TDataSource;
    pnlTopo: TPanel;
    btnIncluir: TButton;
    pnlPesquisa: TPanel;
    pnlPesquisar: TPanel;
    btnPesquisar: TButton;
    btnLimpar: TButton;
    gbxPesquisa: TGroupBox;
    popAcoes: TPopupMenu;
    btnRemover: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgridPastaCellClick(Column: TColumn);
    procedure btnRemoverClick(Sender: TObject);
  private
    TTD: TTaskTypeController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TTaskTypeList.FormCreate(Sender: TObject);
begin
  TTD := tarefa_tipo_dados;
  srcTarefaTipo.DataSet := TTD.tblTarefaTipo;
end;

procedure TTaskTypeList.btnRemoverClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  TTD.tblTarefaTipo.Delete;
  TTD.TarefaTipo.Table.Write;
end;

procedure TTaskTypeList.btnIncluirClick(Sender: TObject);
begin
  TTaskTypeView.New(Self, TTD, Incluir);
end;

procedure TTaskTypeList.dbgridPastaCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TTaskTypeView.New(Self, TTD, Alterar);
end;

procedure TTaskTypeList.btnPesquisarClick(Sender: TObject);
begin
  TTD.TarefaTipo.Query.Add('id', 1);
  TTD.TarefaTipo.Table.Read;
end;

end.
