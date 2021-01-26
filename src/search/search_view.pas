﻿// Eduardo - 08/12/2020
unit search_view;

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
  base_form_view,
  Extend.DBGrids;

type
  TSearchView = class(TBaseFormView)
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
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgridDblClick(Sender: TObject);
  private
    FOrigem: TField;
    FDestino: TField;
  public
    class function New(AParent: TForm; Origem, Destino: TField): TSearchView;
  end;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TPesquisa }

class function TSearchView.New(AParent: TForm; Origem, Destino: TField): TSearchView;
begin
  Result := TSearchView.Create(AParent);
  with Result do
  begin
    FOrigem := Origem;
    FDestino := Destino;
    src.DataSet := Origem.DataSet;
    ShowModal(AParent);
  end;
end;

procedure TSearchView.btnConfirmarClick(Sender: TObject);
begin
  FDestino.Value := FOrigem.Value;
  Close;
end;

procedure TSearchView.btnPesquisarClick(Sender: TObject);
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

procedure TSearchView.dbgridDblClick(Sender: TObject);
begin
  btnConfirmarClick(btnConfirmar);
end;

procedure TSearchView.FormCreate(Sender: TObject);
begin
  CloseEsc := True;
end;

procedure TSearchView.FormShow(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Pred(dbgrid.Columns.Count) do
  begin
    dbgrid.Columns[I].Visible := dbgrid.Columns[I].FieldName <> dbgrid.Columns[I].Field.DisplayLabel;
    if dbgrid.Columns[I].Visible then
    begin
      dbgrid.Columns[I].Title.Alignment := dbgrid.Columns[I].Field.Alignment;
      cbxCampo.AddItem(dbgrid.Columns[I].Field.DisplayLabel, dbgrid.Columns[I].Field);
    end;
  end;
  cbxCampo.ItemIndex := 0;
  dbgrid.ResizeColumn([]);
end;

end.
