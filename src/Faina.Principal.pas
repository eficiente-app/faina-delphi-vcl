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
    procedure pnlTitleBarDblClick(Sender: TObject);
  private
    { Private declarations }
    FAreaTrabalho: TAreaTrabalho;
  protected
    procedure Resizing(State: TWindowState); override;
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

procedure TPrincipal.pnlTitleBarDblClick(Sender: TObject);
begin
  if WindowState = TWindowState.wsMaximized then
    WindowState := TWindowState.wsNormal
  else
    WindowState := TWindowState.wsMaximized;
end;

procedure TPrincipal.Resizing(State: TWindowState);
  procedure SetM(Mar: TMargins; I: Integer);
  begin
    Mar.Left   := I;
    Mar.Top    := I;
    Mar.Bottom := I;
    Mar.Right  := I;
  end;
begin
  if State = TWindowState.wsMaximized then
    SetM(pnlClientForm.Margins, 8)
  else
    SetM(pnlClientForm.Margins, 1);
  inherited;
end;

end.
