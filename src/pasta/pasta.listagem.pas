// Eduardo - 05/12/2020
unit pasta.listagem;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Data.DB,
  Vcl.Controls,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.StdCtrls,
  Formulario.Base.Visual,
  pasta.dados,
  pasta.manutencao,
  Extend.DBGrids;

type
  TPastaListagem = class(TFormularioBaseVisual)
    dbgridPasta: TDBGrid;
    pnlPesquisa: TPanel;
    pnlPesquisar: TPanel;
    btnPesquisar: TButton;
    btnLimpar: TButton;
    gbxPesquisa: TGroupBox;
    pnlTopo: TPanel;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnVisualizar: TButton;
    srcPasta: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure srcPastaDataChange(Sender: TObject; Field: TField);
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

procedure TPastaListagem.srcPastaDataChange(Sender: TObject; Field: TField);
begin
  btnAlterar.Enabled := not TDataSource(Sender).DataSet.IsEmpty;
  btnVisualizar.Enabled := btnAlterar.Enabled;
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
