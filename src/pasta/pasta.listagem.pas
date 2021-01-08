// Eduardo - 05/12/2020
unit pasta.listagem;

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
  pasta.dados,
  pasta.manutencao;

type
  TPastaListagem = class(TForm)
    dbgridPasta: TDBGrid;
    srcPasta: TDataSource;
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
    PD: TPastaDados;
  public
    class procedure New;
  end;

implementation

{$R *.dfm}

{ TPasta }

class procedure TPastaListagem.New;
begin
  with TPastaListagem.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TPastaListagem.FormCreate(Sender: TObject);
begin
  PD := TPastaDados.Create(Self);
  srcPasta.DataSet := PD.tblPasta;
end;

procedure TPastaListagem.btnAlterarClick(Sender: TObject);
begin
  TPastaManutencao.New(Self, PD, Alterar);
end;

procedure TPastaListagem.btnIncluirClick(Sender: TObject);
begin
  TPastaManutencao.New(Self, PD, Incluir);
end;

procedure TPastaListagem.btnVisualizarClick(Sender: TObject);
begin
  TPastaManutencao.New(Self, PD, Visualizar);
end;

procedure TPastaListagem.btnPesquisarClick(Sender: TObject);
begin
  PD.Pasta.Query.Add('id', 1);
  PD.Pasta.Table.Read;
end;

end.
