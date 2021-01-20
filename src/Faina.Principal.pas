// Eduardo - 07/11/2020
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
  SVGIconImage,
  SysButtons,
  Formulario.Base.Visual,
  area_trabalho;

type
  TPrincipal = class(TFormularioBaseVisual)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FAreaTrabalho: TAreaTrabalho;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; override;
    property AreaDeTrabalho: TAreaTrabalho read FAreaTrabalho;
  end;

var
  Principal: TPrincipal;

implementation

uses
  Faina.Login;

{$R *.dfm}

constructor TPrincipal.Create(AOwner: TComponent);
begin
  inherited;
  Redimensionar := True;
  ControleForm  := True;
  Caption := 'Faina - Gerencie suas Tarefas';

//  lblTitleForm.Caption   := 'Faina - Gerencie suas Tarefas';
//  pnlTitleBar.Height     := 20;

  SystemButtons.Visible := True;
  SystemButtons.Buttons := [bMinimize, bMaximize, bClose];
  pnlClientForm.AlignWithMargins := True;
end;

procedure TPrincipal.FormShow(Sender: TObject);
begin
  FAreaTrabalho := TAreaTrabalho.Create(Self);
  FAreaTrabalho.ShowIn(pnlClientArea, alClient);
  TLogin.New(pnlClientArea);
end;

end.
