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
  Formulario.Base.Visual,
  tarefa_tipo.dados,
  Faina.Pesquisa;

type
  TAcaoManutencao = (Incluir, Alterar);

  TTarefaTipoManutencao = class(TFormularioBaseVisual)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnConfirmar: TButton;
    lbdescricao: TLabel;
    srcTarefaTipo: TDataSource;
    dbedtdescricao: TDBEdit;
    lbnome: TLabel;
    dbedtnome: TDBEdit;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    TTD: TTarefaTipoDados;
  public
    class procedure New(AParent: TForm; ATTD: TTarefaTipoDados; Tipo: TAcaoManutencao);
  end;

implementation

{$R *.dfm}

class procedure TTarefaTipoManutencao.New(AParent: TForm; ATTD: TTarefaTipoDados; Tipo: TAcaoManutencao);
begin
  with TTarefaTipoManutencao.Create(AParent) do
  begin
    CloseEsc := True;

    TTD := ATTD;
    srcTarefaTipo.DataSet := TTD.tblTarefaTipo;

    case Tipo of
      Incluir: TTD.tblTarefaTipo.Append;
      Alterar: TTD.tblTarefaTipo.Edit;
    end;

    btnConfirmar.Visible := Tipo in [Incluir, Alterar];
    ShowModal(AParent);
  end;
end;

procedure TTarefaTipoManutencao.btnConfirmarClick(Sender: TObject);
begin
  if TTD.tblTarefaTipo.State in dsEditModes then
    TTD.tblTarefaTipo.Post;
  TTD.TarefaTipo.Table.Write;
  Close;
end;

procedure TTarefaTipoManutencao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if TTD.tblTarefaTipo.State in dsEditModes then
    TTD.tblTarefaTipo.Cancel;
end;

end.
