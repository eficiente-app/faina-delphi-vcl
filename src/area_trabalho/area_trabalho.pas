unit area_trabalho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Formulario.Base.Visual, Vcl.StdCtrls,
  Vcl.ExtCtrls, SVGIconImage;

type
  TAreaTrabalho = class(TFormularioBaseVisual)
    pnlTop: TPanel;
    pnlTitle: TPanel;
    lblTitlePrincipal: TLabel;
    svgUserAvatar: TSVGIconImage;
    pnlLateralEsquerda: TPanel;
    pnlAreaTrabalho: TPanel;
    procedure svgUserAvatarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AreaTrabalho: TAreaTrabalho;

implementation

uses
  Menu.Usuario;
{$R *.dfm}

procedure TAreaTrabalho.svgUserAvatarClick(Sender: TObject);
begin
  TMenuUsuario.Exibir;
end;

end.
