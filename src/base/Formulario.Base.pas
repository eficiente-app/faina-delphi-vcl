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
  protected
    function FecharEsc(IsEsc: Boolean): Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
    CloseEsc: Boolean;
    constructor Create(AOwner: TComponent); reintroduce; override;
    destructor Destroy; override;
    procedure ShowModal(AParent: TForm); reintroduce; overload;
    procedure ShowIn(AParent: TControl; Align: TAlign = TAlign.alNone; Anchors: TAnchors = []);

    class function Principal: TFormularioBase;
    class function AreaTrabalho: TFormularioBase;
    class function ClientArea: TPanel;
  end;

implementation

uses
  Faina.Principal;

{$R *.dfm}

{ TFormularioBase }

class function TFormularioBase.Principal: TFormularioBase;
begin
  Result := TFormularioBase(Faina.Principal.Principal);
end;

class function TFormularioBase.ClientArea: TPanel;
begin
  Result := TPrincipal(Principal).pnlClientArea;
end;

class function TFormularioBase.AreaTrabalho: TFormularioBase;
begin
  Result := TPrincipal(Principal).AreaDeTrabalho;
end;

constructor TFormularioBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  KeyPreview := True;
  CloseEsc   := False;
end;

destructor TFormularioBase.Destroy;
begin
  if Assigned(FEscuro) then
    FreeAndNil(FEscuro);
  inherited;
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

procedure TFormularioBase.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if FecharEsc(Key = VK_ESCAPE) then
    Key := 0;

  inherited;
end;

function TFormularioBase.FecharEsc(IsEsc: Boolean): Boolean;
begin
  Result := CloseEsc and IsEsc;
  if Result then
    Close;
end;

end.
