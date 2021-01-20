// Daniel Araujo - 18/01/2021
unit SysButtons;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Types,

  Winapi.GDIPAPI,
  Winapi.GDIPOBJ,
  Winapi.GDIPUTIL,
  Winapi.Messages,
  Winapi.Windows,

  Vcl.Controls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.GraphUtil;

type

  TSysButtons = class(TCustomControl)
  private type

    TTypeButton = (bClose, bMaximize, bMinimize, bHelp, bNone);
    TTypeButtons = set of TTypeButton;

    THitResult = record
      Button: TTypeButton;
    end;

    TCustomBrush = object
    private
      FColor: TColor;
      FAlpha: Integer;
      procedure SetAlpha(const Value: Integer);
      procedure SetColor(const Value: TColor);
    public
      constructor Create;
      procedure CopyFrom(const Source: TCustomBrush);
      property Color: TColor read FColor write SetColor;
      property Alpha: Integer read FAlpha write SetAlpha;
    end;

    TSysButton = object
    private
      FBrush: TCustomBrush;
      FPen  : TCustomBrush;
      FRect : TRect;
    public
      property Brush: TCustomBrush read FBrush write FBrush;
      property Pen  : TCustomBrush read FPen   write FPen;
      property Rect : TRect        read FRect  write FRect;
    end;

  private
    FForm: TForm;
    FCanvasBitmap: TBitmap;
    FDrawingCanvas : Boolean;
    FClose: TSysButton;    // biSystemMenu
    FMinimize: TSysButton; // biMinimize
    FMaximize: TSysButton; // biMaximize
    FHelp: TSysButton;     // biHelp
    FMouseDown: Boolean;
    FMouseDownHit: THitResult;
    FButtonsEnabled: TTypeButtons;
    FButtonWidth: Integer;
    procedure CalcButtons;
    function GetMousePoint: TPoint;
    function GetPenColor(tb:  TTypeButton): TGPColor;
    function GetBrushColor(tb: TTypeButton): TGPColor;
    function HitTest(pt: TPoint): THitResult;
    procedure DoClick;
    procedure SetButtonsEnabled(const Value: TTypeButtons);
  protected
    procedure DrawCanvas; virtual;
    procedure PaintWindow(DC: HDC); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMERASEBKGND(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;

    // Eventos do Mouse
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; x, y: Integer); override;
    procedure MouseMove(Shift: TShiftState; x, y: Integer); override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Form: TForm read FForm write FForm;
    property ButtonWidth: Integer read FButtonWidth write FButtonWidth;
    property Buttons: TTypeButtons read FButtonsEnabled write SetButtonsEnabled;
  published
    property Color;
  end;

implementation

{ TSysButtons }

procedure TSysButtons.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Repaint;
end;

procedure TSysButtons.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Repaint;
end;

constructor TSysButtons.Create(AOwner: TComponent);
begin
  inherited;
  Parent          := TWinControl(AOwner);
  ControlStyle    := ControlStyle + [csReplicatable, csCaptureMouse];
  Color           := clRed;
  Align           := alRight;
  FButtonWidth    := 45;
  FCanvasBitmap   := TBitmap.Create;
  FDrawingCanvas  := False;
  ParentColor     := True;
  Buttons         := [bClose, bMaximize, bMinimize, bHelp];

  CalcButtons;
end;

destructor TSysButtons.Destroy;
begin
  FreeAndNil(FCanvasBitmap);
  inherited;
end;

procedure TSysButtons.DoClick;
begin
  if not FMouseDown then
    Exit;
  if not Assigned(FForm) then
    Exit;

  case FMouseDownHit.Button of
    bClose   : FForm.Close;
    bMaximize:
    begin
      if FForm.WindowState = wsMaximized then
        FForm.WindowState := wsNormal
      else
        FForm.WindowState := wsMaximized;
    end;
    bMinimize: FForm.WindowState := wsMinimized;
    bHelp    : ;
  end;
end;

function MakeGDIPColor(C: TColor; Alpha: Byte): Cardinal;
var
  tmpRGB : TColorRef;
begin
  tmpRGB := ColorToRGB(C);

  Result := ((DWORD(GetBValue(tmpRGB)) shl  BlueShift) or
             (DWORD(GetGValue(tmpRGB)) shl GreenShift) or
             (DWORD(GetRValue(tmpRGB)) shl   RedShift) or
             (DWORD(Alpha) shl AlphaShift));
end;

procedure TSysButtons.DrawCanvas;
var
  SysButtonsCanvas : TGPGraphics;
  Brush: TGPSolidBrush;
  Pen  : TGPPen;
  Font : TGPFont;
  GPRFont: TGPRectF;
  sf: TGPStringFormat;

  R : TRect;
  RD: TRect;
  ws: TWindowState;
begin
  if not Assigned(FCanvasBitmap) then
    Exit;

  if FDrawingCanvas then
    Exit;

  FDrawingCanvas:= True;
  try
    FCanvasBitmap.Width:= ClientWidth;
    FCanvasBitmap.Height:= ClientHeight;

    CalcButtons;
    SysButtonsCanvas:= TGPGraphics.Create(FCanvasBitmap.Canvas.Handle);
    Brush := TGPSolidBrush.Create(GetBrushColor(bNone));
    Pen   := TGPPen.Create(GetPenColor(bNone), 1);
    try
      // Modo de Suavização
      SysButtonsCanvas.SetSmoothingMode(SmoothingModeDefault);
      // Fundo
      SysButtonsCanvas.FillRectangle(Brush, -1.0, -1.0, ClientWidth + 1, ClientHeight + 1);

      // Botão Fechar
      if bClose in FButtonsEnabled then
      begin
        R := FClose.Rect;
        RD.Left   := R.Left  + ((R.Width  - 10) div 2);
        RD.Top    := R.Top   + ((R.Height - 10) div 2);
        RD.Right  := RD.Left + 10;
        RD.Bottom := RD.Top  + 10;
        // Configura Cores
        Brush.SetColor(GetBrushColor(bClose));
        Pen.SetColor(GetPenColor(bClose));
        // Pinta o Fundo
        SysButtonsCanvas.FillRectangle(Brush, MakeRect(R));
        // Desenha o " X "
        SysButtonsCanvas.DrawLine(Pen, RD.Left, RD.Top, RD.Right, RD.Bottom);
        SysButtonsCanvas.DrawLine(Pen, RD.Left, RD.Bottom, RD.Right, RD.Top);
        Pen.SetWidth(1);
      end;

      // Botão Maximizar
      if bMaximize in FButtonsEnabled then
      begin
        R := FMaximize.Rect;
        // Configura Cores
        Brush.SetColor(GetBrushColor(bMaximize));
        Pen.SetColor(GetPenColor(bMaximize));
        // Pinta o Fundo
        SysButtonsCanvas.FillRectangle(Brush, MakeRect(R));

        if Assigned(FForm) then
          ws := FForm.WindowState
        else
          ws := wsMaximized;

        // Desenha um Quadrado Simples
        if ws in [wsNormal, wsMinimized] then
        begin
          RD.Left   := R.Left  + ((R.Width  - 10) div 2);
          RD.Top    := R.Top   + ((R.Height - 10) div 2);
          RD.Right  := RD.Left + 10;
          RD.Bottom := RD.Top  + 10;
          SysButtonsCanvas.FillRectangle(Brush, MakeRect(RD));
          SysButtonsCanvas.DrawRectangle(Pen, MakeRect(RD));
        end
        else // Desenha um Quadrado Duplo
        begin
          RD.Left   := R.Left  + ((R.Width  - 8) div 2) + 1;
          RD.Top    := R.Top   + ((R.Height - 8) div 2) - 1;
          RD.Right  := RD.Left + 8;
          RD.Bottom := RD.Top  + 8;
          SysButtonsCanvas.FillRectangle(Brush, MakeRect(RD));
          SysButtonsCanvas.DrawRectangle(Pen, MakeRect(RD));
          RD.Left   := R.Left  + ((R.Width  - 8) div 2) - 1;
          RD.Top    := R.Top   + ((R.Height - 8) div 2) + 1;
          RD.Right  := RD.Left + 8;
          RD.Bottom := RD.Top  + 8;
          SysButtonsCanvas.FillRectangle(Brush, MakeRect(RD));
          SysButtonsCanvas.DrawRectangle(Pen, MakeRect(RD));
        end;
      end;

      // Botão Minimizar
      if bMinimize in FButtonsEnabled then
      begin
        R := FMinimize.Rect;
        // Configura Cores
        Brush.SetColor(GetBrushColor(bMinimize));
        Pen.SetColor(GetPenColor(bMinimize));
        RD.Left   := R.Left  + ((R.Width  - 10) div 2);
        RD.Top    := R.Top   + (R.Height div 2);
        RD.Right  := RD.Left + 10;
        RD.Bottom := RD.Top;
        // Fundo Botão
        SysButtonsCanvas.FillRectangle(Brush, MakeRect(R));
        // Desenha o " - "
        SysButtonsCanvas.DrawLine(Pen, RD.Left, RD.Top, RD.Right, RD.Top);
      end;

      // Botão Help
      if bHelp in FButtonsEnabled then
      begin
        R := FHelp.Rect;
        // Configura Cores
        Brush.SetColor(GetBrushColor(bHelp));
        // Fundo Botão
        SysButtonsCanvas.FillRectangle(Brush, MakeRect(R));
        // Desenha o " ? "
        Font:= TGPFont.Create('Tahoma', 10{, FontStyleBold});
        sf  := TGPStringFormat.Create;
        try
          SysButtonsCanvas.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
          SysButtonsCanvas.MeasureString('?', 1, Font, MakeRect(0.0, 0.0, 100, 100), GPRFont);
          GPRFont.X := R.Left + ((R.Width  - GPRFont.Width)  / 2);
          GPRFont.Y := R.Top  + ((R.Height - GPRFont.Height) / 2);
          Brush.SetColor(GetPenColor(bHelp));
          SysButtonsCanvas.DrawString('?', 1, Font, GPRFont, sf, Brush);
        finally
          FreeAndNil(sf);
          FreeAndNil(Font);
        end;
      end;

      {$REGION ' ---> Desenha o bitmap do Componente '}
      Winapi.Windows.BitBlt(
        Self.Canvas.Handle,
        0 { Left },
        0 { Top },
        FCanvasBitmap.Width { Largura},
        FCanvasBitmap.Height { Altura },
        FCanvasBitmap.Canvas.Handle,
        0,
        0,
        SRCCOPY
      );
      {$ENDREGION}

    finally
      FreeAndNil(SysButtonsCanvas);
    end;
  finally
    FDrawingCanvas:= False;
  end;
end;

function TSysButtons.GetMousePoint: TPoint;
begin
  // Obtém a Posição do ponteiro do mouse
  GetCursorPos(Result);
  // Obtém a Posição do ponteiro do mouse em relação ao componente
  Result := ScreenToClient(Result);
end;

function TSysButtons.GetBrushColor(tb: TTypeButton): TGPColor;
var
  H: Word;
  L: Word;
  S: Word;
  HitResult: THitResult;
begin
  Result := MakeGDIPColor(Self.Color, 255);
  HitResult := HitTest(GetMousePoint);
  if (HitResult.Button = bClose) and (HitResult.Button = tb) then
  begin
    if FMouseDown then
      Result := MakeGDIPColor(RGB(232, 17, 35), 150)
    else
      Result := MakeGDIPColor(RGB(232, 17, 35), 255)
  end
  else
  if (HitResult.Button = tb) and (HitResult.Button <> bNone) then
  begin
    ColorRGBToHLS(Self.Color, H, L, S);
    if FMouseDown then
      Result := MakeGDIPColor(ColorHLSToRGB(H, L + 15, S), 255)
    else
      Result := MakeGDIPColor(ColorHLSToRGB(H, L + 10, S), 255);
  end;
end;

function TSysButtons.GetPenColor(tb:  TTypeButton): TGPColor;
begin
  Result  := MakeGDIPColor(clWhite, 175);
  if HitTest(GetMousePoint).Button = tb then
    Result  := aclWhite;
end;

function TSysButtons.HitTest(pt: TPoint): THitResult;
begin
  if PtInRect(FClose.Rect, pt) then
    Result.Button := bClose
  else
  if PtInRect(FMaximize.Rect, pt) then
    Result.Button := bMaximize
  else
  if PtInRect(FMinimize.Rect, pt) then
    Result.Button := bMinimize
  else
  if PtInRect(FHelp.Rect, pt) then
    Result.Button := bHelp
  else
    Result.Button := bNone;
end;

procedure TSysButtons.CalcButtons;
var
  CR: TRect;
  rectButton: TRect;
begin
  CR:= ClientRect;
  rectButton.Top    := 0;
  rectButton.Bottom := CR.Bottom;

  // Close
  rectButton.Left    := CR.Right - FButtonWidth;
  rectButton.Right   := CR.Right;
  FClose.Brush.Color := Self.Color;
  FClose.Brush.Alpha := 255;
  FClose.Pen.Color   := clWhite;
  FClose.Pen.Alpha   := 255;
  FClose.Rect        := rectButton;

  // Restore/Maximizar
  rectButton.Left   := rectButton.Left - FButtonWidth;
  rectButton.Right  := rectButton.Right - FButtonWidth;
  FMaximize.Brush.Color := Self.Color;
  FMaximize.Brush.Alpha := 255;
  FMaximize.Pen.Color   := clWhite;
  FMaximize.Pen.Alpha   := 255;
  FMaximize.Rect        := rectButton;


  // Minimizar
  rectButton.Left   := rectButton.Left - FButtonWidth;
  rectButton.Right  := rectButton.Right - FButtonWidth;
  FMinimize.Brush.Color := Self.Color;
  FMinimize.Brush.Alpha := 255;
  FMinimize.Pen.Color   := clWhite;
  FMinimize.Pen.Alpha   := 255;
  FMinimize.Rect        := rectButton;

  // Help
  rectButton.Left   := rectButton.Left - FButtonWidth;
  rectButton.Right  := rectButton.Right - FButtonWidth;
  FHelp.Brush.Color := Self.Color;
  FHelp.Brush.Alpha := 255;
  FHelp.Pen.Color   := clWhite;
  FHelp.Pen.Alpha   := 255;
  FHelp.Rect        := rectButton;
end;

procedure TSysButtons.MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: Integer);
begin
  FMouseDownHit := HitTest(Point(X, Y));
  FMouseDown    := Button = mbLeft;
  inherited;
  Repaint;
end;

procedure TSysButtons.MouseMove(Shift: TShiftState; x, y: Integer);
begin
  inherited;
  Repaint;
end;

procedure TSysButtons.MouseUp(Button: TMouseButton; Shift: TShiftState; x, y: Integer);
begin
  if FMouseDownHit.Button = HitTest(Point(X, Y)).Button then
    DoClick;
  FMouseDown := False;
  inherited;
  Repaint;
end;

procedure TSysButtons.PaintWindow(DC: HDC);
begin
  Canvas.Lock;
  try
    Canvas.Handle := DC;
    try
      DrawCanvas;
    finally
      Canvas.Handle := 0;
    end;
  finally
    Canvas.Unlock;
  end;
end;

procedure TSysButtons.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  CalcButtons;
end;

procedure TSysButtons.SetButtonsEnabled(const Value: TTypeButtons);
var
  tb: TTypeButton;
  iQtd: Integer;
begin
  FButtonsEnabled := Value;
  iQtd := 0;
  for tb in FButtonsEnabled do
    Inc(iQtd);

  Width := (iQtd * FButtonWidth);
end;

procedure TSysButtons.WMERASEBKGND(var Message: TWMEraseBkgnd);
begin
  Message.Result:=1;
end;

procedure TSysButtons.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TSysButtons.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if not(csLoading in ComponentState) then
    DrawCanvas;
end;

{ TSysButtons.TCustomBrush }

constructor TSysButtons.TCustomBrush.Create;
begin
  FColor := clWhite;
  FAlpha := 255;
end;

procedure TSysButtons.TCustomBrush.CopyFrom(const Source: TCustomBrush);
begin
  FColor := Source.Color;
  FAlpha := Source.Alpha;
end;

procedure TSysButtons.TCustomBrush.SetAlpha(const Value: Integer);
begin
  FAlpha := Value;
end;

procedure TSysButtons.TCustomBrush.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

end.
