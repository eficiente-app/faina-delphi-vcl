// Eduardo - 07/11/2020
unit Faina.Login;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TLogin = class(TForm)
    pnlCentro: TPanel;
    pnlTop: TPanel;
    pnlBotoes: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    estSenha: TEdit;
    edtUsuario: TEdit;
    imgLogo: TImage;
    lbUsuario: TLabel;
    lbSenha: TLabel;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    class procedure New(AParent: TWinControl);
  end;

implementation

{$R *.dfm}

{ TLogin }

procedure TLogin.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TLogin.btnConfirmarClick(Sender: TObject);
begin
  Close;
end;

procedure TLogin.FormShow(Sender: TObject);
begin
  edtUsuario.SetFocus;
end;

class procedure TLogin.New(AParent: TWinControl);
begin
  with TLogin.Create(AParent) do
  begin
    Parent := AParent;
    SetBounds(AParent.Left, AParent.Top, AParent.Width, AParent.Height);
    Show;
  end;
end;

end.
