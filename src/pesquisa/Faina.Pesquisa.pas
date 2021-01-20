// Eduardo - 08/12/2020
unit Faina.Pesquisa;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Data.DB,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.Mask,
  Vcl.StdCtrls,
  FireDAC.Comp.Client,
  Formulario.Base,
  Formulario.Base.Visual,
  Extend.DBGrids;

type
  TPesquisa = class(TFormularioBaseVisual)
    pnlPesquisa: TPanel;
    dbgrid: TDBGrid;
    src: TDataSource;
    cbxCampo: TComboBox;
    lbCampo: TLabel;
    btnPesquisar: TButton;
    pnlTop: TPanel;
    edtValor: TEdit;
    lbValor: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FOrigem: TField;
    FDestino: TField;
  public
    class function New(AParent: TForm; Origem, Destino: TField): TPesquisa;
  end;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TPesquisa }

class function TPesquisa.New(AParent: TForm; Origem, Destino: TField): TPesquisa;
begin
  Result := TPesquisa.Create(AParent);
  with Result do
  begin
    FOrigem := Origem;
    FDestino := Destino;
    src.DataSet := Origem.DataSet;
    ShowModal(AParent);
  end;
end;

procedure TPesquisa.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TPesquisa.btnConfirmarClick(Sender: TObject);
begin
  FDestino.Value := FOrigem.Value;
  Close;
end;

procedure TPesquisa.btnPesquisarClick(Sender: TObject);
var
  sPesquisa: String;
  Field: TField;
begin
  if Trim(edtValor.Text).IsEmpty then
    Exit;

  Field := TField(cbxCampo.Items.Objects[cbxCampo.ItemIndex]);

  sPesquisa := Field.FieldName;

  if Field.InheritsFrom(TNumericField) or Field.InheritsFrom(TDateField) then
    sPesquisa := sPesquisa +' = '+ Trim(edtValor.Text)
  else
    sPesquisa := sPesquisa +' LIKE '+ QuotedStr('%'+ ReplaceStr(Trim(edtValor.Text), ' ', '%') +'%');

  src.DataSet.Filtered := False;
  src.DataSet.Filter   := sPesquisa;
  src.DataSet.Filtered := True;
end;

procedure TPesquisa.FormCreate(Sender: TObject);
begin
  CloseEsc := True;
end;

procedure TPesquisa.FormShow(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Pred(dbgrid.Columns.Count) do
  begin
    dbgrid.Columns[I].Visible := dbgrid.Columns[I].FieldName <> dbgrid.Columns[I].Field.DisplayLabel;
    if dbgrid.Columns[I].Visible then
      cbxCampo.AddItem(dbgrid.Columns[I].Field.DisplayLabel, dbgrid.Columns[I].Field);
  end;

  cbxCampo.ItemIndex := 0;

  // Aplicar resize nas colunas
end;

end.
