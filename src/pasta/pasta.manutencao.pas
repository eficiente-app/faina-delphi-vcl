﻿// Eduardo - 08/12/2020
unit pasta.manutencao;

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
  Vcl.StdCtrls,
  Data.DB,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.ImgList,
  Vcl.Buttons,
  pasta.dados,
  Faina.Pesquisa;

type
  TAcaoManutencao = (Incluir, Alterar, Visualizar);

  TPastaManutencao = class(TForm)
    dbedtid: TDBEdit;
    lbid: TLabel;
    pnlTop: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    dbedttipo: TDBEdit;
    lbtipo: TLabel;
    lbprojeto_id: TLabel;
    dbedtprojeto_id: TDBEdit;
    lbnome: TLabel;
    lbdescricao: TLabel;
    sbttipo: TSpeedButton;
    sbtprojeto_id: TSpeedButton;
    srcPasta: TDataSource;
    dbedtnome: TDBEdit;
    dbedtdescricao: TDBEdit;
    dbedttipo_descricao: TDBEdit;
    lbtipo_descricao: TLabel;
    dbedtprojeto_descricao: TDBEdit;
    lbprojeto_descricao: TLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure sbttipoClick(Sender: TObject);
    procedure sbtprojeto_idClick(Sender: TObject);
  private
    PD: TPastaDados;
  public
    class procedure New(AParent: TWinControl; ADM: TPastaDados; Tipo: TAcaoManutencao);
  end;

implementation

{$R *.dfm}

class procedure TPastaManutencao.New(AParent: TWinControl; ADM: TPastaDados; Tipo: TAcaoManutencao);
begin
  with TPastaManutencao.Create(AParent) do
  begin
    Parent := AParent;
    BorderStyle := bsNone;
    Anchors := [akLeft,akTop,akRight,akBottom];
    SetBounds(AParent.Left, AParent.Top, AParent.Width, AParent.Height);

    PD := ADM;
    srcPasta.DataSet := PD.tblPasta;

    case Tipo of
      Incluir: PD.tblPasta.Append;
      Alterar: PD.tblPasta.Edit;
    end;

    btnGravar.Visible   := Tipo in [Incluir, Alterar];
    btnCancelar.Visible := Tipo in [Incluir, Alterar];
    btnExcluir.Visible  := Tipo = Alterar;
    btnFechar.Visible   := Tipo = Visualizar;

    Show;
  end;
end;

procedure TPastaManutencao.sbttipoClick(Sender: TObject);
begin
  // Só exemplo
  TPesquisa.New(PD.tblPasta);
  PD.tblPasta.FieldByName('tipo').AsString := PD.tblPasta.FieldByName('id').AsString;
  PD.tblPasta.FieldByName('tipo_descricao').AsString := PD.tblPasta.FieldByName('descricao').AsString;
end;

procedure TPastaManutencao.sbtprojeto_idClick(Sender: TObject);
begin
  // Só exemplo
  TPesquisa.New(PD.tblPasta);
  PD.tblPasta.FieldByName('projeto_id').AsString := PD.tblPasta.FieldByName('id').AsString;
  PD.tblPasta.FieldByName('projeto_descricao').AsString := PD.tblPasta.FieldByName('descricao').AsString;
end;

procedure TPastaManutencao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TPastaManutencao.btnCancelarClick(Sender: TObject);
begin
  PD.tblPasta.Cancel;
  Close;
end;

procedure TPastaManutencao.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PWideChar('Confirma a exclusão do registro?'), PWideChar('Confirmação')) <> mrOk then
    Exit;
  PD.tblPasta.Delete;
  PD.Pasta.Table.Write;
  Close;
end;

procedure TPastaManutencao.btnGravarClick(Sender: TObject);
begin
  if PD.tblPasta.State in dsEditModes then
    PD.tblPasta.Post;
  PD.Pasta.Table.Write;
  Close;
end;

end.
