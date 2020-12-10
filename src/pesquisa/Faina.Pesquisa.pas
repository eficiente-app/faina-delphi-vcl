// Eduardo - 08/12/2020
unit Faina.Pesquisa;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  FireDAC.Comp.Client;

type
  TPesquisa = class(TForm)
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
  private
    FFiltro: String;
    FFiltrado: Boolean;
  public
    class procedure New(ATable: TFDMemTable);
  end;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TPesquisa }

class procedure TPesquisa.New(ATable: TFDMemTable);
begin
  with TPesquisa.Create(nil) do
  try
    FFiltro   := ATable.Filter;
    FFiltrado := ATable.Filtered;
    try
      src.DataSet := ATable;

      if ShowModal <> mrOk then
        Abort;
    finally
      ATable.Filter   := FFiltro;
      ATable.Filtered := FFiltrado;
    end;
  finally
    Free;
  end;
end;

procedure TPesquisa.btnPesquisarClick(Sender: TObject);
var
  sPesquisa: String;
  Field: TField;
begin
  Field := TField(cbxCampo.Items.Objects[cbxCampo.ItemIndex]);

  sPesquisa := IfThen(FFiltrado and not FFiltro.IsEmpty, FFiltro +' and ') + Field.FieldName;
  
  if Field.InheritsFrom(TNumericField) or Field.InheritsFrom(TDateField) then
    sPesquisa := sPesquisa +' = '+ edtValor.Text
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
