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
    pnlCenter: TPanel;
    pnlTop: TPanel;
    pnlButtons: TPanel;
    btnConfirm: TButton;
    btnCancel: TButton;
    estPassword: TEdit;
    edtUser: TEdit;
    imgLogo: TImage;
    lbUser: TLabel;
    lbPassword: TLabel;
    procedure btnConfirmClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    class procedure New(AParent: TWinControl);
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
end;

procedure TLogin.FormShow(Sender: TObject);
begin
  edtUser.SetFocus;
end;

class procedure TLogin.New(AParent: TWinControl);
begin
  with TLogin.Create(AParent) do
  begin
    Parent := AParent;
    SetBounds(0, 0, AParent.Width, AParent.Height);
    Show;
  end;
end;

end.
