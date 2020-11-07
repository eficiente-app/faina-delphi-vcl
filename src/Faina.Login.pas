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
    Panel1: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    pnlTop: TPanel;
  public
    class function New: Boolean;
  end;

implementation

{$R *.dfm}

{ TLogin }

class function TLogin.New: Boolean;
begin
  with TLogin.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

end.
