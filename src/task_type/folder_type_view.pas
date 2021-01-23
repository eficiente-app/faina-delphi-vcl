// Eduardo - 07/01/2021
unit folder_type_view;

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
  folder_type_controller,
  search_view;

type
  TAcaoManutencao = (Incluir, Alterar);

  TPastaTipoManutencao = class(TFormularioBaseVisual)
    lbid: TLabel;
    lbdescricao: TLabel;
    lbnome: TLabel;
    dbedtid: TDBEdit;
    pnlTop: TPanel;
    btnConfirmar: TButton;
    dbedtdescricao: TDBEdit;
    dbedtnome: TDBEdit;
    srcPastaTipo: TDataSource;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    PTD: TFolderTypeController;
  public
    class procedure New(AParent: TForm; APTD: TFolderTypeController; Tipo: TAcaoManutencao);
  end;

implementation

{$R *.dfm}

class procedure TPastaTipoManutencao.New(AParent: TForm; APTD: TFolderTypeController; Tipo: TAcaoManutencao);
begin
  with TPastaTipoManutencao.Create(AParent) do
  begin
    CloseEsc := True;

    PTD := APTD;
    srcPastaTipo.DataSet := PTD.tblPastaTipo;

    case Tipo of
      Incluir: PTD.tblPastaTipo.Append;
      Alterar: PTD.tblPastaTipo.Edit;
    end;

    btnConfirmar.Visible := Tipo in [Incluir, Alterar];
    ShowModal(AParent);
  end;
end;

procedure TPastaTipoManutencao.btnConfirmarClick(Sender: TObject);
begin
  if PTD.tblPastaTipo.State in dsEditModes then
    PTD.tblPastaTipo.Post;
  PTD.PastaTipo.Table.Write;
  Close;
end;

procedure TPastaTipoManutencao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if PTD.tblPastaTipo.State in dsEditModes then
    PTD.tblPastaTipo.Cancel;
end;

end.
