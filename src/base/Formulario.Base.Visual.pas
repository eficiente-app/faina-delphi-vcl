// Daniel Araujo - 18/01/2021
unit Formulario.Base.Visual;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Formulario.Base,
  SysButtons,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type

  TFormularioBaseVisual = class(TFormularioBase)
    pnlClientForm: TPanel;
    pnlTitleBar: TPanel;
    pnlClientArea: TPanel;
    lblTitleForm: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure MouseDownMovimentarFormulario(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private type
    TBorda   = (bLeft, bTop, bRight, bBottom, bBottomLeft, bBottomRight);
  private
    FControleForm: Boolean;
    FMouseMove: TMouseMoveEvent;
    FMouseDown: TMouseEvent;
    function SetMouse(ABorda: TBorda): TCursor;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  protected
    FSystemButtons: TSysButtons;
    procedure WmNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
  public
    constructor Create(AOwner: TComponent); override;
    property SystemButtons: TSysButtons read FSystemButtons;
    property ControleForm: Boolean read FControleForm write FControleForm;
  end;

implementation

{$R *.dfm}

{ TFormularioPrincipalBase }

constructor TFormularioBaseVisual.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  lblTitleForm.Caption := Self.Caption;

  FControleForm := True;

  FMouseMove := Self.OnMouseMove;
  FMouseDown := Self.OnMouseDown;

  Self.OnMouseMove := FormMouseMove;
  Self.OnMouseDown := FormMouseDown;

  FSystemButtons := TSysButtons.Create(pnlTitleBar);
  FSystemButtons.Form := Self;
  FSystemButtons.Visible := False;
end;

procedure TFormularioBaseVisual.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  SetWindowLong(Handle ,GWL_STYLE ,WS_CLIPCHILDREN or WS_OVERLAPPEDWINDOW);
  Self.BorderStyle := bsNone;
end;

function TFormularioBaseVisual.SetMouse(ABorda: TBorda): TCursor;
begin
  Result := crDefault;
  case ABorda of
    bLeft, bRight : Result := crSizeWE;
    bTop, bBottom : Result := crSizeNS;
    bBottomLeft   : Result := crSizeNESW;
    bBottomRight  : Result := crSizeNWSE;
  end;
end;

procedure TFormularioBaseVisual.WmNCCalcSize(var Msg: TWMNCCalcSize);
begin
  Msg.Result := 0;
end;

procedure TFormularioBaseVisual.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FMouseDown) then
    FMouseDown(Sender, Button, Shift, X, Y);
  if (Button = mbLeft) and FControleForm then
  begin
    ReleaseCapture;

    {Left Bottom}
    if(((X >= 0)and(X <= 8)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOMLEFT, 0);
      Exit;
    end;

    {Right Bottom}
    if(((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOMRIGHT, 0);
      Exit;
    end;

    {Left}
    if((X >= 0)and(X <= 8))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_LEFT, 0);
    end;

    {Right}
    if((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_RIGHT, 0);
    end;

    {Bottom}
    if((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOM, 0);
    end;

    {Top}
    if((Y >= 0)and(Y <= 10))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_TOP, 0);
    end;
  end;
end;

procedure TFormularioBaseVisual.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FMouseMove) then
    FMouseMove(Sender, Shift, X, Y);

  if FControleForm then
  begin
    {Left}
    if((X >= 0)and(X <= 8))then
    begin
      Self.Cursor := SetMouse(bLeft);
    end;

    {Right}
    if((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth))then
    begin
      Self.Cursor := SetMouse(bRight);
    end;

    {Bottom}
    if((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight))then
    begin
      Self.Cursor := SetMouse(bBottom);
    end;

    {Top}
    if((Y >= 0)and(Y <= 10))then
    begin
      Self.Cursor := SetMouse(bTop);
    end;

    {Left Bottom}
    if(((X >= 0)and(X <= 8)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      Self.Cursor := SetMouse(bBottomLeft);
    end;

    {Right Bottom}
    if(((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      Self.Cursor := SetMouse(bBottomRight);
    end;
  end;
end;

procedure TFormularioBaseVisual.MouseDownMovimentarFormulario(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

end.
