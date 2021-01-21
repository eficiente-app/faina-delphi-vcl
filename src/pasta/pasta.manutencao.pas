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
  TAcaoManutencao = (Incluir, Alterar);

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
    dbedttipo_id: TDBEdit;
    dbedtprojeto_id: TDBEdit;
    dbedtnome: TDBEdit;
    dbedtdescricao: TDBEdit;
    dbedttipo_nome: TDBEdit;
    dbedtprojeto_descricao: TDBEdit;
    srcPasta: TDataSource;
    pnlTop: TPanel;
    btnConfirmar: TButton;
    procedure btnConfirmarClick(Sender: TObject);
    procedure sbttipo_idClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    CloseEsc := True;

    PD := ADM;
    srcPasta.DataSet := PD.tblPasta;

    case Tipo of
      Incluir: PD.tblPasta.Append;
      Alterar: PD.tblPasta.Edit;
    end;

    btnConfirmar.Visible := Tipo in [Incluir, Alterar];
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

procedure TPastaManutencao.btnConfirmarClick(Sender: TObject);
begin
  if PD.tblPasta.State in dsEditModes then
    PD.tblPasta.Post;
  PD.Pasta.Table.Write;
  Close;
end;

procedure TPastaManutencao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if PD.tblPasta.State in dsEditModes then
    PD.tblPasta.Cancel;
end;

end.
