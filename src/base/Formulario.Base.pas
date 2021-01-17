// Daniel Araujo - 15/01/2021
unit Formulario.Base;

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

  Faina.Escuro;

type
  TFormularioBase = class(TForm)
  private
    { Private declarations }
    FEscuro: TEscuro;
  public
    { Public declarations }
    destructor Destroy; override;
    procedure ShowModal(AParent: TForm); reintroduce; overload;
    procedure ShowIn(AParent: TControl; Align: TAlign = TAlign.alNone; Anchors: TAnchors = []);

    function Principal: TFormularioBase;
    function AreaTrabalho: TPanel;
  end;

var
  FormularioBase: TFormularioBase;

implementation

uses
  Faina.Principal;

{$R *.dfm}

{ TFormularioBase }

destructor TFormularioBase.Destroy;
begin
  if Assigned(FEscuro) then
    FreeAndNil(FEscuro);
  inherited;
end;

function TFormularioBase.Principal: TFormularioBase;
begin
  Result := Faina.Principal.Principal;
end;

function TFormularioBase.AreaTrabalho: TPanel;
begin
  Result := TPrincipal(Principal).pnlAreaTrabalho;
end;

procedure TFormularioBase.ShowIn(AParent: TControl; Align: TAlign = TAlign.alNone; Anchors: TAnchors = []);
begin
  Parent       := TWinControl(AParent);
  Self.Align   := Align;
  Self.Anchors := Anchors;
  BorderStyle  := bsNone;
  Position     := poDesigned;
  SetBounds((AParent.Width div 2) - (Width div 2), (AParent.Height div 2) - (Height div 2), Width, Height);
  Show;
end;

procedure TFormularioBase.ShowModal(AParent: TForm);
begin
  if not Assigned(FEscuro) then
    FEscuro := TEscuro.Create(Self, AParent);
end;

end.
