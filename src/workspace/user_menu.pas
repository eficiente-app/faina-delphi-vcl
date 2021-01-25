// Daniel Araujo - 17/01/2021
unit user_menu;

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
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  base_form_dropdown,
  base_form,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxSkinsCore,
  dxSkinsDefaultPainters,
  cxButtons,
  SVGIconImage;

type
  TUserMenu = class(TBaseFormDropDown)
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
    class function Show: TUserMenu;
    procedure Position;
  end;

implementation

uses
  workspace.view,
  main_configuration;

{$R *.dfm}

class function TUserMenu.Show: TUserMenu;
begin
  Result := TUserMenu.Create(Principal);
  Result.Position;
end;

procedure TUserMenu.Position;
var
  pMenu: TPoint;
begin
  with TWorkSpace(AreaTrabalho).pnlTop do
  begin
    pMenu := ClientOrigin;
    pMenu.X := pMenu.X + Width;
    pMenu.Y := pMenu.Y + Height;
  end;
  pMenu.X := pMenu.X - Width;
  ShowDropDown(Principal, pMenu);
end;

procedure TUserMenu.cxButton2Click(Sender: TObject);
begin
  TMainConfiguration.Create(AreaTrabalho).ShowModal(AreaTrabalho);
  Close;
end;

procedure TUserMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
