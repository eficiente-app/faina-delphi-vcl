// Daniel Araujo - 17/01/2021
unit menu.usuario;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Formulario.DropDown.Base, Formulario.Base, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinsDefaultPainters,
  Vcl.StdCtrls, cxButtons, SVGIconImage, Vcl.ExtCtrls;

type
  TMenuUsuario = class(TFormularioDropDownBase)
    pnlTopUsuario: TPanel;
    svgUserAvatar: TSVGIconImage;
    pnlInfoUsuario: TPanel;
    lblApelidoUsuario: TLabel;
    lblNomeUsuario: TLabel;
    lblFuncaoPrincipal: TLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    procedure cxButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Exibir: TMenuUsuario;
    procedure Posicionar;
  end;

implementation

uses
  area_trabalho,
  Configuracoes.Principal;

{$R *.dfm}

class function TMenuUsuario.Exibir: TMenuUsuario;
begin
  Result := TMenuUsuario.Create(Principal);
  Result.Posicionar;
end;

procedure TMenuUsuario.Posicionar;
var
  pMenu: TPoint;
begin
  with TAreaTrabalho(AreaTrabalho).pnlTop do
  begin
    pMenu := ClientOrigin;
    pMenu.X := pMenu.X + Width;
    pMenu.Y := pMenu.Y + Height;
  end;
  pMenu.X := pMenu.X - Width;
  ShowDropDown(Principal, pMenu);
end;

procedure TMenuUsuario.cxButton2Click(Sender: TObject);
begin
  TConfiguracoesPrincipal.Create(Principal).ShowModal(Principal);
  Close;
end;

procedure TMenuUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
