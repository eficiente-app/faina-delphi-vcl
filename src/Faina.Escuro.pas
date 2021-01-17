// Eduardo - 15/01/2021
unit Faina.Escuro;

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
  Vcl.Dialogs;

type
  TEscuro = class(TForm)
  private
    FInstancia: TForm;
    FOnClose: TCloseEvent;
    procedure FechaJanela(Sender: TObject; var Action: TCloseAction);
    procedure EscuroOnClick(Sender: TObject);
    procedure ConfigurarCLose(AForm: TForm);
  protected
    constructor Create(AOwner: TComponent); reintroduce; overload;
  public
    constructor Create(AOwner, AParent: TForm); reintroduce; overload;
    class procedure Novo(AFundo: TForm; AJanela: TFormClass);
    procedure ShowIn(AParent: TForm);
  end;

implementation

uses
  Formulario.Base;

{ TEscuro }

constructor TEscuro.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  AlphaBlend      := True;
  AlphaBlendValue := 100;
  Color           := clBlack;
  Caption         := 'Escuro';
  OldCreateOrder  := False;
  Anchors         := [akLeft, akTop, akRight, akBottom];
  BorderStyle     := bsNone;
  OnClick         := EscuroOnClick;
end;

constructor TEscuro.Create(AOwner, AParent: TForm);
begin
  Create(AOwner);
  ShowIn(AParent);
  ConfigurarCLose(AOwner);
  TFormularioBase(AOwner).ShowIn(AParent);
end;

class procedure TEscuro.Novo(AFundo: TForm; AJanela: TFormClass);
begin
  with TEscuro.Create(AFundo) do
  begin
    ShowIn(AFundo);
    FInstancia := AJanela.Create(AFundo);
    ConfigurarCLose(FInstancia);
    TFormularioBase(FInstancia).ShowIn(AFundo);
  end;
end;

procedure TEscuro.ConfigurarCLose(AForm: TForm);
begin
  // Guarda o evento Close do formulário, e sobrescreve para poder fechar o form escuro ao fechar o formulario exibido
  if Assigned(AForm.OnClose) then
    FOnClose := AForm.OnClose;
  AForm.OnClose := FechaJanela;
end;

procedure TEscuro.ShowIn(AParent: TForm);
begin
  Parent := AParent;
  SetBounds(0, 0, AParent.Width, AParent.Height);
  Show;
end;

procedure TEscuro.FechaJanela(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FOnClose) then
    FOnClose(Sender, Action);

  Close;
end;

procedure TEscuro.EscuroOnClick(Sender: TObject);
begin
  TForm(Owner).Close;
end;

end.
