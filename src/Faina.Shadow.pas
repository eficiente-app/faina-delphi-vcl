// Eduardo - 15/01/2021
unit Faina.Shadow;

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
  TShadow = class(TForm)
  private
    FInstance: TForm;
    FOnClose: TCloseEvent;
    procedure CloseWindow(Sender: TObject; var Action: TCloseAction);
    procedure ShadowOnClick(Sender: TObject);
    procedure ConfigClose(AForm: TForm);
  protected
    constructor Create(AOwner: TComponent); reintroduce; overload;
  public
    constructor Create(AOwner, AParent: TForm); reintroduce; overload;
    class procedure New(AFundo: TForm; AWindow: TFormClass);
    procedure ShowIn(AParent: TForm);
  end;

implementation

uses
  base_form;

{ TShadow }

constructor TShadow.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  AlphaBlend      := True;
  AlphaBlendValue := 100;
  Color           := clBlack;
  Caption         := 'Escuro';
  OldCreateOrder  := False;
  Anchors         := [akLeft, akTop, akRight, akBottom];
  BorderStyle     := bsNone;
  OnClick         := ShadowOnClick;
end;

constructor TShadow.Create(AOwner, AParent: TForm);
begin
  Create(AOwner);
  ShowIn(AParent);
  ConfigClose(AOwner);
  TBaseForm(AOwner).ShowIn(AParent);
end;

class procedure TShadow.New(AFundo: TForm; AWindow: TFormClass);
begin
  with TShadow.Create(AFundo) do
  begin
    ShowIn(AFundo);
    FInstance := AWindow.Create(AFundo);
    ConfigClose(FInstance);
    TBaseForm(FInstance).ShowIn(AFundo);
  end;
end;

procedure TShadow.ConfigClose(AForm: TForm);
begin
  // Guarda o evento Close do formulário, e sobrescreve para poder fechar o form escuro ao fechar o formulario exibido
  if Assigned(AForm.OnClose) then
    FOnClose := AForm.OnClose;
  AForm.OnClose := CloseWindow;
end;

procedure TShadow.ShowIn(AParent: TForm);
begin
  Parent := AParent;
  SetBounds(0, 0, AParent.Width, AParent.Height);
  Show;
end;

procedure TShadow.CloseWindow(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FOnClose) then
    FOnClose(Sender, Action);

  Close;
end;

procedure TShadow.ShadowOnClick(Sender: TObject);
begin
  TForm(Owner).Close;
end;

end.
