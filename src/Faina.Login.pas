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
  Vcl.StdCtrls,
  Data.DB,
  base_form_view,
  user_controller;

type
  TLogin = class(TBaseFormView)
    pnlCenter: TPanel;
    imgLogo: TImage;
    lbUser: TLabel;
    lbPassword: TLabel;
    pnlTop: TPanel;
    pnlButtons: TPanel;
    btnConfirm: TButton;
    btnCancel: TButton;
    estPassword: TEdit;
    edtUser: TEdit;
    procedure btnConfirmClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

{ TLogin }

procedure TLogin.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TLogin.btnConfirmClick(Sender: TObject);
begin
  Close;
  Exit;

  // Desenvolver autenticação
  with UserController, User.Query, User.Table do
  begin
    Clear;
    Add('login', edtUser.Text);
    Add('password', estPassword.Text);
    Read;
    if tblUser.IsEmpty then
      raise Exception.Create('Usuário ou senha inválidos!');
  end;
end;

procedure TLogin.FormShow(Sender: TObject);
begin
  edtUser.SetFocus;
end;

end.
