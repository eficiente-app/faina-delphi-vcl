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
  workspace.view;

type
  TMain = class(TBaseFormView)
    tmrConnectionAlert: TTimer;
    procedure FormShow(Sender: TObject);
    procedure pnlTitleBarDblClick(Sender: TObject);
    procedure tmrConnectionAlertTimer(Sender: TObject);
  private
    { Private declarations }
    FWorkArea: TWorkSpace;
  protected
    procedure Resizing(State: TWindowState); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; override;
    property WorkArea: TWorkSpace read FWorkArea;
    function SetConnectionAlert(bConnected: Boolean): TMain;
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
  Resizer := True;
  ControleForm  := True;
  SystemButtons.Visible := True;
  SystemButtons.Buttons := [bMinimize, bMaximize, bClose];
  pnlClientForm.AlignWithMargins := True;

  if not TConfiguration.Exists('url') then
    TConfiguration.Write<String>('url', 'http://18.230.153.64:3000');
end;

procedure TMain.FormShow(Sender: TObject);
begin
  FWorkArea := TWorkSpace.Create(Self);
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

function TMain.SetConnectionAlert(bConnected: Boolean): TMain;
begin
  Result := Self;
  pnlTitleBar.Font.Color := clWhite;
  pnlTitleBar.Caption := IfThen(bConnected, 'Conectado!', 'Falha na conexão!');
  tmrConnectionAlert.Enabled := bConnected;
  pnlTitleBar.Color := $00929907;
end;

procedure TMain.tmrConnectionAlertTimer(Sender: TObject);
begin
  tmrConnectionAlert.Enabled := False;
  pnlTitleBar.Color := $00230D0A;
  pnlTitleBar.Caption := EmptyStr;
end;

end.
