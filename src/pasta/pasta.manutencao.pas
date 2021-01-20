// Eduardo - 08/12/2020
unit pasta.manutencao;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Data.DB,
  Vcl.Buttons,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.ImgList,
  Vcl.Mask,
  Vcl.StdCtrls,
  Formulario.Base.Visual,
  pasta.dados,
  Faina.Pesquisa;

type
  TAcaoManutencao = (Incluir, Alterar, Visualizar);

  TPastaManutencao = class(TFormularioBaseVisual)
    lbid: TLabel;
    lbtipo_id: TLabel;
    lbprojeto_id: TLabel;
    lbnome: TLabel;
    lbdescricao: TLabel;
    sbttipo_id: TSpeedButton;
    sbtprojeto_id: TSpeedButton;
    lbtipo_nome: TLabel;
    lbprojeto_descricao: TLabel;
    dbedtid: TDBEdit;
    pnlTop: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    dbedttipo_id: TDBEdit;
    dbedtprojeto_id: TDBEdit;
    dbedtnome: TDBEdit;
    dbedtdescricao: TDBEdit;
    dbedttipo_nome: TDBEdit;
    dbedtprojeto_descricao: TDBEdit;
    srcPasta: TDataSource;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure sbttipo_idClick(Sender: TObject);
  private
    PD: TPastaDados;
  public
    class procedure New(AParent: TForm; ADM: TPastaDados; Tipo: TAcaoManutencao);
  end;

implementation

{$R *.dfm}

uses
  pasta_tipo.dados;

class procedure TPastaManutencao.New(AParent: TForm; ADM: TPastaDados; Tipo: TAcaoManutencao);
begin
  with TPastaManutencao.Create(AParent) do
  begin
    PD := ADM;
    srcPasta.DataSet := PD.tblPasta;

    CloseEsc := True;

    case Tipo of
      Incluir: PD.tblPasta.Append;
      Alterar: PD.tblPasta.Edit;
    end;

    btnGravar.Visible   := Tipo in [Incluir, Alterar];
    btnCancelar.Visible := Tipo in [Incluir, Alterar];
    btnExcluir.Visible  := Tipo = Alterar;
    btnFechar.Visible   := Tipo = Visualizar;

    ShowModal(AParent);
  end;
end;

procedure TPastaManutencao.sbttipo_idClick(Sender: TObject);
begin
  TPesquisa.New(
    TForm(Self.Parent),
    pasta_tipo_dados.tblPastaTipo.FieldByName('id'),
    PD.tblPasta.FieldByName('tipo_id')
  );
end;

procedure TPastaManutencao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TPastaManutencao.btnCancelarClick(Sender: TObject);
begin
  PD.tblPasta.Cancel;
  Close;
end;

procedure TPastaManutencao.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  PD.tblPasta.Delete;
  PD.Pasta.Table.Write;
  Close;
end;

procedure TPastaManutencao.btnGravarClick(Sender: TObject);
begin
  if PD.tblPasta.State in dsEditModes then
    PD.tblPasta.Post;
  PD.Pasta.Table.Write;
  Close;
end;

end.
