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
  public
    class procedure Novo(AFundo: TForm; AJanela: TFormClass);
  end;

implementation

{$R *.dfm}

{ TEscuro }

class procedure TEscuro.Novo(AFundo: TForm; AJanela: TFormClass);
begin
  with TEscuro.Create(AFundo) do
  begin
    Parent := AFundo;
    SetBounds(0, 0, AFundo.Width, AFundo.Height);
    Show;

    FInstancia := AJanela.Create(AFundo);
    with FInstancia do
    begin
      Anchors := [];
      BorderStyle := bsNone;
      Position := poDesigned;
      Parent := AFundo;
      SetBounds((AFundo.Width div 2) - (Width div 2), (AFundo.Height div 2) - (Height div 2), Width, Height);
      if Assigned(OnClose) then
        FOnClose := OnClose;
      OnClose := FechaJanela;
      Show;
    end;
  end;
end;

procedure TEscuro.FechaJanela(Sender: TObject; var Action: TCloseAction);
begin
  Close;
  if Assigned(FOnClose) then
    FOnClose(Sender, Action);
end;

end.
