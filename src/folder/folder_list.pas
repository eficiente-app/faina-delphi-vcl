// Eduardo - 05/12/2020
unit folder_list;

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
  base_form_view,
  folder_controller,
  folder_view,
  Extend.DBGrids, Vcl.Menus;

type
  TFolderList = class(TBaseFormView)
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
    PD: TFolderController;
  end;

implementation

{$R *.dfm}

{ TPasta }

procedure TFolderList.FormCreate(Sender: TObject);
begin
  PD := TFolderController.Create(Self);
  srcPasta.DataSet := PD.tblPasta;
end;

procedure TFolderList.btnRemoverClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  PD.tblPasta.Delete;
  PD.Pasta.Table.Write;
end;

procedure TFolderList.btnAdicionarClick(Sender: TObject);
begin
  TFolderView.New(Self, PD, Incluir);
end;

procedure TFolderList.dbgridPastaCellClick(Column: TColumn);
begin
  if not Column.Field.DataSet.IsEmpty then
    TFolderView.New(Self, PD, Alterar);
end;

procedure TFolderList.btnPesquisarClick(Sender: TObject);
begin
  PD.Pasta.Query.Add('id', 1);
  PD.Pasta.Table.Read;
end;

end.
