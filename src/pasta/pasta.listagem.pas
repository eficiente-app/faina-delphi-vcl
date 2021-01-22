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
  Extend.DBGrids, Vcl.Menus;

type
  TPastaListagem = class(TFormularioBaseVisual)
    dbgridPasta: TDBGrid;
    pnlPesquisa: TPanel;
    pnlPesquisar: TPanel;
    btnPesquisar: TButton;
    btnLimpar: TButton;
    gbxPesquisa: TGroupBox;
    pnlTopo: TPanel;
    btnAdicionar: TButton;
    srcPasta: TDataSource;
    popAcoes: TPopupMenu;
    btnRemover: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgridPastaCellClick(Column: TColumn);
    procedure btnRemoverClick(Sender: TObject);
  private
    PD: TPastaDados;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TPastaListagem.FormCreate(Sender: TObject);
begin
  PD := TPastaDados.Create(Self);
  srcPasta.DataSet := PD.tblPasta;
end;

procedure TPastaListagem.btnRemoverClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  PD.tblPasta.Delete;
  PD.Pasta.Table.Write;
end;

procedure TPastaListagem.btnAdicionarClick(Sender: TObject);
begin
  TPastaManutencao.New(Self, PD, Incluir);
end;

procedure TPastaListagem.dbgridPastaCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TPastaManutencao.New(Self, PD, Alterar);
end;

procedure TPastaListagem.btnPesquisarClick(Sender: TObject);
begin
  PD.Pasta.Query.Add('id', 1);
  PD.Pasta.Table.Read;
end;

end.
