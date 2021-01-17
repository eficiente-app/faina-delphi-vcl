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
    procedure nbiPastasClick(Sender: TObject);
    procedure nbiTipoPastaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FTelaAtiva: TFormularioBase;
    procedure AbrirTela(FormClass: TFormClass);
    procedure FercharTela;
  public
    { Public declarations }
  end;

var
  ConfiguracoesPrincipal: TConfiguracoesPrincipal;

implementation

uses
  pasta.listagem,
  pasta_tipo.listagem;

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

end.
