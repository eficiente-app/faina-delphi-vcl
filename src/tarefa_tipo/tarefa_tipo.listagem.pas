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
    btnAlterar: TButton;
    btnVisualizar: TButton;
    pnlPesquisa: TPanel;
    pnlPesquisar: TPanel;
    btnPesquisar: TButton;
    btnLimpar: TButton;
    gbxPesquisa: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure srcTarefaTipoDataChange(Sender: TObject; Field: TField);
  private
    TTD: TTarefaTipoDados;
  public
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TTarefaTipoListagem.FormCreate(Sender: TObject);
begin
  TTD := TTarefaTipoDados.Create(Self);
  srcTarefaTipo.DataSet := TTD.tblTarefaTipo;
end;

procedure TTarefaTipoListagem.srcTarefaTipoDataChange(Sender: TObject; Field: TField);
begin
  btnAlterar.Enabled := not TDataSource(Sender).DataSet.IsEmpty;
  btnVisualizar.Enabled := btnAlterar.Enabled;
end;

procedure TTarefaTipoListagem.btnAlterarClick(Sender: TObject);
begin
  TTarefaTipoManutencao.New(Self, TTD, Alterar);
end;

procedure TTarefaTipoListagem.btnIncluirClick(Sender: TObject);
begin
  TTarefaTipoManutencao.New(Self, TTD, Incluir);
end;

procedure TTarefaTipoListagem.btnVisualizarClick(Sender: TObject);
begin
  TTarefaTipoManutencao.New(Self, TTD, Visualizar);
end;

procedure TTarefaTipoListagem.btnPesquisarClick(Sender: TObject);
begin
  TTD.TarefaTipo.Query.Add('id', 1);
  TTD.TarefaTipo.Table.Read;
end;

end.
