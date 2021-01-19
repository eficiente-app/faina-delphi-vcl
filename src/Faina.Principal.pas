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
  Formulario.Principal.Base,
  SVGIconImage;

type
  TPrincipal = class(TFormularioPrincipalBase)
    pnlTop: TPanel;
    pnlTitle: TPanel;
    lblTitle: TLabel;
    svgUserAvatar: TSVGIconImage;
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
  Menu.Usuario,
  Configuracoes.Principal,
  pasta.listagem,
  pasta_tipo.listagem,
  tarefa_tipo.listagem;

{$R *.dfm}

procedure TPrincipal.btnConfiguracoesClick(Sender: TObject);
begin
  TConfiguracoesPrincipal.Create(TComponent(Self)).ShowModal(Self);
end;

procedure TPrincipal.FormShow(Sender: TObject);
begin
  TLogin.New(Self);
end;

procedure TPrincipal.svgUserAvatarClick(Sender: TObject);
begin
  TMenuUsuario.Exibir;
end;

end.
