// Eduardo - 07/01/2021
unit folder_type_list;

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
  folder_type_controller,
  folder_type_view,
  Extend.DBGrids, Vcl.Menus;

type
  TFolderTypeList = class(TFormularioBaseVisual)
    dbgridPasta: TDBGrid;
    pnlTopo: TPanel;
    btnAdicionar: TButton;
    pnlPesquisa: TPanel;
    pnlPesquisar: TPanel;
    btnPesquisar: TButton;
    btnLimpar: TButton;
    gbxPesquisa: TGroupBox;
    srcPastaTipo: TDataSource;
    popAcoes: TPopupMenu;
    btnRemover: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgridPastaCellClick(Column: TColumn);
    procedure btnRemoverClick(Sender: TObject);
  private
    PTD: TFolderTypeController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TFolderTypeList.FormCreate(Sender: TObject);
begin
  PTD := pasta_tipo_dados;
  srcPastaTipo.DataSet := PTD.tblPastaTipo;
end;

procedure TFolderTypeList.btnRemoverClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  PTD.tblPastaTipo.Delete;
  PTD.PastaTipo.Table.Write;
end;

procedure TFolderTypeList.btnAdicionarClick(Sender: TObject);
begin
  TPastaTipoManutencao.New(Self, PTD, Incluir);
end;

procedure TFolderTypeList.dbgridPastaCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TPastaTipoManutencao.New(Self, PTD, Alterar);
end;

procedure TFolderTypeList.btnPesquisarClick(Sender: TObject);
begin
  PTD.PastaTipo.Query.Add('id', 1);
  PTD.PastaTipo.Table.Read;
end;

end.
