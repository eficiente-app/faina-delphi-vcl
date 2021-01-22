// Eduardo - 08/01/2021
unit tarefa_tipo.listagem;

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
  tarefa_tipo.dados,
  tarefa_tipo.manutencao,
  Extend.DBGrids;

type
  TTarefaTipoListagem = class(TFormularioBaseVisual)
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
    TTD: TTarefaTipoDados;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TTarefaTipoListagem.FormCreate(Sender: TObject);
begin
  TTD := tarefa_tipo_dados;
  srcTarefaTipo.DataSet := TTD.tblTarefaTipo;
end;

procedure TTarefaTipoListagem.btnRemoverClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  TTD.tblTarefaTipo.Delete;
  TTD.TarefaTipo.Table.Write;
end;

procedure TTarefaTipoListagem.btnIncluirClick(Sender: TObject);
begin
  TTarefaTipoManutencao.New(Self, TTD, Incluir);
end;

procedure TTarefaTipoListagem.dbgridPastaCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TTarefaTipoManutencao.New(Self, TTD, Alterar);
end;

procedure TTarefaTipoListagem.btnPesquisarClick(Sender: TObject);
begin
  TTD.TarefaTipo.Query.Add('id', 1);
  TTD.TarefaTipo.Table.Read;
end;

end.
