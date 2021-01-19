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
  Formulario.Base,
  FireDAC.Comp.Client;

type
  TPesquisa = class(TFormularioBase)
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
  private
    FFiltro: String;
    FFiltrado: Boolean;
    FSelecao: TProc;
  public
    class function New(AParent: TForm; ATable: TFDMemTable): TPesquisa;
    procedure Selecao(Prc: TProc);
  end;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TPesquisa }

class function TPesquisa.New(AParent: TForm; ATable: TFDMemTable): TPesquisa;
begin
  Result := TPesquisa.Create(AParent);
  with Result do
  try
    FFiltro   := ATable.Filter;
    FFiltrado := ATable.Filtered;
    try
      src.DataSet := ATable;

      ShowModal(AParent);

//      if ShowModal <> mrOk then
//        Abort;
    finally
//      ATable.Filter   := FFiltro;
//      ATable.Filtered := FFiltrado;
    end;
  finally

  end;
end;

procedure TPesquisa.Selecao(Prc: TProc);
begin
  FSelecao := Prc;
end;

procedure TPesquisa.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TPesquisa.btnConfirmarClick(Sender: TObject);
begin
  if Assigned(FSelecao) then
    FSelecao;
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

  sPesquisa := IfThen(FFiltrado and not FFiltro.IsEmpty, FFiltro +' and ') + Field.FieldName;

  if Field.InheritsFrom(TNumericField) or Field.InheritsFrom(TDateField) then
    sPesquisa := sPesquisa +' = '+ Trim(edtValor.Text)
  else
    sPesquisa := sPesquisa +' LIKE '+ QuotedStr('%'+ ReplaceStr(Trim(edtValor.Text), ' ', '%') +'%');

  src.DataSet.Filtered := False;
  src.DataSet.Filter   := sPesquisa;
  src.DataSet.Filtered := True;
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
