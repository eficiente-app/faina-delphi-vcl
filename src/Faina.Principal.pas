unit Faina.Principal;

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
  Vcl.Menus,
  Vcl.StdCtrls,
  Formulario.Base,
  SVGIconImage;

type
  TPrincipal = class(TFormularioBase)
    pnlTop: TPanel;
    pnlClient: TPanel;
    pnlTitle: TPanel;
    lblTitle: TLabel;
    pmUserAvatar: TPopupMenu;
    svgUserAvatar: TSVGIconImage;
    btnConfiguracoes: TMenuItem;
    pnlLateralEsquerda: TPanel;
    pnlAreaTrabalho: TPanel;
    procedure svgUserAvatarClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

uses
  Faina.Login,
  pasta.listagem,
  pasta_tipo.listagem,
  tarefa_tipo.listagem;

{$R *.dfm}

procedure TPrincipal.btnConfiguracoesClick(Sender: TObject);
begin
  TTarefaTipoListagem.Create(AreaTrabalho).ShowModal(Self);
end;

procedure TPrincipal.FormShow(Sender: TObject);
begin
  TLogin.New(Self);
end;

procedure TPrincipal.svgUserAvatarClick(Sender: TObject);
var
  pMenu: TPoint;
begin
  pMenu := pnlTop.ClientOrigin;
  pMenu.X := pMenu.X + pnlTop.Width;
  pMenu.Y := pMenu.Y + pnlTop.Height;
  pmUserAvatar.Popup(pMenu.X, pMenu.Y);
end;

end.
