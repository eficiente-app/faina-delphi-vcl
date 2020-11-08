program Faina;

uses
  Vcl.Forms,
  Faina.Principal in 'src\Faina.Principal.pas' {Principal},
  Faina.Login in 'src\Faina.Login.pas' {Login},
  Faina.Dados in 'src\Faina.Dados.pas' {Dados: TDataModule},
  Faina.Configuracoes in 'src\Faina.Configuracoes.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDados, Dados);
  if TLogin.New then
    Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
