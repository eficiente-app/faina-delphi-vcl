// Eduardo - 08/01/2021
unit task_type_view;

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
  base_form_view,
  task_type_controller,
  search_view;

type
  TAcaoManutencao = (Incluir, Alterar);

  TTaskTypeView = class(TBaseFormView)
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
    TTD: TTaskTypeController;
  public
    class procedure New(AParent: TForm; ATTD: TTaskTypeController; Tipo: TAcaoManutencao);
  end;

implementation

{$R *.dfm}

class procedure TTaskTypeView.New(AParent: TForm; ATTD: TTaskTypeController; Tipo: TAcaoManutencao);
begin
  with TTaskTypeView.Create(AParent) do
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

procedure TTaskTypeView.btnConfirmarClick(Sender: TObject);
begin
  if TTD.tblTarefaTipo.State in dsEditModes then
    TTD.tblTarefaTipo.Post;
  TTD.TarefaTipo.Table.Write;
  Close;
end;

procedure TTaskTypeView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if TTD.tblTarefaTipo.State in dsEditModes then
    TTD.tblTarefaTipo.Cancel;
end;

end.
