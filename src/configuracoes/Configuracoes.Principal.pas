// Daniel Araujo - 17/01/2021
unit Configuracoes.Principal;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Formulario.Base, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, Vcl.StdCtrls;

type
  TConfiguracoesPrincipal = class(TFormularioBase)
    pnlTopTitle: TPanel;
    pnlLateralEsquerda: TPanel;
    pnlAreaTrabalho: TPanel;
    nbMenu: TdxNavBar;
    nbgCadastros: TdxNavBarGroup;
    nbgSitema: TdxNavBarGroup;
    nbiPastas: TdxNavBarItem;
    lblTitle: TLabel;
    nbiTipoPasta: TdxNavBarItem;
    lblSubTitle: TLabel;
    nbiTipoTarefa: TdxNavBarItem;
    procedure nbiPastasClick(Sender: TObject);
    procedure nbiTipoPastaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nbiTipoTarefaClick(Sender: TObject);
  private
    { Private declarations }
    FTelaAtiva: TFormularioBase;
    procedure AbrirTela(FormClass: TFormClass);
    procedure FercharTela;
    procedure AtualizarSubTitulo;
  public
    { Public declarations }
  end;

var
  ConfiguracoesPrincipal: TConfiguracoesPrincipal;

implementation

uses
  pasta.listagem,
  pasta_tipo.listagem,
  tarefa_tipo.listagem;

{$R *.dfm}

{ TConfiguracoesPrincipal }

procedure TConfiguracoesPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FercharTela;
end;

procedure TConfiguracoesPrincipal.AbrirTela(FormClass: TFormClass);
begin
  FercharTela;
  FTelaAtiva := TFormularioBase(FormClass.Create(Self));
  FTelaAtiva.ShowIn(pnlAreaTrabalho, alClient);
  AtualizarSubTitulo;
end;

procedure TConfiguracoesPrincipal.AtualizarSubTitulo;
begin
  lblSubTitle.Visible := Assigned(FTelaAtiva);
  if Assigned(FTelaAtiva) then
    lblSubTitle.Caption := '-> '+ FTelaAtiva.Caption;
end;

procedure TConfiguracoesPrincipal.FercharTela;
begin
  if not Assigned(FTelaAtiva) then
    Exit;

  FTelaAtiva.Close;
end;

procedure TConfiguracoesPrincipal.nbiPastasClick(Sender: TObject);
begin
  AbrirTela(TPastaListagem);
end;

procedure TConfiguracoesPrincipal.nbiTipoPastaClick(Sender: TObject);
begin
  AbrirTela(TPastaTipoListagem);
end;

procedure TConfiguracoesPrincipal.nbiTipoTarefaClick(Sender: TObject);
begin
  AbrirTela(TTarefaTipoListagem);
end;

end.
