// Eduardo - 05/12/2020
unit pasta_tipo.listagem;

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
  pasta_tipo.dados,
  pasta_tipo.manutencao;

type
  TPastaTipoListagem = class(TForm)
    dbgridPasta: TDBGrid;
    srcPastaTipo: TDataSource;
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
  private
    PTD: TPastaTipoDados;
  public
    class procedure New;
  end;

implementation

{$R *.dfm}

{ TPasta }

class procedure TPastaTipoListagem.New;
begin
  with TPastaTipoListagem.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TPastaTipoListagem.FormCreate(Sender: TObject);
begin
  PTD := TPastaTipoDados.Create(Self);
  srcPastaTipo.DataSet := PTD.tblPastaTipo;
end;

procedure TPastaTipoListagem.btnAlterarClick(Sender: TObject);
begin
  TPastaTipoManutencao.New(Self, PTD, Alterar);
end;

procedure TPastaTipoListagem.btnIncluirClick(Sender: TObject);
begin
  TPastaTipoManutencao.New(Self, PTD, Incluir);
end;

procedure TPastaTipoListagem.btnVisualizarClick(Sender: TObject);
begin
  TPastaTipoManutencao.New(Self, PTD, Visualizar);
end;

procedure TPastaTipoListagem.btnPesquisarClick(Sender: TObject);
begin
  PTD.PastaTipo.Query.Add('id', 1);
  PTD.PastaTipo.Table.Read;
end;

end.
