// Daniel Araujo - 15/01/2021
unit base_form;

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
  Faina.Shadow;

type
  TBaseForm = class(TForm)
  private
    { Private declarations }
    FShadow: TShadow;
  protected
    function CloseWithEsc(IsEsc: Boolean): Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
    CloseEsc: Boolean;
    constructor Create(AOwner: TComponent); reintroduce; override;
    destructor Destroy; override;
    procedure ShowModal(AParent: TForm); reintroduce; overload; dynamic;
    procedure ShowIn(AParent: TControl; Align: TAlign = TAlign.alNone; Anchors: TAnchors = []); dynamic;

    class function Main: TBaseForm;
    class function WorkSpace: TBaseForm;
    class function ClientArea: TPanel;
  end;

implementation

uses
  Faina.Main;

{$R *.dfm}

{ TFormularioBase }

class function TBaseForm.Main: TBaseForm;
begin
  Result := TBaseForm(Main);
end;

class function TBaseForm.ClientArea: TPanel;
begin
  Result := TMain(Main).pnlClientArea;
end;

class function TBaseForm.WorkSpace: TBaseForm;
begin
  Result := TMain(Main).WorkArea;
end;

constructor TBaseForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  KeyPreview := True;
  CloseEsc   := False;
end;

destructor TBaseForm.Destroy;
begin
  if Assigned(FShadow) then
    FreeAndNil(FShadow);
  inherited;
end;

procedure TBaseForm.ShowIn(AParent: TControl; Align: TAlign = TAlign.alNone; Anchors: TAnchors = []);
begin
  Parent       := TWinControl(AParent);
  Self.Align   := Align;
  Self.Anchors := Anchors;
  BorderStyle  := bsNone;
  Position     := poDesigned;

  if Align = TAlign.alNone then
    SetBounds((AParent.Width div 2) - (Width div 2), (AParent.Height div 2) - (Height div 2), Width, Height);

  Show;
end;

procedure TBaseForm.ShowModal(AParent: TForm);
begin
  if not Assigned(FShadow) then
    FShadow := TShadow.Create(Self, AParent);
end;

procedure TBaseForm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if CloseWithEsc(Key = VK_ESCAPE) then
    Key := 0;

  inherited;
end;

function TBaseForm.CloseWithEsc(IsEsc: Boolean): Boolean;
begin
  Result := CloseEsc and IsEsc;
  if Result then
    Close;
end;

end.
