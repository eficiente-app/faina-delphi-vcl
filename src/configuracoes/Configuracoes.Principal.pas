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
  Formulario.Base.Visual, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, Vcl.StdCtrls;

type
  TConfiguracoesPrincipal = class(TFormularioBaseVisual)
    pnlLateralEsquerda: TPanel;
    nbMenu: TdxNavBar;
    nbgCadastros: TdxNavBarGroup;
    nbgSitema: TdxNavBarGroup;
    nbiPastas: TdxNavBarItem;
    nbiTipoPasta: TdxNavBarItem;
    nbiTipoTarefa: TdxNavBarItem;
    pnlAreaTrabalho: TPanel;
    lblSubTitle: TLabel;
    procedure nbiPastasClick(Sender: TObject);
    procedure nbiTipoPastaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nbiTipoTarefaClick(Sender: TObject);
  private
    { Private declarations }
    FTelaAtiva: TFormularioBaseVisual;
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
  folder_list,
  folder_type_list,
  task_type_list;

{$R *.dfm}

{ TConfiguracoesPrincipal }

procedure TConfiguracoesPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FercharTela;
end;

procedure TConfiguracoesPrincipal.AbrirTela(FormClass: TFormClass);
begin
  FercharTela;
  FTelaAtiva := TFormularioBaseVisual(FormClass.Create(Self));
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
  AbrirTela(TFolderList);
end;

procedure TConfiguracoesPrincipal.nbiTipoPastaClick(Sender: TObject);
begin
  AbrirTela(TFolderTypeList);
end;

procedure TConfiguracoesPrincipal.nbiTipoTarefaClick(Sender: TObject);
begin
  AbrirTela(TTaskTypeList);
end;

end.
