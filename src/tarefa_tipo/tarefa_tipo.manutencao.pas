// Eduardo - 08/01/2021
unit tarefa_tipo.manutencao;

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
  Formulario.Base,
  tarefa_tipo.dados,
  Faina.Pesquisa;

type
  TAcaoManutencao = (Incluir, Alterar, Visualizar);

  TTarefaTipoManutencao = class(TFormularioBase)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    lbdescricao: TLabel;
    srcTarefaTipo: TDataSource;
    dbedtdescricao: TDBEdit;
    lbnome: TLabel;
    dbedtnome: TDBEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    TTD: TTarefaTipoDados;
  public
    class procedure New(AParent: TWinControl; ATTD: TTarefaTipoDados; Tipo: TAcaoManutencao);
  end;

implementation

{$R *.dfm}

class procedure TTarefaTipoManutencao.New(AParent: TWinControl; ATTD: TTarefaTipoDados; Tipo: TAcaoManutencao);
begin
  with TTarefaTipoManutencao.Create(AParent) do
  begin
    Parent := AParent;
    BorderStyle := bsNone;
    Anchors := [akLeft,akTop,akRight,akBottom];
    SetBounds(AParent.Left, AParent.Top, AParent.Width, AParent.Height);

    TTD := ATTD;
    srcTarefaTipo.DataSet := TTD.tblTarefaTipo;

    case Tipo of
      Incluir: TTD.tblTarefaTipo.Append;
      Alterar: TTD.tblTarefaTipo.Edit;
    end;

    btnGravar.Visible   := Tipo in [Incluir, Alterar];
    btnCancelar.Visible := Tipo in [Incluir, Alterar];
    btnExcluir.Visible  := Tipo = Alterar;
    btnFechar.Visible   := Tipo = Visualizar;

    Show;
  end;
end;

procedure TTarefaTipoManutencao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TTarefaTipoManutencao.btnCancelarClick(Sender: TObject);
begin
  TTD.tblTarefaTipo.Cancel;
  Close;
end;

procedure TTarefaTipoManutencao.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  TTD.tblTarefaTipo.Delete;
  TTD.TarefaTipo.Table.Write;
  Close;
end;

procedure TTarefaTipoManutencao.btnGravarClick(Sender: TObject);
begin
  if TTD.tblTarefaTipo.State in dsEditModes then
    TTD.tblTarefaTipo.Post;
  TTD.TarefaTipo.Table.Write;
  Close;
end;

end.
