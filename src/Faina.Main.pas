// Eduardo - 07/11/2020
unit Faina.Main;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.StrUtils,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Vcl.StdCtrls,
  SysButtons,
  Faina.Configuration,
  base_form_view,
  work_area;

type
  TMain = class(TBaseFormView)
    pnlAlertaConexao: TPanel;
    lblAlertaConexao: TLabel;
    tmrAlertaConexao: TTimer;
    procedure FormShow(Sender: TObject);
    procedure pnlTitleBarDblClick(Sender: TObject);
    procedure tmrAlertaConexaoTimer(Sender: TObject);
  private
    { Private declarations }
    FWorkArea: TWorkArea;
  protected
    procedure Resizing(State: TWindowState); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; override;
    property WorkArea: TWorkArea read FWorkArea;
    function SetConnectionAlert(bConectado: Boolean): TMain;
  end;

var
  Main: TMain;

implementation

uses
  Faina.Login;

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  Redimensionar := True;
  ControleForm  := True;
  SystemButtons.Visible := True;
  SystemButtons.Buttons := [bMinimize, bMaximize, bClose];
  pnlClientForm.AlignWithMargins := True;

  if not TConfiguration.Existe('url') then
    TConfiguration.Escrever<String>('url', 'http://18.230.153.64:3000');
end;

procedure TMain.FormShow(Sender: TObject);
begin
  FWorkArea := TWorkArea.Create(Self);
  FWorkArea.ShowIn(pnlClientArea, alClient);
  TLogin.New(pnlClientArea);
  SetConnectionAlert(True);
end;

procedure TMain.pnlTitleBarDblClick(Sender: TObject);
begin
  if WindowState = TWindowState.wsMaximized then
    WindowState := TWindowState.wsNormal
  else
    WindowState := TWindowState.wsMaximized;
end;

procedure TMain.Resizing(State: TWindowState);
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

function TMain.SetConnectionAlert(bConectado: Boolean): TMain;
begin
  Result := Self;
  lblAlertaConexao.Caption := IfThen(bConectado, 'Conectado!', 'Falha na conexão!');
  pnlAlertaConexao.Visible := True;
  tmrAlertaConexao.Enabled := bConectado;
  Application.ProcessMessages;
end;

procedure TMain.tmrAlertaConexaoTimer(Sender: TObject);
begin
  tmrAlertaConexao.Enabled := False;
  pnlAlertaConexao.Visible := False;
end;

end.
