// Eduardo - 07/11/2020
unit Faina.Principal;

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
  Vcl.ComCtrls,
  Vcl.Buttons;

type
  TPrincipal = class(TForm)
    pnlTop: TPanel;
    tvwMenu: TTreeView;
    SpeedButton1: TSpeedButton;
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
  Faina.Login;

{$R *.dfm}

procedure TPrincipal.FormShow(Sender: TObject);
begin
  TLogin.New(Self);
end;

end.
