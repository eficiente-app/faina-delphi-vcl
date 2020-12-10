// Eduardo - 05/12/2020
unit Faina.Pasta.lst.vw;

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
  Faina.Pasta.cl,
  Faina.Pasta.man.vw;

type
  TPastaListagem = class(TForm)
    dbgridPasta: TDBGrid;
    srcPasta: TDataSource;
    Panel1: TPanel;
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
    DM: TPastaController;
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
  DM := TPastaController.Create(Self);
  srcPasta.DataSet := DM.tblPasta;
end;

procedure TPastaListagem.btnAlterarClick(Sender: TObject);
begin
  TPastaManutencao.New(Self, DM);
end;

procedure TPastaListagem.btnIncluirClick(Sender: TObject);
begin
  TPastaManutencao.New(Self, DM);
end;

procedure TPastaListagem.btnPesquisarClick(Sender: TObject);
begin
  DM.Pasta.Query.Add('id', 1);
  DM.Pasta.Table.Read;
end;

procedure TPastaListagem.btnVisualizarClick(Sender: TObject);
begin
  TPastaManutencao.New(Self, DM);
end;

end.
