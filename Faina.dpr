program Faina;

uses
  Vcl.Forms,
  Faina.Principal in 'src\Faina.Principal.pas' {Principal},
  Faina.Login in 'src\Faina.Login.pas' {Login};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  if TLogin.New then
    Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
