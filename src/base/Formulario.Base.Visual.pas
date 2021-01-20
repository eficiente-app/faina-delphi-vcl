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
  Vcl.ExtCtrls, Vcl.StdCtrls, System.SysUtils;

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
    FRedimensionar: Boolean;
    function GetBorderSize: TRect;
    function GetHitTest(P: TPoint): Integer;
    function NormalizePoint(P: TPoint): TPoint;
  protected
    FSystemButtons: TSysButtons;
    procedure WmNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  public
    property Redimensionar: Boolean read FRedimensionar write FRedimensionar;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SystemButtons: TSysButtons read FSystemButtons;
    property ControleForm: Boolean read FControleForm write FControleForm;
  end;

implementation

uses
  System.Types,
  Vcl.Themes;

{$R *.dfm}

{ TFormularioPrincipalBase }

constructor TFormularioBaseVisual.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRedimensionar := False;
  FControleForm  := False;
  lblTitleForm.Caption := Self.Caption;

  FSystemButtons := TSysButtons.Create(pnlTitleBar);
  FSystemButtons.Form := Self;
  FSystemButtons.Visible := False;
end;

destructor TFormularioBaseVisual.Destroy;
begin
  inherited;
end;

procedure TFormularioBaseVisual.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  SetWindowLong(Handle ,GWL_STYLE ,WS_CLIPCHILDREN or WS_OVERLAPPEDWINDOW or WS_SIZEBOX);
  Self.BorderStyle := bsNone;
end;

procedure TFormularioBaseVisual.WmNCCalcSize(var Msg: TWMNCCalcSize);
begin
  Msg.Result := 0;
end;

procedure TFormularioBaseVisual.MouseDownMovimentarFormulario(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if (Button = mbLeft) and FControleForm then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;


procedure TFormularioBaseVisual.WMNCHitTest(var Message: TWMNCHitTest);
var
  P: TPoint;
begin
  P := NormalizePoint(Point(Message.XPos, Message.YPos));
  Message.Result := GetHitTest(P);
end;

function TFormularioBaseVisual.GetBorderSize: TRect;
var
  Size: TSize;
  Details: TThemedElementDetails;
  Detail: TThemedWindow;
begin
  Result := Rect(0, 0, 0, 0);
//  if Self.BorderStyle = bsNone then
//    Exit;
  // FStretchedCaptionInc := 0;
  if not StyleServices.Available then Exit;
  {caption height}
  if (Self.BorderStyle <> bsToolWindow) and (Self.BorderStyle <> bsSizeToolWin) then
    Detail := twCaptionActive
  else
    Detail := twSmallCaptionActive;
  Details := StyleServices.GetElementDetails(Detail);
  StyleServices.GetElementSize(0, Details, esActual, Size);
  Result.Top := Size.cy;
  if (Screen.PixelsPerInch > 96) or CheckPerMonitorV2SupportForWindow(Handle) then
  begin
    Result.Top := MulDiv(Result.Top, Self.CurrentPPI, 96);
    //FStretchedCaptionInc := Result.Top - Size.cy;
  end;

  {left border width}
  if (Self.BorderStyle <> bsToolWindow) and (Self.BorderStyle <> bsSizeToolWin) then
    Detail := twFrameLeftActive
  else
    Detail := twSmallFrameLeftActive;

  Details := StyleServices.GetElementDetails(Detail);
  StyleServices.GetElementSize(0, Details, esActual, Size);
  Result.Left := Size.cx;
  {right border width}
  if (Self.BorderStyle <> bsToolWindow) and
     (Self.BorderStyle <> bsSizeToolWin) then
    Detail := twFrameRightActive
  else
    Detail := twSmallFrameRightActive;
  Details := StyleServices.GetElementDetails(Detail);
  StyleServices.GetElementSize(0, Details, esActual, Size);
  Result.Right := Size.cx;
  {bottom border height}
  if (Self.BorderStyle <> bsToolWindow) and
     (Self.BorderStyle <> bsSizeToolWin) then
    Detail := twFrameBottomActive
  else
    Detail := twSmallFrameBottomActive;
  Details := StyleServices.GetElementDetails(Detail);
  StyleServices.GetElementSize(0, Details, esActual, Size);
  Result.Bottom := Size.cy;
end;

function TFormularioBaseVisual.GetHitTest(P: TPoint): Integer;
var
  FBorderSize: TRect;
  FTopLeftRect,  FTopRightRect,
  FBottomLeftRect, FBottomRightRect,
  FTopRect, FLeftRect, FRightRect, FBottomRect, FHitCaptionRect: TRect;
begin
  Result := HTCLIENT;
  if not FRedimensionar then
    Exit;

  FBorderSize := GetBorderSize;
  FHitCaptionRect := pnlTitleBar.ClientRect;
  FHitCaptionRect.Top := FBorderSize.Left;
  FBorderSize.Top := FHitCaptionRect.Top;

  {check window state}
  if (Self.WindowState = wsMaximized) or (Self.WindowState = wsMinimized) then
    Exit;

  {check border}
  if (Self.BorderStyle = bsDialog) or (Self.BorderStyle = bsSingle) or (Self.BorderStyle = bsToolWindow) then
  begin
    if Rect(FBorderSize.Left, FBorderSize.Top, Width - FBorderSize.Right, Height - FBorderSize.Bottom).Contains(P) then
      Exit(HTCLIENT)
    else
      Exit(HTBORDER);
  end;

  FTopLeftRect := Rect(0, 0, FBorderSize.Left, FBorderSize.Top);
  FTopRightRect := Rect(Width - FBorderSize.Right, 0, Width, FBorderSize.Top);
  FBottomLeftRect := Rect(0, Height - FBorderSize.Bottom, FBorderSize.Left, Height);
  FBottomRightRect := Rect(Width - FBorderSize.Right, Height - FBorderSize.Bottom, Width, Height);
  FTopRect := Rect(FTopLeftRect.Right, 0, FTopRightRect.Left, FBorderSize.Top);
  FLeftRect := Rect(0, FTopLeftRect.Bottom, FBorderSize.Left, FBottomLeftRect.Top);
  FRightRect := Rect(Width - FBorderSize.Right, FTopRightRect.Bottom, Width, FBottomRightRect.Top);
  FBottomRect := Rect(FBottomLeftRect.Right, Height - FBorderSize.Bottom, FBottomRightRect.Left, Height);

  if FTopLeftRect.Contains(P) then
    Result := HTTOPLEFT
  else if FTopRightRect.Contains(P) then
    Result := HTTOPRIGHT
  else if FBottomLeftRect.Contains(P) then
    Result := HTBOTTOMLEFT
   else if FBottomRightRect.Contains(P) then
    Result := HTBOTTOMRIGHT
  else if FLeftRect.Contains(P) then
    Result := HTLEFT
  else if FRightRect.Contains(P) then
    Result := HTRIGHT
  else if FBottomRect.Contains(P) then
    Result := HTBOTTOM
  else if FTopRect.Contains(P) then
    Result := HTTOP;
end;

function TFormularioBaseVisual.NormalizePoint(P: TPoint): TPoint;
var
  WindowPos, ClientPos: TPoint;
  HandleParent: HWnd;
begin
  if (Self.FormStyle = fsMDIChild) or (Self.Parent <> nil) then
  begin
    HandleParent := GetParent(Self.Handle);
    WindowPos := Point(Left, Top);
    Winapi.Windows.ClientToScreen(HandleParent, WindowPos);
    ClientPos := Point(0, 0);
    Winapi.Windows.ClientToScreen(Handle, ClientPos);
    Result := P;
    Winapi.Windows.ScreenToClient(Handle, Result);
    Inc(Result.X, ClientPos.X - WindowPos.X);
    Inc(Result.Y, ClientPos.Y - WindowPos.Y);
  end
  else
  begin
    WindowPos := Point(Left, Top);
    ClientPos := Point(0, 0);
    Winapi.Windows.ClientToScreen(Handle, ClientPos);
    Result := P;
    Winapi.Windows.ScreenToClient(Handle, Result);
    Inc(Result.X, ClientPos.X - WindowPos.X);
    Inc(Result.Y, ClientPos.Y - WindowPos.Y);
  end;
end;

end.
