// Daniel Araujo - 19/01/2021
unit work_area;

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
  Vcl.ExtCtrls,
  base_form_view,
  SVGIconImage;

type
  TWorkArea = class(TBaseFormView)
    pnlTop: TPanel;
    pnlTitle: TPanel;
    lblTitlePrincipal: TLabel;
    svgUserAvatar: TSVGIconImage;
    pnlLateralEsquerda: TPanel;
    pnlAreaTrabalho: TPanel;
    svgNotificacao: TSVGIconImage;
    svgAdicionar: TSVGIconImage;
    procedure svgUserAvatarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WorkArea: TWorkArea;

implementation

uses
  user_menu;
{$R *.dfm}

procedure TWorkArea.svgUserAvatarClick(Sender: TObject);
begin
  TUserMenu.Show;
end;

end.
