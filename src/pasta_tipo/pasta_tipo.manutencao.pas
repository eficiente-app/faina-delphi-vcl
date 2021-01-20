// Eduardo - 07/01/2021
unit pasta_tipo.manutencao;

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
  pasta_tipo.dados,
  Faina.Pesquisa;

type
  TAcaoManutencao = (Incluir, Alterar, Visualizar);

  TPastaTipoManutencao = class(TFormularioBaseVisual)
    lbid: TLabel;
    lbdescricao: TLabel;
    lbnome: TLabel;
    dbedtid: TDBEdit;
    pnlTop: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    dbedtdescricao: TDBEdit;
    dbedtnome: TDBEdit;
    srcPastaTipo: TDataSource;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    PTD: TPastaTipoDados;
  public
    class procedure New(AParent: TWinControl; APTD: TPastaTipoDados; Tipo: TAcaoManutencao);
  end;

implementation

{$R *.dfm}

class procedure TPastaTipoManutencao.New(AParent: TWinControl; APTD: TPastaTipoDados; Tipo: TAcaoManutencao);
begin
  with TPastaTipoManutencao.Create(AParent) do
  begin
    Parent := AParent;
    BorderStyle := bsNone;
    Anchors := [akLeft,akTop,akRight,akBottom];
    SetBounds(AParent.Left, AParent.Top, AParent.Width, AParent.Height);

    CloseEsc := True;

    PTD := APTD;
    srcPastaTipo.DataSet := PTD.tblPastaTipo;

    case Tipo of
      Incluir: PTD.tblPastaTipo.Append;
      Alterar: PTD.tblPastaTipo.Edit;
    end;

    btnGravar.Visible   := Tipo in [Incluir, Alterar];
    btnCancelar.Visible := Tipo in [Incluir, Alterar];
    btnExcluir.Visible  := Tipo = Alterar;
    btnFechar.Visible   := Tipo = Visualizar;

    Show;
  end;
end;

procedure TPastaTipoManutencao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TPastaTipoManutencao.btnCancelarClick(Sender: TObject);
begin
  PTD.tblPastaTipo.Cancel;
  Close;
end;

procedure TPastaTipoManutencao.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  PTD.tblPastaTipo.Delete;
  PTD.PastaTipo.Table.Write;
  Close;
end;

procedure TPastaTipoManutencao.btnGravarClick(Sender: TObject);
begin
  if PTD.tblPastaTipo.State in dsEditModes then
    PTD.tblPastaTipo.Post;
  PTD.PastaTipo.Table.Write;
  Close;
end;

end.
